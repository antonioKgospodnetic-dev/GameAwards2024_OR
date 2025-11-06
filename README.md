# GameAwards2024_OR

Otvorena baza podataka na temu događaja **The Game Awards 2024**.

## Metapodaci skupa podataka

1. **Naziv skupa podataka:** Game Awards 2024  
2. **Autor:** Antonio Gospodnetić 
3. **Verzija skupa podataka:** 1.0 
4. **Licenca:** [MIT License](./LICENSE)
5. **Jezik podataka:** Hrvatski  
6. **Format podataka:** JSON i CSV  
7. **Opis skupa podataka:**  
   Skup podataka prikazuje nominirane igre, njihove kategorije, žanrove, platforme i osnovne informacije povezane s događajem *The Game Awards 2024*.  
8. **Izvor podataka:**  
   - Službena web stranica [The Game Awards](https://thegameawards.com/nominees) i dodatni podaci iz baze Metacritic.
   - Dokumentacija događaja na [Wikipediji](https://en.wikipedia.org/wiki/The_Game_Awards_2024)
9. **Struktura podataka:**  
   - `Godina` - godina održavanja događaja
   - `Događaj` - naziv događaja u kojem su se nominirale igre
   - `Lokacija_događaja` - lokacija odrzavanja događaja
   - `Voditelj` - ime i prezime voditelja događaja
   
   - `Kategorija` – naziv kategorije u kojoj je igra nominirana
   - `Opis` – opis kategorije

   - `Naziv_igre` – naziv igre  
   - `Developer` – studio koji je razvio igru  
   - `Izdavač` – izdavač igre  
   - `Zemlja_podrijetla` – zemlja podrijetla developera
   - `Platforme` – popis platformi na kojima je igra dostupna  
   - `Zanrovi` – popis žanrova kojima igra pripada  
   - `Prosjecna_ocjena_metacritic` – prosječna ocjena igre  
   - `Pobjednik` – označava je li igra osvojila nagradu (true/false) u toj kategoriji 
11. **Datum izrade:** listopad 2025.

## Sadržaj repozitorija

- `GameAwards2024.json` – skup podataka u JSON formatu  
- `GameAwards2024.csv` – skup podataka u CSV formatu  
- `dump_GameAwards2024.sql` – dump baze podataka s tablicama i podacima  
- `README.md` – opis skupa podataka i metapodaci  
- `LICENSE` – otvorena licenca

## Kontekst i namjena

Skup podataka može se koristiti za:
- analizu i usporedbu nominacija i pobjednika po žanrovima i platformama,  
- vizualizaciju popularnosti žanrova tijekom 2024. godine,  
- vježbu rada s relacijskim bazama podataka, JSON i CSV formatima.

## Korištena tehnologija

- PostgreSQL  
- DBeaver  
- SQL i JSON za modeliranje i export podataka  
- GitHub za verzioniranje i objavu otvorenih podataka
