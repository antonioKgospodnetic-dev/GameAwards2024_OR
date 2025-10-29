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
   - `naziv_igre` – naziv igre  
   - `developer` – studio koji je razvio igru  
   - `izdavac` – izdavač igre  
   - `zemlja_podrijetla` – zemlja podrijetla developera  
   - `prosjecna_ocjena_metacritic` – prosječna ocjena igre  
   - `pobjednik` – označava je li igra osvojila nagradu (true/false)  
   - `zanrovi` – popis žanrova kojima igra pripada  
   - `platforme` – popis platformi na kojima je igra dostupna  
   - `opis_kategorije` – opis kategorije u kojoj je igra nominirana  
10. **Datum izrade:** listopad 2025.

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
