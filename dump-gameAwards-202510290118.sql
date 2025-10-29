--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-10-29 01:18:21

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4970 (class 1262 OID 18677)
-- Name: gameAwards; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE "gameAwards" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'hr-HR';


\connect "gameAwards"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 18980)
-- Name: dogadaj; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dogadaj (
    id integer NOT NULL,
    naziv character varying(64) NOT NULL,
    lokacija character varying(128) NOT NULL,
    godina integer NOT NULL,
    voditelj character varying(64) NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 18979)
-- Name: dogadaj_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.dogadaj ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.dogadaj_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 19077)
-- Name: igre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.igre (
    id integer NOT NULL,
    naziv_igre character varying(128) NOT NULL,
    developer character varying(64) NOT NULL,
    izdavac character varying(64) NOT NULL,
    zemlja_podrijetla character varying(32),
    prosjecna_ocjena_metacritic smallint NOT NULL,
    napomena character varying(256)
);


--
-- TOC entry 223 (class 1259 OID 19076)
-- Name: igre_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.igre ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.igre_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 18986)
-- Name: kategorije; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.kategorije (
    id integer NOT NULL,
    naziv character varying(64),
    opis character varying(128),
    dogadajid integer NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 18985)
-- Name: kategorije_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.kategorije ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.kategorije_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 19087)
-- Name: nominacije; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.nominacije (
    id integer NOT NULL,
    igra_id integer,
    kategorija_id integer,
    pobjednik boolean NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 19086)
-- Name: nominacije_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.nominacije ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.nominacije_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 19166)
-- Name: platforme; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.platforme (
    id integer NOT NULL,
    naziv character varying(64) NOT NULL
);


--
-- TOC entry 228 (class 1259 OID 19165)
-- Name: platforme_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.platforme ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.platforme_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 19173)
-- Name: platforme_igre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.platforme_igre (
    igra_id integer NOT NULL,
    platformeid integer NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 19014)
-- Name: zanr; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.zanr (
    id integer NOT NULL,
    naziv character varying(64) NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 19013)
-- Name: zanr_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.zanr ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.zanr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 19135)
-- Name: zanr_igre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.zanr_igre (
    igra_id integer NOT NULL,
    zanr_id integer NOT NULL
);


--
-- TOC entry 4952 (class 0 OID 18980)
-- Dependencies: 218
-- Data for Name: dogadaj; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.dogadaj OVERRIDING SYSTEM VALUE VALUES (1, 'The Game Awards 2024', 'Peacock Theater, Los Angeles, USA', 2024, 'Geoff Keighley');


