async function loadTopBar() {
  const res = await fetch("/me");
  const data = await res.json();

  const topbar = document.getElementById("topbar");

  if (!data.authenticated) {
    topbar.innerHTML = `
      <a id="login-link" href="/login">Prijavite se</a>
    `;
  } else {
    topbar.innerHTML = `
      <a id="profile-link" href="/profile">Korisnički profil</a>
      <a id="refresh-snapshots-link" href="/osvjeziPreslike">Osvježi preslike</a>
      <a id="logout-link" href="/logout">Odjava</a>
    `;
  }
}

loadTopBar();
