const express = require('express');
const path = require('path');
const { Pool } = require('pg');
const app = express();

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'gameAwards',
  password: 'bazepodataka',
  port: 5432
});

app.use(express.static(path.join(__dirname, '.')));

app.get('/datatable', async (req, res) => {
  try {
    res.sendFile(path.join(__dirname, 'datatable.html'));
  } catch (err) {
    console.error(err);
    res.status(500).send('Greška u GET /, Greška sa datatable.html');
  }
});

app.get('/everything_JSON', async (req, res) => {
  try {
    const { search, atribut } = req.query;

    console.log(`Search "${search}" in column "${atribut}"`);

    // temelj pretrazivanja baze
    let sql = `
      SELECT d.GODINA 
          , d.NAZIV as događaj 
          , d.LOKACIJA as lokacija_događaja 
          , d.VODITELJ 
          , k.NAZIV as kategorija 
          , k.OPIS 
          , i.NAZIV_IGRE 
          , i.DEVELOPER 
          , i.IZDAVAC as izdavač 
          , i.ZEMLJA_PODRIJETLA 
          , COALESCE(array_agg(DISTINCT p.NAZIV), ARRAY[]::varchar[]) as platforme
          , COALESCE(array_agg(DISTINCT z.NAZIV), ARRAY[]::varchar[]) as zanrovi
          , i.PROSJECNA_OCJENA_METACRITIC as prosjecna_ocjena_metacritic 
          , n.POBJEDNIK 
          , i.NAPOMENA
      FROM dogadaj d
      JOIN kategorije k      ON k.dogadajid      = d.id
      JOIN nominacije n      ON n.kategorija_id  = k.id
      JOIN igre i            ON i.id             = n.igra_id
      LEFT JOIN platforme_igre pi ON pi.igra_id  = i.id
      LEFT JOIN platforme p   ON p.id            = pi.platformeid
      LEFT JOIN zanr_igre zi  ON zi.igra_id      = i.id
      LEFT JOIN zanr z        ON z.id            = zi.zanr_id
      WHERE 1 = 1
    `;

    const params = [];

    // ako postoji search
    if (search && search.trim() !== "") {
      const s = `%${search.trim()}%`;

      // odaberi stupac prema atributu iz forme
      let column = null;
      switch (atribut) {
        case "godina":              column = "CAST(d.godina AS TEXT)"; break;
        case "dogadaj":             column = "d.naziv"; break;
        case "lokacija":            column = "d.lokacija"; break;
        case "voditelj":            column = "d.voditelj"; break;
        case "kategorija":          column = "k.naziv"; break;
        case "opis":                column = "k.opis"; break;
        case "naziv_igre":          column = "i.naziv_igre"; break;
        case "developer":           column = "i.developer"; break;
        case "izdavac":             column = "i.izdavac"; break;
        case "zemlja_podrijetla":   column = "i.zemlja_podrijetla"; break;
        case "platforma":           column = "p.naziv"; break;
        case "zarn":                column = "z.naziv"; break; // tvoj value iz <option>
        case "prosjecna_ocjena":    column = "CAST(i.prosjecna_ocjena_metacritic AS TEXT)"; break;
        case "pobjednik":           column = "CAST(n.pobjednik AS TEXT)"; break;
        case "napomena":            column = "i.napomena"; break;
        case "sva_polja":
        default:
          column = null;
      }

      if (column) {
        params.push(s);
        sql += ` AND ${column} ILIKE $${params.length} `;
      } else {
        // "sva_polja" -> traži po više stupaca
        params.push(s);
        sql += `
          AND (
               CAST(d.godina AS TEXT)           ILIKE $1
            OR d.naziv                           ILIKE $1
            OR d.lokacija                        ILIKE $1
            OR d.voditelj                        ILIKE $1
            OR k.naziv                           ILIKE $1
            OR k.opis                            ILIKE $1
            OR i.naziv_igre                      ILIKE $1
            OR i.developer                       ILIKE $1
            OR i.izdavac                         ILIKE $1
            OR i.zemlja_podrijetla               ILIKE $1
            OR p.naziv                           ILIKE $1
            OR z.naziv                           ILIKE $1
            OR CAST(i.prosjecna_ocjena_metacritic AS TEXT) ILIKE $1
            OR CAST(n.pobjednik AS TEXT)         ILIKE $1
            OR i.napomena                        ILIKE $1
          )
        `;
      }
    }

    sql += `
      GROUP BY 
        d.GODINA,
        d.NAZIV,
        d.LOKACIJA,
        d.VODITELJ,
        k.NAZIV,
        k.OPIS,
        i.NAZIV_IGRE,
        i.DEVELOPER,
        i.IZDAVAC,
        i.ZEMLJA_PODRIJETLA,
        i.PROSJECNA_OCJENA_METACRITIC,
        n.POBJEDNIK,
        i.NAPOMENA
      ORDER BY 
        d.GODINA,
        k.NAZIV,
        i.NAZIV_IGRE;
    `;

    const result = await pool.query(sql, params);
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Greška u bazi podataka');
  }
});

app.listen(3000, () => {
  console.log('Server pokrenut na http://localhost:3000');
});