--
-- TOC entry 4958 (class 0 OID 19077)
-- Dependencies: 224
-- Data for Name: igre; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (35, 'League of Legends', 'Riot Games', 'Riot Games', 'USA', 78, 'Jedan od najpopularnijih MOBA naslova, poznat po stalnim nadogradnjama i esport sceni.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (36, 'Fortnite', 'Epic Games', 'Epic Games', 'USA', 85, 'Stalno razvijajući battle royale s inovativnim suradnjama i kreativnim modovima.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (37, 'Call of Duty: Black Ops 6', 'Treyarch', 'Activision', 'USA', 83, 'Nastavak popularnog FPS serijala s fokusom na dinamičnu kampanju i višestruki multiplayer mod.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (38, 'Dragon Age: The Veilguard', 'BioWare', 'Electronic Arts', 'Canada', 0, 'Nadolazeći nastavak poznatog RPG serijala s fokusom na priču i likove.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (39, 'Counter-Strike 2', 'Valve', 'Valve', 'USA', 80, 'Nasljednik legendarne CS:GO igre, s moderniziranim motorom i natjecateljskim značajkama.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (40, 'Mobile Legends: Bang Bang', 'Moonton', 'Moonton', 'China', 75, 'Najpopularniji mobilni MOBA naslov s velikom azijskom bazom igrača.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (41, 'Black Myth: Wukong', 'Game Science', 'Game Science', 'China', 90, 'Akcijski RPG inspiriran kineskom mitologijom s impresivnim tehničkim postignućima.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (42, 'Dota 2', 'Valve', 'Valve', 'USA', 90, 'Kultna MOBA igra s najvećim esport nagradnim fondom i aktivnom zajednicom.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (43, 'Prince of Persia: The Lost Crown', 'Ubisoft Montpellier', 'Ubisoft', 'France', 88, 'Povratak klasičnog serijala u obliku 2.5D akcijske avanture s izvrsnim level dizajnom.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (44, 'Silent Hill 2', 'Bloober Team', 'Konami', 'Poland', 81, 'Remake klasika horor žanra s moderniziranom grafikom i atmosferom vjernom originalu.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (45, 'Elden Ring: Shadow of the Erdtree', 'FromSoftware', 'Bandai Namco Entertainment', 'Japan', 94, 'Velika ekspanzija nagrađivane igre, poznata po dubokom dizajnu svijeta i izazovnim borbama.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (46, 'UFO 50', 'Mossmouth', 'Mossmouth', 'USA', 85, 'Kolekcija od 50 retro-stiliziranih igara koja istražuje različite žanrove i mehanike.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (47, 'Star Wars Outlaws', 'Massive Entertainment', 'Ubisoft', 'Sweden', 0, 'Open-world avantura smještena između Epizoda V i VI s fokusom na kriminalni svijet galaksije.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (48, 'Like a Dragon: Infinite Wealth', 'Ryu Ga Gotoku Studio', 'Sega', 'Japan', 89, 'Hvaljena zbog bogate priče, razvijenih likova i uspješne kombinacije drame, komedije i taktičkih borbi.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (49, 'Final Fantasy VII Rebirth', 'Square Enix', 'Square Enix', 'Japan', 92, 'Nastavlja reinterpretaciju originalnog FF7 s modernim borbenim sustavom i vizualima.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (50, 'Metaphor: ReFantazio', 'Atlus', 'Sega', 'Japan', 88, 'Pohvaljena zbog dubine svijeta, političke alegorije i složenog RPG sustava.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (51, 'Lorelei and the Laser Eyes', 'Simogo', 'Annapurna Interactive', 'Sweden', 88, 'Apstraktna narativna zagonetka s fokusom na vizualnu simboliku i nelinearnu strukturu.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (52, 'Senua''s Saga: Hellblade II', 'Ninja Theory', 'Xbox Game Studios', 'UK', 82, 'Psihološka, kinematografska prezentacija perspektive Senuae.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (53, 'Animal Well', 'Shared Memory', 'Bigmode', 'USA', 90, 'Atmosferski indie metroidvania s pažljivo dizajniranim zagonetkama i tajnovitim svijetom.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (54, 'Helldivers II', 'Arrowhead Game Studios', 'Sony Interactive Entertainment', 'Sweden', 86, 'Kooperativni shooter s taktičkim izazovima i prijateljskim vatrom koji potiče suradnju igrača.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (55, 'Diablo IV: Vessel of Hatred', 'Blizzard Entertainment', 'Blizzard Entertainment', 'USA', 88, 'Ekspanzija s novim likovima, klasama i mračnim narativom karakterističnim za serijal.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (56, 'Warhammer 40,000: Space Marine 2', 'Saber Interactive', 'Focus Entertainment', 'USA', 84, 'Nastavak klasične akcijske igre s intenzivnim borbama protiv hordâ neprijatelja.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (57, 'Valorant', 'Riot Games', 'Riot Games', 'USA', 85, 'Taktički FPS koji kombinira precizno pucanje i jedinstvene sposobnosti agenata.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (58, 'Stellar Blade', 'Shift Up', 'Sony Interactive Entertainment', 'South Korea', 85, 'Akcijska avantura s fokusom na preciznu borbu i vizualno impresivne animacije.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (59, 'Final Fantasy XIV: Dawntrail', 'Square Enix', 'Square Enix', 'Japan', 89, 'Nova ekspanzija popularnog MMORPG-a koja donosi svjetliju i vedriju priču.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (60, 'Balatro', 'LocalThunk', 'Playstack', 'UK', 89, 'Indie kartaška roguelike igra poznata po dubokoj mehanici i visokoj ovisnosti.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (61, 'Destiny 2: The Final Shape', 'Bungie', 'Bungie', 'USA', 83, 'Veliko završno poglavlje dugogodišnjeg FPS MMO serijala.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (62, 'Neva', 'Nomada Studio', 'Devolver Digital', 'Spain', 87, 'Umjetnički platformer koji istražuje teme gubitka i emocionalne povezanosti.');
INSERT INTO public.igre OVERRIDING SYSTEM VALUE VALUES (63, 'Astro Bot', 'Team Asobi', 'Sony Interactive Entertainment', 'Japan', 91, 'Šarmantna 3D avantura s preciznom kontrolom i kreativnim korištenjem DualSense mogućnosti.');


--
-- TOC entry 4954 (class 0 OID 18986)
-- Dependencies: 220
-- Data for Name: kategorije; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.kategorije OVERRIDING SYSTEM VALUE VALUES (1, 'Best Narrative', 'Nagrada za najbolju priču i kvalitetu pripovijedanja.', 1);
INSERT INTO public.kategorije OVERRIDING SYSTEM VALUE VALUES (2, 'Game of the Year', 'Igra koja je ostvarila najbolje ukupno iskustvo u svim kreativnim i tehničkim aspektima.', 1);
INSERT INTO public.kategorije OVERRIDING SYSTEM VALUE VALUES (5, 'Best Esports Game', 'Najbolja kompetitivna igra s aktivnom esports scenom.', 1);
INSERT INTO public.kategorije OVERRIDING SYSTEM VALUE VALUES (6, 'Best Art Direction', 'Nagrada za izvrsnost u vizualnom dizajnu i umjetničkoj prezentaciji igre.', 1);
INSERT INTO public.kategorije OVERRIDING SYSTEM VALUE VALUES (7, 'Best Score and Music', 'Nagrada za najbolju originalnu glazbu, kompoziciju i produkciju zvuka.', 1);
INSERT INTO public.kategorije OVERRIDING SYSTEM VALUE VALUES (8, 'Best Audio Design', 'Prepoznaje izvrsnost u dizajnu zvuka, glasovnim efektima i miksu.', 1);
INSERT INTO public.kategorije OVERRIDING SYSTEM VALUE VALUES (9, 'Best Ongoing Game', 'Nagrada za igru koja kontinuirano nudi novo iskustvo kroz ažuriranja i podršku zajednice.', 1);
INSERT INTO public.kategorije OVERRIDING SYSTEM VALUE VALUES (10, 'Innovation in Accessibility', 'Nagrada za najbolje implementirane značajke pristupačnosti koje olakšavaju igranje osobama s različitim sposobnostima.', 1);
INSERT INTO public.kategorije OVERRIDING SYSTEM VALUE VALUES (4, 'Best Independent Game', 'Najbolja igra nezavisnog studija.', 1);
INSERT INTO public.kategorije OVERRIDING SYSTEM VALUE VALUES (3, 'Best Action Game', 'Nagrada za najbolju igru koja se temelji prvenstveno na borbenom sustavu i akcijskom igranju.', 1);


--
-- TOC entry 4960 (class 0 OID 19087)
-- Dependencies: 226
-- Data for Name: nominacije; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (1, 48, 1, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (2, 44, 1, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (3, 63, 2, true);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (4, 60, 2, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (5, 41, 2, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (6, 45, 2, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (7, 41, 3, true);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (8, 37, 3, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (9, 54, 3, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (10, 58, 3, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (11, 56, 3, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (12, 60, 4, true);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (13, 53, 4, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (14, 51, 4, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (15, 62, 4, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (16, 46, 4, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (17, 35, 5, true);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (18, 39, 5, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (19, 42, 5, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (20, 40, 5, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (21, 57, 5, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (22, 63, 6, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (23, 41, 6, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (24, 45, 6, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (25, 62, 6, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (26, 63, 7, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (27, 44, 7, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (28, 58, 7, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (29, 63, 8, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (30, 37, 8, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (31, 44, 8, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (32, 54, 9, true);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (33, 61, 9, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (34, 55, 9, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (35, 59, 9, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (36, 52, 1, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (37, 52, 8, true);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (38, 50, 1, true);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (39, 50, 2, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (40, 50, 6, true);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (41, 50, 7, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (42, 36, 9, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (43, 43, 10, true);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (44, 37, 10, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (45, 55, 10, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (46, 38, 10, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (47, 47, 10, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (48, 49, 1, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (49, 49, 2, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (50, 49, 7, true);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (51, 49, 8, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (61, NULL, 2, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (65, NULL, 3, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (67, NULL, 3, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (71, NULL, 4, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (76, NULL, 4, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (85, NULL, 5, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (90, NULL, 5, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (97, NULL, 6, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (117, NULL, 3, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (122, NULL, 3, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (132, NULL, 2, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (168, NULL, 2, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (211, NULL, 8, false);
INSERT INTO public.nominacije OVERRIDING SYSTEM VALUE VALUES (221, NULL, 9, false);


--
-- TOC entry 4963 (class 0 OID 19166)
-- Dependencies: 229
-- Data for Name: platforme; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.platforme OVERRIDING SYSTEM VALUE VALUES (19, 'Android');
INSERT INTO public.platforme OVERRIDING SYSTEM VALUE VALUES (20, 'iOS');
INSERT INTO public.platforme OVERRIDING SYSTEM VALUE VALUES (21, 'macOS');
INSERT INTO public.platforme OVERRIDING SYSTEM VALUE VALUES (22, 'Nintendo Switch');
INSERT INTO public.platforme OVERRIDING SYSTEM VALUE VALUES (23, 'PlayStation 4');
INSERT INTO public.platforme OVERRIDING SYSTEM VALUE VALUES (24, 'PlayStation 5');
INSERT INTO public.platforme OVERRIDING SYSTEM VALUE VALUES (25, 'Windows');
INSERT INTO public.platforme OVERRIDING SYSTEM VALUE VALUES (26, 'Xbox One');
INSERT INTO public.platforme OVERRIDING SYSTEM VALUE VALUES (27, 'Xbox Series X/S');
INSERT INTO public.platforme OVERRIDING SYSTEM VALUE VALUES (28, 'Linux');


--
-- TOC entry 4964 (class 0 OID 19173)
-- Dependencies: 230
-- Data for Name: platforme_igre; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.platforme_igre VALUES (60, 19);
INSERT INTO public.platforme_igre VALUES (60, 20);
INSERT INTO public.platforme_igre VALUES (60, 21);
INSERT INTO public.platforme_igre VALUES (60, 22);
INSERT INTO public.platforme_igre VALUES (60, 23);
INSERT INTO public.platforme_igre VALUES (60, 24);
INSERT INTO public.platforme_igre VALUES (60, 25);
INSERT INTO public.platforme_igre VALUES (60, 26);
INSERT INTO public.platforme_igre VALUES (63, 24);
INSERT INTO public.platforme_igre VALUES (50, 23);
INSERT INTO public.platforme_igre VALUES (50, 24);
INSERT INTO public.platforme_igre VALUES (50, 25);
INSERT INTO public.platforme_igre VALUES (50, 27);
INSERT INTO public.platforme_igre VALUES (49, 24);
INSERT INTO public.platforme_igre VALUES (52, 25);
INSERT INTO public.platforme_igre VALUES (52, 27);
INSERT INTO public.platforme_igre VALUES (48, 23);
INSERT INTO public.platforme_igre VALUES (48, 24);
INSERT INTO public.platforme_igre VALUES (48, 25);
INSERT INTO public.platforme_igre VALUES (48, 26);
INSERT INTO public.platforme_igre VALUES (48, 27);
INSERT INTO public.platforme_igre VALUES (44, 24);
INSERT INTO public.platforme_igre VALUES (44, 25);
INSERT INTO public.platforme_igre VALUES (58, 24);
INSERT INTO public.platforme_igre VALUES (45, 23);
INSERT INTO public.platforme_igre VALUES (45, 24);
INSERT INTO public.platforme_igre VALUES (45, 25);
INSERT INTO public.platforme_igre VALUES (45, 26);
INSERT INTO public.platforme_igre VALUES (45, 27);
INSERT INTO public.platforme_igre VALUES (41, 24);
INSERT INTO public.platforme_igre VALUES (41, 25);
INSERT INTO public.platforme_igre VALUES (41, 27);
INSERT INTO public.platforme_igre VALUES (37, 23);
INSERT INTO public.platforme_igre VALUES (37, 24);
INSERT INTO public.platforme_igre VALUES (37, 25);
INSERT INTO public.platforme_igre VALUES (37, 26);
INSERT INTO public.platforme_igre VALUES (37, 27);
INSERT INTO public.platforme_igre VALUES (54, 24);
INSERT INTO public.platforme_igre VALUES (54, 25);
INSERT INTO public.platforme_igre VALUES (56, 24);
INSERT INTO public.platforme_igre VALUES (56, 25);
INSERT INTO public.platforme_igre VALUES (56, 27);
INSERT INTO public.platforme_igre VALUES (35, 21);
INSERT INTO public.platforme_igre VALUES (35, 25);
INSERT INTO public.platforme_igre VALUES (39, 21);
INSERT INTO public.platforme_igre VALUES (39, 25);
INSERT INTO public.platforme_igre VALUES (42, 21);
INSERT INTO public.platforme_igre VALUES (42, 25);
INSERT INTO public.platforme_igre VALUES (42, 28);
INSERT INTO public.platforme_igre VALUES (40, 19);
INSERT INTO public.platforme_igre VALUES (40, 20);
INSERT INTO public.platforme_igre VALUES (57, 25);
INSERT INTO public.platforme_igre VALUES (62, 22);
INSERT INTO public.platforme_igre VALUES (62, 24);
INSERT INTO public.platforme_igre VALUES (62, 25);
INSERT INTO public.platforme_igre VALUES (62, 27);
INSERT INTO public.platforme_igre VALUES (61, 23);
INSERT INTO public.platforme_igre VALUES (61, 24);
INSERT INTO public.platforme_igre VALUES (61, 25);
INSERT INTO public.platforme_igre VALUES (61, 26);
INSERT INTO public.platforme_igre VALUES (61, 27);
INSERT INTO public.platforme_igre VALUES (55, 23);
INSERT INTO public.platforme_igre VALUES (55, 24);
INSERT INTO public.platforme_igre VALUES (55, 25);
INSERT INTO public.platforme_igre VALUES (55, 26);
INSERT INTO public.platforme_igre VALUES (55, 27);
INSERT INTO public.platforme_igre VALUES (59, 21);
INSERT INTO public.platforme_igre VALUES (59, 23);
INSERT INTO public.platforme_igre VALUES (59, 24);
INSERT INTO public.platforme_igre VALUES (59, 25);
INSERT INTO public.platforme_igre VALUES (59, 27);
INSERT INTO public.platforme_igre VALUES (36, 19);
INSERT INTO public.platforme_igre VALUES (36, 20);
INSERT INTO public.platforme_igre VALUES (36, 21);
INSERT INTO public.platforme_igre VALUES (36, 22);
INSERT INTO public.platforme_igre VALUES (36, 23);
INSERT INTO public.platforme_igre VALUES (36, 24);
INSERT INTO public.platforme_igre VALUES (36, 25);
INSERT INTO public.platforme_igre VALUES (36, 26);
INSERT INTO public.platforme_igre VALUES (36, 27);
INSERT INTO public.platforme_igre VALUES (43, 22);
INSERT INTO public.platforme_igre VALUES (43, 23);
INSERT INTO public.platforme_igre VALUES (43, 24);
INSERT INTO public.platforme_igre VALUES (43, 25);
INSERT INTO public.platforme_igre VALUES (43, 26);
INSERT INTO public.platforme_igre VALUES (43, 27);
INSERT INTO public.platforme_igre VALUES (38, 24);
INSERT INTO public.platforme_igre VALUES (38, 25);
INSERT INTO public.platforme_igre VALUES (38, 27);
INSERT INTO public.platforme_igre VALUES (47, 24);
INSERT INTO public.platforme_igre VALUES (47, 25);
INSERT INTO public.platforme_igre VALUES (47, 27);
INSERT INTO public.platforme_igre VALUES (53, 21);
INSERT INTO public.platforme_igre VALUES (53, 22);
INSERT INTO public.platforme_igre VALUES (53, 24);
INSERT INTO public.platforme_igre VALUES (53, 25);
INSERT INTO public.platforme_igre VALUES (51, 22);
INSERT INTO public.platforme_igre VALUES (51, 25);
INSERT INTO public.platforme_igre VALUES (46, 25);


--
-- TOC entry 4956 (class 0 OID 19014)
-- Dependencies: 222
-- Data for Name: zanr; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (1, 'Roguelike');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (2, 'Deck-building');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (3, 'Platformer');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (4, 'Action-adventure');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (5, 'Role-playing');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (7, 'Action');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (8, 'Hack-and-slash');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (9, 'Survival-horror');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (10, 'First-person');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (11, 'Shooter');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (12, 'Third-person');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (13, 'MOBA');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (14, 'Tactical');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (15, 'Hero');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (16, 'Puzzle');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (17, 'MMOG');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (18, 'Dungeon-crawler');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (19, 'MMORPG');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (20, 'Battle-royale');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (21, 'Survival');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (22, 'Sandbox');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (23, 'Metroidvania');
INSERT INTO public.zanr OVERRIDING SYSTEM VALUE VALUES (24, 'Various');


--
-- TOC entry 4961 (class 0 OID 19135)
-- Dependencies: 227
-- Data for Name: zanr_igre; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.zanr_igre VALUES (50, 5);
INSERT INTO public.zanr_igre VALUES (54, 11);
INSERT INTO public.zanr_igre VALUES (60, 1);
INSERT INTO public.zanr_igre VALUES (58, 4);
INSERT INTO public.zanr_igre VALUES (58, 8);
INSERT INTO public.zanr_igre VALUES (49, 7);
INSERT INTO public.zanr_igre VALUES (45, 5);
INSERT INTO public.zanr_igre VALUES (63, 3);
INSERT INTO public.zanr_igre VALUES (41, 7);
INSERT INTO public.zanr_igre VALUES (48, 5);
INSERT INTO public.zanr_igre VALUES (49, 5);
INSERT INTO public.zanr_igre VALUES (52, 8);
INSERT INTO public.zanr_igre VALUES (45, 7);
INSERT INTO public.zanr_igre VALUES (37, 11);
INSERT INTO public.zanr_igre VALUES (52, 4);
INSERT INTO public.zanr_igre VALUES (41, 5);
INSERT INTO public.zanr_igre VALUES (44, 9);
INSERT INTO public.zanr_igre VALUES (60, 2);
INSERT INTO public.zanr_igre VALUES (37, 10);
INSERT INTO public.zanr_igre VALUES (63, 4);
INSERT INTO public.zanr_igre VALUES (54, 12);
INSERT INTO public.zanr_igre VALUES (56, 12);
INSERT INTO public.zanr_igre VALUES (56, 11);
INSERT INTO public.zanr_igre VALUES (56, 8);
INSERT INTO public.zanr_igre VALUES (35, 13);
INSERT INTO public.zanr_igre VALUES (39, 14);
INSERT INTO public.zanr_igre VALUES (39, 10);
INSERT INTO public.zanr_igre VALUES (39, 11);
INSERT INTO public.zanr_igre VALUES (42, 13);
INSERT INTO public.zanr_igre VALUES (40, 13);
INSERT INTO public.zanr_igre VALUES (57, 15);
INSERT INTO public.zanr_igre VALUES (57, 14);
INSERT INTO public.zanr_igre VALUES (57, 11);
INSERT INTO public.zanr_igre VALUES (62, 16);
INSERT INTO public.zanr_igre VALUES (62, 3);
INSERT INTO public.zanr_igre VALUES (61, 10);
INSERT INTO public.zanr_igre VALUES (61, 11);
INSERT INTO public.zanr_igre VALUES (61, 17);
INSERT INTO public.zanr_igre VALUES (55, 7);
INSERT INTO public.zanr_igre VALUES (55, 5);
INSERT INTO public.zanr_igre VALUES (55, 8);
INSERT INTO public.zanr_igre VALUES (55, 18);
INSERT INTO public.zanr_igre VALUES (59, 19);
INSERT INTO public.zanr_igre VALUES (36, 21);
INSERT INTO public.zanr_igre VALUES (36, 20);
INSERT INTO public.zanr_igre VALUES (36, 22);
INSERT INTO public.zanr_igre VALUES (43, 23);
INSERT INTO public.zanr_igre VALUES (38, 7);
INSERT INTO public.zanr_igre VALUES (38, 5);
INSERT INTO public.zanr_igre VALUES (47, 4);
INSERT INTO public.zanr_igre VALUES (53, 23);
INSERT INTO public.zanr_igre VALUES (53, 16);
INSERT INTO public.zanr_igre VALUES (51, 16);
INSERT INTO public.zanr_igre VALUES (46, 24);


--
-- TOC entry 4971 (class 0 OID 0)
-- Dependencies: 217
-- Name: dogadaj_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.dogadaj_id_seq', 1, true);


--
-- TOC entry 4972 (class 0 OID 0)
-- Dependencies: 223
-- Name: igre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.igre_id_seq', 113, true);


--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 219
-- Name: kategorije_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.kategorije_id_seq', 10, true);


--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 225
-- Name: nominacije_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.nominacije_id_seq', 232, true);


--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 228
-- Name: platforme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.platforme_id_seq', 65, true);


--
-- TOC entry 4976 (class 0 OID 0)
-- Dependencies: 221
-- Name: zanr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.zanr_id_seq', 68, true);


--
-- TOC entry 4776 (class 2606 OID 18984)
-- Name: dogadaj dogadaj_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dogadaj
    ADD CONSTRAINT dogadaj_pkey PRIMARY KEY (id);


--
-- TOC entry 4784 (class 2606 OID 19083)
-- Name: igre igre_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.igre
    ADD CONSTRAINT igre_pkey PRIMARY KEY (id);


--
-- TOC entry 4778 (class 2606 OID 18990)
-- Name: kategorije kategorije_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kategorije
    ADD CONSTRAINT kategorije_pkey PRIMARY KEY (id);


--
-- TOC entry 4788 (class 2606 OID 19091)
-- Name: nominacije nominacije_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nominacije
    ADD CONSTRAINT nominacije_pkey PRIMARY KEY (id);


--
-- TOC entry 4798 (class 2606 OID 19177)
-- Name: platforme_igre platforme_igre_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platforme_igre
    ADD CONSTRAINT platforme_igre_pkey PRIMARY KEY (igra_id, platformeid);


--
-- TOC entry 4794 (class 2606 OID 19172)
-- Name: platforme platforme_naziv_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platforme
    ADD CONSTRAINT platforme_naziv_key UNIQUE (naziv);


--
-- TOC entry 4796 (class 2606 OID 19170)
-- Name: platforme platforme_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platforme
    ADD CONSTRAINT platforme_pkey PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 19093)
-- Name: nominacije unique_igra_i_kategorija; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nominacije
    ADD CONSTRAINT unique_igra_i_kategorija UNIQUE (igra_id, kategorija_id);


--
-- TOC entry 4780 (class 2606 OID 19189)
-- Name: zanr unique_naziv; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zanr
    ADD CONSTRAINT unique_naziv UNIQUE (naziv);


--
-- TOC entry 4786 (class 2606 OID 19085)
-- Name: igre unique_naziv_igre; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.igre
    ADD CONSTRAINT unique_naziv_igre UNIQUE (naziv_igre);


--
-- TOC entry 4792 (class 2606 OID 19139)
-- Name: zanr_igre zanr_igre_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zanr_igre
    ADD CONSTRAINT zanr_igre_pkey PRIMARY KEY (igra_id, zanr_id);


--
-- TOC entry 4782 (class 2606 OID 19018)
-- Name: zanr zanr_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zanr
    ADD CONSTRAINT zanr_pkey PRIMARY KEY (id);


--
-- TOC entry 4799 (class 2606 OID 18991)
-- Name: kategorije kategorije_dogadajid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kategorije
    ADD CONSTRAINT kategorije_dogadajid_fkey FOREIGN KEY (dogadajid) REFERENCES public.dogadaj(id);


--
-- TOC entry 4800 (class 2606 OID 19094)
-- Name: nominacije nominacije_igra_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nominacije
    ADD CONSTRAINT nominacije_igra_id_fkey FOREIGN KEY (igra_id) REFERENCES public.igre(id) ON DELETE CASCADE;


--
-- TOC entry 4801 (class 2606 OID 19099)
-- Name: nominacije nominacije_kategorija_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nominacije
    ADD CONSTRAINT nominacije_kategorija_id_fkey FOREIGN KEY (kategorija_id) REFERENCES public.kategorije(id) ON DELETE CASCADE;


--
-- TOC entry 4804 (class 2606 OID 19178)
-- Name: platforme_igre platforme_igre_igra_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platforme_igre
    ADD CONSTRAINT platforme_igre_igra_id_fkey FOREIGN KEY (igra_id) REFERENCES public.igre(id);


--
-- TOC entry 4805 (class 2606 OID 19183)
-- Name: platforme_igre platforme_igre_platformeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platforme_igre
    ADD CONSTRAINT platforme_igre_platformeid_fkey FOREIGN KEY (platformeid) REFERENCES public.platforme(id);


--
-- TOC entry 4802 (class 2606 OID 19140)
-- Name: zanr_igre zanr_igre_igra_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zanr_igre
    ADD CONSTRAINT zanr_igre_igra_id_fkey FOREIGN KEY (igra_id) REFERENCES public.igre(id);


--
-- TOC entry 4803 (class 2606 OID 19145)
-- Name: zanr_igre zanr_igre_zanr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zanr_igre
    ADD CONSTRAINT zanr_igre_zanr_id_fkey FOREIGN KEY (zanr_id) REFERENCES public.zanr(id);


-- Completed on 2025-10-29 01:18:22

--
-- PostgreSQL database dump complete
--

