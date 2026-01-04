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

// Express prepoznaj content-type od HTTP-zahtjeva
app.use(express.json());
// Default ucitaj index.html 
app.use(express.static(path.join(__dirname, '.')));


app.get('/datatable', async (req, res) => {
  try {
    res.sendFile(path.join(__dirname, 'datatable.html'));
  } catch (err) {
    console.error(err);
    res.status(500).send('Greška u GET /, Greška sa datatable.html');
  }
});

// #################### APIs ####################

// ########## CRUD /api/v1/igre ##########
// GET /api/v1/igre 
app.get('/api/v1/igre', async (req, res) => {
  try {
    // 1. compile request
    // const { search, atribut } = req.query;
    // console.log(`Search "${search}" in column "${atribut}"`);

    let sql = `
      SELECT i.id
          , i.naziv_igre 
          , i.developer 
          , i.izdavac as izdavač
          , i.zemlja_podrijetla 
          , COALESCE(array_agg(DISTINCT p.NAZIV), ARRAY[]::varchar[]) as platforme
          , COALESCE(array_agg(DISTINCT z.NAZIV), ARRAY[]::varchar[]) as zanrovi
          , i.prosjecna_ocjena_metacritic
          , i.napomena
      FROM igre i            
      LEFT JOIN platforme_igre pi ON pi.igra_id  = i.id
      LEFT JOIN platforme p   ON p.id            = pi.platformeid
      LEFT JOIN zanr_igre zi  ON zi.igra_id      = i.id
      LEFT JOIN zanr z        ON z.id            = zi.zanr_id
      GROUP BY
       i.id,
       i.naziv_igre,
       i.developer,
       i.izdavac,
       i.zemlja_podrijetla,
       i.prosjecna_ocjena_metacritic,
       i.napomena
      ORDER BY naziv_igre
    `;
    const params = [];

    // 2. query
    const result = await pool.query(sql, params);
  
    // 3. response
    res.status(200).json({
      status: "OK",
      message: "Fetched games",
      response: result.rows
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({
      status: "Error",
      message: "Database error",
      response: null
    });
  }
});

// GET /api/v1/igre/{id}
app.get('/api/v1/igre/:id', async (req, res) => {
  try {
    // 1. compile request
    const id = parseInt(req.params.id, 10);
    const params = [];

    let sql = `
      SELECT i.id
          , i.naziv_igre 
          , i.developer 
          , i.izdavac as izdavač
          , i.zemlja_podrijetla 
          , COALESCE(array_agg(DISTINCT p.NAZIV), ARRAY[]::varchar[]) as platforme
          , COALESCE(array_agg(DISTINCT z.NAZIV), ARRAY[]::varchar[]) as zanrovi
          , i.prosjecna_ocjena_metacritic
          , i.napomena
      FROM igre i            
      LEFT JOIN platforme_igre pi ON pi.igra_id  = i.id
      LEFT JOIN platforme p   ON p.id            = pi.platformeid
      LEFT JOIN zanr_igre zi  ON zi.igra_id      = i.id
      LEFT JOIN zanr z        ON z.id            = zi.zanr_id
      WHERE 1 = 1
    `;

    if (isNaN(id)) {
      return res.status(400).json({
        status: "Bad Request",
        message: "ID must be a number",
        response: null
      }); 
    }

    params.push(id);
    sql += `
      AND i.id = $1
      GROUP BY
       i.id,
       i.naziv_igre,
       i.developer,
       i.izdavac,
       i.zemlja_podrijetla,
       i.prosjecna_ocjena_metacritic,
       i.napomena
      ORDER BY naziv_igre
    `;

    // 2. query
    const result = await pool.query(sql, params);
  
    // 3. response
    if (result.rows.length === 0) {
      return res.status(404).json({
        status: "Not Found",
        message: "Game with the provided ID doesn't exist",
        response: null
      });
    }

    return res.status(200).json({
      status: "OK",
      message: "Fetched game",
      response: result.rows[0]
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({
      status: "Error",
      message: "Database error",
      response: null
    });
  }
});

// POST /api/v1/igre 
app.post('/api/v1/igre', async (req, res) => {
  try {
    // 1. compile request
    /*
      The request (req.body is .json) looks like:
        {
          "naziv_igre": "A Moja Nova Igra",
          "developer": "Developer Co",
          "izdavac": "Izdavac Co",
          "zemlja_podrijetla": "Hrvatska",
          "prosjecna_ocjena_metacritic": 90,
          "napomena": "Test JSON"
        }
    */
    const params = [
      req.body.naziv_igre,
      req.body.developer,
      req.body.izdavac,
      req.body.zemlja_podrijetla,
      req.body.prosjecna_ocjena_metacritic,
      req.body.napomena
    ];

    // 2. queries
    let sql = `
      INSERT INTO igre
        (naziv_igre, developer, izdavac, zemlja_podrijetla, prosjecna_ocjena_metacritic, napomena)
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING id, naziv_igre, developer, izdavac, zemlja_podrijetla, prosjecna_ocjena_metacritic, napomena;
    `;
    const result = await pool.query(sql, params);

    // 3. response
    res.status(201)
    .set('Location', `/api/v1/igre/${result.rows[0].id}`)
    .json({
      status: "OK",
      message: "Game created",
      response: result.rows[0]
    });

  } catch (err) {
    console.error(err);

    // UNIQUE constraint violation (naziv_igre) err.code = 23505
    if (err.code === '23505') {
      return res.status(409).json({
        status: "Conflict",
        message: "Game with the same naziv_igre already exists",
        response: null
      });
    }

    // NOT NULL constraint violation err.code = 23505
    if (err.code === '23502') {
      return res.status(400).json({
        status: "Bad request",
        message: `Missing required field: ${err.column ?? "unknown"}`,
        response: null
      });
    }

    return res.status(500).json({
      status: "Error",
      message: "Database error",
      response: null
    });
  }
});

// DELETE /api/v1/igre/{id}
app.delete('/api/v1/igre/:id', async (req, res) => {
  try {
    // 1. compile request
    const id = parseInt(req.params.id, 10);
    const params = [];

    if (isNaN(id)) {
      return res.status(400).json({
        status: "Bad Request",
        message: "ID must be a number",
        response: null
      }); 
    }

    params.push(id);

    // 2. query
    let sql = `
      DELETE FROM igre
      WHERE id = $1
    `;
    const result = await pool.query(sql, params);

    // 3. response
    if (result.rowCount === 0) {
      return res.status(404).json({
        status: "Not Found",
        message: `Game with id ${id} not found`,
        response: null
      });
    }

    return res.status(200).json({
      status: "OK",
      message: "Game deleted",
      response: null
    });

  } catch (err) {
    console.error(err);
    return res.status(500).json({
      status: "Error",
      message: "Database error",
      response: null
    });
  }
});

// PUT /api/v1/igre/{id}
app.put('/api/v1/igre/:id', async (req, res) => {
  try {
    // 1. compile request
    const id = parseInt(req.params.id, 10);
    const params = [];

    if (isNaN(id)) {
      return res.status(400).json({
        status: "Bad Request",
        message: "ID must be a number",
        response: null
      }); 
    } 

    params.push(id, 
      req.body.naziv_igre,
      req.body.developer,
      req.body.izdavac,
      req.body.zemlja_podrijetla,
      req.body.prosjecna_ocjena_metacritic,
      req.body.napomena);
  

    // 2. query
    let sql = `
      UPDATE igre
      SET (naziv_igre, developer, izdavac, zemlja_podrijetla, prosjecna_ocjena_metacritic, napomena) = ($2, $3, $4, $5, $6, $7)
      WHERE id = $1
      RETURNING id, naziv_igre, developer, izdavac, zemlja_podrijetla, prosjecna_ocjena_metacritic, napomena;
    `;
    const result = await pool.query(sql, params);

    // 3. response
    if (result.rowCount === 0) {
      return res.status(404).json({
        status: "Not Found",
        message: `Game with id ${id} not found`,
        response: null
      });
    }

    return res.status(200)
      .json({
        status: "OK",
        message: "Game updated",
        response: result.rows[0]
      });

  } catch (err) {
    console.error(err);
    
    // UNIQUE constraint violation (naziv_igre) err.code = 23505
    if (err.code === '23505') {
      return res.status(409).json({
        status: "Conflict",
        message: "Game with the same naziv_igre already exists",
        response: null
      });
    }

    return res.status(500).json({
      status: "Error",
      message: "Database error",
      response: null
    });
  }
});

// PATCH /api/v1/igre - not implemented
app.patch('/api/v1/igre', async (req, res) => {
    return res.status(501).json({
      status: "Not implemented",
      message: "Method not implemented for requested resource",
      response: null
    });
});

// ########## CRUD /api/v1/igre/{id}/zanrovi ##########
// GET /api/v1/igre/{id}/zanrovi
app.get('/api/v1/igre/:id/zanrovi', async (req, res) => {
  try {
    // 1. compile request
    const id = parseInt(req.params.id, 10);
    const params = [];

    if (isNaN(id)) {
      return res.status(400).json({
        status: "Bad Request",
        message: "ID must be a number",
        response: null
      }); 
    }
    params.push(id);

    // checking if game with :id exists
    const exists = await pool.query(` SELECT 1 FROM igre WHERE id = $1 `, params );

    if (exists.rowCount === 0) {
      return res.status(404).json({
        status: "Not Found",
        message: "Game with the provided ID doesn't exist",
        response: null
      });
    }

    // 2. query
    let sql = `
     SELECT
        COALESCE(
          array_agg(DISTINCT z.naziv ORDER BY z.naziv),
          ARRAY[]::varchar[]
        ) AS zanrovi
      FROM zanr_igre zi
      JOIN zanr z ON z.id = zi.zanr_id
      WHERE zi.igra_id = $1;
    `;
    const result = await pool.query(sql, params);
  
    // 3. response
    return res.status(200).json({
      status: "OK",
      message: "Fetched game zanrs",
      response: result.rows
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({
      status: "Error",
      message: "Database error",
      response: null
    });
  }
});

// POST /api/v1/igre/{id}/zanrovi - not implemented
app.post('/api/v1/igre/:id/zanrovi', async (req, res) => {
    return res.status(501).json({
      status: "Not implemented",
      message: "Method not implemented for requested resource",
      response: null
    });
});
// DELETE /api/v1/igre/{id}/zanrovi/{id} - not implemented
app.delete('/api/v1/igre/:id/zanrovi/:id', async (req, res) => {
    return res.status(501).json({
      status: "Not implemented",
      message: "Method not implemented for requested resource",
      response: null
    });
});
// PUT /api/v1/igre/{id}/zanrovi/{id} - not implemented
app.put('/api/v1/igre/:id/zanrovi/:id', async (req, res) => {
    return res.status(501).json({
      status: "Not implemented",
      message: "Method not implemented for requested resource",
      response: null
    });
});

// ########## CRUD /api/v1/igre/{id}/platforme ##########
// GET /api/v1/igre/{id}/platforme
app.get('/api/v1/igre/:id/platforme', async (req, res) => {
  try {
    // 1. compile request
    const id = parseInt(req.params.id, 10);
    const params = [];

    if (isNaN(id)) {
      return res.status(400).json({
        status: "Bad Request",
        message: "ID must be a number",
        response: null
      }); 
    }
    params.push(id);

    // checking if game with :id exists
    const exists = await pool.query(` SELECT 1 FROM igre WHERE id = $1 `, params );

    if (exists.rowCount === 0) {
      return res.status(404).json({
        status: "Not Found",
        message: "Game with the provided ID doesn't exist",
        response: null
      });
    }

    // 2. query
    let sql = `
     SELECT
        COALESCE(
          array_agg(DISTINCT p.naziv ORDER BY p.naziv),
          ARRAY[]::varchar[]
        ) AS platforme
      FROM platforme_igre pi
      JOIN platforme p ON p.id = pi.platformeid
      WHERE pi.igra_id = $1;
    `;
    const result = await pool.query(sql, params);
  
    // 3. response
    return res.status(200).json({
      status: "OK",
      message: "Fetched game zanrs",
      response: result.rows
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({
      status: "Error",
      message: "Database error",
      response: null
    });
  }
});

// POST /api/v1/igre/{id}/platforme - not implemented
app.post('/api/v1/igre/:id/platforme', async (req, res) => {
    return res.status(501).json({
      status: "Not implemented",
      message: "Method not implemented for requested resource",
      response: null
    });
});
// DELETE /api/v1/igre/{id}/platforme/{id} - not implemented
app.delete('/api/v1/igre/:id/platforme/:id', async (req, res) => {
    return res.status(501).json({
      status: "Not implemented",
      message: "Method not implemented for requested resource",
      response: null
    });
});
// PUT /api/v1/igre/{id}/platforme/{id} - not implemented
app.put('/api/v1/igre/:id/platforme/:id', async (req, res) => {
    return res.status(501).json({
      status: "Not implemented",
      message: "Method not implemented for requested resource",
      response: null
    });
});

// ########## CRUD /api/v1/kategorije ##########
// GET /api/v1/kategorije
app.get('/api/v1/kategorije', async (req, res) => {
  try {
    // 2. queries
    let sql = `
      SELECT k.id
          , k.naziv 
          , k.opis 
      FROM kategorije k            
      ORDER BY k.naziv
    `;
    const result = await pool.query(sql);
  
    // 3. response
    res.status(200).json({
      status: "OK",
      message: "Fetched categories",
      response: result.rows
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({
      status: "Error",
      message: "Database error",
      response: null
    });
  }
});

// POST /api/v1/kategorije - not implemented
app.post('/api/v1/kategorije', async (req, res) => {
    return res.status(501).json({
      status: "Not implemented",
      message: "Method not implemented for requested resource",
      response: null
    });
});
// DELETE /api/v1/kategorije/{id} - not implemented
app.delete('/api/v1/kategorije/:id', async (req, res) => {
    return res.status(501).json({
      status: "Not implemented",
      message: "Method not implemented for requested resource",
      response: null
    });
});
// PUT /api/v1/kategorije/{id} - not implemented
app.put('/api/v1/kategorije/:id', async (req, res) => {
    return res.status(501).json({
      status: "Not implemented",
      message: "Method not implemented for requested resource",
      response: null
    });
});

// GET /api/v1/kategorije/{id}
app.get('/api/v1/kategorije/:id', async (req, res) => {
  try {
    // 1. compile request
    const id = parseInt(req.params.id, 10);
    const params = [];
    
    if (isNaN(id)) {
      return res.status(400).json({
        status: "Bad Request",
        message: "ID must be a number",
        response: null
      }); 
    }
    params.push(id);

    // 2. query
    let sql = `
      SELECT k.id
          , k.naziv 
          , k.opis 
      FROM kategorije k   
      WHERE k.id = $1         
      ORDER BY k.naziv
    `;
    const result = await pool.query(sql, params);
  
    // 3. response
    if (result.rows.length === 0) {
      return res.status(404).json({
        status: "Not Found",
        message: "Category with the provided ID doesn't exist",
        response: null
      });
    }

    return res.status(200).json({
      status: "OK",
      message: "Fetched category",
      response: result.rows[0]
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({
      status: "Error",
      message: "Database error",
      response: null
    });
  }
});

// GET /api/v1/kategorije/{id}/nominacije
app.get('/api/v1/kategorije/:id/nominacije', async (req, res) => {
  try {
    // 1. compile request
    const id = parseInt(req.params.id, 10);
    const params = [];

    if (isNaN(id)) {
      return res.status(400).json({
        status: "Bad Request",
        message: "ID must be a number",
        response: null
      }); 
    }
    params.push(id);

    // checking if category with :id exists
    const exists = await pool.query(` SELECT 1 FROM kategorije WHERE id = $1 `, params );

    if (exists.rowCount === 0) {
      return res.status(404).json({
        status: "Not Found",
        message: "Category with the provided ID doesn't exist",
        response: null
      });
    }
    // 2. query
    let sql = `
      SELECT n.id as nominacija_id
          , k.naziv as naziv_kategorije
          , i.id as igra_id
          , i.naziv_igre
          , n.pobjednik
      FROM nominacije n
      JOIN kategorije k ON k.id = n.kategorija_id
      JOIN igre i ON i.id = n.igra_id
      WHERE k.id = $1         
      ORDER BY k.naziv, i.naziv_igre
    `;
    const result = await pool.query(sql, params);
  
    // 3. response
    res.status(200).json({
      status: "OK",
      message: "Fetched nominations",
      response: result.rows
    });


  } catch (err) {
    console.error(err);
    res.status(500).json({
      status: "Error",
      message: "Database error",
      response: null
    });
  }
});

// GET /api/v1/openapi
app.get("/api/v1/openapi", (req, res) => {
  res.type("application/json");
  res.sendFile(path.join(__dirname, "../openapi.json"));
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
