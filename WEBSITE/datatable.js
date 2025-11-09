const tableBody = document.querySelector("#MyTable tbody");
const form = document.querySelector("form");              // prva (i jedina) forma na stranici
const searchInput = form.elements["search"];
const atributSelect = form.elements["atribut"];

const downloadJsonBtn = document.getElementById('downloadJsonBtn');
const downloadCsvBtn = document.getElementById('downloadCsvBtn');
let lastResults = [];

async function loadTable() {
  // 1. pripremi URL s query parametrima
  const params = new URLSearchParams();
  const search = searchInput.value.trim();
  const atribut = atributSelect.value;

  if (search !== "") {
    params.append("search", search);
  }
  if (atribut) {
    params.append("atribut", atribut);
  }

  const url = "/everything_JSON" + (params.toString() ? "?" + params.toString() : "");

  // 2. fetch podataka
  const response = await fetch(url);
  if (!response.ok) {
    console.error("Greška pri dohvaćanju podataka");
    return;
  }
  const jsonContents = await response.json();
  lastResults = jsonContents;   // zapamti zadnje rezultate za kasniji download

  // 3. očisti tablicu
  tableBody.innerHTML = "";

  // 4. ispuni tablicu
  jsonContents.forEach(element => {
    const row = document.createElement('tr');

    row.innerHTML = `
      <td>${element.godina}</td>
      <td>${element["događaj"]}</td>
      <td>${element["lokacija_događaja"]}</td>
      <td>${element.voditelj}</td>
      <td>${element.kategorija}</td>
      <td class="long-text">${element.opis}</td>
      <td>${element.naziv_igre}</td>
      <td>${element.developer}</td>
      <td>${element["izdavač"]}</td>
      <td>${element.zemlja_podrijetla}</td>
      <td>${Array.isArray(element.platforme) ? element.platforme.join(', ') : (element.platforme)}</td>
      <td>${Array.isArray(element.zanrovi) ? element.zanrovi.join(', ') : (element.zanrovi)}</td>
      <td>${element.prosjecna_ocjena_metacritic}</td>
      <td>${element.pobjednik}</td>
      <td class="long-text">${element.napomena}</td>
    `;

    tableBody.appendChild(row);
  });
}

// kad se forma submit-a, spriječi reload i samo ponovno učitaj tablicu
form.addEventListener("submit", (e) => {
  e.preventDefault();   // nema reloada stranice
  loadTable();
});

downloadJsonBtn.addEventListener('click', () => {
  if (!lastResults || lastResults.length === 0) {
    alert('Nema rezultata za preuzimanje.');
    return;
  }

  const blob = new Blob(
    [JSON.stringify(lastResults, null, 2)],
    { type: 'application/json' }
  );

  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = 'gameawards_rezultati.json';  // ime fajla po želji
  document.body.appendChild(a);
  a.click();
  a.remove();
  URL.revokeObjectURL(url);
});

downloadCsvBtn.addEventListener('click', () => {
  if (!lastResults || lastResults.length === 0) {
    alert('Nema rezultata za preuzimanje.');
    return;
  }

  // Extract keys (column names)
  const headers = Object.keys(lastResults[0]);

  // Convert array of objects -> CSV string
  const csvRows = [];

  // Header row
  csvRows.push(headers.join(','));

  // Data rows
  for (const obj of lastResults) {
    const row = headers.map(h => {
      let val = obj[h];

      // Convert arrays to comma-separated strings
      if (Array.isArray(val)) {
        val = val.join(', ');
      }

      // Escape quotes and semicolons
      if (typeof val === 'string') {
        val = val.replace(/"/g, '""'); // escape double quotes
        if (val.includes(',') || val.includes('"')) {
          val = `"${val}"`; // wrap in quotes if needed
        }
      }

      return val ?? ''; // empty string if null/undefined
    });
    csvRows.push(row.join(','));
  }

  // Join all rows into single text
  const csvData = csvRows.join('\n');

  // Create and download file
  const blob = new Blob([csvData], { type: 'text/csv;charset=utf-8;' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = 'gameawards_rezultati.csv';
  document.body.appendChild(a);
  a.click();
  a.remove();
  URL.revokeObjectURL(url);
});

// inicijalno punjenje tablice bez filtera
loadTable();
