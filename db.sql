--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: contributors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contributors (
    user_id integer NOT NULL,
    ds_id integer NOT NULL
);


--
-- Name: ds_frontend; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ds_frontend (
    num_contributors integer DEFAULT 0,
    description text,
    num_entries integer DEFAULT 0,
    licence smallint NOT NULL,
    ds_id integer NOT NULL,
    readme text,
    contribution_guidelines text,
    CONSTRAINT ds_frontend_licence_check CHECK (((licence >= 0) AND (licence <= 5))),
    CONSTRAINT ds_frontend_num_entries_check CHECK ((num_entries >= 0))
);


--
-- Name: ds_frontend_ds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ds_frontend_ds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ds_frontend_ds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ds_frontend_ds_id_seq OWNED BY public.ds_frontend.ds_id;


--
-- Name: ds_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ds_metadata (
    ds_id integer NOT NULL,
    ds_name character varying(150) NOT NULL,
    score integer DEFAULT 0,
    contribution smallint NOT NULL,
    owner integer NOT NULL,
    CONSTRAINT ds_metadata_contribution_check CHECK (((contribution >= 0) AND (contribution <= 2)))
);


--
-- Name: ds_metadata_dataset_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ds_metadata_dataset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ds_metadata_dataset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ds_metadata_dataset_id_seq OWNED BY public.ds_metadata.ds_id;


--
-- Name: issues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.issues (
    id integer NOT NULL,
    ds_id integer,
    description text,
    bounty boolean,
    bounty_amount integer,
    from_user integer
);


--
-- Name: issues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.issues_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: issues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.issues_id_seq OWNED BY public.issues.id;


--
-- Name: second_dataset; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.second_dataset (
    index integer,
    id integer,
    name text,
    owner text,
    rank integer,
    score real,
    price real,
    tax real,
    province text,
    type text,
    ls real
);


--
-- Name: session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    username text NOT NULL,
    email text NOT NULL,
    cakeday date NOT NULL,
    password text NOT NULL,
    id integer NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: ds_frontend ds_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ds_frontend ALTER COLUMN ds_id SET DEFAULT nextval('public.ds_frontend_ds_id_seq'::regclass);


--
-- Name: ds_metadata ds_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ds_metadata ALTER COLUMN ds_id SET DEFAULT nextval('public.ds_metadata_dataset_id_seq'::regclass);


--
-- Name: issues id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues ALTER COLUMN id SET DEFAULT nextval('public.issues_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: contributors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contributors (user_id, ds_id) FROM stdin;
\.


--
-- Data for Name: ds_frontend; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ds_frontend (num_contributors, description, num_entries, licence, ds_id, readme, contribution_guidelines) FROM stdin;
0	The Bee Movie script, but it's actually an anime title dataset	0	0	52	### Simple README.md example. \n This **should** be markdown formatted so that it is nice and crispy when reading. \n It can also technically render LaTeX, \n $ e^{i\\pi} = -1 $ \n $$ \n \\int\\limits_0^1 x^2 + y^2 \\ dx \n $$	#### General contribution guidelines:  \\n    * Nothing illegal (follow common sense). \\n      * Another requirement that I  cannot think about now. \\n     * Yet another requirement, this time more detailed because it will probably be something important.  \\n\\n  &nbsp;  \\n\\n     For more information, please read the full  *general contributions guidelines*.
\.


--
-- Data for Name: ds_metadata; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ds_metadata (ds_id, ds_name, score, contribution, owner) FROM stdin;
52	second_dataset	0	0	0
\.


--
-- Data for Name: issues; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.issues (id, ds_id, description, bounty, bounty_amount, from_user) FROM stdin;
\.


--
-- Data for Name: second_dataset; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.second_dataset (index, id, name, owner, rank, score, price, tax, province, type, ls) FROM stdin;
\N	1	Eldon Base for stackable storage shelf, platinum	Muhammed MacIntyre	3	-213.25	38.94	35	Nunavut	Storage & Organization	0.8
\N	2	1.7 Cubic Foot Compact "Cube" Office Refrigerators	Barry French	293	457.81	208.16	68.02	Nunavut	Appliances	0.58
\N	3	Cardinal Slant-D® Ring Binder, Heavy Gauge Vinyl	Barry French	293	46.71	8.69	2.99	Nunavut	Binders and Binder Accessories	0.39
\N	4	R380	Clay Rozendal	483	1198.97	195.99	3.99	Nunavut	Telephones and Communication	0.58
\N	5	Holmes HEPA Air Purifier	Carlos Soltero	515	30.94	21.78	5.94	Nunavut	Appliances	0.5
\N	6	G.E. Longer-Life Indoor Recessed Floodlight Bulbs	Carlos Soltero	515	4.43	6.64	4.95	Nunavut	Office Furnishings	0.37
\N	7	Angle-D Binders with Locking Rings, Label Holders	Carl Jackson	613	-54.04	7.3	7.72	Nunavut	Binders and Binder Accessories	0.38
\N	8	SAFCO Mobile Desk Side File, Wire Frame	Carl Jackson	613	127.7	42.76	6.22	Nunavut	Storage & Organization	\N
\N	9	SAFCO Commercial Wire Shelving, Black	Monica Federle	643	-695.26	138.14	35	Nunavut	Storage & Organization	\N
\N	10	Xerox 198	Dorothy Badders	678	-226.36	4.98	8.33	Nunavut	Paper	0.38
\N	11	Xerox 1980	Neola Schneider	807	-166.85	4.28	6.18	Nunavut	Paper	0.4
\N	12	Advantus Map Pennant Flags and Round Head Tacks	Neola Schneider	807	-14.33	3.95	2	Nunavut	Rubber Bands	0.53
\N	13	Holmes HEPA Air Purifier	Carlos Daly	868	134.72	21.78	5.94	Nunavut	Appliances	0.5
\N	14	DS/HD IBM Formatted Diskettes, 200/Pack - Staples	Carlos Daly	868	114.46	47.98	3.61	Nunavut	Computer Peripherals	0.71
\N	15	Wilson Jones 1" Hanging DublLock® Ring Binders	Claudia Miner	933	-4.72	5.28	2.99	Nunavut	Binders and Binder Accessories	0.37
\N	16	Ultra Commercial Grade Dual Valve Door Closer	Neola Schneider	995	782.91	39.89	3.04	Nunavut	Office Furnishings	0.53
\N	17	#10-4 1/8" x 9 1/2" Premium Diagonal Seam Envelopes	Allen Rosenblatt	998	93.8	15.74	1.39	Nunavut	Envelopes	0.4
\N	18	Hon 4-Shelf Metal Bookcases	Sylvia Foulston	1154	440.72	100.98	26.22	Nunavut	Bookcases	0.6
\N	19	Lesro Sheffield Collection Coffee Table, End Table, Center Table, Corner Table	Sylvia Foulston	1154	-481.04	71.37	69	Nunavut	Tables	0.68
\N	20	g520	Jim Radford	1344	-11.68	65.99	5.26	Nunavut	Telephones and Communication	0.59
\N	21	LX 788	Jim Radford	1344	313.58	155.99	8.99	Nunavut	Telephones and Communication	0.58
\N	22	Avery 52	Carlos Soltero	1412	26.92	3.69	0.5	Nunavut	Labels	0.38
\N	23	Plymouth Boxed Rubber Bands by Plymouth	Carlos Soltero	1412	-5.77	4.71	0.7	Nunavut	Rubber Bands	0.8
\N	24	GBC Pre-Punched Binding Paper, Plastic, White, 8-1/2" x 11"	Carl Ludwig	1539	-172.88	15.99	13.18	Nunavut	Binders and Binder Accessories	0.37
\N	25	Maxell 3.5" DS/HD IBM-Formatted Diskettes, 10/Pack	Carl Ludwig	1539	-144.55	4.89	4.93	Nunavut	Computer Peripherals	0.66
\N	26	Newell 335	Don Miller	1540	5.76	2.88	0.7	Nunavut	Pens & Art Supplies	0.56
\N	27	SANFORD Liquid Accent™ Tank-Style Highlighters	Annie Cyprus	1702	4.9	2.84	0.93	Nunavut	Pens & Art Supplies	0.54
\N	28	Canon PC940 Copier	Carl Ludwig	1761	-547.61	449.99	49	Nunavut	Copiers and Fax	0.38
\N	29	Tenex Personal Project File with Scoop Front Design, Black	Carlos Soltero	1792	-5.45	13.48	4.51	Nunavut	Storage & Organization	0.59
\N	30	Col-Erase® Pencils with Erasers	Grant Carroll	2275	41.67	6.08	1.17	Nunavut	Pens & Art Supplies	0.56
\N	31	Imation 3.5" DS/HD IBM Formatted Diskettes, 10/Pack	Don Miller	2277	-46.03	5.98	4.38	Nunavut	Computer Peripherals	0.75
\N	32	White Dual Perf Computer Printout Paper, 2700 Sheets, 1 Part, Heavyweight, 20 lbs., 14 7/8 x 11	Don Miller	2277	33.67	40.99	19.99	Nunavut	Paper	0.36
\N	33	Self-Adhesive Address Labels for Typewriters by Universal	Alan Barnes	2532	140.01	7.31	0.49	Nunavut	Labels	0.38
\N	34	Accessory37	Alan Barnes	2532	-78.96	20.99	2.5	Nunavut	Telephones and Communication	0.81
\N	35	Fuji 5.2GB DVD-RAM	Jack Garza	2631	252.66	40.96	1.99	Nunavut	Computer Peripherals	0.55
\N	36	Bevis Steel Folding Chairs	Julia West	2757	-1766.01	95.95	74.35	Nunavut	Chairs & Chairmats	0.57
\N	37	Avery Binder Labels	Eugene Barchas	2791	-236.27	3.89	7.01	Nunavut	Binders and Binder Accessories	0.37
\N	38	Hon Every-Day® Chair Series Swivel Task Chairs	Eugene Barchas	2791	80.44	120.98	30	Nunavut	Chairs & Chairmats	0.64
\N	39	IBM Multi-Purpose Copy Paper, 8 1/2 x 11", Case	Eugene Barchas	2791	118.94	30.98	5.76	Nunavut	Paper	0.4
\N	40	Global Troy™ Executive Leather Low-Back Tilter	Edward Hooks	2976	3424.22	500.98	26	Nunavut	Chairs & Chairmats	0.6
\N	41	XtraLife® ClearVue™ Slant-D® Ring Binders by Cardinal	Brad Eason	3232	-11.83	7.84	4.71	Nunavut	Binders and Binder Accessories	0.35
\N	42	Computer Printout Paper with Letter-Trim Perforations	Nicole Hansen	3524	52.35	18.97	9.03	Nunavut	Paper	0.37
\N	43	6160	Dorothy Wardle	3908	-180.2	115.99	2.5	Nunavut	Telephones and Communication	0.57
\N	44	Avery 49	Aaron Bergman	4132	1.32	2.88	0.5	Nunavut	Labels	0.36
\N	45	Hoover Portapower™ Portable Vacuum	Jim Radford	4612	-375.64	4.48	49	Nunavut	Appliances	0.6
\N	46	Timeport L7089	Annie Cyprus	4676	-104.25	125.99	7.69	Nunavut	Telephones and Communication	0.58
\N	47	Avery 510	Annie Cyprus	4676	85.96	3.75	0.5	Nunavut	Labels	0.37
\N	48	Xerox 1881	Annie Cyprus	4676	-8.38	12.28	6.47	Nunavut	Paper	0.38
\N	49	LX 788	Annie Cyprus	4676	1115.69	155.99	8.99	Nunavut	Telephones and Communication	0.58
\N	50	Cardinal Slant-D® Ring Binder, Heavy Gauge Vinyl	Annie Cyprus	5284	-3.05	8.69	2.99	Nunavut	Binders and Binder Accessories	0.39
\N	51	Memorex 4.7GB DVD-RAM, 3/Pack	Clay Rozendal	5316	514.07	31.78	1.99	Nunavut	Computer Peripherals	0.42
\N	52	Unpadded Memo Slips	Don Jones	5409	-7.04	3.98	2.97	Nunavut	Paper	0.35
\N	53	Adams Telephone Message Book W/Dividers/Space For Phone Numbers, 5 1/4"X8 1/2", 300/Messages	Beth Thompson	5506	4.41	5.88	3.04	Nunavut	Paper	0.36
\N	54	Eldon Expressions™ Desk Accessory, Wood Pencil Holder, Oak	Frank Price	5569	-0.06	9.65	6.22	Nunavut	Office Furnishings	0.55
\N	55	Bell Sonecor JB700 Caller ID	Michelle Lonsdale	5607	-50.33	7.99	5.03	Nunavut	Telephones and Communication	0.6
\N	56	Avery Arch Ring Binders	Ann Chong	5894	87.68	58.1	1.49	Nunavut	Binders and Binder Accessories	0.38
\N	57	APC 7 Outlet Network SurgeArrest Surge Protector	Ann Chong	5894	-68.22	80.48	4.5	Nunavut	Appliances	0.55
\N	3867	Avery 501	Tracy Poddar	386	-0.03	3.69	0.5	Ontario	Labels	0.38
\N	58	Deflect-o RollaMat Studded, Beveled Mat for Medium Pile Carpeting	Joy Bell	5925	-354.9	92.23	39.61	Nunavut	Office Furnishings	0.67
\N	59	Accessory4	Joy Bell	5925	-267.01	85.99	0.99	Nunavut	Telephones and Communication	0.85
\N	60	Personal Creations™ Ink Jet Cards and Labels	Skye Norling	6016	3.63	11.48	5.43	Nunavut	Paper	0.36
\N	61	High Speed Automatic Electric Letter Opener	Barry Weirich	6116	-1759.58	1637.53	24.49	Nunavut	Scissors, Rulers and Trimmers	0.81
\N	62	Xerox 1966	Grant Carroll	6182	-116.79	6.48	6.65	Nunavut	Paper	0.36
\N	63	Xerox 213	Grant Carroll	6182	-67.28	6.48	7.86	Nunavut	Paper	0.37
\N	64	Boston Electric Pencil Sharpener, Model 1818, Charcoal Black	Adrian Hane	6535	-19.33	28.15	8.99	Nunavut	Pens & Art Supplies	0.57
\N	65	Hammermill CopyPlus Copy Paper (20Lb. and 84 Bright)	Skye Norling	6884	-61.21	4.98	4.75	Nunavut	Paper	0.36
\N	66	Telephone Message Books with Fax/Mobile Section, 5 1/2" x 3 3/16"	Skye Norling	6884	119.09	6.35	1.02	Nunavut	Paper	0.39
\N	67	Crate-A-Files™	Andrew Gjertsen	6916	-141.27	10.9	7.46	Nunavut	Storage & Organization	0.59
\N	68	Angle-D Binders with Locking Rings, Label Holders	Ralph Knight	6980	-77.28	7.3	7.72	Nunavut	Binders and Binder Accessories	0.38
\N	69	80 Minute CD-R Spindle, 100/Pack - Staples	Dorothy Wardle	6982	407.44	39.48	1.99	Nunavut	Computer Peripherals	0.54
\N	70	Bush Westfield Collection Bookcases, Dark Cherry Finish, Fully Assembled	Dorothy Wardle	6982	-338.27	100.98	57.38	Nunavut	Bookcases	0.78
\N	71	12-1/2 Diameter Round Wall Clock	Dorothy Wardle	6982	52.56	19.98	10.49	Nunavut	Office Furnishings	0.49
\N	72	SAFCO Arco Folding Chair	Grant Carroll	7110	1902.24	276.2	24.49	Nunavut	Chairs & Chairmats	\N
\N	73	#10 White Business Envelopes,4 1/8 x 9 1/2	Barry Weirich	7430	353.2	15.67	1.39	Nunavut	Envelopes	0.38
\N	74	3M Office Air Cleaner	Beth Paige	7906	271.78	25.98	5.37	Nunavut	Appliances	0.5
\N	75	Global Leather and Oak Executive Chair, Black	Sylvia Foulston	8391	-268.36	300.98	64.73	Nunavut	Chairs & Chairmats	0.56
\N	76	Xerox 1936	Nicole Hansen	8419	70.39	19.98	5.97	Nunavut	Paper	0.38
\N	77	Xerox 214	Nicole Hansen	8419	-86.62	6.48	7.03	Nunavut	Paper	0.37
\N	78	Carina Double Wide Media Storage Towers in Natural & Black	Nicole Hansen	8833	-846.73	80.98	35	Nunavut	Storage & Organization	0.81
\N	79	Staples® General Use 3-Ring Binders	Beth Paige	8995	8.05	1.88	1.49	Nunavut	Binders and Binder Accessories	0.37
\N	80	Xerox 1904	Beth Paige	8995	-78.02	6.48	5.86	Northwest Territories	Paper	0.36
\N	81	Luxo Professional Combination Clamp-On Lamps	Beth Paige	8995	737.94	102.3	21.26	Northwest Territories	Office Furnishings	0.59
\N	82	Xerox 217	Beth Paige	8995	-191.28	6.48	8.19	Northwest Territories	Paper	0.37
\N	83	Revere Boxed Rubber Bands by Revere	Beth Paige	8995	-21.49	1.89	0.76	Northwest Territories	Rubber Bands	0.83
\N	84	Acco Smartsocket™ Table Surge Protector, 6 Color-Coded Adapter Outlets	Sylvia Foulston	9126	884.08	62.05	3.99	Northwest Territories	Appliances	0.55
\N	85	Tennsco Snap-Together Open Shelving Units, Starter Sets and Add-On Units	Bryan Davis	9127	-329.49	279.48	35	Northwest Territories	Storage & Organization	0.8
\N	86	Hon 4070 Series Pagoda™ Round Back Stacking Chairs	Joy Bell	9509	2825.15	320.98	58.95	Northwest Territories	Chairs & Chairmats	0.57
\N	87	Xerox 1887	Joy Bell	9509	2.13	18.97	5.21	Northwest Territories	Paper	0.37
\N	88	Xerox 1891	Joy Bell	9509	707.15	48.91	5.81	Northwest Territories	Paper	0.38
\N	89	Avery 506	Alan Barnes	9763	75.13	4.13	0.5	Northwest Territories	Labels	0.39
\N	90	Bush Heritage Pine Collection 5-Shelf Bookcase, Albany Pine Finish, *Special Order	Grant Carroll	9927	-270.63	140.98	53.48	Northwest Territories	Bookcases	0.65
\N	91	Lifetime Advantage™ Folding Chairs, 4/Carton	Grant Carroll	9927	3387.35	218.08	18.06	Northwest Territories	Chairs & Chairmats	0.57
\N	92	Microsoft Natural Multimedia Keyboard	Grant Carroll	9927	-82.16	50.98	6.5	Northwest Territories	Computer Peripherals	0.73
\N	93	Staples Wirebound Steno Books, 6" x 9", 12/Pack	Delfina Latchford	10022	-3.88	10.14	2.27	Northwest Territories	Paper	0.36
\N	94	GBC Pre-Punched Binding Paper, Plastic, White, 8-1/2" x 11"	Don Jones	10437	-191.22	15.99	13.18	Northwest Territories	Binders and Binder Accessories	0.37
\N	95	Bevis Boat-Shaped Conference Table	Doug Bickford	10499	31.21	262.11	62.74	Northwest Territories	Tables	0.75
\N	96	Linden® 12" Wall Clock With Oak Frame	Doug Bickford	10535	-44.14	33.98	19.99	Northwest Territories	Office Furnishings	0.55
\N	97	Newell 326	Doug Bickford	10535	-0.79	1.76	0.7	Northwest Territories	Pens & Art Supplies	0.56
\N	98	Prismacolor Color Pencil Set	Jamie Kunitz	10789	76.42	19.84	4.1	Northwest Territories	Pens & Art Supplies	0.44
\N	99	Xerox Blank Computer Paper	Anthony Johnson	10791	93.36	19.98	5.77	Northwest Territories	Paper	0.38
\N	100	600 Series Flip	Ralph Knight	10945	4.22	95.99	8.99	Northwest Territories	Telephones and Communication	0.57
\N	101	Fellowes Recycled Storage Drawers	Allen Rosenblatt	11137	395.12	111.03	8.64	Northwest Territories	Storage & Organization	0.78
\N	102	Satellite Sectional Post Binders	Barry Weirich	11202	79.59	43.41	2.99	Northwest Territories	Binders and Binder Accessories	0.39
\N	103	Deflect-o DuraMat Antistatic Studded Beveled Mat for Medium Pile Carpeting	Doug Bickford	11456	399.37	105.34	24.49	Northwest Territories	Office Furnishings	0.61
\N	104	Avery 487	Carl Jackson	11460	37.79	3.69	0.5	Northwest Territories	Labels	0.38
\N	105	Bevis Round Conference Table Top & Single Column Base	Brendan Dodson	11495	-144.2	146.34	43.75	Northwest Territories	Tables	0.65
\N	106	GBC Twin Loop™ Wire Binding Elements, 9/16" Spine, Black	Edward Hooks	11911	-14.75	15.22	9.73	Northwest Territories	Binders and Binder Accessories	0.36
\N	107	Hanging Personal Folder File	Jamie Kunitz	11941	-41.01	15.7	11.25	Northwest Territories	Storage & Organization	0.6
\N	108	Bevis Round Conference Table Top, X-Base	Jamie Kunitz	11941	111.52	179.29	29.21	Northwest Territories	Tables	0.74
\N	109	5125	Michelle Lonsdale	12096	2332.4	200.99	8.08	Northwest Territories	Telephones and Communication	0.59
\N	110	Electrix Halogen Magnifier Lamp	Michelle Lonsdale	12096	2176.19	194.3	11.54	Northwest Territories	Office Furnishings	0.59
\N	111	Canon BP1200DH 12-Digit Bubble Jet Printing Calculator	Brendan Dodson	12289	1269.05	120.97	7.11	Northwest Territories	Office Machines	0.36
\N	631	*Staples* Packaging Labels	Dan Reichenbach	35300	7.15	2.89	0.49	Prince Edward Island	Labels	0.38
\N	112	Fellowes Black Plastic Comb Bindings	Hunter Glantz	12352	-32.82	5.81	8.49	Northwest Territories	Binders and Binder Accessories	0.39
\N	113	Polycom ViewStation™ Adapter H323 Videoconferencing Unit	Sylvia Foulston	12419	5322.14	1938.02	13.99	Northwest Territories	Office Machines	0.38
\N	114	Hon GuestStacker Chair	Eugene Barchas	12485	1068.48	226.67	28.16	Northwest Territories	Chairs & Chairmats	0.59
\N	115	Eldon® Wave Desk Accessories	Jim Radford	12544	-129.01	2.08	5.33	Northwest Territories	Office Furnishings	0.43
\N	116	Sharp AL-1530CS Digital Copier	Carlos Soltero	12704	1260.51	499.99	24.49	Northwest Territories	Copiers and Fax	0.36
\N	117	Tennsco Lockers, Gray	Carlos Soltero	12704	-1274.02	20.98	53.03	Northwest Territories	Storage & Organization	0.78
\N	118	Avery 4027 File Folder Labels for Dot Matrix Printers, 5000 Labels per Box, White	Carlos Soltero	12771	-193.44	30.53	19.99	Northwest Territories	Labels	0.39
\N	119	Newell 323	Carlos Soltero	12771	-43.1	1.68	1.57	Northwest Territories	Pens & Art Supplies	0.59
\N	120	Global Enterprise Series Seating High-Back Swivel/Tilt Chairs	Jim Radford	12929	-158.93	270.98	50	Northwest Territories	Chairs & Chairmats	0.77
\N	121	Spiral Phone Message Books with Labels by Adams	Jim Radford	12929	29.68	4.48	1.22	Northwest Territories	Paper	0.36
\N	122	Crate-A-Files™	Grant Carroll	13280	-116.76	10.9	7.46	Northwest Territories	Storage & Organization	0.59
\N	123	Bell Sonecor JB700 Caller ID	Grant Carroll	13280	-160.95	7.99	5.03	Northwest Territories	Telephones and Communication	0.6
\N	124	Holmes 99% HEPA Air Purifier	Skye Norling	13313	-209.61	21.66	13.99	Northwest Territories	Appliances	0.52
\N	125	Xerox 224	Doug Bickford	13346	-240.83	6.48	8.88	Northwest Territories	Paper	0.37
\N	126	Xerox 1906	Grant Carroll	13702	12.32	35.44	7.5	Northwest Territories	Paper	0.38
\N	127	GBC Pre-Punched Binding Paper, Plastic, White, 8-1/2" x 11"	Muhammed MacIntyre	13795	-119.08	15.99	13.18	Northwest Territories	Binders and Binder Accessories	0.37
\N	128	Xerox 188	Muhammed MacIntyre	13795	43.35	11.34	5.01	Northwest Territories	Paper	0.36
\N	129	Xerox 1932	Muhammed MacIntyre	13795	545.49	35.44	5.09	Northwest Territories	Paper	0.38
\N	130	GBC Linen Binding Covers	Doug Bickford	14116	-16.07	30.98	11.63	Northwest Territories	Binders and Binder Accessories	0.37
\N	131	GBC Recycled Grain Textured Covers	Doug Bickford	14116	161.48	34.54	14.72	Northwest Territories	Binders and Binder Accessories	0.37
\N	132	Sauder Facets Collection Library, Sky Alder Finish	Beth Thompson	14372	-1059.2	170.98	60.49	Northwest Territories	Bookcases	0.69
\N	133	Fellowes Basic 104-Key Keyboard, Platinum	Ralph Knight	14726	-21.48	20.95	4	Northwest Territories	Computer Peripherals	0.6
\N	134	Kensington 7 Outlet MasterPiece Power Center with Fax/Phone Line Protection	Carl Jackson	14819	3122.78	207.48	0.99	Northwest Territories	Appliances	0.55
\N	135	O'Sullivan 3-Shelf Heavy-Duty Bookcases	Carl Jackson	14819	-478.22	58.14	36.61	Northwest Territories	Bookcases	0.61
\N	136	G.E. Longer-Life Indoor Recessed Floodlight Bulbs	Dorothy Badders	15106	-14.23	6.64	4.95	Northwest Territories	Office Furnishings	0.37
\N	137	Panasonic KX-P1150 Dot Matrix Printer	Dorothy Badders	15106	948.79	145.45	17.85	Northwest Territories	Office Machines	0.56
\N	138	Newell 327	Dorothy Badders	15106	-6.33	2.21	1.12	Northwest Territories	Pens & Art Supplies	0.58
\N	139	Xerox 1893	Delfina Latchford	15108	372.36	40.99	17.48	Northwest Territories	Paper	0.36
\N	140	Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back	Julia West	15205	678.26	243.98	43.32	Northwest Territories	Chairs & Chairmats	0.55
\N	141	Eldon Radial Chair Mat for Low to Medium Pile Carpets	Julia West	15205	155.72	39.98	9.2	Northwest Territories	Office Furnishings	0.65
\N	142	DAX Copper Panel Document Frame, 5 x 7 Size	Brad Eason	15591	73.53	12.58	5.16	Northwest Territories	Office Furnishings	0.43
\N	143	O'Sullivan 2-Shelf Heavy-Duty Bookcases	Thomas Seio	15907	-1414.41	48.58	54.11	Northwest Territories	Bookcases	0.69
\N	144	Tenex 46" x 60" Computer Anti-Static Chairmat, Rectangular Shaped	Thomas Seio	15907	950.68	105.98	13.99	Northwest Territories	Office Furnishings	0.65
\N	145	Wirebound Message Books, 2 7/8" x 5", 3 Forms per Page	Thomas Seio	15907	-5.41	7.04	2.17	Northwest Territories	Paper	0.38
\N	146	Memorex Slim 80 Minute CD-R, 10/Pack	Monica Federle	15937	74.07	9.78	1.99	Northwest Territories	Computer Peripherals	0.43
\N	147	Aluminum Document Frame	Monica Federle	15937	77.38	12.22	2.85	Northwest Territories	Office Furnishings	0.55
\N	148	Memorex 80 Minute CD-R Spindle, 100/Pack	Michelle Lonsdale	16039	-118.82	43.98	1.99	Northwest Territories	Computer Peripherals	0.44
\N	149	Multi-Use Personal File Cart and Caster Set, Three Stacking Bins	Frank Price	16193	6.41	34.76	8.22	Northwest Territories	Storage & Organization	0.57
\N	150	Accessory36	Frank Price	16193	-183.68	55.99	5	Northwest Territories	Telephones and Communication	0.83
\N	151	Xerox 20	Bryan Davis	16423	-55.13	6.48	6.57	Northwest Territories	Paper	0.37
\N	152	Surelock™ Post Binders	Don Jones	16451	58.23	30.56	2.99	Northwest Territories	Binders and Binder Accessories	0.35
\N	153	Colorific® Watercolor Pencils	Carlos Soltero	16545	4.45	5.16	0.73	Northwest Territories	Pens & Art Supplies	0.56
\N	154	*Staples* vLetter Openers, 2/Pack	Carlos Soltero	16545	-3.06	3.68	1.32	Northwest Territories	Scissors, Rulers and Trimmers	0.83
\N	155	Hon 4700 Series Mobuis™ Mid-Back Task Chairs with Adjustable Arms	Nicole Hansen	16547	1240.25	355.98	58.92	Northwest Territories	Chairs & Chairmats	0.64
\N	156	BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	Nicole Hansen	16547	-533.23	218.75	69.64	Northwest Territories	Tables	0.77
\N	157	Eldon Econocleat® Chair Mats for Low Pile Carpets	Beth Thompson	16706	-1003.58	41.47	34.2	Northwest Territories	Office Furnishings	0.73
\N	158	Prang Drawing Pencil Set	Beth Thompson	16706	-4.06	2.78	1.2	Northwest Territories	Pens & Art Supplies	0.58
\N	159	T39m	Beth Thompson	16706	1881.58	155.99	3.9	Northwest Territories	Telephones and Communication	0.55
\N	160	Xerox 1982	Nicole Hansen	16741	-42.38	22.84	16.87	Northwest Territories	Paper	0.39
\N	161	Xerox 1924	Carlos Soltero	16932	-120.99	5.78	8.09	Northwest Territories	Paper	0.36
\N	162	Turquoise Lead Holder with Pocket Clip	Carlos Soltero	16932	12.88	6.7	1.56	Northwest Territories	Pens & Art Supplies	0.52
\N	163	Okidata ML395C Color Dot Matrix Printer	Dorothy Badders	17283	-2816.34	1360.14	14.7	Northwest Territories	Office Machines	0.59
\N	164	Global Enterprise Series Seating High-Back Swivel/Tilt Chairs	Muhammed MacIntyre	17286	-541.87	270.98	50	Northwest Territories	Chairs & Chairmats	0.77
\N	165	Microsoft Internet Keyboard	Muhammed MacIntyre	17409	-158.87	20.97	6.5	Northwest Territories	Computer Peripherals	0.78
\N	166	Xerox 1982	Don Miller	17764	-97.28	22.84	16.87	Northwest Territories	Paper	0.39
\N	167	Global Ergonomic Managers Chair	Sylvia Foulston	18080	-80.83	180.98	26.2	Northwest Territories	Chairs & Chairmats	0.59
\N	168	Office Star - Contemporary Task Swivel chair with 2-way adjustable arms, Plum	Becky Castell	18113	-514.32	130.98	30	Northwest Territories	Chairs & Chairmats	0.78
\N	169	Xerox 1971	Dorothy Wardle	18144	-131.82	4.28	5.17	Northwest Territories	Paper	0.4
\N	170	Eldon Portable Mobile Manager	Dorothy Wardle	18144	-65.42	28.28	13.99	Northwest Territories	Storage & Organization	0.58
\N	171	Accessory6	Dorothy Wardle	18144	-250.17	55.99	5	Northwest Territories	Telephones and Communication	0.8
\N	172	Durable Pressboard Binders	Ann Chong	18308	15.73	3.8	1.49	Northwest Territories	Binders and Binder Accessories	0.38
\N	173	Fellowes 17-key keypad for PS/2 interface	Ann Chong	18308	-92.58	30.73	4	Northwest Territories	Computer Peripherals	0.75
\N	174	StarTAC ST7762	Ann Chong	18308	1465.87	125.99	8.08	Northwest Territories	Telephones and Communication	0.57
\N	175	Accessory21	Clay Rozendal	18887	18.23	20.99	0.99	Northwest Territories	Telephones and Communication	0.37
\N	176	Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind	Grant Carroll	19010	10951.31	1270.99	19.99	Northwest Territories	Binders and Binder Accessories	0.35
\N	177	Staples 6 Outlet Surge	Brendan Dodson	19078	-18.19	11.97	4.98	Northwest Territories	Appliances	0.58
\N	178	Recycled Eldon Regeneration Jumbo File	Carlos Daly	19138	-31.45	12.28	6.13	Northwest Territories	Storage & Organization	0.57
\N	179	Verbatim DVD-R 4.7GB authoring disc	Alan Barnes	19655	304.42	39.24	1.99	Northwest Territories	Computer Peripherals	0.51
\N	180	Canon P1-DHIII Palm Printing Calculator	Alan Barnes	19686	-53.08	17.98	8.51	Northwest Territories	Office Machines	0.4
\N	181	GBC Binding covers	Alan Barnes	19686	12.76	12.95	4.98	Northwest Territories	Binders and Binder Accessories	0.4
\N	182	Newell 323	Nicole Hansen	20007	-46.25	1.68	1.57	Northwest Territories	Pens & Art Supplies	0.59
\N	183	Global Stack Chair without Arms, Black	Cari Schnelling	20071	-190.41	25.98	14.36	Northwest Territories	Chairs & Chairmats	0.6
\N	184	Speediset Carbonless Redi-Letter® 7" x 8 1/2"	Chad Cunningham	20160	174.89	10.31	1.79	Northwest Territories	Paper	0.38
\N	185	GBC Recycled Regency Composition Covers	Bryan Mills	20263	72.51	59.78	10.29	Northwest Territories	Binders and Binder Accessories	0.39
\N	186	Accessory29	Bryan Mills	20263	-76.86	20.99	1.25	Northwest Territories	Telephones and Communication	0.83
\N	187	Newell 323	Adrian Hane	21285	-30.54	1.68	1.57	Northwest Territories	Pens & Art Supplies	0.59
\N	188	SANFORD Major Accent™ Highlighters	Adrian Hane	21285	23.82	7.08	2.35	Northwest Territories	Pens & Art Supplies	0.47
\N	189	Polycom ViaVideo™ Desktop Video Communications Unit	Rick Reed	21383	7416.43	574.74	24.49	Northwest Territories	Office Machines	0.37
\N	190	Dixon Ticonderoga Core-Lock Colored Pencils, 48-Color Set	Heather Kirkland	21607	54.92	36.55	13.89	Northwest Territories	Pens & Art Supplies	0.41
\N	191	Accessory24	Fred Wasserman	21636	366.51	55.99	3.3	Northwest Territories	Telephones and Communication	0.59
\N	192	Howard Miller 13-3/4" Diameter Brushed Chrome Round Wall Clock	Becky Castell	21889	135.79	51.75	19.99	Northwest Territories	Office Furnishings	0.55
\N	193	Recycled Steel Personal File for Standard File Folders	Becky Castell	21889	103.38	55.29	5.08	Northwest Territories	Storage & Organization	0.59
\N	194	Eldon Expressions™ Desk Accessory, Wood Pencil Holder, Oak	Beth Thompson	22151	-79.72	9.65	6.22	Northwest Territories	Office Furnishings	0.55
\N	195	Accessory39	Claudia Miner	22342	-92.96	20.99	3.3	Northwest Territories	Telephones and Communication	0.81
\N	196	Bell Sonecor JB700 Caller ID	Jack Lebron	22469	-162.37	7.99	5.03	Northwest Territories	Telephones and Communication	0.6
\N	197	#10- 4 1/8" x 9 1/2" Security-Tint Envelopes	Alan Barnes	22501	7.27	7.64	1.39	Northwest Territories	Envelopes	0.36
\N	198	GBC Standard Plastic Binding Systems Combs	Carlos Soltero	22532	-11.8	8.85	5.6	Northwest Territories	Binders and Binder Accessories	0.36
\N	199	Xerox 1930	Clay Rozendal	23264	-50.82	6.48	6.81	Northwest Territories	Paper	0.36
\N	200	Avery 474	Clay Rozendal	23264	17.99	2.88	0.99	Northwest Territories	Labels	0.36
\N	201	Riverside Palais Royal Lawyers Bookcase, Royale Cherry Finish	Julia West	23488	-11053.6	880.98	44.55	Northwest Territories	Bookcases	0.62
\N	202	Hewlett-Packard Deskjet 6122 Color Inkjet Printer	Alan Barnes	23584	636.18	200.97	15.59	Northwest Territories	Office Machines	0.36
\N	203	IBM 80 Minute CD-R Spindle, 50/Pack	Joy Bell	24007	135.65	20.89	1.99	Northwest Territories	Computer Peripherals	0.48
\N	204	Peel & Seel® Recycled Catalog Envelopes, Brown	Joy Bell	24007	-13.95	11.58	6.97	Northwest Territories	Envelopes	0.35
\N	205	Avery 506	Joy Bell	24007	66.17	4.13	0.5	Northwest Territories	Labels	0.39
\N	206	Prang Drawing Pencil Set	Jack Lebron	24038	-0.95	2.78	1.34	Northwest Territories	Pens & Art Supplies	0.45
\N	207	TDK 4.7GB DVD+RW	Anthony Johnson	24097	-35.34	14.48	1.99	Northwest Territories	Computer Peripherals	0.49
\N	208	U.S. Robotics 56K Internet Call Modem	Anthony Johnson	24097	399.93	99.99	19.99	Northwest Territories	Computer Peripherals	0.5
\N	209	Xerox 190	Anthony Johnson	24097	-8.15	4.98	4.86	Northwest Territories	Paper	0.38
\N	210	Standard Line™ “While You Were Out” Hardbound Telephone Message Book	Eugene Barchas	24128	7.07	21.98	8.32	Northwest Territories	Paper	0.39
\N	211	CF 888	Eugene Barchas	24128	1459.79	195.99	3.99	Northwest Territories	Telephones and Communication	0.59
\N	212	Hewlett-Packard Deskjet 6122 Color Inkjet Printer	Thomas Seio	24294	1951.3	200.97	15.59	Northwest Territories	Office Machines	0.36
\N	213	Dana Halogen Swing-Arm Architect Lamp	Bryan Mills	24387	51.9	40.97	14.45	Northwest Territories	Office Furnishings	0.57
\N	214	SAFCO PlanMaster Heigh-Adjustable Drafting Table Base, 43w x 30d x 30-37h, Black	Bryan Mills	24387	1418.36	349.45	60	Northwest Territories	Tables	\N
\N	215	Lexmark Z25 Color Inkjet Printer	Eugene Barchas	24515	121.48	80.97	33.6	Northwest Territories	Office Machines	0.37
\N	216	Hon Multipurpose Stacking Arm Chairs	Sylvia Foulston	24743	176.67	216.6	64.2	Northwest Territories	Chairs & Chairmats	0.59
\N	217	Hon Olson Stacker Stools	Sylvia Foulston	24743	753.61	140.81	24.49	Northwest Territories	Chairs & Chairmats	0.57
\N	218	Executive Impressions 14" Two-Color Numerals Wall Clock	Carl Ludwig	24871	75.3	22.72	8.99	Northwest Territories	Office Furnishings	0.44
\N	219	12-1/2 Diameter Round Wall Clock	Julia West	25318	-65.18	19.98	10.49	Northwest Territories	Office Furnishings	0.49
\N	220	Epson DFX5000+ Dot Matrix Printer	Don Jones	25377	-3755.03	1500.97	29.7	Northwest Territories	Office Machines	0.57
\N	221	Fellowes Basic 104-Key Keyboard, Platinum	Mike Pelletier	25634	28.99	20.95	4	Northwest Territories	Computer Peripherals	0.6
\N	222	Recycled Interoffice Envelopes with String and Button Closure, 10 x 13	Mike Pelletier	25634	185.32	23.99	6.71	Northwest Territories	Envelopes	0.35
\N	223	GBC Standard Therm-A-Bind Covers	Eugene Barchas	25733	-42.99	24.92	12.98	Northwest Territories	Binders and Binder Accessories	0.39
\N	224	80 Minute CD-R Spindle, 100/Pack - Staples	Ann Chong	25767	-59.2	39.48	1.99	Northwest Territories	Computer Peripherals	0.54
\N	225	Xerox 1892	Ann Chong	25767	108.01	38.76	13.26	Northwest Territories	Paper	0.36
\N	226	Staples Paper Clips	Charles McCrossin	26023	19.86	2.47	1.02	Northwest Territories	Rubber Bands	0.38
\N	227	Metal Folding Chairs, Beige, 4/Carton	Annie Cyprus	26051	-127.39	33.94	19.19	Northwest Territories	Chairs & Chairmats	0.58
\N	228	80 Minute Slim Jewel Case CD-R , 10/Pack - Staples	Annie Cyprus	26051	22.46	8.33	1.99	Northwest Territories	Computer Peripherals	0.52
\N	229	Computer Printout Paper with Letter-Trim Perforations	Carlos Soltero	26116	81.71	18.97	9.03	Northwest Territories	Paper	0.37
\N	230	Bush Mission Pointe Library	Doug Bickford	26182	-549.27	150.98	66.27	Northwest Territories	Bookcases	0.65
\N	231	Hon Olson Stacker Stools	Carlos Daly	26272	-4.19	140.81	24.49	Northwest Territories	Chairs & Chairmats	0.57
\N	232	Xerox 1929	Fred Wasserman	26370	52.02	22.84	5.47	Northwest Territories	Paper	0.39
\N	233	Home/Office Personal File Carts	Fred Wasserman	26370	63.83	34.76	5.49	Northwest Territories	Storage & Organization	0.6
\N	234	Avery 507	Sylvia Foulston	26499	8.78	2.88	0.5	Northwest Territories	Labels	0.39
\N	235	i470	Michelle Lonsdale	26531	1215.44	205.99	5.26	Northwest Territories	Telephones and Communication	0.56
\N	236	3M Organizer Strips	Sylvia Foulston	26567	-44.07	5.4	7.78	Northwest Territories	Binders and Binder Accessories	0.37
\N	237	Imation 3.5 IBM Diskettes, 10/Box	Sylvia Foulston	26567	-100.51	8.46	8.99	Northwest Territories	Computer Peripherals	0.79
\N	238	GE 4 Foot Flourescent Tube, 40 Watt	Sylvia Foulston	26567	-17.75	14.98	8.99	Northwest Territories	Office Furnishings	0.39
\N	239	300 Series Non-Flip	Sylvia Foulston	26567	1374.95	155.99	8.08	Northwest Territories	Telephones and Communication	0.6
\N	240	Executive Impressions 13" Chairman Wall Clock	Charlotte Melton	26854	-12.95	25.38	8.99	Northwest Territories	Office Furnishings	0.5
\N	241	Micro Innovations 104 Keyboard	Barry French	27109	-154.66	10.97	6.5	Northwest Territories	Computer Peripherals	0.64
\N	242	US Robotics 56K V.92 External Faxmodem	Heather Kirkland	27111	-127.56	99.99	19.99	Northwest Territories	Computer Peripherals	0.52
\N	243	Fellowes Staxonsteel® Drawer Files	Heather Kirkland	27111	282.18	193.17	19.99	Northwest Territories	Storage & Organization	0.71
\N	244	Accessory39	Heather Kirkland	27111	-96.34	20.99	3.3	Northwest Territories	Telephones and Communication	0.81
\N	245	Telescoping Adjustable Floor Lamp	Henry Goldwyn	27264	44.54	19.99	11.17	Northwest Territories	Office Furnishings	0.6
\N	246	Canon MP41DH Printing Calculator	Frank Price	27392	2509.52	150.98	13.99	Northwest Territories	Office Machines	0.38
\N	247	Sauder Facets Collection Locker/File Cabinet, Sky Alder Finish	Jim Radford	27553	1166.93	370.98	99	Northwest Territories	Storage & Organization	0.65
\N	248	VTech VT20-2481 2.4GHz Two-Line Phone System w/Answering Machine	Jim Radford	27553	297.11	179.99	13.99	Northwest Territories	Telephones and Communication	0.57
\N	249	Memo Book, 100 Message Capacity, 5 3/8” x 11”	Ralph Knight	27555	65.41	6.74	1.72	Northwest Territories	Paper	0.35
\N	250	Belkin 6 Outlet Metallic Surge Strip	Delfina Latchford	27680	-46.98	10.89	4.5	Northwest Territories	Appliances	0.59
\N	251	Xerox 21	Delfina Latchford	27680	-46.89	6.48	6.6	Northwest Territories	Paper	0.37
\N	252	GBC DocuBind TL200 Manual Binding Machine	Roy Skaria	27778	-105.14	223.98	15.01	Northwest Territories	Binders and Binder Accessories	0.38
\N	253	Sauder Forest Hills Library, Woodland Oak Finish	Roy Skaria	27778	-393.96	140.98	36.09	Northwest Territories	Bookcases	0.77
\N	254	Xerox 1940	Monica Federle	27909	-23.24	54.96	10.75	Northwest Territories	Paper	0.36
\N	255	Bagged Rubber Bands	Monica Federle	27909	-24.86	1.26	0.7	Northwest Territories	Rubber Bands	0.81
\N	256	Xerox 1897	Charles McCrossin	28003	-95.92	4.98	6.07	Northwest Territories	Paper	0.36
\N	257	Poly Designer Cover & Back	Don Miller	28035	89.56	18.99	5.23	Northwest Territories	Binders and Binder Accessories	0.37
\N	258	Bionaire Personal Warm Mist Humidifier/Vaporizer	Jeremy Lonsdale	28135	520.69	46.89	5.1	Northwest Territories	Appliances	0.46
\N	259	Acme® 8" Straight Scissors	Jeremy Lonsdale	28135	38.23	12.98	3.14	Northwest Territories	Scissors, Rulers and Trimmers	0.6
\N	260	Heavy-Duty E-Z-D® Binders	Grant Carroll	28165	-12.8	10.91	2.99	Northwest Territories	Binders and Binder Accessories	0.38
\N	261	Hammermill CopyPlus Copy Paper (20Lb. and 84 Bright)	Carl Ludwig	28289	-46.03	4.98	4.75	Northwest Territories	Paper	0.36
\N	262	Deluxe Rollaway Locking File with Drawer	Carlos Daly	28486	-517.47	415.88	11.37	Northwest Territories	Storage & Organization	0.57
\N	263	252	Ralph Knight	28675	4.39	65.99	5.92	Northwest Territories	Telephones and Communication	0.55
\N	264	6160	Cindy Schnelling	28870	822.4	115.99	2.5	Northwest Territories	Telephones and Communication	0.57
\N	265	Imation 3.5, DISKETTE 44766 HGHLD3.52HD/FM, 10/Pack	Claudia Miner	28871	-56.12	5.02	5.14	Northwest Territories	Computer Peripherals	0.79
\N	266	Prismacolor Color Pencil Set	Roy Skaria	29030	24.6	19.84	4.1	Northwest Territories	Pens & Art Supplies	0.44
\N	267	Wilson Jones DublLock® D-Ring Binders	Delfina Latchford	29095	54.46	6.75	2.99	Northwest Territories	Binders and Binder Accessories	0.35
\N	268	Binder Posts	Edward Hooks	29287	-106.4	5.74	5.01	Northwest Territories	Binders and Binder Accessories	0.39
\N	269	Epson LQ-570e Dot Matrix Printer	Edward Hooks	29287	2699.67	270.97	28.06	Northwest Territories	Office Machines	0.56
\N	270	Atlantic Metals Mobile 3-Shelf Bookcases, Custom Colors	Don Miller	29510	1292.44	260.98	41.91	Northwest Territories	Bookcases	0.59
\N	271	Fellowes PB300 Plastic Comb Binding Machine	Grant Carroll	29795	8793.54	387.99	19.99	Northwest Territories	Binders and Binder Accessories	0.38
\N	272	Rush Hierlooms Collection Rich Wood Bookcases	Grant Carroll	29795	813.83	160.98	35.02	Northwest Territories	Bookcases	0.72
\N	273	Avery 481	Brad Eason	29861	5.58	3.08	0.99	Northwest Territories	Labels	0.37
\N	274	Sharp AL-1530CS Digital Copier	Charles McCrossin	30658	6907.61	499.99	24.49	Northwest Territories	Copiers and Fax	0.36
\N	275	SAFCO Commercial Wire Shelving, Black	Charles McCrossin	30658	-942.5	138.14	35	Northwest Territories	Storage & Organization	\N
\N	276	Avery Trapezoid Extra Heavy Duty 4" Binders	Charles McCrossin	30947	261.24	41.94	2.99	Northwest Territories	Binders and Binder Accessories	0.35
\N	277	Self-Adhesive Address Labels for Typewriters by Universal	Charles McCrossin	30947	183.53	7.31	0.49	Northwest Territories	Labels	0.38
\N	278	StarTAC Series	Bryan Mills	31077	470.83	65.99	3.9	Northwest Territories	Telephones and Communication	0.55
\N	279	Rediform Wirebound "Phone Memo" Message Book, 11 x 5-3/4	Monica Federle	31111	-29.02	7.64	5.83	Northwest Territories	Paper	0.36
\N	280	Dana Halogen Swing-Arm Architect Lamp	Michelle Lonsdale	31169	109.88	40.97	14.45	Northwest Territories	Office Furnishings	0.57
\N	281	Global Comet™ Stacking Armless Chair	Michelle Lonsdale	31270	801.72	299.05	87.01	Northwest Territories	Chairs & Chairmats	0.57
\N	282	Hon 4070 Series Pagoda™ Armless Upholstered Stacking Chairs	Michelle Lonsdale	31270	-328.36	291.73	48.8	Northwest Territories	Chairs & Chairmats	0.56
\N	283	Fellowes Internet Keyboard, Platinum	Michelle Lonsdale	31270	-112.44	30.42	8.65	Northwest Territories	Computer Peripherals	0.74
\N	284	Deluxe Rollaway Locking File with Drawer	Beth Thompson	31364	-539.59	415.88	11.37	Northwest Territories	Storage & Organization	0.57
\N	285	Luxo Economy Swing Arm Lamp	Cindy Schnelling	31393	-27.31	19.94	14.87	Northwest Territories	Office Furnishings	0.57
\N	286	*Staples* vLetter Openers, 2/Pack	Cindy Schnelling	31393	-32.65	3.68	1.32	Northwest Territories	Scissors, Rulers and Trimmers	0.83
\N	287	Staples 6 Outlet Surge	Nicole Hansen	31492	-12.25	11.97	4.98	Northwest Territories	Appliances	0.58
\N	288	Acco Perma® 2700 Stacking Storage Drawers	Nicole Hansen	31492	-21.1	29.74	6.64	Northwest Territories	Storage & Organization	0.7
\N	289	Fellowes Stor/Drawer® Steel Plus™ Storage Drawers	Nicole Hansen	31492	-235.56	95.43	19.99	Northwest Territories	Storage & Organization	0.79
\N	290	Honeywell Enviracaire Portable HEPA Air Cleaner for 17' x 22' Room	Cari Schnelling	31558	900.06	300.65	24.49	Northwest Territories	Appliances	0.52
\N	291	Verbatim DVD-RAM, 9.4GB, Rewritable, Type 1, DS, DataLife Plus	Cari Schnelling	31558	455.37	45.19	1.99	Northwest Territories	Computer Peripherals	0.55
\N	292	Lock-Up Easel 'Spel-Binder'	Roy Skaria	31618	147.45	28.53	1.49	Northwest Territories	Binders and Binder Accessories	0.38
\N	293	Adams Write n' Stick Phone Message Book, 11" X 5 1/4", 200 Messages	Susan Vittorini	31684	23.48	5.68	1.46	Northwest Territories	Paper	0.39
\N	294	Tenex File Box, Personal Filing Tote with Lid, Black	Susan Vittorini	31684	-328.18	15.51	17.78	Northwest Territories	Storage & Organization	0.59
\N	295	Fellowes Black Plastic Comb Bindings	Sylvia Foulston	31781	-282.61	5.81	8.49	Northwest Territories	Binders and Binder Accessories	0.39
\N	296	Assorted Color Push Pins	Sylvia Foulston	31781	5.53	1.81	0.75	Northwest Territories	Rubber Bands	0.52
\N	297	HP Office Paper (20Lb. and 87 Bright)	Chad Cunningham	32193	-10.25	6.68	6.93	Northwest Territories	Paper	0.37
\N	298	Staples Vinyl Coated Paper Clips	Chad Cunningham	32193	37.33	3.93	0.99	Northwest Territories	Rubber Bands	0.39
\N	299	Canon MP41DH Printing Calculator	Carlos Daly	32229	44.37	150.98	13.99	Northwest Territories	Office Machines	0.38
\N	300	Newell 310	Carlos Daly	32229	-0.12	1.76	0.7	Northwest Territories	Pens & Art Supplies	0.56
\N	301	Kensington 7 Outlet MasterPiece Power Center	Grant Carroll	32743	1280.19	177.98	0.99	Northwest Territories	Appliances	0.56
\N	302	DAX Metal Frame, Desktop, Stepped-Edge	Julia West	32806	-28.34	20.24	8.99	Northwest Territories	Office Furnishings	0.46
\N	303	Bush Mission Pointe Library	Roy Skaria	33123	-996.67	150.98	66.27	Northwest Territories	Bookcases	0.65
\N	304	Accessory21	Cindy Schnelling	33159	-70.97	20.99	0.99	Northwest Territories	Telephones and Communication	0.37
\N	305	8860	Don Jones	33186	221.18	65.99	5.26	Northwest Territories	Telephones and Communication	0.56
\N	306	Array® Memo Cubes	Beth Thompson	33377	11.94	5.18	2.04	Northwest Territories	Paper	0.36
\N	307	Fiskars 8" Scissors, 2/Pack	Beth Thompson	33377	47.3	17.24	3.26	Northwest Territories	Scissors, Rulers and Trimmers	0.56
\N	308	12 Colored Short Pencils	Alan Barnes	33444	-17.68	2.6	2.4	Northwest Territories	Pens & Art Supplies	0.58
\N	309	Pizazz® Global Quick File™	Alan Barnes	33444	-30.48	14.97	7.51	Northwest Territories	Storage & Organization	0.57
\N	310	Imation 5.2GB DVD-RAM	Carl Ludwig	33703	-131.48	60.98	1.99	Northwest Territories	Computer Peripherals	0.5
\N	311	Acco Perma® 2700 Stacking Storage Drawers	Carl Ludwig	33703	56.26	29.74	6.64	Northwest Territories	Storage & Organization	0.7
\N	312	Portable Personal File Box	Carl Ludwig	33703	-8.47	12.21	4.81	Northwest Territories	Storage & Organization	0.58
\N	313	Snap-A-Way® Black Print Carbonless Speed Message, No Reply Area, Duplicate	Jamie Kunitz	33734	106.53	29.14	4.86	Northwest Territories	Paper	0.38
\N	314	Ibico Covers for Plastic or Wire Binding Elements	Heather Kirkland	33888	-44.92	11.5	7.19	Northwest Territories	Binders and Binder Accessories	0.4
\N	315	Hanging Personal Folder File	Heather Kirkland	33888	-35.08	15.7	11.25	Northwest Territories	Storage & Organization	0.6
\N	316	Tennsco Double-Tier Lockers	Heather Kirkland	33888	965.48	225.02	28.66	Northwest Territories	Storage & Organization	0.72
\N	317	Wirebound Message Books, Four 2 3/4" x 5" Forms per Page, 600 Sets per Book	Doug Bickford	33894	11.34	9.27	4.39	Northwest Territories	Paper	0.38
\N	318	Acme Design Line 8" Stainless Steel Bent Scissors w/Champagne Handles, 3-1/8" Cut	Doug Bickford	33894	-32.48	6.84	8.37	Northwest Territories	Scissors, Rulers and Trimmers	0.58
\N	319	Imation 3.5", DISKETTE 44766 HGHLD3.52HD/FM, 10/Pack	Doug Bickford	33894	-173.15	4.98	4.62	Northwest Territories	Computer Peripherals	0.64
\N	320	PC Concepts 116 Key Quantum 3000 Keyboard	Doug Bickford	33894	-119.02	32.98	5.5	Northwest Territories	Computer Peripherals	0.75
\N	321	Epson Stylus 1520 Color Inkjet Printer	Carlos Daly	33922	5353.19	500.97	69.3	Northwest Territories	Office Machines	0.37
\N	322	Avery 494	Toby Braunhardt	34177	9.47	2.61	0.5	Northwest Territories	Labels	0.39
\N	323	Self-Adhesive Address Labels for Typewriters by Universal	Toby Braunhardt	34177	73.18	7.31	0.49	Northwest Territories	Labels	0.38
\N	324	Accessory37	Toby Braunhardt	34177	-83.95	20.99	2.5	Northwest Territories	Telephones and Communication	0.81
\N	325	Wilson Jones 14 Line Acrylic Coated Pressboard Data Binders	Cari Schnelling	34215	-5.92	5.34	2.99	Northwest Territories	Binders and Binder Accessories	0.38
\N	326	Eureka Disposable Bags for Sanitaire® Vibra Groomer I® Upright Vac	Thomas Seio	34246	-257.11	4.06	6.89	Northwest Territories	Appliances	0.6
\N	327	AT&T 2230 Dual Handset Phone With Caller ID/Call Waiting	Thomas Seio	34246	192.33	99.99	19.99	Northwest Territories	Office Machines	0.52
\N	328	Peel & Seel® Recycled Catalog Envelopes, Brown	Thomas Seio	34246	1.91	11.58	6.97	Northwest Territories	Envelopes	0.35
\N	329	Cardinal Poly Pocket Divider Pockets for Ring Binders	Brendan Dodson	34631	-22.28	3.36	6.27	Northwest Territories	Binders and Binder Accessories	0.4
\N	330	Canon PC1060 Personal Laser Copier	Brendan Dodson	34631	2808.22	699.99	24.49	Northwest Territories	Copiers and Fax	0.41
\N	331	Sterling Rubber Bands by Alliance	Charlotte Melton	35047	-7.06	4.71	0.7	Northwest Territories	Rubber Bands	0.85
\N	332	Newell 312	Beth Thompson	35266	33.5	5.84	1.2	Northwest Territories	Pens & Art Supplies	0.55
\N	333	BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	Beth Thompson	35266	-998.94	218.75	69.64	Northwest Territories	Tables	0.77
\N	334	Imation 3.5" DS/HD IBM Formatted Diskettes, 50/Pack	Eugene Barchas	35847	-144.27	15.98	8.99	Northwest Territories	Computer Peripherals	0.64
\N	335	Avery Flip-Chart Easel Binder, Black	Michelle Lonsdale	36001	-78.36	22.38	15.1	Northwest Territories	Binders and Binder Accessories	0.38
\N	336	GBC Binding covers	Michelle Lonsdale	36001	51.82	12.95	4.98	Northwest Territories	Binders and Binder Accessories	0.4
\N	337	R280	Grant Carroll	36134	-413.33	155.99	8.99	Northwest Territories	Telephones and Communication	0.55
\N	338	Accessory9	Beth Paige	36135	381.17	35.99	3.3	Northwest Territories	Telephones and Communication	0.39
\N	339	U.S. Robotics 56K Internet Call Modem	Dorothy Wardle	36644	218.72	99.99	19.99	Northwest Territories	Computer Peripherals	0.5
\N	340	Tennsco Industrial Shelving	Muhammed MacIntyre	36646	-743.96	48.91	35	Northwest Territories	Storage & Organization	0.83
\N	341	Staples Bulldog Clip	Charlotte Melton	36707	71.56	3.78	0.71	Northwest Territories	Rubber Bands	0.39
\N	342	Micro Innovations Micro 3000 Keyboard, Black	Muhammed MacIntyre	37253	-99.55	26.31	5.89	Northwest Territories	Computer Peripherals	0.75
\N	343	Fellowes Basic 104-Key Keyboard, Platinum	Claudia Miner	37541	-70.68	20.95	5.99	Northwest Territories	Computer Peripherals	0.65
\N	344	Xerox 1882	Claudia Miner	37541	98.32	55.98	13.88	Northwest Territories	Paper	0.36
\N	345	Carina Double Wide Media Storage Towers in Natural & Black	Claudia Miner	37541	-599.54	80.98	35	Northwest Territories	Storage & Organization	0.81
\N	346	Portable Personal File Box	Brendan Dodson	37634	-36.78	12.21	4.81	Northwest Territories	Storage & Organization	0.58
\N	347	Acme Hot Forged Carbon Steel Scissors with Nickel-Plated Handles, 3 7/8" Cut, 8"L	Dorothy Wardle	37793	-49.31	13.9	7.59	Northwest Territories	Scissors, Rulers and Trimmers	0.56
\N	348	Eldon Cleatmat® Chair Mats for Medium Pile Carpets	Mike Pelletier	37860	-98.31	55.5	52.2	Northwest Territories	Office Furnishings	0.72
\N	349	Xerox 4200 Series MultiUse Premium Copy Paper (20Lb. and 84 Bright)	Edward Hooks	38884	-119.84	5.28	5.66	Northwest Territories	Paper	0.4
\N	350	Hon 94000 Series Round Tables	Edward Hooks	38884	-98.05	296.18	54.12	Northwest Territories	Tables	0.76
\N	351	Deflect-o RollaMat Studded, Beveled Mat for Medium Pile Carpeting	Jamie Kunitz	39364	-1.33	92.23	39.61	Northwest Territories	Office Furnishings	0.67
\N	352	Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind	Jamie Kunitz	39364	8417.57	1270.99	19.99	Northwest Territories	Binders and Binder Accessories	0.35
\N	353	Global High-Back Leather Tilter, Burgundy	Julia West	39457	-1975.26	122.99	70.2	Northwest Territories	Chairs & Chairmats	0.74
\N	354	Poly Designer Cover & Back	Jeremy Lonsdale	39683	168	18.99	5.23	Northwest Territories	Binders and Binder Accessories	0.37
\N	355	Lifetime Advantage™ Folding Chairs, 4/Carton	Jeremy Lonsdale	39683	2113.95	218.08	18.06	Northwest Territories	Chairs & Chairmats	0.57
\N	356	DAX Contemporary Wood Frame with Silver Metal Mat, Desktop, 11 x 14 Size	Jeremy Lonsdale	39683	66.97	20.24	6.67	Northwest Territories	Office Furnishings	0.49
\N	357	Stockwell Push Pins	Jeremy Lonsdale	39683	6.37	2.18	0.78	Northwest Territories	Rubber Bands	0.52
\N	358	Imation 3.5", DISKETTE 44766 HGHLD3.52HD/FM, 10/Pack	Cindy Schnelling	39846	-62.73	4.98	4.62	Northwest Territories	Computer Peripherals	0.64
\N	359	8260	Heather Kirkland	40036	-147.36	65.99	8.99	Northwest Territories	Telephones and Communication	0.58
\N	360	3390	Alan Barnes	40067	519.25	65.99	5.31	Northwest Territories	Telephones and Communication	0.57
\N	361	Global Deluxe Stacking Chair, Gray	Hunter Glantz	40132	149.83	50.98	14.19	Northwest Territories	Chairs & Chairmats	0.56
\N	362	Bevis 36 x 72 Conference Tables	Hunter Glantz	40132	-219.38	124.49	51.94	Northwest Territories	Tables	0.63
\N	363	Avery Flip-Chart Easel Binder, Black	Hunter Glantz	40132	-86.2	22.38	15.1	Northwest Territories	Binders and Binder Accessories	0.38
\N	364	Howard Miller 16" Diameter Gallery Wall Clock	Julia West	40160	202.87	63.94	14.48	Northwest Territories	Office Furnishings	0.46
\N	365	ACCOHIDE® 3-Ring Binder, Blue, 1"	Carlos Daly	40518	-12.16	4.13	5.04	Northwest Territories	Binders and Binder Accessories	0.38
\N	366	Global High-Back Leather Tilter, Burgundy	Barry French	40804	-1775.83	122.99	70.2	Northwest Territories	Chairs & Chairmats	0.74
\N	367	Wilson Jones Hanging View Binder, White, 1"	Susan Vittorini	40902	-48.88	7.1	6.05	Northwest Territories	Binders and Binder Accessories	0.39
\N	368	Boston 1730 StandUp Electric Pencil Sharpener	Carl Jackson	41063	-34.09	21.38	8.99	Northwest Territories	Pens & Art Supplies	0.59
\N	369	Accessory31	Carl Jackson	41063	42.27	35.99	0.99	Northwest Territories	Telephones and Communication	0.35
\N	370	Accessory8	Carl Jackson	41063	822.89	85.99	1.25	Northwest Territories	Telephones and Communication	0.39
\N	371	Fellowes 17-key keypad for PS/2 interface	Alan Barnes	41153	-45.1	30.73	4	Northwest Territories	Computer Peripherals	0.75
\N	372	Hanging Personal Folder File	Charlotte Melton	41184	-56.06	15.7	11.25	Northwest Territories	Storage & Organization	0.6
\N	373	Ibico Covers for Plastic or Wire Binding Elements	Beth Thompson	41409	-18.25	11.5	7.19	Northwest Territories	Binders and Binder Accessories	0.4
\N	374	Hoover Portapower™ Portable Vacuum	Bryan Mills	41696	-2088.68	4.48	49	Northwest Territories	Appliances	0.6
\N	375	Fellowes Command Center 5-outlet power strip	Alan Barnes	42209	-12.82	67.84	0.99	Northwest Territories	Appliances	0.58
\N	376	SAFCO Arco Folding Chair	Alan Barnes	42209	2795.36	276.2	24.49	Northwest Territories	Chairs & Chairmats	\N
\N	377	Accessory12	Beth Paige	42561	298.48	85.99	2.5	Northwest Territories	Telephones and Communication	0.35
\N	378	Global Leather Highback Executive Chair with Pneumatic Height Adjustment, Black	Mike Pelletier	42564	2155.41	200.98	23.76	Northwest Territories	Chairs & Chairmats	0.58
\N	379	3390	Delfina Latchford	42695	-10.3	65.99	5.31	Northwest Territories	Telephones and Communication	0.57
\N	380	GBC DocuBind TL300 Electric Binding System	Susan Vittorini	42981	232.44	896.99	19.99	Northwest Territories	Binders and Binder Accessories	0.38
\N	381	GBC Prepunched Paper, 19-Hole, for Binding Systems, 24-lb	Dorothy Wardle	43109	-21.85	15.01	8.4	Northwest Territories	Binders and Binder Accessories	0.39
\N	382	Microsoft Internet Keyboard	Dorothy Wardle	43109	-145.78	20.97	6.5	Northwest Territories	Computer Peripherals	0.78
\N	383	TDK 4.7GB DVD-R	Dorothy Wardle	43109	-3.96	10.01	1.99	Northwest Territories	Computer Peripherals	0.41
\N	384	Xerox 1977	Susan Vittorini	43203	-33.69	6.68	5.2	Northwest Territories	Paper	0.37
\N	385	DAX Solid Wood Frames	Jamie Kunitz	43236	10.68	9.77	6.02	Northwest Territories	Office Furnishings	0.48
\N	386	Honeywell Enviracaire® Portable Air Cleaner for up to 8 x 10 Room	Fred Wasserman	43267	171.26	76.72	19.95	Northwest Territories	Appliances	0.54
\N	387	Belkin 8 Outlet SurgeMaster II Gold Surge Protector	Doug Bickford	43329	752.37	59.98	3.99	Northwest Territories	Appliances	0.57
\N	388	8260	Fred Wasserman	43330	337.04	65.99	8.99	Northwest Territories	Telephones and Communication	0.58
\N	389	Recycled Interoffice Envelopes with String and Button Closure, 10 x 13	Susan Vittorini	43364	158.98	23.99	6.71	Northwest Territories	Envelopes	0.35
\N	390	Multimedia Mailers	Doug Bickford	43392	2969.81	162.93	19.99	Northwest Territories	Envelopes	0.39
\N	391	White Business Envelopes with Contemporary Seam, Recycled White Business Envelopes	Claudia Miner	43781	240.41	10.94	1.39	Northwest Territories	Envelopes	0.35
\N	392	Avery Trapezoid Ring Binder, 3" Capacity, Black, 1040 sheets	Claudia Miner	43781	393.41	40.98	2.99	Northwest Territories	Binders and Binder Accessories	0.36
\N	393	DXL™ Angle-View Binders with Locking Rings, Black	Frank Price	44071	-43.75	5.99	4.92	Northwest Territories	Binders and Binder Accessories	0.38
\N	394	8260	Frank Price	44071	83.84	65.99	8.99	Northwest Territories	Telephones and Communication	0.58
\N	395	Newell® 3-Hole Punched Plastic Slotted Magazine Holders for Binders	Dorothy Wardle	44519	-144.76	4.57	5.42	Northwest Territories	Binders and Binder Accessories	0.37
\N	396	Laser & Ink Jet Business Envelopes	Dorothy Wardle	44519	155.69	10.67	1.39	Northwest Territories	Envelopes	0.39
\N	397	Okidata ML390 Turbo Dot Matrix Printers	Dorothy Wardle	44519	5386.32	442.14	14.7	Northwest Territories	Office Machines	0.56
\N	398	Eldon Regeneration Recycled Desk Accessories, Smoke	Allen Rosenblatt	44708	-37.39	1.74	4.08	Northwest Territories	Office Furnishings	0.53
\N	399	Accessory36	Dorothy Wardle	44772	-232.99	55.99	5	Northwest Territories	Telephones and Communication	0.83
\N	400	Linden® 12" Wall Clock With Oak Frame	Julia West	44839	-246.3	33.98	19.99	Northwest Territories	Office Furnishings	0.55
\N	401	2160i	Ralph Knight	45217	1864.66	200.99	4.2	Northwest Territories	Telephones and Communication	0.59
\N	402	Global Deluxe High-Back Office Chair in Storm	Michelle Lonsdale	45440	-183.6	135.99	28.63	Northwest Territories	Chairs & Chairmats	0.76
\N	403	Howard Miller 16" Diameter Gallery Wall Clock	Charlotte Melton	45766	1026.07	63.94	14.48	Northwest Territories	Office Furnishings	0.46
\N	404	Canon MP100DHII Printing Calculator	Charlotte Melton	45766	1765.48	140.99	13.99	Northwest Territories	Office Machines	0.37
\N	405	Accessory21	Allen Rosenblatt	45861	319.1	20.99	0.99	Northwest Territories	Telephones and Communication	0.37
\N	406	Verbatim DVD-R 4.7GB authoring disc	Neola Schneider	45957	162.83	39.24	1.99	Northwest Territories	Computer Peripherals	0.51
\N	407	Rediform Wirebound "Phone Memo" Message Book, 11 x 5-3/4	Neola Schneider	45957	-30.92	7.64	5.83	Northwest Territories	Paper	0.36
\N	408	C-Line Cubicle Keepers Polyproplyene Holder w/Velcro® Back, 8-1/2x11, 25/Bx	Joy Bell	46912	181.53	54.74	14.83	Northwest Territories	Office Furnishings	0.54
\N	409	Avery 51	Monica Federle	46980	103.16	6.3	0.5	Northwest Territories	Labels	0.39
\N	410	SANFORD Liquid Accent™ Tank-Style Highlighters	Jamie Kunitz	47460	-3.64	2.84	0.93	Northwest Territories	Pens & Art Supplies	0.54
\N	411	Avery Poly Binder Pockets	Susan Vittorini	47462	-166.92	3.58	5.47	Northwest Territories	Binders and Binder Accessories	0.37
\N	412	Dixon My First Ticonderoga Pencil, #2	Susan Vittorini	47462	-1.22	5.85	2.27	Northwest Territories	Pens & Art Supplies	0.56
\N	413	Acco® Hot Clips™ Clips to Go	Susan Vittorini	47462	21.62	3.29	1.35	Northwest Territories	Rubber Bands	0.4
\N	414	Fiskars® Softgrip Scissors	Charles McCrossin	47620	20.27	10.98	3.37	Northwest Territories	Scissors, Rulers and Trimmers	0.57
\N	415	Elite 5" Scissors	Cari Schnelling	47749	-188.53	8.45	7.77	Northwest Territories	Scissors, Rulers and Trimmers	0.55
\N	416	Eldon Wave Desk Accessories	Doug Bickford	47873	-17.38	5.89	5.57	Northwest Territories	Office Furnishings	0.41
\N	417	Avery 478	Don Miller	47943	24.06	4.91	0.5	Northwest Territories	Labels	0.36
\N	418	Boston 16701 Slimline Battery Pencil Sharpener	Don Miller	47943	63.46	15.94	5.45	Northwest Territories	Pens & Art Supplies	0.55
\N	419	Xerox 1982	Fred Wasserman	48101	-39.92	22.84	16.87	Northwest Territories	Paper	0.39
\N	420	Soundgear Copyboard Conference Phone, Optional Battery	Bryan Mills	48295	4938.78	204.1	13.99	Northwest Territories	Office Machines	0.37
\N	421	Dot Matrix Printer Tape Reel Labels, White, 5000/Box	Carlos Daly	48839	-37.06	98.31	0.49	Northwest Territories	Labels	0.36
\N	422	Euro Pro Shark Stick Mini Vacuum	Joy Bell	49154	-807.89	60.98	49	Northwest Territories	Appliances	0.59
\N	423	Panasonic KX-P1150 Dot Matrix Printer	Claudia Miner	49921	-280.28	145.45	17.85	Northwest Territories	Office Machines	0.56
\N	424	Recycled Eldon Regeneration Jumbo File	Claudia Miner	49921	-7.26	12.28	6.13	Northwest Territories	Storage & Organization	0.57
\N	425	Tenex Contemporary Contur Chairmats for Low and Medium Pile Carpet, Computer, 39" x 49"	Beth Thompson	49952	630.28	107.53	5.81	Northwest Territories	Office Furnishings	0.65
\N	426	Avery 498	Allen Rosenblatt	50117	14.49	2.89	0.5	Northwest Territories	Labels	0.38
\N	427	Premium Transparent Presentation Covers by GBC	Beth Thompson	50278	-27.53	20.98	8.83	Northwest Territories	Binders and Binder Accessories	0.37
\N	428	Barricks 18" x 48" Non-Folding Utility Table with Bottom Storage Shelf	Beth Thompson	50278	-355.94	100.8	60	Northwest Territories	Tables	0.59
\N	429	GBC VeloBinder Electric Binding Machine	Susan Vittorini	50374	1443.35	120.98	9.07	Northwest Territories	Binders and Binder Accessories	0.35
\N	430	Brown Kraft Recycled Envelopes	Sylvia Foulston	50565	-138.82	16.98	12.39	Northwest Territories	Envelopes	0.35
\N	431	Acme® 8" Straight Scissors	Joy Bell	50688	27.86	12.98	3.14	Northwest Territories	Scissors, Rulers and Trimmers	0.6
\N	432	Bell Sonecor JB700 Caller ID	Becky Castell	50754	-58.34	7.99	5.03	Northwest Territories	Telephones and Communication	0.6
\N	433	A1228	Carlos Daly	50914	2763.13	195.99	8.99	Northwest Territories	Telephones and Communication	0.58
\N	434	3M Polarizing Task Lamp with Clamp Arm, Light Gray	Cari Schnelling	51169	-192.92	136.98	24.49	Northwest Territories	Office Furnishings	0.59
\N	435	8290	Jim Radford	51938	-488.31	125.99	5.63	Northwest Territories	Telephones and Communication	0.6
\N	436	Hewlett-Packard Deskjet 5550 Color Inkjet Printer	Allen Rosenblatt	51970	-343.47	115.99	56.14	Northwest Territories	Office Machines	0.4
\N	437	Fellowes Neat Ideas® Storage Cubes	Dorothy Badders	51971	-1129.96	32.48	35	Northwest Territories	Storage & Organization	0.81
\N	438	Lesro Round Back Collection Coffee Table, End Table	Dorothy Badders	51971	-803.52	182.55	69	Northwest Territories	Tables	0.72
\N	439	Avery 492	Mike Pelletier	52193	10.51	2.88	0.5	Northwest Territories	Labels	0.39
\N	440	Newell 343	Mike Pelletier	52193	6.04	2.94	0.96	Northwest Territories	Pens & Art Supplies	0.58
\N	441	Recycled Eldon Regeneration Jumbo File	Doug Bickford	52321	-37.52	12.28	6.13	Northwest Territories	Storage & Organization	0.57
\N	442	SAFCO PlanMaster Heigh-Adjustable Drafting Table Base, 43w x 30d x 30-37h, Black	Doug Bickford	52321	5626.42	349.45	60	Northwest Territories	Tables	\N
\N	443	Canon S750 Color Inkjet Printer	Susan Vittorini	52386	-188.58	120.97	26.3	Northwest Territories	Office Machines	0.38
\N	444	Panasonic KP-310 Heavy-Duty Electric Pencil Sharpener	Andrew Gjertsen	52807	204.74	21.98	2.87	Northwest Territories	Pens & Art Supplies	0.55
\N	445	AT&T Black Trimline Phone, Model 210	Muhammed MacIntyre	52929	-90.14	15.99	9.4	Northwest Territories	Office Machines	0.49
\N	446	Newell 318	Muhammed MacIntyre	52929	-6.53	2.78	1.25	Northwest Territories	Pens & Art Supplies	0.59
\N	447	Staples Pen Style Liquid Stix; Assorted (yellow, pink, green, blue, orange), 5/Pack	Muhammed MacIntyre	52929	7.34	6.47	1.22	Northwest Territories	Pens & Art Supplies	0.4
\N	448	Staples Vinyl Coated Paper Clips	Muhammed MacIntyre	52929	19.68	3.93	0.99	Northwest Territories	Rubber Bands	0.39
\N	449	3M Polarizing Task Lamp with Clamp Arm, Light Gray	Jim Radford	52964	828.27	136.98	24.49	Northwest Territories	Office Furnishings	0.59
\N	450	Avery 491	Bryan Davis	53156	56.44	4.13	0.99	Northwest Territories	Labels	0.39
\N	451	Fellowes Black Plastic Comb Bindings	Anthony Johnson	53511	-243.24	5.81	8.49	Northwest Territories	Binders and Binder Accessories	0.39
\N	452	Eldon Expressions™ Desk Accessory, Wood Pencil Holder, Oak	Anthony Johnson	53511	-53.62	9.65	6.22	Northwest Territories	Office Furnishings	0.55
\N	453	O'Sullivan 3-Shelf Heavy-Duty Bookcases	Doug Bickford	53797	-213.32	58.14	36.61	Northwest Territories	Bookcases	0.61
\N	454	T18	Carlos Daly	53990	1411.03	110.99	2.5	Northwest Territories	Telephones and Communication	0.57
\N	455	Sanyo 2.5 Cubic Foot Mid-Size Office Refrigerators	Don Miller	54083	258.01	279.81	23.19	Northwest Territories	Appliances	0.59
\N	456	Honeywell Quietcare HEPA Air Cleaner	Don Jones	54274	328	78.65	13.99	Northwest Territories	Appliances	0.52
\N	457	Staples Colored Bar Computer Paper	Chad Cunningham	54276	299.59	35.44	4.92	Northwest Territories	Paper	0.38
\N	458	Boston 16765 Mini Stand Up Battery Pencil Sharpener	Ralph Arnett	54528	-85.91	11.66	8.99	Northwest Territories	Pens & Art Supplies	0.59
\N	459	Staples Battery-Operated Desktop Pencil Sharpener	Ralph Arnett	54528	-6.38	10.48	2.89	Northwest Territories	Pens & Art Supplies	0.6
\N	460	Eldon® 200 Class™ Desk Accessories	Nicole Hansen	54567	-61.59	6.28	5.41	Northwest Territories	Office Furnishings	0.53
\N	461	Memorex 80 Minute CD-R, 30/Pack	Fred Wasserman	54628	115.54	22.98	1.99	Northwest Territories	Computer Peripherals	0.46
\N	462	Global Leather and Oak Executive Chair, Black	Bryan Mills	55298	-165.6	300.98	64.73	Northwest Territories	Chairs & Chairmats	0.56
\N	463	Dual Level, Single-Width Filing Carts	Ralph Arnett	55363	542.16	155.06	7.07	Northwest Territories	Storage & Organization	0.59
\N	464	Fellowes Smart Design 104-Key Enhanced Keyboard, PS/2 Adapter, Platinum	Doug Bickford	55366	-204.65	55.94	6.55	Northwest Territories	Computer Peripherals	0.68
\N	465	Wilson Jones 1" Hanging DublLock® Ring Binders	Eugene Barchas	55715	16.65	5.28	2.99	Northwest Territories	Binders and Binder Accessories	0.37
\N	466	Master Giant Foot® Doorstop, Safety Yellow	Brad Eason	55875	39.29	7.59	4	Northwest Territories	Office Furnishings	0.42
\N	467	Perma STOR-ALL™ Hanging File Box, 13 1/8"W x 12 1/4"D x 10 1/2"H	Brad Eason	55875	-104.96	5.98	4.69	Northwest Territories	Storage & Organization	0.68
\N	468	Epson DFX-8500 Dot Matrix Printer	Dorothy Wardle	56453	-5572.39	2550.14	29.7	Northwest Territories	Office Machines	0.57
\N	469	Xerox 194	Ralph Knight	57127	171.82	55.48	14.3	Northwest Territories	Paper	0.37
\N	470	SouthWestern Bell FA970 Digital Answering Machine with Time/Day Stamp	Sylvia Foulston	57344	-71.03	28.99	8.59	Northwest Territories	Telephones and Communication	0.56
\N	471	Avery 493	Neola Schneider	57509	101.13	4.91	0.5	Northwest Territories	Labels	0.36
\N	472	Bevis Round Bullnose 29" High Table Top	Neola Schneider	57509	-202.58	259.71	66.67	Northwest Territories	Tables	0.61
\N	473	GBC Recycled Regency Composition Covers	Grant Carroll	57600	584.15	59.78	10.29	Northwest Territories	Binders and Binder Accessories	0.39
\N	474	Avery 506	Grant Carroll	57600	85.81	4.13	0.5	Prince Edward Island	Labels	0.39
\N	475	Xerox 197	Grant Carroll	57600	-8.42	30.98	17.08	Prince Edward Island	Paper	0.4
\N	476	Eldon® Expressions™ Wood Desk Accessories, Oak	Julia West	58055	-56.45	7.38	5.21	Prince Edward Island	Office Furnishings	0.56
\N	477	Xerox 1935	Muhammed MacIntyre	58144	257.32	26.38	5.86	Prince Edward Island	Paper	0.39
\N	478	Peel & Stick Add-On Corner Pockets	Susan Vittorini	58150	-119.62	2.16	6.05	Prince Edward Island	Binders and Binder Accessories	0.37
\N	479	Eureka The Boss® Cordless Rechargeable Stick Vac	Sylvia Foulston	58340	278.12	50.98	13.66	Prince Edward Island	Appliances	0.58
\N	480	Eldon® Wave Desk Accessories	Doug Bickford	58368	-4.43	2.08	5.33	Prince Edward Island	Office Furnishings	0.43
\N	481	Xerox 1905	Doug Bickford	58368	-206.46	6.48	9.54	Prince Edward Island	Paper	0.37
\N	482	Fellowes Bankers Box™ Staxonsteel® Drawer File/Stacking System	Doug Bickford	58368	-76.11	64.98	6.88	Prince Edward Island	Storage & Organization	0.73
\N	483	Executive Impressions 13" Clairmont Wall Clock	Dorothy Badders	58434	268.32	19.23	6.15	Prince Edward Island	Office Furnishings	0.44
\N	484	Global Leather and Oak Executive Chair, Black	Henry Goldwyn	58626	673.77	300.98	64.73	Prince Edward Island	Chairs & Chairmats	0.56
\N	485	Global Troy™ Executive Leather Low-Back Tilter	Henry Goldwyn	58626	2608.72	500.98	26	Prince Edward Island	Chairs & Chairmats	0.6
\N	486	Verbatim DVD-RAM, 9.4GB, Rewritable, Type 1, DS, DataLife Plus	Henry Goldwyn	58626	171.59	45.19	1.99	Prince Edward Island	Computer Peripherals	0.55
\N	487	Staples SlimLine Pencil Sharpener	Grant Carroll	58688	-41.87	11.97	5.81	Prince Edward Island	Pens & Art Supplies	0.6
\N	488	Presstex Flexible Ring Binders	Chad Cunningham	59045	32.87	4.55	1.49	Prince Edward Island	Binders and Binder Accessories	0.35
\N	489	Memorex 4.7GB DVD+RW, 3/Pack	Beth Thompson	59047	19.2	28.48	1.99	Prince Edward Island	Computer Peripherals	0.4
\N	490	Eldon Image Series Black Desk Accessories	Beth Thompson	59047	-93.93	4.14	6.6	Prince Edward Island	Office Furnishings	0.49
\N	491	Avery 485	Andrew Gjertsen	59202	21.92	12.53	0.5	Prince Edward Island	Labels	0.38
\N	492	Dixon My First Ticonderoga Pencil, #2	Andrew Gjertsen	59202	7.45	5.85	2.27	Prince Edward Island	Pens & Art Supplies	0.56
\N	493	Global Adaptabilities™ Conference Tables	Sylvia Foulston	59207	-945.56	280.98	81.98	Prince Edward Island	Tables	0.78
\N	494	Kensington 7 Outlet MasterPiece Power Center	Michelle Lonsdale	59234	2109.21	177.98	0.99	Prince Edward Island	Appliances	0.56
\N	495	Global Deluxe Stacking Chair, Gray	Michelle Lonsdale	59234	11.46	50.98	14.19	Prince Edward Island	Chairs & Chairmats	0.56
\N	496	Xerox 1885	Cari Schnelling	59395	367.12	48.04	7.23	Prince Edward Island	Paper	0.37
\N	497	Avery 479	Henry Goldwyn	59558	37.73	2.61	0.5	Prince Edward Island	Labels	0.39
\N	498	AT&T Black Trimline Phone, Model 210	Edward Hooks	59585	-110.93	15.99	9.4	Prince Edward Island	Office Machines	0.49
\N	499	Fellowes Twister Kit, Gray/Clear, 3/pkg	Brendan Dodson	59651	-196.06	8.04	8.94	Prince Edward Island	Binders and Binder Accessories	0.4
\N	500	Eldon Pizzaz™ Desk Accessories	Brendan Dodson	59651	-52.92	2.23	4.57	Prince Edward Island	Office Furnishings	0.41
\N	501	GBC Binding covers	Harold Engle	645	89.45	12.95	4.98	Prince Edward Island	Binders and Binder Accessories	0.4
\N	502	Hewlett-Packard Deskjet 5550 Color Inkjet Printer	Roy French	769	4.15	115.99	56.14	Prince Edward Island	Office Machines	0.4
\N	503	Talkabout T8367	Helen Abelman	773	324.93	65.99	8.99	Prince Edward Island	Telephones and Communication	0.56
\N	504	Logitech Access Keyboard	Guy Armstrong	1187	20.21	15.98	4	Prince Edward Island	Computer Peripherals	0.37
\N	505	Fellowes Strictly Business® Drawer File, Letter/Legal Size	Jennifer Braxton	2339	-120.45	140.85	19.99	Prince Edward Island	Storage & Organization	0.73
\N	506	Newell 336	Giulietta Baptist	3521	28.71	4.28	0.94	Prince Edward Island	Pens & Art Supplies	0.56
\N	507	Conquest™ 14 Commercial Heavy-Duty Upright Vacuum, Collection System, Accessory Kit	Jack Lebron	4007	112.36	56.96	13.22	Prince Edward Island	Appliances	0.56
\N	508	Tennsco Snap-Together Open Shelving Units, Starter Sets and Add-On Units	Jack Lebron	4007	-232.24	279.48	35	Prince Edward Island	Storage & Organization	0.8
\N	509	GBC DocuBind P100 Manual Binding Machine	Erica Bern	4416	2665.4	165.98	19.99	Prince Edward Island	Binders and Binder Accessories	0.4
\N	510	Avery 497	Erica Bern	4454	21.42	3.08	0.5	Prince Edward Island	Labels	0.37
\N	511	SAFCO Folding Chair Trolley	Helen Abelman	5153	1467.82	128.24	12.65	Prince Edward Island	Chairs & Chairmats	\N
\N	512	Manila Recycled Extra-Heavyweight Clasp Envelopes, 6" x 9"	Guy Armstrong	5446	44.1	10.98	4.8	Prince Edward Island	Envelopes	0.36
\N	513	Verbatim DVD-RAM, 5.2GB, Rewritable, Type 1, DS	Helen Abelman	8131	191.29	29.89	1.99	Prince Edward Island	Computer Peripherals	0.5
\N	514	Keytronic Designer 104- Key Black Keyboard	Christopher Schild	8994	-580.32	40.48	19.99	Prince Edward Island	Computer Peripherals	0.77
\N	515	Accessory31	Roy French	9027	458.98	35.99	0.99	Prince Edward Island	Telephones and Communication	0.35
\N	516	Avanti 4.4 Cu. Ft. Refrigerator	Roy French	9216	-86.68	180.98	55.24	Prince Edward Island	Appliances	0.57
\N	517	Bush Mission Pointe Library	Jennifer Braxton	9537	-382.38	150.98	66.27	Prince Edward Island	Bookcases	0.65
\N	518	Acco Pressboard Covers with Storage Hooks, 14 7/8" x 11", Dark Blue	Jennifer Braxton	9537	-149.09	3.81	5.44	Prince Edward Island	Binders and Binder Accessories	0.36
\N	519	Ibico Covers for Plastic or Wire Binding Elements	Joy Smith	9574	-68.98	11.5	7.19	Prince Edward Island	Binders and Binder Accessories	0.4
\N	520	Boston KS Multi-Size Manual Pencil Sharpener	Evan Minnotte	10435	-14.31	22.99	8.99	Prince Edward Island	Pens & Art Supplies	0.57
\N	521	Hunt BOSTON® Vista® Battery-Operated Pencil Sharpener, Black	Evan Minnotte	10435	-162.24	11.66	7.95	Prince Edward Island	Pens & Art Supplies	0.58
\N	522	Martin-Yale Premier Letter Opener	Jenna Caffey	10851	-175.13	12.88	4.59	Prince Edward Island	Scissors, Rulers and Trimmers	0.82
\N	523	Recycled Premium Regency Composition Covers	Harold Engle	10852	-27.26	15.28	10.91	Prince Edward Island	Binders and Binder Accessories	0.36
\N	524	Atlantic Metals Mobile 5-Shelf Bookcases, Custom Colors	Harold Engle	10852	3030.16	300.98	54.92	Prince Edward Island	Bookcases	0.55
\N	525	i1000	Harold Engle	11269	354.96	65.99	5.99	Prince Edward Island	Telephones and Communication	0.58
\N	526	Avery 493	Harold Engle	11269	112.35	4.91	0.5	Prince Edward Island	Labels	0.36
\N	527	Fellowes Super Stor/Drawer®	Harold Engle	11269	-19.32	27.75	19.99	Prince Edward Island	Storage & Organization	0.67
\N	528	Rubbermaid ClusterMat Chairmats, Mat Size- 66" x 60", Lip 20" x 11" -90 Degree Angle	Hilary Holden	11362	569.57	110.98	13.99	Prince Edward Island	Office Furnishings	0.69
\N	529	*Staples* Letter Opener	Hilary Holden	11362	-119.66	2.18	5	Prince Edward Island	Scissors, Rulers and Trimmers	0.81
\N	530	Canon PC1060 Personal Laser Copier	Hilary Holden	11362	-690.21	699.99	24.49	Prince Edward Island	Copiers and Fax	0.41
\N	531	LX 677	Hilary Holden	11362	424.14	110.99	8.99	Prince Edward Island	Telephones and Communication	0.57
\N	532	Avery Hi-Liter® Fluorescent Desk Style Markers	Christopher Schild	11968	26.09	3.38	0.85	Prince Edward Island	Pens & Art Supplies	0.48
\N	533	#10- 4 1/8" x 9 1/2" Recycled Envelopes	Harold Engle	12293	119.64	8.74	1.39	Prince Edward Island	Envelopes	0.38
\N	534	Acco Suede Grain Vinyl Round Ring Binder	Greg Guthrie	12773	-4.61	2.78	1.49	Prince Edward Island	Binders and Binder Accessories	0.39
\N	535	Eldon Image Series Black Desk Accessories	Greg Guthrie	12773	-49.6	4.14	6.6	Prince Edward Island	Office Furnishings	0.49
\N	536	Xerox 213	Greg Guthrie	12773	-77.18	6.48	7.86	Prince Edward Island	Paper	0.37
\N	537	Newell 342	Greg Guthrie	12773	-50.88	3.28	3.97	Prince Edward Island	Pens & Art Supplies	0.56
\N	538	Staples #10 Laser & Inkjet Envelopes, 4 1/8" x 9 1/2", 100/Box	Guy Armstrong	12934	186.64	9.78	1.39	Prince Edward Island	Envelopes	0.39
\N	539	Newell 337	Guy Armstrong	12934	-66.35	3.28	3.97	Prince Edward Island	Pens & Art Supplies	0.56
\N	540	GBC Binding covers	Joy Smith	13120	82.59	12.95	4.98	Prince Edward Island	Binders and Binder Accessories	0.4
\N	541	GBC Standard Therm-A-Bind Covers	Joy Smith	13120	-17.37	24.92	12.98	Prince Edward Island	Binders and Binder Accessories	0.39
\N	542	Micro Innovations Micro Digital Wireless Keyboard and Mouse, Gray	Erica Bern	13604	1166.4	83.1	6.13	Prince Edward Island	Computer Peripherals	0.45
\N	543	Eldon ClusterMat Chair Mat with Cordless Antistatic Protection	Erica Bern	13604	-1396.22	90.98	56.2	Prince Edward Island	Office Furnishings	0.74
\N	544	Xerox 1985	Dan Reichenbach	13927	-21.41	6.48	5.16	Prince Edward Island	Paper	0.37
\N	545	Zoom V.92 V.44 PCI Internal Controllerless FaxModem	Erica Bern	15044	167.37	39.99	10.25	Prince Edward Island	Computer Peripherals	0.55
\N	546	Global Leather and Oak Executive Chair, Black	Guy Armstrong	15139	636.2	300.98	64.73	Prince Edward Island	Chairs & Chairmats	0.56
\N	547	Tennsco Lockers, Sand	Guy Armstrong	15139	-1163.21	20.98	45	Prince Edward Island	Storage & Organization	0.61
\N	548	Xerox 1920	Evan Minnotte	15463	-193.48	5.98	7.5	Prince Edward Island	Paper	0.4
\N	549	Xerox 1928	Joy Smith	15618	-34.98	5.28	6.26	Prince Edward Island	Paper	0.4
\N	550	Xerox 1939	Joy Smith	15618	26.27	18.97	9.54	Prince Edward Island	Paper	0.37
\N	551	StarTAC 7760	Joy Smith	15618	-11.4	65.99	3.99	Prince Edward Island	Telephones and Communication	0.59
\N	552	Magna Visual Magnetic Picture Hangers	Paul Gonzalez	16100	-115.54	4.82	5.72	Prince Edward Island	Office Furnishings	0.47
\N	553	M3682	Filia McAdams	16320	176.87	125.99	8.08	Prince Edward Island	Telephones and Communication	0.57
\N	554	Xerox 1978	Joy Smith	16419	-103.65	5.78	5.67	Prince Edward Island	Paper	0.36
\N	555	Sauder Forest Hills Library, Woodland Oak Finish	Greg Guthrie	17090	-443.78	140.98	36.09	Prince Edward Island	Bookcases	0.77
\N	556	Global High-Back Leather Tilter, Burgundy	Greg Guthrie	17090	-1086.43	122.99	70.2	Prince Edward Island	Chairs & Chairmats	0.74
\N	557	Wirebound Message Book, 4 per Page	Joy Smith	17315	64.01	5.43	0.95	Prince Edward Island	Paper	0.36
\N	558	Memorex 4.7GB DVD+RW, 3/Pack	Joy Smith	17376	425.08	28.48	1.99	Prince Edward Island	Computer Peripherals	0.4
\N	559	Hoover WindTunnel™ Plus Canister Vacuum	Greg Guthrie	18210	2437.17	363.25	19.99	Prince Edward Island	Appliances	0.57
\N	560	Newell 335	Greg Guthrie	18210	12.58	2.88	0.7	Prince Edward Island	Pens & Art Supplies	0.56
\N	561	Zoom V.92 USB External Faxmodem	Jack Lebron	18273	-3.68	49.99	19.99	Prince Edward Island	Computer Peripherals	0.41
\N	562	Telescoping Adjustable Floor Lamp	Joy Smith	18788	-19.33	19.99	11.17	Prince Edward Island	Office Furnishings	0.6
\N	563	Wilson Jones Ledger-Size, Piano-Hinge Binder, 2", Blue	Evan Minnotte	19042	54.9	40.98	7.47	Prince Edward Island	Binders and Binder Accessories	0.37
\N	564	Eldon Expressions Punched Metal & Wood Desk Accessories, Pewter & Cherry	Chuck Magee	19073	20.08	10.64	5.16	Prince Edward Island	Office Furnishings	0.57
\N	565	Prang Drawing Pencil Set	Chuck Magee	19073	5.81	2.78	1.34	Prince Edward Island	Pens & Art Supplies	0.45
\N	566	Xerox 1992	Filia McAdams	19365	-43.36	5.98	5.2	Prince Edward Island	Paper	0.36
\N	567	TI 36X Solar Scientific Calculator	Jack Lebron	19617	270.69	23.99	6.3	Prince Edward Island	Office Machines	0.38
\N	568	V 3600 Series	Jack Lebron	19617	-296.37	65.99	8.99	Prince Edward Island	Telephones and Communication	0.58
\N	569	Sharp AL-1530CS Digital Copier	Jack Lebron	20033	-1011.32	499.99	24.49	Prince Edward Island	Copiers and Fax	0.36
\N	570	Hon 4-Shelf Metal Bookcases	Harold Engle	21223	-144.43	100.98	26.22	Prince Edward Island	Bookcases	0.6
\N	571	Deflect-o EconoMat Nonstudded, No Bevel Mat	Harold Engle	21223	122.41	51.65	18.45	Prince Edward Island	Office Furnishings	0.65
\N	572	Lock-Up Easel 'Spel-Binder'	Jack Lebron	21378	391.6	28.53	1.49	Prince Edward Island	Binders and Binder Accessories	0.38
\N	573	U.S. Robotics 56K Internet Call Modem	Jack Lebron	21378	26.94	99.99	19.99	Prince Edward Island	Computer Peripherals	0.5
\N	574	Boston 1730 StandUp Electric Pencil Sharpener	Frank Atkinson	21542	-27.34	21.38	8.99	Prince Edward Island	Pens & Art Supplies	0.59
\N	575	Bretford CR4500 Series Slim Rectangular Table	Frank Atkinson	21542	715.18	348.21	84.84	Prince Edward Island	Tables	0.66
\N	576	Euro Pro Shark Stick Mini Vacuum	Jack Lebron	22469	-678.63	60.98	49	Prince Edward Island	Appliances	0.59
\N	577	Hon 5100 Series Wood Tables	Jack Lebron	22469	40.32	290.98	69	Prince Edward Island	Tables	0.67
\N	578	Belkin ErgoBoard™ Keyboard	Evan Minnotte	22656	-77.89	30.98	6.5	Prince Edward Island	Computer Peripherals	0.64
\N	579	Riverleaf Stik-Withit® Designer Note Cubes®	Joy Smith	22695	161.13	10.06	2.06	Prince Edward Island	Paper	0.39
\N	580	Coloredge Poster Frame	Dan Reichenbach	23076	122.21	14.2	5.3	Prince Edward Island	Office Furnishings	0.46
\N	581	8860	Jack Lebron	24038	82.04	65.99	5.26	Prince Edward Island	Telephones and Communication	0.56
\N	582	Xerox 1920	Frank Atkinson	24067	-79.35	5.98	7.5	Prince Edward Island	Paper	0.4
\N	583	252	Frank Atkinson	24067	751.38	65.99	5.92	Prince Edward Island	Telephones and Communication	0.55
\N	584	Sharp 1540cs Digital Laser Copier	Erica Bern	24388	-704.66	549.99	49	Prince Edward Island	Copiers and Fax	0.35
\N	585	Holmes Replacement Filter for HEPA Air Cleaner, Very Large Room, HEPA Filter	Jack Lebron	24451	-564.74	68.81	60	Prince Edward Island	Appliances	0.41
\N	586	Wilson Jones Impact Binders	Filia McAdams	24806	-57.99	5.18	5.74	Prince Edward Island	Binders and Binder Accessories	0.36
\N	587	GBC DocuBind 200 Manual Binding Machine	Jack Lebron	24965	580.15	420.98	19.99	Prince Edward Island	Binders and Binder Accessories	0.35
\N	588	Deflect-o SuperTray™ Unbreakable Stackable Tray, Letter, Black	Jack Lebron	24965	330.63	29.18	8.55	Prince Edward Island	Office Furnishings	0.42
\N	589	Sanford Liquid Accent Highlighters	Giulietta Baptist	25154	13.84	6.68	1.5	Prince Edward Island	Pens & Art Supplies	0.48
\N	590	Holmes Harmony HEPA Air Purifier for 17 x 20 Room	Joy Smith	25315	3506.24	225.04	11.79	Prince Edward Island	Appliances	0.42
\N	591	SANFORD Liquid Accent™ Tank-Style Highlighters	Joy Smith	25315	4.34	2.84	0.93	Prince Edward Island	Pens & Art Supplies	0.54
\N	592	Hon iLevel™ Computer Training Table	Joy Smith	25315	-1048.25	31.76	45.51	Prince Edward Island	Tables	0.65
\N	593	Eldon® 200 Class™ Desk Accessories, Burgundy	Greg Guthrie	25376	-31.83	6.28	5.29	Prince Edward Island	Office Furnishings	0.43
\N	594	80 Minute CD-R Spindle, 100/Pack - Staples	Carlos Soltero	26240	439.77	39.48	1.99	Prince Edward Island	Computer Peripherals	0.54
\N	595	3M Hangers With Command Adhesive	Carlos Soltero	26240	12	3.7	1.61	Prince Edward Island	Office Furnishings	0.44
\N	596	X-Rack™ File for Hanging Folders	Harold Engle	26791	-48.2	11.29	5.03	Prince Edward Island	Storage & Organization	0.59
\N	597	688	Erica Bern	28836	2342.21	195.99	4.2	Prince Edward Island	Telephones and Communication	0.6
\N	598	Ibico EB-19 Dual Function Manual Binding System	Erica Bern	28836	170.08	172.99	19.99	Prince Edward Island	Binders and Binder Accessories	0.39
\N	599	IBM Multi-Purpose Copy Paper, 8 1/2 x 11", Case	Hilary Holden	28995	73.19	30.98	5.76	Prince Edward Island	Paper	0.4
\N	600	Southworth 25% Cotton Premium Laser Paper and Envelopes	Hilary Holden	28995	80.92	19.98	8.68	Prince Edward Island	Paper	0.37
\N	601	Timeport L7089	Jack Lebron	29121	575.33	125.99	7.69	Prince Edward Island	Telephones and Communication	0.58
\N	602	Safco Contoured Stacking Chairs	Filia McAdams	29319	1151.69	238.4	24.49	Prince Edward Island	Chairs & Chairmats	\N
\N	603	Canon PC-428 Personal Copier	Filia McAdams	29319	983.55	199.99	24.49	Prince Edward Island	Copiers and Fax	0.46
\N	604	Staples Standard Envelopes	Greg Guthrie	29382	78.96	5.68	1.39	Prince Edward Island	Envelopes	0.38
\N	605	12-1/2 Diameter Round Wall Clock	Greg Guthrie	29382	35.09	19.98	10.49	Prince Edward Island	Office Furnishings	0.49
\N	606	Lexmark Z55se Color Inkjet Printer	Harold Engle	29445	415.55	90.97	28	Prince Edward Island	Office Machines	0.38
\N	607	Binder Clips by OIC	Philip Brown	29762	0.78	1.48	0.7	Prince Edward Island	Rubber Bands	0.37
\N	608	Avanti 4.4 Cu. Ft. Refrigerator	Helen Abelman	30048	433.63	180.98	55.24	Prince Edward Island	Appliances	0.57
\N	609	Fellowes Smart Surge Ten-Outlet Protector, Platinum	Hilary Holden	30243	650.56	60.22	3.5	Prince Edward Island	Appliances	0.57
\N	610	Canon PC-428 Personal Copier	Hilary Holden	30243	340.88	199.99	24.49	Prince Edward Island	Copiers and Fax	0.46
\N	611	Aluminum Document Frame	Christopher Schild	30372	-7.39	12.22	2.85	Prince Edward Island	Office Furnishings	0.55
\N	612	Wausau Papers Astrobrights® Colored Envelopes	Carlos Soltero	30499	5.66	5.98	2.5	Prince Edward Island	Envelopes	0.36
\N	613	Newell 312	Carlos Soltero	30499	42.34	5.84	1.2	Prince Edward Island	Pens & Art Supplies	0.55
\N	614	Pressboard Covers with Storage Hooks, 9 1/2" x 11", Light Blue	Erica Bern	32199	-99.76	4.91	4.97	Prince Edward Island	Binders and Binder Accessories	0.38
\N	615	Canon imageCLASS 2200 Advanced Copier	Erica Bern	32199	-3061.82	3499.99	24.49	Prince Edward Island	Copiers and Fax	0.37
\N	616	Newell 312	Erica Bern	32199	-0.01	5.84	1.2	Prince Edward Island	Pens & Art Supplies	0.55
\N	617	Chromcraft Bull-Nose Wood 48" x 96" Rectangular Conference Tables	Erica Bern	32327	-1430.45	550.98	147.12	Prince Edward Island	Tables	0.8
\N	618	Verbatim DVD-RAM, 9.4GB, Rewritable, Type 1, DS, DataLife Plus	Joy Smith	32676	523.43	45.19	1.99	Prince Edward Island	Computer Peripherals	0.55
\N	619	KF 788	Joy Smith	32835	-19.44	45.99	4.99	Prince Edward Island	Telephones and Communication	0.56
\N	620	Imation Neon Mac Format Diskettes, 10/Pack	Christopher Schild	32869	-82.83	8.12	2.83	Prince Edward Island	Computer Peripherals	0.77
\N	621	Deflect-o EconoMat Nonstudded, No Bevel Mat	Christopher Schild	32869	25.04	51.65	18.45	Prince Edward Island	Office Furnishings	0.65
\N	622	Sanford Liquid Accent Highlighters	Christopher Schild	32869	-7.51	6.68	1.5	Prince Edward Island	Pens & Art Supplies	0.48
\N	623	2180	Christopher Schild	32869	930.99	175.99	8.99	Prince Edward Island	Telephones and Communication	0.57
\N	624	Sharp AL-1530CS Digital Copier	Evan Minnotte	33763	-234.79	499.99	24.49	Prince Edward Island	Copiers and Fax	0.36
\N	625	Executive Impressions 14" Contract Wall Clock	Christopher Schild	34048	-10.74	22.23	3.63	Prince Edward Island	Office Furnishings	0.52
\N	626	*Staples* Highlighting Markers	Greg Guthrie	34275	26.66	4.84	0.71	Prince Edward Island	Pens & Art Supplies	0.52
\N	627	Boston 19500 Mighty Mite Electric Pencil Sharpener	Harold Engle	34438	-30.72	20.15	8.99	Prince Edward Island	Pens & Art Supplies	0.58
\N	628	Xerox 1995	Philip Brown	34880	-62.43	6.48	5.19	Prince Edward Island	Paper	0.37
\N	629	Self-Adhesive Ring Binder Labels	Carlos Soltero	34978	-269.91	3.52	6.83	Prince Edward Island	Binders and Binder Accessories	0.38
\N	630	Catalog Binders with Expanding Posts	Jennifer Braxton	35141	469.28	67.28	19.99	Prince Edward Island	Binders and Binder Accessories	0.4
\N	632	Deflect-o EconoMat Studded, No Bevel Mat for Low Pile Carpeting	Dan Reichenbach	35300	126.03	41.32	8.66	Prince Edward Island	Office Furnishings	0.76
\N	633	Recycled Desk Saver Line "While You Were Out" Book, 5 1/2" X 4"	Dan Reichenbach	35300	29.62	8.95	2.01	Prince Edward Island	Paper	0.39
\N	634	9-3/4 Diameter Round Wall Clock	Carlos Soltero	35558	-22.12	13.79	8.78	Prince Edward Island	Office Furnishings	0.43
\N	635	Logitech Cordless Elite Duo	Carlos Soltero	36293	250.47	100.98	7.18	Prince Edward Island	Computer Peripherals	0.4
\N	636	Xerox 220	Carlos Soltero	36293	-94.79	6.48	7.49	Prince Edward Island	Paper	0.37
\N	637	Logitech Cordless Elite Duo	Giulietta Baptist	36516	51.3	100.98	7.18	Prince Edward Island	Computer Peripherals	0.4
\N	638	Canon Image Class D660 Copier	Jack Lebron	36677	-734.33	599.99	24.49	Prince Edward Island	Copiers and Fax	0.44
\N	639	12 Colored Short Pencils	Guy Armstrong	37185	-13.27	2.6	2.4	Prince Edward Island	Pens & Art Supplies	0.58
\N	640	Avery Legal 4-Ring Binder	Hilary Holden	37888	274.9	20.98	1.49	Prince Edward Island	Binders and Binder Accessories	0.35
\N	641	Hoover® Commercial Lightweight Upright Vacuum	Jack Lebron	38310	-141.76	3.48	49	Prince Edward Island	Appliances	0.59
\N	642	Colored Envelopes	Erica Bern	40327	-20.27	3.69	2.5	Prince Edward Island	Envelopes	0.39
\N	643	Xerox 1953	Erica Bern	40327	-123.87	4.28	5.74	Prince Edward Island	Paper	0.4
\N	644	GBC DocuBind 200 Manual Binding Machine	Harold Engle	40480	3049.45	420.98	19.99	Prince Edward Island	Binders and Binder Accessories	0.35
\N	645	DAX Natural Wood-Tone Poster Frame	Harold Engle	40480	221.81	26.48	6.93	Prince Edward Island	Office Furnishings	0.49
\N	646	Staples Standard Envelopes	Jim Sink	40800	26.11	5.68	1.39	Prince Edward Island	Envelopes	0.38
\N	647	GBC Prepunched Paper, 19-Hole, for Binding Systems, 24-lb	Jennifer Braxton	40835	-8.08	15.01	8.4	Prince Edward Island	Binders and Binder Accessories	0.39
\N	648	Keytronic Designer 104- Key Black Keyboard	Jennifer Braxton	40835	-326.97	40.48	19.99	Prince Edward Island	Computer Peripherals	0.77
\N	649	Recycled Eldon Regeneration Jumbo File	Jennifer Braxton	40835	-6.68	12.28	6.13	Prince Edward Island	Storage & Organization	0.57
\N	650	GBC Standard Plastic Binding Systems Combs	Joy Smith	40871	-5.53	8.85	5.6	Prince Edward Island	Binders and Binder Accessories	0.36
\N	651	Office Star Flex Back Scooter Chair with White Frame	Joy Smith	40871	-157.63	110.98	30	Prince Edward Island	Chairs & Chairmats	0.71
\N	652	Xerox 1941	Harold Engle	41570	1037.55	104.85	4.65	Prince Edward Island	Paper	0.37
\N	653	Global Deluxe Stacking Chair, Gray	Philip Brown	41991	133.3	50.98	14.19	Prince Edward Island	Chairs & Chairmats	0.56
\N	654	DAX Clear Channel Poster Frame	Philip Brown	41991	68.44	14.58	7.4	Prince Edward Island	Office Furnishings	0.48
\N	655	Tenex B1-RE Series Chair Mats for Low Pile Carpets	Philip Brown	41991	256.66	45.98	4.8	Prince Edward Island	Office Furnishings	0.68
\N	656	Belkin 105-Key Black Keyboard	Giulietta Baptist	42400	11.55	19.98	4	Prince Edward Island	Computer Peripherals	0.68
\N	657	Micro Innovations 104 Keyboard	Giulietta Baptist	42400	-168.95	10.97	6.5	Prince Edward Island	Computer Peripherals	0.64
\N	658	GBC Imprintable Covers	Paul Gonzalez	42754	32.19	10.98	5.14	Prince Edward Island	Binders and Binder Accessories	0.36
\N	659	GBC Laser Imprintable Binding System Covers, Desert Sand	Logan Haushalter	42918	30.48	14.27	7.27	Prince Edward Island	Binders and Binder Accessories	0.38
\N	660	Sharp EL501VB Scientific Calculator, Battery Operated, 10-Digit Display, Hard Case	Logan Haushalter	42918	-54.58	9.49	5.76	Prince Edward Island	Office Machines	0.39
\N	661	Hon Multipurpose Stacking Arm Chairs	Filia McAdams	42944	1061.61	216.6	64.2	Prince Edward Island	Chairs & Chairmats	0.59
\N	662	Executive Impressions 14"	Carlos Soltero	44037	326.43	22.23	5.08	Prince Edward Island	Office Furnishings	0.41
\N	663	Accessory2	Carlos Soltero	44037	557.6	55.99	1.25	Prince Edward Island	Telephones and Communication	0.55
\N	664	Verbatim DVD-RAM, 5.2GB, Rewritable, Type 1, DS	Erica Bern	44387	475.26	29.89	1.99	Prince Edward Island	Computer Peripherals	0.5
\N	665	Southworth 25% Cotton Antique Laid Paper & Envelopes	Erica Bern	44387	-6.71	8.34	4.82	Prince Edward Island	Paper	0.4
\N	666	Bevis 36 x 72 Conference Tables	Greg Guthrie	44576	-189.35	124.49	51.94	Prince Edward Island	Tables	0.63
\N	667	Xerox 1936	Dan Reichenbach	45601	267.64	19.98	5.97	Prince Edward Island	Paper	0.38
\N	668	Eldon® 400 Class™ Desk Accessories, Black Carbon	Jim Sink	45606	-124.25	8.75	8.54	Prince Edward Island	Office Furnishings	0.43
\N	669	Dixon My First Ticonderoga Pencil, #2	Jim Sink	45606	-8.38	5.85	2.27	Prince Edward Island	Pens & Art Supplies	0.56
\N	670	Durable Pressboard Binders	Carlos Soltero	46119	15.27	3.8	1.49	Prince Edward Island	Binders and Binder Accessories	0.38
\N	671	Adams Telephone Message Book w/Frequently-Called Numbers Space, 400 Messages per Book	Carlos Soltero	46119	57.31	7.98	1.25	Prince Edward Island	Paper	0.35
\N	672	Bretford “Just In Time” Height-Adjustable Multi-Task Work Tables	Carlos Soltero	46119	-575.35	417.4	75.23	Prince Edward Island	Tables	0.79
\N	673	Array® Parchment Paper, Assorted Colors	Chuck Magee	46756	-22.45	7.28	11.15	Prince Edward Island	Paper	0.37
\N	674	Avery Durable Poly Binders	Philip Brown	47714	-125.36	5.53	6.98	Prince Edward Island	Binders and Binder Accessories	0.39
\N	675	Dana Swing-Arm Lamps	Hilary Holden	47846	-9.45	10.68	13.04	Prince Edward Island	Office Furnishings	0.6
\N	676	Rubbermaid ClusterMat Chairmats, Mat Size- 66" x 60", Lip 20" x 11" -90 Degree Angle	Hilary Holden	47846	631.99	110.98	13.99	Prince Edward Island	Office Furnishings	0.69
\N	677	Tenex 46" x 60" Computer Anti-Static Chairmat, Rectangular Shaped	Hilary Holden	47846	1581.93	105.98	13.99	Prince Edward Island	Office Furnishings	0.65
\N	678	HP Office Paper (20Lb. and 87 Bright)	Hilary Holden	47846	-120.08	6.68	6.93	Prince Edward Island	Paper	0.37
\N	679	Bionaire Personal Warm Mist Humidifier/Vaporizer	Greg Guthrie	47876	58.08	46.89	5.1	Prince Edward Island	Appliances	0.46
\N	680	270c	Jennifer Braxton	48067	695.06	125.99	3	Prince Edward Island	Telephones and Communication	0.59
\N	681	T28 WORLD	Jennifer Braxton	48067	630.7	195.99	8.99	Prince Edward Island	Telephones and Communication	0.6
\N	682	#10-4 1/8" x 9 1/2" Premium Diagonal Seam Envelopes	Erica Bern	48199	279.74	15.74	1.39	Prince Edward Island	Envelopes	0.4
\N	683	CF 888	Jim Sink	49029	2549.4	195.99	3.99	Prince Edward Island	Telephones and Communication	0.59
\N	684	GBC Standard Therm-A-Bind Covers	Noah Childs	49216	-45.82	24.92	12.98	Prince Edward Island	Binders and Binder Accessories	0.39
\N	685	Epson LQ-570e Dot Matrix Printer	Noah Childs	49216	-172.48	270.97	28.06	Manitoba	Office Machines	0.56
\N	686	Staples Premium Bright 1-Part Blank Computer Paper	Noah Childs	49216	30.63	12.28	6.35	Manitoba	Paper	0.38
\N	687	Okidata ML390 Turbo Dot Matrix Printers	Evan Minnotte	49990	501.51	442.14	14.7	Manitoba	Office Machines	0.56
\N	688	Hon Metal Bookcases, Black	Guy Armstrong	50081	-88.75	70.98	26.74	Manitoba	Bookcases	0.6
\N	689	24 Capacity Maxi Data Binder Racks, Pearl	Guy Armstrong	50404	905.57	210.55	9.99	Manitoba	Storage & Organization	0.6
\N	690	Lesro Round Back Collection Coffee Table, End Table	Guy Armstrong	50404	-367	182.55	69	Manitoba	Tables	0.72
\N	691	PC Concepts 116 Key Quantum 3000 Keyboard	Chuck Magee	50784	-130.88	32.98	5.5	Manitoba	Computer Peripherals	0.75
\N	692	Wilson Jones Ledger-Size, Piano-Hinge Binder, 2", Blue	Greg Guthrie	50850	578.14	40.98	7.47	Manitoba	Binders and Binder Accessories	0.37
\N	693	Bretford “Just In Time” Height-Adjustable Multi-Task Work Tables	Greg Guthrie	50850	-634.87	417.4	75.23	Manitoba	Tables	0.79
\N	694	Accessory17	Carlos Soltero	51075	-160.68	35.99	5	Manitoba	Telephones and Communication	0.82
\N	695	Telescoping Adjustable Floor Lamp	Greg Guthrie	51461	-97.54	19.99	11.17	Manitoba	Office Furnishings	0.6
\N	696	Xerox 1898	Greg Guthrie	51558	-87.27	6.68	6.92	Manitoba	Paper	0.37
\N	697	Barricks Non-Folding Utility Table with Steel Legs, Laminate Tops	Greg Guthrie	51558	85.29	85.29	60	Manitoba	Tables	0.56
\N	698	ACCOHIDE® Binder by Acco	Carlos Soltero	52130	-39.96	4.13	5.34	Manitoba	Binders and Binder Accessories	0.38
\N	699	Eldon Executive Woodline II Cherry Finish Desk Accessories	Carlos Soltero	52130	-4.01	40.89	18.98	Manitoba	Office Furnishings	0.57
\N	700	Belkin 8 Outlet Surge Protector	Greg Guthrie	52482	163.78	40.98	5.33	Manitoba	Appliances	0.57
\N	701	Executive Impressions 14" Contract Wall Clock	Greg Guthrie	52482	217.06	22.23	3.63	Manitoba	Office Furnishings	0.52
\N	702	Holmes Replacement Filter for HEPA Air Cleaner, Large Room	Christopher Schild	53410	-253.11	14.81	13.32	Manitoba	Appliances	0.43
\N	703	Bevis Steel Folding Chairs	Joy Smith	53477	-1207.18	95.95	74.35	Manitoba	Chairs & Chairmats	0.57
\N	704	Global Leather and Oak Executive Chair, Black	Joy Smith	53477	1261.44	300.98	64.73	Manitoba	Chairs & Chairmats	0.56
\N	705	Snap-A-Way® Black Print Carbonless Ruled Speed Letter, Triplicate	Joy Smith	53477	536.87	37.94	5.08	Manitoba	Paper	0.38
\N	706	Fellowes Super Stor/Drawer® Files	Joy Smith	53477	610.9	161.55	19.99	Manitoba	Storage & Organization	0.66
\N	707	Logitech Cordless Navigator Duo	Joy Smith	53508	149.64	80.98	7.18	Manitoba	Computer Peripherals	0.48
\N	708	Sharp EL500L Fraction Calculator	Joy Smith	53508	-32.42	13.99	7.51	Manitoba	Office Machines	0.39
\N	709	White GlueTop Scratch Pads	Joy Smith	53508	1.06	15.04	1.97	Manitoba	Paper	0.39
\N	710	Fellowes Strictly Business® Drawer File, Letter/Legal Size	Guy Armstrong	53703	-34.79	140.85	19.99	Manitoba	Storage & Organization	0.73
\N	711	Eureka Sanitaire ® Multi-Pro Heavy-Duty Upright, Disposable Bags	Brian Moss	54115	-80.05	4.37	5.15	Manitoba	Appliances	0.59
\N	712	Cardinal Holdit Business Card Pockets	Brian Moss	54115	-89.42	4.98	4.95	Manitoba	Binders and Binder Accessories	0.37
\N	713	Accessory36	Logan Haushalter	54437	-311.05	55.99	5	Manitoba	Telephones and Communication	0.83
\N	714	T193	Guy Armstrong	54501	481.7	65.99	4.99	Manitoba	Telephones and Communication	0.57
\N	715	Sharp EL500L Fraction Calculator	Guy Armstrong	54501	-33.03	13.99	7.51	Manitoba	Office Machines	0.39
\N	716	Tennsco Commercial Shelving	Guy Armstrong	54501	-1195.29	20.34	35	Manitoba	Storage & Organization	0.84
\N	717	T39m	Christopher Schild	54753	1380.32	155.99	3.9	Manitoba	Telephones and Communication	0.55
\N	718	Tennsco Industrial Shelving	Jim Sink	55138	-628.38	48.91	35	Manitoba	Storage & Organization	0.83
\N	719	Office Star Flex Back Scooter Chair with Aluminum Finish Frame	Carlos Soltero	55271	-210.14	100.89	42	Manitoba	Chairs & Chairmats	0.61
\N	720	Colored Envelopes	Jennifer Braxton	55331	-8.24	3.69	2.5	Manitoba	Envelopes	0.39
\N	721	Accessory13	Brian Moss	55618	479.95	35.99	1.25	Manitoba	Telephones and Communication	0.57
\N	722	Xerox 197	Harold Engle	56645	65.82	30.98	17.08	Manitoba	Paper	0.4
\N	723	Bretford CR4500 Series Slim Rectangular Table	Harold Engle	56645	3277.57	348.21	40.19	Manitoba	Tables	0.62
\N	724	Xerox 1976	Carlos Soltero	56803	-103.27	6.48	5.9	Manitoba	Paper	0.37
\N	725	Hon 2090 “Pillow Soft” Series Mid Back Swivel/Tilt Chairs	Hilary Holden	57159	-635.65	280.98	57	Manitoba	Chairs & Chairmats	0.78
\N	726	Hammermill Color Copier Paper (28Lb. and 96 Bright)	Hilary Holden	57159	-214.39	9.99	11.59	Manitoba	Paper	0.4
\N	727	GBC Prepunched Paper, 19-Hole, for Binding Systems, 24-lb	Logan Haushalter	57507	-19.68	15.01	8.4	Manitoba	Binders and Binder Accessories	0.39
\N	728	Acme Design Line 8" Stainless Steel Bent Scissors w/Champagne Handles, 3-1/8" Cut	Guy Armstrong	57922	-287.28	6.84	8.37	Manitoba	Scissors, Rulers and Trimmers	0.58
\N	729	Serrated Blade or Curved Handle Hand Letter Openers	Erica Bern	58117	-62.84	3.14	1.92	Manitoba	Scissors, Rulers and Trimmers	0.84
\N	730	GE 48" Fluorescent Tube, Cool White Energy Saver, 34 Watts, 30/Box	Logan Haushalter	58278	2093.7	99.23	8.99	Manitoba	Office Furnishings	0.35
\N	731	Accessory4	Logan Haushalter	58278	-434.56	85.99	0.99	Manitoba	Telephones and Communication	0.85
\N	732	Hon GuestStacker Chair	Harold Engle	58502	1009.38	226.67	28.16	Manitoba	Chairs & Chairmats	0.59
\N	733	Belkin ErgoBoard™ Keyboard	Christopher Schild	58788	43.72	30.98	6.5	Manitoba	Computer Peripherals	0.64
\N	734	TOPS Money Receipt Book, Consecutively Numbered in Red,	Helen Abelman	58947	102.58	8.01	2.87	Manitoba	Paper	0.4
\N	735	Xerox 1989	Helen Abelman	58947	-67.79	4.98	5.02	Manitoba	Paper	0.38
\N	736	GE 4 Foot Flourescent Tube, 40 Watt	Jack Lebron	59074	70.8	14.98	8.99	British Columbia	Office Furnishings	0.39
\N	737	Bush Westfield Collection Bookcases, Fully Assembled	Jack Lebron	59233	-160.46	100.98	35.84	British Columbia	Bookcases	0.62
\N	738	Nu-Dell Leatherette Frames	Jack Lebron	59233	7.69	14.34	5	British Columbia	Office Furnishings	0.49
\N	739	Micro Innovations Micro Digital Wireless Keyboard and Mouse, Gray	Giulietta Baptist	59425	717.12	83.1	6.13	British Columbia	Computer Peripherals	0.45
\N	740	Snap-A-Way® Black Print Carbonless Ruled Speed Letter, Triplicate	Giulietta Baptist	59425	741.27	37.94	5.08	British Columbia	Paper	0.38
\N	741	Xerox 1994	Jim Sink	59750	-66.05	6.48	5.74	British Columbia	Paper	0.37
\N	742	Dixon Ticonderoga Core-Lock Colored Pencils	Julie Creighton	35	60.72	9.11	2.25	British Columbia	Pens & Art Supplies	0.52
\N	743	CF 688	Julie Creighton	35	48.99	155.99	8.99	British Columbia	Telephones and Communication	0.58
\N	744	Fellowes Staxonsteel® Drawer Files	Sanjit Chand	294	489.02	193.17	19.99	British Columbia	Storage & Organization	0.71
\N	745	Panasonic KP-350BK Electric Pencil Sharpener with Auto Stop	Matt Collins	450	109.33	34.58	8.99	British Columbia	Pens & Art Supplies	0.56
\N	746	Hanging Personal Folder File	Matt Collins	450	-211.13	15.7	11.25	British Columbia	Storage & Organization	0.6
\N	747	Memorex 4.7GB DVD+RW, 3/Pack	Matt Collins	1028	-28.46	28.48	1.99	British Columbia	Computer Peripherals	0.4
\N	748	3285	Matt Collins	1028	-60.39	205.99	5.99	British Columbia	Telephones and Communication	0.59
\N	749	Wirebound Message Books, Four 2 3/4" x 5" Forms per Page, 600 Sets per Book	Justin Knight	1314	-7.61	9.27	4.39	British Columbia	Paper	0.38
\N	750	Office Star - Task Chair with Contemporary Loop Arms	Rob Haberlin	2279	205.83	90.98	30	British Columbia	Chairs & Chairmats	0.61
\N	751	Acco Perma® 3000 Stacking Storage Drawers	Rob Haberlin	2279	52.53	20.98	5.42	British Columbia	Storage & Organization	0.66
\N	752	80 Minute CD-R Spindle, 100/Pack - Staples	Rob Haberlin	2465	271.87	39.48	1.99	British Columbia	Computer Peripherals	0.54
\N	753	Avery 479	Rob Haberlin	2530	4.58	2.61	0.5	British Columbia	Labels	0.39
\N	754	Fellowes Bankers Box™ Staxonsteel® Drawer File/Stacking System	Rob Haberlin	2883	177.66	64.98	6.88	British Columbia	Storage & Organization	0.73
\N	755	Imation Printable White 80 Minute CD-R Spindle, 50/Pack	Christina Vanderzanden	3362	734.75	40.98	1.99	British Columbia	Computer Peripherals	0.44
\N	756	Eldon® Gobal File Keepers	Christina Vanderzanden	3362	-109.1	15.14	4.53	British Columbia	Storage & Organization	0.81
\N	757	Kensington 7 Outlet MasterPiece® HOMEOFFICE Power Control Center	Matt Collins	5318	195.16	131.12	0.99	British Columbia	Appliances	0.55
\N	758	2160i	Matt Collins	5318	1196.37	200.99	4.2	British Columbia	Telephones and Communication	0.59
\N	759	Sharp AL-1530CS Digital Copier	Sanjit Chand	5988	-379.29	499.99	24.49	British Columbia	Copiers and Fax	0.36
\N	760	Seth Thomas 13 1/2" Wall Clock	Matt Collins	6115	78.86	17.78	5.03	British Columbia	Office Furnishings	0.54
\N	761	Tenex Carpeted, Granite-Look or Clear Contemporary Contour Shape Chair Mats	Justin Knight	6337	-912.08	70.71	37.58	British Columbia	Office Furnishings	0.78
\N	762	Bretford Rectangular Conference Table Tops	Justin Knight	6337	-261.61	376.13	85.63	British Columbia	Tables	0.74
\N	763	Wirebound Voice Message Log Book	Rob Haberlin	6434	14.49	4.76	0.88	British Columbia	Paper	0.39
\N	764	80 Minute CD-R Spindle, 100/Pack - Staples	Lena Cacioppo	7136	88.72	39.48	1.99	British Columbia	Computer Peripherals	0.54
\N	765	Avery 493	Lena Cacioppo	7136	17.05	4.91	0.5	British Columbia	Labels	0.36
\N	766	O'Sullivan Manor Hill 2-Door Library in Brianna Oak	Kimberly Carter	7489	552.97	180.98	23.58	British Columbia	Bookcases	0.74
\N	767	Novimex Swivel Fabric Task Chair	Gene Hale	7968	-270	150.98	30	British Columbia	Chairs & Chairmats	0.74
\N	768	Imation Primaris 3.5" 2HD Unformatted Diskettes, 10/Pack	Christina Vanderzanden	8227	-43.21	4.77	2.39	British Columbia	Computer Peripherals	0.72
\N	769	Project Tote Personal File	Matt Collins	9123	-108.28	14.03	9.37	British Columbia	Storage & Organization	0.56
\N	770	3M Organizer Strips	Sally Knutson	9792	-73.14	5.4	7.78	British Columbia	Binders and Binder Accessories	0.37
\N	771	Imation 3.5" DS-HD Macintosh Formatted Diskettes, 10/Pack	Kimberly Carter	9860	-73.66	7.28	3.52	British Columbia	Computer Peripherals	0.68
\N	772	Sanford Colorific Colored Pencils, 12/Box	Christina Vanderzanden	10310	9.59	2.88	1.01	British Columbia	Pens & Art Supplies	0.55
\N	773	R380	Christina Vanderzanden	10310	-655.42	195.99	3.99	British Columbia	Telephones and Communication	0.58
\N	774	Xerox 1899	Kimberly Carter	10369	-12.38	5.78	4.96	British Columbia	Paper	0.36
\N	775	Imation IBM Formatted Diskettes, 100/Pack	Kimberly Carter	10369	-95.54	28.48	8.99	British Columbia	Computer Peripherals	0.7
\N	776	Barrel Sharpener	Rob Haberlin	10692	-69.91	3.57	4.17	British Columbia	Pens & Art Supplies	0.59
\N	777	2160i	Rob Haberlin	10692	2369.84	200.99	4.2	British Columbia	Telephones and Communication	0.59
\N	778	A1228	Rob Haberlin	10692	-457.16	195.99	8.99	British Columbia	Telephones and Communication	0.58
\N	779	Gould Plastics 9-Pocket Panel Bin, 18-3/8w x 5-1/4d x 20-1/2h, Black	Justin Knight	11553	-517.17	52.99	19.99	British Columbia	Storage & Organization	0.81
\N	780	Bush Westfield Collection Bookcases, Dark Cherry Finish, Fully Assembled	Justin Knight	11553	-429.86	100.98	57.38	British Columbia	Bookcases	0.78
\N	781	Accessory34	Justin Knight	11553	365.42	85.99	0.99	British Columbia	Telephones and Communication	0.55
\N	782	Bagged Rubber Bands	Christina Vanderzanden	11776	-14.1	1.26	0.7	British Columbia	Rubber Bands	0.81
\N	783	Hammermill CopyPlus Copy Paper (20Lb. and 84 Bright)	Marina Lichtenstein	11782	-63.72	4.98	4.75	British Columbia	Paper	0.36
\N	784	Panasonic All Digital Answering System with Caller ID*, KX-TM150B	Marina Lichtenstein	11782	14.35	66.99	13.99	British Columbia	Telephones and Communication	0.6
\N	785	Wilson Jones® Four-Pocket Poly Binders	Justin Knight	12199	-10.73	6.54	5.27	British Columbia	Binders and Binder Accessories	0.36
\N	786	Dual Level, Single-Width Filing Carts	Justin Knight	12199	3051.62	155.06	7.07	British Columbia	Storage & Organization	0.59
\N	787	Economy Binders	Gene Hale	14275	-7.73	2.08	1.49	British Columbia	Binders and Binder Accessories	0.36
\N	788	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Gene Hale	14275	-187.75	160.98	30	British Columbia	Chairs & Chairmats	0.62
\N	789	X-Rack™ File for Hanging Folders	Gene Hale	14535	-33.82	11.29	5.03	British Columbia	Storage & Organization	0.59
\N	790	Verbatim DVD-RAM, 5.2GB, Rewritable, Type 1, DS	Rob Haberlin	15329	319.52	29.89	1.99	British Columbia	Computer Peripherals	0.5
\N	791	Newell 323	Gene Hale	15621	-13.95	1.68	1.57	British Columbia	Pens & Art Supplies	0.59
\N	792	Eldon Portable Mobile Manager	Gene Hale	15621	-136.2	28.28	13.99	British Columbia	Storage & Organization	0.58
\N	793	Avery Binder Labels	Michelle Arnett	17826	-88.61	3.89	7.01	British Columbia	Binders and Binder Accessories	0.37
\N	794	Eldon Jumbo ProFile™ Portable File Boxes Graphite/Black	Sally Knutson	17926	-70.04	15.31	8.78	British Columbia	Storage & Organization	0.57
\N	795	Master Giant Foot® Doorstop, Safety Yellow	Rob Haberlin	18247	27.22	7.59	4	British Columbia	Office Furnishings	0.42
\N	796	Newell 315	Justin Knight	18471	46.41	5.98	0.96	British Columbia	Pens & Art Supplies	0.6
\N	797	Kleencut® Forged Office Shears by Acme United Corporation	Justin Knight	18471	-8.02	2.08	2.56	British Columbia	Scissors, Rulers and Trimmers	0.55
\N	798	Xerox 1983	Justin Knight	18471	-47.12	5.98	5.46	British Columbia	Paper	0.36
\N	799	T61	Lena Cacioppo	19813	218.73	45.99	2.5	British Columbia	Telephones and Communication	0.56
\N	800	Avery Poly Binder Pockets	Seth Vernon	20322	-183.36	3.58	5.47	British Columbia	Binders and Binder Accessories	0.37
\N	801	Bush Westfield Collection Bookcases, Fully Assembled	Seth Vernon	20322	-129.53	100.98	35.84	British Columbia	Bookcases	0.62
\N	802	Xerox 196	Seth Vernon	20322	-72.28	5.78	7.96	British Columbia	Paper	0.36
\N	803	Nu-Dell Leatherette Frames	Gene Hale	20422	115.21	14.34	5	British Columbia	Office Furnishings	0.49
\N	804	Colored Envelopes	Luke Weiss	20448	6.84	3.69	2.5	British Columbia	Envelopes	0.39
\N	805	Pressboard Covers with Storage Hooks, 9 1/2" x 11", Light Blue	Justin Knight	21892	-18.34	4.91	4.97	British Columbia	Binders and Binder Accessories	0.38
\N	806	Eldon Simplefile® Box Office®	Rob Haberlin	22980	-27.92	12.44	6.27	British Columbia	Storage & Organization	0.57
\N	807	6190	Julie Creighton	23907	-164.46	65.99	2.5	British Columbia	Telephones and Communication	0.55
\N	808	Panasonic KX-P3200 Dot Matrix Printer	Sanjit Chand	24064	935.8	297.64	14.7	British Columbia	Office Machines	0.57
\N	809	Wilson Jones DublLock® D-Ring Binders	Justin Knight	24132	-4.49	6.75	2.99	British Columbia	Binders and Binder Accessories	0.35
\N	810	Wilson Jones Hanging View Binder, White, 1"	Justin Knight	24132	-101.25	7.1	6.05	British Columbia	Binders and Binder Accessories	0.39
\N	811	Fellowes Basic 104-Key Keyboard, Platinum	Justin Knight	24132	-1.88	20.95	4	British Columbia	Computer Peripherals	0.6
\N	812	Ibico Recycled Linen-Style Covers	Justin Knight	24132	339.75	39.06	10.55	British Columbia	Binders and Binder Accessories	0.37
\N	813	Self-Adhesive Ring Binder Labels	Justin Knight	24132	-57.75	3.52	6.83	British Columbia	Binders and Binder Accessories	0.38
\N	814	Tenex File Box, Personal Filing Tote with Lid, Black	Justin Knight	24132	-47.97	15.51	17.78	British Columbia	Storage & Organization	0.59
\N	815	1726 Digital Answering Machine	Luke Weiss	24576	24.56	20.99	4.81	British Columbia	Telephones and Communication	0.58
\N	816	DAX Clear Channel Poster Frame	Luke Weiss	24576	38.02	14.58	7.4	British Columbia	Office Furnishings	0.48
\N	817	80 Minute Slim Jewel Case CD-R , 10/Pack - Staples	Christina Vanderzanden	25248	29.21	8.33	1.99	British Columbia	Computer Peripherals	0.52
\N	818	Xerox 1891	Christina Vanderzanden	25248	418.19	48.91	5.81	British Columbia	Paper	0.38
\N	819	Xerox 220	Lena Cacioppo	25475	-191.49	6.48	7.49	British Columbia	Paper	0.37
\N	820	Computer Printout Paper with Letter-Trim Perforations	Seth Vernon	26978	-21.2	18.97	9.03	British Columbia	Paper	0.37
\N	821	Wausau Papers Astrobrights® Colored Envelopes	Sanjit Chand	27105	39.63	5.98	2.5	British Columbia	Envelopes	0.36
\N	822	Executive Impressions 8-1/2" Career Panel/Partition Cubicle Clock	Sanjit Chand	27105	26.21	10.4	5.4	British Columbia	Office Furnishings	0.51
\N	823	Belkin MediaBoard 104- Keyboard	Julie Creighton	28068	-43.96	27.48	4	British Columbia	Computer Peripherals	0.75
\N	824	Executive Impressions 12" Wall Clock	Sanjit Chand	28802	51.36	17.67	8.99	British Columbia	Office Furnishings	0.47
\N	825	Southworth 25% Cotton Antique Laid Paper & Envelopes	Sanjit Chand	28802	25.95	8.34	4.82	British Columbia	Paper	0.4
\N	826	6185	Sanjit Chand	28802	884.91	205.99	3	British Columbia	Telephones and Communication	0.58
\N	827	Eldon Spacemaker® Box, Quick-Snap Lid, Clear	Anthony Johnson	28839	-175.86	3.34	7.49	British Columbia	Pens & Art Supplies	0.54
\N	828	Xerox 1995	Anthony Johnson	29252	-15.44	6.48	5.19	British Columbia	Paper	0.37
\N	829	Honeywell Quietcare HEPA Air Cleaner	Kimberly Carter	31941	650.73	78.65	13.99	British Columbia	Appliances	0.52
\N	830	Xerox 1993	Kimberly Carter	31941	-43.5	6.48	9.68	British Columbia	Paper	0.36
\N	831	Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back	Marina Lichtenstein	32418	-131.31	243.98	43.32	British Columbia	Chairs & Chairmats	0.55
\N	832	Strathmore #10 Envelopes, Ultimate White	Sanjit Chand	34241	16.23	52.71	2.5	British Columbia	Envelopes	0.36
\N	833	Fellowes 8 Outlet Superior Workstation Surge Protector	Sally Knutson	34816	267.16	41.71	4.5	British Columbia	Appliances	0.56
\N	834	Tyvek Interoffice Envelopes, 9 1/2" x 12 1/2", 100/Box	Sally Knutson	34816	590.77	60.98	19.99	British Columbia	Envelopes	0.38
\N	835	Fiskars® Softgrip Scissors	Luke Weiss	35011	-2.31	10.98	3.37	British Columbia	Scissors, Rulers and Trimmers	0.57
\N	836	Sanyo 2.5 Cubic Foot Mid-Size Office Refrigerators	Anthony Johnson	36068	1243.17	279.81	23.19	British Columbia	Appliances	0.59
\N	837	Accessory20	Michelle Arnett	36930	1325.82	85.99	3.3	British Columbia	Telephones and Communication	0.37
\N	838	Xerox 1971	Luke Weiss	37315	-133.68	4.28	5.17	British Columbia	Paper	0.4
\N	839	5165	Luke Weiss	37315	1176.48	175.99	4.99	British Columbia	Telephones and Communication	0.59
\N	840	Lexmark Z54se Color Inkjet Printer	Luke Weiss	37925	1265.82	90.97	14	British Columbia	Office Machines	0.36
\N	841	StarTAC 7760	Luke Weiss	37925	394.45	65.99	3.99	British Columbia	Telephones and Communication	0.59
\N	842	Premier Elliptical Ring Binder, Black	Rob Haberlin	38021	709.33	30.44	1.49	British Columbia	Binders and Binder Accessories	0.37
\N	843	Wilson Jones DublLock® D-Ring Binders	Julie Creighton	38336	2.82	6.75	2.99	British Columbia	Binders and Binder Accessories	0.35
\N	844	Micro Innovations 104 Keyboard	Julie Creighton	38336	-116.45	10.97	6.5	British Columbia	Computer Peripherals	0.64
\N	845	Eldon Expressions Punched Metal & Wood Desk Accessories, Pewter & Cherry	Justin Knight	38565	-11.69	10.64	5.16	British Columbia	Office Furnishings	0.57
\N	846	Eureka Disposable Bags for Sanitaire® Vibra Groomer I® Upright Vac	Sally Knutson	39783	-94.76	4.06	6.89	British Columbia	Appliances	0.6
\N	847	GBC Standard Plastic Binding Systems Combs	Sally Knutson	39783	5.02	8.85	5.6	British Columbia	Binders and Binder Accessories	0.36
\N	848	Avery 520	Sally Knutson	39783	39.9	3.15	0.5	British Columbia	Labels	0.37
\N	849	Fellowes Premier Superior Surge Suppressor, 10-Outlet, With Phone and Remote	Michelle Arnett	42500	437.07	48.92	4.5	British Columbia	Appliances	0.59
\N	850	Cardinal Slant-D® Ring Binder, Heavy Gauge Vinyl	Michelle Arnett	42500	-10.48	8.69	2.99	British Columbia	Binders and Binder Accessories	0.39
\N	851	Fiskars® Softgrip Scissors	Julie Creighton	44162	42.76	10.98	3.37	British Columbia	Scissors, Rulers and Trimmers	0.57
\N	852	TOPS Money Receipt Book, Consecutively Numbered in Red,	Sally Knutson	44256	48.45	8.01	2.87	British Columbia	Paper	0.4
\N	853	Xerox 226	Sally Knutson	44256	-38.72	6.48	5.84	British Columbia	Paper	0.37
\N	854	Sanford 52201 APSCO Electric Pencil Sharpener	Sally Knutson	44256	182.15	40.97	8.99	British Columbia	Pens & Art Supplies	0.59
\N	855	Laminate Occasional Tables	Sally Knutson	44320	-1640.51	154.13	69	British Columbia	Tables	0.68
\N	856	Round Ring Binders	Kimberly Carter	45377	-22.9	2.08	1.49	British Columbia	Binders and Binder Accessories	0.38
\N	857	Durable Pressboard Binders	Rob Haberlin	47367	-0.17	3.8	1.49	British Columbia	Binders and Binder Accessories	0.38
\N	858	Avery 52	Rob Haberlin	47367	2.28	3.69	0.5	British Columbia	Labels	0.38
\N	859	Avery 492	Sally Knutson	47750	36.64	2.88	0.5	British Columbia	Labels	0.39
\N	860	Executive Impressions 13" Chairman Wall Clock	Sally Knutson	47750	216.12	25.38	8.99	British Columbia	Office Furnishings	0.5
\N	861	Binder Posts	Marina Lichtenstein	48388	-13.33	5.74	5.01	British Columbia	Binders and Binder Accessories	0.39
\N	862	Avery 498	Christina DeMoss	49059	45.51	2.89	0.5	British Columbia	Labels	0.38
\N	863	Xerox 1891	Christina DeMoss	49059	32.86	48.91	5.81	British Columbia	Paper	0.38
\N	864	DIXON Oriole® Pencils	Luke Weiss	49510	-6.22	2.58	1.3	British Columbia	Pens & Art Supplies	0.59
\N	865	Avery Durable Binders	Sally Knutson	49634	10.91	2.88	1.49	British Columbia	Binders and Binder Accessories	0.36
\N	866	Avery 510	Michelle Arnett	50210	82.3	3.75	0.5	British Columbia	Labels	0.37
\N	867	Super Bands, 12/Pack	Michelle Arnett	50210	-30.26	1.86	2.58	British Columbia	Rubber Bands	0.82
\N	868	iDEN i95	Sanjit Chand	50503	-186.33	65.99	19.99	British Columbia	Telephones and Communication	0.59
\N	869	Staples 6 Outlet Surge	Anthony Johnson	50816	-35.94	11.97	4.98	British Columbia	Appliances	0.58
\N	870	Lock-Up Easel 'Spel-Binder'	Anthony Johnson	50816	302.8	28.53	1.49	British Columbia	Binders and Binder Accessories	0.38
\N	871	Memorex 4.7GB DVD+R, 3/Pack	Anthony Johnson	50816	-12.46	15.28	1.99	British Columbia	Computer Peripherals	0.42
\N	872	3M Polarizing Task Lamp with Clamp Arm, Light Gray	Luke Weiss	51073	958.8	136.98	24.49	British Columbia	Office Furnishings	0.59
\N	873	Advantus Employee of the Month Certificate Frame, 11 x 13-1/2	Luke Weiss	51073	813.35	30.93	3.92	British Columbia	Office Furnishings	0.44
\N	874	Office Star Flex Back Scooter Chair with White Frame	Rob Haberlin	51584	176.04	110.98	30	British Columbia	Chairs & Chairmats	0.71
\N	875	Howard Miller 11-1/2" Diameter Ridgewood Wall Clock	Monica Federle	51879	372.26	51.94	19.99	British Columbia	Office Furnishings	0.44
\N	876	Southworth 25% Cotton Premium Laser Paper and Envelopes	Monica Federle	51879	212.06	19.98	8.68	British Columbia	Paper	0.37
\N	877	Howard Miller 12-3/4 Diameter Accuwave DS ™ Wall Clock	Kimberly Carter	52288	545.11	78.69	19.99	British Columbia	Office Furnishings	0.43
\N	878	Lock-Up Easel 'Spel-Binder'	Michelle Arnett	53190	74.64	28.53	1.49	British Columbia	Binders and Binder Accessories	0.38
\N	879	StarTAC 7760	Michelle Arnett	53190	-170.53	65.99	3.99	British Columbia	Telephones and Communication	0.59
\N	880	Seth Thomas 12" Clock w/ Goldtone Case	Sanjit Chand	53536	109.16	22.98	7.58	British Columbia	Office Furnishings	0.51
\N	881	Bevis Round Conference Room Tables and Bases	Sanjit Chand	53536	-234.59	179.29	56.2	British Columbia	Tables	0.71
\N	882	#10 Self-Seal White Envelopes	Marina Lichtenstein	53572	4.79	11.09	5.25	British Columbia	Envelopes	0.36
\N	883	Xerox 1885	Joy Smith	53825	649.8	48.04	7.23	British Columbia	Paper	0.37
\N	884	Fellowes Super Stor/Drawer® Files	Christina DeMoss	53863	1660.15	161.55	19.99	British Columbia	Storage & Organization	0.66
\N	885	Advantus Push Pins, Aluminum Head	Monica Federle	54119	-43.45	5.81	3.37	British Columbia	Rubber Bands	0.54
\N	886	Acco Perma® 2700 Stacking Storage Drawers	Monica Federle	54119	-41.75	29.74	6.64	British Columbia	Storage & Organization	0.7
\N	887	Acco Pressboard Covers with Storage Hooks, 14 7/8" x 11", Dark Blue	Michelle Arnett	56224	-117.27	3.81	5.44	British Columbia	Binders and Binder Accessories	0.36
\N	888	Bevis Steel Folding Chairs	Michelle Arnett	56224	-1115.99	95.95	74.35	British Columbia	Chairs & Chairmats	0.57
\N	889	Staples Vinyl Coated Paper Clips, 800/Box	Michelle Arnett	56224	48.59	7.89	2.82	British Columbia	Rubber Bands	0.4
\N	890	Bevis 36 x 72 Conference Tables	Michelle Arnett	56224	-153.25	124.49	51.94	British Columbia	Tables	0.63
\N	891	Telescoping Adjustable Floor Lamp	Michelle Arnett	56293	-44.81	19.99	11.17	British Columbia	Office Furnishings	0.6
\N	892	Tenex Personal Self-Stacking Standard File Box, Black/Gray	Michelle Arnett	56293	-27.72	16.91	6.25	British Columbia	Storage & Organization	0.58
\N	893	Advantus Push Pins, Aluminum Head	Sally Knutson	57959	-32.06	5.81	3.37	British Columbia	Rubber Bands	0.54
\N	894	Micro Innovations Micro 3000 Keyboard, Black	Sally Knutson	57959	-65.33	26.31	5.89	British Columbia	Computer Peripherals	0.75
\N	895	LX 677	Christina DeMoss	58500	14.01	110.99	8.99	British Columbia	Telephones and Communication	0.57
\N	896	Bush Westfield Collection Bookcases, Fully Assembled	Joy Smith	59584	-160.46	100.98	35.84	British Columbia	Bookcases	0.62
\N	897	Canon MP41DH Printing Calculator	Joy Smith	59584	16.81	150.98	13.99	British Columbia	Office Machines	0.38
\N	898	7160	Sonia Sunley	261	1680.79	140.99	4.2	British Columbia	Telephones and Communication	0.59
\N	899	Belkin 8 Outlet SurgeMaster II Gold Surge Protector	Anthony O'Donnell	928	300.97	59.98	3.99	British Columbia	Appliances	0.57
\N	900	DAX Clear Channel Poster Frame	Anthony O'Donnell	928	45	14.58	7.4	British Columbia	Office Furnishings	0.48
\N	901	Memorex 4.7GB DVD-RAM, 3/Pack	Emily Grady	1282	366.48	31.78	1.99	British Columbia	Computer Peripherals	0.42
\N	902	Prang Drawing Pencil Set	Emily Grady	1282	-2.06	2.78	1.34	British Columbia	Pens & Art Supplies	0.45
\N	903	Euro Pro Shark Stick Mini Vacuum	Alex Avila	1856	-712.14	60.98	49	British Columbia	Appliances	0.59
\N	904	M3682	Alex Avila	1856	973.16	125.99	8.08	British Columbia	Telephones and Communication	0.57
\N	905	StarTAC 6500	Alex Avila	1856	676.13	125.99	8.8	British Columbia	Telephones and Communication	0.59
\N	906	SAFCO Arco Folding Chair	Brian Moss	1925	67.84	276.2	24.49	British Columbia	Chairs & Chairmats	\N
\N	907	Eldon Advantage® Chair Mats for Low to Medium Pile Carpets	Emily Grady	2848	-303.62	43.31	15.9	British Columbia	Office Furnishings	0.75
\N	908	SC7868i	Emily Grady	2848	-264.28	125.99	8.99	British Columbia	Telephones and Communication	0.55
\N	909	HP Office Recycled Paper (20Lb. and 87 Bright)	Anna Andreadi	5504	-20.33	5.78	7.64	British Columbia	Paper	0.36
\N	910	KF 788	Anna Andreadi	5504	20.23	45.99	4.99	British Columbia	Telephones and Communication	0.56
\N	911	Logitech Internet Navigator Keyboard	Emily Grady	8390	-99.34	30.98	4	British Columbia	Computer Peripherals	0.8
\N	912	ACCOHIDE® Binder by Acco	Barbara Fisher	8545	-77.34	4.13	5.34	British Columbia	Binders and Binder Accessories	0.38
\N	913	O'Sullivan Elevations Bookcase, Cherry Finish	Barbara Fisher	8545	-662.8	130.98	54.74	British Columbia	Bookcases	0.69
\N	914	Serrated Blade or Curved Handle Hand Letter Openers	Emily Grady	9573	-59.91	3.14	1.92	British Columbia	Scissors, Rulers and Trimmers	0.84
\N	915	Tyvek ® Top-Opening Peel & Seel Envelopes, Plain White	Kelly Williams	9892	424.36	27.18	8.23	British Columbia	Envelopes	0.38
\N	916	Keytronic 105-Key Spanish Keyboard	Sonia Sunley	10048	97.16	73.98	4	British Columbia	Computer Peripherals	0.77
\N	917	*Staples* vLetter Openers, 2/Pack	Sonia Sunley	10048	-20.65	3.68	1.32	British Columbia	Scissors, Rulers and Trimmers	0.83
\N	918	Hon 4700 Series Mobuis™ Mid-Back Task Chairs with Adjustable Arms	Sonia Sunley	10144	103.83	355.98	58.92	British Columbia	Chairs & Chairmats	0.64
\N	919	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Sonia Sunley	10144	-98.3	160.98	30	British Columbia	Chairs & Chairmats	0.62
\N	920	Global Adaptabilities™ Conference Tables	Sonia Sunley	10144	539.54	280.98	35.67	British Columbia	Tables	0.66
\N	921	Motorola SB4200 Cable Modem	Sonia Sunley	10432	220.39	179.99	19.99	British Columbia	Computer Peripherals	0.48
\N	922	Acme Design Line 8" Stainless Steel Bent Scissors w/Champagne Handles, 3-1/8" Cut	Jocasta Rupert	10661	-99.34	6.84	8.37	British Columbia	Scissors, Rulers and Trimmers	0.58
\N	923	Jet-Pak Recycled Peel 'N' Seal Padded Mailers	Sonia Sunley	12806	107.93	35.89	14.72	British Columbia	Envelopes	0.4
\N	924	Wilson Jones DublLock® D-Ring Binders	Kelly Williams	13158	29.33	6.75	2.99	British Columbia	Binders and Binder Accessories	0.35
\N	925	Strathmore Photo Mount Cards	Anna Andreadi	13507	-75.71	6.78	6.18	British Columbia	Paper	0.39
\N	926	Xerox 1978	Rick Duston	14375	-21.77	5.78	5.67	British Columbia	Paper	0.36
\N	927	GBC White Gloss Covers, Plain Front	Sonia Sunley	14627	67.86	14.48	6.46	British Columbia	Binders and Binder Accessories	0.38
\N	928	GBC DocuBind 200 Manual Binding Machine	Angele Hood	14852	1234.57	420.98	19.99	British Columbia	Binders and Binder Accessories	0.35
\N	929	Self-Adhesive Address Labels for Typewriters by Universal	Sonia Sunley	16230	-7.86	7.31	0.49	British Columbia	Labels	0.38
\N	930	O'Sullivan Elevations Bookcase, Cherry Finish	Sonia Sunley	16230	-801.09	130.98	54.74	British Columbia	Bookcases	0.69
\N	931	Xerox 1891	Sonia Sunley	16230	223.76	48.91	5.81	British Columbia	Paper	0.38
\N	932	Fellowes Recycled Storage Drawers	Sonia Sunley	16230	506.86	111.03	8.64	British Columbia	Storage & Organization	0.78
\N	933	1.7 Cubic Foot Compact "Cube" Office Refrigerators	Sonia Sunley	19074	191.47	208.16	68.02	British Columbia	Appliances	0.58
\N	934	DAX Contemporary Wood Frame with Silver Metal Mat, Desktop, 11 x 14 Size	Dennis Bolton	20194	68.89	20.24	6.67	British Columbia	Office Furnishings	0.49
\N	935	Newell 312	Stewart Carmichael	21024	33.8	5.84	1.2	British Columbia	Pens & Art Supplies	0.55
\N	936	Avery 487	Dennis Bolton	21509	15.82	3.69	0.5	British Columbia	Labels	0.38
\N	937	Avery 487	Sonia Sunley	21856	71.77	3.69	0.5	British Columbia	Labels	0.38
\N	938	Serrated Blade or Curved Handle Hand Letter Openers	Sonia Sunley	21856	-47.75	3.14	1.92	British Columbia	Scissors, Rulers and Trimmers	0.84
\N	939	Eureka Hand Vacuum, Bagless	Stewart Carmichael	22119	-122.77	49.43	19.99	British Columbia	Appliances	0.57
\N	940	Airmail Envelopes	Kelly Williams	22534	-44.18	83.93	19.99	British Columbia	Envelopes	0.38
\N	941	Keytronic French Keyboard	Sonia Sunley	22629	-243.02	73.98	14.52	British Columbia	Computer Peripherals	0.65
\N	942	TDK 4.7GB DVD-R	Kelly Williams	23011	-33.93	10.01	1.99	British Columbia	Computer Peripherals	0.41
\N	943	Pressboard Covers with Storage Hooks, 9 1/2" x 11", Light Blue	Sonia Sunley	24070	-98.31	4.91	4.97	British Columbia	Binders and Binder Accessories	0.38
\N	944	Hon Olson Stacker Stools	Sonia Sunley	24070	-164.59	140.81	24.49	British Columbia	Chairs & Chairmats	0.57
\N	945	Newell 314	Sonia Sunley	24070	88.8	5.58	0.7	British Columbia	Pens & Art Supplies	0.6
\N	946	Global Ergonomic Managers Chair	Sonia Sunley	24737	-210.97	180.98	26.2	British Columbia	Chairs & Chairmats	0.59
\N	947	Xerox 1995	Sonia Sunley	24737	-28.15	6.48	5.19	British Columbia	Paper	0.37
\N	948	Belkin 8 Outlet Surge Protector	Anna Andreadi	26373	2.3	40.98	5.33	British Columbia	Appliances	0.57
\N	949	Canon Image Class D660 Copier	Seth Vernon	26978	-635.69	599.99	24.49	British Columbia	Copiers and Fax	0.44
\N	950	Xerox 1919	Seth Vernon	26978	938.26	40.99	5.86	British Columbia	Paper	0.36
\N	951	Eldon Jumbo ProFile™ Portable File Boxes Graphite/Black	Seth Vernon	26978	-157.44	15.31	8.78	British Columbia	Storage & Organization	0.57
\N	952	Accessory27	Alex Avila	27174	-245.56	35.99	5	British Columbia	Telephones and Communication	0.85
\N	953	Berol Giant Pencil Sharpener	Sarah Foster	27876	-70.54	16.99	8.99	British Columbia	Pens & Art Supplies	0.56
\N	954	Verbatim DVD-R 4.7GB authoring disc	Alex Avila	28582	423.87	39.24	1.99	British Columbia	Computer Peripherals	0.51
\N	955	TOPS Money Receipt Book, Consecutively Numbered in Red,	Alex Avila	28582	87.96	8.01	2.87	British Columbia	Paper	0.4
\N	956	Xerox 227	Anna Andreadi	28868	-142.3	6.48	8.73	British Columbia	Paper	0.37
\N	957	Sauder Forest Hills Library, Woodland Oak Finish	Angele Hood	29857	-639.47	140.98	36.09	British Columbia	Bookcases	0.77
\N	958	GBC VeloBinder Electric Binding Machine	Sonia Sunley	29921	1733.47	120.98	9.07	British Columbia	Binders and Binder Accessories	0.35
\N	959	Accessory4	Kelly Williams	30659	-106.51	85.99	0.99	British Columbia	Telephones and Communication	0.85
\N	960	Lesro Sheffield Collection Coffee Table, End Table, Center Table, Corner Table	Anna Andreadi	30660	-647.14	71.37	69	British Columbia	Tables	0.68
\N	961	Adams Phone Message Book, Professional, 400 Message Capacity, 5 3/6” x 11”	Alex Avila	30883	59.84	6.98	1.6	British Columbia	Paper	0.38
\N	962	Microsoft Internet Keyboard	Jim Karlsson	32871	9.72	20.97	4	British Columbia	Computer Peripherals	0.77
\N	963	Xerox 1962	Sonia Sunley	33600	-94.36	4.28	4.79	British Columbia	Paper	0.4
\N	964	636	Alex Avila	33632	-277.78	115.99	5.26	British Columbia	Telephones and Communication	0.57
\N	965	Global Commerce™ Series High-Back Swivel/Tilt Chairs	Lisa DeCherney	33665	1063.46	284.98	69.55	British Columbia	Chairs & Chairmats	0.6
\N	966	Wilson Jones Easy Flow II™ Sheet Lifters	Barbara Fisher	34434	-63.19	1.8	4.79	British Columbia	Binders and Binder Accessories	0.37
\N	967	Avery White Multi-Purpose Labels	Barbara Fisher	34434	50.66	4.98	0.49	British Columbia	Labels	0.39
\N	968	Accessory25	Barbara Fisher	34753	-63.7	20.99	0.99	British Columbia	Telephones and Communication	0.57
\N	969	Xerox 199	Lisa DeCherney	35364	-54.75	4.28	5.68	British Columbia	Paper	0.4
\N	970	Bretford Rectangular Conference Table Tops	Lisa DeCherney	35364	-871.52	376.13	85.63	British Columbia	Tables	0.74
\N	971	Bush Advantage Collection® Racetrack Conference Table	Lisa DeCherney	35364	455.02	424.21	110.2	British Columbia	Tables	0.67
\N	972	T28 WORLD	Lisa DeCherney	35364	-554.44	195.99	8.99	British Columbia	Telephones and Communication	0.6
\N	973	Hon Comfortask® Task/Swivel Chairs	Barbara Fisher	35812	-112.62	113.98	30	British Columbia	Chairs & Chairmats	0.69
\N	974	Fellowes 17-key keypad for PS/2 interface	Barbara Fisher	35812	-147.81	30.73	4	British Columbia	Computer Peripherals	0.75
\N	975	Xerox 1938	Barbara Fisher	35812	307.64	47.9	5.86	British Columbia	Paper	0.37
\N	976	Executive Impressions 12" Wall Clock	Alex Avila	37063	89.6	17.67	8.99	British Columbia	Office Furnishings	0.47
\N	977	1726 Digital Answering Machine	Roy Skaria	37281	3.31	20.99	4.81	British Columbia	Telephones and Communication	0.58
\N	978	Hon 4070 Series Pagoda™ Armless Upholstered Stacking Chairs	Angele Hood	37798	813.49	291.73	48.8	British Columbia	Chairs & Chairmats	0.56
\N	979	Rediform S.O.S. Phone Message Books	Seth Vernon	38017	45.14	4.98	0.8	British Columbia	Paper	0.36
\N	980	StarTAC 3000	Seth Vernon	38017	453.65	125.99	7.69	British Columbia	Telephones and Communication	0.59
\N	981	Staples® General Use 3-Ring Binders	Sarah Foster	38272	-20.65	1.88	1.49	British Columbia	Binders and Binder Accessories	0.37
\N	982	Adesso Programmable 142-Key Keyboard	Kelly Williams	39301	-521.09	152.48	4	British Columbia	Computer Peripherals	0.79
\N	983	ACCOHIDE® 3-Ring Binder, Blue, 1"	Dennis Bolton	39367	-146.97	4.13	5.04	British Columbia	Binders and Binder Accessories	0.38
\N	984	Ampad #10 Peel & Seel® Holiday Envelopes	Dennis Bolton	39367	5.9	4.48	2.5	British Columbia	Envelopes	0.37
\N	985	Imation 3.5" DS-HD Macintosh Formatted Diskettes, 10/Pack	Roy Skaria	39655	-72.43	7.28	3.52	British Columbia	Computer Peripherals	0.68
\N	986	Durable Pressboard Binders	Jim Karlsson	40803	9.24	3.8	1.49	British Columbia	Binders and Binder Accessories	0.38
\N	987	Global Leather and Oak Executive Chair, Black	Jim Karlsson	40803	1512.07	300.98	64.73	British Columbia	Chairs & Chairmats	0.56
\N	988	3M Organizer Strips	Barbara Fisher	40806	-41.26	5.4	7.78	British Columbia	Binders and Binder Accessories	0.37
\N	989	Xerox 1983	Anna Andreadi	43523	-97.23	5.98	5.46	British Columbia	Paper	0.36
\N	990	Advantus Map Pennant Flags and Round Head Tacks	Seth Vernon	44199	-6.33	3.95	2	British Columbia	Rubber Bands	0.53
\N	991	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Alex Avila	44231	116.1	160.98	30	British Columbia	Chairs & Chairmats	0.62
\N	992	Belkin 107-key enhanced keyboard, USB/PS/2 interface	Alex Avila	44231	-87.96	17.98	4	British Columbia	Computer Peripherals	0.79
\N	993	5185	Alex Avila	44231	311.64	115.99	8.99	British Columbia	Telephones and Communication	0.58
\N	994	Hon Every-Day® Chair Series Swivel Task Chairs	Sonia Sunley	45573	-151.46	120.98	30	British Columbia	Chairs & Chairmats	0.64
\N	995	Avery 494	Lisa DeCherney	45763	24.28	2.61	0.5	British Columbia	Labels	0.39
\N	996	Xerox 1905	Dennis Bolton	48165	-147.27	6.48	9.54	British Columbia	Paper	0.37
\N	997	Dana Halogen Swing-Arm Architect Lamp	Anthony O'Donnell	48197	154.74	40.97	14.45	British Columbia	Office Furnishings	0.57
\N	998	Maxell DVD-RAM Discs	Barbara Fisher	48484	67.96	16.48	1.99	British Columbia	Computer Peripherals	0.42
\N	999	DAX Contemporary Wood Frame with Silver Metal Mat, Desktop, 11 x 14 Size	Barbara Fisher	48484	133.83	20.24	6.67	British Columbia	Office Furnishings	0.49
\N	1000	Computer Printout Paper with Letter-Trim Perforations	Barbara Fisher	48484	153.8	18.97	9.03	British Columbia	Paper	0.37
\N	1001	StarTAC ST7868	Barbara Fisher	48484	1275.91	125.99	8.99	British Columbia	Telephones and Communication	0.55
\N	1002	Novimex Turbo Task Chair	Barbara Fisher	49153	-432.46	70.98	30	British Columbia	Chairs & Chairmats	0.73
\N	1003	Panasonic KX-P3626 Dot Matrix Printer	Dennis Bolton	49412	909.36	517.48	16.63	British Columbia	Office Machines	0.59
\N	1004	TI 36X Solar Scientific Calculator	Lisa DeCherney	49761	300.91	23.99	6.3	British Columbia	Office Machines	0.38
\N	1005	Belkin F9M820V08 8 Outlet Surge	Sarah Foster	50310	520.41	42.98	4.62	British Columbia	Appliances	0.56
\N	1006	Global Leather Task Chair, Black	Sarah Foster	50310	-444.14	89.99	42	British Columbia	Chairs & Chairmats	0.66
\N	1007	Fellowes Basic 104-Key Keyboard, Platinum	Sarah Foster	50310	34.03	20.95	4	British Columbia	Computer Peripherals	0.6
\N	1008	Fellowes Super Stor/Drawer® Files	Anna Andreadi	51072	1268.65	161.55	19.99	British Columbia	Storage & Organization	0.66
\N	1009	Zoom V.92 USB External Faxmodem	Roy Skaria	51648	332.97	49.99	19.99	British Columbia	Computer Peripherals	0.41
\N	1010	Unpadded Memo Slips	Roy Skaria	51648	-38.23	3.98	2.97	British Columbia	Paper	0.35
\N	1011	Canon PC1060 Personal Laser Copier	Roy Skaria	52035	-4437.91	699.99	24.49	British Columbia	Copiers and Fax	0.41
\N	1012	Acco Pressboard Covers with Storage Hooks, 14 7/8" x 11", Dark Blue	Dennis Bolton	52326	-154.81	3.81	5.44	British Columbia	Binders and Binder Accessories	0.36
\N	1013	GBC VeloBinder Strips	Alex Avila	52737	-15.74	7.68	6.16	British Columbia	Binders and Binder Accessories	0.35
\N	1014	Xerox 227	Roy Skaria	53216	-185.54	6.48	8.73	British Columbia	Paper	0.37
\N	1015	Memorex 4.7GB DVD+RW, 3/Pack	Seth Vernon	54081	-83.18	28.48	1.99	British Columbia	Computer Peripherals	0.4
\N	1016	Memorex 4.7GB DVD+RW, 3/Pack	Barbara Fisher	54560	167.58	28.48	1.99	British Columbia	Computer Peripherals	0.4
\N	1017	MicroTAC 650	Barbara Fisher	54560	496.89	65.99	4.99	British Columbia	Telephones and Communication	0.58
\N	1018	Imation 3.5", DISKETTE 44766 HGHLD3.52HD/FM, 10/Pack	Peter Buhler	54947	-98.35	4.98	4.62	British Columbia	Computer Peripherals	0.64
\N	1019	Hand-Finished Solid Wood Document Frame	Peter Buhler	54947	565.37	34.23	5.02	British Columbia	Office Furnishings	0.55
\N	1020	Boston 1645 Deluxe Heavier-Duty Electric Pencil Sharpener	Dennis Bolton	55170	138.37	43.98	8.99	British Columbia	Pens & Art Supplies	0.58
\N	1021	Howard Miller 13-3/4" Diameter Brushed Chrome Round Wall Clock	Roy Skaria	55777	136.32	51.75	19.99	British Columbia	Office Furnishings	0.55
\N	1022	StarTAC 7760	Roy Skaria	55777	-252.48	65.99	3.99	British Columbia	Telephones and Communication	0.59
\N	1023	Xerox 210	Alex Avila	56001	-60.65	6.48	7.37	British Columbia	Paper	0.37
\N	1024	Personal Creations™ Ink Jet Cards and Labels	Anthony O'Donnell	56640	-12.78	11.48	5.43	British Columbia	Paper	0.36
\N	1025	Xerox 1923	Anthony O'Donnell	56640	-22.55	6.68	5.66	British Columbia	Paper	0.37
\N	1026	Peel & Seel® Recycled Catalog Envelopes, Brown	Seth Vernon	59393	0.82	11.58	6.97	British Columbia	Envelopes	0.35
\N	1027	Staples Metal Binder Clips	Sonia Sunley	59712	16.8	2.62	0.8	British Columbia	Rubber Bands	0.39
\N	1028	Hewlett-Packard 4.7GB DVD+R Discs	Daniel Lacy	59905	8.3	8.5	1.99	British Columbia	Computer Peripherals	0.49
\N	1029	It's Hot Message Books with Stickers, 2 3/4" x 5"	Daniel Lacy	59905	5.95	7.4	1.71	British Columbia	Paper	0.4
\N	1030	Dixon Prang® Watercolor Pencils, 10-Color Set with Brush	Daniel Lacy	59905	2.61	4.26	1.2	British Columbia	Pens & Art Supplies	0.44
\N	1031	I888 World Phone	Giulietta Weimer	322	257.76	155.99	8.08	British Columbia	Telephones and Communication	0.6
\N	1032	Xerox 1997	Giulietta Weimer	322	-291.59	6.48	10.05	British Columbia	Paper	0.37
\N	1033	GBC Therma-A-Bind 250T Electric Binding System	Mike Vittorini	962	1408.19	122.99	19.99	British Columbia	Binders and Binder Accessories	0.37
\N	1034	Holmes Replacement Filter for HEPA Air Cleaner, Very Large Room, HEPA Filter	Mike Vittorini	962	-1069.72	68.81	60	British Columbia	Appliances	0.41
\N	1035	Avery Printable Repositionable Plastic Tabs	Lela Donovan	1221	-13.78	8.6	6.19	British Columbia	Binders and Binder Accessories	0.38
\N	1036	GBC DocuBind TL300 Electric Binding System	Lela Donovan	1221	3724.57	896.99	19.99	British Columbia	Binders and Binder Accessories	0.38
\N	1037	Storex DuraTech Recycled Plastic Frosted Binders	Lela Donovan	1221	-57.88	4.24	5.41	British Columbia	Binders and Binder Accessories	0.35
\N	1038	GBC DocuBind 200 Manual Binding Machine	Shahid Shariari	1445	-20.55	420.98	19.99	British Columbia	Binders and Binder Accessories	0.35
\N	1039	Staples SlimLine Pencil Sharpener	Shahid Shariari	1445	-74.21	11.97	5.81	British Columbia	Pens & Art Supplies	0.6
\N	1040	Hon Comfortask® Task/Swivel Chairs	Trudy Schmidt	1799	-127.3	113.98	30	British Columbia	Chairs & Chairmats	0.69
\N	1041	Xerox 204	Trudy Schmidt	1799	-52.77	6.48	6.86	British Columbia	Paper	0.37
\N	1042	StarTAC 7760	Christopher Martinez	2720	483.97	65.99	3.99	British Columbia	Telephones and Communication	0.59
\N	1043	Newell 35	Mike Vittorini	3685	-98.05	3.28	5	British Columbia	Pens & Art Supplies	0.56
\N	1044	Acco® Hot Clips™ Clips to Go	Marc Harrigan	3687	6.14	3.29	1.35	British Columbia	Rubber Bands	0.4
\N	1045	Hoover Portapower™ Portable Vacuum	Christopher Martinez	3907	-1642.65	4.48	49	British Columbia	Appliances	0.6
\N	1046	Wilson Jones Hanging View Binder, White, 1"	Shahid Shariari	4067	-42.46	7.1	6.05	British Columbia	Binders and Binder Accessories	0.39
\N	1047	Staples Brown Kraft Recycled Clasp Envelopes	Liz Price	4257	-83.66	5.58	5.3	British Columbia	Envelopes	0.35
\N	1048	Holmes Replacement Filter for HEPA Air Cleaner, Very Large Room, HEPA Filter	Lela Donovan	4261	-521.42	68.81	60	British Columbia	Appliances	0.41
\N	1049	Xerox 1947	Lela Donovan	4261	-71.47	5.98	5.35	British Columbia	Paper	0.4
\N	1050	Honeywell Enviracaire Portable HEPA Air Cleaner for 17' x 22' Room	Lela Donovan	4261	2848.17	300.65	24.49	British Columbia	Appliances	0.52
\N	1051	Xerox 1950	Lela Donovan	4261	-94.82	5.78	5.37	British Columbia	Paper	0.36
\N	1052	Eldon Regeneration Recycled Desk Accessories, Smoke	Mike Vittorini	4294	-15.34	1.74	4.08	British Columbia	Office Furnishings	0.53
\N	1053	Imation 3.5" DS-HD Macintosh Formatted Diskettes, 10/Pack	Shahid Shariari	4642	-39.74	7.28	3.52	British Columbia	Computer Peripherals	0.68
\N	1054	Project Tote Personal File	Shahid Shariari	4642	-80.2	14.03	9.37	British Columbia	Storage & Organization	0.56
\N	1055	GBC ProClick™ 150 Presentation Binding System	Ralph Kennedy	4864	1724.68	315.98	19.99	British Columbia	Binders and Binder Accessories	0.38
\N	1056	Letter Size Cart	Rob Dowd	4996	1020.32	142.86	19.99	British Columbia	Storage & Organization	0.56
\N	1057	Accessory2	Ralph Kennedy	5121	559.11	55.99	1.25	British Columbia	Telephones and Communication	0.55
\N	1058	Eldon ClusterMat Chair Mat with Cordless Antistatic Protection	Khloe Miller	5346	-1448.83	90.98	56.2	British Columbia	Office Furnishings	0.74
\N	1059	BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	Khloe Miller	5346	-1760.57	218.75	69.64	British Columbia	Tables	0.77
\N	1060	Sauder Forest Hills Library, Woodland Oak Finish	Khloe Miller	5346	-455.8	140.98	36.09	British Columbia	Bookcases	0.77
\N	1061	#10- 4 1/8" x 9 1/2" Recycled Envelopes	Shahid Hopkins	5473	-149.46	8.74	8.29	British Columbia	Envelopes	0.38
\N	1062	Kensington 6 Outlet Guardian Standard Surge Protector	Kristina Nunn	5698	-16.89	20.48	6.32	British Columbia	Appliances	0.58
\N	1063	#10 White Business Envelopes,4 1/8 x 9 1/2	Kristina Nunn	5698	25.51	15.67	1.39	British Columbia	Envelopes	0.38
\N	1064	Avery 492	Ralph Kennedy	6144	22.63	2.88	0.5	British Columbia	Labels	0.39
\N	1065	Bretford CR4500 Series Slim Rectangular Table	Ralph Kennedy	6144	-223.59	348.21	40.19	British Columbia	Tables	0.62
\N	1066	Imation 3.5" Diskettes, IBM Format, DS/HD, 10/Box, Neon	Ricardo Emerson	6374	51.18	31.11	3.6	British Columbia	Computer Peripherals	0.64
\N	1067	Binder Clips by OIC	Ricardo Emerson	6374	-1.97	1.48	0.7	British Columbia	Rubber Bands	0.37
\N	1068	Career Cubicle Clock, 8 1/4", Black	Lela Donovan	7169	-39	20.28	14.39	British Columbia	Office Furnishings	0.47
\N	1069	V8162	Lela Donovan	7169	303.53	65.99	2.79	British Columbia	Telephones and Communication	0.56
\N	1070	Hoover WindTunnel™ Plus Canister Vacuum	Ricardo Emerson	7427	4604.79	363.25	19.99	British Columbia	Appliances	0.57
\N	1071	Flexible Leather- Look Classic Collection Ring Binder	Ricardo Emerson	7427	60.61	18.94	1.49	British Columbia	Binders and Binder Accessories	0.35
\N	1072	Okidata ML520 Series Dot Matrix Printers	Patrick O'Brill	8229	-502.81	510.14	14.7	British Columbia	Office Machines	0.56
\N	1073	TOPS Voice Message Log Book, Flash Format	Patrick O'Brill	8229	-4.69	4.76	3.01	British Columbia	Paper	0.36
\N	1074	Avery 48	Patrick O'Brill	8290	101.8	6.3	0.5	British Columbia	Labels	0.39
\N	1075	Fellowes Basic 104-Key Keyboard, Platinum	Trudy Schmidt	8515	99.31	20.95	4	British Columbia	Computer Peripherals	0.6
\N	1076	Eldon Cleatmat Plus™ Chair Mats for High Pile Carpets	Thomas Brumley	8801	-673.31	79.52	48.2	British Columbia	Office Furnishings	0.74
\N	1077	270c	Thomas Brumley	8801	371.21	125.99	3	British Columbia	Telephones and Communication	0.59
\N	1078	Hon Olson Stacker Stools	Shahid Shariari	8992	-154.45	140.81	24.49	British Columbia	Chairs & Chairmats	0.57
\N	1079	688	Shahid Shariari	8992	-176.79	195.99	4.2	British Columbia	Telephones and Communication	0.6
\N	1080	6340	Shahid Shariari	8992	180.78	85.99	2.79	British Columbia	Telephones and Communication	0.58
\N	1081	Adesso Programmable 142-Key Keyboard	Vicky Freymann	9409	-390.77	152.48	4	British Columbia	Computer Peripherals	0.79
\N	1082	DAX Clear Channel Poster Frame	Lela Donovan	10306	51.5	14.58	7.4	British Columbia	Office Furnishings	0.48
\N	1083	Eldon® Expressions™ Wood Desk Accessories, Oak	Khloe Miller	10470	-94.78	7.38	5.21	British Columbia	Office Furnishings	0.56
\N	1084	Xerox 1905	Mike Vittorini	10819	-197.39	6.48	9.54	British Columbia	Paper	0.37
\N	1085	Binder Posts	Trudy Schmidt	10916	-49.32	5.74	5.01	British Columbia	Binders and Binder Accessories	0.39
\N	1086	Canon P1-DHIII Palm Printing Calculator	Mike Vittorini	10944	-27.47	17.98	8.51	British Columbia	Office Machines	0.4
\N	1087	Microsoft Natural Keyboard Elite	Tony Chapman	11301	107.45	39.98	4	British Columbia	Computer Peripherals	0.7
\N	1088	Accessory41	Liz Price	11332	-89.2	35.99	5.99	British Columbia	Telephones and Communication	0.38
\N	1089	i500plus	Liz Price	11332	83.57	65.99	5.92	British Columbia	Telephones and Communication	0.58
\N	1090	Presstex Flexible Ring Binders	Sarah Bern	11392	28.29	4.55	1.49	British Columbia	Binders and Binder Accessories	0.35
\N	1091	Keytronic Designer 104- Key Black Keyboard	Mark Cousins	11745	-345.36	40.48	19.99	British Columbia	Computer Peripherals	0.77
\N	1092	Eldon Simplefile® Box Office®	Shahid Hopkins	11875	-36.11	12.44	6.27	British Columbia	Storage & Organization	0.57
\N	1093	Hewlett-Packard Deskjet 3820 Color Inkjet Printer	Mark Cousins	11907	2014.82	100.97	14	British Columbia	Office Machines	0.37
\N	1094	Global High-Back Leather Tilter, Burgundy	Giulietta Weimer	12129	-1197.58	122.99	70.2	British Columbia	Chairs & Chairmats	0.74
\N	1095	White GlueTop Scratch Pads	Patrick O'Brill	12579	1.07	15.04	1.97	British Columbia	Paper	0.39
\N	1096	Accessory25	Mark Cousins	12743	168.22	20.99	0.99	British Columbia	Telephones and Communication	0.57
\N	1097	Belkin ErgoBoard™ Keyboard	Daniel Byrd	12902	-58.81	30.98	6.5	British Columbia	Computer Peripherals	0.64
\N	1098	Newell 346	Rob Dowd	13380	4.85	2.88	0.7	British Columbia	Pens & Art Supplies	0.56
\N	1099	Avery Hi-Liter® Fluorescent Desk Style Markers	Mike Vittorini	13606	19.04	3.38	0.85	British Columbia	Pens & Art Supplies	0.48
\N	1100	Global Enterprise™ Series Seating Low-Back Swivel/Tilt Chairs	John Murray	13889	2820.44	258.98	54.31	British Columbia	Chairs & Chairmats	0.55
\N	1101	Tenex Carpeted, Granite-Look or Clear Contemporary Contour Shape Chair Mats	Khloe Miller	13984	-870.61	70.71	37.58	British Columbia	Office Furnishings	0.78
\N	1102	80 Minute CD-R Spindle, 100/Pack - Staples	Kristina Nunn	13986	675.65	39.48	1.99	British Columbia	Computer Peripherals	0.54
\N	1103	Acco Suede Grain Vinyl Round Ring Binder	Ralph Kennedy	14240	1.31	2.78	1.49	British Columbia	Binders and Binder Accessories	0.39
\N	1104	Staples Battery-Operated Desktop Pencil Sharpener	Lela Donovan	14276	-11.13	10.48	2.89	British Columbia	Pens & Art Supplies	0.6
\N	1105	3M Polarizing Light Filter Sleeves	Ralph Kennedy	14471	375.02	18.65	3.77	British Columbia	Office Furnishings	0.39
\N	1106	Xerox 220	Ralph Kennedy	14471	-141.51	6.48	7.49	British Columbia	Paper	0.37
\N	1107	Global Leather Task Chair, Black	Lena Hernandez	14529	-821.87	89.99	42	British Columbia	Chairs & Chairmats	0.66
\N	1108	Master Caster Door Stop, Brown	Lena Hernandez	14529	24.87	5.08	2.03	British Columbia	Office Furnishings	0.51
\N	1109	Bush Westfield Collection Bookcases, Fully Assembled	Shahid Hopkins	14948	-144.87	100.98	35.84	British Columbia	Bookcases	0.62
\N	1110	6162i	Kristina Nunn	16161	768.32	65.99	4.2	British Columbia	Telephones and Communication	0.55
\N	1111	Staples Bulldog Clip	Kristina Nunn	16161	60.63	3.78	0.71	British Columbia	Rubber Bands	0.39
\N	1112	Wausau Papers Astrobrights® Colored Envelopes	Greg Maxwell	16257	16.33	5.98	2.5	British Columbia	Envelopes	0.36
\N	1113	Fellowes Mobile Numeric Keypad, Graphite	Vicky Freymann	16806	-132.15	43.22	4	British Columbia	Computer Peripherals	0.64
\N	1114	iDENi80s	Vicky Freymann	16806	-201.05	65.99	19.99	British Columbia	Telephones and Communication	0.59
\N	1115	5190	Rob Dowd	17344	571.54	65.99	7.69	British Columbia	Telephones and Communication	0.59
\N	1116	M70	Lena Hernandez	17382	223.25	125.99	8.99	British Columbia	Telephones and Communication	0.59
\N	1117	Acco 6 Outlet Guardian Premium Surge Suppressor	Lela Donovan	17507	48.13	14.56	3.5	British Columbia	Appliances	0.58
\N	1118	Epson LQ-570e Dot Matrix Printer	Lela Donovan	17507	353.72	270.97	28.06	British Columbia	Office Machines	0.56
\N	1119	Belkin MediaBoard 104- Keyboard	Mark Cousins	17702	-66.78	27.48	4	British Columbia	Computer Peripherals	0.75
\N	1120	G.E. Halogen Desk Lamp Bulbs	Ricardo Emerson	17831	41.31	6.98	2.83	British Columbia	Office Furnishings	0.37
\N	1121	Xerox 1947	Ricardo Emerson	17831	-45.75	5.98	5.35	British Columbia	Paper	0.4
\N	1122	Imation 5.2GB DVD-RAM	Liz Price	18179	1207.91	60.98	1.99	British Columbia	Computer Peripherals	0.5
\N	1123	Avery 481	Liz Price	18179	16.1	3.08	0.99	British Columbia	Labels	0.37
\N	1124	Speediset Carbonless Redi-Letter® 7" x 8 1/2"	Liz Price	18179	221.59	10.31	1.79	British Columbia	Paper	0.38
\N	1125	Canon MP41DH Printing Calculator	Rob Dowd	19044	1912.92	150.98	13.99	British Columbia	Office Machines	0.38
\N	1126	Filing/Storage Totes and Swivel Casters	Rob Dowd	19044	-191.09	9.71	9.45	British Columbia	Storage & Organization	0.6
\N	1127	Carina Double Wide Media Storage Towers in Natural & Black	Mark Cousins	19462	-156.47	80.98	35	British Columbia	Storage & Organization	0.81
\N	1128	Staples® General Use 3-Ring Binders	Giulietta Weimer	19936	-9.82	1.88	1.49	British Columbia	Binders and Binder Accessories	0.37
\N	1129	Verbatim DVD-RAM, 5.2GB, Rewritable, Type 1, DS	Giulietta Weimer	19936	301.31	29.89	1.99	British Columbia	Computer Peripherals	0.5
\N	1130	GE 4 Foot Flourescent Tube, 40 Watt	Liz Price	19972	-21.09	14.98	8.99	British Columbia	Office Furnishings	0.39
\N	1131	Eldon Image Series Black Desk Accessories	Sally Knutson	20038	-172.4	4.14	6.6	British Columbia	Office Furnishings	0.49
\N	1132	Atlantic Metals Mobile 3-Shelf Bookcases, Custom Colors	Liz Price	20389	883.29	260.98	41.91	British Columbia	Bookcases	0.59
\N	1133	Ultra Door Pull Handle	Liz Price	20389	-30.42	10.52	7.94	British Columbia	Office Furnishings	0.52
\N	1134	Xerox 1920	Liz Price	20389	-107.37	5.98	7.5	British Columbia	Paper	0.4
\N	1135	Avery 498	Gene Hale	20422	1.61	2.89	0.5	British Columbia	Labels	0.38
\N	1136	Staples® General Use 3-Ring Binders	Shahid Shariari	20676	-9.05	1.88	1.49	British Columbia	Binders and Binder Accessories	0.37
\N	1137	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Justin Hirsh	20807	768.06	160.98	30	British Columbia	Chairs & Chairmats	0.62
\N	1138	Newell 342	Shahid Shariari	20838	-15.42	3.28	3.97	British Columbia	Pens & Art Supplies	0.56
\N	1139	Fiskars® Softgrip Scissors	Shahid Shariari	20838	11.82	10.98	3.37	British Columbia	Scissors, Rulers and Trimmers	0.57
\N	1140	Micro Innovations 104 Keyboard	Giulietta Weimer	20960	-104.82	10.97	6.5	British Columbia	Computer Peripherals	0.64
\N	1141	Canon PC-428 Personal Copier	Lela Donovan	20961	1462.72	199.99	24.49	British Columbia	Copiers and Fax	0.46
\N	1142	Southworth 25% Cotton Linen-Finish Paper & Envelopes	Ralph Kennedy	21350	-143.7	9.06	9.86	British Columbia	Paper	0.4
\N	1143	Electrix Halogen Magnifier Lamp	Vicky Freymann	21572	2861.01	194.3	11.54	British Columbia	Office Furnishings	0.59
\N	1144	Verbatim DVD-RAM, 9.4GB, Rewritable, Type 1, DS, DataLife Plus	Thomas Brumley	21671	87.51	45.19	1.99	British Columbia	Computer Peripherals	0.55
\N	1145	Hayes Optima 56K V.90 Internal Voice Modem	Ralph Kennedy	22657	3392.88	256.99	11.25	British Columbia	Computer Peripherals	0.51
\N	1146	Advantus Map Pennant Flags and Round Head Tacks	Ralph Kennedy	22657	-7.73	3.95	2	British Columbia	Rubber Bands	0.53
\N	1147	Xerox 1979	Ralph Kennedy	23207	42.5	30.98	8.74	British Columbia	Paper	0.4
\N	1148	Hoover Portapower™ Portable Vacuum	Khloe Miller	23940	-895.24	4.48	49	British Columbia	Appliances	0.6
\N	1149	Global Leather & Oak Executive Chair, Burgundy	Khloe Miller	23940	-506.43	150.89	60.2	British Columbia	Chairs & Chairmats	0.77
\N	1150	Staples 6 Outlet Surge	Kristina Nunn	24450	-21.73	11.97	4.98	British Columbia	Appliances	0.58
\N	1151	DAX Two-Tone Rosewood/Black Document Frame, Desktop, 5 x 7	Kristina Nunn	24450	-100.15	9.48	7.29	British Columbia	Office Furnishings	0.45
\N	1152	Xerox 1903	Kristina Nunn	24450	-12.88	5.98	5.79	British Columbia	Paper	0.36
\N	1153	Boston 1645 Deluxe Heavier-Duty Electric Pencil Sharpener	Mark Cousins	24580	130.8	43.98	8.99	British Columbia	Pens & Art Supplies	0.58
\N	1154	Eldon Pizzaz™ Desk Accessories	Mark Cousins	24580	-31.45	2.23	4.57	British Columbia	Office Furnishings	0.41
\N	1155	Bevis 36 x 72 Conference Tables	Sally Knutson	24833	-818.77	124.49	51.94	British Columbia	Tables	0.63
\N	1156	Bush Westfield Collection Bookcases, Dark Cherry Finish, Fully Assembled	Shahid Shariari	24933	-1142.2	100.98	57.38	British Columbia	Bookcases	0.78
\N	1157	Staples Wirebound Steno Books, 6" x 9", 12/Pack	Shahid Shariari	24933	39.64	10.14	2.27	British Columbia	Paper	0.36
\N	1158	Hon 2111 Invitation™ Series Corner Table	Sally Knutson	25031	-318.45	209.37	69	British Columbia	Tables	0.79
\N	1159	Staples Copy Paper (20Lb. and 84 Bright)	Sally Knutson	25031	-41.7	4.98	4.7	British Columbia	Paper	0.38
\N	1160	Bevis Rectangular Conference Tables	Sally Knutson	25633	-582.43	145.98	51.92	British Columbia	Tables	0.69
\N	1161	Belkin F9M820V08 8 Outlet Surge	Sally Knutson	25635	145.48	42.98	4.62	British Columbia	Appliances	0.56
\N	1162	Master Caster Door Stop, Gray	Sally Knutson	25635	-36.6	5.08	3.63	British Columbia	Office Furnishings	0.51
\N	1163	Eureka Disposable Bags for Sanitaire® Vibra Groomer I® Upright Vac	Justin Hirsh	25830	-21.29	4.06	6.89	British Columbia	Appliances	0.6
\N	1164	Recycled Premium Regency Composition Covers	Justin Hirsh	25830	-37.39	15.28	10.91	British Columbia	Binders and Binder Accessories	0.36
\N	1165	Hammermill Color Copier Paper (28Lb. and 96 Bright)	Khloe Miller	26342	-128.69	9.99	11.59	British Columbia	Paper	0.4
\N	1166	Xerox 1937	Khloe Miller	26342	931.7	48.04	5.79	British Columbia	Paper	0.37
\N	1167	Xerox 1986	Khloe Miller	26342	-10.77	6.68	4.91	British Columbia	Paper	0.37
\N	1168	Accessory12	Shahid Shariari	26368	795.05	85.99	2.5	British Columbia	Telephones and Communication	0.35
\N	1169	Verbatim DVD-RAM, 5.2GB, Rewritable, Type 1, DS	Ralph Kennedy	26372	-74.64	29.89	1.99	British Columbia	Computer Peripherals	0.5
\N	1170	Microsoft Multimedia Keyboard	Giulietta Weimer	26756	-29.56	30.97	4	British Columbia	Computer Peripherals	0.74
\N	1171	Xerox 1894	Giulietta Weimer	26756	-103.77	6.48	6.22	British Columbia	Paper	0.37
\N	1172	Xerox 210	Giulietta Weimer	26756	-80.41	6.48	7.37	British Columbia	Paper	0.37
\N	1173	BASF Silver 74 Minute CD-R	Heather Jas	26851	-58.87	1.7	1.99	British Columbia	Computer Peripherals	0.51
\N	1174	Accessory32	Vicky Freymann	26981	142.98	55.99	1.25	British Columbia	Telephones and Communication	0.35
\N	1343	StarTAC Series	Art Ferguson	5511	482.45	65.99	3.9	Nova Scotia	Telephones and Communication	0.55
\N	1175	Tenex Personal Self-Stacking Standard File Box, Black/Gray	Vicky Freymann	26981	30.17	16.91	6.25	British Columbia	Storage & Organization	0.58
\N	1176	Canon PC-428 Personal Copier	Philisse Overcash	27298	2154.33	199.99	24.49	British Columbia	Copiers and Fax	0.46
\N	1177	Xerox 190	Philisse Overcash	27298	-54.36	4.98	4.86	British Columbia	Paper	0.38
\N	1178	Eldon Cleatmat® Chair Mats for Medium Pile Carpets	Mark Cousins	27330	-118.54	55.5	52.2	British Columbia	Office Furnishings	0.72
\N	1179	Okidata ML390 Turbo Dot Matrix Printers	Mark Cousins	27330	2963.48	442.14	14.7	British Columbia	Office Machines	0.56
\N	1180	Colored Envelopes	Shahid Hopkins	27781	-11.39	3.69	2.5	British Columbia	Envelopes	0.39
\N	1181	Career Cubicle Clock, 8 1/4", Black	Khloe Miller	28225	-49.81	20.28	14.39	British Columbia	Office Furnishings	0.47
\N	1182	Advantus Employee of the Month Certificate Frame, 11 x 13-1/2	Mark Cousins	28389	344.61	30.93	3.92	British Columbia	Office Furnishings	0.44
\N	1183	Panasonic KX-P3200 Dot Matrix Printer	Mark Cousins	28389	322.66	297.48	18.06	British Columbia	Office Machines	0.6
\N	1184	Hon 94000 Series Round Tables	Mark Cousins	28389	-404.05	296.18	54.12	British Columbia	Tables	0.76
\N	1185	Xerox 196	Mark Cousins	28898	-207.36	5.78	7.96	British Columbia	Paper	0.36
\N	1186	Xerox 1919	Trudy Schmidt	28901	315.16	40.99	5.86	British Columbia	Paper	0.36
\N	1187	Conquest™ 14 Commercial Heavy-Duty Upright Vacuum, Collection System, Accessory Kit	Rob Dowd	29185	-6.37	56.96	13.22	British Columbia	Appliances	0.56
\N	1188	Westinghouse Clip-On Gooseneck Lamps	Rob Dowd	29185	-261.45	8.37	10.16	British Columbia	Office Furnishings	0.59
\N	1189	Xerox 1893	Rob Dowd	29185	-25.31	40.99	17.48	British Columbia	Paper	0.36
\N	1190	Hewlett-Packard 2600DN Business Color Inkjet Printer	Neil Knudson	29408	251.58	119.99	56.14	British Columbia	Office Machines	0.39
\N	1191	Staples Plastic Wall Frames	Khloe Miller	29985	0.13	7.96	4.95	British Columbia	Office Furnishings	0.41
\N	1192	Vinyl Sectional Post Binders	Rob Dowd	29986	641.4	37.7	2.99	British Columbia	Binders and Binder Accessories	0.35
\N	1193	12-1/2 Diameter Round Wall Clock	Cathy Armstrong	30147	29.73	19.98	10.49	British Columbia	Office Furnishings	0.49
\N	1194	Round Ring Binders	Mark Cousins	30149	-6.82	2.08	1.49	British Columbia	Binders and Binder Accessories	0.38
\N	1195	Metal Folding Chairs, Beige, 4/Carton	Mark Cousins	30149	-88.64	33.94	19.19	British Columbia	Chairs & Chairmats	0.58
\N	1196	9-3/4 Diameter Round Wall Clock	Mark Cousins	30149	-16.94	13.79	8.78	British Columbia	Office Furnishings	0.43
\N	1197	StarTAC 6500	Thomas Brumley	30310	4.9	125.99	8.8	British Columbia	Telephones and Communication	0.59
\N	1198	i2000	Greg Maxwell	31426	914.19	125.99	2.5	British Columbia	Telephones and Communication	0.6
\N	1199	Ames Color-File® Green Diamond Border X-ray Mailers	Vicky Freymann	31872	1409.87	83.98	5.01	British Columbia	Envelopes	0.38
\N	1200	Hon Non-Folding Utility Tables	Vicky Freymann	31872	-265.12	159.31	60	British Columbia	Tables	0.55
\N	1201	Fiskars® Softgrip Scissors	Shahid Shariari	31874	20.76	10.98	3.37	British Columbia	Scissors, Rulers and Trimmers	0.57
\N	1202	Bretford CR4500 Series Slim Rectangular Table	Shahid Shariari	31874	275.93	348.21	84.84	British Columbia	Tables	0.66
\N	1203	Global Leather Task Chair, Black	Shahid Shariari	31938	-304.47	89.99	42	British Columbia	Chairs & Chairmats	0.66
\N	1204	Master Giant Foot® Doorstop, Safety Yellow	Shahid Shariari	31938	40.58	7.59	4	British Columbia	Office Furnishings	0.42
\N	1205	Deflect-o DuraMat Antistatic Studded Beveled Mat for Medium Pile Carpeting	Tony Chapman	32582	595.38	105.34	24.49	British Columbia	Office Furnishings	0.61
\N	1206	Economy Binders	Neil Knudson	32611	-7.15	2.08	1.49	British Columbia	Binders and Binder Accessories	0.36
\N	1207	Office Star - Ergonomic Mid Back Chair with 2-Way Adjustable Arms	Neil Knudson	32611	232.78	180.98	30	British Columbia	Chairs & Chairmats	0.69
\N	1208	Nu-Form 106-Key Ergonomic Keyboard w/ Touchpad	Neil Knudson	32611	68.9	53.98	5.5	British Columbia	Computer Peripherals	0.62
\N	1209	Xerox 1989	Neil Knudson	32611	-31.99	4.98	5.02	British Columbia	Paper	0.38
\N	1210	Avery 496	Neil Knudson	32901	17.7	3.75	0.5	British Columbia	Labels	0.37
\N	1211	Executive Impressions 14" Contract Wall Clock with Quartz Movement	Lela Donovan	33284	144.66	22.23	8.99	British Columbia	Office Furnishings	0.41
\N	1212	Epson LQ-570e Dot Matrix Printer	Mike Vittorini	33287	3909.33	270.97	28.06	British Columbia	Office Machines	0.56
\N	1213	Eldon Expressions™ Desk Accessory, Wood Pencil Holder, Oak	Heather Jas	33732	-28.16	9.65	6.22	British Columbia	Office Furnishings	0.55
\N	1214	Staples Battery-Operated Desktop Pencil Sharpener	Justin Hirsh	34435	40.92	10.48	2.89	British Columbia	Pens & Art Supplies	0.6
\N	1215	Round Ring Binders	Rob Dowd	34852	-10.95	2.08	1.49	British Columbia	Binders and Binder Accessories	0.38
\N	1216	Tuff Stuff™ Recycled Round Ring Binders	Justin Hirsh	35649	3.9	4.82	1.49	British Columbia	Binders and Binder Accessories	0.36
\N	1217	Xerox 1994	Justin Hirsh	35649	-42.37	6.48	5.74	British Columbia	Paper	0.37
\N	1218	Lock-Up Easel 'Spel-Binder'	Lela Donovan	36480	502.49	28.53	1.49	British Columbia	Binders and Binder Accessories	0.38
\N	1219	Avery 514	Ralph Kennedy	36803	30.76	2.88	0.99	British Columbia	Labels	0.36
\N	1220	Eldon® Wave Desk Accessories	Ralph Kennedy	36803	10.73	2.08	5.33	British Columbia	Office Furnishings	0.43
\N	1221	V8160	Ralph Kennedy	36803	-316.32	65.99	2.5	British Columbia	Telephones and Communication	0.56
\N	1222	Hand-Finished Solid Wood Document Frame	Shahid Shariari	36805	165.33	34.23	5.02	British Columbia	Office Furnishings	0.55
\N	1223	g520	Shahid Shariari	36805	226.72	65.99	5.26	British Columbia	Telephones and Communication	0.59
\N	1224	Rush Hierlooms Collection 1" Thick Stackable Bookcases	Rob Dowd	36834	-42.96	170.98	35.89	British Columbia	Bookcases	0.66
\N	1225	Hewlett-Packard Deskjet 1220Cse Color Inkjet Printer	Chuck Clark	37410	8504.47	400.97	48.26	British Columbia	Office Machines	0.36
\N	1226	Avery Printable Repositionable Plastic Tabs	Giulietta Weimer	37729	-26.78	8.6	6.19	British Columbia	Binders and Binder Accessories	0.38
\N	1227	Letter/Legal File Tote with Clear Snap-On Lid, Black Granite	Khloe Miller	37988	-56.71	16.06	8.34	British Columbia	Storage & Organization	0.59
\N	1228	TI 36X Solar Scientific Calculator	Shahid Shariari	38690	169.89	23.99	6.3	British Columbia	Office Machines	0.38
\N	1229	Euro Pro Shark Stick Mini Vacuum	Justin Hirsh	38758	-219.61	60.98	49	British Columbia	Appliances	0.59
\N	1230	Dana Halogen Swing-Arm Architect Lamp	Khloe Miller	39332	-34.43	40.97	14.45	British Columbia	Office Furnishings	0.57
\N	1231	Hewlett-Packard Deskjet 5550 Color Inkjet Printer	Ralph Kennedy	39745	-286.2	115.99	56.14	British Columbia	Office Machines	0.4
\N	1232	Belkin 6 Outlet Metallic Surge Strip	Shahid Hopkins	40134	-21.66	10.89	4.5	British Columbia	Appliances	0.59
\N	1233	Memorex 4.7GB DVD-RAM, 3/Pack	Shahid Hopkins	40134	674.46	31.78	1.99	British Columbia	Computer Peripherals	0.42
\N	1234	Xerox 1949	Shahid Hopkins	40134	-6.72	4.98	4.72	British Columbia	Paper	0.36
\N	1235	Seth Thomas 12" Clock w/ Goldtone Case	Chuck Clark	40164	75.63	22.98	7.58	British Columbia	Office Furnishings	0.51
\N	1236	Xerox 1939	Bill Eplett	40608	55.82	18.97	9.54	British Columbia	Paper	0.37
\N	1237	Xerox 4200 Series MultiUse Premium Copy Paper (20Lb. and 84 Bright)	Bill Eplett	40608	-89.88	5.28	5.66	British Columbia	Paper	0.4
\N	1238	Xerox 1894	Sarah Bern	40801	-56.15	6.48	6.22	British Columbia	Paper	0.37
\N	1239	Xerox 1979	Mark Cousins	40965	168.76	30.98	8.74	British Columbia	Paper	0.4
\N	1240	Xerox 1894	Lena Hernandez	41286	-96.7	6.48	6.22	British Columbia	Paper	0.37
\N	1241	3M Organizer Strips	Shahid Shariari	41412	-237.54	5.4	7.78	British Columbia	Binders and Binder Accessories	0.37
\N	1242	3M Hangers With Command Adhesive	Khloe Miller	41569	5.25	3.7	1.61	British Columbia	Office Furnishings	0.44
\N	1243	Global High-Back Leather Tilter, Burgundy	Bill Eplett	41633	-1284.24	122.99	70.2	British Columbia	Chairs & Chairmats	0.74
\N	1244	Canon imageCLASS 2200 Advanced Copier	Tony Chapman	41895	-391.92	3499.99	24.49	British Columbia	Copiers and Fax	0.37
\N	1245	T28 WORLD	Bill Eplett	42112	201.03	195.99	8.99	British Columbia	Telephones and Communication	0.6
\N	1246	SouthWestern Bell FA970 Digital Answering Machine with Time/Day Stamp	Shahid Hopkins	42177	47.42	28.99	8.59	British Columbia	Telephones and Communication	0.56
\N	1247	DAX Solid Wood Frames	Shahid Hopkins	42177	8.42	9.77	6.02	British Columbia	Office Furnishings	0.48
\N	1248	Xerox 1993	Cathy Armstrong	42339	-178.82	6.48	9.68	British Columbia	Paper	0.36
\N	1249	Xerox 1907	Bill Eplett	42342	49.67	12.28	5.09	British Columbia	Paper	0.38
\N	1250	Imation DVD-RAM discs	Patrick O'Brill	42947	-50.67	35.41	1.99	British Columbia	Computer Peripherals	0.43
\N	1251	Fellowes 17-key keypad for PS/2 interface	Giulietta Weimer	43079	-20.79	30.73	4	British Columbia	Computer Peripherals	0.75
\N	1252	GBC DocuBind P100 Manual Binding Machine	Sally Knutson	43111	1749.78	165.98	19.99	British Columbia	Binders and Binder Accessories	0.4
\N	1253	Xerox 1974	Marc Harrigan	43140	-49.53	5.98	5.14	British Columbia	Paper	0.36
\N	1254	Serrated Blade or Curved Handle Hand Letter Openers	John Grady	44098	-2.64	3.14	1.92	British Columbia	Scissors, Rulers and Trimmers	0.84
\N	1255	Seth Thomas 12" Clock w/ Goldtone Case	Khloe Miller	44451	-19.26	22.98	7.58	Nova Scotia	Office Furnishings	0.51
\N	1256	Panasonic KP-150 Electric Pencil Sharpener	Tony Chapman	45059	371.28	37.74	2.9	Nova Scotia	Pens & Art Supplies	0.59
\N	1257	Fellowes Stor/Drawer® Steel Plus™ Storage Drawers	Tony Chapman	45059	-508.87	95.43	19.99	Nova Scotia	Storage & Organization	0.79
\N	1258	ACCOHIDE® Binder by Acco	Ralph Kennedy	45155	-150.26	4.13	5.34	Nova Scotia	Binders and Binder Accessories	0.38
\N	1259	Serrated Blade or Curved Handle Hand Letter Openers	Ralph Kennedy	45155	-54.25	3.14	1.92	Nova Scotia	Scissors, Rulers and Trimmers	0.84
\N	1260	Verbatim DVD-R 4.7GB authoring disc	Trudy Schmidt	45317	486.9	39.24	1.99	Nova Scotia	Computer Peripherals	0.51
\N	1261	Hand-Finished Solid Wood Document Frame	Trudy Schmidt	45317	361.82	34.23	5.02	Nova Scotia	Office Furnishings	0.55
\N	1262	Xerox 1894	Gene Hale	45731	-30.06	6.48	6.22	Nova Scotia	Paper	0.37
\N	1263	Accessory20	Gene Hale	45731	1160.58	85.99	3.3	Nova Scotia	Telephones and Communication	0.37
\N	1264	80 Minute Slim Jewel Case CD-R , 10/Pack - Staples	Sarah Bern	46849	9.82	8.33	1.99	Nova Scotia	Computer Peripherals	0.52
\N	1265	3M Polarizing Light Filter Sleeves	Justin Hirsh	47108	187.15	18.65	3.77	Nova Scotia	Office Furnishings	0.39
\N	1266	Canon P1-DHIII Palm Printing Calculator	Justin Hirsh	47108	-43.74	17.98	8.51	Nova Scotia	Office Machines	0.4
\N	1267	Xerox 1896	Justin Hirsh	47108	9.95	9.99	4.78	Nova Scotia	Paper	0.4
\N	1268	2180	Justin Hirsh	47108	-382.57	175.99	8.99	Nova Scotia	Telephones and Communication	0.57
\N	1269	GBC VeloBinder Strips	Liz Price	47520	-64.41	7.68	6.16	Nova Scotia	Binders and Binder Accessories	0.35
\N	1270	Hon 4070 Series Pagoda™ Armless Upholstered Stacking Chairs	Liz Price	47520	598.24	291.73	48.8	Nova Scotia	Chairs & Chairmats	0.56
\N	1271	Xerox Blank Computer Paper	Liz Price	47520	257.31	19.98	5.77	Nova Scotia	Paper	0.38
\N	1272	Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back	Greg Maxwell	47527	3064.51	243.98	43.32	Nova Scotia	Chairs & Chairmats	0.55
\N	1273	8890	Marc Harrigan	47713	858.58	115.99	5.92	Nova Scotia	Telephones and Communication	0.58
\N	1274	Office Impressions Heavy Duty Welded Shelving & Multimedia Storage Drawers	Sally Knutson	47750	-149.41	167.27	35	Nova Scotia	Storage & Organization	0.85
\N	1275	Novimex Fabric Task Chair	Giulietta Weimer	48452	-588.9	60.98	30	Nova Scotia	Chairs & Chairmats	0.7
\N	1276	U.S. Robotics 56K Internet Call Modem	Giulietta Weimer	48452	51.44	99.99	19.99	Nova Scotia	Computer Peripherals	0.5
\N	1277	Eldon® Image Series Desk Accessories, Burgundy	Giulietta Weimer	48452	-192.56	4.18	6.92	Nova Scotia	Office Furnishings	0.49
\N	1278	Pressboard Covers with Storage Hooks, 9 1/2" x 11", Light Blue	Giulietta Weimer	48452	-44.79	4.91	4.97	Nova Scotia	Binders and Binder Accessories	0.38
\N	1279	Binder Clips by OIC	Giulietta Weimer	48452	5.77	1.48	0.7	Nova Scotia	Rubber Bands	0.37
\N	1280	Imation Neon Mac Format Diskettes, 10/Pack	Kristina Nunn	49088	-47.69	8.12	2.83	Nova Scotia	Computer Peripherals	0.77
\N	1281	Tennsco Snap-Together Open Shelving Units, Starter Sets and Add-On Units	Kristina Nunn	49088	-425.14	279.48	35	Nova Scotia	Storage & Organization	0.8
\N	1282	Xerox 1893	Kristina Nunn	49088	214.23	40.99	17.48	Nova Scotia	Paper	0.36
\N	1283	Staples File Caddy	Chuck Clark	49223	-83.55	9.38	7.28	Nova Scotia	Storage & Organization	0.57
\N	1284	Belkin 6 Outlet Metallic Surge Strip	Sally Knutson	49634	-44.13	10.89	4.5	Nova Scotia	Appliances	0.59
\N	1285	Memorex 4.7GB DVD+RW, 3/Pack	Sally Knutson	49634	-67.22	28.48	1.99	Nova Scotia	Computer Peripherals	0.4
\N	1286	Sauder Camden County Collection Libraries, Planked Cherry Finish	Tanja Norvell	49987	-626.04	114.98	58.72	Nova Scotia	Bookcases	0.76
\N	1287	Bush Advantage Collection® Round Conference Table	Tanja Norvell	49987	-226.51	212.6	52.2	Nova Scotia	Tables	0.64
\N	1288	Avery Hole Reinforcements	Sarah Bern	50208	-12.13	6.23	6.97	Nova Scotia	Binders and Binder Accessories	0.36
\N	1289	Sharp EL500L Fraction Calculator	Liz Price	50338	28.7	13.99	7.51	Nova Scotia	Office Machines	0.39
\N	1290	Accessory13	Vicky Freymann	50945	192.29	35.99	1.25	Nova Scotia	Telephones and Communication	0.57
\N	1291	Boston Electric Pencil Sharpener, Model 1818, Charcoal Black	Philisse Overcash	51462	-13.95	28.15	8.99	Nova Scotia	Pens & Art Supplies	0.57
\N	1292	TI 30X Scientific Calculator	Justin Hirsh	51494	12.73	11.99	5.99	Nova Scotia	Office Machines	0.36
\N	1293	Belkin 105-Key Black Keyboard	Patrick O'Brill	51525	-36.24	19.98	4	Nova Scotia	Computer Peripherals	0.68
\N	1294	Multi-Use Personal File Cart and Caster Set, Three Stacking Bins	Patrick O'Brill	51525	104.22	34.76	8.22	Nova Scotia	Storage & Organization	0.57
\N	1295	Avery Non-Stick Binders	Liz Price	52933	50.04	4.49	1.49	Nova Scotia	Binders and Binder Accessories	0.39
\N	1296	Xerox 1920	Justin Hirsh	53025	-132.93	5.98	7.5	Nova Scotia	Paper	0.4
\N	1297	Coloredge Poster Frame	Cathy Armstrong	53894	107.02	14.2	5.3	Nova Scotia	Office Furnishings	0.46
\N	1298	Lesro Sheffield Collection Coffee Table, End Table, Center Table, Corner Table	Cathy Armstrong	53894	-1561.72	71.37	69	Nova Scotia	Tables	0.68
\N	1299	5125	Cathy Armstrong	53894	1252.48	200.99	8.08	Nova Scotia	Telephones and Communication	0.59
\N	1300	Recycled Desk Saver Line "While You Were Out" Book, 5 1/2" X 4"	Heather Jas	53953	91.73	8.95	2.01	Nova Scotia	Paper	0.39
\N	1301	Belkin Premiere Surge Master II 8-outlet surge protector	Justin Hirsh	54304	118.32	48.58	3.99	Nova Scotia	Appliances	0.56
\N	1302	Global Stack Chair without Arms, Black	Lena Hernandez	55075	-124.42	25.98	14.36	Nova Scotia	Chairs & Chairmats	0.6
\N	1303	Maxell 3.5" DS/HD IBM-Formatted Diskettes, 10/Pack	Patrick O'Brill	55268	-47.83	4.89	4.93	Nova Scotia	Computer Peripherals	0.66
\N	1304	Hon Metal Bookcases, Putty	Kristina Nunn	55367	-686.01	70.98	46.74	Nova Scotia	Bookcases	0.56
\N	1305	Newell 309	Kristina Nunn	55367	129.87	11.55	2.36	Nova Scotia	Pens & Art Supplies	0.55
\N	1306	Wilson Jones “Snap” Scratch Pad Binder Tool for Ring Binders	Shahid Shariari	56321	-75.39	5.8	5.59	Nova Scotia	Binders and Binder Accessories	0.4
\N	1307	Fellowes Mobile Numeric Keypad, Graphite	Justin Hirsh	56610	51.85	43.22	4	Nova Scotia	Computer Peripherals	0.64
\N	1308	Flat Face Poster Frame	Khloe Miller	56740	256.57	18.84	3.62	Nova Scotia	Office Furnishings	0.43
\N	1309	12 Colored Short Pencils	Paul MacIntyre	56901	-45.21	2.6	2.4	Nova Scotia	Pens & Art Supplies	0.58
\N	1310	Snap-A-Way® Black Print Carbonless Ruled Speed Letter, Triplicate	Patrick O'Brill	57314	341.53	37.94	5.08	Nova Scotia	Paper	0.38
\N	1311	6340	Patrick O'Brill	57314	473.36	85.99	2.79	Nova Scotia	Telephones and Communication	0.58
\N	1312	Ultra Door Pull Handle	Mike Vittorini	57376	-168.38	10.52	7.94	Nova Scotia	Office Furnishings	0.52
\N	1313	3390	Mike Vittorini	57376	-223.21	65.99	5.31	Nova Scotia	Telephones and Communication	0.57
\N	1314	Avery 510	Liz Price	57671	3.96	3.75	0.5	Nova Scotia	Labels	0.37
\N	1315	DS/HD IBM Formatted Diskettes, 200/Pack - Staples	Paul MacIntyre	57700	134.85	47.98	3.61	Nova Scotia	Computer Peripherals	0.71
\N	1316	Xerox 194	John Grady	58407	548.92	55.48	14.3	Nova Scotia	Paper	0.37
\N	1317	Tenex Carpeted, Granite-Look or Clear Contemporary Contour Shape Chair Mats	Ricardo Emerson	58593	-812.25	70.71	37.58	Nova Scotia	Office Furnishings	0.78
\N	1318	Avery 474	Chuck Clark	58884	23.14	2.88	0.99	Nova Scotia	Labels	0.36
\N	1319	Barricks Non-Folding Utility Table with Steel Legs, Laminate Tops	Chuck Clark	58884	-1255.86	85.29	60	Nova Scotia	Tables	0.56
\N	1320	Eureka Recycled Copy Paper 8 1/2" x 11", Ream	Sarah Bern	58913	-60.17	6.48	5.94	Nova Scotia	Paper	0.37
\N	1321	Xerox 193	Kristina Nunn	58978	-31.01	5.98	5.15	Nova Scotia	Paper	0.36
\N	1322	Nu-Dell Executive Frame	Matt Abelman	229	98.44	12.64	4.98	Nova Scotia	Office Furnishings	0.48
\N	1323	Newell 326	Sarah Jordon	706	0.82	1.76	0.7	Nova Scotia	Pens & Art Supplies	0.56
\N	1324	O'Sullivan Elevations Bookcase, Cherry Finish	Sally Matthias	1285	-305.98	130.98	54.74	Nova Scotia	Bookcases	0.69
\N	1325	BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	Sally Matthias	1285	-277.29	218.75	69.64	Nova Scotia	Tables	0.77
\N	1326	Xerox 1973	Sally Matthias	1313	-83.75	22.84	16.92	Nova Scotia	Paper	0.39
\N	1327	Hon 4-Shelf Metal Bookcases	Theone Pippenger	1346	421.15	100.98	26.22	Nova Scotia	Bookcases	0.6
\N	1328	#10 Self-Seal White Envelopes	Art Ferguson	1699	39	11.09	5.25	Nova Scotia	Envelopes	0.36
\N	1329	Ibico Covers for Plastic or Wire Binding Elements	Jack O'Briant	2208	-26.99	11.5	7.19	Nova Scotia	Binders and Binder Accessories	0.4
\N	1330	Hewlett Packard LaserJet 3310 Copier	Jack O'Briant	2208	9097.65	599.99	24.49	Nova Scotia	Copiers and Fax	0.37
\N	1331	Hon Non-Folding Utility Tables	Nathan Cano	2656	-214.53	159.31	60	Nova Scotia	Tables	0.55
\N	1332	Accessory13	Nathan Cano	2656	237.14	35.99	1.25	Nova Scotia	Telephones and Communication	0.57
\N	1333	Xerox 1927	Michael Granlund	3361	-208.02	4.28	6.72	Nova Scotia	Paper	0.4
\N	1334	Dixon My First Ticonderoga Pencil, #2	Michael Granlund	3361	-5.6	5.85	2.27	Nova Scotia	Pens & Art Supplies	0.56
\N	1335	Logitech Access Keyboard	Steve Carroll	3393	-5.57	15.98	4	Nova Scotia	Computer Peripherals	0.37
\N	1336	DAX Two-Tone Rosewood/Black Document Frame, Desktop, 5 x 7	Steve Carroll	3393	-36.47	9.48	7.29	Nova Scotia	Office Furnishings	0.45
\N	1337	Wilson Jones® Four-Pocket Poly Binders	Scott Williamson	4487	-79.42	6.54	5.27	Nova Scotia	Binders and Binder Accessories	0.36
\N	1338	Satellite Sectional Post Binders	Dennis Bolton	4579	749.22	43.41	2.99	Nova Scotia	Binders and Binder Accessories	0.39
\N	1339	Newell 346	Sean Wendt	5061	-2.21	2.88	0.7	Nova Scotia	Pens & Art Supplies	0.56
\N	1340	Bush Cubix Collection Bookcases, Fully Assembled	John Castell	5092	-337.92	220.98	64.66	Nova Scotia	Bookcases	0.62
\N	1341	Xerox 1892	John Castell	5092	220.91	38.76	13.26	Nova Scotia	Paper	0.36
\N	1342	DIXON Oriole® Pencils	Art Ferguson	5511	-5.54	2.58	1.3	Nova Scotia	Pens & Art Supplies	0.59
\N	1344	3.6 Cubic Foot Counter Height Office Refrigerator	Jack O'Briant	5799	1882.2	294.62	42.52	Nova Scotia	Appliances	0.57
\N	1345	Accessory21	David Philippe	5890	435.95	20.99	0.99	Nova Scotia	Telephones and Communication	0.37
\N	1346	Hewlett-Packard cp1700 [D, PS] Series Color Inkjet Printers	Chad Sievert	6596	8157.7	500.98	28.14	Nova Scotia	Office Machines	0.38
\N	1347	Imation Printable White 80 Minute CD-R Spindle, 50/Pack	Matt Abelman	7015	775.88	40.98	1.99	Nova Scotia	Computer Peripherals	0.44
\N	1348	T65	Matt Abelman	7015	2374.73	195.99	4.2	Nova Scotia	Telephones and Communication	0.56
\N	1349	GBC Laser Imprintable Binding System Covers, Desert Sand	Shaun Weien	7106	-12.77	14.27	7.27	Nova Scotia	Binders and Binder Accessories	0.38
\N	1350	Gyration RF Keyboard	Shaun Weien	7106	1669.38	159.99	5.5	Nova Scotia	Computer Peripherals	0.49
\N	1351	Fellowes Super Stor/Drawer®	Shaun Weien	7106	-386.02	27.75	19.99	Nova Scotia	Storage & Organization	0.67
\N	1352	StarTAC 8000	Maya Herman	8007	-800.25	205.99	8.99	Nova Scotia	Telephones and Communication	0.6
\N	1353	Epson DFX5000+ Dot Matrix Printer	David Philippe	8257	-2561.32	1500.97	29.7	Nova Scotia	Office Machines	0.57
\N	1354	Xerox 1910	David Philippe	8257	373.67	48.04	5.09	Nova Scotia	Paper	0.37
\N	1355	Newell 320	David Philippe	8257	-6.2	4.28	1.6	Nova Scotia	Pens & Art Supplies	0.58
\N	1356	Accessory36	Sally Matthias	8773	-305.32	55.99	5	Nova Scotia	Telephones and Communication	0.83
\N	1357	Master Giant Foot® Doorstop, Safety Yellow	Michael Granlund	9057	1.35	7.59	4	Nova Scotia	Office Furnishings	0.42
\N	1358	Avery Trapezoid Ring Binder, 3" Capacity, Black, 1040 sheets	David Philippe	9285	-11.94	40.98	2.99	Nova Scotia	Binders and Binder Accessories	0.36
\N	1359	Boston 16701 Slimline Battery Pencil Sharpener	Chad Sievert	9861	6.6	15.94	5.45	Nova Scotia	Pens & Art Supplies	0.55
\N	1360	Global Adaptabilities™ Conference Tables	Jack O'Briant	9922	539.54	280.98	35.67	Nova Scotia	Tables	0.66
\N	1361	Eldon® Wave Desk Accessories	Chad Sievert	9923	-96.03	2.08	5.33	Nova Scotia	Office Furnishings	0.43
\N	1362	Sauder Facets Collection Locker/File Cabinet, Sky Alder Finish	Chad Sievert	9923	-115.08	370.98	99	Nova Scotia	Storage & Organization	0.65
\N	1363	Avery Trapezoid Extra Heavy Duty 4" Binders	Chad Sievert	9925	771.83	41.94	2.99	Nova Scotia	Binders and Binder Accessories	0.35
\N	1364	Wilson Jones 1" Hanging DublLock® Ring Binders	Chad Sievert	9925	-9.35	5.28	2.99	Nova Scotia	Binders and Binder Accessories	0.37
\N	1365	Boston 1730 StandUp Electric Pencil Sharpener	Chad Sievert	9925	-27.99	21.38	8.99	Nova Scotia	Pens & Art Supplies	0.59
\N	1366	Imation 3.5" DS/HD IBM Formatted Diskettes, 50/Pack	Sally Matthias	10593	-147.51	15.98	8.99	Nova Scotia	Computer Peripherals	0.64
\N	1367	Howard Miller Distant Time Traveler Alarm Clock	Sally Matthias	10593	-40.98	27.42	19.46	Nova Scotia	Office Furnishings	0.44
\N	1368	Carina Mini System Audio Rack, Model AR050B	Ivan Liston	11969	-553.06	110.98	35	Nova Scotia	Storage & Organization	0.82
\N	1369	Bush Advantage Collection® Round Conference Table	Ivan Liston	11969	-471.26	212.6	110.2	Nova Scotia	Tables	0.73
\N	1370	SAFCO PlanMaster Heigh-Adjustable Drafting Table Base, 43w x 30d x 30-37h, Black	Ivan Liston	11969	4264.82	349.45	60	Nova Scotia	Tables	\N
\N	1371	Office Star - Contemporary Task Swivel chair with 2-way adjustable arms, Plum	Brad Norvell	12228	-103.63	130.98	30	Nova Scotia	Chairs & Chairmats	0.78
\N	1372	2160i	Brad Norvell	12228	1090.43	200.99	4.2	Nova Scotia	Telephones and Communication	0.59
\N	1373	Hoover Replacement Belts For Soft Guard™ & Commercial Ltweight Upright Vacs, 2/Pk	Ken Heidel	12355	-167.06	3.95	5.13	Nova Scotia	Appliances	0.59
\N	1374	Logitech Cordless Navigator Duo	Michael Granlund	12389	670.96	80.98	7.18	Nova Scotia	Computer Peripherals	0.48
\N	1375	SimpliFile™ Personal File, Black Granite, 15w x 6-15/16d x 11-1/4h	Michael Granlund	12389	-74.77	11.35	8.6	Nova Scotia	Storage & Organization	0.57
\N	1376	Xerox 1882	John Castell	12710	745.45	55.98	13.88	Nova Scotia	Paper	0.36
\N	1377	Riverside Palais Royal Lawyers Bookcase, Royale Cherry Finish	Sally Matthias	13636	7513.88	880.98	44.55	Nova Scotia	Bookcases	0.62
\N	1378	Newell 307	Ken Heidel	14021	1	1.82	0.83	Nova Scotia	Pens & Art Supplies	0.57
\N	1379	Hewlett-Packard Deskjet 6122 Color Inkjet Printer	Mike Kennedy	14338	2786.35	200.97	15.59	Nova Scotia	Office Machines	0.36
\N	1380	Canon MP41DH Printing Calculator	Charles Sheldon	14406	2366.51	150.98	13.99	Nova Scotia	Office Machines	0.38
\N	1381	Tennsco Lockers, Gray	Charles Sheldon	14406	-932.55	20.98	53.03	Nova Scotia	Storage & Organization	0.78
\N	1382	Accessory4	Charles Sheldon	14406	-310.24	85.99	0.99	Nova Scotia	Telephones and Communication	0.85
\N	1383	Array® Parchment Paper, Assorted Colors	Mike Kennedy	15878	-237.87	7.28	11.15	Nova Scotia	Paper	0.37
\N	1384	Tensor Computer Mounted Lamp	Matt Abelman	16133	-9.13	14.89	13.56	Nova Scotia	Office Furnishings	0.58
\N	1385	Hewlett-Packard Deskjet 940 REFURBISHED Color Inkjet Printer	Sally Matthias	16612	565.18	80.97	30.06	Nova Scotia	Office Machines	0.4
\N	1386	Xerox 1997	Sally Matthias	16612	-38.72	6.48	10.05	Nova Scotia	Paper	0.37
\N	1387	Micro Innovations Micro Digital Wireless Keyboard and Mouse, Gray	Brad Norvell	16967	-152.47	83.1	6.13	Nova Scotia	Computer Peripherals	0.45
\N	1388	Xerox Blank Computer Paper	Brad Norvell	16967	181.98	19.98	5.77	Nova Scotia	Paper	0.38
\N	1389	Eldon Expressions Punched Metal & Wood Desk Accessories, Pewter & Cherry	Art Ferguson	18432	1.16	10.64	5.16	Nova Scotia	Office Furnishings	0.57
\N	1390	Holmes Odor Grabber	Art Ferguson	18432	-24.91	14.42	6.75	Nova Scotia	Appliances	0.52
\N	1391	Sanyo 2.5 Cubic Foot Mid-Size Office Refrigerators	Art Ferguson	18432	-126.34	279.81	23.19	Nova Scotia	Appliances	0.59
\N	1392	Avery Hi-Liter® Smear-Safe Highlighters	Art Ferguson	18432	20.44	5.84	0.83	Nova Scotia	Pens & Art Supplies	0.49
\N	1393	Avanti 4.4 Cu. Ft. Refrigerator	Brian Derr	18464	253.14	180.98	55.24	Nova Scotia	Appliances	0.57
\N	1394	Bush Mission Pointe Library	Brian Derr	18464	-345.92	150.98	66.27	Nova Scotia	Bookcases	0.65
\N	1395	Wirebound Four 2-3/4 x 5 Forms per Page, 400 Sets per Book	Brian Derr	18464	80.07	6.45	1.34	Nova Scotia	Paper	0.36
\N	1396	Revere Boxed Rubber Bands by Revere	Brian Derr	18464	-18.72	1.89	0.76	Nova Scotia	Rubber Bands	0.83
\N	1397	Sauder Forest Hills Library, Woodland Oak Finish	Roland Black	18754	-221.5	140.98	36.09	Nova Scotia	Bookcases	0.77
\N	1398	Talkabout T8367	Roland Black	18754	206.35	65.99	8.99	Nova Scotia	Telephones and Communication	0.56
\N	1399	Avery 506	Matt Abelman	19905	32.5	4.13	0.5	Nova Scotia	Labels	0.39
\N	1400	Chromcraft Bull-Nose Wood 48" x 96" Rectangular Conference Tables	Matt Abelman	19905	-3687.65	550.98	64.59	Nova Scotia	Tables	0.66
\N	1401	Iris® 3-Drawer Stacking Bin, Black	Roland Black	20256	-221.56	20.89	11.52	Nova Scotia	Storage & Organization	0.83
\N	1402	Bagged Rubber Bands	Mike Kennedy	20386	-21.51	1.26	0.7	Nova Scotia	Rubber Bands	0.81
\N	1403	V 3600 Series	Dana Kaydos	20455	-233.56	65.99	8.99	Nova Scotia	Telephones and Communication	0.58
\N	1404	Avery 506	Darren Koutras	20642	59.4	4.13	0.5	Nova Scotia	Labels	0.39
\N	1405	Global Leather & Oak Executive Chair, Burgundy	Charles Sheldon	21379	-1046.78	150.89	60.2	Nova Scotia	Chairs & Chairmats	0.77
\N	1406	Hon Every-Day® Chair Series Swivel Task Chairs	Steve Carroll	21766	531.69	120.98	30	Nova Scotia	Chairs & Chairmats	0.64
\N	1407	Artistic Insta-Plaque	Steve Carroll	21766	216.43	15.68	3.73	Nova Scotia	Office Furnishings	0.46
\N	1408	Poly Designer Cover & Back	Sean Wendt	22053	112.97	18.99	5.23	Nova Scotia	Binders and Binder Accessories	0.37
\N	1409	Verbatim DVD-R 4.7GB authoring disc	Sarah Jordon	22368	-74.85	39.24	1.99	Nova Scotia	Computer Peripherals	0.51
\N	1410	Hewlett-Packard 2600DN Business Color Inkjet Printer	Sarah Jordon	22368	40.76	119.99	56.14	Nova Scotia	Office Machines	0.39
\N	1411	Carina 42"Hx23 3/4"W Media Storage Unit	Sarah Jordon	22368	-849.18	80.98	35	Nova Scotia	Storage & Organization	0.83
\N	1412	Martin-Yale Premier Letter Opener	Neil Ducich	22885	-29.9	12.88	4.59	Nova Scotia	Scissors, Rulers and Trimmers	0.82
\N	1413	Aluminum Document Frame	Sarah Jordon	22947	58.84	12.22	2.85	Nova Scotia	Office Furnishings	0.55
\N	1414	Belkin F9M820V08 8 Outlet Surge	Michael Granlund	23844	627.85	42.98	4.62	Nova Scotia	Appliances	0.56
\N	1415	Holmes HEPA Air Purifier	Michael Granlund	23844	187.2	21.78	5.94	Nova Scotia	Appliances	0.5
\N	1416	Avery 520	Michael Granlund	23844	8.4	3.15	0.5	Nova Scotia	Labels	0.37
\N	1417	Imation Printable White 80 Minute CD-R Spindle, 50/Pack	Sean Wendt	24039	-64.87	40.98	1.99	Nova Scotia	Computer Peripherals	0.44
\N	1418	Xerox 1906	Theone Pippenger	25347	309.31	35.44	7.5	Nova Scotia	Paper	0.38
\N	1419	Speediset Carbonless Redi-Letter® 7" x 8 1/2"	Michael Granlund	25825	206.27	10.31	1.79	Nova Scotia	Paper	0.38
\N	1420	Dixon My First Ticonderoga Pencil, #2	Michael Granlund	25825	-1.79	5.85	2.27	Nova Scotia	Pens & Art Supplies	0.56
\N	1421	3285	Art Ferguson	26304	2028.36	205.99	5.99	Nova Scotia	Telephones and Communication	0.59
\N	1422	Eureka Sanitaire ® Multi-Pro Heavy-Duty Upright, Disposable Bags	Roland Black	26726	-121.58	4.37	5.15	Nova Scotia	Appliances	0.59
\N	1423	Hoover® Commercial Lightweight Upright Vacuum	Roland Black	26726	-474.91	3.48	49	Nova Scotia	Appliances	0.59
\N	1424	Avery Legal 4-Ring Binder	Roland Black	26726	364.99	20.98	1.49	Nova Scotia	Binders and Binder Accessories	0.35
\N	1425	Verbatim DVD-R, 4.7GB, Spindle, WE, Blank, Ink Jet/Thermal, 20/Spindle	Art Ferguson	27266	39.36	115.79	1.99	Nova Scotia	Computer Peripherals	0.49
\N	1426	DAX Solid Wood Frames	Sean Wendt	27396	-31.16	9.77	6.02	British Columbia	Office Furnishings	0.48
\N	1427	Newell 310	Mike Kennedy	28480	-1.56	1.76	0.7	British Columbia	Pens & Art Supplies	0.56
\N	1428	Global Leather Highback Executive Chair with Pneumatic Height Adjustment, Black	Matt Abelman	29158	180.8	200.98	23.76	British Columbia	Chairs & Chairmats	0.58
\N	1429	BASF Silver 74 Minute CD-R	Sally Matthias	29409	-33.52	1.7	1.99	British Columbia	Computer Peripherals	0.51
\N	1430	Newell 307	Steve Carroll	29956	-12.95	1.82	0.83	British Columbia	Pens & Art Supplies	0.57
\N	1431	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Matt Abelman	30341	470.3	160.98	30	British Columbia	Chairs & Chairmats	0.62
\N	1432	Avery 51	Matt Abelman	30341	105.91	6.3	0.5	British Columbia	Labels	0.39
\N	1433	Rediform S.O.S. Phone Message Books	Matt Abelman	30341	62.46	4.98	0.8	British Columbia	Paper	0.36
\N	1434	GBC DocuBind 200 Manual Binding Machine	John Castell	30467	289.88	420.98	19.99	British Columbia	Binders and Binder Accessories	0.35
\N	1435	Xerox 227	Neil Ducich	30785	-35.04	6.48	8.73	British Columbia	Paper	0.37
\N	1436	Peel-Off® China Markers	Neil Ducich	30785	149.53	9.93	1.09	British Columbia	Pens & Art Supplies	0.43
\N	1437	Presstex Flexible Ring Binders	Parhena Norris	31171	32.19	4.55	1.49	British Columbia	Binders and Binder Accessories	0.35
\N	1438	Model L Table or Wall-Mount Pencil Sharpener	Mike Kennedy	31297	-93.3	17.99	8.65	British Columbia	Pens & Art Supplies	0.57
\N	1439	Staples Colored Bar Computer Paper	Mike Kennedy	31297	699.64	35.44	4.92	British Columbia	Paper	0.38
\N	1440	Multimedia Mailers	Sean Wendt	31553	1907.94	162.93	19.99	British Columbia	Envelopes	0.39
\N	1441	Okidata ML320 Series Turbo Dot Matrix Printers	Matt Abelman	32706	-663.51	399.98	12.06	British Columbia	Office Machines	0.56
\N	1442	Hewlett-Packard Deskjet 1220Cse Color Inkjet Printer	Roland Black	33122	2819.96	400.97	48.26	British Columbia	Office Machines	0.36
\N	1443	Binder Posts	Ken Heidel	33570	-90.9	5.74	5.01	British Columbia	Binders and Binder Accessories	0.39
\N	1444	Epson DFX5000+ Dot Matrix Printer	Ken Heidel	33570	-3381.99	1500.97	29.7	British Columbia	Office Machines	0.57
\N	1445	i470	Ken Heidel	33570	286.4	205.99	5.26	British Columbia	Telephones and Communication	0.56
\N	1446	Jet-Pak Recycled Peel 'N' Seal Padded Mailers	Sarah Jordon	33893	-14.03	35.89	14.72	British Columbia	Envelopes	0.4
\N	1447	Dixon My First Ticonderoga Pencil, #2	Sarah Jordon	33893	-12.14	5.85	2.27	British Columbia	Pens & Art Supplies	0.56
\N	1448	Deflect-O® Glasstique™ Clear Desk Accessories	John Castell	34599	7.17	7.7	3.68	British Columbia	Office Furnishings	0.52
\N	1449	Xerox 197	John Castell	34599	22.21	30.98	17.08	British Columbia	Paper	0.4
\N	1450	Acme® Box Cutter Scissors	Bart Watters	34721	-10.21	10.23	4.68	British Columbia	Scissors, Rulers and Trimmers	0.59
\N	1451	Boston School Pro Electric Pencil Sharpener, 1670	Sean Wendt	34787	14.61	30.98	8.99	British Columbia	Pens & Art Supplies	0.58
\N	1452	Master Giant Foot® Doorstop, Safety Yellow	Mary O'Rourke	34791	33.81	7.59	4	British Columbia	Office Furnishings	0.42
\N	1453	Multicolor Computer Printout Paper	Mary O'Rourke	34791	271.5	104.85	19.99	British Columbia	Paper	0.37
\N	1454	Memorex 80 Minute CD-R Spindle, 100/Pack	Nathan Cano	34822	323.73	43.98	1.99	British Columbia	Computer Peripherals	0.44
\N	1455	DAX Wood Document Frame.	Matt Abelman	34853	-74.51	13.73	6.85	British Columbia	Office Furnishings	0.54
\N	1456	US Robotics 56K V.92 External Faxmodem	Michael Granlund	35522	231.46	99.99	19.99	British Columbia	Computer Peripherals	0.52
\N	1457	Newell 340	Neil Ducich	36099	5.72	2.88	0.7	British Columbia	Pens & Art Supplies	0.56
\N	1458	Space Solutions Commercial Steel Shelving	Neil Ducich	36099	-503.8	64.65	35	British Columbia	Storage & Organization	0.8
\N	1459	IBM Multi-Purpose Copy Paper, 8 1/2 x 11", Case	Ken Heidel	36359	-29.6	30.98	5.76	British Columbia	Paper	0.4
\N	1460	Xerox 1923	Dana Kaydos	36901	-56.22	6.68	5.66	British Columbia	Paper	0.37
\N	1461	Fiskars® Softgrip Scissors	Steve Carroll	37412	6.02	10.98	3.37	British Columbia	Scissors, Rulers and Trimmers	0.57
\N	1462	US Robotics 56K V.92 External Faxmodem	Chad Sievert	38625	336.47	99.99	19.99	British Columbia	Computer Peripherals	0.52
\N	1463	Wausau Papers Astrobrights® Colored Envelopes	Chad Sievert	38625	5.03	5.98	2.5	British Columbia	Envelopes	0.36
\N	1464	Avery 478	John Castell	38656	25.16	4.91	0.5	British Columbia	Labels	0.36
\N	1465	Avery 51	Mark Cousins	38784	137.67	6.3	0.5	British Columbia	Labels	0.39
\N	1466	Global High-Back Leather Tilter, Burgundy	Hunter Lopez	38882	-1799.35	122.99	70.2	British Columbia	Chairs & Chairmats	0.74
\N	1467	Adams Phone Message Book, 200 Message Capacity, 8 1/16” x 11”	Nathan Mautz	39527	63.78	6.88	2	British Columbia	Paper	0.39
\N	1468	Xerox 1896	Shaun Weien	39845	41.3	9.99	4.78	British Columbia	Paper	0.4
\N	1469	Stockwell Push Pins	Nathan Mautz	39877	8.06	2.18	0.78	British Columbia	Rubber Bands	0.52
\N	1470	DS/HD IBM Formatted Diskettes, 10/Pack - Staples	Theone Pippenger	40259	-20.9	4.98	4.32	British Columbia	Computer Peripherals	0.64
\N	1471	Eaton Premium Continuous-Feed Paper, 25% Cotton, Letter Size, White, 1000 Shts/Box	Nathan Cano	41217	575.38	55.48	6.79	British Columbia	Paper	0.37
\N	1472	Acme® 8" Straight Scissors	Bart Watters	41671	77.48	12.98	3.14	British Columbia	Scissors, Rulers and Trimmers	0.6
\N	1473	Xerox 1885	Matt Abelman	41927	1085.93	48.04	7.23	British Columbia	Paper	0.37
\N	1474	Panasonic KX-P1150 Dot Matrix Printer	Matt Abelman	41988	751.58	145.45	17.85	British Columbia	Office Machines	0.56
\N	1475	Metal Folding Chairs, Beige, 4/Carton	Matt Abelman	41988	-157.56	33.94	19.19	British Columbia	Chairs & Chairmats	0.58
\N	1476	Fellowes Personal Hanging Folder Files, Navy	Matt Abelman	41988	-29.54	13.43	5.5	British Columbia	Storage & Organization	0.57
\N	1477	Xerox 1920	Scott Williamson	42692	-168.67	5.98	7.5	British Columbia	Paper	0.4
\N	1478	Xerox 227	Scott Williamson	42692	-202.31	6.48	8.73	British Columbia	Paper	0.37
\N	1479	Newell 315	Nathan Cano	44007	42.45	5.98	0.96	British Columbia	Pens & Art Supplies	0.6
\N	1480	Maxell Pro 80 Minute CD-R, 10/Pack	Sean Wendt	44450	35.33	17.48	1.99	British Columbia	Computer Peripherals	0.45
\N	1481	StarTAC Analog	Sean Wendt	44450	58.17	65.99	8.99	British Columbia	Telephones and Communication	0.6
\N	1482	Avery 506	Hunter Lopez	44610	54.21	4.13	0.5	British Columbia	Labels	0.39
\N	1483	Xerox 220	Mike Kennedy	44999	-70.31	6.48	7.49	British Columbia	Paper	0.37
\N	1484	Avery Durable Binders	Mike Kennedy	45025	2.01	2.88	1.49	Manitoba	Binders and Binder Accessories	0.36
\N	1485	Hoover Replacement Belts For Soft Guard™ & Commercial Ltweight Upright Vacs, 2/Pk	Mark Cousins	45248	-136.55	3.95	5.13	Manitoba	Appliances	0.59
\N	1486	T28 WORLD	Mark Cousins	45248	704.89	195.99	8.99	Manitoba	Telephones and Communication	0.6
\N	1487	Accessory6	Roland Black	45249	-127	55.99	5	Manitoba	Telephones and Communication	0.8
\N	1488	Avery Poly Binder Pockets	Bart Watters	45570	-67.49	3.58	5.47	Manitoba	Binders and Binder Accessories	0.37
\N	1489	Hon 94000 Series Round Tables	Matt Abelman	45731	-169.23	296.18	154.12	Manitoba	Tables	0.76
\N	1490	Xerox 1932	Parhena Norris	46375	389.07	35.44	5.09	Manitoba	Paper	0.38
\N	1491	232	Parhena Norris	46375	162.11	125.99	5.26	Manitoba	Telephones and Communication	0.55
\N	1492	Executive Impressions 14" Two-Color Numerals Wall Clock	Mike Kennedy	46885	165.35	22.72	8.99	Manitoba	Office Furnishings	0.44
\N	1493	Colored Push Pins	Mike Kennedy	46885	-30.11	1.81	1.56	Manitoba	Rubber Bands	0.49
\N	1494	Howard Miller 16" Diameter Gallery Wall Clock	Mike Kennedy	46885	720.45	63.94	14.48	Manitoba	Office Furnishings	0.46
\N	1495	Wilson Jones® Four-Pocket Poly Binders	Mike Kennedy	46948	-28.97	6.54	5.27	Manitoba	Binders and Binder Accessories	0.36
\N	1496	Southworth 25% Cotton Premium Laser Paper and Envelopes	Theone Pippenger	47267	67.01	19.98	8.68	Manitoba	Paper	0.37
\N	1497	KI Conference Tables	Theone Pippenger	47267	-931.25	70.89	89.3	Manitoba	Tables	0.69
\N	1498	Accessory24	Sally Matthias	47333	29.8	55.99	3.3	Manitoba	Telephones and Communication	0.59
\N	1499	Global High-Back Leather Tilter, Burgundy	Dana Kaydos	48167	-2136.66	122.99	70.2	Manitoba	Chairs & Chairmats	0.74
\N	1500	Xerox 224	Dana Kaydos	48167	-237.47	6.48	8.88	Manitoba	Paper	0.37
\N	1501	SAFCO PlanMaster Heigh-Adjustable Drafting Table Base, 43w x 30d x 30-37h, Black	Dana Kaydos	48167	-2946.05	349.45	60	Manitoba	Tables	\N
\N	1502	Deflect-o SuperTray™ Unbreakable Stackable Tray, Letter, Black	Dana Kaydos	48230	387.2	29.18	8.55	Manitoba	Office Furnishings	0.42
\N	1503	Carina 42"Hx23 3/4"W Media Storage Unit	Dana Kaydos	48230	-684.78	80.98	35	Manitoba	Storage & Organization	0.83
\N	1504	Sauder Facets Collection Locker/File Cabinet, Sky Alder Finish	Sean Wendt	48480	-522.59	370.98	99	Manitoba	Storage & Organization	0.65
\N	1505	T28 WORLD	Nathan Mautz	48614	2311.96	195.99	8.99	Manitoba	Telephones and Communication	0.6
\N	1506	Howard Miller 12-3/4 Diameter Accuwave DS ™ Wall Clock	Aaron Smayling	48772	991.26	78.69	19.99	Manitoba	Office Furnishings	0.43
\N	1507	Xerox 213	Aaron Smayling	48772	-44.54	6.48	7.86	Manitoba	Paper	0.37
\N	1508	Newell 321	Aaron Smayling	48772	-24.03	3.28	2.31	Manitoba	Pens & Art Supplies	0.56
\N	1509	Newell 351	Aaron Smayling	48772	-37.03	3.28	4.2	Manitoba	Pens & Art Supplies	0.56
\N	1510	OIC Colored Binder Clips, Assorted Sizes	Aaron Smayling	48772	-0.71	3.58	1.63	Manitoba	Rubber Bands	0.36
\N	1511	Canon imageCLASS 2200 Advanced Copier	Parhena Norris	48800	285.11	3499.99	24.49	Manitoba	Copiers and Fax	0.37
\N	1512	Fellowes Basic 104-Key Keyboard, Platinum	Charles Sheldon	48931	120.05	20.95	4	Manitoba	Computer Peripherals	0.6
\N	1513	Logitech Internet Navigator Keyboard	Charles Sheldon	48931	-117.39	30.98	6.5	Manitoba	Computer Peripherals	0.79
\N	1514	Howard Miller 13-3/4" Diameter Brushed Chrome Round Wall Clock	Charles Sheldon	48931	217.87	51.75	19.99	Manitoba	Office Furnishings	0.55
\N	1515	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Mark Cousins	49126	1055.47	160.98	30	Manitoba	Chairs & Chairmats	0.62
\N	1516	Xerox 1881	Shaun Weien	49283	31.74	12.28	6.47	Manitoba	Paper	0.38
\N	1517	Deflect-o EconoMat Studded, No Bevel Mat for Low Pile Carpeting	Mary O'Rourke	49441	100.8	41.32	8.66	Manitoba	Office Furnishings	0.76
\N	1518	Hon Comfortask® Task/Swivel Chairs	Mark Cousins	49601	-101.19	113.98	30	Manitoba	Chairs & Chairmats	0.69
\N	1519	Staples Standard Envelopes	Brad Norvell	49763	9.29	5.68	1.39	Manitoba	Envelopes	0.38
\N	1520	Bretford CR4500 Series Slim Rectangular Table	Brad Norvell	49763	-237.62	348.21	84.84	Manitoba	Tables	0.66
\N	1521	Cardinal Holdit Business Card Pockets	Parhena Norris	49927	-54.08	4.98	4.95	Manitoba	Binders and Binder Accessories	0.37
\N	1522	Master Giant Foot® Doorstop, Safety Yellow	Parhena Norris	49927	13.44	7.59	4	Manitoba	Office Furnishings	0.42
\N	1523	Stockwell Push Pins	Parhena Norris	49927	6.67	2.18	0.78	Manitoba	Rubber Bands	0.52
\N	1524	DIXON Oriole® Pencils	Chad Sievert	50048	-9.19	2.58	1.3	Manitoba	Pens & Art Supplies	0.59
\N	1525	Acme Design Line 8" Stainless Steel Bent Scissors w/Champagne Handles, 3-1/8" Cut	Chad Sievert	50048	-11.02	6.84	8.37	Manitoba	Scissors, Rulers and Trimmers	0.58
\N	1526	Avanti 1.7 Cu. Ft. Refrigerator	Brian Derr	50499	238.52	100.98	15.66	Manitoba	Appliances	0.57
\N	1527	252	Neil Ducich	51041	846.95	65.99	5.92	Manitoba	Telephones and Communication	0.55
\N	1528	Executive Impressions 13-1/2" Indoor/Outdoor Wall Clock	Sarah Jordon	51328	51.47	18.7	8.99	Manitoba	Office Furnishings	0.47
\N	1529	Lexmark Z25 Color Inkjet Printer	Theone Pippenger	51333	-9.45	80.97	33.6	Manitoba	Office Machines	0.37
\N	1530	Southworth 25% Cotton Linen-Finish Paper & Envelopes	Theone Pippenger	51333	-117.86	9.06	9.86	Manitoba	Paper	0.4
\N	1531	Eldon Wave Desk Accessories	Theone Pippenger	51365	-72.46	5.89	5.57	Manitoba	Office Furnishings	0.41
\N	1532	Bevis 36 x 72 Conference Tables	Theone Pippenger	51365	-684.07	124.49	51.94	Manitoba	Tables	0.63
\N	1533	GBC DocuBind TL300 Electric Binding System	Mike Kennedy	51777	194.32	896.99	19.99	Manitoba	Binders and Binder Accessories	0.38
\N	1534	Gyration Ultra Cordless Optical Suite	Mike Kennedy	51777	206.86	100.97	7.18	Manitoba	Computer Peripherals	0.46
\N	1535	XtraLife® ClearVue™ Slant-D® Ring Binders by Cardinal	Michael Granlund	51814	-9.28	7.84	4.71	Manitoba	Binders and Binder Accessories	0.35
\N	1536	DPC 650 Piper	Michael Granlund	51975	-181.01	115.99	2.5	Manitoba	Telephones and Communication	0.58
\N	1537	Aluminum Document Frame	Dana Kaydos	52225	10.94	12.22	2.85	Manitoba	Office Furnishings	0.55
\N	1538	Xerox 1940	Dana Kaydos	52225	700.31	54.96	10.75	Manitoba	Paper	0.36
\N	1539	Staples #10 Colored Envelopes	Nathan Mautz	52487	15.74	7.78	2.5	Manitoba	Envelopes	0.38
\N	1540	Imation 3.5" Unformatted DS/HD Diskettes, 10/Box	Ken Heidel	52868	-100.49	7.37	5.53	Manitoba	Computer Peripherals	0.69
\N	1541	Artistic Insta-Plaque	Art Ferguson	53221	147.46	15.68	3.73	Manitoba	Office Furnishings	0.46
\N	1542	Wilson Jones Impact Binders	Roland Black	53600	-17.95	5.18	5.74	Manitoba	Binders and Binder Accessories	0.36
\N	1543	Cardinal Poly Pocket Divider Pockets for Ring Binders	Steve Carroll	53667	-159.74	3.36	6.27	Manitoba	Binders and Binder Accessories	0.4
\N	1544	Accessory35	Steve Carroll	53667	46.51	35.99	1.1	Manitoba	Telephones and Communication	0.55
\N	1545	GBC Twin Loop™ Wire Binding Elements, 9/16" Spine, Black	Nathan Mautz	53891	-17.45	15.22	9.73	Manitoba	Binders and Binder Accessories	0.36
\N	1546	Office Star - Contemporary Task Swivel chair with 2-way adjustable arms, Plum	Matt Abelman	53955	-3404.24	130.98	130	Manitoba	Chairs & Chairmats	0.78
\N	1547	CF 888	Bart Watters	54150	-53.69	195.99	3.99	Manitoba	Telephones and Communication	0.59
\N	1548	Xerox 214	Nathan Cano	55429	-157.76	6.48	7.03	Manitoba	Paper	0.37
\N	1549	Avery Heavy-Duty EZD ™ Binder With Locking Rings	Shaun Weien	55462	-1.84	5.58	2.99	Manitoba	Binders and Binder Accessories	0.37
\N	1550	IBM Active Response Keyboard, Black	Shaun Weien	55462	-26.49	39.98	7.12	Manitoba	Computer Peripherals	0.67
\N	1551	M70	Shaun Weien	55462	708.76	125.99	8.99	Manitoba	Telephones and Communication	0.59
\N	1552	#10- 4 1/8" x 9 1/2" Recycled Envelopes	Brad Norvell	55749	149.45	8.74	1.39	Manitoba	Envelopes	0.38
\N	1553	Okidata ML184 Turbo Dot Matrix Printers	Bart Watters	55873	4875.89	306.14	26.53	Manitoba	Office Machines	0.56
\N	1554	Sauder Forest Hills Library, Woodland Oak Finish	Theone Pippenger	56135	-320.3	140.98	36.09	Manitoba	Bookcases	0.77
\N	1555	Colored Push Pins	Theone Pippenger	56135	-41.32	1.81	1.56	Manitoba	Rubber Bands	0.49
\N	1556	Riverside Furniture Stanwyck Manor Table Series	Art Ferguson	56708	-760.98	286.85	61.76	Manitoba	Tables	0.78
\N	1557	Peel & Seel® Recycled Catalog Envelopes, Brown	Art Ferguson	56708	-12.82	11.58	6.97	Manitoba	Envelopes	0.35
\N	1558	Holmes Replacement Filter for HEPA Air Cleaner, Large Room	Dennis Bolton	57986	-105.33	14.81	13.32	Manitoba	Appliances	0.43
\N	1559	Companion Letter/Legal File, Black	Mary O'Rourke	58310	1.98	37.76	12.9	Manitoba	Storage & Organization	0.57
\N	1560	#10- 4 1/8" x 9 1/2" Recycled Envelopes	Joel Jenkins	58725	-134.97	8.74	8.29	Manitoba	Envelopes	0.38
\N	1561	Kensington 7 Outlet MasterPiece Power Center with Fax/Phone Line Protection	Meg O'Connel	902	359.83	207.48	0.99	Manitoba	Appliances	0.55
\N	1562	Belkin 8 Outlet Surge Protector	Hallie Redmond	2147	92.81	40.98	5.33	Manitoba	Appliances	0.57
\N	1563	Acco Four Pocket Poly Ring Binder with Label Holder, Smoke, 1"	Liz Thompson	2306	-46.35	7.45	6.28	Manitoba	Binders and Binder Accessories	0.4
\N	1564	Microsoft Internet Keyboard	Robert Waldorf	2823	-135.98	20.97	6.5	Manitoba	Computer Peripherals	0.78
\N	1565	Tennsco Double-Tier Lockers	Robert Waldorf	2823	299.88	225.02	28.66	Manitoba	Storage & Organization	0.72
\N	1566	Epson C82 Color Inkjet Printer	Helen Andreada	3110	377.81	119.99	14	Manitoba	Office Machines	0.36
\N	1567	Xerox 212	Julia Dunbar	3463	-212.51	6.48	8.4	Manitoba	Paper	0.37
\N	1568	Eldon Cleatmat Plus™ Chair Mats for High Pile Carpets	Christine Sundaresam	4034	-1183.69	79.52	48.2	Manitoba	Office Furnishings	0.74
\N	1569	Bevis Rectangular Conference Tables	Christine Sundaresam	4034	-194.97	145.98	51.92	Manitoba	Tables	0.69
\N	1570	Xerox 213	Bruce Stewart	4037	-101.85	6.48	7.86	Manitoba	Paper	0.37
\N	1571	Binding Machine Supplies	Julia Dunbar	5538	415.85	29.17	6.27	Manitoba	Binders and Binder Accessories	0.37
\N	1572	BPI Conference Tables	Julia Dunbar	5538	-668.19	146.05	80.2	Manitoba	Tables	0.71
\N	1573	8290	Julia Dunbar	5538	-492.77	125.99	5.63	Manitoba	Telephones and Communication	0.6
\N	1574	Seth Thomas 12" Clock w/ Goldtone Case	Guy Thornton	5863	207.18	22.98	7.58	Manitoba	Office Furnishings	0.51
\N	1575	Hon Metal Bookcases, Black	Helen Andreada	7175	-86.99	70.98	26.74	Manitoba	Bookcases	0.6
\N	1576	Brown Kraft Recycled Envelopes	Mary Zewe	7364	-48.57	16.98	12.39	Manitoba	Envelopes	0.35
\N	1577	O'Sullivan 5-Shelf Heavy-Duty Bookcases	Meg O'Connel	7878	-1508.46	81.94	55.81	Manitoba	Bookcases	0.6
\N	1578	DAX Cubicle Frames, 8-1/2 x 11	Meg O'Connel	7878	13.29	8.57	3.44	Manitoba	Office Furnishings	0.49
\N	1579	Advantus Push Pins, Aluminum Head	Meg O'Connel	7878	-28.29	5.81	3.37	Manitoba	Rubber Bands	0.54
\N	1580	Acco Four Pocket Poly Ring Binder with Label Holder, Smoke, 1"	Meg O'Connel	8551	-69.87	7.45	6.28	Manitoba	Binders and Binder Accessories	0.4
\N	1581	Xerox 213	Meg O'Connel	8551	-135.74	6.48	7.86	Manitoba	Paper	0.37
\N	1582	Nu-Dell Executive Frame	Ken Lonsdale	8834	-6.96	12.64	4.98	Manitoba	Office Furnishings	0.48
\N	1583	GBC Linen Binding Covers	Ken Lonsdale	9155	54.63	30.98	11.63	Manitoba	Binders and Binder Accessories	0.37
\N	1584	Avery® Durable Slant Ring Binders With Label Holder	Christine Sundaresam	9668	-12.72	4.18	2.99	Manitoba	Binders and Binder Accessories	0.37
\N	1585	Seth Thomas 12" Clock w/ Goldtone Case	Maria Bertelson	10242	119.25	22.98	7.58	Manitoba	Office Furnishings	0.51
\N	1586	Micro Innovations Micro 3000 Keyboard, Black	Ken Lonsdale	12292	-127.23	26.31	5.89	Manitoba	Computer Peripherals	0.75
\N	1587	Surelock™ Post Binders	Bruce Stewart	14503	157.89	30.56	2.99	Manitoba	Binders and Binder Accessories	0.35
\N	1588	Fellowes Basic 104-Key Keyboard, Platinum	Maria Bertelson	15109	-68.76	20.95	5.99	Manitoba	Computer Peripherals	0.65
\N	1589	Xerox 212	Maria Bertelson	15109	-205.38	6.48	8.4	Manitoba	Paper	0.37
\N	1590	Binney & Smith inkTank™ Erasable Desk Highlighter, Chisel Tip, Yellow, 12/Box	Maria Bertelson	15109	-89.13	2.52	4.28	Manitoba	Pens & Art Supplies	0.44
\N	1591	Fiskars® Softgrip Scissors	Maria Bertelson	15109	19.36	10.98	3.37	Manitoba	Scissors, Rulers and Trimmers	0.57
\N	1592	Project Tote Personal File	Maria Bertelson	15109	-58.18	14.03	9.37	Manitoba	Storage & Organization	0.56
\N	1593	Recycled Premium Regency Composition Covers	Meg O'Connel	15142	-51.72	15.28	10.91	Manitoba	Binders and Binder Accessories	0.36
\N	1594	Ibico Laser Imprintable Binding System Covers	Maria Bertelson	15332	-2.73	52.4	16.11	Manitoba	Binders and Binder Accessories	0.39
\N	1595	Avanti 1.7 Cu. Ft. Refrigerator	Helen Andreada	15872	1481.67	100.98	15.66	Manitoba	Appliances	0.57
\N	1596	1/4 Fold Party Design Invitations & White Envelopes, 24 8-1/2" X 11" Cards, 25 Env./Pack	Helen Andreada	15872	-27.49	7.35	5.96	Manitoba	Paper	0.38
\N	1597	Xerox 1893	Helen Andreada	15872	23.94	40.99	17.48	Manitoba	Paper	0.36
\N	1598	Nu-Dell Executive Frame	Brian Thompson	16032	75.61	12.64	4.98	Manitoba	Office Furnishings	0.48
\N	1599	Fellowes 17-key keypad for PS/2 interface	Hallie Redmond	16165	-125.16	30.73	4	Manitoba	Computer Peripherals	0.75
\N	1600	Deflect-o Glass Clear Studded Chair Mats	Hallie Redmond	16165	376.52	62.18	10.84	Manitoba	Office Furnishings	0.63
\N	1601	Fellowes Staxonsteel® Drawer Files	Hallie Redmond	16165	183.28	193.17	19.99	Manitoba	Storage & Organization	0.71
\N	1602	Brites Rubber Bands, 1 1/2 oz. Box	Liz Thompson	17632	-21.89	1.98	0.7	Manitoba	Rubber Bands	0.83
\N	1603	Howard Miller 12-3/4 Diameter Accuwave DS ™ Wall Clock	Jason Gross	19492	364.03	78.69	19.99	Manitoba	Office Furnishings	0.43
\N	1604	Panasonic KP-310 Heavy-Duty Electric Pencil Sharpener	Jason Gross	19492	176.09	21.98	2.87	Manitoba	Pens & Art Supplies	0.55
\N	1605	Verbatim DVD-R, 3.95GB, SR, Mitsubishi Branded, Jewel	Christine Sundaresam	20102	71.04	22.24	1.99	Manitoba	Computer Peripherals	0.43
\N	1606	Avery Round Ring Poly Binders	Christine Sundaresam	21863	-102.02	2.84	5.44	Manitoba	Binders and Binder Accessories	0.36
\N	1607	GBC Imprintable Covers	Christine Sundaresam	21863	7.77	10.98	5.14	Manitoba	Binders and Binder Accessories	0.36
\N	1608	Wirebound Service Call Books, 5 1/2" x 4"	Katrina Bavinger	21894	1.27	9.68	2.03	Manitoba	Paper	0.37
\N	1609	Epson DFX5000+ Dot Matrix Printer	Hallie Redmond	22022	-3461.12	1500.97	29.7	Manitoba	Office Machines	0.57
\N	1610	Hon 2090 “Pillow Soft” Series Mid Back Swivel/Tilt Chairs	Maria Bertelson	22663	-384.6	280.98	57	Manitoba	Chairs & Chairmats	0.78
\N	1611	Hewlett-Packard cp1700 [D, PS] Series Color Inkjet Printers	Maria Bertelson	22663	1908.45	500.98	28.14	Manitoba	Office Machines	0.38
\N	1612	8890	Katrina Bavinger	23713	894.06	115.99	5.92	Manitoba	Telephones and Communication	0.58
\N	1613	Tennsco Snap-Together Open Shelving Units, Starter Sets and Add-On Units	Christine Sundaresam	24358	-207.28	279.48	35	Manitoba	Storage & Organization	0.8
\N	1614	Gyration Ultra Cordless Optical Suite	Bruce Stewart	24386	1653.96	100.97	7.18	Manitoba	Computer Peripherals	0.46
\N	1615	Targus USB Numeric Keypad	Bruce Stewart	24386	-102.74	40.98	6.5	Manitoba	Computer Peripherals	0.74
\N	1616	Avery 491	Bruce Stewart	24386	29.67	4.13	0.99	Manitoba	Labels	0.39
\N	1617	SANFORD Major Accent™ Highlighters	Maria Bertelson	24899	28.76	7.08	2.35	Manitoba	Pens & Art Supplies	0.47
\N	1618	Hewlett-Packard cp1700 [D, PS] Series Color Inkjet Printers	Mary Zewe	25473	7434.48	500.98	28.14	Manitoba	Office Machines	0.38
\N	1619	Xerox 1893	Mary Zewe	25473	67.61	40.99	17.48	Manitoba	Paper	0.36
\N	1620	Maxell 3.5" DS/HD IBM-Formatted Diskettes, 10/Pack	Ivan Gibson	25638	-108.55	4.89	4.93	Manitoba	Computer Peripherals	0.66
\N	1621	Riverleaf Stik-Withit® Designer Note Cubes®	Ivan Gibson	25638	23.53	10.06	2.06	Manitoba	Paper	0.39
\N	1622	Micro Innovations Media Access Pro Keyboard	Ken Lonsdale	26016	-358.43	77.51	4	Manitoba	Computer Peripherals	0.76
\N	1623	KF 788	Ken Lonsdale	26016	314.84	45.99	4.99	Manitoba	Telephones and Communication	0.56
\N	1624	Global Leather Highback Executive Chair with Pneumatic Height Adjustment, Black	Doug Bickford	26182	-192.51	200.98	23.76	Ontario	Chairs & Chairmats	0.58
\N	1625	GBC VeloBinder Strips	Liz Thompson	26691	-83.16	7.68	6.16	Ontario	Binders and Binder Accessories	0.35
\N	1626	Conquest™ 14 Commercial Heavy-Duty Upright Vacuum, Collection System, Accessory Kit	Maria Bertelson	27015	142.51	56.96	13.22	Ontario	Appliances	0.56
\N	1627	Bush Mission Pointe Library	Maria Bertelson	27840	-407.85	150.98	66.27	Ontario	Bookcases	0.65
\N	1628	GBC Pre-Punched Binding Paper, Plastic, White, 8-1/2" x 11"	Guy Thornton	28130	-76.99	15.99	13.18	Ontario	Binders and Binder Accessories	0.37
\N	1629	Howard Miller 13" Diameter Goldtone Round Wall Clock	Guy Thornton	28130	598.2	46.94	6.77	Ontario	Office Furnishings	0.44
\N	1630	Fellowes Internet Keyboard, Platinum	Maria Bertelson	28290	-154.24	30.42	8.65	Ontario	Computer Peripherals	0.74
\N	1631	Fellowes Super Stor/Drawer® Files	Maria Bertelson	28290	-179.36	161.55	19.99	Ontario	Storage & Organization	0.66
\N	1632	GBC Binding covers	Bruce Stewart	29927	33.18	12.95	4.98	Ontario	Binders and Binder Accessories	0.4
\N	1633	Acco Recycled 2" Capacity Laser Printer Hanging Data Binders	Brian Thompson	29953	50.24	14.45	7.17	Ontario	Binders and Binder Accessories	0.38
\N	1634	Hoover WindTunnel™ Plus Canister Vacuum	Joseph Airdo	31238	2017.64	363.25	19.99	Ontario	Appliances	0.57
\N	1635	Timeport L7089	Christina Vanderzanden	32067	492.24	125.99	7.69	Ontario	Telephones and Communication	0.58
\N	1636	Imation 3.5" Unformatted DS/HD Diskettes, 10/Box	Joseph Airdo	32198	-117.92	7.37	5.53	Ontario	Computer Peripherals	0.69
\N	1637	Dixon Prang® Watercolor Pencils, 10-Color Set with Brush	Ken Lonsdale	32231	48.54	4.26	1.2	Ontario	Pens & Art Supplies	0.44
\N	1638	Avery 507	Joseph Airdo	32452	-2.03	2.88	0.5	Ontario	Labels	0.39
\N	1639	O'Sullivan Elevations Bookcase, Cherry Finish	Guy Thornton	32998	-484.64	130.98	54.74	Ontario	Bookcases	0.69
\N	1640	Hammermill Color Copier Paper (28Lb. and 96 Bright)	Robert Waldorf	33091	-128.69	9.99	11.59	Ontario	Paper	0.4
\N	1641	Kensington 7 Outlet MasterPiece Power Center	Guy Thornton	33250	2998.88	177.98	0.99	Ontario	Appliances	0.56
\N	1642	Blue String-Tie & Button Interoffice Envelopes, 10 x 13	Joseph Airdo	33378	219.85	39.98	9.83	Ontario	Envelopes	0.4
\N	1643	Avanti 4.4 Cu. Ft. Refrigerator	Christina Vanderzanden	33889	1398.03	180.98	55.24	Ontario	Appliances	0.57
\N	1644	Staples 4 Outlet Surge Protector	Christina Vanderzanden	33889	-16.11	8.67	3.5	Ontario	Appliances	0.58
\N	1645	Wausau Papers Astrobrights® Colored Envelopes	Christina Vanderzanden	33889	21.46	5.98	2.5	Ontario	Envelopes	0.36
\N	1646	Avery 49	Christina Vanderzanden	33889	50.44	2.88	0.5	Ontario	Labels	0.36
\N	1647	Global Ergonomic Managers Chair	Katrina Bavinger	34567	588.54	180.98	26.2	Ontario	Chairs & Chairmats	0.59
\N	1648	Acco Recycled 2" Capacity Laser Printer Hanging Data Binders	Meg O'Connel	36163	24.61	14.45	7.17	Ontario	Binders and Binder Accessories	0.38
\N	1649	Tensor "Hersey Kiss" Styled Floor Lamp	Bruce Stewart	36449	-26.39	12.99	14.37	Ontario	Office Furnishings	0.73
\N	1650	Prang Colored Pencils	Christine Sundaresam	36675	29.76	2.94	0.81	Ontario	Pens & Art Supplies	0.4
\N	1651	Belkin 8 Outlet SurgeMaster II Gold Surge Protector	Guy Thornton	37862	452.49	59.98	3.99	Ontario	Appliances	0.57
\N	1652	Avery Printable Repositionable Plastic Tabs	Ken Lonsdale	38240	-15.53	8.6	6.19	Ontario	Binders and Binder Accessories	0.38
\N	1653	Canon PC1060 Personal Laser Copier	Lycoris Saunders	38693	196.08	699.99	24.49	Ontario	Copiers and Fax	0.41
\N	1654	6120	Joseph Airdo	38917	-132.53	65.99	8.8	Ontario	Telephones and Communication	0.58
\N	1655	Okidata ML320 Series Turbo Dot Matrix Printers	Lycoris Saunders	39015	567.59	399.98	12.06	Ontario	Office Machines	0.56
\N	1656	Xerox 1994	Lycoris Saunders	39015	-28.45	6.48	5.74	Ontario	Paper	0.37
\N	1657	Newell 336	Dorothy Dickinson	39265	32.69	4.28	0.94	Ontario	Pens & Art Supplies	0.56
\N	1658	Belkin 5 Outlet SurgeMaster™ Power Centers	Mary Zewe	40962	547.48	54.48	0.99	Ontario	Appliances	0.57
\N	1659	M70	Mary Zewe	40962	653.06	125.99	8.99	Ontario	Telephones and Communication	0.59
\N	1660	GBC Laser Imprintable Binding System Covers, Desert Sand	Lycoris Saunders	41059	3.92	14.27	7.27	Ontario	Binders and Binder Accessories	0.38
\N	1661	Polycom VoiceStation 100	Lycoris Saunders	41059	5455.96	300.98	13.99	Ontario	Office Machines	0.39
\N	1662	Newell 312	Lycoris Saunders	41059	24.53	5.84	1.2	Ontario	Pens & Art Supplies	0.55
\N	1663	Bretford CR8500 Series Meeting Room Furniture	Lycoris Saunders	41059	2357.86	400.98	42.52	Ontario	Tables	0.71
\N	1664	Memorex Slim 80 Minute CD-R, 10/Pack	Janet Molinari	41664	-15.3	9.78	1.99	Ontario	Computer Peripherals	0.43
\N	1665	Boston 1799 Powerhouse™ Electric Pencil Sharpener	Janet Molinari	41664	230.69	25.98	4.08	Ontario	Pens & Art Supplies	0.57
\N	1666	Newell 314	Liz Thompson	42596	4.16	5.58	0.7	Ontario	Pens & Art Supplies	0.6
\N	1667	Belkin F5C206VTEL 6 Outlet Surge	Maria Bertelson	43424	143.87	22.98	4.5	Ontario	Appliances	0.55
\N	1668	Eldon Expressions Mahogany Wood Desk Collection	Christine Sundaresam	43808	-22.21	6.24	5.22	Ontario	Office Furnishings	0.6
\N	1669	Sony MFD2HD Formatted Diskettes, 10/Pack	Robert Waldorf	45218	-82.64	6.48	2.74	Ontario	Computer Peripherals	0.71
\N	1670	Hoover Upright Vacuum With Dirt Cup	Julie Prescott	46050	-248.69	289.53	19.99	Ontario	Appliances	0.56
\N	1671	Global Deluxe Stacking Chair, Gray	Maria Bertelson	46117	126.07	50.98	14.19	Ontario	Chairs & Chairmats	0.56
\N	1672	Computer Printout Paper with Letter-Trim Perforations	Maria Bertelson	46243	78.89	18.97	9.03	Ontario	Paper	0.37
\N	1673	Newell 335	Maria Bertelson	46243	-1.56	2.88	0.7	Ontario	Pens & Art Supplies	0.56
\N	1674	Quartet Omega® Colored Chalk, 12/Pack	Maria Bertelson	46243	61.51	5.84	1	Ontario	Pens & Art Supplies	0.38
\N	1675	GBC DocuBind P50 Personal Binding Machine	Annie Thurman	46310	652.19	63.98	11.55	Ontario	Binders and Binder Accessories	0.38
\N	1676	Boston 16801 Nautilus™ Battery Pencil Sharpener	Annie Thurman	46310	-6.23	22.01	5.53	Ontario	Pens & Art Supplies	0.59
\N	1677	Iceberg Mobile Mega Data/Printer Cart ®	Annie Thurman	46310	1361.56	120.33	19.99	Ontario	Storage & Organization	0.59
\N	1678	Accessory2	Meg O'Connel	46503	265.39	55.99	1.25	Ontario	Telephones and Communication	0.55
\N	1679	Acme Design Line 8" Stainless Steel Bent Scissors w/Champagne Handles, 3-1/8" Cut	Meg O'Connel	46726	-255.22	6.84	8.37	Ontario	Scissors, Rulers and Trimmers	0.58
\N	1680	Presstex Flexible Ring Binders	Meg O'Connel	46726	8.27	4.55	1.49	Ontario	Binders and Binder Accessories	0.35
\N	1681	Accessory9	Maria Bertelson	47042	592.22	35.99	3.3	Ontario	Telephones and Communication	0.39
\N	1682	Sharp EL500L Fraction Calculator	Maria Bertelson	47174	41.56	13.99	7.51	Ontario	Office Machines	0.39
\N	1683	Boston 16801 Nautilus™ Battery Pencil Sharpener	Robert Waldorf	48034	31.59	22.01	5.53	Ontario	Pens & Art Supplies	0.59
\N	1684	Chromcraft Rectangular Conference Tables	Robert Waldorf	48034	243.16	236.97	59.24	Ontario	Tables	0.61
\N	1685	Newell 340	Christine Sundaresam	48164	12.31	2.88	0.7	Ontario	Pens & Art Supplies	0.56
\N	1686	Security-Tint Envelopes	Brian Thompson	49189	101.82	7.64	1.39	Ontario	Envelopes	0.36
\N	1687	SANFORD Liquid Accent™ Tank-Style Highlighters	Joseph Airdo	49986	8.6	2.84	0.93	Ontario	Pens & Art Supplies	0.54
\N	1688	Avery Binding System Hidden Tab™ Executive Style Index Sets	Joseph Airdo	50336	-17.79	5.77	4.97	Ontario	Binders and Binder Accessories	0.35
\N	1689	Fellowes Super Stor/Drawer® Files	Christina Vanderzanden	50373	-7.58	161.55	19.99	Ontario	Storage & Organization	0.66
\N	1690	Fellowes PB300 Plastic Comb Binding Machine	Julie Prescott	50564	4456.25	387.99	19.99	Ontario	Binders and Binder Accessories	0.38
\N	1691	Stockwell Push Pins	Guy Thornton	50949	7.95	2.18	0.78	Ontario	Rubber Bands	0.52
\N	1692	StarTAC 6500	Guy Thornton	50949	1077.92	125.99	8.8	Ontario	Telephones and Communication	0.59
\N	1693	Xerox 199	Meg O'Connel	51361	-35.99	4.28	5.68	Ontario	Paper	0.4
\N	1694	SAFCO PlanMaster Heigh-Adjustable Drafting Table Base, 43w x 30d x 30-37h, Black	Meg O'Connel	51361	-6474.65	349.45	60	Ontario	Tables	\N
\N	1695	Fellowes Twister Kit, Gray/Clear, 3/pkg	Rob Beeghly	51780	-177.03	8.04	8.94	Ontario	Binders and Binder Accessories	0.4
\N	1696	Imation 3.5" DS/HD IBM Formatted Diskettes, 10/Pack	Ivan Gibson	51940	-55.94	5.98	4.38	Ontario	Computer Peripherals	0.75
\N	1697	GBC Standard Plastic Binding Systems Combs	Annie Thurman	52071	-4.43	8.85	5.6	Ontario	Binders and Binder Accessories	0.36
\N	1698	Staples Plastic Wall Frames	Annie Thurman	52071	-11.39	7.96	4.95	Ontario	Office Furnishings	0.41
\N	1699	Fellowes EZ Multi-Media Keyboard	Bill Eplett	53152	-159.68	34.98	7.53	Ontario	Computer Peripherals	0.76
\N	1700	Telescoping Adjustable Floor Lamp	Bill Eplett	53152	27.91	19.99	11.17	Ontario	Office Furnishings	0.6
\N	1701	Southworth 25% Cotton Premium Laser Paper and Envelopes	Bill Eplett	53152	2.06	19.98	8.68	Ontario	Paper	0.37
\N	1702	Wilson Jones Elliptical Ring 3 1/2" Capacity Binders, 800 sheets	Maria Bertelson	54177	148.2	42.8	2.99	Ontario	Binders and Binder Accessories	0.36
\N	1703	Xerox 210	Maria Bertelson	54177	-98.15	6.48	7.37	Ontario	Paper	0.37
\N	1704	Staples Standard Envelopes	Julie Prescott	55107	46.61	5.68	1.39	Ontario	Envelopes	0.38
\N	1705	Magna Visual Magnetic Picture Hangers	Meg O'Connel	55461	-34.12	4.82	5.72	Ontario	Office Furnishings	0.47
\N	1706	Computer Printout Paper with Letter-Trim Perforations	Guy Thornton	55526	38.11	18.97	9.03	Ontario	Paper	0.37
\N	1707	Fellowes Bankers Box™ Staxonsteel® Drawer File/Stacking System	Meg O'Connel	55969	189.77	64.98	6.88	Ontario	Storage & Organization	0.73
\N	1708	Holmes Replacement Filter for HEPA Air Cleaner, Medium Room	Meg O'Connel	57153	-14.52	11.33	6.12	Ontario	Appliances	0.42
\N	1709	#10 White Business Envelopes,4 1/8 x 9 1/2	Meg O'Connel	57153	336.25	15.67	1.39	Ontario	Envelopes	0.38
\N	1710	Linden® 12" Wall Clock With Oak Frame	Christina Vanderzanden	57538	-244.63	33.98	19.99	Ontario	Office Furnishings	0.55
\N	1711	Wilson Jones DublLock® D-Ring Binders	Doug O'Connell	58656	-0.94	6.75	2.99	Ontario	Binders and Binder Accessories	0.35
\N	1712	Eldon® Wave Desk Accessories	Doug O'Connell	58656	-1.42	2.08	5.33	Ontario	Office Furnishings	0.43
\N	1713	Angle-D Binders with Locking Rings, Label Holders	Christina Vanderzanden	58789	-105.72	7.3	7.72	Ontario	Binders and Binder Accessories	0.38
\N	1714	DAX Solid Wood Frames	Christina Vanderzanden	58789	-10.29	9.77	6.02	Ontario	Office Furnishings	0.48
\N	1715	Belkin F9M820V08 8 Outlet Surge	Maria Bertelson	59200	-30.27	42.98	4.62	Ontario	Appliances	0.56
\N	1716	Staples SlimLine Pencil Sharpener	Maria Bertelson	59200	-37.3	11.97	5.81	Ontario	Pens & Art Supplies	0.6
\N	1717	BASF Silver 74 Minute CD-R	Christine Sundaresam	59459	-51.42	1.7	1.99	Ontario	Computer Peripherals	0.51
\N	1718	Canon P1-DHIII Palm Printing Calculator	Ivan Gibson	59878	-46.75	17.98	8.51	Ontario	Office Machines	0.4
\N	1719	Crate-A-Files™	Ivan Gibson	59878	-91.65	10.9	7.46	Ontario	Storage & Organization	0.59
\N	1720	Hewlett-Packard Deskjet 5550 Color Inkjet Printer	Christina Vanderzanden	59909	-292.65	115.99	56.14	Ontario	Office Machines	0.4
\N	1721	Staples File Caddy	Christina Vanderzanden	59909	-188.02	9.38	7.28	Ontario	Storage & Organization	0.57
\N	1722	Holmes Odor Grabber	Craig Carroll	1218	-25.13	14.42	6.75	Ontario	Appliances	0.52
\N	1723	Eldon Expressions™ Desk Accessory, Wood Pencil Holder, Oak	Liz MacKendrick	1600	-45.99	9.65	6.22	Ontario	Office Furnishings	0.55
\N	1724	Xerox 1922	Liz MacKendrick	1600	-150.74	4.98	7.44	Ontario	Paper	0.36
\N	1725	Avery Printable Repositionable Plastic Tabs	Craig Carroll	2373	-46.12	8.6	6.19	Ontario	Binders and Binder Accessories	0.38
\N	1726	Avery 504	Christine Kargatis	2626	18.02	2.88	0.5	Ontario	Labels	0.36
\N	1727	Executive Impressions 14" Contract Wall Clock with Quartz Movement	Liz MacKendrick	3109	199.3	22.23	8.99	Ontario	Office Furnishings	0.41
\N	1728	Talkabout T8097	Liz MacKendrick	3109	1653.97	205.99	8.99	Ontario	Telephones and Communication	0.58
\N	1729	Executive Impressions 12" Wall Clock	Christine Kargatis	3777	38.06	17.67	8.99	Ontario	Office Furnishings	0.47
\N	1730	Artistic Insta-Plaque	Bobby Odegard	3973	117.91	15.68	3.73	Ontario	Office Furnishings	0.46
\N	1731	Speediset Carbonless Redi-Letter® 7" x 8 1/2"	Bobby Odegard	4932	25.96	10.31	1.79	Ontario	Paper	0.38
\N	1732	Iceberg Mobile Mega Data/Printer Cart ®	Craig Carroll	7239	1416.27	120.33	19.99	Ontario	Storage & Organization	0.59
\N	1733	Ibico Hi-Tech Manual Binding System	Russell Applegate	9088	6523.26	304.99	19.99	Ontario	Binders and Binder Accessories	0.4
\N	1734	V 3600 Series	Russell Applegate	9088	118.15	65.99	8.99	Ontario	Telephones and Communication	0.58
\N	1735	Tyvek® Side-Opening Peel & Seel® Expanding Envelopes	Bill Donatelli	11428	474.66	90.48	19.99	Ontario	Envelopes	0.4
\N	1736	Fellowes PB300 Plastic Comb Binding Machine	Bill Donatelli	12452	-228.24	387.99	19.99	Ontario	Binders and Binder Accessories	0.38
\N	1737	3.5" IBM Formatted Diskettes, DS/HD	Bill Donatelli	12452	-56.78	6.6	4.07	Ontario	Computer Peripherals	0.66
\N	1738	Xerox 1934	Bill Donatelli	12452	989.95	55.98	5.15	Ontario	Paper	0.36
\N	1739	Imation Primaris 3.5" 2HD Unformatted Diskettes, 10/Pack	Bill Donatelli	13345	-42.05	4.77	2.39	Ontario	Computer Peripherals	0.72
\N	1740	Fiskars® Softgrip Scissors	Bill Donatelli	13345	28.39	10.98	3.37	Ontario	Scissors, Rulers and Trimmers	0.57
\N	1741	Imation Neon Mac Format Diskettes, 10/Pack	Bobby Odegard	13410	-35.17	8.12	2.83	Ontario	Computer Peripherals	0.77
\N	1742	TI 36X Solar Scientific Calculator	Bobby Odegard	13410	158.91	23.99	6.3	Ontario	Office Machines	0.38
\N	1743	3M Hangers With Command Adhesive	Bill Donatelli	15808	12.63	3.7	1.61	Ontario	Office Furnishings	0.44
\N	1744	Avery Flip-Chart Easel Binder, Black	Bill Donatelli	15808	-148.93	22.38	15.1	Ontario	Binders and Binder Accessories	0.38
\N	1745	Belkin 105-Key Black Keyboard	Bill Donatelli	15808	11.65	19.98	4	Ontario	Computer Peripherals	0.68
\N	1746	1726 Digital Answering Machine	Bill Donatelli	15808	-96.25	20.99	4.81	Ontario	Telephones and Communication	0.58
\N	1747	80 Minute CD-R Spindle, 100/Pack - Staples	Bill Donatelli	16326	471.35	39.48	1.99	Ontario	Computer Peripherals	0.54
\N	1748	"While you Were Out" Message Book, One Form per Page	Bill Donatelli	16326	14.13	3.71	1.93	Ontario	Paper	0.35
\N	1749	Office Star Flex Back Scooter Chair with White Frame	Duane Benoit	17985	-183.26	110.98	30	Ontario	Chairs & Chairmats	0.71
\N	1750	Accessory39	Duane Benoit	17985	-133.31	20.99	3.3	Ontario	Telephones and Communication	0.81
\N	1751	Atlantic Metals Mobile 2-Shelf Bookcases, Custom Colors	Liz MacKendrick	20480	-219.93	240.98	60.2	Ontario	Bookcases	0.56
\N	1752	GBC Instant Index™ System for Binding Systems	Bill Donatelli	21091	-54.57	8.88	6.28	Ontario	Binders and Binder Accessories	0.35
\N	1753	XtraLife® ClearVue™ Slant-D® Ring Binders by Cardinal	Bobby Odegard	26759	10.04	7.84	4.71	Ontario	Binders and Binder Accessories	0.35
\N	1754	Letter or Legal Size Expandable Poly String Tie Envelopes	Russell Applegate	26853	-89.02	2.66	6.35	Ontario	Envelopes	0.36
\N	1755	*Staples* Highlighting Markers	Russell Applegate	26918	16.65	4.84	0.71	Ontario	Pens & Art Supplies	0.52
\N	1756	Sanyo Counter Height Refrigerator with Crisper, 3.6 Cubic Foot, Stainless Steel/Black	Duane Benoit	27456	772.04	328.14	91.05	Ontario	Appliances	0.57
\N	1757	Park Ridge™ Embossed Executive Business Envelopes	Bill Donatelli	28420	-0.11	15.57	1.39	Ontario	Envelopes	0.38
\N	1758	SAFCO Commercial Wire Shelving, Black	Bobby Odegard	29318	-522.94	138.14	35	Ontario	Storage & Organization	\N
\N	1759	StarTAC ST7762	Bobby Odegard	29318	562.13	125.99	8.08	Ontario	Telephones and Communication	0.57
\N	1760	Xerox 4200 Series MultiUse Premium Copy Paper (20Lb. and 84 Bright)	Bill Donatelli	30016	-41.58	5.28	5.66	Ontario	Paper	0.4
\N	1761	T18	Bill Donatelli	30016	-212.55	110.99	2.5	Ontario	Telephones and Communication	0.57
\N	1762	Xerox 4200 Series MultiUse Premium Copy Paper (20Lb. and 84 Bright)	Russell Applegate	33255	-50.02	5.28	5.66	Ontario	Paper	0.4
\N	1763	Logitech Cordless Access Keyboard	Bill Donatelli	35104	-74.45	29.99	5.5	Ontario	Computer Peripherals	0.51
\N	1764	Luxo Economy Swing Arm Lamp	Bill Donatelli	35104	-44.21	19.94	14.87	Ontario	Office Furnishings	0.57
\N	1765	DAX Contemporary Wood Frame with Silver Metal Mat, Desktop, 11 x 14 Size	Joel Jenkins	35142	89.29	20.24	6.67	Ontario	Office Furnishings	0.49
\N	1766	Filing/Storage Totes and Swivel Casters	Joel Jenkins	35584	-98.23	9.71	9.45	Ontario	Storage & Organization	0.6
\N	1767	HP Office Recycled Paper (20Lb. and 87 Bright)	Brad Eason	35908	-160.21	5.78	7.64	Ontario	Paper	0.36
\N	1768	Portable Personal File Box	Brad Eason	35908	-30.27	12.21	4.81	Ontario	Storage & Organization	0.58
\N	1769	Avery Legal 4-Ring Binder	Brad Eason	36706	365.79	20.98	1.49	Ontario	Binders and Binder Accessories	0.35
\N	1770	14-7/8 x 11 Blue Bar Computer Printout Paper	Brad Eason	36706	-4.46	48.04	19.99	Ontario	Paper	0.37
\N	1771	Hon Multipurpose Stacking Arm Chairs	Bill Donatelli	37121	618.36	216.6	64.2	Ontario	Chairs & Chairmats	0.59
\N	1772	Accessory4	Russell Applegate	38528	-113.06	85.99	0.99	Ontario	Telephones and Communication	0.85
\N	1773	6000	Duane Benoit	38853	20	65.99	2.5	Ontario	Telephones and Communication	0.55
\N	1774	Rediform Wirebound "Phone Memo" Message Book, 11 x 5-3/4	Jason Gross	39590	-13.25	7.64	5.83	Ontario	Paper	0.36
\N	1775	5180	Harold Pawlan	40707	211.09	65.99	8.99	Ontario	Telephones and Communication	0.56
\N	1776	Avery 520	Bill Donatelli	40961	5.88	3.15	0.5	Ontario	Labels	0.37
\N	1777	Global Leather Task Chair, Black	Duane Benoit	41026	-281.76	89.99	42	Ontario	Chairs & Chairmats	0.66
\N	1778	Serrated Blade or Curved Handle Hand Letter Openers	Duane Benoit	41026	-33.11	3.14	1.92	Ontario	Scissors, Rulers and Trimmers	0.84
\N	1779	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Bill Donatelli	41543	1385.35	160.98	30	Ontario	Chairs & Chairmats	0.62
\N	1780	StarTAC 7760	Bill Donatelli	41543	172.33	65.99	3.99	Ontario	Telephones and Communication	0.59
\N	1781	O'Sullivan Living Dimensions 3-Shelf Bookcases	Brad Eason	41606	-641.09	200.98	55.96	Ontario	Bookcases	0.75
\N	1782	Newell 333	Brad Eason	41606	-4.73	2.78	0.97	Ontario	Pens & Art Supplies	0.59
\N	1783	Xerox 23	Harold Pawlan	41926	-28.53	6.48	5.14	Ontario	Paper	0.37
\N	1784	Multi-Use Personal File Cart and Caster Set, Three Stacking Bins	Harold Pawlan	41926	287.74	34.76	8.22	Ontario	Storage & Organization	0.57
\N	1785	Space Solutions Commercial Steel Shelving	Adam Bellavance	50533	-929.68	64.65	35	Ontario	Storage & Organization	0.8
\N	1786	Anderson Hickey Conga Table Tops & Accessories	Adam Bellavance	50533	-53.78	15.23	27.75	Ontario	Tables	0.76
\N	1787	Avery 52	Harold Pawlan	51747	-0.98	3.69	0.5	Ontario	Labels	0.38
\N	1788	Howard Miller 12-3/4 Diameter Accuwave DS ™ Wall Clock	Cari Sayre	53314	1049.02	78.69	19.99	Ontario	Office Furnishings	0.43
\N	1789	Bevis Rectangular Conference Tables	Cari Sayre	53314	-310.95	145.98	51.92	Ontario	Tables	0.69
\N	1790	Office Star - Task Chair with Contemporary Loop Arms	Lisa DeCherney	54791	135.68	90.98	30	Ontario	Chairs & Chairmats	0.61
\N	1791	Wirebound Message Books, 5-1/2 x 4 Forms, 2 or 4 Forms per Page	Harold Pawlan	54912	10.31	6.69	3.1	Ontario	Paper	0.36
\N	1792	Xerox 197	Adam Bellavance	55269	-41.82	30.98	17.08	Ontario	Paper	0.4
\N	1793	Holmes Odor Grabber	Bill Donatelli	56101	-7.22	14.42	6.75	Ontario	Appliances	0.52
\N	1794	GBC Therma-A-Bind 250T Electric Binding System	Bill Donatelli	56101	1886.41	122.99	19.99	Ontario	Binders and Binder Accessories	0.37
\N	1795	O'Sullivan Elevations Bookcase, Cherry Finish	Harold Pawlan	56582	-904.73	130.98	54.74	Ontario	Bookcases	0.69
\N	1796	Aluminum Document Frame	Roy Skaria	56677	120.01	12.22	2.85	Ontario	Office Furnishings	0.55
\N	1797	Wirebound Message Books, 2 7/8" x 5", 3 Forms per Page	Joel Jenkins	58725	37.33	7.04	2.17	Ontario	Paper	0.38
\N	1798	Pressboard Covers with Storage Hooks, 9 1/2" x 11", Light Blue	Bill Donatelli	59683	-82.09	4.91	4.97	Ontario	Binders and Binder Accessories	0.38
\N	1799	Avery Hi-Liter® Smear-Safe Highlighters	Sean O'Donnell	837	13.41	5.84	0.83	Ontario	Pens & Art Supplies	0.49
\N	1800	Wilson Jones 14 Line Acrylic Coated Pressboard Data Binders	Sean O'Donnell	1059	5.3	5.34	2.99	Ontario	Binders and Binder Accessories	0.38
\N	1801	Wilson Jones Ledger-Size, Piano-Hinge Binder, 2", Blue	Sean O'Donnell	1059	310.22	40.98	7.47	Ontario	Binders and Binder Accessories	0.37
\N	1802	Hammermill CopyPlus Copy Paper (20Lb. and 84 Bright)	Susan Vittorini	1826	-14.35	4.98	4.75	Ontario	Paper	0.36
\N	1803	Imation 3.5, DISKETTE 44766 HGHLD3.52HD/FM, 10/Pack	Sandra Glassco	2020	-188.77	5.02	5.14	Ontario	Computer Peripherals	0.79
\N	1804	Hon Pagoda™ Stacking Chairs	Sandra Glassco	10340	2080.48	320.98	24.49	Ontario	Chairs & Chairmats	0.55
\N	1805	Rubbermaid ClusterMat Chairmats, Mat Size- 66" x 60", Lip 20" x 11" -90 Degree Angle	Sandra Glassco	10340	-178.77	110.98	13.99	Ontario	Office Furnishings	0.69
\N	1806	Boston 16801 Nautilus™ Battery Pencil Sharpener	Sandra Glassco	10340	-9.78	22.01	5.53	Ontario	Pens & Art Supplies	0.59
\N	1807	Newell 35	Sandra Glassco	11044	-12.58	3.28	5	Ontario	Pens & Art Supplies	0.56
\N	1808	Tensor "Hersey Kiss" Styled Floor Lamp	Skye Norling	13313	-159.86	12.99	14.37	Ontario	Office Furnishings	0.73
\N	1809	Xerox 1906	Skye Norling	13313	223.44	35.44	7.5	Ontario	Paper	0.38
\N	1810	Acme® 8" Straight Scissors	Skye Norling	13313	75.01	12.98	3.14	Ontario	Scissors, Rulers and Trimmers	0.6
\N	1811	Newell 338	Sean O'Donnell	15718	8.4	2.94	0.7	Ontario	Pens & Art Supplies	0.58
\N	1812	3.6 Cubic Foot Counter Height Office Refrigerator	Susan Vittorini	17506	1939.11	294.62	42.52	Ontario	Appliances	0.57
\N	1813	Belkin 105-Key Black Keyboard	Shirley Schmidt	20003	30.29	19.98	4	Ontario	Computer Peripherals	0.68
\N	1814	Avery Durable Poly Binders	Sandra Glassco	20805	-58.33	5.53	6.98	Ontario	Binders and Binder Accessories	0.39
\N	1815	DAX Copper Panel Document Frame, 5 x 7 Size	Sandra Glassco	20805	73.57	12.58	5.16	Ontario	Office Furnishings	0.43
\N	1816	Xerox 1962	Sandra Glassco	20805	-10.37	4.28	4.79	Ontario	Paper	0.4
\N	1817	Avery Hi-Liter Pen Style Six-Color Fluorescent Set	Sandra Glassco	20805	9.18	3.85	0.7	Ontario	Pens & Art Supplies	0.44
\N	1818	Avery 491	Sandra Glassco	23524	48.25	4.13	0.99	Ontario	Labels	0.39
\N	1819	Xerox 194	Sandra Glassco	23524	748.2	55.48	14.3	Ontario	Paper	0.37
\N	1820	Hot File® 7-Pocket, Floor Stand	Skye Norling	29860	2267.22	178.47	19.99	Ontario	Storage & Organization	0.55
\N	1821	2180	Sandra Glassco	30787	1836.46	175.99	8.99	Ontario	Telephones and Communication	0.57
\N	1822	Eldon Expressions Punched Metal & Wood Desk Accessories, Black & Cherry	Rick Wilson	37440	-4.36	9.38	4.93	Ontario	Office Furnishings	0.57
\N	1823	Avery 514	Sandra Glassco	39872	0.35	2.88	0.99	Ontario	Labels	0.36
\N	1824	BASF Silver 74 Minute CD-R	Rick Wilson	39943	-23.86	1.7	1.99	Ontario	Computer Peripherals	0.51
\N	1825	Accessory39	Rick Wilson	39943	-122.62	20.99	3.3	Ontario	Telephones and Communication	0.81
\N	1826	Xerox 193	Skye Norling	42405	-25.22	5.98	5.15	Ontario	Paper	0.36
\N	1827	Xerox 212	Sandra Glassco	47171	-92.55	6.48	8.4	Ontario	Paper	0.37
\N	1828	Blackstonian Pencils	Sandra Glassco	47171	-0.53	2.67	0.86	Ontario	Pens & Art Supplies	0.57
\N	1829	Chromcraft Bull-Nose Wood Round Conference Table Top, Wood Base	Sandra Glassco	47171	875.55	217.85	29.1	Ontario	Tables	0.68
\N	1830	Lock-Up Easel 'Spel-Binder'	Sandra Glassco	48576	168.22	28.53	1.49	Ontario	Binders and Binder Accessories	0.38
\N	1831	Xerox 220	Sandra Glassco	48576	-161	6.48	7.49	Ontario	Paper	0.37
\N	1832	Adams Phone Message Book, 200 Message Capacity, 8 1/16” x 11”	Rick Wilson	53984	51.43	6.88	2	Ontario	Paper	0.39
\N	1833	Xerox 217	Pauline Chand	129	-22.59	6.48	8.19	Ontario	Paper	0.37
\N	1834	Harmony HEPA Quiet Air Purifiers	Jennifer Halladay	388	-94.73	11.7	6.96	Ontario	Appliances	0.5
\N	1835	Bush Westfield Collection Bookcases, Fully Assembled	Ritsa Hightower	1345	-120.85	100.98	35.84	Ontario	Bookcases	0.62
\N	1836	GBC Standard Plastic Binding Systems' Combs	Joni Blumstein	1793	-71.9	6.28	5.36	Ontario	Binders and Binder Accessories	0.4
\N	1837	Hon 4070 Series Pagoda™ Round Back Stacking Chairs	Pete Armstrong	2209	2245.24	320.98	58.95	Ontario	Chairs & Chairmats	0.57
\N	1838	Wirebound Voice Message Log Book	Pete Armstrong	2209	-1.82	4.76	0.88	Ontario	Paper	0.39
\N	1839	Newell 336	Pete Armstrong	2209	25.88	4.28	0.94	Ontario	Pens & Art Supplies	0.56
\N	1840	270c	Pete Armstrong	2209	-161.12	125.99	3	Ontario	Telephones and Communication	0.59
\N	1841	Xerox 1930	Pete Armstrong	2947	-29.06	6.48	6.81	Ontario	Paper	0.36
\N	1842	Panasonic KX-P1131 Dot Matrix Printer	Joni Blumstein	3271	2753.39	264.98	17.86	Ontario	Office Machines	0.58
\N	1843	REDIFORM Incoming/Outgoing Call Register, 11" X 8 1/2", 100 Messages	Joni Blumstein	3271	51.14	8.34	1.43	Ontario	Paper	0.35
\N	1844	Avery 4027 File Folder Labels for Dot Matrix Printers, 5000 Labels per Box, White	Pauline Chand	4321	-54.63	30.53	19.99	Ontario	Labels	0.39
\N	1845	EcoTones® Memo Sheets	Pauline Chand	4545	26.64	4	1.3	Ontario	Paper	0.37
\N	1846	Xerox 1984	Pauline Chand	4545	-24.15	6.48	8.74	Ontario	Paper	0.36
\N	1847	Imation 3.5" Unformatted DS/HD Diskettes, 10/Box	Anna Gayman	5572	-133.7	7.37	5.53	Ontario	Computer Peripherals	0.69
\N	1848	Xerox 1881	Joni Blumstein	5703	10.44	12.28	6.47	Ontario	Paper	0.38
\N	1849	Dual Level, Single-Width Filing Carts	Nat Gilpin	5920	-121.75	155.06	7.07	Ontario	Storage & Organization	0.59
\N	1850	3395	Anna Gayman	6311	4.21	85.99	10.78	Ontario	Telephones and Communication	0.58
\N	1851	Avery 492	Pauline Chand	8231	29.85	2.88	0.5	Ontario	Labels	0.39
\N	1852	12-1/2 Diameter Round Wall Clock	Pauline Chand	8231	-31.33	19.98	10.49	Ontario	Office Furnishings	0.49
\N	1853	Canon MP25DIII Desktop Whisper-Quiet Printing Calculator	Rose O'Brian	8709	773.36	51.98	10.17	Ontario	Office Machines	0.37
\N	1854	Lexmark Z25 Color Inkjet Printer	Rose O'Brian	8709	-149.46	80.97	33.6	Ontario	Office Machines	0.37
\N	1855	SAFCO Folding Chair Trolley	Rose O'Brian	9765	1019.7	128.24	12.65	Ontario	Chairs & Chairmats	\N
\N	1856	Storex DuraTech Recycled Plastic Frosted Binders	Jennifer Halladay	10147	-72.91	4.24	5.41	Ontario	Binders and Binder Accessories	0.35
\N	1857	Tenex Contemporary Contur Chairmats for Low and Medium Pile Carpet, Computer, 39" x 49"	Joni Blumstein	11876	1708.84	107.53	5.81	Ontario	Office Furnishings	0.65
\N	1858	Bevis 36 x 72 Conference Tables	Joni Blumstein	12224	-186.13	124.49	51.94	Ontario	Tables	0.63
\N	1859	Accessory17	Joni Blumstein	12224	-208.43	35.99	5	Ontario	Telephones and Communication	0.82
\N	1860	Avery 49	Joni Blumstein	12256	44.59	2.88	0.5	Ontario	Labels	0.36
\N	1861	Global Leather Highback Executive Chair with Pneumatic Height Adjustment, Black	Ritsa Hightower	12261	151.86	200.98	23.76	Ontario	Chairs & Chairmats	0.58
\N	1862	Fluorescent Highlighters by Dixon	Ritsa Hightower	12261	1.19	3.98	0.83	Ontario	Pens & Art Supplies	0.51
\N	1863	Acco 6 Outlet Guardian Premium Surge Suppressor	Ritsa Hightower	12261	25.67	14.56	3.5	Ontario	Appliances	0.58
\N	1864	#10- 4 1/8" x 9 1/2" Recycled Envelopes	Ritsa Hightower	12261	-67.19	8.74	8.29	Ontario	Envelopes	0.38
\N	1865	Hot File® 7-Pocket, Floor Stand	Ritsa Hightower	12261	617.4	178.47	19.99	Ontario	Storage & Organization	0.55
\N	1866	Tenex Traditional Chairmats for Medium Pile Carpet, Standard Lip, 36" x 48"	Joni Blumstein	13408	173.89	60.65	12.23	Ontario	Office Furnishings	0.64
\N	1867	Wirebound Voice Message Log Book	Pete Armstrong	13444	54.62	4.76	0.88	Ontario	Paper	0.39
\N	1868	Eureka Hand Vacuum, Bagless	Joni Blumstein	13601	-94.76	49.43	19.99	Ontario	Appliances	0.57
\N	1869	Prang Colored Pencils	Rose O'Brian	13894	21.73	2.94	0.81	Ontario	Pens & Art Supplies	0.4
\N	1870	Accessory23	Rose O'Brian	13894	829.65	35.99	1.25	Ontario	Telephones and Communication	0.36
\N	1871	3M Organizer Strips	Nat Gilpin	16480	-69.53	5.4	7.78	Ontario	Binders and Binder Accessories	0.37
\N	1872	80 Minute Slim Jewel Case CD-R , 10/Pack - Staples	Becky Castell	17858	21.07	8.33	1.99	Ontario	Computer Peripherals	0.52
\N	1873	Logitech Internet Navigator Keyboard	Becky Castell	17858	-109.91	30.98	6.5	Ontario	Computer Peripherals	0.79
\N	1874	Seth Thomas 12" Clock w/ Goldtone Case	Becky Castell	17858	206.56	22.98	7.58	Ontario	Office Furnishings	0.51
\N	1875	Avery 05222 Permanent Self-Adhesive File Folder Labels for Typewriters, on Rolls, White, 250/Roll	Joni Blumstein	18561	-38.9	4.13	6.89	Ontario	Labels	0.39
\N	1876	GBC Prepunched Paper, 19-Hole, for Binding Systems, 24-lb	Pauline Chand	19777	-24.96	15.01	8.4	Ontario	Binders and Binder Accessories	0.39
\N	1877	GBC Recycled Regency Composition Covers	Pauline Chand	19777	-61.88	59.78	10.29	Ontario	Binders and Binder Accessories	0.39
\N	1878	300 Series Non-Flip	Pauline Chand	19777	562.91	155.99	8.08	Ontario	Telephones and Communication	0.6
\N	1879	SAFCO Boltless Steel Shelving	Nat Gilpin	21601	-609.09	113.64	35	Ontario	Storage & Organization	\N
\N	1880	Howard Miller 12-3/4 Diameter Accuwave DS ™ Wall Clock	Joni Blumstein	21670	830.75	78.69	19.99	Ontario	Office Furnishings	0.43
\N	1881	DS/HD IBM Formatted Diskettes, 200/Pack - Staples	Ritsa Hightower	23489	230.3	47.98	3.61	Ontario	Computer Peripherals	0.71
\N	1882	Imation Neon Mac Format Diskettes, 10/Pack	Pete Armstrong	24486	-31.62	8.12	2.83	Ontario	Computer Peripherals	0.77
\N	1883	Newell 310	Pete Armstrong	24486	-0.06	1.76	0.7	Ontario	Pens & Art Supplies	0.56
\N	1884	GBC Standard Plastic Binding Systems Combs	Nat Gilpin	24869	-9.18	8.85	5.6	Ontario	Binders and Binder Accessories	0.36
\N	1885	Imation 3.5", RTS 247544 3M 3.5 DSDD, 10/Pack	Joni Blumstein	25697	-37.5	8.46	3.62	Ontario	Computer Peripherals	0.61
\N	1886	GBC Wire Binding Strips	Daniel Raglin	27490	93.23	31.74	12.62	Ontario	Binders and Binder Accessories	0.37
\N	1887	Xerox 1952	Rose O'Brian	27844	-73.42	4.98	5.49	Ontario	Paper	0.38
\N	1888	Electrix Halogen Magnifier Lamp	Pauline Chand	28451	1162.76	194.3	11.54	Ontario	Office Furnishings	0.59
\N	1889	Luxo Professional Fluorescent Magnifier Lamp with Clamp-Mount Base	Pauline Chand	28451	2593.14	209.84	21.21	Ontario	Office Furnishings	0.59
\N	1890	Panasonic KX-P1150 Dot Matrix Printer	Pauline Chand	28451	1054.93	145.45	17.85	Ontario	Office Machines	0.56
\N	1891	Master Caster Door Stop, Gray	Jennifer Halladay	28482	-27.39	5.08	3.63	Ontario	Office Furnishings	0.51
\N	1892	Xerox 1927	Jennifer Halladay	28482	-167.92	4.28	6.72	Ontario	Paper	0.4
\N	1893	Wilson Jones 1" Hanging DublLock® Ring Binders	Pauline Chand	28642	14.48	5.28	2.99	Ontario	Binders and Binder Accessories	0.37
\N	1894	iDENi80s	Pauline Chand	28642	-52.7	65.99	19.99	Ontario	Telephones and Communication	0.59
\N	1895	Xerox 1933	Anna Gayman	29380	1.73	12.28	4.86	Ontario	Paper	0.38
\N	1896	Xerox 1940	Pauline Chand	32036	45.76	54.96	10.75	Ontario	Paper	0.36
\N	1897	Pizazz® Global Quick File™	Pauline Chand	32036	-68.49	14.97	7.51	Ontario	Storage & Organization	0.57
\N	1898	i1000	Pauline Chand	32295	-112.24	65.99	5.99	Ontario	Telephones and Communication	0.58
\N	1899	EcoTones® Memo Sheets	Pete Armstrong	33505	20.82	4	1.3	Ontario	Paper	0.37
\N	1900	3395	Pete Armstrong	33505	310.57	85.99	10.78	Ontario	Telephones and Communication	0.58
\N	1901	6190	Nat Gilpin	34086	655.91	65.99	2.5	Ontario	Telephones and Communication	0.55
\N	1902	Coloredge Poster Frame	Ritsa Hightower	34209	165.9	14.2	5.3	Ontario	Office Furnishings	0.46
\N	1903	Staples Colored Bar Computer Paper	Ritsa Hightower	34209	437.61	35.44	4.92	Ontario	Paper	0.38
\N	1904	Park Ridge™ Embossed Executive Business Envelopes	Daniel Raglin	36807	78.45	15.57	1.39	Ontario	Envelopes	0.38
\N	1905	Linden® 12" Wall Clock With Oak Frame	Nat Gilpin	37318	-138.54	33.98	19.99	Ontario	Office Furnishings	0.55
\N	1906	Xerox 1949	Pauline Chand	38496	-43.18	4.98	4.72	Ontario	Paper	0.36
\N	1907	Adesso Programmable 142-Key Keyboard	Corinna Mitchell	41702	99.88	152.48	4	Ontario	Computer Peripherals	0.79
\N	1908	Xerox 1927	Corinna Mitchell	41702	-22.82	4.28	6.72	Ontario	Paper	0.4
\N	1909	Bush Advantage Collection® Racetrack Conference Table	Ritsa Hightower	44706	-352.24	424.21	110.2	Ontario	Tables	0.67
\N	1910	Binder Clips by OIC	Ritsa Hightower	44706	3.35	1.48	0.7	Ontario	Rubber Bands	0.37
\N	1911	Riverside Palais Royal Lawyers Bookcase, Royale Cherry Finish	Ritsa Hightower	45347	1034.54	880.98	44.55	Ontario	Bookcases	0.62
\N	1912	Hewlett Packard LaserJet 3310 Copier	Ritsa Hightower	45347	9791.04	599.99	24.49	Ontario	Copiers and Fax	0.37
\N	1913	Xerox 1928	Eva Jacobs	46627	-14.22	5.28	6.26	Ontario	Paper	0.4
\N	1914	8860	Eva Jacobs	46627	261.52	65.99	5.26	Ontario	Telephones and Communication	0.56
\N	1915	Epson C82 Color Inkjet Printer	Corinna Mitchell	47168	1068.16	119.99	14	Ontario	Office Machines	0.36
\N	1916	Xerox 1993	Corinna Mitchell	47168	-255.2	6.48	9.68	Ontario	Paper	0.36
\N	1917	Avery Durable Poly Binders	Jas O'Carroll	50051	-72.06	5.53	6.98	Ontario	Binders and Binder Accessories	0.39
\N	1918	Eldon Econocleat® Chair Mats for Low Pile Carpets	Jas O'Carroll	50051	10.2	41.47	34.2	Ontario	Office Furnishings	0.73
\N	1919	Panasonic KX-P1150 Dot Matrix Printer	Jennifer Halladay	50433	1081.65	145.45	17.85	Ontario	Office Machines	0.56
\N	1920	Ibico Hi-Tech Manual Binding System	Jennifer Halladay	50721	3793.7	304.99	19.99	Ontario	Binders and Binder Accessories	0.4
\N	1921	HP Office Paper (20Lb. and 87 Bright)	Ritsa Hightower	50758	-44.69	6.68	6.93	Ontario	Paper	0.37
\N	1922	Office Star - Ergonomic Mid Back Chair with 2-Way Adjustable Arms	Pauline Chand	50883	957.29	180.98	30	Ontario	Chairs & Chairmats	0.69
\N	1923	Office Impressions Heavy Duty Welded Shelving & Multimedia Storage Drawers	Pauline Chand	51524	-446.31	167.27	35	Ontario	Storage & Organization	0.85
\N	1924	Accessory15	Pauline Chand	51524	-71.09	20.99	0.99	Ontario	Telephones and Communication	0.83
\N	1925	Advantus Map Pennant Flags and Round Head Tacks	Joni Blumstein	52322	-2.34	3.95	2	Ontario	Rubber Bands	0.53
\N	1926	Xerox 21	Joni Blumstein	52932	-13.72	6.48	6.6	Ontario	Paper	0.37
\N	1927	Cardinal Poly Pocket Divider Pockets for Ring Binders	Nat Gilpin	52995	-35.51	3.36	6.27	Ontario	Binders and Binder Accessories	0.4
\N	1928	Career Cubicle Clock, 8 1/4", Black	Ritsa Hightower	53024	12.4	20.28	14.39	Ontario	Office Furnishings	0.47
\N	1929	Accessory6	Ritsa Hightower	53024	74.51	55.99	5	Ontario	Telephones and Communication	0.8
\N	1930	Eldon® Wave Desk Accessories	Joni Blumstein	54145	-133.06	2.08	5.33	Ontario	Office Furnishings	0.43
\N	1931	Xerox 190	Jas O'Carroll	55840	-25.21	4.98	4.86	Ontario	Paper	0.38
\N	1932	Tennsco Regal Shelving Units	Eva Jacobs	56930	-396.84	101.41	35	Ontario	Storage & Organization	0.82
\N	1933	Hon Metal Bookcases, Black	Daniel Raglin	57570	-190.78	70.98	26.74	Ontario	Bookcases	0.6
\N	1934	IBM Active Response Keyboard, Black	Pauline Chand	58051	-106.76	39.98	7.12	Ontario	Computer Peripherals	0.67
\N	1935	Fuji Slim Jewel Case CD-R	Pauline Chand	59392	-29.02	2.12	1.99	Ontario	Computer Peripherals	0.55
\N	1936	Memorex 4.7GB DVD+RW, 3/Pack	Pauline Chand	59392	589.2	28.48	1.99	Ontario	Computer Peripherals	0.4
\N	1937	Boston School Pro Electric Pencil Sharpener, 1670	Paul Prost	3136	-38.89	30.98	8.99	Ontario	Pens & Art Supplies	0.58
\N	1938	Self-Adhesive Removable Labels	Philip Brown	3648	52.36	3.15	0.49	Ontario	Labels	0.37
\N	1939	KH 688	Philip Brown	3648	1382.45	195.99	4.2	Ontario	Telephones and Communication	0.57
\N	1940	Staples Vinyl Coated Paper Clips	Philip Brown	6246	11.72	3.93	0.99	Ontario	Rubber Bands	0.39
\N	1941	Okidata ML184 Turbo Dot Matrix Printers	Michael Nguyen	9028	3829.63	306.14	26.53	Ontario	Office Machines	0.56
\N	1942	Executive Impressions 8-1/2" Career Panel/Partition Cubicle Clock	Philip Brown	9478	29.98	10.4	5.4	Ontario	Office Furnishings	0.51
\N	1943	Xerox 1962	Philip Brown	9478	-121.2	4.28	4.79	Ontario	Paper	0.4
\N	1944	Plastic Binding Combs	Lisa DeCherney	12323	-28.68	15.15	10.13	Ontario	Binders and Binder Accessories	0.38
\N	1945	Eldon® Expressions™ Wood Desk Accessories, Oak	Lisa DeCherney	12323	14.19	7.38	5.21	Ontario	Office Furnishings	0.56
\N	1946	Tyvek® Side-Opening Peel & Seel® Expanding Envelopes	Michael Nguyen	13830	911.66	90.48	19.99	Ontario	Envelopes	0.4
\N	1947	TIMEPORT P8767	Lisa DeCherney	14791	286.12	65.99	3.99	Ontario	Telephones and Communication	0.57
\N	1948	Bretford CR4500 Series Slim Rectangular Table	Lisa DeCherney	18085	1541.25	348.21	40.19	Ontario	Tables	0.62
\N	1949	KH 688	Lisa DeCherney	18085	1343.21	195.99	4.2	Ontario	Telephones and Communication	0.57
\N	1950	Epson Stylus 1520 Color Inkjet Printer	Philip Brown	20674	8291.08	500.97	69.3	Ontario	Office Machines	0.37
\N	1951	Xerox 1891	Paul Prost	24903	743.59	48.91	5.81	Ontario	Paper	0.38
\N	1952	DIXON Ticonderoga® Erasable Checking Pencils	Lisa DeCherney	25735	44.15	5.58	1.99	Ontario	Pens & Art Supplies	0.46
\N	1953	Bevis Steel Folding Chairs	Philip Brown	29762	-1181.71	95.95	74.35	Ontario	Chairs & Chairmats	0.57
\N	1954	Rediform S.O.S. Phone Message Books	Lisa DeCherney	29856	43.35	4.98	0.8	Ontario	Paper	0.36
\N	1955	It's Hot Message Books with Stickers, 2 3/4" x 5"	Paul MacIntyre	32580	44.59	7.4	1.71	Ontario	Paper	0.4
\N	1956	Xerox 1984	Paul MacIntyre	32580	-172.35	6.48	8.74	Ontario	Paper	0.36
\N	1957	*Staples* Highlighting Markers	Paul Prost	34017	29.17	4.84	0.71	Ontario	Pens & Art Supplies	0.52
\N	1958	Super Decoflex Portable Personal File	Paul Prost	34017	-48.97	14.98	7.69	Ontario	Storage & Organization	0.57
\N	1959	DS/HD IBM Formatted Diskettes, 10/Pack - Staples	Paul Prost	42597	-32.78	4.98	4.32	Ontario	Computer Peripherals	0.64
\N	1960	Newell 309	Paul Prost	46884	39.52	11.55	2.36	Ontario	Pens & Art Supplies	0.55
\N	1961	GBC DocuBind TL200 Manual Binding Machine	Paul MacIntyre	52325	2019.19	223.98	15.01	Ontario	Binders and Binder Accessories	0.38
\N	1962	Bravo II™ Megaboss® 12-Amp Hard Body Upright, Replacement Belts, 2 Belts per Pack	Paul MacIntyre	53382	-572.49	3.25	49	Ontario	Appliances	0.56
\N	1963	Global Leather and Oak Executive Chair, Black	Paul MacIntyre	53382	658.88	300.98	64.73	Ontario	Chairs & Chairmats	0.56
\N	1964	Avery Arch Ring Binders	Paul MacIntyre	53728	637.6	58.1	1.49	Ontario	Binders and Binder Accessories	0.38
\N	1965	Verbatim DVD-R, 4.7GB, Spindle, WE, Blank, Ink Jet/Thermal, 20/Spindle	Tamara Dahlen	65	1470.3	115.79	1.99	Ontario	Computer Peripherals	0.49
\N	1966	Boston 1645 Deluxe Heavier-Duty Electric Pencil Sharpener	Erin Creighton	230	320.37	43.98	8.99	Ontario	Pens & Art Supplies	0.58
\N	1967	StarTAC ST7762	Erin Creighton	230	-212.33	125.99	8.08	Ontario	Telephones and Communication	0.57
\N	1968	Accessory4	Henry MacAllister	355	-172.55	85.99	0.99	Ontario	Telephones and Communication	0.85
\N	1969	Eldon® Expressions™ Wood Desk Accessories, Oak	Candace McMahon	449	-48.97	7.38	5.21	Ontario	Office Furnishings	0.56
\N	1970	O'Sullivan Living Dimensions 2-Shelf Bookcases	Tamara Chand	640	-1153.9	120.98	58.64	Ontario	Bookcases	0.75
\N	1971	Xerox 1939	Tamara Chand	640	29.42	18.97	9.54	Ontario	Paper	0.37
\N	1972	Acme® Forged Steel Scissors with Black Enamel Handles	Duane Huffman	646	-10.9	9.31	3.98	Ontario	Scissors, Rulers and Trimmers	0.56
\N	1973	Xerox 23	Duane Huffman	835	-23.48	6.48	5.14	Ontario	Paper	0.37
\N	1974	GBC Standard Therm-A-Bind Covers	Edward Nazzal	896	52.48	24.92	12.98	Ontario	Binders and Binder Accessories	0.39
\N	1975	OIC Colored Binder Clips, Assorted Sizes	Kelly Lampkin	994	14	3.58	1.63	Ontario	Rubber Bands	0.36
\N	1976	Imation 3.5", RTS 247544 3M 3.5 DSDD, 10/Pack	Anthony Witt	1057	-52.48	8.46	3.62	Ontario	Computer Peripherals	0.61
\N	1977	T60	Ted Trevino	1538	149.82	95.99	4.9	Ontario	Telephones and Communication	0.56
\N	1978	Imation Printable White 80 Minute CD-R Spindle, 50/Pack	Ed Ludwig	1701	902.62	40.98	1.99	Ontario	Computer Peripherals	0.44
\N	1979	Dana Halogen Swing-Arm Architect Lamp	Ed Ludwig	1701	-22.16	40.97	14.45	Ontario	Office Furnishings	0.57
\N	1980	Tenex Contemporary Contur Chairmats for Low and Medium Pile Carpet, Computer, 39" x 49"	Jeremy Ellison	1891	290.31	107.53	5.81	Ontario	Office Furnishings	0.65
\N	1981	Hoover Replacement Belts For Soft Guard™ & Commercial Ltweight Upright Vacs, 2/Pk	Alan Hwang	2022	-157.18	3.95	5.13	Ontario	Appliances	0.59
\N	1982	Avery 494	Kelly Lampkin	2181	36.62	2.61	0.5	Ontario	Labels	0.39
\N	1983	OIC Bulk Pack Metal Binder Clips	Kelly Lampkin	2181	2.53	3.49	0.76	Ontario	Rubber Bands	0.39
\N	1984	*Staples* Letter Opener	Eileen Kiefer	2628	-60.13	2.18	5	Ontario	Scissors, Rulers and Trimmers	0.81
\N	1985	BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	Eileen Kiefer	2628	-752.83	218.75	69.64	Ontario	Tables	0.77
\N	1986	Atlantic Metals Mobile 3-Shelf Bookcases, Custom Colors	Ted Trevino	2691	98.75	260.98	41.91	Ontario	Bookcases	0.59
\N	1987	Epson DFX-8500 Dot Matrix Printer	Tamara Dahlen	2912	-3476.86	2550.14	29.7	Ontario	Office Machines	0.57
\N	1988	Xerox 1908	Tamara Dahlen	2912	170.9	55.98	4.86	Ontario	Paper	0.36
\N	1989	Sterling Rubber Bands by Alliance	James Lanier	3235	-12.26	4.71	0.7	Ontario	Rubber Bands	0.85
\N	1990	Durable Pressboard Binders	Edward Becker	3266	-2.55	3.8	1.49	Ontario	Binders and Binder Accessories	0.38
\N	1991	Deluxe Rollaway Locking File with Drawer	Gary Zandusky	3363	2137.28	415.88	11.37	Ontario	Storage & Organization	0.57
\N	1992	Riverleaf Stik-Withit® Designer Note Cubes®	Ann Blume	3585	78.05	10.06	2.06	Ontario	Paper	0.39
\N	1993	Newell 323	Ann Blume	3585	-35.75	1.68	1.57	Ontario	Pens & Art Supplies	0.59
\N	1994	Deflect-o SuperTray™ Unbreakable Stackable Tray, Letter, Black	Erin Smith	3745	411.1	29.18	8.55	Ontario	Office Furnishings	0.42
\N	1995	Xerox 1948	Allen Golden	4128	25.03	9.99	5.12	Ontario	Paper	0.4
\N	1996	Eldon® Expressions™ Wood Desk Accessories, Oak	Erin Creighton	4354	7.74	7.38	5.21	Ontario	Office Furnishings	0.56
\N	1997	Epson C62 Color Inkjet Printer	Gary Zandusky	4550	1369.09	119.99	16.8	Ontario	Office Machines	0.35
\N	1998	Mead 1st Gear 2" Zipper Binder, Asst. Colors	Gary Zandusky	4743	128.99	12.97	1.49	Ontario	Binders and Binder Accessories	0.35
\N	1999	Iris® 3-Drawer Stacking Bin, Black	Gary Zandusky	4743	-245.62	20.89	11.52	Ontario	Storage & Organization	0.83
\N	2000	2160	Tamara Dahlen	5251	1057.89	115.99	5.99	Ontario	Telephones and Communication	0.57
\N	2001	Timeport L7089	Gary Zandusky	5283	417.47	125.99	7.69	Ontario	Telephones and Communication	0.58
\N	2002	Tenex Contemporary Contur Chairmats for Low and Medium Pile Carpet, Computer, 39" x 49"	Edward Nazzal	5381	1545.09	107.53	5.81	Ontario	Office Furnishings	0.65
\N	2003	Ampad® Evidence® Wirebond Steno Books, 6" x 9"	Edward Nazzal	5381	-149.93	2.18	7.09	Ontario	Paper	0.38
\N	2004	Canon PC940 Copier	Frank Carlisle	5444	-2024.08	449.99	24.49	Ontario	Copiers and Fax	0.52
\N	2005	Aluminum Document Frame	Gary Hansen	5601	49.26	12.22	2.85	Ontario	Office Furnishings	0.55
\N	2006	Global Airflow Leather Mesh Back Chair, Black	Nancy Lomonaco	5760	650.3	150.98	43.71	Ontario	Chairs & Chairmats	0.55
\N	2007	DAX Solid Wood Frames	Anna Haberlin	6438	20.29	9.77	6.02	Ontario	Office Furnishings	0.48
\N	2008	Xerox 1992	Anna Haberlin	6438	-66.16	5.98	5.2	Ontario	Paper	0.36
\N	2009	Acme Design Line 8" Stainless Steel Bent Scissors w/Champagne Handles, 3-1/8" Cut	Tamara Chand	6592	-177.17	6.84	8.37	Ontario	Scissors, Rulers and Trimmers	0.58
\N	2010	Tennsco Industrial Shelving	Tamara Chand	6592	-971.36	48.91	35	Ontario	Storage & Organization	0.83
\N	2011	Wilson Jones Hanging View Binder, White, 1"	Kelly Lampkin	6755	-39.23	7.1	6.05	Ontario	Binders and Binder Accessories	0.39
\N	2012	80 Minute CD-R Spindle, 100/Pack - Staples	Erin Ashbrook	6918	515.83	39.48	1.99	Ontario	Computer Peripherals	0.54
\N	2013	Electrix Fluorescent Magnifier Lamps & Weighted Base	Darren Budd	7841	295.6	49.34	10.25	Ontario	Office Furnishings	0.57
\N	2014	Coloredge Poster Frame	Darren Budd	7841	56.3	10.06	2.06	Ontario	Office Furnishings	0.46
\N	2015	Binding Machine Supplies	Bill Stewart	8103	107.38	29.17	6.27	Ontario	Binders and Binder Accessories	0.37
\N	2016	Staples 1 Part Blank Computer Paper	James Lanier	8258	-155.21	11.34	11.25	Ontario	Paper	0.36
\N	2017	3M Organizer Strips	Christine Phan	8454	-188.13	5.4	7.78	Ontario	Binders and Binder Accessories	0.37
\N	2018	Cardinal Poly Pocket Divider Pockets for Ring Binders	Tamara Dahlen	8710	-76.02	3.36	6.27	Ontario	Binders and Binder Accessories	0.4
\N	2019	"While you Were Out" Message Book, One Form per Page	Tamara Dahlen	8710	8.33	3.71	1.93	Ontario	Paper	0.35
\N	2020	Advantus Panel Wall Certificate Holder - 8.5x11	James Lanier	8835	-6.15	12.2	6.02	Ontario	Office Furnishings	0.43
\N	2021	US Robotics 56K V.92 External Faxmodem	Christine Phan	8960	524.09	99.99	19.99	Ontario	Computer Peripherals	0.52
\N	2022	Accessory8	Christine Phan	8960	361.65	85.99	1.25	Ontario	Telephones and Communication	0.39
\N	2023	Xerox 1930	Alan Hwang	9281	-96.59	6.48	6.81	Ontario	Paper	0.36
\N	2024	Newell 339	Alan Hwang	9281	0.77	2.78	0.97	Ontario	Pens & Art Supplies	0.59
\N	2025	Bush Heritage Pine Collection 5-Shelf Bookcase, Albany Pine Finish, *Special Order	Darren Budd	9350	-432.54	140.98	53.48	Ontario	Bookcases	0.65
\N	2026	Tenex Traditional Chairmats for Medium Pile Carpet, Standard Lip, 36" x 48"	Darren Budd	9350	-210.78	172.99	19.99	Ontario	Office Furnishings	0.64
\N	2027	Bionaire Personal Warm Mist Humidifier/Vaporizer	Eugene Hildebrand	9665	921.41	46.89	5.1	Ontario	Appliances	0.46
\N	2028	Sauder Forest Hills Library, Woodland Oak Finish	Eugene Hildebrand	9665	-373.09	140.98	36.09	Ontario	Bookcases	0.77
\N	2029	Bush Advantage Collection® Round Conference Table	Eugene Hildebrand	9665	-3465.07	212.6	110.2	Ontario	Tables	0.73
\N	2030	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Edward Nazzal	9893	-98.3	160.98	30	Ontario	Chairs & Chairmats	0.62
\N	2031	Global Stack Chair without Arms, Black	Darren Budd	10183	-279.44	25.98	14.36	Ontario	Chairs & Chairmats	0.6
\N	2032	Xerox 1952	Edward Becker	10247	-53.33	4.98	5.49	Ontario	Paper	0.38
\N	2033	Memorex Slim 80 Minute CD-R, 10/Pack	Edward Becker	10247	44.14	9.78	1.99	Ontario	Computer Peripherals	0.43
\N	2034	Acme Galleria® Hot Forged Steel Scissors with Colored Handles	Melanie Page	10371	-37.6	15.73	7.42	Ontario	Scissors, Rulers and Trimmers	0.56
\N	2035	Sanford 52201 APSCO Electric Pencil Sharpener	Jesus Ocampo	10498	327.9	40.97	8.99	Ontario	Pens & Art Supplies	0.59
\N	2036	DS/HD IBM Formatted Diskettes, 200/Pack - Staples	Darren Powers	10624	23.97	47.98	3.61	Ontario	Computer Peripherals	0.71
\N	2037	Tenex Personal Self-Stacking Standard File Box, Black/Gray	Patrick Bzostek	11425	-16.59	16.91	6.25	Ontario	Storage & Organization	0.58
\N	2038	CF 688	Patrick Bzostek	11425	383.45	155.99	8.99	Ontario	Telephones and Communication	0.58
\N	2039	3.5" IBM Formatted Diskettes, DS/HD	Darren Budd	11491	-80.11	6.6	4.07	Ontario	Computer Peripherals	0.66
\N	2040	Staples Plastic Wall Frames	Darren Budd	11491	739.48	48.04	7.23	Ontario	Office Furnishings	0.41
\N	2041	Xerox 1940	Melanie Page	11841	886.03	54.96	10.75	Ontario	Paper	0.36
\N	2042	Staples SlimLine Pencil Sharpener	Melanie Page	11841	-88.32	11.97	5.81	Ontario	Pens & Art Supplies	0.6
\N	2043	Avery 48	Jesus Ocampo	11878	36.23	6.3	0.5	Ontario	Labels	0.39
\N	2044	Xerox 214	Jesus Ocampo	11878	-52.55	6.48	7.03	Ontario	Paper	0.37
\N	2045	Flat Face Poster Frame	Grace Kelly	12130	290.2	18.84	3.62	Ontario	Office Furnishings	0.43
\N	2046	Accessory41	Grace Kelly	12130	444.15	35.99	5.99	Ontario	Telephones and Communication	0.38
\N	2047	Bevis Steel Folding Chairs	Darren Budd	12160	865.02	208.16	68.02	Ontario	Chairs & Chairmats	0.57
\N	2048	Global Deluxe Stacking Chair, Gray	Darren Budd	12160	-45.3	24.98	8.79	Ontario	Chairs & Chairmats	0.56
\N	2049	Dana Fluorescent Magnifying Lamp, White, 36"	Darren Budd	12160	-42.49	3.36	6.27	Ontario	Office Furnishings	0.55
\N	2050	Office Star - Ergonomic Mid Back Chair with 2-Way Adjustable Arms	Kelly Lampkin	12258	-264.94	180.98	30	Ontario	Chairs & Chairmats	0.69
\N	2051	Bravo II™ Megaboss® 12-Amp Hard Body Upright, Replacement Belts, 2 Belts per Pack	Kelly Lampkin	12258	-52.54	3.25	49	Ontario	Appliances	0.56
\N	2052	Rubbermaid ClusterMat Chairmats, Mat Size- 66" x 60", Lip 20" x 11" -90 Degree Angle	Kelly Lampkin	12258	660.63	110.98	13.99	Ontario	Office Furnishings	0.69
\N	2053	Advantus Map Pennant Flags and Round Head Tacks	Kelly Lampkin	12258	-5.02	3.95	2	Ontario	Rubber Bands	0.53
\N	2054	Belkin 7 Outlet SurgeMaster Surge Protector with Phone Protection	Dan Lawera	12263	123.5	39.48	3.99	Ontario	Appliances	0.56
\N	2055	232	George Ashbrook	12551	1665.23	125.99	5.26	Ontario	Telephones and Communication	0.55
\N	2056	Eldon Expressions™ Desk Accessory, Wood Pencil Holder, Oak	Henry MacAllister	12736	21.77	9.65	6.22	Ontario	Office Furnishings	0.55
\N	2057	Belkin F9M820V08 8 Outlet Surge	Kelly Lampkin	12768	501.59	42.98	4.62	Ontario	Appliances	0.56
\N	2058	Avery 474	Dave Hallsten	12837	15.84	2.88	0.99	Ontario	Labels	0.36
\N	2059	Avery 487	Edward Becker	12897	59.92	3.69	0.5	Ontario	Labels	0.38
\N	2060	Xerox 216	Edward Becker	12897	-120.95	6.48	7.91	Ontario	Paper	0.37
\N	2061	Avery Binder Labels	Nancy Lomonaco	13030	-154.31	3.89	7.01	Ontario	Binders and Binder Accessories	0.37
\N	2062	Xerox 214	Arthur Wiediger	13091	-44.66	6.48	7.03	Ontario	Paper	0.37
\N	2063	Tennsco Commercial Shelving	Arthur Wiediger	13091	-1148.19	20.34	35	Ontario	Storage & Organization	0.84
\N	2064	Tennsco Commercial Shelving	Duane Huffman	13383	-1072.97	20.34	35	Ontario	Storage & Organization	0.84
\N	2065	Memorex 80 Minute CD-R Spindle, 100/Pack	Jim Mitchum	13440	326.39	43.98	1.99	Ontario	Computer Peripherals	0.44
\N	2066	US Robotics 56K V.92 External Faxmodem	Erin Ashbrook	13479	-322.95	99.99	19.99	Ontario	Computer Peripherals	0.52
\N	2067	i470	Erin Ashbrook	13479	-1.63	205.99	5.26	Ontario	Telephones and Communication	0.56
\N	2068	DMI Arturo Collection Mission-style Design Wood Chair	Alan Hwang	13633	-231.6	150.98	57.2	Ontario	Chairs & Chairmats	0.59
\N	2069	Eldon Base for stackable storage shelf, platinum	Alan Hwang	13633	-1119.64	38.94	35	Ontario	Storage & Organization	0.8
\N	2070	#10- 4 1/8" x 9 1/2" Security-Tint Envelopes	Edward Becker	13735	117.38	7.64	1.39	Ontario	Envelopes	0.36
\N	2071	*Staples* Highlighting Markers	Andy Yotov	13861	5.03	4.84	0.71	Ontario	Pens & Art Supplies	0.52
\N	2072	Verbatim DVD-RAM, 5.2GB, Rewritable, Type 1, DS	Frank Hawley	13892	531.47	29.89	1.99	Ontario	Computer Peripherals	0.5
\N	2073	Acco D-Ring Binder w/DublLock®	Edward Becker	14023	241.08	21.38	2.99	Ontario	Binders and Binder Accessories	0.36
\N	2074	Xerox 1948	Edward Becker	14023	40.61	9.99	5.12	Ontario	Paper	0.4
\N	2075	Eldon® 200 Class™ Desk Accessories	Jim Mitchum	14115	-38.38	6.28	5.41	Ontario	Office Furnishings	0.53
\N	2076	3395	Jim Mitchum	14115	591.91	85.99	10.78	Ontario	Telephones and Communication	0.58
\N	2077	Avery Trapezoid Extra Heavy Duty 4" Binders	Theresa Coyne	14147	107.32	41.94	2.99	Ontario	Binders and Binder Accessories	0.35
\N	2078	Xerox 1927	Theresa Coyne	14147	-69.34	4.28	6.72	Ontario	Paper	0.4
\N	2079	Xerox 1953	Theresa Coyne	14147	-148.87	4.28	5.74	Ontario	Paper	0.4
\N	2080	Canon MP41DH Printing Calculator	Frank Hawley	14211	1046.69	150.98	13.99	Ontario	Office Machines	0.38
\N	2081	Fellowes High-Stak® Drawer Files	Frank Hawley	14211	320.1	176.19	11.87	Ontario	Storage & Organization	0.62
\N	2082	Tenex 46" x 60" Computer Anti-Static Chairmat, Rectangular Shaped	Ivan Liston	14368	319.64	105.98	13.99	Ontario	Office Furnishings	0.65
\N	2083	Panasonic KP-350BK Electric Pencil Sharpener with Auto Stop	Ivan Liston	14368	99.79	34.58	8.99	Ontario	Pens & Art Supplies	0.56
\N	2084	Document Clip Frames	Darren Powers	14596	73.33	8.34	0.96	Ontario	Office Furnishings	0.43
\N	2085	Newell 337	Darren Powers	14596	-53.75	3.28	3.97	Ontario	Pens & Art Supplies	0.56
\N	2086	Xerox 221	Darren Powers	14693	-87.52	6.48	6.41	Ontario	Paper	0.37
\N	2087	Tennsco Lockers, Sand	Darren Powers	14693	-1348.5	20.98	45	Ontario	Storage & Organization	0.61
\N	2088	O'Sullivan 2-Shelf Heavy-Duty Bookcases	Anthony Witt	14695	-1609.92	48.58	54.11	Ontario	Bookcases	0.69
\N	2089	Self-Adhesive Address Labels for Typewriters by Universal	David Smith	14823	39.98	7.31	0.49	Ontario	Labels	0.38
\N	2090	Turquoise Lead Holder with Pocket Clip	David Smith	14823	10.56	6.7	1.56	Ontario	Pens & Art Supplies	0.52
\N	2091	O'Sullivan 3-Shelf Heavy-Duty Bookcases	Ted Trevino	15014	-203.9	58.14	36.61	Ontario	Bookcases	0.61
\N	2092	Staples Gold Paper Clips	Naresj Patel	15972	-3.86	2.98	1.58	Ontario	Rubber Bands	0.39
\N	2093	Advantus Push Pins, Aluminum Head	Naresj Patel	15972	-10.24	5.81	3.37	Ontario	Rubber Bands	0.54
\N	2094	Canon PC940 Copier	Ruben Ausman	16065	1200.21	449.99	49	Ontario	Copiers and Fax	0.38
\N	2095	EcoTones® Memo Sheets	Ruben Ausman	16065	8.07	4	1.3	Ontario	Paper	0.37
\N	2096	Avery 474	Roy French	16096	18.21	2.88	0.99	Ontario	Labels	0.36
\N	2097	Belkin 6 Outlet Metallic Surge Strip	Larry Hughes	16160	-53.18	10.89	4.5	Ontario	Appliances	0.59
\N	2098	Hon Pagoda™ Stacking Chairs	Magdelene Morse	16196	5034.15	320.98	24.49	Ontario	Chairs & Chairmats	0.55
\N	2099	StarTAC 6500	Magdelene Morse	16196	671.95	125.99	8.8	Ontario	Telephones and Communication	0.59
\N	2100	Howard Miller Distant Time Traveler Alarm Clock	Gary Hansen	16291	-27.79	27.42	19.46	Ontario	Office Furnishings	0.44
\N	2101	Avery® Durable Slant Ring Binders With Label Holder	Alan Hwang	16519	-30.27	4.18	2.99	Ontario	Binders and Binder Accessories	0.37
\N	2102	Newell 340	Alan Hwang	16519	19.87	2.88	0.7	Ontario	Pens & Art Supplies	0.56
\N	2103	Tensor Computer Mounted Lamp	Darren Budd	16548	-59.12	3.28	3.97	Ontario	Office Furnishings	0.58
\N	2104	Eldon Regeneration Recycled Desk Accessories, Smoke	Nancy Lomonaco	16613	-81.96	1.74	4.08	Ontario	Office Furnishings	0.53
\N	2105	Eldon Radial Chair Mat for Low to Medium Pile Carpets	Dan Lawera	16771	339.17	39.98	9.2	Ontario	Office Furnishings	0.65
\N	2106	Xerox 1882	Ed Ludwig	16804	752.87	55.98	13.88	Ontario	Paper	0.36
\N	2107	Xerox 1899	Ed Ludwig	16804	-46.43	5.78	4.96	Ontario	Paper	0.36
\N	2108	Belkin F9M820V08 8 Outlet Surge	Tamara Dahlen	17024	426.44	42.98	4.62	Ontario	Appliances	0.56
\N	2109	Newell 340	Ivan Liston	17061	10.01	2.88	0.7	Ontario	Pens & Art Supplies	0.56
\N	2110	Eldon Shelf Savers™ Cubes and Bins	Dave Hallsten	17152	-259.02	6.98	9.69	Ontario	Storage & Organization	0.83
\N	2111	Okidata ML591 Wide Format Dot Matrix Printer	Bill Stewart	17187	-1890.33	810.98	16.06	Ontario	Office Machines	0.56
\N	2112	Xerox 1917	Ivan Liston	17252	1006.72	48.91	5.97	Ontario	Paper	0.38
\N	2113	Hon 94000 Series Round Tables	Ivan Liston	17252	229.22	296.18	54.12	Ontario	Tables	0.76
\N	2114	Xerox 1959	Nancy Lomonaco	17312	-116.37	6.68	7.3	Ontario	Paper	0.37
\N	2115	i2000	Nancy Lomonaco	17312	1432.86	125.99	2.5	Ontario	Telephones and Communication	0.6
\N	2116	Prang Drawing Pencil Set	Erin Creighton	17377	-4.86	2.78	1.2	Ontario	Pens & Art Supplies	0.58
\N	2117	Global Leather Task Chair, Black	Alan Hwang	17634	-197.88	89.99	42	Ontario	Chairs & Chairmats	0.66
\N	2118	Maxell Pro 80 Minute CD-R, 10/Pack	Erin Creighton	17668	296.06	17.48	1.99	Ontario	Computer Peripherals	0.45
\N	2119	Polycom VoiceStation 100	Erin Creighton	17668	2574.12	300.98	13.99	Ontario	Office Machines	0.39
\N	2120	Phone 918	Erin Creighton	17668	-69.78	205.99	5	Ontario	Telephones and Communication	0.59
\N	2121	Avery Self-Adhesive Photo Pockets for Polaroid Photos	Ed Ludwig	17735	-71.25	6.81	5.48	Ontario	Binders and Binder Accessories	0.37
\N	2122	Staples Bulldog Clip	Ed Ludwig	17735	32.47	3.78	0.71	Ontario	Rubber Bands	0.39
\N	2123	Companion Letter/Legal File, Black	Larry Hughes	17825	11.38	37.76	12.9	Ontario	Storage & Organization	0.57
\N	2124	Snap-A-Way® Black Print Carbonless Ruled Speed Letter, Triplicate	Kelly Lampkin	17956	711.74	37.94	5.08	Ontario	Paper	0.38
\N	2125	Fellowes Recycled Storage Drawers	Kelly Lampkin	17956	73.45	111.03	8.64	Ontario	Storage & Organization	0.78
\N	2126	Economy Binders	George Ashbrook	17986	-15.09	2.08	1.49	Ontario	Binders and Binder Accessories	0.36
\N	2127	Wirebound Four 2-3/4 x 5 Forms per Page, 400 Sets per Book	Henry MacAllister	18112	22.8	6.45	1.34	Ontario	Paper	0.36
\N	2128	Hoover Portapower™ Portable Vacuum	Naresj Patel	18178	-1987.49	4.48	49	Ontario	Appliances	0.6
\N	2129	Executive Impressions 12" Wall Clock	Naresj Patel	18178	49.85	17.67	8.99	Ontario	Office Furnishings	0.47
\N	2130	U.S. Robotics 56K Internet Call Modem	Anna Haberlin	18182	1049.45	99.99	19.99	Ontario	Computer Peripherals	0.5
\N	2131	Eldon Cleatmat® Chair Mats for Medium Pile Carpets	Anna Haberlin	18182	-1363.12	55.5	52.2	Ontario	Office Furnishings	0.72
\N	2132	Fellowes Bases and Tops For Staxonsteel®/High-Stak® Systems	Anna Haberlin	18182	-18.45	33.29	8.74	Ontario	Storage & Organization	0.61
\N	2133	Premium Transparent Presentation Covers by GBC	George Ashbrook	18405	60.27	20.98	8.83	Ontario	Binders and Binder Accessories	0.37
\N	2134	Keytronic French Keyboard	George Ashbrook	18405	-263.09	73.98	14.52	Ontario	Computer Peripherals	0.65
\N	2135	Global Stack Chair without Arms, Black	Jeremy Ellison	18531	-250.55	25.98	14.36	Ontario	Chairs & Chairmats	0.6
\N	2136	Eldon Jumbo ProFile™ Portable File Boxes Graphite/Black	Larry Hughes	18533	-60.73	15.31	8.78	Ontario	Storage & Organization	0.57
\N	2137	Bell Sonecor JB700 Caller ID	Larry Hughes	18533	-28.44	7.99	5.03	Ontario	Telephones and Communication	0.6
\N	2138	Global Deluxe Office Fabric Chairs	Erin Creighton	18661	-351.3	95.98	58.2	Ontario	Chairs & Chairmats	0.58
\N	2139	Riverside Furniture Stanwyck Manor Table Series	Erin Creighton	18661	-139.27	286.85	61.76	Ontario	Tables	0.78
\N	2140	Accessory28	Jonathan Howell	18723	-232.8	55.99	2.5	Ontario	Telephones and Communication	0.83
\N	2141	SAFCO Folding Chair Trolley	Erin Creighton	18753	1031.32	128.24	12.65	Ontario	Chairs & Chairmats	\N
\N	2200	Fiskars® Softgrip Scissors	Edward Nazzal	24546	-7.78	10.98	3.37	Ontario	Scissors, Rulers and Trimmers	0.57
\N	2142	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Erin Creighton	18753	788.79	160.98	30	Ontario	Chairs & Chairmats	0.62
\N	2143	Eldon® 400 Class™ Desk Accessories, Black Carbon	Linda Cazamias	19204	-80.75	8.75	8.54	Ontario	Office Furnishings	0.43
\N	2144	Xerox 1908	Linda Cazamias	19204	829.73	55.98	4.86	Ontario	Paper	0.36
\N	2145	Accessory21	Darren Powers	19394	75.21	20.99	0.99	Ontario	Telephones and Communication	0.37
\N	2146	StarTAC 6500	Darren Powers	19394	-452.39	125.99	8.8	Ontario	Telephones and Communication	0.59
\N	2147	Avery Poly Binder Pockets	Edward Nazzal	19653	-129.63	3.58	5.47	Ontario	Binders and Binder Accessories	0.37
\N	2148	Binder Clips by OIC	George Ashbrook	19687	3.86	1.48	0.7	Ontario	Rubber Bands	0.37
\N	2149	600 Series Non-Flip	George Ashbrook	19687	25.53	45.99	4.99	Ontario	Telephones and Communication	0.57
\N	2150	7160	Nat Carroll	19716	-458.74	140.99	4.2	Ontario	Telephones and Communication	0.59
\N	2151	Assorted Color Push Pins	Erin Ashbrook	19782	-0.85	1.81	0.75	Ontario	Rubber Bands	0.52
\N	2152	Microsoft Internet Keyboard	James Lanier	20134	-94.59	20.97	6.5	Ontario	Computer Peripherals	0.78
\N	2153	Xerox 210	James Lanier	20134	-190.57	6.48	7.37	Ontario	Paper	0.37
\N	2154	Martin-Yale Premier Letter Opener	Anna Haberlin	20259	-123.07	12.88	4.59	Ontario	Scissors, Rulers and Trimmers	0.82
\N	2155	GBC Wire Binding Strips	Duane Huffman	20261	67.11	31.74	12.62	Ontario	Binders and Binder Accessories	0.37
\N	2156	Telephone Message Books with Fax/Mobile Section, 5 1/2" x 3 3/16"	Duane Huffman	20261	81.91	6.35	1.02	Ontario	Paper	0.39
\N	2157	Talkabout T8367	Duane Huffman	20261	168.24	65.99	8.99	Ontario	Telephones and Communication	0.56
\N	2158	Executive Impressions 13" Clairmont Wall Clock	Magdelene Morse	20453	152.79	19.23	6.15	Ontario	Office Furnishings	0.44
\N	2159	Accessory34	Magdelene Morse	20453	137.59	85.99	0.99	Ontario	Telephones and Communication	0.55
\N	2160	Keytronic 105-Key Spanish Keyboard	Arthur Wiediger	20614	326.25	73.98	12.14	Ontario	Computer Peripherals	0.67
\N	2161	Avery 491	Gary Mitchum	20709	-2.06	4.13	0.99	Ontario	Labels	0.39
\N	2162	Avery White Multi-Purpose Labels	Gary Mitchum	20709	2.98	4.98	0.49	Ontario	Labels	0.39
\N	2163	Logitech Access Keyboard	George Ashbrook	21025	-49.38	15.98	6.5	Ontario	Computer Peripherals	0.48
\N	2164	Peel & Seel® Recycled Catalog Envelopes, Brown	Gary Mitchum	21028	-4.17	11.58	6.97	Ontario	Envelopes	0.35
\N	2165	Wirebound Message Books, Four 2 3/4" x 5" Forms per Page, 600 Sets per Book	Matt Hagelstein	21125	2.12	9.27	4.39	Ontario	Paper	0.38
\N	2166	Xerox 1922	Andy Reiter	21382	-113.32	4.98	7.44	Ontario	Paper	0.36
\N	2167	Fellowes PB300 Plastic Comb Binding Machine	Magdelene Morse	21604	593.59	387.99	19.99	Ontario	Binders and Binder Accessories	0.38
\N	2168	Eldon ClusterMat Chair Mat with Cordless Antistatic Protection	Dave Hallsten	21824	-1036.92	90.98	56.2	Ontario	Office Furnishings	0.74
\N	2169	Recycled Interoffice Envelopes with Re-Use-A-Seal® Closure, 10 x 13	Gary Zandusky	21893	59.47	17.07	8.13	Ontario	Envelopes	0.38
\N	2170	G.E. Halogen Desk Lamp Bulbs	Candace McMahon	22054	57.55	6.98	2.83	Ontario	Office Furnishings	0.37
\N	2171	Staples Bulk Pack Metal Binder Clips	Alan Hwang	22181	84.1	6.08	1.82	Ontario	Rubber Bands	0.35
\N	2172	Adesso Programmable 142-Key Keyboard	Edward Nazzal	22272	14.85	152.48	4	Ontario	Computer Peripherals	0.79
\N	2173	Imation DVD-RAM discs	Edward Nazzal	22272	342.41	35.41	1.99	Ontario	Computer Peripherals	0.43
\N	2174	#10- 4 1/8" x 9 1/2" Recycled Envelopes	Candace McMahon	22373	-86.34	8.74	8.29	Ontario	Envelopes	0.38
\N	2175	Avery® Durable Plastic 1" Binders	Allen Golden	22434	-14.69	4.54	5.83	Ontario	Binders and Binder Accessories	0.36
\N	2176	Newell 337	Allen Golden	22434	-92.29	3.28	3.97	Ontario	Pens & Art Supplies	0.56
\N	2177	Fellowes Binding Cases	Erin Creighton	22849	2.73	11.7	5.63	Ontario	Binders and Binder Accessories	0.4
\N	2178	Prang Drawing Pencil Set	Erin Creighton	22849	10.59	2.78	1.34	Ontario	Pens & Art Supplies	0.45
\N	2179	Eldon Shelf Savers™ Cubes and Bins	Erin Creighton	22849	-219.92	6.98	9.69	Ontario	Storage & Organization	0.83
\N	2180	6185	Erin Creighton	22849	940.57	205.99	3	Ontario	Telephones and Communication	0.58
\N	2181	Project Tote Personal File	Melanie Page	22881	-120.48	14.03	9.37	Ontario	Storage & Organization	0.56
\N	2182	Space Solutions Commercial Steel Shelving	Mike Caudle	22950	-888.07	64.65	35	Ontario	Storage & Organization	0.8
\N	2183	GBC VeloBinder Electric Binding Machine	Erin Ashbrook	23008	323.32	120.98	9.07	Ontario	Binders and Binder Accessories	0.35
\N	2184	Adesso Programmable 142-Key Keyboard	Erin Ashbrook	23008	-522.78	152.48	6.5	Ontario	Computer Peripherals	0.74
\N	2185	Wirebound Message Forms, Four 2 3/4 x 5 Forms per Page, Pink Paper	Naresj Patel	23202	104.09	8.17	1.69	Ontario	Paper	0.38
\N	2186	Staples SlimLine Pencil Sharpener	Naresj Patel	23202	-39.27	11.97	5.81	Ontario	Pens & Art Supplies	0.6
\N	2187	Memorex 80 Minute CD-R, 30/Pack	Erin Ashbrook	23426	352.64	22.98	1.99	Ontario	Computer Peripherals	0.46
\N	2188	Letter Slitter	Erin Ashbrook	23426	-23.17	2.52	1.92	Ontario	Scissors, Rulers and Trimmers	0.82
\N	2189	688	Arthur Wiediger	23649	687.41	195.99	4.2	Ontario	Telephones and Communication	0.6
\N	2190	M3682	Arthur Wiediger	23649	1222.14	125.99	8.08	Ontario	Telephones and Communication	0.57
\N	2191	Tennsco Double-Tier Lockers	Naresj Patel	23748	755.95	225.02	28.66	Ontario	Storage & Organization	0.72
\N	2192	2160i	Darren Budd	23847	-396.17	200.99	4.2	Ontario	Telephones and Communication	0.59
\N	2193	Staples 6 Outlet Surge	Cynthia Arntzen	23971	-16.92	11.97	4.98	Ontario	Appliances	0.58
\N	2194	Premier Elliptical Ring Binder, Black	Ed Ludwig	24135	111.59	30.44	1.49	Ontario	Binders and Binder Accessories	0.37
\N	2195	Xerox 1971	Nat Carroll	24196	-8.88	4.28	5.17	Ontario	Paper	0.4
\N	2196	Trav-L-File Heavy-Duty Shuttle II, Black	Nat Carroll	24196	-5.41	43.57	16.36	Ontario	Storage & Organization	0.55
\N	2197	Fellowes Smart Design 104-Key Enhanced Keyboard, PS/2 Adapter, Platinum	David Smith	24197	246.54	55.94	6.55	Ontario	Computer Peripherals	0.68
\N	2198	Accessory29	David Smith	24197	-110.4	20.99	1.25	Ontario	Telephones and Communication	0.83
\N	2199	Pressboard Data Binder, Crimson, 12" X 8 1/2"	Duane Huffman	24519	-60.72	5.34	5.63	Ontario	Binders and Binder Accessories	0.39
\N	2201	Honeywell Enviracaire Portable HEPA Air Cleaner for 17' x 22' Room	Edward Nazzal	24579	5183.04	300.65	24.49	Ontario	Appliances	0.52
\N	2202	Staples 6 Outlet Surge	Edward Nazzal	24579	-33.34	11.97	4.98	Ontario	Appliances	0.58
\N	2203	Presstex Flexible Ring Binders	George Ashbrook	24581	4.08	4.55	1.49	Ontario	Binders and Binder Accessories	0.35
\N	2204	Xerox 1922	Jonathan Howell	24710	-15.6	4.98	7.44	Ontario	Paper	0.36
\N	2205	Fellowes EZ Multi-Media Keyboard	Cynthia Arntzen	24960	-17.08	34.98	7.53	Ontario	Computer Peripherals	0.76
\N	2206	Snap-A-Way® Black Print Carbonless Ruled Speed Letter, Triplicate	Cynthia Arntzen	24960	639.66	37.94	5.08	Ontario	Paper	0.38
\N	2207	Xerox 229	Cynthia Arntzen	24960	-35.98	6.48	5.87	Ontario	Paper	0.37
\N	2208	2160i	Cynthia Arntzen	24960	1366.57	200.99	4.2	Ontario	Telephones and Communication	0.59
\N	2209	Xerox 1885	Noah Childs	25061	344.95	48.04	7.23	Ontario	Paper	0.37
\N	2210	Blue String-Tie & Button Interoffice Envelopes, 10 x 13	Brian Stugart	25095	148.3	39.98	9.83	Ontario	Envelopes	0.4
\N	2211	Hewlett-Packard Deskjet 5550 Color Inkjet Printer	Brian Stugart	25095	-167.83	115.99	56.14	Ontario	Office Machines	0.4
\N	2212	GBC Standard Plastic Binding Systems Combs	Christine Phan	25254	-29.36	8.85	5.6	Ontario	Binders and Binder Accessories	0.36
\N	2213	Black Print Carbonless 8 1/2" x 8 1/4" Rapid Memo Book	Matt Hagelstein	25542	-18.66	7.28	4.23	Ontario	Paper	0.39
\N	2214	Xerox 1881	Frank Carlisle	25569	-14.03	12.28	6.47	Ontario	Paper	0.38
\N	2215	1726 Digital Answering Machine	George Bell	25863	-10.85	20.99	4.81	Ontario	Telephones and Communication	0.58
\N	2216	GBC Durable Plastic Covers	Candace McMahon	25895	-93.43	19.35	12.79	Ontario	Binders and Binder Accessories	0.39
\N	2217	#10- 4 1/8" x 9 1/2" Recycled Envelopes	Edward Nazzal	26050	-163.13	8.74	8.29	Ontario	Envelopes	0.38
\N	2218	Acco Pressboard Covers with Storage Hooks, 14 7/8" x 11", Light Blue	George Bell	26145	-51.2	4.91	5.68	Ontario	Binders and Binder Accessories	0.36
\N	2219	Eldon® Expressions™ Wood and Plastic Desk Accessories, Oak	George Bell	26145	-362.11	9.98	12.52	Ontario	Office Furnishings	0.57
\N	2220	Seth Thomas 14" Putty-Colored Wall Clock	George Bell	26145	153.5	29.34	7.87	Ontario	Office Furnishings	0.54
\N	2221	Accessory23	Edward Nazzal	26279	-33.31	35.99	1.25	Ontario	Telephones and Communication	0.36
\N	2222	Storex DuraTech Recycled Plastic Frosted Binders	Edward Becker	26406	-134.3	4.24	5.41	Ontario	Binders and Binder Accessories	0.35
\N	2223	Ibico Presentation Index for Binding Systems	Candace McMahon	26535	-103.21	3.98	5.26	Ontario	Binders and Binder Accessories	0.38
\N	2224	T193	Ruben Ausman	26661	390.86	65.99	4.99	Ontario	Telephones and Communication	0.57
\N	2225	Advantus Employee of the Month Certificate Frame, 11 x 13-1/2	Naresj Patel	26855	230.02	30.93	3.92	Ontario	Office Furnishings	0.44
\N	2226	Canon PC1080F Personal Copier	Patrick Bzostek	27047	3128.69	599.99	24.49	Ontario	Copiers and Fax	0.5
\N	2227	Xerox 1927	Patrick Bzostek	27047	-161.57	4.28	6.72	Ontario	Paper	0.4
\N	2228	Canon MP100DHII Printing Calculator	Frank Carlisle	27077	321.25	140.99	13.99	Ontario	Office Machines	0.37
\N	2229	Xerox 191	Alan Hwang	27236	84.3	19.98	5.86	Ontario	Paper	0.38
\N	2230	80 Minute CD-R Spindle, 100/Pack - Staples	Darren Budd	27589	221.6	39.48	1.99	Ontario	Computer Peripherals	0.54
\N	2231	Executive Impressions 12" Wall Clock	Darren Budd	27589	69.97	17.67	8.99	Ontario	Office Furnishings	0.47
\N	2232	Global Adaptabilities™ Conference Tables	Darren Budd	27589	-18.64	1.88	1.49	Ontario	Tables	0.66
\N	2233	Staples Copy Paper (20Lb. and 84 Bright)	Dave Hallsten	27681	-18.31	4.98	4.7	Ontario	Paper	0.38
\N	2234	Col-Erase® Pencils with Erasers	Dave Hallsten	27681	33.88	6.08	1.17	Ontario	Pens & Art Supplies	0.56
\N	2235	Global Ergonomic Managers Chair	Dan Lawera	28033	337.29	180.98	26.2	Ontario	Chairs & Chairmats	0.59
\N	2236	Hon Multipurpose Stacking Arm Chairs	Dan Lawera	28033	297.79	216.6	64.2	Ontario	Chairs & Chairmats	0.59
\N	2237	3.5" IBM Formatted Diskettes, DS/HD	Dan Lawera	28033	-57.11	6.6	4.07	Ontario	Computer Peripherals	0.66
\N	2238	Staples 4 Outlet Surge Protector	Edward Nazzal	28324	-40.72	8.67	3.5	Ontario	Appliances	0.58
\N	2239	Hoover® Commercial Lightweight Upright Vacuum	Bill Stewart	28805	-616.81	3.48	49	Ontario	Appliances	0.59
\N	2240	Avery Hanging File Binders	Bill Stewart	28805	-1.99	5.98	1.49	Ontario	Binders and Binder Accessories	0.39
\N	2241	Acme® Box Cutter Scissors	Bill Stewart	28805	-25.88	10.23	4.68	Ontario	Scissors, Rulers and Trimmers	0.59
\N	2242	Eureka Disposable Bags for Sanitaire® Vibra Groomer I® Upright Vac	Ed Ludwig	28897	-180.26	4.06	6.89	Ontario	Appliances	0.6
\N	2243	Tyvek Interoffice Envelopes, 9 1/2" x 12 1/2", 100/Box	Ed Ludwig	28897	151.24	60.98	19.99	Ontario	Envelopes	0.38
\N	2244	Executive Impressions 8-1/2" Career Panel/Partition Cubicle Clock	Gary Mitchum	28932	33.47	10.4	5.4	Ontario	Office Furnishings	0.51
\N	2245	Dixon My First Ticonderoga Pencil, #2	Gary Mitchum	28932	-12.59	5.85	2.27	Ontario	Pens & Art Supplies	0.56
\N	2246	SANFORD Major Accent™ Highlighters	Nat Carroll	29219	24.59	7.08	2.35	Ontario	Pens & Art Supplies	0.47
\N	2247	Canon BP1200DH 12-Digit Bubble Jet Printing Calculator	Linda Cazamias	29410	1929.58	120.97	7.11	Ontario	Office Machines	0.36
\N	2248	688	Linda Cazamias	29410	1585.5	195.99	4.2	Ontario	Telephones and Communication	0.6
\N	2249	Hoover Replacement Belt for Commercial Guardsman Heavy-Duty Upright Vacuum	Naresj Patel	29411	-112.54	2.22	5	Ontario	Appliances	0.55
\N	2250	#10 White Business Envelopes,4 1/8 x 9 1/2	Naresj Patel	29411	268.53	15.67	1.39	Ontario	Envelopes	0.38
\N	2251	Hewlett-Packard Deskjet 1220Cse Color Inkjet Printer	Naresj Patel	29411	7251.92	400.97	48.26	Ontario	Office Machines	0.36
\N	2252	TI 36X Solar Scientific Calculator	Naresj Patel	29411	294.43	23.99	6.3	Ontario	Office Machines	0.38
\N	2253	Ultra Door Push Plate	Gary Zandusky	29475	-29.62	4.91	3.05	Ontario	Office Furnishings	0.52
\N	2254	Riverside Palais Royal Lawyers Bookcase, Royale Cherry Finish	Gary Zandusky	29475	-1128.66	880.98	44.55	Ontario	Bookcases	0.62
\N	2255	Belkin 6 Outlet Metallic Surge Strip	Joni Sundaresam	29537	-30.97	10.89	4.5	Ontario	Appliances	0.59
\N	2256	Hunt Boston® Vacuum Mount KS Pencil Sharpener	Duane Huffman	29671	221.63	34.99	7.73	Ontario	Pens & Art Supplies	0.59
\N	2257	Rush Hierlooms Collection Rich Wood Bookcases	Theresa Coyne	29895	474.89	160.98	35.02	Ontario	Bookcases	0.72
\N	2258	Wilson Jones Easy Flow II™ Sheet Lifters	George Bell	30308	-59.18	1.8	4.79	Ontario	Binders and Binder Accessories	0.37
\N	2259	Avery Binder Labels	Dave Hallsten	30436	-152.13	3.89	7.01	Ontario	Binders and Binder Accessories	0.37
\N	2260	Newell 327	Cynthia Arntzen	30820	-6.85	2.21	1.12	Ontario	Pens & Art Supplies	0.58
\N	2261	T18	Erin Creighton	31046	1144.63	110.99	2.5	Ontario	Telephones and Communication	0.57
\N	2262	Acme® Design Stainless Steel Bent Scissors	Erin Creighton	31046	-58.81	6.84	4.42	Ontario	Scissors, Rulers and Trimmers	0.58
\N	2263	Avery 510	Duane Huffman	31301	43.77	3.75	0.5	Ontario	Labels	0.37
\N	2264	Cardinal Slant-D® Ring Binder, Heavy Gauge Vinyl	Gary Hansen	31495	39.5	8.69	2.99	Ontario	Binders and Binder Accessories	0.39
\N	2265	Multi-Use Personal File Cart and Caster Set, Three Stacking Bins	Gary Hansen	31495	212.2	34.76	8.22	Ontario	Storage & Organization	0.57
\N	2266	Sony MFD2HD Formatted Diskettes, 10/Pack	Joni Sundaresam	31523	-44.86	6.48	2.74	Ontario	Computer Peripherals	0.71
\N	2267	#10- 4 1/8" x 9 1/2" Recycled Envelopes	Joni Sundaresam	31523	-58.76	8.74	8.29	Ontario	Envelopes	0.38
\N	2268	Verbatim DVD-R, 3.95GB, SR, Mitsubishi Branded, Jewel	Alan Hwang	31552	70.48	22.24	1.99	Ontario	Computer Peripherals	0.43
\N	2269	Verbatim DVD-RAM, 5.2GB, Rewritable, Type 1, DS	Alan Hwang	31552	175.82	29.89	1.99	Ontario	Computer Peripherals	0.5
\N	2270	Westinghouse Clip-On Gooseneck Lamps	Duane Huffman	31877	-211.54	8.37	10.16	Ontario	Office Furnishings	0.59
\N	2271	Avery Printable Repositionable Plastic Tabs	Edward Becker	32037	-63.81	8.6	6.19	Ontario	Binders and Binder Accessories	0.38
\N	2272	Canon Imageclass D680 Copier / Fax	Edward Becker	32037	325.29	699.99	24.49	Ontario	Copiers and Fax	0.54
\N	2273	Staples Bulldog Clip	David Smith	32131	44.8	3.78	0.71	Ontario	Rubber Bands	0.39
\N	2274	IBM Active Response Keyboard, Black	Magdelene Morse	32135	160.68	39.98	7.12	Ontario	Computer Peripherals	0.67
\N	2275	TI 30X Scientific Calculator	Magdelene Morse	32135	-21.82	11.99	5.99	Ontario	Office Machines	0.36
\N	2276	Peel & Seel® Recycled Catalog Envelopes, Brown	Michelle Huthwaite	32195	-14.03	11.58	6.97	Ontario	Envelopes	0.35
\N	2277	Eldon Radial Chair Mat for Low to Medium Pile Carpets	David Philippe	32230	215.11	39.98	9.2	Ontario	Office Furnishings	0.65
\N	2278	Avery Premier Heavy-Duty Binder with Round Locking Rings	Nat Carroll	32451	163.63	14.28	2.99	Ontario	Binders and Binder Accessories	0.39
\N	2279	Memorex 4.7GB DVD+RW, 3/Pack	Darren Budd	32642	724.14	28.48	1.99	Ontario	Computer Peripherals	0.4
\N	2280	XtraLife® ClearVue™ Slant-D® Ring Binders by Cardinal	James Lanier	32803	-10.33	7.84	4.71	Ontario	Binders and Binder Accessories	0.35
\N	2281	Ampad #10 Peel & Seel® Holiday Envelopes	James Lanier	32803	-4.36	4.48	2.5	Ontario	Envelopes	0.37
\N	2282	8890	Noah Childs	32834	573.06	115.99	5.92	Ontario	Telephones and Communication	0.58
\N	2283	Hon Multipurpose Stacking Arm Chairs	Duane Huffman	33219	764.95	216.6	64.2	Ontario	Chairs & Chairmats	0.59
\N	2284	Avery 503	Duane Huffman	33477	113.63	10.35	0.99	Ontario	Labels	0.37
\N	2285	Letter Size Cart	Dan Lawera	34082	350.62	142.86	19.99	Ontario	Storage & Organization	0.56
\N	2286	Staples® General Use 3-Ring Binders	Dan Lawera	34082	-10.25	1.88	1.49	Ontario	Binders and Binder Accessories	0.37
\N	2287	Boston 1730 StandUp Electric Pencil Sharpener	Dan Lawera	34082	-34.59	21.38	8.99	Ontario	Pens & Art Supplies	0.59
\N	2288	Peel-Off® China Markers	Alan Hwang	34211	36.23	9.93	1.09	Ontario	Pens & Art Supplies	0.43
\N	2289	Imation 3.5" Unformatted DS/HD Diskettes, 10/Box	Duane Huffman	34244	-89.56	7.37	5.53	Ontario	Computer Peripherals	0.69
\N	2290	Memorex 4.7GB DVD-RAM, 3/Pack	Duane Huffman	34244	-62.77	31.78	1.99	Ontario	Computer Peripherals	0.42
\N	2291	O'Sullivan 5-Shelf Heavy-Duty Bookcases	Alan Hwang	34658	-926.33	81.94	55.81	Ontario	Bookcases	0.6
\N	2292	Xerox 193	Alan Hwang	34788	-10.7	5.98	5.15	Ontario	Paper	0.36
\N	2293	Global Ergonomic Managers Chair	Amy Cox	34918	273.27	180.98	26.2	Ontario	Chairs & Chairmats	0.59
\N	2294	Master Caster Door Stop, Large Neon Orange	Amy Cox	34918	-60.61	7.28	7.98	Ontario	Office Furnishings	0.42
\N	2295	Bush Mission Pointe Library	Darren Budd	35079	-30.69	4.98	4.95	Ontario	Bookcases	0.65
\N	2296	Hon 4060 Series Tables	Darren Budd	35079	559.59	60.98	19.99	Ontario	Tables	0.63
\N	2297	GBC DocuBind TL300 Electric Binding System	Mike Caudle	35110	5065.51	896.99	19.99	Ontario	Binders and Binder Accessories	0.38
\N	2298	Verbatim DVD-RAM, 5.2GB, Rewritable, Type 1, DS	Mike Caudle	35110	485.95	29.89	1.99	Ontario	Computer Peripherals	0.5
\N	2299	O'Sullivan Elevations Bookcase, Cherry Finish	Darren Budd	35554	-614.37	130.98	54.74	Ontario	Bookcases	0.69
\N	2300	Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back	James Lanier	35555	1902.99	243.98	43.32	Ontario	Chairs & Chairmats	0.55
\N	2301	Maxell 3.5" DS/HD IBM-Formatted Diskettes, 10/Pack	James Lanier	35555	-70.31	4.89	4.93	Ontario	Computer Peripherals	0.66
\N	2302	Rediform S.O.S. Phone Message Books	James Lanier	35555	-4.72	4.98	0.8	Ontario	Paper	0.36
\N	2303	Xerox 199	Erin Creighton	35877	-100.61	4.28	5.68	Ontario	Paper	0.4
\N	2304	Telephone Message Books with Fax/Mobile Section, 4 1/4" x 6"	Cari MacIntyre	35878	-7.71	3.6	2.2	Ontario	Paper	0.39
\N	2305	Zebra Zazzle Fluorescent Highlighters	Allen Golden	36448	0.43	6.08	0.91	Ontario	Pens & Art Supplies	0.51
\N	2306	Boston 16801 Nautilus™ Battery Pencil Sharpener	Allen Golden	36448	105.37	22.01	5.53	Ontario	Pens & Art Supplies	0.59
\N	2307	Avery Flip-Chart Easel Binder, Black	Eudokia Martin	36452	-107.51	22.38	15.1	Ontario	Binders and Binder Accessories	0.38
\N	2308	G.E. Halogen Desk Lamp Bulbs	Eudokia Martin	36452	46.01	6.98	2.83	Ontario	Office Furnishings	0.37
\N	2309	StarTAC Series	Cari MacIntyre	36484	740.48	65.99	3.9	Ontario	Telephones and Communication	0.55
\N	2310	9-3/4 Diameter Round Wall Clock	Ruben Ausman	36643	-36.77	13.79	8.78	Ontario	Office Furnishings	0.43
\N	2311	Fellowes Bases and Tops For Staxonsteel®/High-Stak® Systems	Ruben Ausman	36643	87.03	33.29	8.74	Ontario	Storage & Organization	0.61
\N	2312	Talkabout T8367	Anna Haberlin	36679	124.83	65.99	8.99	Ontario	Telephones and Communication	0.56
\N	2313	Adams Write n' Stick Phone Message Book, 11" X 5 1/4", 200 Messages	Fred Hopkins	36741	34.48	5.68	1.46	Ontario	Paper	0.39
\N	2314	Accessory36	Fred Hopkins	36741	-254.36	55.99	5	Ontario	Telephones and Communication	0.83
\N	2315	24 Capacity Maxi Data Binder Racks, Pearl	Brian Stugart	36866	1462.42	210.55	9.99	Ontario	Storage & Organization	0.6
\N	2316	Belkin 8 Outlet SurgeMaster II Gold Surge Protector with Phone Protection	Amy Cox	36929	1123.79	80.98	4.5	Ontario	Appliances	0.59
\N	2317	Fellowes Bases and Tops For Staxonsteel®/High-Stak® Systems	Amy Cox	36929	185.37	33.29	8.74	Ontario	Storage & Organization	0.61
\N	2318	Sharp 1540cs Digital Laser Copier	Cari MacIntyre	36999	4963.89	549.99	49	Ontario	Copiers and Fax	0.35
\N	2319	2160	Cari MacIntyre	36999	-479.08	115.99	5.99	Ontario	Telephones and Communication	0.57
\N	2320	Premium Transparent Presentation Covers by GBC	Eudokia Martin	37216	74.01	20.98	8.83	Ontario	Binders and Binder Accessories	0.37
\N	2321	DAX Solid Wood Frames	Michelle Huthwaite	37314	5.5	9.77	6.02	Ontario	Office Furnishings	0.48
\N	2322	Howard Miller 12-3/4 Diameter Accuwave DS ™ Wall Clock	Bill Stewart	37349	122.43	78.69	19.99	Ontario	Office Furnishings	0.43
\N	2323	Microsoft Internet Keyboard	Mike Caudle	37828	-57.09	20.97	4	Ontario	Computer Peripherals	0.77
\N	2324	Avery 508	Mike Caudle	37828	101.14	4.91	0.5	Ontario	Labels	0.36
\N	2325	Imation 3.5 IBM Diskettes, 10/Box	Andy Reiter	37920	-380.2	8.46	8.99	Ontario	Computer Peripherals	0.79
\N	2326	Imation Printable White 80 Minute CD-R Spindle, 50/Pack	Erin Ashbrook	38052	118.4	40.98	1.99	Ontario	Computer Peripherals	0.44
\N	2327	Staples Copy Paper (20Lb. and 84 Bright)	Jim Mitchum	38080	-56.35	4.98	4.7	Ontario	Paper	0.38
\N	2328	Staples® General Use 3-Ring Binders	Amy Cox	38145	-17.2	1.88	1.49	Ontario	Binders and Binder Accessories	0.37
\N	2329	Tenex B1-RE Series Chair Mats for Low Pile Carpets	Amy Cox	38145	190.6	45.98	4.8	Ontario	Office Furnishings	0.68
\N	2330	Bush Advantage Collection® Round Conference Table	Cynthia Arntzen	38437	199.25	212.6	52.2	Ontario	Tables	0.64
\N	2331	Newell 321	Cynthia Arntzen	38437	-21.4	3.28	2.31	Ontario	Pens & Art Supplies	0.56
\N	2332	Belkin 325VA UPS Surge Protector, 6'	Melanie Page	38503	1726.66	120.98	3.99	Ontario	Appliances	0.6
\N	2333	Accessory36	Melanie Page	38503	-222.82	55.99	5	Ontario	Telephones and Communication	0.83
\N	2334	Westinghouse Floor Lamp with Metal Mesh Shade, Black	Melanie Page	38503	-133.71	23.99	15.68	Ontario	Office Furnishings	0.62
\N	2335	Avery Trapezoid Ring Binder, 3" Capacity, Black, 1040 sheets	Dave Hallsten	38530	904.83	40.98	2.99	Ontario	Binders and Binder Accessories	0.36
\N	2336	Eureka Hand Vacuum, Bagless	Dave Hallsten	38530	-82.35	49.43	19.99	Ontario	Appliances	0.57
\N	2337	Economy Binders	Eugene Hildebrand	38726	-11.28	2.08	1.49	Ontario	Binders and Binder Accessories	0.36
\N	2338	Hoover Commercial Lightweight Upright Vacuum with E-Z Empty™ Dirt Cup	Nancy Lomonaco	39172	2574.36	232.58	19.99	Ontario	Appliances	0.59
\N	2339	Xerox 1920	Nancy Lomonaco	39172	-93.73	5.98	7.5	Ontario	Paper	0.4
\N	2340	Accessory1	Gary Zandusky	39269	107.51	35.99	2.5	Ontario	Telephones and Communication	0.36
\N	2341	Acme Kleencut® Forged Steel Scissors	Andy Yotov	39330	-71.96	5.74	5.3	Ontario	Scissors, Rulers and Trimmers	0.55
\N	2342	Verbatim DVD-RAM, 5.2GB, Rewritable, Type 1, DS	Cynthia Arntzen	39365	269.6	29.89	1.99	Ontario	Computer Peripherals	0.5
\N	2343	Logitech Internet Navigator Keyboard	Edward Becker	39430	-144.2	30.98	6.5	Ontario	Computer Peripherals	0.79
\N	2344	Tyvek ® Top-Opening Peel & Seel Envelopes, Plain White	Naresj Patel	39555	352.96	27.18	8.23	Ontario	Envelopes	0.38
\N	2345	Staples Plastic Wall Frames	Ed Ludwig	39749	26.24	7.96	4.95	Ontario	Office Furnishings	0.41
\N	2346	Panasonic KX-P1131 Dot Matrix Printer	Ed Ludwig	39749	3497.45	264.98	17.86	Ontario	Office Machines	0.58
\N	2347	12 Colored Short Pencils	Ed Ludwig	39749	-62.6	2.6	2.4	Ontario	Pens & Art Supplies	0.58
\N	2348	5185	Roy French	39815	841.73	115.99	8.99	Ontario	Telephones and Communication	0.58
\N	2349	Belkin 7 Outlet SurgeMaster Surge Protector with Phone Protection	Aimee Bixby	40001	457.03	39.48	3.99	Ontario	Appliances	0.56
\N	2350	Dot Matrix Printer Tape Reel Labels, White, 5000/Box	Jesus Ocampo	40386	1704	98.31	0.49	Ontario	Labels	0.36
\N	2351	White Dual Perf Computer Printout Paper, 2700 Sheets, 1 Part, Heavyweight, 20 lbs., 14 7/8 x 11	Naresj Patel	40647	267.1	40.99	19.99	Ontario	Paper	0.36
\N	2352	SAFCO Optional Arm Kit for Workspace® Cribbage Stacking Chair	Darren Budd	41120	100.5	26.64	5.3	Ontario	Chairs & Chairmats	\N
\N	2353	DAX Solid Wood Frames	Darren Budd	41120	9.53	3.08	0.99	Ontario	Office Furnishings	0.48
\N	2354	Eldon Regeneration Recycled Desk Accessories, Smoke	Darren Budd	41122	-76.88	1.74	4.08	Ontario	Office Furnishings	0.53
\N	2355	Newell 314	Edward Nazzal	41187	5.34	5.58	0.7	Ontario	Pens & Art Supplies	0.6
\N	2356	Xerox 1899	Edward Nazzal	41187	-42.45	5.78	4.96	Ontario	Paper	0.36
\N	2357	Carina Double Wide Media Storage Towers in Natural & Black	Eugene Hildebrand	41221	-218.77	80.98	35	Ontario	Storage & Organization	0.81
\N	2358	GBC Standard Therm-A-Bind Covers	Eileen Kiefer	41282	-21.9	24.92	12.98	Ontario	Binders and Binder Accessories	0.39
\N	2359	80 Minute CD-R Spindle, 100/Pack - Staples	Jonathan Howell	41312	140.22	39.48	1.99	Ontario	Computer Peripherals	0.54
\N	2360	Conquest™ 14 Commercial Heavy-Duty Upright Vacuum, Collection System, Accessory Kit	Brian Stugart	41318	161.72	56.96	13.22	Ontario	Appliances	0.56
\N	2361	Staples Pushpins	Magdelene Morse	41345	0.37	1.88	0.79	Ontario	Rubber Bands	0.5
\N	2362	C-Line Peel & Stick Add-On Filing Pockets, 8-3/4 x 5-1/8, 10/Pack	Edward Becker	41604	-48.22	6.37	5.19	Ontario	Binders and Binder Accessories	0.38
\N	2363	Eldon Executive Woodline II Cherry Finish Desk Accessories	Tamara Dahlen	41891	-1.95	40.89	18.98	Ontario	Office Furnishings	0.57
\N	2364	Angle-D Binders with Locking Rings, Label Holders	Eugene Hildebrand	42022	-170.18	7.3	7.72	Ontario	Binders and Binder Accessories	0.38
\N	2365	Advantus Map Pennant Flags and Round Head Tacks	Eugene Hildebrand	42022	-9.68	3.95	2	Ontario	Rubber Bands	0.53
\N	2366	Wilson Jones Impact Binders	Christine Phan	42081	-110.16	5.18	5.74	Ontario	Binders and Binder Accessories	0.36
\N	2367	White Business Envelopes with Contemporary Seam, Recycled White Business Envelopes	Christine Phan	42081	-5.05	10.94	1.39	Ontario	Envelopes	0.35
\N	2368	6120	Christine Phan	42081	183.24	65.99	8.8	Ontario	Telephones and Communication	0.58
\N	2369	Newell 339	Erin Smith	42086	-2.39	2.78	0.97	Ontario	Pens & Art Supplies	0.59
\N	2370	Micro Innovations Media Access Pro Keyboard	Ted Trevino	42246	234.03	77.51	4	Ontario	Computer Peripherals	0.76
\N	2371	*Staples* Highlighting Markers	Ted Trevino	42246	-0.5	4.84	0.71	Ontario	Pens & Art Supplies	0.52
\N	2372	Xerox 1994	Tamara Dahlen	42465	-32.7	6.48	5.74	Ontario	Paper	0.37
\N	2373	Xerox 1936	Eileen Kiefer	42657	254.58	19.98	5.97	Ontario	Paper	0.38
\N	2374	Wilson Jones 1" Hanging DublLock® Ring Binders	Ted Trevino	42820	-2.85	5.28	2.99	Ontario	Binders and Binder Accessories	0.37
\N	2375	Rediform Wirebound "Phone Memo" Message Book, 11 x 5-3/4	David Philippe	42848	-56.51	7.64	5.83	Ontario	Paper	0.36
\N	2376	Xerox 1891	James Lanier	43269	355	48.91	5.81	Ontario	Paper	0.38
\N	2377	GBC DocuBind P100 Manual Binding Machine	James Lanier	43269	1336.96	165.98	19.99	Ontario	Binders and Binder Accessories	0.4
\N	2378	Xerox 23	Anemone Ratner	43367	-12.19	6.48	5.14	Ontario	Paper	0.37
\N	2379	Acme® Elite Stainless Steel Scissors	Anemone Ratner	43367	1.72	8.34	2.64	Ontario	Scissors, Rulers and Trimmers	0.59
\N	2380	Space Solutions Commercial Steel Shelving	Anemone Ratner	43367	-468.64	64.65	35	Ontario	Storage & Organization	0.8
\N	2381	Newell 323	Cari MacIntyre	43399	-33.34	1.68	1.57	Ontario	Pens & Art Supplies	0.59
\N	2382	BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	Cari MacIntyre	43399	-201.28	218.75	69.64	Ontario	Tables	0.77
\N	2383	White GlueTop Scratch Pads	Cari MacIntyre	43399	31.94	15.04	1.97	Ontario	Paper	0.39
\N	2384	Holmes Odor Grabber	Melanie Page	43875	11.39	14.42	6.75	Ontario	Appliances	0.52
\N	2385	Global Airflow Leather Mesh Back Chair, Black	Melanie Page	43875	117.23	150.98	143.71	Ontario	Chairs & Chairmats	0.55
\N	2386	Canon P1-DHIII Palm Printing Calculator	Melanie Page	43875	27.64	17.98	8.51	Ontario	Office Machines	0.4
\N	2387	A1228	Melanie Page	43875	311.09	195.99	8.99	Ontario	Telephones and Communication	0.58
\N	2388	Timeport L7089	Melanie Page	43875	331.29	125.99	7.69	Ontario	Telephones and Communication	0.58
\N	2389	Bush Heritage Pine Collection 5-Shelf Bookcase, Albany Pine Finish, *Special Order	Cynthia Arntzen	44197	-229.79	140.98	53.48	Ontario	Bookcases	0.65
\N	2390	*Staples* Highlighting Markers	Erin Smith	44229	50.16	4.84	0.71	Ontario	Pens & Art Supplies	0.52
\N	2391	Pressboard Covers with Storage Hooks, 9 1/2" x 11", Light Blue	Chris Selesnick	44386	-75.13	4.91	4.97	Ontario	Binders and Binder Accessories	0.38
\N	2392	Memorex 4.7GB DVD+RW, 3/Pack	Chris Selesnick	44386	518.81	28.48	1.99	Ontario	Computer Peripherals	0.4
\N	2393	GE 48" Fluorescent Tube, Cool White Energy Saver, 34 Watts, 30/Box	Noel Staavos	44390	2033.5	99.23	8.99	Ontario	Office Furnishings	0.35
\N	2394	Accessory8	Dean Braden	44612	-147.72	85.99	1.25	Ontario	Telephones and Communication	0.39
\N	2395	Hoover Replacement Belt for Commercial Guardsman Heavy-Duty Upright Vacuum	George Bell	44614	-56.63	2.22	5	Ontario	Appliances	0.55
\N	2396	Micro Innovations Micro 3000 Keyboard, Black	George Bell	44614	-123.01	26.31	5.89	Ontario	Computer Peripherals	0.75
\N	2397	Staples® General Use 3-Ring Binders	Edward Becker	44615	-10.26	1.88	1.49	Ontario	Binders and Binder Accessories	0.37
\N	2398	Hoover Commercial Soft Guard Upright Vacuum And Disposable Filtration Bags	Lena Creighton	44864	-171.41	7.77	9.23	Ontario	Appliances	0.58
\N	2399	Geographics Note Cards, Blank, White, 8 1/2" x 11"	Joni Sundaresam	44900	-12.03	11.19	5.03	Ontario	Paper	0.37
\N	2400	Xerox 212	Tamara Chand	44960	-72.81	6.48	8.4	Ontario	Paper	0.37
\N	2401	Acme® Office Executive Series Stainless Steel Trimmers	Tamara Chand	44960	-82.54	8.57	6.14	Ontario	Scissors, Rulers and Trimmers	0.59
\N	2402	BASF Silver 74 Minute CD-R	Tamara Chand	44960	-23.69	1.7	1.99	Ontario	Computer Peripherals	0.51
\N	2403	Canon MP25DIII Desktop Whisper-Quiet Printing Calculator	Anthony Witt	44992	524.73	51.98	10.17	Ontario	Office Machines	0.37
\N	2404	BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	Anthony Witt	44992	-536.17	218.75	69.64	Ontario	Tables	0.72
\N	2405	Rush Hierlooms Collection Rich Wood Bookcases	Erin Smith	45125	-252.01	160.98	35.02	Ontario	Bookcases	0.72
\N	2406	5165	Erin Smith	45125	1193.11	175.99	4.99	Ontario	Telephones and Communication	0.59
\N	2407	Global Airflow Leather Mesh Back Chair, Black	George Ashbrook	45190	135.26	150.98	43.71	Ontario	Chairs & Chairmats	0.55
\N	2408	Euro Pro Shark Stick Mini Vacuum	George Ashbrook	45414	-563.86	60.98	49	Ontario	Appliances	0.59
\N	2409	Fellowes Superior 10 Outlet Split Surge Protector	Nat Carroll	45700	518.48	38.06	4.5	Ontario	Appliances	0.56
\N	2410	Hon Olson Stacker Stools	Duane Huffman	45824	1232.79	140.81	24.49	Ontario	Chairs & Chairmats	0.57
\N	2411	Bush Westfield Collection Bookcases, Fully Assembled	George Ashbrook	45991	-68.16	100.98	35.84	Ontario	Bookcases	0.62
\N	2412	Avery 506	George Ashbrook	45991	82.6	4.13	0.5	Ontario	Labels	0.39
\N	2413	Xerox Blank Computer Paper	Jonathan Howell	46307	175.97	19.98	5.77	Ontario	Paper	0.38
\N	2414	SAFCO Mobile Desk Side File, Wire Frame	Jonathan Howell	46307	283.14	42.76	6.22	Ontario	Storage & Organization	\N
\N	2415	Large Capacity Hanging Post Binders	David Philippe	46434	270.29	24.95	2.99	Ontario	Binders and Binder Accessories	0.39
\N	2416	Eldon Delta Triangular Chair Mat, 52" x 58", Clear	Matt Hagelstein	46466	71.31	37.93	13.99	Ontario	Office Furnishings	0.67
\N	2417	Tenex Carpeted, Granite-Look or Clear Contemporary Contour Shape Chair Mats	Edward Nazzal	46528	-865.98	70.71	37.58	Ontario	Office Furnishings	0.78
\N	2418	Xerox 1939	Edward Nazzal	46528	57.25	18.97	9.54	Ontario	Paper	0.37
\N	2419	Global Deluxe Office Fabric Chairs	Magdelene Morse	46626	-276.95	95.98	58.2	Ontario	Chairs & Chairmats	0.58
\N	2420	Hayes Optima 56K V.90 Internal Voice Modem	Eudokia Martin	46853	1489.8	256.99	11.25	Ontario	Computer Peripherals	0.51
\N	2421	Tenex B1-RE Series Chair Mats for Low Pile Carpets	Darren Budd	46855	-4.68	1.68	0.7	Ontario	Office Furnishings	0.68
\N	2422	Adesso Programmable 142-Key Keyboard	Jesus Ocampo	46919	174.61	152.48	6.5	Ontario	Computer Peripherals	0.74
\N	2423	Tuff Stuff™ Recycled Round Ring Binders	Allen Golden	46977	7.25	4.82	1.49	Ontario	Binders and Binder Accessories	0.36
\N	2424	2180	Allen Golden	46977	494.63	175.99	8.99	Ontario	Telephones and Communication	0.57
\N	2425	Binney & Smith Crayola® Metallic Colored Pencils, 8-Color Set	Cynthia Arntzen	47041	-7.08	4.63	1.93	Ontario	Pens & Art Supplies	0.52
\N	2426	Sensible Storage WireTech Storage Systems	Eileen Kiefer	47301	-231.95	70.98	35	Ontario	Storage & Organization	0.8
\N	2427	Balt Solid Wood Rectangular Table	Philip Brown	47714	-690.21	105.49	41.64	Ontario	Tables	0.75
\N	2428	Imation 3.5" DS/HD IBM Formatted Diskettes, 10/Pack	Darren Budd	48003	-106.54	5.98	4.38	Ontario	Computer Peripherals	0.75
\N	2429	Executive Impressions 14" Two-Color Numerals Wall Clock	Darren Budd	48003	-69.05	6.48	9.68	Ontario	Office Furnishings	0.44
\N	2430	6162m	Ruben Ausman	48195	850.54	115.99	2.5	Ontario	Telephones and Communication	0.57
\N	2431	Accessory41	Ruben Ausman	48195	296.87	35.99	5.99	Ontario	Telephones and Communication	0.38
\N	2432	iDENi80s	Ruben Ausman	48195	47.28	65.99	19.99	Ontario	Telephones and Communication	0.59
\N	2433	Canon MP41DH Printing Calculator	Eileen Kiefer	48357	619.71	150.98	13.99	Ontario	Office Machines	0.38
\N	2434	Avery 506	George Bell	48615	0.21	4.13	0.5	Ontario	Labels	0.39
\N	2435	C-Line Cubicle Keepers Polyproplyene Holder w/Velcro® Back, 8-1/2x11, 25/Bx	George Bell	48615	219.02	54.74	14.83	Ontario	Office Furnishings	0.54
\N	2436	Staples 4 Outlet Surge Protector	Matt Collister	48642	-13.72	8.67	3.5	Ontario	Appliances	0.58
\N	2437	Logitech Cordless Elite Duo	Matt Collister	48642	-122.09	100.98	7.18	Ontario	Computer Peripherals	0.4
\N	2438	Adams Phone Message Book, Professional, 400 Message Capacity, 5 3/6” x 11”	Cynthia Arntzen	48710	-1.73	6.98	1.6	Ontario	Paper	0.38
\N	2439	Belkin MediaBoard 104- Keyboard	Brian Stugart	49094	-25.98	27.48	4	Ontario	Computer Peripherals	0.75
\N	2440	HP Office Recycled Paper (20Lb. and 87 Bright)	Edward Becker	49125	-116.05	5.78	7.64	Ontario	Paper	0.36
\N	2441	Newell 342	Noah Childs	49216	-72.44	3.28	3.97	Ontario	Pens & Art Supplies	0.56
\N	2442	Westinghouse Floor Lamp with Metal Mesh Shade, Black	Darren Budd	49538	217.57	26.38	5.58	Ontario	Office Furnishings	0.62
\N	2443	Office Star - Professional Matrix Back Chair with 2-to-1 Synchro Tilt and Mesh Fabric Seat	Dave Hallsten	49730	-394.69	350.98	30	Ontario	Chairs & Chairmats	0.61
\N	2444	Storex DuraTech Recycled Plastic Frosted Binders	Edward Nazzal	49924	-155.53	4.24	5.41	Ontario	Binders and Binder Accessories	0.35
\N	2445	Eldon Pizzaz™ Desk Accessories	Edward Nazzal	49924	-35.96	2.23	4.57	Ontario	Office Furnishings	0.41
\N	2446	GBC DocuBind P50 Personal Binding Machine	Anemone Ratner	50306	564.07	63.98	11.55	Ontario	Binders and Binder Accessories	0.38
\N	2447	Staples 4 Outlet Surge Protector	Dan Lawera	50566	-37.43	8.67	3.5	Ontario	Appliances	0.58
\N	2448	Logitech Cordless Elite Duo	Nancy Lomonaco	50823	269.94	100.98	7.18	Ontario	Computer Peripherals	0.4
\N	2449	Cardinal Holdit Business Card Pockets	Dan Lawera	50854	-64.24	4.98	4.95	Ontario	Binders and Binder Accessories	0.37
\N	2450	Hewlett-Packard cp1700 [D, PS] Series Color Inkjet Printers	Dan Lawera	50854	1118.17	500.98	28.14	Ontario	Office Machines	0.38
\N	2451	Fiskars® Softgrip Scissors	Dan Lawera	50854	25.79	10.98	3.37	Ontario	Scissors, Rulers and Trimmers	0.57
\N	2452	EcoTones® Memo Sheets	Theresa Coyne	51109	26.21	4	1.3	Ontario	Paper	0.37
\N	2453	Avery 484	Lena Creighton	51395	32.5	2.88	0.5	Ontario	Labels	0.36
\N	2454	Xerox 1952	Lena Creighton	51395	-32.13	4.98	5.49	Ontario	Paper	0.38
\N	2455	Boston 1799 Powerhouse™ Electric Pencil Sharpener	David Philippe	51559	129.81	25.98	4.08	Ontario	Pens & Art Supplies	0.57
\N	2456	Carina Mini System Audio Rack, Model AR050B	Lena Creighton	51813	-469.84	110.98	35	Ontario	Storage & Organization	0.82
\N	2457	3.6 Cubic Foot Counter Height Office Refrigerator	James Lanier	51937	2816.21	294.62	42.52	Ontario	Appliances	0.57
\N	2458	Office Star - Professional Matrix Back Chair with 2-to-1 Synchro Tilt and Mesh Fabric Seat	Darren Budd	52098	220.07	39.06	10.55	Ontario	Chairs & Chairmats	0.61
\N	2459	Staples SlimLine Pencil Sharpener	Philip Brown	52102	-23.61	11.97	5.81	Ontario	Pens & Art Supplies	0.6
\N	2460	U.S. Robotics 56K Internet Call Modem	Jeremy Ellison	52135	863.57	99.99	19.99	Ontario	Computer Peripherals	0.5
\N	2461	Hon Metal Bookcases, Putty	Darren Budd	52162	-220.3	6.48	9.68	Ontario	Bookcases	0.56
\N	2462	Global Enterprise™ Series Seating Low-Back Swivel/Tilt Chairs	Darren Budd	52162	23.34	3.29	1.35	Ontario	Chairs & Chairmats	0.55
\N	2463	5170	Cari MacIntyre	52256	119.89	65.99	4.2	Ontario	Telephones and Communication	0.59
\N	2464	Snap-A-Way® Black Print Carbonless Speed Message, No Reply Area, Duplicate	Alan Hwang	52391	440.48	29.14	4.86	Ontario	Paper	0.38
\N	2465	Iris® 3-Drawer Stacking Bin, Black	Alan Hwang	52391	-309.43	20.89	11.52	Ontario	Storage & Organization	0.83
\N	2466	Situations Contoured Folding Chairs, 4/Set	Magdelene Morse	52642	-320.7	70.98	59.81	Ontario	Chairs & Chairmats	0.6
\N	2467	Adesso Programmable 142-Key Keyboard	Magdelene Morse	52642	-281.67	152.48	4	Ontario	Computer Peripherals	0.79
\N	2468	Xerox 1908	Magdelene Morse	52642	276.98	55.98	4.86	Ontario	Paper	0.36
\N	2469	Dixon My First Ticonderoga Pencil, #2	Alan Hwang	52645	-8.37	5.85	2.27	Ontario	Pens & Art Supplies	0.56
\N	2470	Tripp Lite Isotel 8 Ultra 8 Outlet Metal Surge	Alan Hwang	52645	97.36	70.97	3.5	Ontario	Appliances	0.59
\N	2471	Advantus Push Pins, Aluminum Head	Aimee Bixby	52711	-51.25	5.81	3.37	Ontario	Rubber Bands	0.54
\N	2472	Array® Memo Cubes	Lena Creighton	52896	2.76	5.18	2.04	Ontario	Paper	0.36
\N	2473	Bevis Round Bullnose 29" High Table Top	Lena Creighton	52896	-192.49	259.71	66.67	Ontario	Tables	0.65
\N	2474	Master Giant Foot® Doorstop, Safety Yellow	Eugene Hildebrand	52999	22.85	7.59	4	Ontario	Office Furnishings	0.42
\N	2475	Black Print Carbonless Snap-Off® Rapid Letter, 8 1/2" x 7"	Eugene Hildebrand	52999	98.86	9.11	2.15	Ontario	Paper	0.4
\N	2476	Xerox 1978	Eugene Hildebrand	52999	-21.19	5.78	5.67	Ontario	Paper	0.36
\N	2477	5165	Noel Staavos	53254	1640.3	175.99	4.99	Ontario	Telephones and Communication	0.59
\N	2478	Hon 4700 Series Mobuis™ Mid-Back Task Chairs with Adjustable Arms	Philip Brown	53281	1894.14	355.98	58.92	Ontario	Chairs & Chairmats	0.64
\N	2479	GBC DocuBind P100 Manual Binding Machine	Eudokia Martin	53285	163.8	165.98	19.99	Ontario	Binders and Binder Accessories	0.4
\N	2480	Hoover WindTunnel™ Plus Canister Vacuum	Edward Nazzal	53312	2464.75	363.25	19.99	Ontario	Appliances	0.57
\N	2481	Eldon Spacemaker® Box, Quick-Snap Lid, Clear	Edward Nazzal	53312	-173.36	3.34	7.49	Ontario	Pens & Art Supplies	0.54
\N	2482	Blue String-Tie & Button Interoffice Envelopes, 10 x 13	Erin Ashbrook	53637	61.27	39.98	9.83	Ontario	Envelopes	0.4
\N	2483	*Staples* Highlighting Markers	Tamara Chand	53698	13.38	4.84	0.71	Ontario	Pens & Art Supplies	0.52
\N	2484	Micro Innovations Micro Digital Wireless Keyboard and Mouse, Gray	Mike Caudle	54183	1097.25	82.99	5.5	Ontario	Computer Peripherals	0.44
\N	2485	Boston 16765 Mini Stand Up Battery Pencil Sharpener	Mike Caudle	54183	-52.25	11.66	8.99	Ontario	Pens & Art Supplies	0.59
\N	2486	Accessory37	Cari MacIntyre	54245	-114.91	20.99	2.5	Ontario	Telephones and Communication	0.81
\N	2487	Belkin 8 Outlet SurgeMaster II Gold Surge Protector	Alan Hwang	54339	1053.21	59.98	3.99	Ontario	Appliances	0.57
\N	2488	3390	Alan Hwang	54339	458.62	65.99	5.31	Ontario	Telephones and Communication	0.57
\N	2489	Avery Legal 4-Ring Binder	Dave Hallsten	54401	278.58	20.98	1.49	Ontario	Binders and Binder Accessories	0.35
\N	2490	DAX Metal Frame, Desktop, Stepped-Edge	Fred Hopkins	54563	43.87	20.24	8.99	Ontario	Office Furnishings	0.46
\N	2491	Letter or Legal Size Expandable Poly String Tie Envelopes	Jonathan Howell	54694	-201.6	2.66	6.35	Ontario	Envelopes	0.36
\N	2492	Keytronic 105-Key Spanish Keyboard	Matt Collister	54755	443.52	73.98	4	Ontario	Computer Peripherals	0.77
\N	2493	Xerox 1983	Duane Huffman	54914	-57.64	5.98	5.46	Ontario	Paper	0.36
\N	2494	Eldon Simplefile® Box Office®	Duane Huffman	54914	-27.83	12.44	6.27	Ontario	Storage & Organization	0.57
\N	2495	TIMEPORT P8767	Kelly Lampkin	55073	721.81	65.99	3.99	Ontario	Telephones and Communication	0.57
\N	2496	Binding Machine Supplies	Edward Nazzal	55270	-12.75	29.17	6.27	Ontario	Binders and Binder Accessories	0.37
\N	2497	High Speed Automatic Electric Letter Opener	Philip Brown	55716	-767.51	1637.53	24.49	Ontario	Scissors, Rulers and Trimmers	0.81
\N	2498	Panasonic KX-P1150 Dot Matrix Printer	Dean Braden	55776	1096.64	145.45	17.85	Ontario	Office Machines	0.56
\N	2499	Wilson Jones Hanging View Binder, White, 1"	Erica Smith	55874	-60.15	7.1	6.05	Ontario	Binders and Binder Accessories	0.39
\N	2500	Imation 3.5", DISKETTE 44766 HGHLD3.52HD/FM, 10/Pack	Erica Smith	55874	-111.72	4.98	4.62	Ontario	Computer Peripherals	0.64
\N	2501	Recycled Interoffice Envelopes with String and Button Closure, 10 x 13	Dave Hallsten	56002	149.31	23.99	6.71	Ontario	Envelopes	0.35
\N	2502	Xerox 1908	Dave Hallsten	56002	286.7	55.98	4.86	Ontario	Paper	0.36
\N	2503	Fellowes Super Stor/Drawer® Files	Dave Hallsten	56002	35.31	161.55	19.99	Ontario	Storage & Organization	0.66
\N	2504	Hon 5100 Series Wood Tables	Dave Hallsten	56002	-377.81	290.98	69	Ontario	Tables	0.67
\N	2505	Xerox 1977	Erica Smith	56039	-33.15	6.68	5.2	Ontario	Paper	0.37
\N	2506	Fellowes Personal Hanging Folder Files, Navy	Jim Mitchum	56710	5.71	13.43	5.5	Ontario	Storage & Organization	0.57
\N	2507	StarTAC 7760	Jim Mitchum	56710	-39.22	65.99	3.99	Ontario	Telephones and Communication	0.59
\N	2508	Belkin ErgoBoard™ Keyboard	Jim Mitchum	56710	-99.24	30.98	6.5	Ontario	Computer Peripherals	0.64
\N	2509	Imation DVD-RAM discs	Jim Mitchum	56710	232.99	35.41	1.99	Ontario	Computer Peripherals	0.43
\N	2510	LX 677	David Philippe	57092	601.34	110.99	8.99	Ontario	Telephones and Communication	0.57
\N	2511	Metal Folding Chairs, Beige, 4/Carton	Darren Budd	57253	1.74	1.81	0.75	Ontario	Chairs & Chairmats	0.58
\N	2512	Hon 4700 Series Mobuis™ Mid-Back Task Chairs with Adjustable Arms	Darren Budd	57253	-1358.9	20.98	53.03	Ontario	Chairs & Chairmats	0.64
\N	2513	Telescoping Adjustable Floor Lamp	Darren Budd	57253	-335.24	279.48	35	Ontario	Office Furnishings	0.6
\N	2514	Iceberg OfficeWorks 42" Round Tables	Darren Budd	57253	-139.16	4.91	5.68	Ontario	Tables	0.7
\N	2515	232	Darren Budd	57253	667.45	125.99	5.26	Ontario	Telephones and Communication	0.55
\N	2516	Presstex Flexible Ring Binders	George Ashbrook	57382	16.9	4.55	1.49	Ontario	Binders and Binder Accessories	0.35
\N	2517	Staples #10 Laser & Inkjet Envelopes, 4 1/8" x 9 1/2", 100/Box	George Ashbrook	57382	20.14	9.78	5.76	Ontario	Envelopes	0.35
\N	2518	Decoflex Hanging Personal Folder File	Tamara Chand	57415	-16.37	15.42	5.41	Ontario	Storage & Organization	0.59
\N	2519	Imation 3.5", RTS 247544 3M 3.5 DSDD, 10/Pack	Darren Budd	57606	-64.24	8.46	3.62	Ontario	Computer Peripherals	0.61
\N	2520	Xerox 1897	Edward Becker	57794	-46.92	4.98	6.07	Ontario	Paper	0.36
\N	2521	Eldon® Wave Desk Accessories	David Philippe	58054	-92.11	2.08	5.33	Ontario	Office Furnishings	0.43
\N	2522	GBC VeloBinder Strips	Anemone Ratner	58113	-88.95	7.68	6.16	Ontario	Binders and Binder Accessories	0.35
\N	2523	2160i	Anemone Ratner	58113	-38.07	200.99	4.2	Ontario	Telephones and Communication	0.59
\N	2524	Bionaire Personal Warm Mist Humidifier/Vaporizer	Janet Martin	58528	233.8	46.89	5.1	Ontario	Appliances	0.46
\N	2525	Colored Envelopes	Janet Martin	58528	-9.14	3.69	2.5	Ontario	Envelopes	0.39
\N	2526	Global Leather and Oak Executive Chair, Black	Edward Nazzal	58598	1342.93	300.98	64.73	Ontario	Chairs & Chairmats	0.56
\N	2527	Advantus SlideClip™ Paper Clips	Edward Nazzal	58598	33.46	3.41	0.7	Ontario	Rubber Bands	0.37
\N	2528	Document Clip Frames	Alan Hwang	58851	-6.39	8.34	0.96	Ontario	Office Furnishings	0.43
\N	2529	Canon MP100DHII Printing Calculator	Alan Hwang	58851	537.4	140.99	13.99	Ontario	Office Machines	0.37
\N	2530	Global Leather Highback Executive Chair with Pneumatic Height Adjustment, Black	Eugene Hildebrand	58853	1116.67	200.98	23.76	Ontario	Chairs & Chairmats	0.58
\N	2531	Hewlett-Packard 4.7GB DVD+R Discs	Andrew Roberts	59015	23.5	8.5	1.99	Ontario	Computer Peripherals	0.49
\N	2532	Document Clip Frames	Andrew Roberts	59015	149.39	8.34	0.96	Ontario	Office Furnishings	0.43
\N	2533	Xerox 1891	Andrew Roberts	59015	783.84	48.91	5.81	Ontario	Paper	0.38
\N	2534	Geographics Note Cards, Blank, White, 8 1/2" x 11"	David Smith	59075	55.06	11.19	5.03	Ontario	Paper	0.37
\N	2535	Newell 342	Edward Becker	59108	-59.97	3.28	3.97	Ontario	Pens & Art Supplies	0.56
\N	2536	M70	Edward Becker	59108	972.19	125.99	8.99	Ontario	Telephones and Communication	0.59
\N	2537	Fellowes Bankers Box™ Staxonsteel® Drawer File/Stacking System	Magdelene Morse	59589	122.42	64.98	6.88	Ontario	Storage & Organization	0.73
\N	2538	Belkin 8 Outlet Surge Protector	Jim Mitchum	59685	78.98	40.98	5.33	Ontario	Appliances	0.57
\N	2539	Tensor "Hersey Kiss" Styled Floor Lamp	Jim Mitchum	59685	-560.29	12.99	14.37	Ontario	Office Furnishings	0.73
\N	2540	Plymouth Boxed Rubber Bands by Plymouth	Ed Ludwig	59845	3.02	4.71	0.7	Ontario	Rubber Bands	0.8
\N	2541	Important Message Pads, 50 4-1/4 x 5-1/2 Forms per Pad	Ed Ludwig	59845	6.52	4.2	2.26	Ontario	Paper	0.36
\N	2542	Safco Industrial Wire Shelving	Michael Dominguez	134	-310.21	95.99	35	Ontario	Storage & Organization	\N
\N	2543	Avery White Multi-Purpose Labels	Thomas Boland	740	3.46	4.98	0.49	Ontario	Labels	0.39
\N	2544	GBC ProClick Spines for 32-Hole Punch	Olvera Toch	833	-20.32	12.53	7.17	Ontario	Binders and Binder Accessories	0.38
\N	2545	Global Push Button Manager's Chair, Indigo	Lena Radford	1573	-226.45	60.89	32.41	Ontario	Chairs & Chairmats	0.56
\N	2546	Strathmore Photo Mount Cards	Sean Christensen	1639	-62.2	6.78	6.18	Ontario	Paper	0.39
\N	2547	Global Troy™ Executive Leather Low-Back Tilter	Todd Boyes	2053	5603.95	500.98	126	Ontario	Chairs & Chairmats	0.6
\N	2548	7160	Todd Boyes	2053	-449.53	140.99	4.2	Ontario	Telephones and Communication	0.59
\N	2549	5165	Todd Boyes	2146	1663.08	175.99	4.99	Ontario	Telephones and Communication	0.59
\N	2550	Avery 479	Todd Boyes	2146	41.7	2.61	0.5	Ontario	Labels	0.39
\N	2551	Memorex 80 Minute CD-R, 30/Pack	Todd Boyes	2752	226.73	22.98	1.99	Ontario	Computer Peripherals	0.46
\N	2552	Staples Bulldog Clip	Todd Boyes	2752	55.48	3.78	0.71	Ontario	Rubber Bands	0.39
\N	2553	Multi-Use Personal File Cart and Caster Set, Three Stacking Bins	Todd Boyes	2752	15.77	34.76	8.22	Ontario	Storage & Organization	0.57
\N	2554	2190	Todd Boyes	2752	-86.52	65.99	5.63	Ontario	Telephones and Communication	0.56
\N	2555	Avery 52	Michael Dominguez	5445	14.43	3.69	0.5	Ontario	Labels	0.38
\N	2556	Binney & Smith Crayola® Metallic Colored Pencils, 8-Color Set	Michael Dominguez	5445	-1.82	4.63	1.93	Ontario	Pens & Art Supplies	0.52
\N	2557	Avery 491	Sean Miller	5699	-4.21	4.13	0.99	Ontario	Labels	0.39
\N	2558	Super Decoflex Portable Personal File	Sean Miller	5699	-121.44	14.98	7.69	Ontario	Storage & Organization	0.57
\N	2559	Large Capacity Hanging Post Binders	Todd Boyes	6823	490.28	24.95	2.99	Ontario	Binders and Binder Accessories	0.39
\N	2560	Imation 3.5" DS/HD IBM Formatted Diskettes, 50/Pack	Todd Boyes	6823	-135.46	15.98	8.99	Ontario	Computer Peripherals	0.64
\N	2561	Keytronic French Keyboard	Phillip Breyer	6948	-88.7	73.98	4	Ontario	Computer Peripherals	0.79
\N	2562	Boston 16801 Nautilus™ Battery Pencil Sharpener	Lena Radford	7462	-26.94	22.01	5.53	Ontario	Pens & Art Supplies	0.59
\N	2563	Acco Pressboard Covers with Storage Hooks, 14 7/8" x 11", Light Blue	Todd Boyes	7845	-63.38	4.91	5.68	Ontario	Binders and Binder Accessories	0.36
\N	2564	Xerox 1916	Todd Boyes	7845	1012.67	48.94	5.86	Ontario	Paper	0.35
\N	2565	Eureka Disposable Bags for Sanitaire® Vibra Groomer I® Upright Vac	Michelle Ellison	8033	-133.62	4.06	6.89	Ontario	Appliances	0.6
\N	2566	Master Giant Foot® Doorstop, Safety Yellow	Olvera Toch	8388	25.16	7.59	4	Ontario	Office Furnishings	0.42
\N	2567	Fellowes Binding Cases	Olvera Toch	8388	24.85	11.7	5.63	Ontario	Binders and Binder Accessories	0.4
\N	2568	Adams Phone Message Book, Professional, 400 Message Capacity, 5 3/6” x 11”	Olvera Toch	8388	96.34	6.98	1.6	Ontario	Paper	0.38
\N	2569	Lexmark Z54se Color Inkjet Printer	Todd Boyes	9761	-221.62	90.97	14	Ontario	Office Machines	0.36
\N	2570	Universal Premium White Copier/Laser Paper (20Lb. and 87 Bright)	Todd Boyes	9761	-92.23	5.98	7.15	Ontario	Paper	0.36
\N	2571	Newell 310	Sean Christensen	9863	0.1	1.76	0.7	Ontario	Pens & Art Supplies	0.56
\N	2572	Sauder Camden County Collection Libraries, Planked Cherry Finish	Michelle Ellison	10342	-1623.6	114.98	58.72	Ontario	Bookcases	0.76
\N	2573	Brother DCP1000 Digital 3 in 1 Multifunction Machine	Michelle Ellison	10342	2925.37	299.99	11.64	Ontario	Copiers and Fax	0.5
\N	2574	Dana Halogen Swing-Arm Architect Lamp	Michelle Ellison	10342	324.47	40.97	14.45	Ontario	Office Furnishings	0.57
\N	2575	Polycom Soundstation EX Audio-Conferencing Telephone, Black	Michelle Ellison	10342	-2342.01	999.99	13.99	Ontario	Office Machines	0.36
\N	2576	Global Ergonomic Managers Chair	Michelle Ellison	10434	-244.47	180.98	26.2	Ontario	Chairs & Chairmats	0.59
\N	2577	Recycled Interoffice Envelopes with String and Button Closure, 10 x 13	Scot Coram	11040	389.61	23.99	6.71	Ontario	Envelopes	0.35
\N	2578	Lexmark Z54se Color Inkjet Printer	Natalie Fritzler	11302	35.29	90.97	14	Ontario	Office Machines	0.36
\N	2579	Xerox 1895	Nathan Gelder	11398	-106.77	5.98	10.39	Ontario	Paper	0.4
\N	2580	Prang Colored Pencils	Nathan Gelder	11398	23.37	2.94	0.81	Ontario	Pens & Art Supplies	0.4
\N	2581	Accessory31	Sean Miller	11584	836.51	35.99	0.99	Ontario	Telephones and Communication	0.35
\N	2582	PC Concepts 116 Key Quantum 3000 Keyboard	Olvera Toch	11652	-36	32.98	5.5	Ontario	Computer Peripherals	0.75
\N	2583	Xerox 1895	Olvera Toch	11652	-249.11	5.98	10.39	Ontario	Paper	0.4
\N	2584	Talkabout T8367	Olvera Toch	11652	-261.35	65.99	8.99	Ontario	Telephones and Communication	0.56
\N	2585	Array® Memo Cubes	Olvera Toch	11652	14.11	5.18	2.04	Ontario	Paper	0.36
\N	2586	V70	Michael Dominguez	11686	1312.34	205.99	2.5	Ontario	Telephones and Communication	0.59
\N	2587	Project Tote Personal File	Michelle Ellison	13895	-171.7	14.03	9.37	Ontario	Storage & Organization	0.56
\N	2588	Bell Sonecor JB700 Caller ID	Michael Dominguez	14820	-104.47	7.99	5.03	Ontario	Telephones and Communication	0.6
\N	2589	1726 Digital Answering Machine	Thomas Boland	15170	-9.11	20.99	4.81	Ontario	Telephones and Communication	0.58
\N	2590	Staples Bulldog Clip	Thomas Boland	15780	22.71	3.78	0.71	Ontario	Rubber Bands	0.39
\N	2591	GE 4 Foot Flourescent Tube, 40 Watt	Patricia Hirasaki	16098	50.59	14.98	8.99	Ontario	Office Furnishings	0.39
\N	2592	Xerox 1894	Maria Zettner	16103	-62.97	6.48	6.22	Ontario	Paper	0.37
\N	2593	Tyvek ® Top-Opening Peel & Seel ® Envelopes, Gray	Thomas Boland	16610	187.57	35.94	6.66	Ontario	Envelopes	0.4
\N	2594	Avery Flip-Chart Easel Binder, Black	Matthew Clasen	18757	-40.25	22.38	15.1	Ontario	Binders and Binder Accessories	0.38
\N	2595	Storex Dura Pro™ Binders	Matthew Clasen	18757	-37.8	5.94	9.92	Ontario	Binders and Binder Accessories	0.38
\N	2596	Newell 31	Nathan Gelder	19431	-5.54	4.13	1.17	Ontario	Pens & Art Supplies	0.57
\N	2597	Epson DFX-8500 Dot Matrix Printer	Maria Zettner	19584	-3971.06	2550.14	29.7	Ontario	Office Machines	0.57
\N	2598	Executive Impressions 14" Two-Color Numerals Wall Clock	Patrick O'Donnell	20262	185.04	22.72	8.99	Ontario	Office Furnishings	0.44
\N	2599	Global Commerce™ Series High-Back Swivel/Tilt Chairs	Sean Miller	20545	-163.58	284.98	69.55	Ontario	Chairs & Chairmats	0.6
\N	2600	Xerox 1919	Sean Miller	20545	554.95	40.99	5.86	Ontario	Paper	0.36
\N	2659	Vinyl Sectional Post Binders	Natalie Fritzler	39168	321.67	37.7	2.99	Ontario	Binders and Binder Accessories	0.35
\N	2601	Lesro Sheffield Collection Coffee Table, End Table, Center Table, Corner Table	Sean Miller	20545	-1754.39	71.37	69	Ontario	Tables	0.68
\N	2602	Ibico Recycled Linen-Style Covers	Patrick O'Donnell	20577	134.75	39.06	10.55	Ontario	Binders and Binder Accessories	0.37
\N	2603	Okidata ML390 Turbo Dot Matrix Printers	Sean Miller	20804	215.31	442.14	14.7	Ontario	Office Machines	0.56
\N	2604	Avoid Verbal Orders Carbonless Minifold Book	Harry Marie	21414	29.27	3.38	1.09	Ontario	Paper	0.39
\N	2605	Carina Double Wide Media Storage Towers in Natural & Black	Harry Marie	21414	-1144.67	80.98	35	Ontario	Storage & Organization	0.81
\N	2606	8290	Harry Marie	21414	717.7	125.99	5.63	Ontario	Telephones and Communication	0.6
\N	2607	Fiskars® Softgrip Scissors	Sean Christensen	21447	9.85	10.98	3.37	Ontario	Scissors, Rulers and Trimmers	0.57
\N	2608	Xerox 20	Patrick O'Donnell	21479	-89.47	6.48	6.57	Ontario	Paper	0.37
\N	2609	Microsoft Multimedia Keyboard	Sean Christensen	22208	18.59	30.97	4	Ontario	Computer Peripherals	0.74
\N	2610	Timeport L7089	Sean Christensen	22208	1379.76	125.99	7.69	Ontario	Telephones and Communication	0.58
\N	2611	Xerox 1940	Lena Radford	22279	1040.65	54.96	10.75	Ontario	Paper	0.36
\N	2612	Hon Multipurpose Stacking Arm Chairs	Harry Marie	23174	44.8	216.6	64.2	Ontario	Chairs & Chairmats	0.59
\N	2613	Rogers® Profile Extra Capacity Storage Tub	Harry Marie	23174	-60.04	16.74	7.04	Ontario	Storage & Organization	0.81
\N	2614	Holmes Odor Grabber	Michael Dominguez	23333	-21.65	14.42	6.75	Ontario	Appliances	0.52
\N	2615	Xerox 1903	Michael Dominguez	23333	-69.29	5.98	5.79	Ontario	Paper	0.36
\N	2616	Talkabout T8367	Michael Dominguez	23333	-23.83	65.99	8.99	Ontario	Telephones and Communication	0.56
\N	2617	Hon Comfortask® Task/Swivel Chairs	Patrick O'Donnell	24640	-151.73	113.98	30	Ontario	Chairs & Chairmats	0.69
\N	2618	Xerox 217	Phillip Breyer	25056	-151.93	6.48	8.19	Ontario	Paper	0.37
\N	2619	Imation 3.5", RTS 247544 3M 3.5 DSDD, 10/Pack	Michael Dominguez	26244	-42.61	8.46	3.62	Ontario	Computer Peripherals	0.61
\N	2620	Global Troy™ Executive Leather Low-Back Tilter	Scot Coram	27201	789.05	500.98	26	Ontario	Chairs & Chairmats	0.6
\N	2621	KI Conference Tables	Scot Coram	27201	-2661.32	70.89	89.3	Ontario	Tables	0.72
\N	2622	IBM 80 Minute CD-R Spindle, 50/Pack	Michelle Ellison	27808	4.41	20.89	1.99	Ontario	Computer Peripherals	0.48
\N	2623	Xerox 1939	Michael Dominguez	29573	42.24	18.97	9.54	Ontario	Paper	0.37
\N	2624	Xerox 1904	Maria Zettner	29862	-76.88	6.48	5.86	Ontario	Paper	0.36
\N	2625	Acme Hot Forged Carbon Steel Scissors with Nickel-Plated Handles, 3 7/8" Cut, 8"L	Nathan Gelder	30433	-35.78	13.9	7.59	Ontario	Scissors, Rulers and Trimmers	0.56
\N	2626	GBC Twin Loop™ Wire Binding Elements, 9/16" Spine, Black	Victoria Wilson	30532	-28.67	15.22	9.73	Ontario	Binders and Binder Accessories	0.36
\N	2627	#10 Self-Seal White Envelopes	Victoria Wilson	30532	27.55	11.09	5.25	Ontario	Envelopes	0.36
\N	2628	Xerox 188	Victoria Wilson	30532	82.19	11.34	5.01	Ontario	Paper	0.36
\N	2629	O'Sullivan Manor Hill 2-Door Library in Brianna Oak	Victoria Wilson	30532	-82.81	180.98	23.58	Ontario	Bookcases	0.74
\N	2630	Master Caster Door Stop, Brown	Michelle Ellison	30597	20.01	5.08	2.03	Ontario	Office Furnishings	0.51
\N	2631	Eldon® Gobal File Keepers	Michelle Ellison	30597	-95.76	15.14	4.53	Ontario	Storage & Organization	0.81
\N	2632	Sanyo 2.5 Cubic Foot Mid-Size Office Refrigerators	Nathan Gelder	30981	1817.76	279.81	23.19	Ontario	Appliances	0.59
\N	2633	Office Star - Ergonomic Mid Back Chair with 2-Way Adjustable Arms	Nathan Gelder	30981	-116.02	180.98	30	Ontario	Chairs & Chairmats	0.69
\N	2634	GBC Laser Imprintable Binding System Covers, Desert Sand	Todd Boyes	31751	-10.22	14.27	7.27	Ontario	Binders and Binder Accessories	0.38
\N	2635	Tripp Lite Isotel 8 Ultra 8 Outlet Metal Surge	Shahid Collister	31873	-91.09	70.97	3.5	Ontario	Appliances	0.59
\N	2636	StarTAC 8000	Shahid Collister	31873	13.01	205.99	8.99	Ontario	Telephones and Communication	0.6
\N	2637	TimeportP7382	Shahid Collister	31873	2539.46	205.99	8.99	Ontario	Telephones and Communication	0.56
\N	2638	Xerox 1928	Shahid Collister	31873	-125.29	5.28	6.26	Ontario	Paper	0.4
\N	2639	Acco® Hot Clips™ Clips to Go	Victoria Wilson	32000	24.95	3.29	1.35	Ontario	Rubber Bands	0.4
\N	2640	Chromcraft Bull-Nose Wood 48" x 96" Rectangular Conference Tables	Victoria Wilson	32000	-1096.78	550.98	147.12	Ontario	Tables	0.8
\N	2641	Lock-Up Easel 'Spel-Binder'	Victoria Wilson	32737	116.8	28.53	1.49	Ontario	Binders and Binder Accessories	0.38
\N	2642	Staples 6 Outlet Surge	Thomas Boland	35012	-16.38	11.97	4.98	Ontario	Appliances	0.58
\N	2643	T65	Thomas Boland	35012	-165.95	195.99	4.2	Ontario	Telephones and Communication	0.56
\N	2644	Microsoft Natural Multimedia Keyboard	Michael Dominguez	35042	-12.51	50.98	6.5	Ontario	Computer Peripherals	0.73
\N	2645	Lock-Up Easel 'Spel-Binder'	Phillip Breyer	35713	590.04	28.53	1.49	Ontario	Binders and Binder Accessories	0.38
\N	2646	Canon BP1200DH 12-Digit Bubble Jet Printing Calculator	Patrick O'Donnell	36229	373.5	120.97	7.11	Ontario	Office Machines	0.36
\N	2647	Bevis Round Conference Table Top & Single Column Base	Patrick O'Donnell	36229	-31.73	146.34	43.75	Ontario	Tables	0.65
\N	2648	Avery 501	Todd Boyes	36933	47.56	3.69	0.5	Ontario	Labels	0.38
\N	2649	Hon Comfortask® Task/Swivel Chairs	Thomas Boland	37152	182.53	113.98	30	Ontario	Chairs & Chairmats	0.69
\N	2650	6120	Thomas Boland	37152	447.12	65.99	8.8	Ontario	Telephones and Communication	0.58
\N	2651	LX 788	Victoria Wilson	37223	310.59	155.99	8.99	Ontario	Telephones and Communication	0.58
\N	2652	Portfile® Personal File Boxes	Victoria Wilson	37223	-152.4	17.7	9.47	Ontario	Storage & Organization	0.59
\N	2653	Tennsco Stur-D-Stor Boltless Shelving, 5 Shelves, 24" Deep, Sand	Victoria Wilson	37223	-743.45	135.31	35	Ontario	Storage & Organization	0.84
\N	2654	Quality Park Security Envelopes	Katrina Bavinger	37254	370.23	26.17	1.39	Ontario	Envelopes	0.38
\N	2655	Global Leather and Oak Executive Chair, Black	Katrina Bavinger	37441	3407.73	300.98	164.73	Ontario	Chairs & Chairmats	0.56
\N	2656	Newell 343	Katrina Bavinger	37441	-1.84	2.94	0.96	Ontario	Pens & Art Supplies	0.58
\N	2657	Black Print Carbonless Snap-Off® Rapid Letter, 8 1/2" x 7"	Victoria Wilson	38084	18.41	9.11	2.15	Ontario	Paper	0.4
\N	2658	Nu-Dell Executive Frame	Victoria Wilson	38084	65.63	12.64	4.98	Ontario	Office Furnishings	0.48
\N	2660	Southworth 25% Cotton Premium Laser Paper and Envelopes	Natalie Fritzler	39168	184.07	19.98	8.68	Ontario	Paper	0.37
\N	2661	Staples Battery-Operated Desktop Pencil Sharpener	Natalie Fritzler	39168	5.08	10.48	2.89	Ontario	Pens & Art Supplies	0.6
\N	2662	Hon Pagoda™ Stacking Chairs	Michelle Ellison	39333	2081.48	320.98	24.49	Ontario	Chairs & Chairmats	0.55
\N	2663	Staples Copy Paper (20Lb. and 84 Bright)	Michelle Ellison	39333	-33.4	4.98	4.7	Ontario	Paper	0.38
\N	2664	Mead 1st Gear 2" Zipper Binder, Asst. Colors	Olvera Toch	39589	253.5	12.97	1.49	Ontario	Binders and Binder Accessories	0.35
\N	2665	Avery 508	Olvera Toch	39589	39.91	4.91	0.5	Ontario	Labels	0.36
\N	2666	Avoid Verbal Orders Carbonless Minifold Book	Sean Christensen	39906	15.25	3.38	1.09	Ontario	Paper	0.39
\N	2667	12 Colored Short Pencils	Olvera Toch	40097	-71	2.6	2.4	Ontario	Pens & Art Supplies	0.58
\N	2668	6162m	Maria Zettner	40193	692.78	115.99	2.5	Ontario	Telephones and Communication	0.57
\N	2669	Holmes Replacement Filter for HEPA Air Cleaner, Large Room	Michelle Ellison	40258	-190.49	14.81	13.32	Ontario	Appliances	0.43
\N	2670	Newell 318	Michelle Ellison	40258	-8.77	2.78	1.25	Ontario	Pens & Art Supplies	0.59
\N	2671	Tenex Traditional Chairmats for Medium Pile Carpet, Standard Lip, 36" x 48"	Michelle Ellison	40544	544.04	60.65	12.23	Ontario	Office Furnishings	0.64
\N	2672	Cardinal Holdit Business Card Pockets	Victoria Wilson	41765	-95.99	4.98	4.95	Ontario	Binders and Binder Accessories	0.37
\N	2673	Ibico Covers for Plastic or Wire Binding Elements	Thomas Boland	42242	-33.19	11.5	7.19	Ontario	Binders and Binder Accessories	0.4
\N	2674	Gyration Ultra Cordless Optical Suite	Thomas Boland	42242	236.61	100.97	7.18	Ontario	Computer Peripherals	0.46
\N	2675	AT&T 2230 Dual Handset Phone With Caller ID/Call Waiting	Thomas Boland	42242	231.49	99.99	19.99	Ontario	Office Machines	0.52
\N	2676	Memorex 'Cool' 80 Minute CD-R Spindle, 25/Pack	Patricia Hirasaki	42369	274.98	17.48	1.99	Ontario	Computer Peripherals	0.46
\N	2677	GBC DocuBind 200 Manual Binding Machine	Olvera Toch	42690	8918.74	420.98	19.99	Ontario	Binders and Binder Accessories	0.35
\N	2678	Rogers® Profile Extra Capacity Storage Tub	Olvera Toch	42690	-236.12	16.74	7.04	Ontario	Storage & Organization	0.81
\N	2679	Hewlett Packard LaserJet 3310 Copier	Victoria Wilson	45184	5485.15	599.99	24.49	Ontario	Copiers and Fax	0.37
\N	2680	Staples Metal Binder Clips	Victoria Wilson	45184	2.65	2.62	0.8	Ontario	Rubber Bands	0.39
\N	2681	Document Clip Frames	Michelle Ellison	45632	231.68	8.34	0.96	Ontario	Office Furnishings	0.43
\N	2682	Memorex 4.7GB DVD+RW, 3/Pack	Sean Miller	46276	-52.62	28.48	1.99	Ontario	Computer Peripherals	0.4
\N	2683	Canon PC1060 Personal Laser Copier	Sean Miller	46276	6079.63	699.99	24.49	Ontario	Copiers and Fax	0.41
\N	2684	Imation 3.5" Diskettes, IBM Format, DS/HD, 10/Box, Neon	Patrick O'Donnell	46566	258.25	31.11	3.6	Ontario	Computer Peripherals	0.64
\N	2685	Okidata ML390 Turbo Dot Matrix Printers	Sean Christensen	48198	-688.44	442.14	14.7	Ontario	Office Machines	0.56
\N	2686	Fellowes Smart Surge Ten-Outlet Protector, Platinum	Sean Christensen	48198	860.22	60.22	3.5	Ontario	Appliances	0.57
\N	2687	Staples Plastic Wall Frames	Victoria Wilson	48453	-7.73	7.96	4.95	Ontario	Office Furnishings	0.41
\N	2688	Snap-A-Way® Black Print Carbonless Ruled Speed Letter, Triplicate	Scot Coram	48518	178.14	37.94	5.08	Ontario	Paper	0.38
\N	2689	Xerox 188	Olvera Toch	49349	0.64	11.34	5.01	Ontario	Paper	0.36
\N	2690	Holmes Replacement Filter for HEPA Air Cleaner, Very Large Room, HEPA Filter	Olvera Toch	49349	-524.03	68.81	60	Ontario	Appliances	0.41
\N	2691	Rubber Band Ball	Michelle Ellison	49668	-15.37	3.74	0.94	Ontario	Rubber Bands	0.83
\N	2692	Eldon Shelf Savers™ Cubes and Bins	Michael Nguyen	50309	-314.22	6.98	9.69	Ontario	Storage & Organization	0.83
\N	2693	Adesso Programmable 142-Key Keyboard	Patrick O'Donnell	52327	21.5	152.48	6.5	Ontario	Computer Peripherals	0.74
\N	2694	Staples Copy Paper (20Lb. and 84 Bright)	Patrick O'Donnell	52327	-14.69	4.98	4.7	Ontario	Paper	0.38
\N	2695	Hewlett-Packard 2600DN Business Color Inkjet Printer	Scot Coram	52516	335.29	119.99	56.14	Ontario	Office Machines	0.39
\N	2696	Acme® Box Cutter Scissors	Scot Coram	52516	-31.67	10.23	4.68	Ontario	Scissors, Rulers and Trimmers	0.59
\N	2697	Super Bands, 12/Pack	Todd Boyes	52800	-27.29	1.86	2.58	Ontario	Rubber Bands	0.82
\N	2698	Carina Double Wide Media Storage Towers in Natural & Black	Scot Coram	53574	-297.02	80.98	35	Ontario	Storage & Organization	0.81
\N	2699	GBC Standard Plastic Binding Systems Combs	Sean Miller	54023	-8.59	8.85	5.6	Ontario	Binders and Binder Accessories	0.36
\N	2700	Accessory21	Scot Coram	55265	346.14	20.99	0.99	Ontario	Telephones and Communication	0.37
\N	2701	Hoover Portapower™ Portable Vacuum	Lena Radford	55398	-1085.52	4.48	49	Ontario	Appliances	0.6
\N	2702	Self-Adhesive Ring Binder Labels	Shahid Collister	55458	-167.42	3.52	6.83	Ontario	Binders and Binder Accessories	0.38
\N	2703	Super Decoflex Portable Personal File	Shahid Collister	55458	-30.71	14.98	7.69	Ontario	Storage & Organization	0.57
\N	2704	Hon Valutask™ Swivel Chairs	Michelle Ellison	55809	-180.61	100.98	45	Ontario	Chairs & Chairmats	0.69
\N	2705	Xerox 197	Maria Zettner	56992	-41.26	30.98	17.08	Ontario	Paper	0.4
\N	2706	Avery Poly Binder Pockets	Patrick O'Donnell	58210	-139.52	3.58	5.47	Ontario	Binders and Binder Accessories	0.37
\N	2707	Harmony HEPA Quiet Air Purifiers	Michael Dominguez	58277	-23.35	11.7	6.96	Ontario	Appliances	0.5
\N	2708	Ibico Laser Imprintable Binding System Covers	Nathan Gelder	58720	597.16	52.4	16.11	Ontario	Binders and Binder Accessories	0.39
\N	2709	Xerox 1979	Nathan Gelder	58720	13.87	30.98	8.74	Ontario	Paper	0.4
\N	2710	Advantus Panel Wall Certificate Holder - 8.5x11	Patricia Hirasaki	58820	61.51	12.2	6.02	Ontario	Office Furnishings	0.43
\N	2711	Tripp Lite Isotel 8 Ultra 8 Outlet Metal Surge	Thea Hendricks	1154	57.1	70.97	3.5	Newfoundland	Appliances	0.59
\N	2712	Accessory37	Corey Catlett	1382	-107.1	20.99	2.5	Newfoundland	Telephones and Communication	0.81
\N	2713	Ibico Presentation Index for Binding Systems	Corey Catlett	1382	-130.66	3.98	5.26	Newfoundland	Binders and Binder Accessories	0.38
\N	2714	Bush Cubix Collection Bookcases, Fully Assembled	Corey Catlett	1382	487.17	220.98	64.66	Newfoundland	Bookcases	0.62
\N	2715	Rush Hierlooms Collection Rich Wood Bookcases	Ed Jacobs	1411	-459.86	160.98	35.02	Newfoundland	Bookcases	0.72
\N	2716	Xerox 1984	Noel Staavos	1444	-13.67	6.48	8.74	Newfoundland	Paper	0.36
\N	2717	Accessory4	Keith Herrera	3942	-247.18	85.99	0.99	Newfoundland	Telephones and Communication	0.85
\N	2718	Multimedia Mailers	Carlos Meador	4647	293.14	162.93	19.99	Newfoundland	Envelopes	0.39
\N	2719	Peel & Seel® Recycled Catalog Envelopes, Brown	Carlos Meador	4647	-6.61	11.58	5.72	Newfoundland	Envelopes	0.35
\N	2720	Global Leather and Oak Executive Chair, Black	Corinna Mitchell	4960	763.33	300.98	64.73	Newfoundland	Chairs & Chairmats	0.56
\N	2721	Sony MFD2HD Formatted Diskettes, 10/Pack	Raymond Fair	7367	-59.98	6.48	2.74	Newfoundland	Computer Peripherals	0.71
\N	2722	Peel-Off® China Markers	Carlos Meador	7938	132.56	9.93	1.09	Newfoundland	Pens & Art Supplies	0.43
\N	2723	Fellowes 17-key keypad for PS/2 interface	Karl Brown	8320	72.78	30.73	4	Newfoundland	Computer Peripherals	0.75
\N	2724	i1000plus	Natalie Webber	8807	-78.54	125.99	4.2	Newfoundland	Telephones and Communication	0.57
\N	2725	GE 48" Fluorescent Tube, Cool White Energy Saver, 34 Watts, 30/Box	Eric Barreto	9062	1193.19	99.23	8.99	Newfoundland	Office Furnishings	0.35
\N	2726	Lexmark Z55se Color Inkjet Printer	Hunter Lopez	9602	600.93	90.97	28	Newfoundland	Office Machines	0.38
\N	2727	Sauder Camden County Collection Library	Hunter Lopez	9602	-399.67	114.98	51.42	Newfoundland	Bookcases	0.65
\N	2728	Linden® 12" Wall Clock With Oak Frame	Barry Franz	10209	-12	33.98	19.99	Newfoundland	Office Furnishings	0.55
\N	2729	Lexmark Z54se Color Inkjet Printer	Barry Franz	10338	15.36	90.97	14	Newfoundland	Office Machines	0.36
\N	2730	Eldon Econocleat® Chair Mats for Low Pile Carpets	Craig Yedwab	10688	-200.84	41.47	34.2	Newfoundland	Office Furnishings	0.73
\N	2731	Lock-Up Easel 'Spel-Binder'	Eric Barreto	11206	39.63	28.53	1.49	Newfoundland	Binders and Binder Accessories	0.38
\N	2732	SC7868i	Chuck Sachs	11585	-605.37	125.99	8.99	Newfoundland	Telephones and Communication	0.55
\N	2733	Spiral Phone Message Books with Labels by Adams	Muhammed Lee	12868	-5.26	4.48	1.22	Newfoundland	Paper	0.36
\N	2734	Eaton Premium Continuous-Feed Paper, 25% Cotton, Letter Size, White, 1000 Shts/Box	Karl Brown	14215	964.1	55.48	6.79	Newfoundland	Paper	0.37
\N	2735	Prang Dustless Chalk Sticks	Karl Brown	14662	-1.78	1.68	1	Newfoundland	Pens & Art Supplies	0.35
\N	2736	Bush Advantage Collection® Round Conference Table	Bobby Trafton	14727	-513.79	212.6	52.2	Newfoundland	Tables	0.64
\N	2737	Belkin MediaBoard 104- Keyboard	David Flashing	15781	0.9	27.48	4	Newfoundland	Computer Peripherals	0.75
\N	2738	i1000plus	Rick Duston	17157	574.98	125.99	4.2	Newfoundland	Telephones and Communication	0.57
\N	2739	Holmes Replacement Filter for HEPA Air Cleaner, Medium Room	Troy Staebel	17795	-15.92	11.33	6.12	Newfoundland	Appliances	0.42
\N	2740	Catalog Binders with Expanding Posts	Nora Paige	20449	162.18	67.28	19.99	Newfoundland	Binders and Binder Accessories	0.4
\N	2741	Newell 343	Amy Cox	21890	4.06	2.94	0.96	Newfoundland	Pens & Art Supplies	0.58
\N	2742	Tenex Personal Project File with Scoop Front Design, Black	Harold Dahlen	22020	10.18	13.48	4.51	Newfoundland	Storage & Organization	0.59
\N	2743	Dixon Prang® Watercolor Pencils, 10-Color Set with Brush	Bobby Trafton	22149	38.11	4.26	1.2	Newfoundland	Pens & Art Supplies	0.44
\N	2744	Staples #10 Laser & Inkjet Envelopes, 4 1/8" x 9 1/2", 100/Box	Jay Fine	23078	-15.9	9.78	5.76	Newfoundland	Envelopes	0.35
\N	2745	Canon MP41DH Printing Calculator	Nora Paige	23619	-52.5	150.98	13.99	Newfoundland	Office Machines	0.38
\N	2746	Newell 310	Dan Campbell	24003	1.33	1.76	0.7	Newfoundland	Pens & Art Supplies	0.56
\N	2747	2300 Heavy-Duty Transfer File Systems by Perma	Dan Campbell	24003	4.69	24.98	8.79	Newfoundland	Storage & Organization	0.66
\N	2748	Xerox 1888	George Zrebassa	25442	742.96	55.48	4.85	Newfoundland	Paper	0.37
\N	2749	Boston 16801 Nautilus™ Battery Pencil Sharpener	Rick Duston	25927	105.7	22.01	5.53	Newfoundland	Pens & Art Supplies	0.59
\N	2750	Crayola Anti Dust Chalk, 12/Pack	Eleni McCrary	26243	-4.9	1.82	1	Newfoundland	Pens & Art Supplies	0.4
\N	2751	Acco D-Ring Binder w/DublLock®	Frank Atkinson	28515	302.12	21.38	2.99	Newfoundland	Binders and Binder Accessories	0.36
\N	2752	Recycled Premium Regency Composition Covers	Astrea Jones	29667	-51.75	15.28	10.91	Newfoundland	Binders and Binder Accessories	0.36
\N	2753	SimpliFile™ Personal File, Black Granite, 15w x 6-15/16d x 11-1/4h	Giulietta Dortch	30023	-76.34	11.35	8.6	Newfoundland	Storage & Organization	0.57
\N	2754	Adams Phone Message Book, 200 Message Capacity, 8 1/16” x 11”	Cathy Hwang	30215	18.42	6.88	2	Newfoundland	Paper	0.39
\N	2755	Riverleaf Stik-Withit® Designer Note Cubes®	Damala Kotsonis	31845	28.61	10.06	2.06	Newfoundland	Paper	0.39
\N	2756	Bush Westfield Collection Bookcases, Fully Assembled	David Flashing	32999	-193.58	100.98	35.84	Newfoundland	Bookcases	0.62
\N	2757	Newell 325	Dianna Arnett	35777	5.91	4.13	1.23	Newfoundland	Pens & Art Supplies	0.55
\N	2758	Super Decoflex Portable Personal File	Fred McMath	36005	-16.54	14.98	7.69	Newfoundland	Storage & Organization	0.57
\N	2759	DAX Solid Wood Frames	Christy Brittain	36196	17.31	9.77	6.02	Newfoundland	Office Furnishings	0.48
\N	2760	Imation 3.5" DS-HD Macintosh Formatted Diskettes, 10/Pack	Tom Prescott	36230	-31.38	7.28	3.52	Newfoundland	Computer Peripherals	0.68
\N	2761	GBC Binding covers	Yana Sorensen	36294	100.22	12.95	4.98	Newfoundland	Binders and Binder Accessories	0.4
\N	2762	i1000	Harold Dahlen	36737	215.43	65.99	5.99	Newfoundland	Telephones and Communication	0.58
\N	2763	Staples Gold Paper Clips	Brad Thomas	37287	0.89	2.98	1.58	Newfoundland	Rubber Bands	0.39
\N	2764	Logitech Access Keyboard	Cynthia Voltz	37831	76.59	15.98	4	Newfoundland	Computer Peripherals	0.37
\N	2765	Wirebound Service Call Books, 5 1/2" x 4"	Dean Percer	38372	106.45	9.68	2.03	Newfoundland	Paper	0.37
\N	2766	T193	Ben Peterman	38912	310.19	65.99	4.99	Newfoundland	Telephones and Communication	0.57
\N	2767	Brites Rubber Bands, 1 1/2 oz. Box	Astrea Jones	39040	-1	1.98	0.7	Newfoundland	Rubber Bands	0.83
\N	2768	It's Hot Message Books with Stickers, 2 3/4" x 5"	Tracy Poddar	40896	42.86	7.4	1.71	Newfoundland	Paper	0.4
\N	2769	Avery Legal 4-Ring Binder	Michael Paige	40994	323.08	20.98	1.49	Newfoundland	Binders and Binder Accessories	0.35
\N	2770	GBC VeloBinder Electric Binding Machine	Barry Franz	41607	1719.47	120.98	9.07	Newfoundland	Binders and Binder Accessories	0.35
\N	2771	SouthWestern Bell FA970 Digital Answering Machine with Time/Day Stamp	Corey Roper	41666	-97.92	28.99	8.59	Newfoundland	Telephones and Communication	0.56
\N	2772	Binney & Smith inkTank™ Erasable Pocket Highlighter, Chisel Tip, Yellow	Maureen Gastineau	42306	-63.03	2.28	5.2	Newfoundland	Pens & Art Supplies	0.41
\N	2773	GBC Wire Binding Strips	Muhammed Yedwab	42469	98.69	31.74	12.62	Newfoundland	Binders and Binder Accessories	0.37
\N	2774	OIC Bulk Pack Metal Binder Clips	Alex Grayson	42528	56.73	3.49	0.76	Newfoundland	Rubber Bands	0.39
\N	2775	Bretford CR8500 Series Meeting Room Furniture	Muhammed Yedwab	42884	-969.05	400.98	42.52	Newfoundland	Tables	0.71
\N	2776	Avery Hi-Liter Comfort Grip Fluorescent Highlighter, Yellow Ink	Damala Kotsonis	43302	-5.14	1.95	1.63	Newfoundland	Pens & Art Supplies	0.46
\N	2777	Fellowes Twister Kit, Gray/Clear, 3/pkg	Astrea Jones	43460	-17.6	8.04	8.94	Newfoundland	Binders and Binder Accessories	0.4
\N	2778	8260	Chris Cortes	43972	-62.33	65.99	8.99	Newfoundland	Telephones and Communication	0.58
\N	2779	Staples Colored Interoffice Envelopes	Dan Campbell	44000	-19.1	30.98	19.51	Newfoundland	Envelopes	0.36
\N	2780	Tensor "Hersey Kiss" Styled Floor Lamp	Rick Duston	46177	-292.7	12.99	14.37	Newfoundland	Office Furnishings	0.73
\N	2781	Bush Westfield Collection Bookcases, Fully Assembled	Corey Roper	48226	-108.8	100.98	35.84	Newfoundland	Bookcases	0.62
\N	2782	Xerox 1964	Amy Cox	48455	76.63	22.84	11.54	Newfoundland	Paper	0.39
\N	2783	Xerox 1880	Sara Luxemburg	48929	-48.91	35.44	19.99	Newfoundland	Paper	0.38
\N	2784	Office Impressions Heavy Duty Welded Shelving & Multimedia Storage Drawers	Christy Brittain	48994	-311.23	167.27	35	Newfoundland	Storage & Organization	0.85
\N	2785	252	Eric Murdock	51111	-257.72	65.99	5.92	Newfoundland	Telephones and Communication	0.55
\N	2786	StarTAC 3000	Paul Knutson	55425	963.68	125.99	7.69	Newfoundland	Telephones and Communication	0.59
\N	2787	Eldon Antistatic Chair Mats for Low to Medium Pile Carpets	Cynthia Voltz	55815	458.4	105.29	10.12	Newfoundland	Office Furnishings	0.79
\N	2788	Logitech Cordless Elite Duo	Janet Martin	55940	1041.29	100.98	7.18	Newfoundland	Computer Peripherals	0.4
\N	2789	Office Star Flex Back Scooter Chair with Aluminum Finish Frame	Nicole Brennan	56166	-62.19	100.89	42	Newfoundland	Chairs & Chairmats	0.61
\N	2790	Personal Creations™ Ink Jet Cards and Labels	Christy Brittain	57638	78.89	11.48	5.43	Newfoundland	Paper	0.36
\N	2791	Kleencut® Forged Office Shears by Acme United Corporation	Christy Brittain	57638	-85.58	2.08	2.56	Newfoundland	Scissors, Rulers and Trimmers	0.55
\N	2792	Eaton Premium Continuous-Feed Paper, 25% Cotton, Letter Size, White, 1000 Shts/Box	Jennifer Patt	57890	282.32	55.48	6.79	Newfoundland	Paper	0.37
\N	2793	Durable Pressboard Binders	Elpida Rittenbach	2244	21.47	3.8	1.49	Nova Scotia	Binders and Binder Accessories	0.38
\N	2794	Xerox 224	David Wiener	3104	-240.78	6.48	8.88	Nova Scotia	Paper	0.37
\N	2795	Boston 16701 Slimline Battery Pencil Sharpener	David Wiener	3104	7.29	15.94	5.45	Nova Scotia	Pens & Art Supplies	0.55
\N	2796	Staples #10 Laser & Inkjet Envelopes, 4 1/8" x 9 1/2", 100/Box	Elpida Rittenbach	6179	197.76	9.78	1.39	Nova Scotia	Envelopes	0.39
\N	2797	5125	Elpida Rittenbach	6179	234.61	200.99	8.08	Nova Scotia	Telephones and Communication	0.59
\N	2798	AT&T 2230 Dual Handset Phone With Caller ID/Call Waiting	David Wiener	11747	-261.55	99.99	19.99	Nova Scotia	Office Machines	0.52
\N	2799	Avery Trapezoid Extra Heavy Duty 4" Binders	David Wiener	11877	320.07	41.94	2.99	Nova Scotia	Binders and Binder Accessories	0.35
\N	2800	While You Were Out Pads, 50 per Pad, 4 x 5 1/4, Green Cycle	David Wiener	11877	33.59	4.73	1.52	Nova Scotia	Paper	0.36
\N	2801	SAFCO Folding Chair Trolley	Elpida Rittenbach	15271	589.38	128.24	12.65	Nova Scotia	Chairs & Chairmats	\N
\N	2802	Accessory13	Elpida Rittenbach	15271	-77.9	35.99	1.25	Nova Scotia	Telephones and Communication	0.57
\N	2803	Executive Impressions 12" Wall Clock	David Wiener	22561	-27.78	17.67	8.99	Nova Scotia	Office Furnishings	0.47
\N	2804	Staples 4 Outlet Surge Protector	David Wiener	22561	-19.77	8.67	3.5	Nova Scotia	Appliances	0.58
\N	2805	U.S. Robotics 56K Internet Call Modem	David Wiener	22561	-245.09	99.99	19.99	Nova Scotia	Computer Peripherals	0.5
\N	2806	Ames Color-File® Green Diamond Border X-ray Mailers	Elpida Rittenbach	25860	239.94	83.98	5.01	Nova Scotia	Envelopes	0.38
\N	2807	iDEN i95	Elpida Rittenbach	25860	-185.89	65.99	19.99	Nova Scotia	Telephones and Communication	0.59
\N	2808	Bagged Rubber Bands	Peter McVee	775	-19.17	1.26	0.7	Nova Scotia	Rubber Bands	0.81
\N	2809	Dixon Prang® Watercolor Pencils, 10-Color Set with Brush	Peter McVee	775	-1.25	4.26	1.2	Nova Scotia	Pens & Art Supplies	0.44
\N	2810	Avery Trapezoid Ring Binder, 3" Capacity, Black, 1040 sheets	Karen Carlisle	900	507.58	40.98	2.99	Nova Scotia	Binders and Binder Accessories	0.36
\N	2811	Peel-Off® China Markers	Stefania Perrino	964	-1.28	9.93	1.09	Nova Scotia	Pens & Art Supplies	0.43
\N	2812	TDK 4.7GB DVD-R Spindle, 15/Pack	Jay Fine	2722	807.62	40.97	1.99	Nova Scotia	Computer Peripherals	0.42
\N	2813	Hon 4070 Series Pagoda™ Armless Upholstered Stacking Chairs	Paul Lucas	3078	-187.29	291.73	48.8	Nova Scotia	Chairs & Chairmats	0.56
\N	2814	Global Adaptabilities™ Conference Tables	George Zrebassa	3456	332.3	280.98	35.67	Nova Scotia	Tables	0.66
\N	2815	Binder Posts	George Zrebassa	3556	-103.55	5.74	5.01	Nova Scotia	Binders and Binder Accessories	0.39
\N	2816	Soundgear Copyboard Conference Phone, Optional Battery	Karl Brown	3654	4031.62	204.1	13.99	Nova Scotia	Office Machines	0.37
\N	2817	Sanyo 2.5 Cubic Foot Mid-Size Office Refrigerators	Karl Brown	3654	3160.63	279.81	23.19	Nova Scotia	Appliances	0.59
\N	2818	Xerox 2	Evan Henry	3680	-61.75	6.48	6	Nova Scotia	Paper	0.37
\N	2819	Boston 19500 Mighty Mite Electric Pencil Sharpener	Keith Herrera	3942	-42.61	20.15	8.99	Nova Scotia	Pens & Art Supplies	0.58
\N	2820	Fellowes Staxonsteel® Drawer Files	Alyssa Tate	4162	-319.02	193.17	19.99	Nova Scotia	Storage & Organization	0.71
\N	2821	Imation DVD-RAM discs	Michael Stewart	4896	259.47	35.41	1.99	Nova Scotia	Computer Peripherals	0.43
\N	2822	i600	Michael Stewart	4896	-124.51	125.99	5.99	Nova Scotia	Telephones and Communication	0.56
\N	2823	Honeywell Enviracaire® Portable Air Cleaner for up to 8 x 10 Room	Paul Lucas	4965	56.05	76.72	19.95	Nova Scotia	Appliances	0.54
\N	2824	Dana Halogen Swing-Arm Architect Lamp	Shirley Jackson	5830	241.74	40.97	14.45	Nova Scotia	Office Furnishings	0.57
\N	2825	Belkin 105-Key Black Keyboard	Barry Weirich	6116	-72.23	19.98	4	Nova Scotia	Computer Peripherals	0.68
\N	3281	Unpadded Memo Slips	Noel Staavos	18562	-26.73	3.98	2.97	Quebec	Paper	0.35
\N	2826	Fellowes Black Plastic Comb Bindings	Natalie Webber	6695	-279.93	5.81	8.49	Nova Scotia	Binders and Binder Accessories	0.39
\N	2827	Hon Comfortask® Task/Swivel Chairs	Damala Kotsonis	6885	-181.27	113.98	30	Nova Scotia	Chairs & Chairmats	0.69
\N	2828	Acco Recycled 2" Capacity Laser Printer Hanging Data Binders	Karen Carlisle	7458	-5.37	14.45	7.17	Nova Scotia	Binders and Binder Accessories	0.38
\N	2829	Micro Innovations 104 Keyboard	Karen Carlisle	7458	-165.74	10.97	6.5	Nova Scotia	Computer Peripherals	0.64
\N	2830	Xerox 1964	Natalie Webber	8807	-6.04	22.84	11.54	Nova Scotia	Paper	0.39
\N	2831	V8162	Katherine Murray	9024	583.75	65.99	2.79	Nova Scotia	Telephones and Communication	0.56
\N	2832	Fuji Slim Jewel Case CD-R	Hunter Lopez	9602	-24.87	2.12	1.99	Nova Scotia	Computer Peripherals	0.55
\N	2833	Hon 4700 Series Mobuis™ Mid-Back Task Chairs with Adjustable Arms	Eric Barreto	9894	103.83	355.98	58.92	Nova Scotia	Chairs & Chairmats	0.64
\N	2834	Hon 61000 Series Interactive Training Tables	Barry Franz	10338	33.99	44.43	46.59	Nova Scotia	Tables	0.67
\N	2835	#10- 4 1/8" x 9 1/2" Recycled Envelopes	Fred McMath	11011	-129.86	8.74	8.29	Nova Scotia	Envelopes	0.38
\N	2836	Newell 337	Berenike Kampe	11271	-115.8	3.28	3.97	Nova Scotia	Pens & Art Supplies	0.56
\N	2837	Deluxe Rollaway Locking File with Drawer	Dean Percer	12005	-164.59	415.88	11.37	Nova Scotia	Storage & Organization	0.57
\N	2838	GBC DocuBind 200 Manual Binding Machine	Muhammed Lee	13284	3858.28	420.98	19.99	Nova Scotia	Binders and Binder Accessories	0.35
\N	2839	Vinyl Sectional Post Binders	Muhammed Lee	13284	674.99	37.7	2.99	Nova Scotia	Binders and Binder Accessories	0.35
\N	2840	Gould Plastics 9-Pocket Panel Bin, 18-3/8w x 5-1/4d x 20-1/2h, Black	Noel Staavos	13476	-121.39	52.99	19.99	Nova Scotia	Storage & Organization	0.81
\N	2841	StarTAC ST7762	Bobby Trafton	14182	355.93	125.99	8.08	Nova Scotia	Telephones and Communication	0.57
\N	2842	Airmail Envelopes	Rick Duston	14375	1110.35	83.93	19.99	Nova Scotia	Envelopes	0.38
\N	2843	Avery Hanging File Binders	Karl Brown	14528	11.02	5.98	1.49	Nova Scotia	Binders and Binder Accessories	0.39
\N	2844	Hammermill CopyPlus Copy Paper (20Lb. and 84 Bright)	Karl Brown	14662	-66.26	4.98	4.75	Nova Scotia	Paper	0.36
\N	2845	M70	Karl Brown	14662	1275.67	125.99	8.99	Nova Scotia	Telephones and Communication	0.59
\N	2846	Staples #10 Colored Envelopes	Erica Hernandez	15009	61.09	7.78	2.5	Nova Scotia	Envelopes	0.38
\N	2847	Acco® Hot Clips™ Clips to Go	Tony Molinari	15619	20.57	3.29	1.35	Nova Scotia	Rubber Bands	0.4
\N	2848	2180	Elizabeth Moffitt	15971	32.75	175.99	8.99	Nova Scotia	Telephones and Communication	0.57
\N	2849	Carina Double Wide Media Storage Towers in Natural & Black	Harold Dahlen	16036	-818.32	80.98	35	Nova Scotia	Storage & Organization	0.81
\N	2850	Sanford Colorific Colored Pencils, 12/Box	David Flashing	16452	9.34	2.88	1.01	Nova Scotia	Pens & Art Supplies	0.55
\N	2851	Lesro Sheffield Collection Coffee Table, End Table, Center Table, Corner Table	David Flashing	16548	-2595.65	71.37	69	Nova Scotia	Tables	0.68
\N	2852	3M Organizer Strips	Berenike Kampe	17408	-132.63	5.4	7.78	Nova Scotia	Binders and Binder Accessories	0.37
\N	2853	5180	Noel Staavos	17410	-247.24	65.99	8.99	Nova Scotia	Telephones and Communication	0.56
\N	2854	Kensington 7 Outlet MasterPiece® HOMEOFFICE Power Control Center	Deanra Eno	18849	50.83	131.12	0.99	Nova Scotia	Appliances	0.55
\N	2855	VTech VT20-2481 2.4GHz Two-Line Phone System w/Answering Machine	Fred McMath	19174	1142.08	179.99	13.99	Nova Scotia	Telephones and Communication	0.57
\N	2856	V8160	Fred McMath	19174	152.75	65.99	2.5	Nova Scotia	Telephones and Communication	0.56
\N	2857	Imation Neon 80 Minute CD-R Spindle, 50/Pack	Fred McMath	19174	665.63	33.98	1.99	Nova Scotia	Computer Peripherals	0.45
\N	2858	AT&T Black Trimline Phone, Model 210	Chuck Sachs	20098	-61.1	15.99	9.4	Nova Scotia	Office Machines	0.49
\N	2859	Computer Printout Paper with Letter-Trim Perforations	Chris Cortes	20711	-19.52	18.97	9.03	Nova Scotia	Paper	0.37
\N	2860	Avery Hi-Liter GlideStik Fluorescent Highlighter, Yellow Ink	Raymond Fair	20932	-4.73	3.26	1.86	Nova Scotia	Pens & Art Supplies	0.41
\N	2861	Canon PC940 Copier	Chuck Sachs	21319	-1042.71	449.99	49	Nova Scotia	Copiers and Fax	0.38
\N	2862	Deflect-o EconoMat Studded, No Bevel Mat for Low Pile Carpeting	Bobby Trafton	21344	171.07	41.32	8.66	Nova Scotia	Office Furnishings	0.76
\N	2863	Newell 343	Mark Packer	21538	-1.18	2.94	0.96	Nova Scotia	Pens & Art Supplies	0.58
\N	2864	Fuji Slim Jewel Case CD-R	Eric Barreto	21574	-37.2	2.12	1.99	Nova Scotia	Computer Peripherals	0.55
\N	2865	Xerox 1905	Noel Staavos	22242	-279.93	6.48	9.54	Nova Scotia	Paper	0.37
\N	2866	White Dual Perf Computer Printout Paper, 2700 Sheets, 1 Part, Heavyweight, 20 lbs., 14 7/8 x 11	Jay Fine	23078	-17.68	40.99	19.99	Nova Scotia	Paper	0.36
\N	2867	Hewlett-Packard Business Color Inkjet 3000 [N, DTN] Series Printers	Ann Blume	23271	-1748.34	808.49	55.3	Nova Scotia	Office Machines	0.4
\N	2868	Xerox 1991	Alan Shonely	23428	234.68	22.84	8.18	Nova Scotia	Paper	0.39
\N	2869	Eldon Expressions Mahogany Wood Desk Collection	Nora Paige	23619	-104.99	6.24	5.22	Nova Scotia	Office Furnishings	0.6
\N	2870	252	Nora Paige	23619	644.81	65.99	5.92	Nova Scotia	Telephones and Communication	0.55
\N	2871	Ibico Presentation Index for Binding Systems	Frank Atkinson	24067	-95.31	3.98	5.26	Nova Scotia	Binders and Binder Accessories	0.38
\N	2872	Trimflex™ Flexible Post Binders	Katrina Willman	25092	28.14	21.38	2.99	Nova Scotia	Binders and Binder Accessories	0.37
\N	2873	Assorted Color Push Pins	Katrina Willman	25092	-2.82	1.81	0.75	Nova Scotia	Rubber Bands	0.52
\N	2874	Newell 31	Stefania Perrino	25280	28.75	4.13	1.17	Nova Scotia	Pens & Art Supplies	0.57
\N	2875	Xerox 188	George Zrebassa	25442	67.6	11.34	5.01	Nova Scotia	Paper	0.36
\N	2876	Fellowes Strictly Business® Drawer File, Letter/Legal Size	Hunter Lopez	25666	369.46	140.85	19.99	Nova Scotia	Storage & Organization	0.73
\N	2877	Avery 487	Ann Blume	25669	15.42	3.69	0.5	Nova Scotia	Labels	0.38
\N	2878	Tenex Antistatic Computer Chair Mats	Janet Martin	26276	1040.62	170.98	13.99	Nova Scotia	Office Furnishings	0.75
\N	2879	Nu-Form 106-Key Ergonomic Keyboard w/ Touchpad	Noel Staavos	26912	55.87	53.98	5.5	Nova Scotia	Computer Peripherals	0.62
\N	2880	Accessory35	Alyssa Tate	27137	-165.54	35.99	1.1	Nova Scotia	Telephones and Communication	0.55
\N	2881	Letter or Legal Size Expandable Poly String Tie Envelopes	Karl Brown	27335	-100.6	2.66	6.35	Nova Scotia	Envelopes	0.36
\N	2882	Tenex 46" x 60" Computer Anti-Static Chairmat, Rectangular Shaped	Anthony Garverick	27430	278.6	105.98	13.99	Nova Scotia	Office Furnishings	0.65
\N	2883	Xerox 1933	Aaron Hawkins	27559	79.34	12.28	4.86	Nova Scotia	Paper	0.38
\N	2884	Tensor Computer Mounted Lamp	Mark Packer	29797	-337.98	14.89	13.56	Nova Scotia	Office Furnishings	0.58
\N	2885	Hewlett-Packard Deskjet 1220Cse Color Inkjet Printer	Giulietta Dortch	30023	3256.81	400.97	48.26	Nova Scotia	Office Machines	0.36
\N	2886	Honeywell Enviracaire® Portable Air Cleaner for up to 8 x 10 Room	Carlos Meador	31682	455.42	76.72	19.95	Nova Scotia	Appliances	0.54
\N	2887	Avanti 1.7 Cu. Ft. Refrigerator	Damala Kotsonis	31845	807.29	100.98	15.66	Nova Scotia	Appliances	0.57
\N	2888	Zoom V.92 V.44 PCI Internal Controllerless FaxModem	Dave Poirier	32389	-7.5	39.99	10.25	Nova Scotia	Computer Peripherals	0.55
\N	2889	Imation 3.5, DISKETTE 44766 HGHLD3.52HD/FM, 10/Pack	Christy Brittain	32420	-168.72	5.02	5.14	Nova Scotia	Computer Peripherals	0.79
\N	2890	Rogers® Profile Extra Capacity Storage Tub	Troy Staebel	33699	-114.2	16.74	7.04	Nova Scotia	Storage & Organization	0.81
\N	2891	Wirebound Four 2-3/4 x 5 Forms per Page, 400 Sets per Book	Troy Staebel	33699	70.39	6.45	1.34	Nova Scotia	Paper	0.36
\N	2892	Panasonic KX-P3200 Dot Matrix Printer	Bradley Drucker	33797	653.68	297.64	14.7	Nova Scotia	Office Machines	0.57
\N	2893	Tensor "Hersey Kiss" Styled Floor Lamp	Bradley Drucker	33797	-449.04	12.99	14.37	Nova Scotia	Office Furnishings	0.73
\N	2894	Holmes Odor Grabber	Bradley Drucker	33797	-22.37	14.42	6.75	Nova Scotia	Appliances	0.52
\N	2895	Accessory39	Mark Haberlin	33958	-120.05	20.99	3.3	Nova Scotia	Telephones and Communication	0.81
\N	2896	BOSTON® Ranger® #55 Pencil Sharpener, Black	Mark Haberlin	33958	5.56	25.99	5.37	Nova Scotia	Pens & Art Supplies	0.56
\N	2897	Iris Project Case	Anthony Garverick	36454	-36.06	7.98	6.5	Nova Scotia	Storage & Organization	0.59
\N	2898	Xerox 1952	Brad Thomas	36609	-23.29	4.98	5.49	Nova Scotia	Paper	0.38
\N	2899	Belkin 6 Outlet Metallic Surge Strip	Barry Franz	36800	-7.04	10.89	4.5	Nova Scotia	Appliances	0.59
\N	2900	G.E. Longer-Life Indoor Recessed Floodlight Bulbs	Brad Thomas	37287	2.37	6.64	4.95	Nova Scotia	Office Furnishings	0.37
\N	2901	Belkin 8 Outlet SurgeMaster II Gold Surge Protector	Mark Packer	37443	840.55	59.98	3.99	Nova Scotia	Appliances	0.57
\N	2902	Avery 501	Eleni McCrary	37792	82.49	3.69	0.5	Nova Scotia	Labels	0.38
\N	2903	#10- 4 1/8" x 9 1/2" Recycled Envelopes	Eleni McCrary	37829	-84.69	8.74	8.29	Nova Scotia	Envelopes	0.38
\N	2904	Zoom V.92 USB External Faxmodem	Ann Blume	38087	-76.89	49.99	19.99	Nova Scotia	Computer Peripherals	0.41
\N	2905	Accessory25	Brendan Murry	38341	122.29	20.99	0.99	Nova Scotia	Telephones and Communication	0.57
\N	2906	Tennsco Regal Shelving Units	Chuck Sachs	38599	-741.81	101.41	35	Nova Scotia	Storage & Organization	0.82
\N	2907	G.E. Longer-Life Indoor Recessed Floodlight Bulbs	Troy Staebel	38721	-25	6.64	54.95	Nova Scotia	Office Furnishings	0.37
\N	2908	Tyvek® Side-Opening Peel & Seel® Expanding Envelopes	Troy Staebel	38721	363	90.48	19.99	Nova Scotia	Envelopes	0.4
\N	2909	Canon PC940 Copier	Paul Knutson	38976	358.19	449.99	49	Nova Scotia	Copiers and Fax	0.38
\N	2910	Eureka Disposable Bags for Sanitaire® Vibra Groomer I® Upright Vac	Emily Burns	39300	-43.48	4.06	6.89	Nova Scotia	Appliances	0.6
\N	2911	Sharp EL501VB Scientific Calculator, Battery Operated, 10-Digit Display, Hard Case	Troy Staebel	39393	-32.43	9.49	5.76	Nova Scotia	Office Machines	0.39
\N	2912	Deflect-o EconoMat Studded, No Bevel Mat for Low Pile Carpeting	Chris Cortes	39842	114.45	41.32	8.66	Nova Scotia	Office Furnishings	0.76
\N	2913	GBC Recycled Grain Textured Covers	Stefania Perrino	41766	10.06	34.54	14.72	Nova Scotia	Binders and Binder Accessories	0.37
\N	2914	Belkin 8 Outlet Surge Protector	Maureen Gastineau	42306	146.79	40.98	5.33	Nova Scotia	Appliances	0.57
\N	2915	Xerox 1880	Alex Grayson	42528	47.65	35.44	19.99	Nova Scotia	Paper	0.38
\N	2916	Portfile® Personal File Boxes	Alex Grayson	42528	-43.52	17.7	9.47	Nova Scotia	Storage & Organization	0.59
\N	2917	Memorex Slim 80 Minute CD-R, 10/Pack	Alex Grayson	42528	81.87	9.78	1.99	Nova Scotia	Computer Peripherals	0.43
\N	2918	Phone 918	Damala Kotsonis	43302	1925.58	205.99	5	Nova Scotia	Telephones and Communication	0.59
\N	2919	Tenex File Box, Personal Filing Tote with Lid, Black	Carlos Meador	43813	-266.22	15.51	17.78	Nova Scotia	Storage & Organization	0.59
\N	2920	Array® Memo Cubes	Frank Atkinson	44292	-3.78	5.18	2.04	Nova Scotia	Paper	0.36
\N	2921	Hoover Replacement Belt for Commercial Guardsman Heavy-Duty Upright Vacuum	Deanra Eno	44583	-19.74	2.22	5	Nova Scotia	Appliances	0.55
\N	2922	Eldon Wave Desk Accessories	Michael Oakman	45381	-7.95	5.89	5.57	Nova Scotia	Office Furnishings	0.41
\N	2923	Hon 4060 Series Tables	Chuck Sachs	46531	-270.57	111.96	69	Nova Scotia	Tables	0.63
\N	2924	Tuff Stuff™ Recycled Round Ring Binders	Deborah Brumfield	47136	18.96	4.82	1.49	Nova Scotia	Binders and Binder Accessories	0.36
\N	2925	Xerox 1923	Dianna Arnett	47813	-76.94	6.68	5.66	Nova Scotia	Paper	0.37
\N	2926	Xerox 1920	Alex Grayson	48263	-124.72	5.98	7.5	Nova Scotia	Paper	0.4
\N	2927	Fiskars® Softgrip Scissors	Amy Cox	48455	-3.18	10.98	3.37	Nova Scotia	Scissors, Rulers and Trimmers	0.57
\N	2928	Array® Parchment Paper, Assorted Colors	Erica Hernandez	48706	-130.96	7.28	11.15	Nova Scotia	Paper	0.37
\N	2929	Xerox 1938	Sara Luxemburg	48929	939.67	47.9	5.86	Nova Scotia	Paper	0.37
\N	2930	Eureka Recycled Copy Paper 8 1/2" x 11", Ream	David Flashing	48963	-31.14	6.48	5.94	Nova Scotia	Paper	0.37
\N	2931	Xerox 1961	Deanra Eno	49312	-128.52	4.98	7.54	Nova Scotia	Paper	0.38
\N	2932	Memorex Slim 80 Minute CD-R, 10/Pack	Robert Barroso	49472	12.09	9.78	1.99	Nova Scotia	Computer Peripherals	0.43
\N	2933	Acco® Hot Clips™ Clips to Go	Robert Barroso	49472	0.08	3.29	1.35	Nova Scotia	Rubber Bands	0.4
\N	2934	Avery Hanging File Binders	Darrin Sayre	49891	80.73	5.98	1.49	Nova Scotia	Binders and Binder Accessories	0.39
\N	2935	Durable Pressboard Binders	Sara Luxemburg	49984	7.31	3.8	1.49	Nova Scotia	Binders and Binder Accessories	0.38
\N	2936	Xerox 212	Sara Luxemburg	49984	-130.61	6.48	8.4	Nova Scotia	Paper	0.37
\N	2937	Hon GuestStacker Chair	Deborah Brumfield	50471	1358.53	226.67	28.16	Nova Scotia	Chairs & Chairmats	0.59
\N	2938	Chromcraft Bull-Nose Wood Oval Conference Tables & Bases	Eleni McCrary	51203	3146.22	550.98	45.7	Nova Scotia	Tables	0.71
\N	2939	Master Giant Foot® Doorstop, Safety Yellow	Eleni McCrary	51233	20.12	7.59	4	Nova Scotia	Office Furnishings	0.42
\N	2940	Acco Recycled 2" Capacity Laser Printer Hanging Data Binders	Alyssa Tate	52195	-2.83	14.45	7.17	Nova Scotia	Binders and Binder Accessories	0.38
\N	2941	GBC Imprintable Covers	Michael Kennedy	53123	14	10.98	5.14	Nova Scotia	Binders and Binder Accessories	0.36
\N	2942	Wilson Jones Hanging View Binder, White, 1"	Marc Crier	54533	-42.72	7.1	6.05	Nova Scotia	Binders and Binder Accessories	0.39
\N	2943	Crayola Colored Pencils	Bobby Elias	55139	9.32	3.28	0.98	Nova Scotia	Pens & Art Supplies	0.52
\N	2944	SANFORD Liquid Accent™ Tank-Style Highlighters	Christy Brittain	55392	3.21	2.84	0.93	Nova Scotia	Pens & Art Supplies	0.54
\N	2945	Imation 3.5" DS/HD IBM Formatted Diskettes, 10/Pack	Joni Wasserman	55616	-102.25	5.98	4.38	Nova Scotia	Computer Peripherals	0.75
\N	2946	Ibico EB-19 Dual Function Manual Binding System	Karen Ferguson	55909	-93.83	172.99	19.99	Nova Scotia	Binders and Binder Accessories	0.39
\N	2947	Safco Industrial Wire Shelving	Mark Haberlin	55938	-468.89	95.99	35	Nova Scotia	Storage & Organization	\N
\N	2948	Holmes Odor Grabber	Nicole Brennan	56166	-54.34	14.42	6.75	Nova Scotia	Appliances	0.52
\N	2949	Avery 51	Sara Luxemburg	56515	60.79	6.3	0.5	Nova Scotia	Labels	0.39
\N	2950	Newell 335	Giulietta Dortch	56768	20.06	2.88	0.7	Nova Scotia	Pens & Art Supplies	0.56
\N	2951	Advantus SlideClip™ Paper Clips	Bradley Talbott	56900	16.11	3.41	0.7	Nova Scotia	Rubber Bands	0.37
\N	2952	KI Conference Tables	Bradley Talbott	57056	-2897.25	70.89	89.3	Nova Scotia	Tables	0.72
\N	2953	4009® Highlighters by Sanford	Brian Stugart	58372	43.2	3.98	0.7	Nova Scotia	Pens & Art Supplies	0.52
\N	2954	Panasonic KX-P3626 Dot Matrix Printer	Deborah Brumfield	59270	8788.81	517.48	16.63	Nova Scotia	Office Machines	0.59
\N	2955	Letter Size Cart	Deborah Brumfield	59270	453.03	142.86	19.99	Nova Scotia	Storage & Organization	0.56
\N	2956	Universal Premium White Copier/Laser Paper (20Lb. and 87 Bright)	Maureen Gastineau	59619	-47.55	5.98	7.15	Nova Scotia	Paper	0.36
\N	2957	Office Star - Ergonomic Mid Back Chair with 2-Way Adjustable Arms	Julia Barnett	59781	329.28	180.98	30	Nova Scotia	Chairs & Chairmats	0.69
\N	2958	O'Sullivan Elevations Bookcase, Cherry Finish	Emily Phan	132	-603.8	130.98	54.74	Nova Scotia	Bookcases	0.69
\N	2959	Xerox 1984	Liz Willingham	258	-91.14	6.48	8.74	Nova Scotia	Paper	0.36
\N	2960	Tennsco Lockers, Gray	Liz Willingham	258	-284.4	20.98	53.03	Nova Scotia	Storage & Organization	0.78
\N	2961	282	Craig Yedwab	325	-178.71	115.99	4.23	Nova Scotia	Telephones and Communication	0.56
\N	2962	Canon PC1060 Personal Laser Copier	Noel Staavos	1444	8249.86	699.99	24.49	Nova Scotia	Copiers and Fax	0.41
\N	2963	Xerox 1893	Andy Reiter	2084	94.97	40.99	17.48	Nova Scotia	Paper	0.36
\N	2964	Avery Hi-Liter GlideStik Fluorescent Highlighter, Yellow Ink	Ben Peterman	3332	-3.51	3.26	1.86	Nova Scotia	Pens & Art Supplies	0.41
\N	2965	Belkin 105-Key Black Keyboard	Alex Grayson	3397	-20.25	19.98	4	Nova Scotia	Computer Peripherals	0.68
\N	2966	SAFCO Folding Chair Trolley	George Zrebassa	3556	1161.89	128.24	12.65	Nova Scotia	Chairs & Chairmats	\N
\N	2967	Self-Adhesive Removable Labels	Denise Leinenbach	3589	28.55	3.15	0.49	Nova Scotia	Labels	0.37
\N	2968	Global Push Button Manager's Chair, Indigo	Muhammed Lee	3905	-377.25	60.89	32.41	Nova Scotia	Chairs & Chairmats	0.56
\N	2969	DMI Eclipse Executive Suite Bookcases	Bill Tyler	4033	4127.79	500.98	41.44	Nova Scotia	Bookcases	0.66
\N	2970	Accessory6	Carlos Meador	4647	-57.54	55.99	5	Nova Scotia	Telephones and Communication	0.8
\N	2971	Peel & Seel® Recycled Catalog Envelopes, Brown	Liz Willingham	4773	34.12	11.58	5.72	Nova Scotia	Envelopes	0.35
\N	2972	Rogers Handheld Barrel Pencil Sharpener	Evan Henry	5189	-21.47	2.74	3.5	Nova Scotia	Pens & Art Supplies	0.58
\N	2973	Wirebound Service Call Books, 5 1/2" x 4"	Denise Leinenbach	5510	29.68	9.68	2.03	Nova Scotia	Paper	0.37
\N	2974	Chromcraft Bull-Nose Wood Oval Conference Tables & Bases	Denise Leinenbach	6369	545.7	550.98	45.7	Nova Scotia	Tables	0.71
\N	2975	Tripp Lite Isotel 6 Outlet Surge Protector with Fax/Modem Protection	Denise Leinenbach	6373	-36.84	60.97	4.5	Nova Scotia	Appliances	0.56
\N	2976	Adams Phone Message Book, 200 Message Capacity, 8 1/16” x 11”	Alan Shonely	6465	57.78	6.88	2	Nova Scotia	Paper	0.39
\N	2977	TI 36X Solar Scientific Calculator	Damala Kotsonis	6885	166.93	23.99	6.3	Nova Scotia	Office Machines	0.38
\N	2978	Bretford CR8500 Series Meeting Room Furniture	Debra Catini	7297	-969.05	400.98	76.37	Nova Scotia	Tables	0.6
\N	2979	Wirebound Message Book, 4 per Page	Raymond Fair	7367	119.64	5.43	0.95	Nova Scotia	Paper	0.36
\N	2980	Global Deluxe Office Fabric Chairs	Ann Blume	7751	-768.14	95.98	58.2	Nova Scotia	Chairs & Chairmats	0.58
\N	2981	Hon 94000 Series Round Tables	Becky Martin	8422	-715.78	296.18	54.12	Nova Scotia	Tables	0.76
\N	2982	Staples Vinyl Coated Paper Clips	Eric Barreto	9062	30.61	3.93	0.99	Nova Scotia	Rubber Bands	0.39
\N	2983	Avery Printable Repositionable Plastic Tabs	Barry Franz	10209	-60.21	8.6	6.19	Nova Scotia	Binders and Binder Accessories	0.38
\N	2984	Avery Durable Poly Binders	Astrea Jones	10245	-108.13	5.53	6.98	Nova Scotia	Binders and Binder Accessories	0.39
\N	2985	SAFCO Commercial Wire Shelving, Black	Peter McVee	11008	-321.51	138.14	35	Nova Scotia	Storage & Organization	\N
\N	2986	Belkin 107-key enhanced keyboard, USB/PS/2 interface	Chuck Sachs	11585	-99.55	17.98	4	Nova Scotia	Computer Peripherals	0.79
\N	2987	Avery 506	Corey Catlett	13472	42.89	4.13	0.5	Nova Scotia	Labels	0.39
\N	2988	Advantus Push Pins	Dave Poirier	14114	-7.04	2.18	1.38	Nova Scotia	Rubber Bands	0.44
\N	2989	Tripp Lite Isotel 8 Ultra 8 Outlet Metal Surge	Bobby Trafton	14727	630.18	70.97	3.5	Nova Scotia	Appliances	0.59
\N	2990	T193	Benjamin Venier	15399	601.65	65.99	4.99	Nova Scotia	Telephones and Communication	0.57
\N	2991	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Tony Molinari	15619	-65.02	160.98	30	Nova Scotia	Chairs & Chairmats	0.62
\N	2992	V3682	Benjamin Venier	16194	315.49	125.99	4.2	Nova Scotia	Telephones and Communication	0.59
\N	2993	Accessory9	Nora Paige	16229	143.79	35.99	3.3	Nova Scotia	Telephones and Communication	0.39
\N	2994	Bevis 36 x 72 Conference Tables	Nora Paige	16231	-500.46	124.49	51.94	Nova Scotia	Tables	0.63
\N	2995	Belkin F9M820V08 8 Outlet Surge	Robert Barroso	16674	467.72	42.98	4.62	Nova Scotia	Appliances	0.56
\N	2996	Hon 4700 Series Mobuis™ Mid-Back Task Chairs with Adjustable Arms	Robert Barroso	16674	2177.54	355.98	58.92	Nova Scotia	Chairs & Chairmats	0.64
\N	2997	Panasonic KX-P1150 Dot Matrix Printer	Alex Grayson	16710	1300.8	145.45	17.85	Nova Scotia	Office Machines	0.56
\N	2998	1726 Digital Answering Machine	Berenike Kampe	17408	49.79	20.99	4.81	Nova Scotia	Telephones and Communication	0.58
\N	2999	8260	Michael Kennedy	17698	-59.59	65.99	8.99	Nova Scotia	Telephones and Communication	0.58
\N	3000	Recycled Premium Regency Composition Covers	Michael Kennedy	17698	-89.23	15.28	10.91	Nova Scotia	Binders and Binder Accessories	0.36
\N	3001	80 Minute Slim Jewel Case CD-R , 10/Pack - Staples	Tracy Poddar	18534	21.68	8.33	1.99	Nova Scotia	Computer Peripherals	0.52
\N	3002	Unpadded Memo Slips	Astrea Jones	18951	-16.27	3.98	2.97	Nova Scotia	Paper	0.35
\N	3003	Accessory27	Astrea Jones	18951	-169.74	35.99	5	Nova Scotia	Telephones and Communication	0.85
\N	3004	Storex DuraTech Recycled Plastic Frosted Binders	Fred McMath	19174	-151.42	4.24	5.41	Nova Scotia	Binders and Binder Accessories	0.35
\N	3005	Executive Impressions 14" Two-Color Numerals Wall Clock	Chuck Sachs	20098	87.66	22.72	8.99	Nova Scotia	Office Furnishings	0.44
\N	3006	Super Decoflex Portable Personal File	Chuck Sachs	21319	-40.94	14.98	7.69	Nova Scotia	Storage & Organization	0.57
\N	3007	Westinghouse Floor Lamp with Metal Mesh Shade, Black	Chuck Sachs	21319	-174.94	23.99	15.68	Nova Scotia	Office Furnishings	0.62
\N	3008	Panasonic KX-P1150 Dot Matrix Printer	Eric Barreto	22115	-283.94	145.45	17.85	Nova Scotia	Office Machines	0.56
\N	3009	Sanford Colorific Colored Pencils, 12/Box	Bobby Trafton	22149	-1.62	2.88	1.01	Nova Scotia	Pens & Art Supplies	0.55
\N	3010	Astroparche® Fine Business Paper	Bill Tyler	22338	-62.97	5.28	5.06	Nova Scotia	Paper	0.37
\N	3011	Howard Miller 16" Diameter Gallery Wall Clock	Bill Shonely	22627	614.03	63.94	14.48	Nova Scotia	Office Furnishings	0.46
\N	3012	Staples Vinyl Coated Paper Clips, 800/Box	Craig Yedwab	22820	21.49	7.89	2.82	Nova Scotia	Rubber Bands	0.4
\N	3013	BASF Silver 74 Minute CD-R	Bradley Talbott	22880	-20.68	1.7	1.99	Nova Scotia	Computer Peripherals	0.51
\N	3014	Acme Galleria® Hot Forged Steel Scissors with Colored Handles	Jay Fine	23078	-86.43	15.73	7.42	Nova Scotia	Scissors, Rulers and Trimmers	0.56
\N	3015	Xerox 1937	Pierre Wener	23268	41.41	48.04	5.79	Nova Scotia	Paper	0.37
\N	3016	Accessory41	Dan Campbell	24003	-116.51	35.99	5.99	Nova Scotia	Telephones and Communication	0.38
\N	3017	Companion Letter/Legal File, Black	Fred McMath	24102	47.58	37.76	12.9	Nova Scotia	Storage & Organization	0.57
\N	3018	Bevis Round Conference Table Top, X-Base	Craig Yedwab	24422	-433.29	179.29	29.21	Nova Scotia	Tables	0.76
\N	3019	Global High-Back Leather Tilter, Burgundy	Tony Molinari	24644	-1764.29	122.99	70.2	Nova Scotia	Chairs & Chairmats	0.74
\N	3020	GBC DocuBind 200 Manual Binding Machine	Dave Poirier	26401	-199.31	420.98	19.99	Nova Scotia	Binders and Binder Accessories	0.35
\N	3021	Xerox 1951	Noel Staavos	27938	308.67	30.98	9.18	Nova Scotia	Paper	0.4
\N	3022	Imation 3.5 IBM Formatted Diskettes, 10/Box	Frank Atkinson	28515	-71.59	8.32	2.38	Nova Scotia	Computer Peripherals	0.74
\N	3023	Maxell 4.7GB DVD-R	Bill Shonely	29280	248.91	28.38	1.99	Nova Scotia	Computer Peripherals	0.51
\N	3024	Peel & Seel® Recycled Catalog Envelopes, Brown	Janet Martin	29346	-16.15	11.58	6.97	Nova Scotia	Envelopes	0.35
\N	3025	6000	Bobby Trafton	29349	772.11	65.99	2.5	Nova Scotia	Telephones and Communication	0.55
\N	3026	Bell Sonecor JB700 Caller ID	Katrina Willman	29473	-111.98	7.99	5.03	Nova Scotia	Telephones and Communication	0.6
\N	3027	Tennsco Double-Tier Lockers	Michael Paige	29893	426.67	225.02	28.66	Nova Scotia	Storage & Organization	0.72
\N	3028	Boston 1730 StandUp Electric Pencil Sharpener	Giulietta Dortch	30023	19.73	21.38	8.99	Nova Scotia	Pens & Art Supplies	0.59
\N	3029	T28 WORLD	Cathy Hwang	30215	349.47	195.99	8.99	Nova Scotia	Telephones and Communication	0.6
\N	3030	Electrix Architect's Clamp-On Swing Arm Lamp, Black	Bill Shonely	30720	656.95	95.46	18.13	Nova Scotia	Office Furnishings	0.56
\N	3031	BPI Conference Tables	Carlos Meador	30884	-352.96	146.05	80.2	Nova Scotia	Tables	0.71
\N	3032	Avery Hanging File Binders	Dianna Arnett	31303	87.6	5.98	1.49	Nova Scotia	Binders and Binder Accessories	0.39
\N	3033	Xerox 1985	George Zrebassa	31392	-42.81	6.48	5.16	Nova Scotia	Paper	0.37
\N	3034	Newell 339	Mark Haberlin	31715	-4.09	2.78	0.97	Nova Scotia	Pens & Art Supplies	0.59
\N	3035	Hon 2090 “Pillow Soft” Series Mid Back Swivel/Tilt Chairs	Christy Brittain	32420	-439.62	280.98	57	Nova Scotia	Chairs & Chairmats	0.78
\N	3036	Unpadded Memo Slips	Michael Paige	32965	-5.54	3.98	2.97	Nova Scotia	Paper	0.35
\N	3037	Accessory9	Katherine Murray	33253	127.85	35.99	3.3	Nova Scotia	Telephones and Communication	0.39
\N	3038	Anderson Hickey Conga Table Tops & Accessories	Ben Peterman	33959	11.65	15.23	27.75	Nova Scotia	Tables	0.76
\N	3039	5180	Dean Percer	35271	64.53	65.99	8.99	Nova Scotia	Telephones and Communication	0.56
\N	3040	M70	Sylvia Foulston	36390	-541.33	125.99	8.99	Nova Scotia	Telephones and Communication	0.59
\N	3041	Fellowes Black Plastic Comb Bindings	Noel Staavos	37447	-137.49	5.81	8.49	Nova Scotia	Binders and Binder Accessories	0.39
\N	3042	Cardinal Poly Pocket Divider Pockets for Ring Binders	Brendan Murry	38341	-67.06	3.36	6.27	Nova Scotia	Binders and Binder Accessories	0.4
\N	3043	Xerox 1933	Brendan Murry	38341	-7.94	12.28	4.86	Nova Scotia	Paper	0.38
\N	3044	Fellowes Bankers Box™ Staxonsteel® Drawer File/Stacking System	Pierre Wener	38723	368.87	64.98	6.88	Nova Scotia	Storage & Organization	0.73
\N	3045	Accohide Poly Flexible Ring Binders	Brad Thomas	38851	-5.74	3.74	4.69	Nova Scotia	Binders and Binder Accessories	0.35
\N	3046	Xerox 1888	Hunter Lopez	38882	1043.43	55.48	4.85	Nova Scotia	Paper	0.37
\N	3047	Park Ridge™ Embossed Executive Business Envelopes	Dan Campbell	39266	3.72	15.57	1.39	Nova Scotia	Envelopes	0.38
\N	3048	Tenex B1-RE Series Chair Mats for Low Pile Carpets	Chuck Sachs	39780	569.08	45.98	4.8	Nova Scotia	Office Furnishings	0.68
\N	3049	StarTAC 7760	Chris Cortes	39842	224.86	65.99	3.99	Nova Scotia	Telephones and Communication	0.59
\N	3050	Tenex B1-RE Series Chair Mats for Low Pile Carpets	Mark Packer	40005	244.45	45.98	4.8	Nova Scotia	Office Furnishings	0.68
\N	3051	Newell 310	Julie Kriz	40704	-2.06	1.76	0.7	Nova Scotia	Pens & Art Supplies	0.56
\N	3631	i500plus	Dennis Kane	24231	421.89	65.99	5.92	Quebec	Telephones and Communication	0.58
\N	3052	Avery Trapezoid Extra Heavy Duty 4" Binders	Fred McMath	41383	620.07	41.94	2.99	Nova Scotia	Binders and Binder Accessories	0.35
\N	3053	Rediform Wirebound "Phone Memo" Message Book, 11 x 5-3/4	Debra Catini	41415	-20.16	7.64	5.83	Nova Scotia	Paper	0.36
\N	3054	Global Leather & Oak Executive Chair, Burgundy	Sylvia Foulston	41825	-1303.6	150.89	60.2	Nova Scotia	Chairs & Chairmats	0.77
\N	3055	DAX Solid Wood Frames	Chuck Sachs	41826	40.63	9.77	6.02	Nova Scotia	Office Furnishings	0.48
\N	3056	Avery 494	Ann Blume	42213	35.92	2.61	0.5	Nova Scotia	Labels	0.39
\N	3057	GBC VeloBinder Electric Binding Machine	Muhammed Yedwab	42469	818.92	120.98	9.07	Nova Scotia	Binders and Binder Accessories	0.35
\N	3058	Accessory21	Damala Kotsonis	43302	329.68	20.99	0.99	Nova Scotia	Telephones and Communication	0.37
\N	3059	Chromcraft Rectangular Conference Tables	Jennifer Patt	43588	-572.69	236.97	59.24	Nova Scotia	Tables	0.61
\N	3060	Xerox 1927	Dan Campbell	44000	-75.31	4.28	6.72	Nova Scotia	Paper	0.4
\N	3061	Binder Posts	Michael Oakman	45381	-41.22	5.74	5.01	Nova Scotia	Binders and Binder Accessories	0.39
\N	3062	Nu-Form 106-Key Ergonomic Keyboard w/ Touchpad	Michael Oakman	45381	204.7	53.98	5.5	Nova Scotia	Computer Peripherals	0.62
\N	3063	Avery File Folder Labels	Keith Herrera	45728	-37.55	2.88	5.33	Nova Scotia	Labels	0.36
\N	3064	Newell 343	Janet Martin	45984	2.49	2.94	0.96	Nova Scotia	Pens & Art Supplies	0.58
\N	3065	Eldon ClusterMat Chair Mat with Cordless Antistatic Protection	David Kendrick	45988	-1570.32	90.98	56.2	Nova Scotia	Office Furnishings	0.74
\N	3066	BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	Rick Duston	46177	-528.65	218.75	69.64	Nova Scotia	Tables	0.77
\N	3067	3285	Becky Martin	47106	1489.96	205.99	5.99	Nova Scotia	Telephones and Communication	0.59
\N	3068	8860	Doug Jacobs	47169	-19.97	65.99	5.26	Nova Scotia	Telephones and Communication	0.56
\N	3069	Nu-Dell Executive Frame	Emily Burns	48071	-13.59	12.64	4.98	Nova Scotia	Office Furnishings	0.48
\N	3070	Tenex Contemporary Contur Chairmats for Low and Medium Pile Carpet, Computer, 39" x 49"	Deanra Eno	49312	336.26	107.53	5.81	Nova Scotia	Office Furnishings	0.65
\N	3071	Newell 336	Robert Barroso	49472	17.89	4.28	0.94	Nova Scotia	Pens & Art Supplies	0.56
\N	3072	Avery 508	Darrin Sayre	49891	35.5	4.91	0.5	Nova Scotia	Labels	0.36
\N	3073	Newell 309	Bradley Talbott	50276	71.03	11.55	2.36	Nova Scotia	Pens & Art Supplies	0.55
\N	3074	Trimflex™ Flexible Post Binders	Luke Foster	51107	286.87	21.38	2.99	Nova Scotia	Binders and Binder Accessories	0.37
\N	3075	Bevis Round Conference Table Top, X-Base	Brian Stugart	51783	-433.29	179.29	29.21	Nova Scotia	Tables	0.74
\N	3076	Westinghouse Clip-On Gooseneck Lamps	Carlos Meador	52006	-241.63	8.37	10.16	Nova Scotia	Office Furnishings	0.59
\N	3077	Avery 508	Sara Luxemburg	52934	36.98	4.91	0.5	Nova Scotia	Labels	0.36
\N	3078	Accessory6	Alex Grayson	54053	-230.34	55.99	5	Nova Scotia	Telephones and Communication	0.8
\N	3079	Xerox 23	Joni Wasserman	55239	-15.27	6.48	5.14	Nova Scotia	Paper	0.37
\N	3080	Filing/Storage Totes and Swivel Casters	Paul Knutson	55425	-52.49	9.71	9.45	Nova Scotia	Storage & Organization	0.6
\N	3081	O'Sullivan 3-Shelf Heavy-Duty Bookcases	Sara Luxemburg	56515	-362.04	58.14	36.61	Nova Scotia	Bookcases	0.61
\N	3082	Chromcraft Bull-Nose Wood Round Conference Table Top, Wood Base	Christy Brittain	57638	-526.48	217.85	29.1	Nova Scotia	Tables	0.68
\N	3083	Hon Comfortask® Task/Swivel Chairs	Dianna Wilson	58599	-219.2	113.98	30	Nova Scotia	Chairs & Chairmats	0.69
\N	3084	Imation Primaris 3.5" 2HD Unformatted Diskettes, 10/Pack	David Smith	59075	-25.31	4.77	2.39	Nova Scotia	Computer Peripherals	0.72
\N	3085	Memorex 4.7GB DVD-RAM, 3/Pack	Deborah Brumfield	59270	749.03	31.78	1.99	Nova Scotia	Computer Peripherals	0.42
\N	3086	DXL™ Angle-View Binders with Locking Rings, Black	Michelle Tran	326	-44.14	5.99	4.92	Quebec	Binders and Binder Accessories	0.38
\N	3087	Advantus Push Pins, Aluminum Head	Michelle Tran	326	-21.3	5.81	3.37	Quebec	Rubber Bands	0.54
\N	3088	Nu-Dell Leatherette Frames	Dave Hallsten	614	163.81	14.34	5	Quebec	Office Furnishings	0.49
\N	3089	Balt Split Level Computer Training Table	Dave Hallsten	614	-335.32	138.75	52.42	Quebec	Tables	0.74
\N	3090	Logitech Access Keyboard	Sanjit Jacobs	898	45.39	15.98	6.5	Quebec	Computer Peripherals	0.48
\N	3091	Hon 94000 Series Round Tables	Sanjit Jacobs	898	-715.78	296.18	54.12	Quebec	Tables	0.76
\N	3092	C-Line Peel & Stick Add-On Filing Pockets, 8-3/4 x 5-1/8, 10/Pack	Sanjit Jacobs	1031	-52.21	6.37	5.19	Quebec	Binders and Binder Accessories	0.38
\N	3093	SC-3160	Barry Gonzalez	1447	239.4	65.99	8.99	Quebec	Telephones and Communication	0.59
\N	3094	Bevis Round Conference Table Top, X-Base	Vivian Mathis	2150	55.3	179.29	29.21	Quebec	Tables	0.76
\N	3095	Keytronic 105-Key Spanish Keyboard	Vivian Mathis	2211	-2.38	73.98	12.14	Quebec	Computer Peripherals	0.67
\N	3096	Universal Premium White Copier/Laser Paper (20Lb. and 87 Bright)	Vivian Mathis	2211	-46.31	5.98	7.15	Quebec	Paper	0.36
\N	3097	Barrel Sharpener	Vivian Mathis	2211	-71.11	3.57	4.17	Quebec	Pens & Art Supplies	0.59
\N	3098	Avery Hanging File Binders	Carol Adams	2307	40.85	5.98	1.49	Quebec	Binders and Binder Accessories	0.39
\N	3099	Rubbermaid ClusterMat Chairmats, Mat Size- 66" x 60", Lip 20" x 11" -90 Degree Angle	Sanjit Jacobs	2370	-85.76	110.98	13.99	Quebec	Office Furnishings	0.69
\N	3100	TOPS Money Receipt Book, Consecutively Numbered in Red,	Sanjit Jacobs	2370	59.18	8.01	2.87	Quebec	Paper	0.4
\N	3101	Avery Round Ring Poly Binders	Vivek Gonzalez	2374	-72.7	2.84	5.44	Quebec	Binders and Binder Accessories	0.36
\N	3102	Motorola SB4200 Cable Modem	Bradley Nguyen	3138	-427.47	179.99	19.99	Quebec	Computer Peripherals	0.48
\N	3103	IBM 3.5" DS/HD IBM Formatted Diskettes, 50/Pack	Matt Collister	3141	-26.72	18.89	3.17	Quebec	Computer Peripherals	0.69
\N	3104	Canon BP1200DH 12-Digit Bubble Jet Printing Calculator	Vivian Mathis	4515	49.45	120.97	7.11	Quebec	Office Machines	0.36
\N	3105	Xerox 220	Michelle Tran	4708	-119.32	6.48	7.49	Quebec	Paper	0.37
\N	3106	Microsoft Natural Keyboard Elite	Pete Takahito	5155	-38.51	39.98	4	Quebec	Computer Peripherals	0.7
\N	3107	Nu-Dell Float Frame 11 x 14 1/2	Michelle Tran	5382	36.54	8.98	4.19	Quebec	Office Furnishings	0.43
\N	3108	Acco Perma® 3000 Stacking Storage Drawers	Michelle Tran	5414	-27.08	20.98	5.42	Quebec	Storage & Organization	0.66
\N	3109	Avery 487	Matt Collister	6433	73.89	3.69	0.5	Quebec	Labels	0.38
\N	3110	Tripp Lite Isotel 6 Outlet Surge Protector with Fax/Modem Protection	Ralph Arnett	6464	-41.77	60.97	4.5	Quebec	Appliances	0.56
\N	3111	Eldon ClusterMat Chair Mat with Cordless Antistatic Protection	Ralph Arnett	6464	-1014.11	90.98	56.2	Quebec	Office Furnishings	0.74
\N	3112	Catalog Binders with Expanding Posts	Dave Hallsten	7846	499.27	67.28	19.99	Quebec	Binders and Binder Accessories	0.4
\N	3113	Economy Binders	Dave Hallsten	7846	-10.22	2.08	1.49	Quebec	Binders and Binder Accessories	0.36
\N	3114	Micro Innovations Micro 3000 Keyboard, Black	Dave Hallsten	7846	-64.82	26.31	5.89	Quebec	Computer Peripherals	0.75
\N	3115	Regeneration Desk Collection	Dave Hallsten	7846	-33.61	1.76	4.86	Quebec	Office Furnishings	0.41
\N	3116	O'Sullivan 3-Shelf Heavy-Duty Bookcases	Pete Takahito	7936	-868.88	58.14	36.61	Quebec	Bookcases	0.61
\N	3117	Eldon Simplefile® Box Office®	Pete Takahito	7936	-41.86	12.44	6.27	Quebec	Storage & Organization	0.57
\N	3118	Array® Parchment Paper, Assorted Colors	Ralph Arnett	8195	-32.48	7.28	11.15	Quebec	Paper	0.37
\N	3119	Master Caster Door Stop, Gray	Ralph Arnett	8195	-7.9	5.08	3.63	Quebec	Office Furnishings	0.51
\N	3120	Newell 337	Ralph Arnett	8195	-70.02	3.28	3.97	Quebec	Pens & Art Supplies	0.56
\N	3121	Accessory35	Jason Klamczynski	8293	483.66	35.99	1.1	Quebec	Telephones and Communication	0.55
\N	3122	Lesro Sheffield Collection Coffee Table, End Table, Center Table, Corner Table	Michelle Tran	9248	-3074.27	71.37	69	Quebec	Tables	0.68
\N	3123	Hoover Replacement Belts For Soft Guard™ & Commercial Ltweight Upright Vacs, 2/Pk	Michelle Tran	9347	-107.98	3.95	5.13	Quebec	Appliances	0.59
\N	3124	Self-Adhesive Removable Labels	Greg Tran	9472	19.47	3.15	0.49	Quebec	Labels	0.37
\N	3125	Xerox 1947	Gene McClure	9733	-90.26	5.98	5.35	Quebec	Paper	0.4
\N	3126	Eldon Cleatmat Plus™ Chair Mats for High Pile Carpets	Helen Wasserman	10054	148.25	79.52	48.2	Quebec	Office Furnishings	0.74
\N	3127	i600	Helen Wasserman	10054	-606.6	125.99	5.99	Quebec	Telephones and Communication	0.56
\N	3128	Hoover Commercial Soft Guard Upright Vacuum And Disposable Filtration Bags	Matt Collister	10627	-30.26	7.77	9.23	Quebec	Appliances	0.58
\N	3129	Westinghouse Clip-On Gooseneck Lamps	Helen Wasserman	10629	-255.65	8.37	10.16	Quebec	Office Furnishings	0.59
\N	3130	Xerox 1996	Helen Wasserman	10629	-76.54	6.48	9.17	Quebec	Paper	0.37
\N	3131	Strathmore Photo Mount Cards	Vivian Mathis	10784	-11.85	6.78	6.18	Quebec	Paper	0.39
\N	3132	Avery Self-Adhesive Photo Pockets for Polaroid Photos	Vivian Mathis	10784	-54.44	6.81	5.48	Quebec	Binders and Binder Accessories	0.37
\N	3133	Satellite Sectional Post Binders	Helen Wasserman	10823	-14.58	43.41	2.99	Quebec	Binders and Binder Accessories	0.39
\N	3134	Tennsco Industrial Shelving	Ross DeVincentis	10919	-1231.87	48.91	35	Quebec	Storage & Organization	0.83
\N	3135	GBC Imprintable Covers	Jason Klamczynski	11429	59.04	10.98	5.14	Quebec	Binders and Binder Accessories	0.36
\N	3136	Bretford CR8500 Series Meeting Room Furniture	Jason Klamczynski	11429	-969.05	400.98	42.52	Quebec	Tables	0.71
\N	3137	Sanford 52201 APSCO Electric Pencil Sharpener	Valerie Mitchum	11650	146.24	40.97	8.99	Quebec	Pens & Art Supplies	0.59
\N	3138	Verbatim DVD-R, 3.95GB, SR, Mitsubishi Branded, Jewel	Dave Hallsten	12837	433.59	22.24	1.99	Quebec	Computer Peripherals	0.43
\N	3139	Durable Pressboard Binders	Vivek Gonzalez	13347	22.84	3.8	1.49	Quebec	Binders and Binder Accessories	0.38
\N	3140	Bevis Round Bullnose 29" High Table Top	Vivian Mathis	13381	-627.64	259.71	66.67	Quebec	Tables	0.65
\N	3141	IBM Active Response Keyboard, Black	Bradley Nguyen	13634	104.51	39.98	7.12	Quebec	Computer Peripherals	0.67
\N	3142	Staples Brown Kraft Recycled Clasp Envelopes	Bradley Nguyen	13634	-55.61	5.58	5.3	Quebec	Envelopes	0.35
\N	3143	Safco Industrial Wire Shelving	Matt Collister	13729	-342.91	95.99	35	Quebec	Storage & Organization	\N
\N	3144	Bevis Round Conference Table Top & Single Column Base	Bradley Nguyen	13730	-354.13	146.34	43.75	Quebec	Tables	0.64
\N	3145	Bretford Rectangular Conference Table Tops	Helen Wasserman	14113	-774.14	376.13	85.63	Quebec	Tables	0.74
\N	3146	Verbatim 4.7GB DVD-R	Helen Wasserman	14210	213.2	33.29	1.99	Quebec	Computer Peripherals	0.41
\N	3147	Belkin 8 Outlet SurgeMaster II Gold Surge Protector with Phone Protection	Vivian Mathis	14272	575.1	80.98	4.5	Quebec	Appliances	0.59
\N	3148	T18	Jason Klamczynski	14401	-128.83	110.99	2.5	Quebec	Telephones and Communication	0.57
\N	3149	O'Sullivan 3-Shelf Heavy-Duty Bookcases	Michelle Tran	15941	-246.32	58.14	36.61	Quebec	Bookcases	0.61
\N	3150	Canon S750 Color Inkjet Printer	Valerie Mitchum	18023	1272.17	120.97	26.3	Quebec	Office Machines	0.38
\N	3151	HP Office Recycled Paper (20Lb. and 87 Bright)	Valerie Mitchum	18023	-149.84	5.78	7.64	Quebec	Paper	0.36
\N	3152	Xerox 196	Bradley Nguyen	18341	-165.26	5.78	7.96	Quebec	Paper	0.36
\N	3153	Fellowes Basic 104-Key Keyboard, Platinum	Ralph Arnett	18400	34.16	20.95	4	Quebec	Computer Peripherals	0.6
\N	3154	Lexmark Z54se Color Inkjet Printer	Barry Gonzalez	18950	1101.9	90.97	14	Quebec	Office Machines	0.36
\N	3155	80 Minute Slim Jewel Case CD-R , 10/Pack - Staples	Bart Pistole	19111	10.79	8.33	1.99	Quebec	Computer Peripherals	0.52
\N	3156	Xerox 193	Helen Wasserman	19139	-26.66	5.98	5.15	Quebec	Paper	0.36
\N	3157	Bevis Round Conference Table Top, X-Base	Barry Gonzalez	19332	-433.29	179.29	29.21	Quebec	Tables	0.74
\N	3158	Advantus 10-Drawer Portable Organizer, Chrome Metal Frame, Smoke Drawers	Michelle Tran	20965	532.21	59.76	9.71	Quebec	Storage & Organization	0.57
\N	3159	T65	Michelle Tran	20965	-444.69	195.99	4.2	Quebec	Telephones and Communication	0.56
\N	3160	Belkin Premiere Surge Master II 8-outlet surge protector	Barry Gonzalez	21249	299.35	48.58	3.99	Quebec	Appliances	0.56
\N	3161	StarTAC 8000	Barry Gonzalez	21249	-523	205.99	8.99	Quebec	Telephones and Communication	0.6
\N	3162	Conquest™ 14 Commercial Heavy-Duty Upright Vacuum, Collection System, Accessory Kit	Vivian Mathis	22529	245.88	56.96	13.22	Quebec	Appliances	0.56
\N	3163	Xerox 1894	Ralph Arnett	23303	-110.56	6.48	6.22	Quebec	Paper	0.37
\N	3164	Xerox 210	Carol Adams	23398	-75.44	6.48	7.37	Quebec	Paper	0.37
\N	3165	Global Leather Executive Chair	Barry Gonzalez	24356	3325.03	350.99	39	Quebec	Chairs & Chairmats	0.55
\N	3166	Accessory12	Valerie Mitchum	25188	682.48	85.99	2.5	Quebec	Telephones and Communication	0.35
\N	3167	Lock-Up Easel 'Spel-Binder'	Vivian Mathis	25249	382.94	28.53	1.49	Quebec	Binders and Binder Accessories	0.38
\N	3168	Dixon Ticonderoga Core-Lock Colored Pencils	Matt Collister	26948	38.6	9.11	2.25	Quebec	Pens & Art Supplies	0.52
\N	3169	Hunt Boston® Vacuum Mount KS Pencil Sharpener	Ralph Arnett	27232	30.21	34.99	7.73	Quebec	Pens & Art Supplies	0.59
\N	3170	Chromcraft 48" x 96" Racetrack Double Pedestal Table	Michelle Tran	27622	-774.89	320.64	43.57	Quebec	Tables	0.63
\N	3171	Black Print Carbonless Snap-Off® Rapid Letter, 8 1/2" x 7"	Jason Klamczynski	28002	-3.64	9.11	2.15	Quebec	Paper	0.4
\N	3172	Seth Thomas 8 1/2" Cubicle Clock	Chad McGuire	28390	83.48	20.28	6.68	Quebec	Office Furnishings	0.53
\N	3173	Global Troy™ Executive Leather Low-Back Tilter	Greg Tran	29223	8022.94	500.98	26	Quebec	Chairs & Chairmats	0.6
\N	3174	Ibico Hi-Tech Manual Binding System	Sanjit Jacobs	29351	1784.04	304.99	19.99	Quebec	Binders and Binder Accessories	0.4
\N	3175	Presstex Flexible Ring Binders	Scott Cohen	29506	59.7	4.55	1.49	Quebec	Binders and Binder Accessories	0.35
\N	3176	Staples® General Use 3-Ring Binders	Scott Cohen	29506	-5.62	1.88	1.49	Quebec	Binders and Binder Accessories	0.37
\N	3177	Iris Project Case	Scott Cohen	29633	-43.24	7.98	6.5	Quebec	Storage & Organization	0.59
\N	3178	GBC Prepunched Paper, 19-Hole, for Binding Systems, 24-lb	Barry Gonzalez	29764	-8.59	15.01	8.4	Quebec	Binders and Binder Accessories	0.39
\N	3179	C-Line Peel & Stick Add-On Filing Pockets, 8-3/4 x 5-1/8, 10/Pack	Barry Gonzalez	29958	-72.3	6.37	5.19	Quebec	Binders and Binder Accessories	0.38
\N	3180	Global Troy™ Executive Leather Low-Back Tilter	Barry Gonzalez	29958	3408.29	500.98	26	Quebec	Chairs & Chairmats	0.6
\N	3181	Storex DuraTech Recycled Plastic Frosted Binders	Sanjit Jacobs	31616	-156.41	4.24	5.41	Quebec	Binders and Binder Accessories	0.35
\N	3182	Avery 481	Sanjit Jacobs	31616	36.96	3.08	0.99	Quebec	Labels	0.37
\N	3183	Imation 3.5", RTS 247544 3M 3.5 DSDD, 10/Pack	Sanjit Jacobs	31907	-35.97	8.46	3.62	Quebec	Computer Peripherals	0.61
\N	3184	Executive Impressions 14" Contract Wall Clock	Chad McGuire	32001	205.13	22.23	3.63	Quebec	Office Furnishings	0.52
\N	3185	Polycom VoiceStation 100	Chad McGuire	32001	794.2	300.98	13.99	Quebec	Office Machines	0.39
\N	3186	Panasonic KX-P1150 Dot Matrix Printer	Gene McClure	32069	-240.31	145.45	17.85	Quebec	Office Machines	0.56
\N	3187	Xerox 1894	Vivek Sundaresam	32102	-10.39	6.48	6.22	Quebec	Paper	0.37
\N	3188	KI Conference Tables	Barry Gonzalez	32450	54.23	70.89	89.3	Quebec	Tables	0.69
\N	3189	Avery Flip-Chart Easel Binder, Black	Greg Tran	32546	-34.85	22.38	15.1	Quebec	Binders and Binder Accessories	0.38
\N	3190	Accessory23	Greg Tran	32546	607.26	35.99	1.25	Quebec	Telephones and Communication	0.36
\N	3191	Bretford “Just In Time” Height-Adjustable Multi-Task Work Tables	Scott Cohen	33029	-1008.73	417.4	75.23	Quebec	Tables	0.79
\N	3192	6160	Scott Cohen	33029	-286.36	115.99	2.5	Quebec	Telephones and Communication	0.57
\N	3193	Fellowes Recycled Storage Drawers	Valerie Mitchum	33061	525.15	111.03	8.64	Quebec	Storage & Organization	0.78
\N	3194	Adams Telephone Message Book W/Dividers/Space For Phone Numbers, 5 1/4"X8 1/2", 300/Messages	Natalie DeCherney	33478	5.85	5.88	3.04	Quebec	Paper	0.36
\N	3195	Lumber Crayons	Barry Gonzalez	33540	-27.15	9.85	4.82	Quebec	Pens & Art Supplies	0.47
\N	3196	Staples Brown Kraft Recycled Clasp Envelopes	Vivek Gonzalez	33862	-45.16	5.58	5.3	Quebec	Envelopes	0.35
\N	3197	Bush Westfield Collection Bookcases, Dark Cherry Finish, Fully Assembled	Vivek Sundaresam	34470	-1456.31	100.98	57.38	Quebec	Bookcases	0.78
\N	3198	Avery Non-Stick Binders	Chad McGuire	36161	0.65	4.49	1.49	Quebec	Binders and Binder Accessories	0.39
\N	3199	80 Minute Slim Jewel Case CD-R , 10/Pack - Staples	Barry Gonzalez	37760	10.74	8.33	1.99	Quebec	Computer Peripherals	0.52
\N	3200	Accessory34	Barry Gonzalez	37760	897.87	85.99	0.99	Quebec	Telephones and Communication	0.55
\N	3201	Standard Line™ “While You Were Out” Hardbound Telephone Message Book	Barry Gonzalez	37895	24.2	21.98	8.32	Quebec	Paper	0.39
\N	3202	Avery 474	Michelle Huthwaite	38403	37.03	2.88	0.99	Quebec	Labels	0.36
\N	3203	R380	Vivek Sundaresam	38630	44.55	195.99	3.99	Quebec	Telephones and Communication	0.58
\N	3204	Acco Six-Outlet Power Strip, 4' Cord Length	Bradley Nguyen	40165	-75.17	8.62	4.5	Quebec	Appliances	0.59
\N	3205	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Barry Gonzalez	40194	290.66	160.98	30	Quebec	Chairs & Chairmats	0.62
\N	3206	Hewlett-Packard 2600DN Business Color Inkjet Printer	Barry Gonzalez	40194	-14.42	119.99	56.14	Quebec	Office Machines	0.39
\N	3207	Accessory27	Barry Gonzalez	40194	-112.12	35.99	5	Quebec	Telephones and Communication	0.85
\N	3208	Boston School Pro Electric Pencil Sharpener, 1670	Cynthia Delaney	40454	22.71	30.98	8.99	Quebec	Pens & Art Supplies	0.58
\N	3209	Bush Westfield Collection Bookcases, Fully Assembled	Barry Gonzalez	40672	-159.21	100.98	35.84	Quebec	Bookcases	0.62
\N	3210	V8160	Michelle Huthwaite	40833	844.82	65.99	2.5	Quebec	Telephones and Communication	0.56
\N	3211	Acco Pressboard Covers with Storage Hooks, 14 7/8" x 11", Light Blue	Tom Stivers	41441	-108.2	4.91	5.68	Quebec	Binders and Binder Accessories	0.36
\N	3212	Hon Comfortask® Task/Swivel Chairs	Vivek Sundaresam	43076	-176.91	113.98	30	Quebec	Chairs & Chairmats	0.69
\N	3213	Xerox 200	Vivian Mathis	43233	-71.91	6.48	6.35	Quebec	Paper	0.37
\N	3214	Xerox 194	Greg Tran	43332	559.38	55.48	14.3	Quebec	Paper	0.37
\N	3215	Office Star - Professional Matrix Back Chair with 2-to-1 Synchro Tilt and Mesh Fabric Seat	Rick Reed	43362	4276.73	350.98	30	Quebec	Chairs & Chairmats	0.61
\N	3216	Prang Dustless Chalk Sticks	Rick Reed	43362	2.72	1.68	1	Quebec	Pens & Art Supplies	0.35
\N	3217	Fellowes Premier Superior Surge Suppressor, 10-Outlet, With Phone and Remote	Michelle Huthwaite	43488	483.67	48.92	4.5	Quebec	Appliances	0.59
\N	3218	Park Ridge™ Embossed Executive Business Envelopes	Michelle Huthwaite	43488	399.12	15.57	1.39	Quebec	Envelopes	0.38
\N	3219	DAX Contemporary Wood Frame with Silver Metal Mat, Desktop, 11 x 14 Size	Michelle Huthwaite	43488	42.39	20.24	6.67	Quebec	Office Furnishings	0.49
\N	3220	GBC White Gloss Covers, Plain Front	Michelle Huthwaite	43488	6.77	14.48	6.46	Quebec	Binders and Binder Accessories	0.38
\N	3221	Hewlett Packard 610 Color Digital Copier / Printer	Michelle Huthwaite	43488	-1569.06	449.99	24.49	Quebec	Copiers and Fax	0.4
\N	3222	Peel & Seel® Recycled Catalog Envelopes, Brown	Barry Gonzalez	43526	-2.23	11.58	6.97	Quebec	Envelopes	0.35
\N	3223	Eldon Jumbo ProFile™ Portable File Boxes Graphite/Black	Barry Gonzalez	43526	-43.22	15.31	8.78	Quebec	Storage & Organization	0.57
\N	3224	Executive Impressions 12" Wall Clock	Gary McGarr	44134	50.04	17.67	8.99	Quebec	Office Furnishings	0.47
\N	3225	3390	Cynthia Delaney	44196	-83.47	65.99	5.31	Quebec	Telephones and Communication	0.57
\N	3226	Hon Rectangular Conference Tables	Cynthia Delaney	44358	547.04	227.55	32.48	Quebec	Tables	0.68
\N	3227	Xerox 1940	Vivek Sundaresam	44480	448.24	54.96	10.75	Quebec	Paper	0.36
\N	3228	OIC Colored Binder Clips, Assorted Sizes	Vivek Sundaresam	44546	4.26	3.58	1.63	Quebec	Rubber Bands	0.36
\N	3229	Global Troy™ Executive Leather Low-Back Tilter	Ross DeVincentis	44647	6888.36	500.98	26	Quebec	Chairs & Chairmats	0.6
\N	3230	Recycled Eldon Regeneration Jumbo File	Ross DeVincentis	44647	-36.76	12.28	6.13	Quebec	Storage & Organization	0.57
\N	3231	Sauder Facets Collection Locker/File Cabinet, Sky Alder Finish	Vivek Gonzalez	45376	-555.98	370.98	99	Quebec	Storage & Organization	0.65
\N	3232	Belkin 105-Key Black Keyboard	Tom Stivers	46115	-37.99	19.98	4	Quebec	Computer Peripherals	0.68
\N	3233	Xerox 1881	Tom Stivers	46115	44.04	12.28	6.47	Quebec	Paper	0.38
\N	3234	SAFCO Folding Chair Trolley	Tom Stivers	47109	1844.96	128.24	12.65	Quebec	Chairs & Chairmats	\N
\N	3235	Logitech Access Keyboard	Vivek Sundaresam	47556	108.21	15.98	4	Quebec	Computer Peripherals	0.37
\N	3236	Acco PRESSTEX® Data Binder with Storage Hooks, Dark Blue, 9 1/2" X 11"	Gary McGarr	47712	-243.87	5.38	7.57	Quebec	Binders and Binder Accessories	0.36
\N	3237	Canon PC-428 Personal Copier	Matt Collister	48135	631.33	199.99	24.49	Quebec	Copiers and Fax	0.46
\N	3238	Hoover Commercial Soft Guard Upright Vacuum And Disposable Filtration Bags	Vivian Mathis	48161	-95.64	7.77	9.23	Quebec	Appliances	0.58
\N	3239	A1228	Vivian Mathis	48161	1197.86	195.99	8.99	Quebec	Telephones and Communication	0.58
\N	3240	White GlueTop Scratch Pads	Barry Gonzalez	48515	327.45	15.04	1.97	Quebec	Paper	0.39
\N	3241	Newell 338	Matt Collister	48642	19.36	2.94	0.7	Quebec	Pens & Art Supplies	0.58
\N	3242	T60	Matt Collister	48642	1332.91	95.99	4.9	Quebec	Telephones and Communication	0.56
\N	3243	Novimex Turbo Task Chair	Vivek Sundaresam	50567	-436.23	70.98	30	Quebec	Chairs & Chairmats	0.73
\N	3244	Eldon® Wave Desk Accessories	Michelle Huthwaite	51623	-66.58	2.08	5.33	Quebec	Office Furnishings	0.43
\N	3245	GBC Standard Therm-A-Bind Covers	Greg Tran	52194	-5.04	24.92	12.98	Quebec	Binders and Binder Accessories	0.39
\N	3246	O'Sullivan Living Dimensions 2-Shelf Bookcases	Greg Tran	52194	-483.12	120.98	78.64	Quebec	Bookcases	0.75
\N	3247	Newell 315	Michelle Tran	52291	57.28	5.98	0.96	Quebec	Pens & Art Supplies	0.6
\N	3248	Accessory25	Michelle Tran	52291	-72.4	20.99	0.99	Quebec	Telephones and Communication	0.57
\N	3249	US Robotics 56K V.92 External Faxmodem	Carol Adams	54370	1041.28	99.99	19.99	Quebec	Computer Peripherals	0.52
\N	3250	Zebra Zazzle Fluorescent Highlighters	Ralph Arnett	54528	19.71	6.08	0.91	Quebec	Pens & Art Supplies	0.51
\N	3251	Xerox 1977	Carol Adams	54659	-41.98	6.68	5.2	Quebec	Paper	0.37
\N	3252	GBC Wire Binding Strips	Bart Pistole	54981	174.72	31.74	12.62	Quebec	Binders and Binder Accessories	0.37
\N	3253	Regeneration Desk Collection	Chad McGuire	55361	-64.37	1.76	4.86	Quebec	Office Furnishings	0.41
\N	3254	Staples File Caddy	Chad McGuire	55361	-116.66	9.38	7.28	Quebec	Storage & Organization	0.57
\N	3255	Wilson Jones Elliptical Ring 3 1/2" Capacity Binders, 800 sheets	Tom Stivers	55908	807.38	42.8	2.99	Quebec	Binders and Binder Accessories	0.36
\N	3256	DAX Value U-Channel Document Frames, Easel Back	Gary McGarr	56257	-135.06	4.97	5.71	Quebec	Office Furnishings	0.54
\N	3257	Ibico Presentation Index for Binding Systems	Vivek Gonzalez	57029	-56.17	3.98	5.26	Quebec	Binders and Binder Accessories	0.38
\N	3258	Xerox 1927	Vivek Gonzalez	57029	-19.06	4.28	6.72	Quebec	Paper	0.4
\N	3259	Eldon ClusterMat Chair Mat with Cordless Antistatic Protection	Darren Budd	58145	46.21	5.84	1.2	Quebec	Office Furnishings	0.74
\N	3260	Wilson Jones DublLock® D-Ring Binders	Michelle Huthwaite	58151	18.15	6.75	2.99	Quebec	Binders and Binder Accessories	0.35
\N	3261	Letter Size Cart	Michelle Huthwaite	58151	1515.7	142.86	19.99	Quebec	Storage & Organization	0.56
\N	3262	Xerox 217	Tom Stivers	58659	-13.13	6.48	8.19	Quebec	Paper	0.37
\N	3263	DAX Natural Wood-Tone Poster Frame	Vivian Mathis	58727	180.64	26.48	6.93	Quebec	Office Furnishings	0.49
\N	3264	Wilson Jones® Four-Pocket Poly Binders	Liz Willingham	258	-55.11	6.54	5.27	Quebec	Binders and Binder Accessories	0.36
\N	3265	Avery Hanging File Binders	Stefania Perrino	964	95.16	5.98	1.49	Quebec	Binders and Binder Accessories	0.39
\N	3266	Avery 493	Thea Hendricks	1154	53.13	4.91	0.5	Quebec	Labels	0.36
\N	3267	Peel & Stick Add-On Corner Pockets	Grant Thornton	1537	-20.3	2.16	6.05	Quebec	Binders and Binder Accessories	0.37
\N	3268	Global Adaptabilities™ Conference Tables	Carlos Meador	4580	-2301.53	280.98	81.98	Quebec	Tables	0.78
\N	3269	Acme Hot Forged Carbon Steel Scissors with Nickel-Plated Handles, 3 7/8" Cut, 8"L	Carlos Meador	4647	-67.59	13.9	7.59	Quebec	Scissors, Rulers and Trimmers	0.56
\N	3270	Multimedia Mailers	Doug Jacobs	8097	3187.37	162.93	19.99	Quebec	Envelopes	0.39
\N	3271	Acco Keyboard-In-A-Box®	Becky Martin	8422	-22.82	29.1	4	Quebec	Computer Peripherals	0.78
\N	3272	Trav-L-File Heavy-Duty Shuttle II, Black	Speros Goranitis	8677	-8.67	43.57	16.36	Quebec	Storage & Organization	0.55
\N	3273	Wirebound Message Book, 4 per Page	Katherine Murray	9024	-4.55	5.43	0.95	Quebec	Paper	0.36
\N	3274	Avery Poly Binder Pockets	Michael Paige	10114	-142.91	3.58	5.47	Quebec	Binders and Binder Accessories	0.37
\N	3275	Deluxe Rollaway Locking File with Drawer	Robert Barroso	11236	-195.7	415.88	11.37	Quebec	Storage & Organization	0.57
\N	3276	Post-it® “Important Message” Note Pad, Neon Colors, 50 Sheets/Pad	Dean Percer	11687	58.32	7.28	1.77	Quebec	Paper	0.37
\N	3277	White GlueTop Scratch Pads	Ann Blume	12643	143.23	15.04	1.97	Quebec	Paper	0.39
\N	3278	Sauder Camden County Collection Libraries, Planked Cherry Finish	Damala Kotsonis	13089	-1620.41	114.98	58.72	Quebec	Bookcases	0.76
\N	3279	Acme Kleencut® Forged Steel Scissors	Paul Knutson	13378	-50.75	5.74	5.3	Quebec	Scissors, Rulers and Trimmers	0.55
\N	3280	Avery 498	George Zrebassa	13824	19.12	2.89	0.5	Quebec	Labels	0.38
\N	3282	Sauder Forest Hills Library, Woodland Oak Finish	Aaron Hawkins	20737	-317.48	140.98	36.09	Quebec	Bookcases	0.77
\N	3283	600 Series Non-Flip	Ellis Ballard	20900	483.6	45.99	4.99	Quebec	Telephones and Communication	0.57
\N	3284	Ibico Presentation Index for Binding Systems	Tom Prescott	26658	-57.89	3.98	5.26	Quebec	Binders and Binder Accessories	0.38
\N	3285	Metal Folding Chairs, Beige, 4/Carton	Speros Goranitis	27271	-77.31	33.94	19.19	Quebec	Chairs & Chairmats	0.58
\N	3286	Electrix Halogen Magnifier Lamp	Dianna Arnett	28001	1162.76	194.3	11.54	Quebec	Office Furnishings	0.59
\N	3287	Office Star - Professional Matrix Back Chair with 2-to-1 Synchro Tilt and Mesh Fabric Seat	Chuck Sachs	28161	664.88	350.98	30	Quebec	Chairs & Chairmats	0.61
\N	3288	Hunt BOSTON® Vista® Battery-Operated Pencil Sharpener, Black	Bill Shonely	29280	-64.51	11.66	7.95	Quebec	Pens & Art Supplies	0.58
\N	3289	Eldon® Gobal File Keepers	Eric Barreto	29350	-47.88	15.14	4.53	Quebec	Storage & Organization	0.81
\N	3290	Xerox 1963	Dave Poirier	29666	-152.59	5.28	8.16	Quebec	Paper	0.4
\N	3291	Avery 481	Eric Barreto	29700	5.02	3.08	0.99	Quebec	Labels	0.37
\N	3292	Hon 2111 Invitation™ Series Corner Table	David Flashing	30754	-505.98	209.37	69	Quebec	Tables	0.79
\N	3293	Micro Innovations Media Access Pro Keyboard	Elizabeth Moffitt	31650	-0.31	77.51	4	Quebec	Computer Peripherals	0.76
\N	3294	2160	Ben Peterman	32292	1601.64	115.99	5.99	Quebec	Telephones and Communication	0.57
\N	3295	Micro Innovations 104 Keyboard	Brad Thomas	35201	-75.81	10.97	6.5	Quebec	Computer Peripherals	0.64
\N	3296	GBC Instant Index™ System for Binding Systems	Yana Sorensen	35360	-16.39	8.88	6.28	Quebec	Binders and Binder Accessories	0.35
\N	3297	Nu-Dell Executive Frame	Janet Martin	35492	83.51	12.64	4.98	Quebec	Office Furnishings	0.48
\N	3298	Array® Memo Cubes	Tom Prescott	37473	2.12	5.18	2.04	Quebec	Paper	0.36
\N	3299	Computer Printout Index Tabs	Debra Catini	39079	-225.25	1.68	5.28	Quebec	Binders and Binder Accessories	0.37
\N	3300	Avery 494	Dan Campbell	39266	9.94	2.61	0.5	Quebec	Labels	0.39
\N	3301	Eureka Disposable Bags for Sanitaire® Vibra Groomer I® Upright Vac	Sylvia Foulston	40356	-245.67	4.06	6.89	Quebec	Appliances	0.6
\N	3302	Atlantic Metals Mobile 5-Shelf Bookcases, Custom Colors	Alex Grayson	42599	2023.75	300.98	54.92	Quebec	Bookcases	0.55
\N	3303	Xerox 213	Barry Franz	45670	-13.32	6.48	7.86	Quebec	Paper	0.37
\N	3304	Durable Pressboard Binders	Chuck Sachs	46531	7.98	3.8	1.49	Quebec	Binders and Binder Accessories	0.38
\N	3305	Ibico Hi-Tech Manual Binding System	Sylvia Foulston	47617	1680.92	304.99	19.99	Quebec	Binders and Binder Accessories	0.4
\N	3306	Xerox 1953	Anthony Garverick	47842	-150.93	4.28	5.74	Quebec	Paper	0.4
\N	3307	Newell 337	Astrea Jones	48548	-10.27	3.28	3.97	Quebec	Pens & Art Supplies	0.56
\N	3308	Xerox 212	Cathy Hwang	49056	-209.58	6.48	8.4	Quebec	Paper	0.37
\N	3309	Talkabout T8367	Deborah Brumfield	50759	366.18	65.99	8.99	Quebec	Telephones and Communication	0.56
\N	3310	Barrel Sharpener	Frank Atkinson	51556	-24.21	3.57	4.17	Quebec	Pens & Art Supplies	0.59
\N	3311	Tenex Personal Project File with Scoop Front Design, Black	Ben Peterman	51620	-2.55	13.48	4.51	Quebec	Storage & Organization	0.59
\N	3312	Fellowes Staxonsteel® Drawer Files	Julie Kriz	52837	519.55	193.17	19.99	Quebec	Storage & Organization	0.71
\N	3313	Safco Value Mate Steel Bookcase, Baked Enamel Finish on Steel, Black	Erica Hernandez	54592	-15.29	70.98	26.85	Quebec	Bookcases	\N
\N	3314	Safco Industrial Wire Shelving	Bobby Elias	55202	-850.71	95.99	35	Quebec	Storage & Organization	\N
\N	3315	Hon 2111 Invitation™ Series Corner Table	Joni Wasserman	55239	-505.98	209.37	69	Quebec	Tables	0.79
\N	3316	Okidata ML184 Turbo Dot Matrix Printers	Jennifer Patt	57894	2852.94	306.14	26.53	Quebec	Office Machines	0.56
\N	3317	Hon Every-Day® Chair Series Swivel Task Chairs	Dianna Wilson	58599	45.54	120.98	30	Quebec	Chairs & Chairmats	0.64
\N	3318	Bell Sonecor JB700 Caller ID	Emily Phan	132	-86.2	7.99	5.03	Quebec	Telephones and Communication	0.6
\N	3319	Barricks 18" x 48" Non-Folding Utility Table with Bottom Storage Shelf	Karl Brown	1191	-243.6	100.8	60	Quebec	Tables	0.59
\N	3320	Advantus Rolling Storage Box	Noel Staavos	1444	24.33	17.15	4.96	Quebec	Storage & Organization	0.58
\N	3321	Xerox 1978	Katherine Murray	1985	-7.96	5.78	5.67	Quebec	Paper	0.36
\N	3322	Tenex Personal Project File with Scoop Front Design, Black	Paul Knutson	1988	-16.99	13.48	4.51	Quebec	Storage & Organization	0.59
\N	3323	Iceberg Mobile Mega Data/Printer Cart ®	Maribeth Dona	2305	141.31	120.33	19.99	Quebec	Storage & Organization	0.59
\N	3324	Avery Durable Binders	Alex Grayson	3397	-3.38	2.88	1.49	Quebec	Binders and Binder Accessories	0.36
\N	3325	Durable Pressboard Binders	Evan Henry	3680	18.28	3.8	1.49	Quebec	Binders and Binder Accessories	0.38
\N	3326	Xerox 1885	Paul Knutson	3877	254.31	48.04	7.23	Quebec	Paper	0.37
\N	3327	Home/Office Personal File Carts	Bill Tyler	4033	140.33	34.76	5.49	Quebec	Storage & Organization	0.6
\N	3328	Boston 16765 Mini Stand Up Battery Pencil Sharpener	Denise Leinenbach	4103	-28.43	11.66	8.99	Quebec	Pens & Art Supplies	0.59
\N	3329	Master Giant Foot® Doorstop, Safety Yellow	Michael Paige	4455	14.15	7.59	4	Quebec	Office Furnishings	0.42
\N	3330	Wilson Jones “Snap” Scratch Pad Binder Tool for Ring Binders	Michael Stewart	4896	-64.87	5.8	5.59	Quebec	Binders and Binder Accessories	0.4
\N	3331	Xerox 1984	Corinna Mitchell	4960	-16.38	6.48	8.74	Quebec	Paper	0.36
\N	3332	Fellowes Strictly Business® Drawer File, Letter/Legal Size	Evan Henry	5189	65.58	140.85	19.99	Quebec	Storage & Organization	0.73
\N	3333	Xerox 1880	Michael Kennedy	6086	57.89	35.44	19.99	Quebec	Paper	0.38
\N	3334	Holmes HEPA Air Purifier	Alan Shonely	6912	15.34	21.78	5.94	Quebec	Appliances	0.5
\N	3335	Accessory24	Dianna Arnett	6950	-225.3	55.99	3.3	Quebec	Telephones and Communication	0.59
\N	3336	Decoflex Hanging Personal Folder File, Blue	Shirley Jackson	7075	-83.3	15.42	10.68	Quebec	Storage & Organization	0.58
\N	3337	Super Bands, 12/Pack	Shirley Jackson	7075	-93.18	1.86	2.58	Quebec	Rubber Bands	0.82
\N	3338	Verbatim DVD-RAM, 9.4GB, Rewritable, Type 1, DS, DataLife Plus	Debra Catini	7297	-71.83	45.19	1.99	Quebec	Computer Peripherals	0.55
\N	3339	Universal Premium White Copier/Laser Paper (20Lb. and 87 Bright)	Carlos Meador	7938	-86.73	5.98	7.15	Quebec	Paper	0.36
\N	3340	Tenex Traditional Chairmats for Medium Pile Carpet, Standard Lip, 36" x 48"	Debra Catini	8065	379.28	60.65	12.23	Quebec	Office Furnishings	0.64
\N	3341	#10-4 1/8" x 9 1/2" Premium Diagonal Seam Envelopes	Ellis Ballard	8292	130.04	15.74	1.39	Quebec	Envelopes	0.4
\N	3342	Acco Six-Outlet Power Strip, 4' Cord Length	Fred McMath	8513	-9.29	8.62	4.5	Quebec	Appliances	0.59
\N	3343	Microsoft Office Keyboard	Katherine Murray	9024	-9.3	40.98	6.5	Quebec	Computer Peripherals	0.64
\N	3344	Staples® General Use 3-Ring Binders	Andy Reiter	9635	-2.91	1.88	1.49	Quebec	Binders and Binder Accessories	0.37
\N	3345	Quartet Omega® Colored Chalk, 12/Pack	Karl Brown	10436	49.81	5.84	1	Quebec	Pens & Art Supplies	0.38
\N	3346	GBC Pre-Punched Binding Paper, Plastic, White, 8-1/2" x 11"	Dianna Wilson	10752	-36.89	15.99	13.18	Quebec	Binders and Binder Accessories	0.37
\N	3347	Self-Adhesive Address Labels for Typewriters by Universal	Fred McMath	11011	118.79	7.31	0.49	Quebec	Labels	0.38
\N	3348	Cardinal Holdit Business Card Pockets	Robert Barroso	11236	-94.05	4.98	4.95	Quebec	Binders and Binder Accessories	0.37
\N	3349	Imation 3.5 IBM Formatted Diskettes, 10/Box	Valerie Mitchum	11650	-45.89	8.32	2.38	Quebec	Computer Peripherals	0.74
\N	3350	Adams Phone Message Book, 200 Message Capacity, 8 1/16” x 11”	Alex Grayson	11779	86.6	6.88	2	Quebec	Paper	0.39
\N	3351	Micro Innovations 104 Keyboard	Alex Grayson	11779	-172.34	10.97	6.5	Quebec	Computer Peripherals	0.64
\N	3352	i600	Michael Stewart	12515	133.45	125.99	5.99	Quebec	Telephones and Communication	0.56
\N	3353	Newell 342	Dave Poirier	12580	-115.53	3.28	3.97	Quebec	Pens & Art Supplies	0.56
\N	3354	Newell 310	Muhammed Lee	12868	-2.44	1.76	0.7	Quebec	Pens & Art Supplies	0.56
\N	3355	Advantus 10-Drawer Portable Organizer, Chrome Metal Frame, Smoke Drawers	Doug Jacobs	12931	52.89	59.76	9.71	Quebec	Storage & Organization	0.57
\N	3356	Strathmore Photo Mount Cards	Fred McMath	13027	-93.5	6.78	6.18	Quebec	Paper	0.39
\N	3357	Acco Pressboard Covers with Storage Hooks, 14 7/8" x 11", Light Blue	Noel Staavos	13476	-147.86	4.91	5.68	Quebec	Binders and Binder Accessories	0.36
\N	3358	Imation 3.5, DISKETTE 44766 HGHLD3.52HD/FM, 10/Pack	Pierre Wener	13572	-43.71	5.02	5.14	Quebec	Computer Peripherals	0.79
\N	3359	Spiral Phone Message Books with Labels by Adams	Tom Prescott	13731	6.79	4.48	1.22	Quebec	Paper	0.36
\N	3360	Eureka The Boss® Cordless Rechargeable Stick Vac	Paul Lucas	14112	-25.76	50.98	13.66	Quebec	Appliances	0.58
\N	3361	Rush Hierlooms Collection 1" Thick Stackable Bookcases	Dave Poirier	14114	538.52	170.98	35.89	Quebec	Bookcases	0.66
\N	3362	DAX Cubicle Frames - 8x10	Dave Poirier	14114	-136.7	5.77	5.92	Quebec	Office Furnishings	0.55
\N	3363	Boston Electric Pencil Sharpener, Model 1818, Charcoal Black	Erica Hernandez	15009	-7.8	28.15	8.99	Quebec	Pens & Art Supplies	0.57
\N	3364	Global Commerce™ Series High-Back Swivel/Tilt Chairs	Benjamin Venier	15399	-51.28	284.98	69.55	Quebec	Chairs & Chairmats	0.6
\N	3365	Fellowes Black Plastic Comb Bindings	Harold Dahlen	16036	-165.11	5.81	8.49	Quebec	Binders and Binder Accessories	0.39
\N	3366	I888 World Phone	Harold Dahlen	16036	-268.87	155.99	8.08	Quebec	Telephones and Communication	0.6
\N	3367	Portfile® Personal File Boxes	Harold Dahlen	16036	-141.6	17.7	9.47	Quebec	Storage & Organization	0.59
\N	3368	Hon 4070 Series Pagoda™ Round Back Stacking Chairs	Eric Barreto	17216	-99.16	320.98	58.95	Quebec	Chairs & Chairmats	0.57
\N	3369	Acco Smartsocket® Color-Coded Six-Outlet AC Adapter Model Surge Protectors	Michael Kennedy	17698	528.77	44.01	3.5	Quebec	Appliances	0.59
\N	3370	Holmes Replacement Filter for HEPA Air Cleaner, Very Large Room, HEPA Filter	Troy Staebel	17953	-499.51	68.81	60	Quebec	Appliances	0.41
\N	3371	Newell 312	Troy Staebel	17953	18.76	5.84	1.2	Quebec	Pens & Art Supplies	0.55
\N	3372	White Dual Perf Computer Printout Paper, 2700 Sheets, 1 Part, Heavyweight, 20 lbs., 14 7/8 x 11	Doug Jacobs	17959	146.8	40.99	19.99	Quebec	Paper	0.36
\N	3373	3M Polarizing Task Lamp with Clamp Arm, Light Gray	Doug Jacobs	17959	847.06	136.98	24.49	Quebec	Office Furnishings	0.59
\N	3374	Hon 94000 Series Round Tables	Benjamin Venier	18017	-715.78	296.18	54.12	Quebec	Tables	0.76
\N	3375	Kensington 7 Outlet MasterPiece Power Center with Fax/Phone Line Protection	Tracy Poddar	18373	2164.64	207.48	0.99	Quebec	Appliances	0.55
\N	3376	Acco® Hot Clips™ Clips to Go	Ellis Ballard	19558	-3.93	3.29	1.35	Quebec	Rubber Bands	0.4
\N	3377	2160i	Paul Knutson	20518	2418.56	200.99	4.2	Quebec	Telephones and Communication	0.59
\N	3378	Panasonic KX-P3200 Dot Matrix Printer	Paul Knutson	20518	-313.13	297.48	18.06	Quebec	Office Machines	0.6
\N	3379	Riverside Furniture Stanwyck Manor Table Series	Aaron Hawkins	20737	-693.23	286.85	61.76	Quebec	Tables	0.78
\N	3380	Bush Westfield Collection Bookcases, Fully Assembled	Elizabeth Moffitt	20903	-152.76	100.98	35.84	Quebec	Bookcases	0.62
\N	3381	IBM 80 Minute CD-R Spindle, 50/Pack	Bobby Trafton	21344	134.25	20.89	1.99	Quebec	Computer Peripherals	0.48
\N	3382	Avery 498	Bobby Trafton	21344	42.68	2.89	0.5	Quebec	Labels	0.38
\N	3383	Memorex 'Cool' 80 Minute CD-R Spindle, 25/Pack	Troy Staebel	21606	138.33	17.48	1.99	Quebec	Computer Peripherals	0.46
\N	3384	Quartet Omega® Colored Chalk, 12/Pack	Speros Goranitis	22183	68.96	5.84	1	Quebec	Pens & Art Supplies	0.38
\N	3385	IBM Numeric Access II Keypad, 17-Key, Black	Bill Tyler	22338	-213.18	35.77	9.02	Quebec	Computer Peripherals	0.75
\N	3386	Telephone Message Books with Fax/Mobile Section, 4 1/4" x 6"	Pierre Wener	23268	-6.81	3.6	2.2	Quebec	Paper	0.39
\N	3387	5180	Alan Shonely	23522	17.25	65.99	8.99	Quebec	Telephones and Communication	0.56
\N	3388	Gyration RF Keyboard	Alan Shonely	23522	666.01	159.99	5.5	Quebec	Computer Peripherals	0.49
\N	3389	Xerox 227	Alan Shonely	23522	-180.17	6.48	8.73	Quebec	Paper	0.37
\N	3390	Xerox 226	Tracy Poddar	23968	-41.99	6.48	5.84	Quebec	Paper	0.37
\N	3391	Tripp Lite Isotel 6 Outlet Surge Protector with Fax/Modem Protection	Tony Molinari	24644	882.45	60.97	4.5	Quebec	Appliances	0.56
\N	3392	Rediform S.O.S. Phone Message Books	Bill Shonely	25472	80.35	4.98	0.8	Quebec	Paper	0.36
\N	3393	Acco Perma® 2700 Stacking Storage Drawers	Rick Duston	25927	-21.06	29.74	6.64	Quebec	Storage & Organization	0.7
\N	3394	Letter/Legal File Tote with Clear Snap-On Lid, Black Granite	Janet Martin	25955	-39.92	16.06	8.34	Quebec	Storage & Organization	0.59
\N	3395	Polycom Soundstation EX Audio-Conferencing Telephone, Black	Janet Martin	26276	9224.1	999.99	13.99	Quebec	Office Machines	0.36
\N	3396	Hon 2111 Invitation™ Series Corner Table	Brendan Murry	26306	-505.98	209.37	69	Quebec	Tables	0.79
\N	3397	Polycom Soundstation EX Audio-Conferencing Telephone, Black	Bobby Elias	26724	-2531.48	999.99	13.99	Quebec	Office Machines	0.36
\N	3398	Hon Every-Day® Chair Series Swivel Task Chairs	Christy Brittain	26784	-64.14	120.98	30	Quebec	Chairs & Chairmats	0.64
\N	3399	Sharp EL500L Fraction Calculator	Christy Brittain	26784	-37.94	13.99	7.51	Quebec	Office Machines	0.39
\N	3400	i470	Noel Staavos	26912	439.78	205.99	5.26	Quebec	Telephones and Communication	0.56
\N	3401	DAX Two-Tone Rosewood/Black Document Frame, Desktop, 5 x 7	Aaron Hawkins	26949	-103.48	9.48	7.29	Quebec	Office Furnishings	0.45
\N	3402	SANFORD Major Accent™ Highlighters	Anthony Garverick	27430	0.35	7.08	2.35	Quebec	Pens & Art Supplies	0.47
\N	3403	Hon Metal Bookcases, Putty	Chuck Sachs	28161	-222.77	70.98	46.74	Quebec	Bookcases	0.56
\N	3404	Belkin MediaBoard 104- Keyboard	Chuck Sachs	28161	-33.32	27.48	4	Quebec	Computer Peripherals	0.75
\N	3405	Hot File® 7-Pocket, Floor Stand	Craig Yedwab	28992	1662.92	178.47	19.99	Quebec	Storage & Organization	0.55
\N	3406	Xerox 1981	Bobby Trafton	29349	-101.68	5.28	5.57	Quebec	Paper	0.4
\N	3407	Ibico Laser Imprintable Binding System Covers	Eric Barreto	29350	592.53	52.4	16.11	Quebec	Binders and Binder Accessories	0.39
\N	3408	Dixon Ticonderoga Core-Lock Colored Pencils, 48-Color Set	Eric Barreto	29350	232.8	36.55	13.89	Quebec	Pens & Art Supplies	0.41
\N	3409	Chromcraft 48" x 96" Racetrack Double Pedestal Table	Katrina Willman	29473	-774.89	320.64	29.2	Quebec	Tables	0.66
\N	3410	Canon PC940 Copier	Giulietta Dortch	30023	6463.34	449.99	49	Quebec	Copiers and Fax	0.38
\N	3411	Park Ridge™ Embossed Executive Business Envelopes	Aaron Hawkins	30150	193.12	15.57	1.39	Quebec	Envelopes	0.38
\N	3412	GBC Standard Therm-A-Bind Covers	Karl Brown	30151	33.37	24.92	12.98	Quebec	Binders and Binder Accessories	0.39
\N	3413	Accessory35	Carlos Meador	30276	549.84	35.99	1.1	Quebec	Telephones and Communication	0.55
\N	3414	Hon 94000 Series Round Tables	Carlos Meador	30276	-715.78	296.18	54.12	Quebec	Tables	0.76
\N	3415	Tripp Lite Isotel 6 Outlet Surge Protector with Fax/Modem Protection	Ellis Ballard	30279	324.96	60.97	4.5	Quebec	Appliances	0.56
\N	3416	Panasonic KX-P3626 Dot Matrix Printer	Ellis Ballard	30279	4914.24	517.48	16.63	Quebec	Office Machines	0.59
\N	3417	Avery Self-Adhesive Photo Pockets for Polaroid Photos	Peter McVee	32640	-35.56	6.81	5.48	Quebec	Binders and Binder Accessories	0.37
\N	3418	Xerox 1881	Peter McVee	32640	3.91	12.28	6.47	Quebec	Paper	0.38
\N	3419	Dixon Prang® Watercolor Pencils, 10-Color Set with Brush	Corey Lock	32902	32.43	4.26	1.2	Quebec	Pens & Art Supplies	0.44
\N	3420	US Robotics 56K V.92 External Faxmodem	Michael Paige	32965	227.67	99.99	19.99	Quebec	Computer Peripherals	0.52
\N	3421	Fellowes Command Center 5-outlet power strip	Debra Catini	33025	-19.06	67.84	0.99	Quebec	Appliances	0.58
\N	3422	5170	Harold Dahlen	33154	-218.81	65.99	4.2	Quebec	Telephones and Communication	0.59
\N	3423	Newell 31	Katherine Murray	33253	-5.2	4.13	1.17	Quebec	Pens & Art Supplies	0.57
\N	3424	Global High-Back Leather Tilter, Burgundy	Troy Staebel	33699	-722.23	122.99	70.2	Quebec	Chairs & Chairmats	0.74
\N	3425	Staples Battery-Operated Desktop Pencil Sharpener	Pierre Wener	33761	29.96	10.48	2.89	Quebec	Pens & Art Supplies	0.6
\N	3426	Eldon Image Series Black Desk Accessories	Bradley Drucker	33797	-103.78	4.14	6.6	Quebec	Office Furnishings	0.49
\N	3427	Xerox 188	Bradley Drucker	33797	30.53	11.34	5.01	Quebec	Paper	0.36
\N	3428	Eureka Sanitaire ® Multi-Pro Heavy-Duty Upright, Disposable Bags	Fred McMath	34309	-56.62	4.37	5.15	Quebec	Appliances	0.59
\N	3429	Xerox 1893	Dave Poirier	34595	19.83	40.99	17.48	Quebec	Paper	0.36
\N	3430	Sauder Facets Collection Locker/File Cabinet, Sky Alder Finish	Darrin Sayre	34662	95.06	370.98	99	Quebec	Storage & Organization	0.65
\N	3431	Tenex Personal Self-Stacking Standard File Box, Black/Gray	Brad Thomas	34689	-39.5	16.91	6.25	Quebec	Storage & Organization	0.58
\N	3432	Stacking Tray, Side-Loading, Legal, Smoke	Elizabeth Moffitt	34694	-37.32	4.48	7.24	Quebec	Office Furnishings	0.54
\N	3433	SAFCO Commercial Wire Shelving, Black	Fred McMath	34725	-524.74	138.14	35	Quebec	Storage & Organization	\N
\N	3434	StarTAC 7760	Evan Henry	35296	-165.63	65.99	3.99	Quebec	Telephones and Communication	0.59
\N	3435	Hon 4060 Series Tables	Joni Wasserman	35494	-270.57	111.96	69	Quebec	Tables	0.63
\N	3436	Bretford Rectangular Conference Table Tops	Deanra Eno	35845	-712.53	376.13	85.63	Quebec	Tables	0.74
\N	3437	Newell 323	Deanra Eno	35905	-17.18	1.68	1.57	Quebec	Pens & Art Supplies	0.59
\N	3438	T18	Brad Thomas	37287	371.4	110.99	2.5	Quebec	Telephones and Communication	0.57
\N	3439	6160	Mark Packer	37443	481.74	115.99	2.5	Quebec	Telephones and Communication	0.57
\N	3440	Avery 496	Pierre Wener	37731	33.68	3.75	0.5	Quebec	Labels	0.37
\N	3441	Newell 339	Eleni McCrary	37792	-5.36	2.78	0.97	Quebec	Pens & Art Supplies	0.59
\N	3442	Logitech Cordless Access Keyboard	Bart Folk	37893	25.69	29.99	5.5	Quebec	Computer Peripherals	0.51
\N	3443	36X48 HARDFLOOR CHAIRMAT	Dean Percer	38372	-632.16	20.98	21.2	Quebec	Office Furnishings	0.78
\N	3444	Hon 2090 “Pillow Soft” Series Mid Back Swivel/Tilt Chairs	Sylvia Foulston	38564	-1262.44	280.98	57	Quebec	Chairs & Chairmats	0.78
\N	3445	Adesso Programmable 142-Key Keyboard	Ben Peterman	38912	608.9	152.48	4	Quebec	Computer Peripherals	0.79
\N	3446	Southworth 25% Cotton Premium Laser Paper and Envelopes	Paul Knutson	38976	165.46	19.98	8.68	Quebec	Paper	0.37
\N	3447	Accessory36	Astrea Jones	39040	-221.25	55.99	5	Quebec	Telephones and Communication	0.83
\N	3448	*Staples* Highlighting Markers	Noel Staavos	39169	-0.9	4.84	0.71	Quebec	Pens & Art Supplies	0.52
\N	3449	Avery Trapezoid Ring Binder, 3" Capacity, Black, 1040 sheets	Tracy Poddar	39238	112.06	40.98	2.99	Quebec	Binders and Binder Accessories	0.36
\N	3450	Staples Metal Binder Clips	Sara Luxemburg	39426	12.71	2.62	0.8	Quebec	Rubber Bands	0.39
\N	3451	Xerox 1937	Chuck Sachs	39780	809.97	48.04	5.79	Quebec	Paper	0.37
\N	3452	Tenex Personal Project File with Scoop Front Design, Black	Mark Packer	40005	-8.7	13.48	4.51	Quebec	Storage & Organization	0.59
\N	3453	Smead Adjustable Mobile File Trolley with Lockable Top	Erica Hernandez	41350	-259.01	419.19	19.99	Quebec	Storage & Organization	0.58
\N	3748	Newell 326	Carol Triggs	40934	-1.23	1.76	0.7	Quebec	Pens & Art Supplies	0.56
\N	3454	Situations Contoured Folding Chairs, 4/Set	Fred McMath	41383	-1330.78	70.98	59.81	Quebec	Chairs & Chairmats	0.6
\N	3455	Global Enterprise™ Series Seating Low-Back Swivel/Tilt Chairs	Chuck Sachs	41826	-340.48	258.98	54.31	Quebec	Chairs & Chairmats	0.55
\N	3456	Avery Hi-Liter Comfort Grip Fluorescent Highlighter, Yellow Ink	Darrin Sayre	42471	-17.13	1.95	1.63	Quebec	Pens & Art Supplies	0.46
\N	3457	Xerox 1996	Alex Grayson	42528	-147.72	6.48	9.17	Quebec	Paper	0.37
\N	3458	Newell 339	Bobby Elias	42529	-4.44	2.78	0.97	Quebec	Pens & Art Supplies	0.59
\N	3459	Fellowes Smart Surge Ten-Outlet Protector, Platinum	Bobby Elias	42529	1060.87	60.22	3.5	Quebec	Appliances	0.57
\N	3460	Ibico EB-19 Dual Function Manual Binding System	Sara Luxemburg	43200	-62.13	172.99	19.99	Quebec	Binders and Binder Accessories	0.39
\N	3461	Accessory4	Sara Luxemburg	43200	-305.97	85.99	0.99	Quebec	Telephones and Communication	0.85
\N	3462	Xerox 1949	Bart Folk	43553	-55.54	4.98	4.72	Quebec	Paper	0.36
\N	3463	Bevis 36 x 72 Conference Tables	Keith Herrera	44033	-434.15	124.49	51.94	Quebec	Tables	0.63
\N	3464	Lexmark Z25 Color Inkjet Printer	Keith Herrera	44065	128.43	80.97	33.6	Quebec	Office Machines	0.37
\N	3465	Coloredge Poster Frame	Deanra Eno	44583	95	14.2	5.3	Quebec	Office Furnishings	0.46
\N	3466	Recycled Eldon Regeneration Jumbo File	Giulietta Dortch	45030	-7.25	12.28	6.13	Quebec	Storage & Organization	0.57
\N	3467	GBC DocuBind TL300 Electric Binding System	Rick Duston	46177	3982.22	896.99	19.99	Quebec	Binders and Binder Accessories	0.38
\N	3468	Newell 323	Astrea Jones	46341	-23.14	1.68	1.57	Quebec	Pens & Art Supplies	0.59
\N	3469	Newell 337	Cynthia Voltz	46368	-119.16	3.28	3.97	Quebec	Pens & Art Supplies	0.56
\N	3470	ELITE Series	Chuck Sachs	46531	447.34	205.99	2.79	Quebec	Telephones and Communication	0.58
\N	3471	Berol Giant Pencil Sharpener	Michael Oakman	47012	-97.21	16.99	8.99	Quebec	Pens & Art Supplies	0.56
\N	3472	Belkin 8 Outlet SurgeMaster II Gold Surge Protector	Becky Martin	47106	660.06	59.98	3.99	Quebec	Appliances	0.57
\N	3473	Coloredge Poster Frame	David Kendrick	47621	27.23	14.2	5.3	Quebec	Office Furnishings	0.46
\N	3474	OIC Thumb-Tacks	Erica Hernandez	48706	-2.81	1.14	0.7	Quebec	Rubber Bands	0.38
\N	3475	Lumber Crayons	Nicole Brennan	49443	-10.98	9.85	4.82	Quebec	Pens & Art Supplies	0.47
\N	3476	3390	Erica Hernandez	49824	440.2	65.99	5.31	Quebec	Telephones and Communication	0.57
\N	3477	Regeneration Desk Collection	Ellis Ballard	51047	-83.54	1.76	4.86	Quebec	Office Furnishings	0.41
\N	3478	Eldon Econocleat® Chair Mats for Low Pile Carpets	Ellis Ballard	51047	-681.97	41.47	34.2	Quebec	Office Furnishings	0.73
\N	3479	KI Conference Tables	Brian Stugart	51783	54.23	70.89	89.3	Quebec	Tables	0.69
\N	3480	5125	Alex Grayson	54053	1185.41	200.99	8.08	Quebec	Telephones and Communication	0.59
\N	3481	Eldon® Image Series Desk Accessories, Burgundy	Erica Hernandez	54592	-133.77	4.18	6.92	Quebec	Office Furnishings	0.49
\N	3482	Gyration Ultra Professional Cordless Optical Suite	Paul Knutson	55425	-114.68	300.97	7.18	Quebec	Computer Peripherals	0.48
\N	3483	Accessory29	Joni Wasserman	55616	-42.23	20.99	1.25	Quebec	Telephones and Communication	0.83
\N	3484	Fellowes Personal Hanging Folder Files, Navy	Karen Ferguson	55909	-20.57	13.43	5.5	Quebec	Storage & Organization	0.57
\N	3485	Xerox 1936	Mark Haberlin	55938	192.88	19.98	5.97	Quebec	Paper	0.38
\N	3486	Xerox 216	Julie Kriz	56260	-139.66	6.48	7.91	Quebec	Paper	0.37
\N	3487	Lexmark Z54se Color Inkjet Printer	Giulietta Dortch	56768	235.4	90.97	14	Quebec	Office Machines	0.36
\N	3488	Dixon My First Ticonderoga Pencil, #2	Rick Duston	58337	-5.08	5.85	2.27	Quebec	Pens & Art Supplies	0.56
\N	3489	Acco® Hot Clips™ Clips to Go	Yana Sorensen	58343	11.32	3.29	1.35	Quebec	Rubber Bands	0.4
\N	3490	Global High-Back Leather Tilter, Burgundy	Deborah Brumfield	59270	-404.77	122.99	70.2	Quebec	Chairs & Chairmats	0.74
\N	3491	Xerox 212	Maureen Gastineau	59619	-165.48	6.48	8.4	Quebec	Paper	0.37
\N	3492	SAFCO PlanMaster Heigh-Adjustable Drafting Table Base, 43w x 30d x 30-37h, Black	Julia Barnett	59714	1656.46	349.45	60	Quebec	Tables	\N
\N	3493	GE 48" Fluorescent Tube, Cool White Energy Saver, 34 Watts, 30/Box	Julia Barnett	59781	1249.43	99.23	8.99	Quebec	Office Furnishings	0.35
\N	3494	Riverside Palais Royal Lawyers Bookcase, Royale Cherry Finish	Julia Barnett	59781	-9611.91	880.98	44.55	Quebec	Bookcases	0.62
\N	3495	Super Bands, 12/Pack	Helen Wasserman	70	-107	1.86	2.58	Quebec	Rubber Bands	0.82
\N	3496	3285	Helen Wasserman	70	2057.17	205.99	5.99	Quebec	Telephones and Communication	0.59
\N	3497	Imation 3.5", DISKETTE 44766 HGHLD3.52HD/FM, 10/Pack	Anne Pryor	135	-89.25	4.98	4.62	Quebec	Computer Peripherals	0.64
\N	3498	Eldon Simplefile® Box Office®	Justin Hirsh	193	-37.04	12.44	6.27	Quebec	Storage & Organization	0.57
\N	3499	Newell 314	Karen Ferguson	225	18.27	5.58	0.7	Quebec	Pens & Art Supplies	0.6
\N	3500	Prismacolor Color Pencil Set	Karen Ferguson	225	-8.97	19.84	4.1	Quebec	Pens & Art Supplies	0.44
\N	3501	Rediform Wirebound "Phone Memo" Message Book, 11 x 5-3/4	Dorris Love	290	-32.48	7.64	5.83	Quebec	Paper	0.36
\N	3502	Hon 4070 Series Pagoda™ Round Back Stacking Chairs	Bill Eplett	644	-171.92	320.98	58.95	Quebec	Chairs & Chairmats	0.57
\N	3503	Belkin 8 Outlet SurgeMaster II Gold Surge Protector with Phone Protection	Caroline Jumper	738	32.6	80.98	4.5	Quebec	Appliances	0.59
\N	3504	Xerox 23	Caroline Jumper	738	-56.68	6.48	5.14	Quebec	Paper	0.37
\N	3505	Bionaire 99.97% HEPA Air Cleaner	Pamela Stobb	772	-38.35	17.52	8.17	Quebec	Appliances	0.5
\N	3506	#6 3/4 Gummed Flap White Envelopes	Pamela Stobb	772	86.93	9.9	1.39	Quebec	Envelopes	0.37
\N	3507	Grip Seal Envelopes	Aaron Smayling	1189	-59.82	4.42	4.99	Quebec	Envelopes	0.38
\N	3508	Newell 310	Aaron Smayling	1825	-2.34	1.76	0.7	Quebec	Pens & Art Supplies	0.56
\N	3509	Panasonic KX-P1150 Dot Matrix Printer	Caroline Jumper	2467	586.61	145.45	17.85	Quebec	Office Machines	0.56
\N	3510	Ibico Hi-Tech Manual Binding System	Pamela Stobb	3014	1314.39	304.99	19.99	Quebec	Binders and Binder Accessories	0.4
\N	3511	Avery Reinforcements for Hole-Punch Pages	Jasper Cacioppo	3073	-11.58	1.98	4.77	Quebec	Binders and Binder Accessories	0.4
\N	3512	Canon PC1060 Personal Laser Copier	Jasper Cacioppo	3073	-2314.74	699.99	24.49	Quebec	Copiers and Fax	0.41
\N	3513	Polycom ViewStation™ ISDN Videoconferencing Unit	Jasper Cacioppo	3073	102.61	6783.02	24.49	Quebec	Office Machines	0.39
\N	3514	Master Big Foot® Doorstop, Beige	Jasper Cacioppo	3168	-4.2	5.28	3.96	Quebec	Office Furnishings	0.54
\N	3515	Artistic Insta-Plaque	Alan Haines	3205	80.43	15.68	3.73	Quebec	Office Furnishings	0.46
\N	3516	Lesro Sheffield Collection Coffee Table, End Table, Center Table, Corner Table	Alan Haines	3205	54.6	71.37	69	Quebec	Tables	0.68
\N	3517	Acco Pressboard Covers with Storage Hooks, 14 7/8" x 11", Dark Blue	Logan Haushalter	3559	-117.92	3.81	5.44	Quebec	Binders and Binder Accessories	0.36
\N	3518	DAX Copper Panel Document Frame, 5 x 7 Size	Lena Cacioppo	3586	70.51	12.58	5.16	Quebec	Office Furnishings	0.43
\N	3519	Nu-Dell Leatherette Frames	Lena Cacioppo	3586	116.96	14.34	5	Quebec	Office Furnishings	0.49
\N	3520	Xerox 1992	Aaron Smayling	3750	-24.03	5.98	5.2	Quebec	Paper	0.36
\N	3521	Imation 3.5 IBM Formatted Diskettes, 10/Box	Deirdre Greer	3778	-63.76	8.32	2.38	Quebec	Computer Peripherals	0.74
\N	3522	Verbatim DVD-RAM, 9.4GB, Rewritable, Type 1, DS, DataLife Plus	Deirdre Greer	3778	8.95	45.19	1.99	Quebec	Computer Peripherals	0.55
\N	3523	Xerox 1898	Deirdre Greer	3778	-15	6.68	6.92	Quebec	Paper	0.37
\N	3524	5165	Deirdre Greer	3778	1313.95	175.99	4.99	Quebec	Telephones and Communication	0.59
\N	3525	Euro Pro Shark Stick Mini Vacuum	John Stevenson	3841	-552.1	60.98	49	Quebec	Appliances	0.59
\N	3526	Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind	John Stevenson	3841	11535.28	1270.99	19.99	Quebec	Binders and Binder Accessories	0.35
\N	3527	StarTAC 8000	John Stevenson	3841	1680.23	205.99	8.99	Quebec	Telephones and Communication	0.6
\N	3528	*Staples* Highlighting Markers	Sheri Gordon	4004	8.66	4.84	0.71	Quebec	Pens & Art Supplies	0.52
\N	3529	Panasonic KP-350BK Electric Pencil Sharpener with Auto Stop	Sheri Gordon	4004	195.48	34.58	8.99	Quebec	Pens & Art Supplies	0.56
\N	3530	Avery 51	Bill Eplett	4096	53.58	6.3	0.5	Quebec	Labels	0.39
\N	3531	Avery 49	Ben Wallace	4769	48.63	2.88	0.5	Quebec	Labels	0.36
\N	3532	Fellowes Twister Kit, Gray/Clear, 3/pkg	Max Engle	4800	-26.17	8.04	8.94	Quebec	Binders and Binder Accessories	0.4
\N	3533	Avery 493	Max Engle	4800	40.88	4.91	0.5	Quebec	Labels	0.36
\N	3534	Newell 309	Max Engle	4800	-4.28	11.55	2.36	Quebec	Pens & Art Supplies	0.55
\N	3535	Belkin Premiere Surge Master II 8-outlet surge protector	Fred Chung	5543	138.46	48.58	3.99	Quebec	Appliances	0.56
\N	3536	Speediset Carbonless Redi-Letter® 7" x 8 1/2"	Fred Chung	5543	11.06	10.31	1.79	Quebec	Paper	0.38
\N	3537	*Staples* Letter Opener	Fred Chung	5543	-115.38	2.18	5	Quebec	Scissors, Rulers and Trimmers	0.81
\N	3538	Dixon My First Ticonderoga Pencil, #2	Dennis Kane	5636	-1.09	5.85	2.27	Quebec	Pens & Art Supplies	0.56
\N	3539	Lexmark Z25 Color Inkjet Printer	Phillip Flathmann	6050	-219.78	80.97	33.6	Quebec	Office Machines	0.37
\N	3540	Hon 2111 Invitation™ Series Corner Table	Phillip Flathmann	6050	-505.98	209.37	69	Quebec	Tables	0.79
\N	3541	Eldon Expressions Punched Metal & Wood Desk Accessories, Pewter & Cherry	Mathew Reese	6148	-29.4	10.64	5.16	Quebec	Office Furnishings	0.57
\N	3542	Seth Thomas 8 1/2" Cubicle Clock	Mathew Reese	6148	116.37	20.28	6.68	Quebec	Office Furnishings	0.53
\N	3543	Avery 498	Stuart Van	6727	8.47	2.89	0.5	Quebec	Labels	0.38
\N	3544	Hon 2090 “Pillow Soft” Series Mid Back Swivel/Tilt Chairs	Brenda Bowman	7079	-416.7	280.98	57	Quebec	Chairs & Chairmats	0.78
\N	3545	Eureka Recycled Copy Paper 8 1/2" x 11", Ream	Brenda Bowman	7079	-34.91	6.48	5.94	Quebec	Paper	0.37
\N	3546	6000	Logan Haushalter	7301	124.99	65.99	2.5	Quebec	Telephones and Communication	0.55
\N	3547	Honeywell Enviracaire Portable HEPA Air Cleaner for 17' x 22' Room	Sheri Gordon	7623	1603.12	300.65	24.49	Quebec	Appliances	0.52
\N	3548	US Robotics 56K V.92 Internal PCI Faxmodem	Sheri Gordon	7623	21.5	49.99	19.99	Quebec	Computer Peripherals	0.45
\N	3549	Xerox 1941	Sheri Gordon	7623	1480.15	104.85	4.65	Quebec	Paper	0.37
\N	3550	GBC Prepunched Paper, 19-Hole, for Binding Systems, 24-lb	John Stevenson	8000	-26.81	15.01	8.4	Quebec	Binders and Binder Accessories	0.39
\N	3551	Wilson Jones Turn Tabs Binder Tool for Ring Binders	John Stevenson	8000	-7.61	4.82	5.24	Quebec	Binders and Binder Accessories	0.39
\N	3552	Staples Colored Interoffice Envelopes	Phillip Flathmann	8039	3.22	30.98	19.51	Quebec	Envelopes	0.36
\N	3553	Belkin MediaBoard 104- Keyboard	Mathew Reese	8162	-82.26	27.48	4	Quebec	Computer Peripherals	0.75
\N	3554	Motorola SB4200 Cable Modem	Mathew Reese	8162	1314.12	179.99	19.99	Quebec	Computer Peripherals	0.48
\N	3555	Fellowes Strictly Business® Drawer File, Letter/Legal Size	Mathew Reese	8162	10.86	140.85	19.99	Quebec	Storage & Organization	0.73
\N	3556	Xerox 19	Mathew Reese	8870	117.39	30.98	5.09	Quebec	Paper	0.4
\N	3557	Howard Miller 13" Diameter Goldtone Round Wall Clock	Daniel Lacy	9253	563.09	46.94	6.77	Quebec	Office Furnishings	0.44
\N	3558	Xerox 199	Dorris Love	10722	-27.44	4.28	5.68	Quebec	Paper	0.4
\N	3559	GE 48" Fluorescent Tube, Cool White Energy Saver, 34 Watts, 30/Box	Ben Wallace	11527	2860.71	99.23	8.99	Quebec	Office Furnishings	0.35
\N	3560	i1000	Fred Chung	11683	335.08	65.99	5.99	Quebec	Telephones and Communication	0.58
\N	3561	GBC Plastic Binding Combs	Dennis Kane	12448	-269.8	7.38	11.51	Quebec	Binders and Binder Accessories	0.36
\N	3562	Global Commerce™ Series High-Back Swivel/Tilt Chairs	Dennis Kane	12448	459.5	284.98	69.55	Quebec	Chairs & Chairmats	0.6
\N	3563	Xerox 1932	Stuart Van	13028	562.92	35.44	5.09	Quebec	Paper	0.38
\N	3564	Eldon Radial Chair Mat for Low to Medium Pile Carpets	Jennifer Ferguson	13156	159.73	39.98	9.2	Quebec	Office Furnishings	0.65
\N	3565	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Pamela Stobb	13252	1279.37	160.98	30	Quebec	Chairs & Chairmats	0.62
\N	3566	Logitech Access Keyboard	Pamela Stobb	13252	154.65	15.98	4	Quebec	Computer Peripherals	0.37
\N	3567	Avery 510	Theresa Swint	13540	51.21	3.75	0.5	Quebec	Labels	0.37
\N	3568	T193	Theresa Swint	13540	239.25	65.99	4.99	Quebec	Telephones and Communication	0.57
\N	3569	Hon 61000 Series Interactive Training Tables	Alan Haines	14081	-1401.17	44.43	46.59	Quebec	Tables	0.67
\N	3570	O'Sullivan Elevations Bookcase, Cherry Finish	Alan Haines	14086	-383.5	130.98	54.74	Quebec	Bookcases	0.69
\N	3571	TOPS Voice Message Log Book, Flash Format	Alan Haines	14086	-7.36	4.76	3.01	Quebec	Paper	0.36
\N	3572	Global Leather Task Chair, Black	Dennis Kane	14435	-605.52	89.99	42	Quebec	Chairs & Chairmats	0.66
\N	3573	Canon imageCLASS 2200 Advanced Copier	Dennis Kane	14435	3992.52	3499.99	24.49	Quebec	Copiers and Fax	0.37
\N	3574	IBM Multi-Purpose Copy Paper, 8 1/2 x 11", Case	Dennis Kane	14435	439.26	30.98	5.76	Quebec	Paper	0.4
\N	3575	Hon 61000 Series Interactive Training Tables	Brenda Bowman	14784	33.99	44.43	46.59	Quebec	Tables	0.67
\N	3576	Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind	Ben Wallace	15264	-408.22	1270.99	19.99	Quebec	Binders and Binder Accessories	0.35
\N	3577	Self-Adhesive Address Labels for Typewriters by Universal	Ben Wallace	15264	33.05	7.31	0.49	Quebec	Labels	0.38
\N	3578	Xerox 1966	Logan Haushalter	16352	-43.43	6.48	6.65	Quebec	Paper	0.36
\N	3579	Global Leather & Oak Executive Chair, Burgundy	Dennis Kane	16513	-423.2	150.89	60.2	Quebec	Chairs & Chairmats	0.77
\N	3580	Chromcraft 48" x 96" Racetrack Double Pedestal Table	Katherine Nockton	16582	-774.89	320.64	43.57	Quebec	Tables	0.63
\N	3581	Hon Comfortask® Task/Swivel Chairs	Stewart Visinsky	16640	-227.51	113.98	30	Quebec	Chairs & Chairmats	0.69
\N	3582	OIC Thumb-Tacks	Jeremy Farry	16711	-1.72	1.14	0.7	Quebec	Rubber Bands	0.38
\N	3583	Array® Memo Cubes	Clay Ludtke	17218	22.54	5.18	2.04	Quebec	Paper	0.36
\N	3584	Staples File Caddy	Dorris Love	17255	-75.22	9.38	7.28	Quebec	Storage & Organization	0.57
\N	3585	Grip Seal Envelopes	Laurel Elliston	17317	-20.87	4.42	4.99	Quebec	Envelopes	0.38
\N	3586	US Robotics 56K V.92 External Faxmodem	Katherine Nockton	17414	448.07	99.99	19.99	Quebec	Computer Peripherals	0.52
\N	3587	Xerox 188	Katherine Nockton	17414	34.29	11.34	5.01	Quebec	Paper	0.36
\N	3588	Acme® Elite Stainless Steel Scissors	Ben Wallace	17446	8.75	8.34	2.64	Quebec	Scissors, Rulers and Trimmers	0.59
\N	3589	Peel & Stick Add-On Corner Pockets	Dennis Kane	17765	-192.68	2.16	6.05	Quebec	Binders and Binder Accessories	0.37
\N	3590	Computer Room Manger, 14"	Jasper Cacioppo	17958	359.53	32.48	7.09	Quebec	Office Furnishings	0.49
\N	3591	Avery 510	Theresa Swint	18375	31.64	3.75	0.5	Quebec	Labels	0.37
\N	3592	Elite 5" Scissors	Jasper Cacioppo	18532	-146.24	8.45	7.77	Quebec	Scissors, Rulers and Trimmers	0.55
\N	3593	Decoflex Hanging Personal Folder File, Blue	Jasper Cacioppo	18532	-131.59	15.42	10.68	Quebec	Storage & Organization	0.58
\N	3594	Avery 487	Phillip Flathmann	18627	0.71	3.69	0.5	Quebec	Labels	0.38
\N	3595	Belkin Premiere Surge Master II 8-outlet surge protector	Jeremy Lonsdale	18816	108.96	48.58	3.99	Quebec	Appliances	0.56
\N	3596	Xerox 1936	Theresa Swint	18852	80.73	19.98	5.97	Quebec	Paper	0.38
\N	3597	Staples Plastic Wall Frames	Max Engle	19329	-6.39	7.96	4.95	Quebec	Office Furnishings	0.41
\N	3598	KF 788	Max Engle	19329	-155.95	45.99	4.99	Quebec	Telephones and Communication	0.56
\N	3599	Durable Pressboard Binders	Alan Haines	19522	21.34	3.8	1.49	Quebec	Binders and Binder Accessories	0.38
\N	3600	Newell 310	Alan Haines	19522	-1.53	1.76	0.7	Quebec	Pens & Art Supplies	0.56
\N	3601	Acme® Office Executive Series Stainless Steel Trimmers	Mitch Webber	19811	-115.1	8.57	6.14	Quebec	Scissors, Rulers and Trimmers	0.59
\N	3602	Staples SlimLine Pencil Sharpener	Tom Stivers	19841	-31.74	11.97	5.81	Quebec	Pens & Art Supplies	0.6
\N	3603	688	Tom Stivers	19841	-557.95	195.99	4.2	Quebec	Telephones and Communication	0.6
\N	3604	Filing/Storage Totes and Swivel Casters	Mathew Reese	19874	-182.52	9.71	9.45	Quebec	Storage & Organization	0.6
\N	3605	Accessory31	Shirley Schmidt	20003	-88.94	35.99	0.99	Quebec	Telephones and Communication	0.35
\N	3606	Avery Durable Poly Binders	Carol Triggs	20068	-46.13	5.53	6.98	Quebec	Binders and Binder Accessories	0.39
\N	3607	GBC Clear Cover, 8-1/2 x 11, unpunched, 25 covers per pack	Helen Wasserman	20162	-254.14	15.16	15.09	Quebec	Binders and Binder Accessories	0.39
\N	3608	Self-Adhesive Removable Labels	Logan Haushalter	20354	30.03	3.15	0.49	Quebec	Labels	0.37
\N	3609	Project Tote Personal File	Mitch Webber	20384	-148.26	14.03	9.37	Quebec	Storage & Organization	0.56
\N	3610	Bush Advantage Collection® Round Conference Table	Mitch Webber	20384	-513.79	212.6	110.2	Quebec	Tables	0.73
\N	3611	Imation 3.5" IBM-Formatted Diskettes, 10/Pack	Dennis Kane	20710	-94.61	5.98	3.85	Quebec	Computer Peripherals	0.68
\N	3612	Avery 494	Dennis Kane	20710	22.71	2.61	0.5	Quebec	Labels	0.39
\N	3613	Accessory9	Justin Hirsh	20807	82.82	35.99	3.3	Quebec	Telephones and Communication	0.39
\N	3614	Panasonic KX-P1131 Dot Matrix Printer	Bill Eplett	20934	-577.48	264.98	17.86	Quebec	Office Machines	0.58
\N	3615	80 Minute CD-R Spindle, 100/Pack - Staples	Justin MacKendrick	21057	253.61	39.48	1.99	Quebec	Computer Peripherals	0.54
\N	3616	Tyvek ® Top-Opening Peel & Seel ® Envelopes, Gray	Aaron Smayling	21190	401.8	35.94	6.66	Quebec	Envelopes	0.4
\N	3617	Global Commerce™ Series High-Back Swivel/Tilt Chairs	Jennifer Ferguson	21505	-379.22	284.98	69.55	Quebec	Chairs & Chairmats	0.6
\N	3618	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Stewart Visinsky	22055	632.98	160.98	30	Quebec	Chairs & Chairmats	0.62
\N	3619	GBC Plastic Binding Combs	Phillip Flathmann	22371	-66.17	7.38	11.51	Quebec	Binders and Binder Accessories	0.36
\N	3620	BASF Silver 74 Minute CD-R	Sarah Brown	22498	-30.7	1.7	1.99	Quebec	Computer Peripherals	0.51
\N	3621	Panasonic KX-P2130 Dot Matrix Printer	Jennifer Ferguson	22562	1981.17	213.45	14.7	Quebec	Office Machines	0.59
\N	3622	Xerox 1882	Jennifer Ferguson	22562	518.07	55.98	13.88	Quebec	Paper	0.36
\N	3623	Letter/Legal File Tote with Clear Snap-On Lid, Black Granite	Jennifer Ferguson	22562	-28.09	16.06	8.34	Quebec	Storage & Organization	0.59
\N	3624	Hon 2111 Invitation™ Series Corner Table	Jennifer Ferguson	23392	-505.98	209.37	69	Quebec	Tables	0.79
\N	3625	Global Troy™ Executive Leather Low-Back Tilter	Justin MacKendrick	23782	5365.43	500.98	26	Quebec	Chairs & Chairmats	0.6
\N	3626	Tennsco Commercial Shelving	Justin MacKendrick	23782	-194.85	20.34	35	Quebec	Storage & Organization	0.84
\N	3627	Bretford Rectangular Conference Table Tops	Anne Pryor	24069	-592.52	376.13	85.63	Quebec	Tables	0.74
\N	3628	Logitech Internet Navigator Keyboard	Max Engle	24099	-135.51	30.98	6.5	Quebec	Computer Peripherals	0.79
\N	3629	Tennsco Commercial Shelving	Max Engle	24099	-1049.26	20.34	35	Quebec	Storage & Organization	0.84
\N	3630	Super Bands, 12/Pack	Anne Pryor	24228	-66.62	1.86	2.58	Quebec	Rubber Bands	0.82
\N	3632	Hewlett Packard LaserJet 3310 Copier	Jasper Cacioppo	24613	2752.11	599.99	24.49	Quebec	Copiers and Fax	0.37
\N	3633	Xerox 21	Jasper Cacioppo	24613	-90.08	6.48	6.6	Quebec	Paper	0.37
\N	3634	Prismacolor Color Pencil Set	Jasper Cacioppo	24613	237.75	19.84	4.1	Quebec	Pens & Art Supplies	0.44
\N	3635	Polycom Soundstation EX Audio-Conferencing Telephone, Black	Mitch Webber	24647	-1820	999.99	13.99	Quebec	Office Machines	0.36
\N	3636	Xerox 23	Mitch Webber	24647	-28.2	6.48	5.14	Quebec	Paper	0.37
\N	3637	Master Giant Foot® Doorstop, Safety Yellow	Stuart Van	24672	23.41	7.59	4	Quebec	Office Furnishings	0.42
\N	3638	Wirebound Message Book, 4 per Page	Stuart Van	24672	74.58	5.43	0.95	Quebec	Paper	0.36
\N	3639	Tennsco Snap-Together Open Shelving Units, Starter Sets and Add-On Units	Stuart Van	24672	406.37	279.48	35	Quebec	Storage & Organization	0.8
\N	3640	Deflect-o RollaMat Studded, Beveled Mat for Medium Pile Carpeting	Logan Haushalter	24740	160.48	92.23	39.61	Quebec	Office Furnishings	0.67
\N	3641	Newell 35	Logan Haushalter	24740	-126.7	3.28	5	Quebec	Pens & Art Supplies	0.56
\N	3642	Accessory8	Bill Eplett	25479	-315.33	85.99	1.25	Quebec	Telephones and Communication	0.39
\N	3643	Ultra Door Push Plate	Tony Sayre	25985	-39.71	4.91	3.05	Quebec	Office Furnishings	0.52
\N	3644	Staples Bulldog Clip	Tony Sayre	25985	25.18	3.78	0.71	Quebec	Rubber Bands	0.39
\N	3645	Bevis 36 x 72 Conference Tables	Karen Ferguson	26341	-281.22	124.49	51.94	Quebec	Tables	0.63
\N	3646	Tennsco Snap-Together Open Shelving Units, Starter Sets and Add-On Units	Karen Ferguson	26407	171.3	279.48	35	Quebec	Storage & Organization	0.8
\N	3647	R280	Karen Ferguson	26407	35.65	155.99	8.99	Quebec	Telephones and Communication	0.55
\N	3648	Fellowes Superior 10 Outlet Split Surge Protector	Logan Haushalter	26432	389.67	38.06	4.5	Quebec	Appliances	0.56
\N	3649	Hewlett Packard LaserJet 3310 Copier	Logan Haushalter	26432	11630.15	599.99	24.49	Quebec	Copiers and Fax	0.37
\N	3650	Unpadded Memo Slips	Logan Haushalter	26432	-10.77	3.98	2.97	Quebec	Paper	0.35
\N	3651	Xerox 210	Logan Haushalter	26630	-35.2	6.48	7.37	Quebec	Paper	0.37
\N	3652	Recycled Desk Saver Line "While You Were Out" Book, 5 1/2" X 4"	Carol Triggs	26660	-4.22	8.95	2.01	Quebec	Paper	0.39
\N	3653	GBC Standard Plastic Binding Systems Combs	Dionis Lloyd	26818	-19.48	8.85	5.6	Quebec	Binders and Binder Accessories	0.36
\N	3654	Staples 6 Outlet Surge	Dionis Lloyd	26818	-5.16	11.97	4.98	Quebec	Appliances	0.58
\N	3655	Angle-D Binders with Locking Rings, Label Holders	Dionis Lloyd	26818	-162.2	7.3	7.72	Quebec	Binders and Binder Accessories	0.38
\N	3656	White Business Envelopes with Contemporary Seam, Recycled White Business Envelopes	Anne Pryor	27011	5.69	10.94	1.39	Quebec	Envelopes	0.35
\N	3657	Sanford EarthWrite® Recycled Pencils, Medium Soft, #2	Caroline Jumper	27841	1.05	2.1	0.7	Quebec	Pens & Art Supplies	0.57
\N	3658	GBC Standard Therm-A-Bind Covers	Carol Triggs	28581	-41.56	24.92	12.98	Quebec	Binders and Binder Accessories	0.39
\N	3659	Rediform S.O.S. Phone Message Books	Carol Triggs	28581	73.05	4.98	0.8	Quebec	Paper	0.36
\N	3660	GBC DocuBind 300 Electric Binding Machine	Alan Haines	28611	6670.41	525.98	19.99	Quebec	Binders and Binder Accessories	0.37
\N	3661	5185	Alan Haines	28611	707.17	115.99	8.99	Quebec	Telephones and Communication	0.58
\N	3662	Laminate Occasional Tables	Carol Triggs	28647	-1763.75	154.13	69	Quebec	Tables	0.68
\N	3663	Xerox 1893	Lindsay Castell	28736	109.16	40.99	17.48	Quebec	Paper	0.36
\N	3664	Hot File® 7-Pocket, Floor Stand	Phillip Flathmann	28835	-112.44	178.47	19.99	Quebec	Storage & Organization	0.55
\N	3665	Ibico Ibimaster 300 Manual Binding System	Logan Haushalter	29220	5045.3	367.99	19.99	Quebec	Binders and Binder Accessories	0.4
\N	3666	Canon PC1060 Personal Laser Copier	Caroline Jumper	30114	-362.88	699.99	24.49	Quebec	Copiers and Fax	0.41
\N	3667	Fellowes Staxonsteel® Drawer Files	Caroline Jumper	30336	368.79	193.17	19.99	Quebec	Storage & Organization	0.71
\N	3668	Canon PC940 Copier	Dennis Kane	30725	5638.75	449.99	49	Quebec	Copiers and Fax	0.38
\N	3669	Hon Metal Bookcases, Black	Tom Stivers	30784	-127.94	70.98	26.74	Quebec	Bookcases	0.6
\N	3670	Turquoise Lead Holder with Pocket Clip	Tom Stivers	30784	80.13	6.7	1.56	Quebec	Pens & Art Supplies	0.52
\N	3671	Microsoft Natural Keyboard Elite	Caroline Jumper	31040	-22.63	39.98	4	Quebec	Computer Peripherals	0.7
\N	3672	Acco Perma® 2700 Stacking Storage Drawers	Caroline Jumper	31040	-35.47	29.74	6.64	Quebec	Storage & Organization	0.7
\N	3673	Metal Folding Chairs, Beige, 4/Carton	Jennifer Ferguson	31846	-78.84	33.94	19.19	Quebec	Chairs & Chairmats	0.58
\N	3674	Harmony HEPA Quiet Air Purifiers	Stuart Van	32038	-14.06	11.7	6.96	Quebec	Appliances	0.5
\N	3675	Canon P1-DHIII Palm Printing Calculator	Laurel Elliston	32065	-12.35	17.98	8.51	Quebec	Office Machines	0.4
\N	3676	Telescoping Adjustable Floor Lamp	Jason Klamczynski	32326	-188.41	19.99	11.17	Quebec	Office Furnishings	0.6
\N	3677	Boston 1645 Deluxe Heavier-Duty Electric Pencil Sharpener	Michael Chen	32613	202.33	43.98	8.99	Quebec	Pens & Art Supplies	0.58
\N	3678	Tennsco Stur-D-Stor Boltless Shelving, 5 Shelves, 24" Deep, Sand	Michael Chen	32613	-691.52	135.31	35	Quebec	Storage & Organization	0.84
\N	3679	R380	Michael Chen	32613	2373.24	195.99	3.99	Quebec	Telephones and Communication	0.58
\N	3680	Filing/Storage Totes and Swivel Casters	Bill Eplett	32741	-81.77	9.71	9.45	Quebec	Storage & Organization	0.6
\N	3681	Eldon Jumbo ProFile™ Portable File Boxes Graphite/Black	Daniel Lacy	32903	-118.75	15.31	8.78	Quebec	Storage & Organization	0.57
\N	3682	Westinghouse Floor Lamp with Metal Mesh Shade, Black	Tony Sayre	33031	-134.63	23.99	15.68	Quebec	Office Furnishings	0.62
\N	3683	Xerox 1966	Tony Sayre	33031	-53.69	6.48	6.65	Quebec	Paper	0.36
\N	3684	R280	Caroline Jumper	33152	398.01	155.99	8.99	Quebec	Telephones and Communication	0.55
\N	3685	Keytronic French Keyboard	Dennis Kane	33217	-229.87	73.98	4	Quebec	Computer Peripherals	0.79
\N	3686	Canon MP25DIII Desktop Whisper-Quiet Printing Calculator	Dennis Kane	33217	599.04	51.98	10.17	Quebec	Office Machines	0.37
\N	3687	Eldon® 400 Class™ Desk Accessories, Black Carbon	Theresa Swint	33606	-138.39	8.75	8.54	Quebec	Office Furnishings	0.43
\N	3688	Hon 2111 Invitation™ Series Corner Table	Theresa Swint	33666	-861.3	209.37	69	Quebec	Tables	0.79
\N	3689	SANFORD Major Accent™ Highlighters	Tony Sayre	33764	35.98	7.08	2.35	Quebec	Pens & Art Supplies	0.47
\N	3690	Global Deluxe Stacking Chair, Gray	Daniel Lacy	33921	196.21	50.98	14.19	Quebec	Chairs & Chairmats	0.56
\N	3691	Master Giant Foot® Doorstop, Safety Yellow	Aaron Smayling	33956	31.32	7.59	4	Quebec	Office Furnishings	0.42
\N	3692	G.E. Longer-Life Indoor Recessed Floodlight Bulbs	Jason Klamczynski	34022	12.74	6.64	4.95	Quebec	Office Furnishings	0.37
\N	3693	Ultra Door Push Plate	Jason Klamczynski	34022	-34.06	4.91	3.05	Quebec	Office Furnishings	0.52
\N	3694	Avery 491	Theresa Swint	34148	42.71	4.13	0.99	Quebec	Labels	0.39
\N	3695	Ultra Door Pull Handle	Karen Ferguson	34182	-89.9	10.52	7.94	Quebec	Office Furnishings	0.52
\N	3696	GE 48" Fluorescent Tube, Cool White Energy Saver, 34 Watts, 30/Box	Bill Eplett	34337	2235.37	99.23	8.99	Quebec	Office Furnishings	0.35
\N	3697	Staples Colored Interoffice Envelopes	Fred Chung	34657	-75.7	30.98	19.51	Quebec	Envelopes	0.36
\N	3698	Fellowes Twister Kit, Gray/Clear, 3/pkg	Dorris Love	34727	-114.41	8.04	8.94	Quebec	Binders and Binder Accessories	0.4
\N	3699	Cardinal Holdit Business Card Pockets	Caroline Jumper	34881	-85.01	4.98	4.95	Quebec	Binders and Binder Accessories	0.37
\N	3700	Staples® General Use 3-Ring Binders	Carol Triggs	34882	-15.1	1.88	1.49	Quebec	Binders and Binder Accessories	0.37
\N	3701	Magna Visual Magnetic Picture Hangers	Theresa Swint	34916	10.04	4.82	5.72	Quebec	Office Furnishings	0.47
\N	3702	GBC Clear Cover, 8-1/2 x 11, unpunched, 25 covers per pack	Jasper Cacioppo	35041	-200.86	15.16	15.09	Quebec	Binders and Binder Accessories	0.39
\N	3703	IBM Multi-Purpose Copy Paper, 8 1/2 x 11", Case	Dennis Kane	35302	17.57	30.98	5.76	Quebec	Paper	0.4
\N	3704	StarTAC 3000	Dennis Kane	35302	-228.18	125.99	7.69	Quebec	Telephones and Communication	0.59
\N	3705	#6 3/4 Gummed Flap White Envelopes	Mathew Reese	35841	94.39	9.9	1.39	Quebec	Envelopes	0.37
\N	3706	M3682	Mathew Reese	35841	1448.33	125.99	8.08	Quebec	Telephones and Communication	0.57
\N	3707	Newell 326	Clay Ludtke	36034	-1.02	1.76	0.7	Quebec	Pens & Art Supplies	0.56
\N	3708	Brown Kraft Recycled Envelopes	Dionis Lloyd	36065	-63.98	16.98	12.39	Quebec	Envelopes	0.35
\N	3709	3M Organizer Strips	Anne Pryor	36355	-42.98	5.4	7.78	Quebec	Binders and Binder Accessories	0.37
\N	3710	Seth Thomas 8 1/2" Cubicle Clock	Anne Pryor	36355	65.49	20.28	6.68	Quebec	Office Furnishings	0.53
\N	3711	Newell 309	Anne Pryor	36355	15.73	11.55	2.36	Quebec	Pens & Art Supplies	0.55
\N	3712	Kleencut® Forged Office Shears by Acme United Corporation	Anne Pryor	36355	-72.5	2.08	2.56	Quebec	Scissors, Rulers and Trimmers	0.55
\N	3713	Fellowes Internet Keyboard, Platinum	Dorris Love	36358	-159.25	30.42	8.65	Quebec	Computer Peripherals	0.74
\N	3714	Snap-A-Way® Black Print Carbonless Ruled Speed Letter, Triplicate	Dorris Love	36358	318.25	37.94	5.08	Quebec	Paper	0.38
\N	3715	Ibico Presentation Index for Binding Systems	Pamela Stobb	36739	-55.52	3.98	5.26	Quebec	Binders and Binder Accessories	0.38
\N	3716	Aluminum Document Frame	Pamela Stobb	36739	97.19	12.22	2.85	Quebec	Office Furnishings	0.55
\N	3717	Master Giant Foot® Doorstop, Safety Yellow	Laurel Elliston	36743	-10.61	7.59	4	Quebec	Office Furnishings	0.42
\N	3718	Zebra Zazzle Fluorescent Highlighters	Toby Carlisle	36864	7.23	6.08	0.91	Quebec	Pens & Art Supplies	0.51
\N	3719	Xerox 198	Carol Triggs	37188	-123.28	4.98	8.33	Quebec	Paper	0.38
\N	3720	Chromcraft Bull-Nose Wood 48" x 96" Rectangular Conference Tables	Ben Wallace	37414	-1331.55	550.98	64.59	Quebec	Tables	0.66
\N	3721	Avery 05222 Permanent Self-Adhesive File Folder Labels for Typewriters, on Rolls, White, 250/Roll	Aaron Smayling	37638	-140.54	4.13	6.89	Quebec	Labels	0.39
\N	3722	Gyration Ultra Cordless Optical Suite	Mathew Reese	37734	84.15	100.97	7.18	Quebec	Computer Peripherals	0.46
\N	3723	Electrix 20W Halogen Replacement Bulb for Zoom-In Desk Lamp	Mathew Reese	37734	171.98	13.4	4.95	Quebec	Office Furnishings	0.37
\N	3724	Storex Dura Pro™ Binders	Alan Haines	37763	-211.06	5.94	9.92	Quebec	Binders and Binder Accessories	0.38
\N	3725	6190	Alan Haines	37763	186.42	65.99	2.5	Quebec	Telephones and Communication	0.55
\N	3726	Xerox 188	Tom Stivers	37859	-11.83	11.34	5.01	Quebec	Paper	0.36
\N	3727	2190	Ted Butterfield	38048	478.11	65.99	5.63	Quebec	Telephones and Communication	0.56
\N	3728	DAX Cubicle Frames - 8x10	Ted Butterfield	38048	-136.84	5.77	5.92	Quebec	Office Furnishings	0.55
\N	3729	300 Series Non-Flip	Michael Chen	38305	88.77	155.99	8.08	Quebec	Telephones and Communication	0.6
\N	3730	Micro Innovations Micro Digital Wireless Keyboard and Mouse, Gray	Dennis Kane	38371	544.3	83.1	6.13	Quebec	Computer Peripherals	0.45
\N	3731	Eldon Expressions Punched Metal & Wood Desk Accessories, Pewter & Cherry	Mathew Reese	38789	16.78	10.64	5.16	Quebec	Office Furnishings	0.57
\N	3732	Westinghouse Floor Lamp with Metal Mesh Shade, Black	Mathew Reese	38789	40.93	23.99	15.68	Quebec	Office Furnishings	0.62
\N	3733	Xerox 1928	Tom Stivers	39076	-131.16	5.28	6.26	Quebec	Paper	0.4
\N	3734	Stockwell Push Pins	Jason Klamczynski	39173	3.23	2.18	0.78	Quebec	Rubber Bands	0.52
\N	3735	Bevis Round Conference Table Top, X-Base	Jason Klamczynski	39173	-433.29	179.29	29.21	Quebec	Tables	0.76
\N	3736	Imation Primaris 3.5" 2HD Unformatted Diskettes, 10/Pack	Mitch Webber	39335	-45.64	4.77	2.39	Quebec	Computer Peripherals	0.72
\N	3737	Tyvek ® Top-Opening Peel & Seel Envelopes, Plain White	Mitch Webber	39335	204.49	27.18	8.23	Quebec	Envelopes	0.38
\N	3738	Riverleaf Stik-Withit® Designer Note Cubes®	Anne Pryor	39744	7.59	10.06	2.06	Quebec	Paper	0.39
\N	3739	252	Anne Pryor	39744	-107.99	65.99	5.92	Quebec	Telephones and Communication	0.55
\N	3740	CF 688	Anne Pryor	39744	1595.67	155.99	8.99	Quebec	Telephones and Communication	0.58
\N	3741	Iceberg OfficeWorks 42" Round Tables	Sheri Gordon	39878	-375.33	150.98	39.25	Quebec	Tables	0.75
\N	3742	Avery 48	Sheri Gordon	39972	108.49	6.3	0.5	Quebec	Labels	0.39
\N	3743	Avery 501	Sheri Gordon	39972	62.73	3.69	0.5	Quebec	Labels	0.38
\N	3744	Wilson Jones Standard D-Ring Binders	Sheri Gordon	39972	-7.36	5.06	2.99	Quebec	Binders and Binder Accessories	0.38
\N	3745	Peel & Seel® Recycled Catalog Envelopes, Brown	Ben Wallace	40643	10.8	11.58	5.72	Quebec	Envelopes	0.35
\N	3746	Gyration Ultra Professional Cordless Optical Suite	Justin MacKendrick	40870	4833.27	300.97	7.18	Quebec	Computer Peripherals	0.48
\N	3747	Eldon® 300 Class™ Desk Accessories, Black	Justin MacKendrick	40870	-64.05	4.95	5.32	Quebec	Office Furnishings	0.41
\N	3749	600 Series Non-Flip	Carol Triggs	40934	-107.5	45.99	4.99	Quebec	Telephones and Communication	0.57
\N	3750	Tenex Contemporary Contur Chairmats for Low and Medium Pile Carpet, Computer, 39" x 49"	Mitch Webber	41254	280.64	107.53	5.81	Quebec	Office Furnishings	0.65
\N	3751	Acco PRESSTEX® Data Binder with Storage Hooks, Dark Blue, 9 1/2" X 11"	Helen Wasserman	41472	-214.15	5.38	7.57	Quebec	Binders and Binder Accessories	0.36
\N	3752	Canon S750 Color Inkjet Printer	Deirdre Greer	41830	1841.92	120.97	26.3	Quebec	Office Machines	0.38
\N	3753	Space Solutions Commercial Steel Shelving	Anne Pryor	42144	-326.47	64.65	35	Quebec	Storage & Organization	0.8
\N	3754	Quartet Omega® Colored Chalk, 12/Pack	Pamela Stobb	42439	62.68	5.84	1	Quebec	Pens & Art Supplies	0.38
\N	3755	Adesso Programmable 142-Key Keyboard	Nora Price	42758	-333.69	152.48	4	Quebec	Computer Peripherals	0.79
\N	3756	White GlueTop Scratch Pads	Nora Price	42758	278.89	15.04	1.97	Quebec	Paper	0.39
\N	3757	Ibico Covers for Plastic or Wire Binding Elements	Logan Haushalter	42918	-2.38	11.5	7.19	Quebec	Binders and Binder Accessories	0.4
\N	3758	Accessory13	Theresa Swint	42950	303.4	35.99	1.25	Quebec	Telephones and Communication	0.57
\N	3759	StarTAC 6500	Toby Carlisle	42951	165.45	125.99	8.8	Quebec	Telephones and Communication	0.59
\N	3760	Binder Clips by OIC	Liz Willingham	43172	1.68	1.48	0.7	Quebec	Rubber Bands	0.37
\N	3761	Avery 503	Sarah Brown	43270	154.54	10.35	0.99	Quebec	Labels	0.37
\N	3762	12 Colored Short Pencils	Brenda Bowman	43271	-5.27	2.6	2.4	Quebec	Pens & Art Supplies	0.58
\N	3763	Belkin 5 Outlet SurgeMaster™ Power Centers	Laurel Elliston	43745	946.7	54.48	0.99	Quebec	Appliances	0.57
\N	3764	Microsoft Natural Multimedia Keyboard	Laurel Elliston	43745	27.51	50.98	6.5	Quebec	Computer Peripherals	0.73
\N	3765	Xerox 1968	Laurel Elliston	43745	-106.21	6.68	6.15	Quebec	Paper	0.37
\N	3766	T61	Laurel Elliston	43745	303.3	45.99	2.5	Quebec	Telephones and Communication	0.56
\N	3767	Luxo Professional Fluorescent Magnifier Lamp with Clamp-Mount Base	Lindsay Castell	43779	1397.86	209.84	21.21	Quebec	Office Furnishings	0.59
\N	3768	Tenex Personal Self-Stacking Standard File Box, Black/Gray	Dorris Love	43877	-31.86	16.91	6.25	Quebec	Storage & Organization	0.58
\N	3769	Hon iLevel™ Computer Training Table	Anne Pryor	43907	-1981.55	31.76	45.51	Quebec	Tables	0.65
\N	3770	2160i	Anne Pryor	43940	-215.34	200.99	4.2	Quebec	Telephones and Communication	0.59
\N	3771	Sanford 52201 APSCO Electric Pencil Sharpener	Anne Pryor	43940	176.13	40.97	8.99	Quebec	Pens & Art Supplies	0.59
\N	3772	Newell 312	Alan Haines	44036	61.97	5.84	1.2	Quebec	Pens & Art Supplies	0.55
\N	3773	Deflect-o Glass Clear Studded Chair Mats	Nora Price	44225	632.29	62.18	10.84	Quebec	Office Furnishings	0.63
\N	3774	Acco® Hot Clips™ Clips to Go	Jeremy Farry	44352	8.53	3.29	1.35	Quebec	Rubber Bands	0.4
\N	3775	Eldon® 200 Class™ Desk Accessories, Burgundy	Helen Wasserman	44487	-10.09	6.28	5.29	Quebec	Office Furnishings	0.43
\N	3776	Eldon® Gobal File Keepers	Helen Wasserman	44487	-92.87	15.14	4.53	Quebec	Storage & Organization	0.81
\N	3777	SANFORD Major Accent™ Highlighters	Dennis Kane	44775	30.49	7.08	2.35	Quebec	Pens & Art Supplies	0.47
\N	3778	Newell 326	Liz Willingham	46337	0.62	1.76	0.7	Quebec	Pens & Art Supplies	0.56
\N	3779	Bevis Rectangular Conference Tables	Anne Pryor	46562	-352.79	145.98	46.2	Quebec	Tables	0.69
\N	3780	T28 WORLD	Michael Chen	46597	2463.46	195.99	8.99	Quebec	Telephones and Communication	0.6
\N	3781	GBC Binding covers	Michael Chen	46597	2.43	12.95	4.98	Quebec	Binders and Binder Accessories	0.4
\N	3782	Global High-Back Leather Tilter, Burgundy	Michael Chen	46597	-83.63	122.99	70.2	Quebec	Chairs & Chairmats	0.74
\N	3783	Newell 312	Anne Pryor	46725	10.96	5.84	1.2	Quebec	Pens & Art Supplies	0.55
\N	3784	Tenex Personal Self-Stacking Standard File Box, Black/Gray	Anne Pryor	46725	-24.86	16.91	6.25	Quebec	Storage & Organization	0.58
\N	3785	Xerox 1996	Caroline Jumper	46787	-162.75	6.48	9.17	Quebec	Paper	0.37
\N	3786	Boston KS Multi-Size Manual Pencil Sharpener	Caroline Jumper	46787	-59.83	22.99	8.99	Quebec	Pens & Art Supplies	0.57
\N	3787	Newell 339	Nora Price	46916	5.54	2.78	0.97	Quebec	Pens & Art Supplies	0.59
\N	3788	Xerox 1983	Ben Wallace	47265	-60.83	5.98	5.46	Quebec	Paper	0.36
\N	3789	Mead 1st Gear 2" Zipper Binder, Asst. Colors	Carol Triggs	48487	146.17	12.97	1.49	Quebec	Binders and Binder Accessories	0.35
\N	3790	Hon Deluxe Fabric Upholstered Stacking Chairs	Dionis Lloyd	48774	573.55	243.98	62.94	Quebec	Chairs & Chairmats	0.57
\N	3791	Sensible Storage WireTech Storage Systems	Stuart Van	49381	-531.92	70.98	35	Quebec	Storage & Organization	0.8
\N	3792	Acme® Preferred Stainless Steel Scissors	Jasper Cacioppo	49666	-64.03	5.68	3.6	Quebec	Scissors, Rulers and Trimmers	0.56
\N	3793	Prang Colored Pencils	Fred Chung	49762	23.74	2.94	0.81	Quebec	Pens & Art Supplies	0.4
\N	3794	Eldon® Gobal File Keepers	Brenda Bowman	49831	-58.24	15.14	4.53	Quebec	Storage & Organization	0.81
\N	3795	Hoover Portapower™ Portable Vacuum	Bill Eplett	49892	-1172.75	4.48	49	Quebec	Appliances	0.6
\N	3796	Office Impressions Heavy Duty Welded Shelving & Multimedia Storage Drawers	Helen Wasserman	49988	-222.17	167.27	35	Quebec	Storage & Organization	0.85
\N	3797	Bretford CR8500 Series Meeting Room Furniture	Helen Wasserman	49988	-969.05	400.98	42.52	Quebec	Tables	0.71
\N	3798	ELITE Series	Helen Wasserman	49988	1619.66	205.99	2.79	Quebec	Telephones and Communication	0.58
\N	3799	Avery 508	Liz Willingham	50308	33.58	4.91	0.5	Quebec	Labels	0.36
\N	3800	GBC Imprintable Covers	Shirley Schmidt	50692	43.68	10.98	5.14	Quebec	Binders and Binder Accessories	0.36
\N	3801	Bevis 36 x 72 Conference Tables	Shirley Schmidt	50692	-300.85	124.49	51.94	Quebec	Tables	0.63
\N	3802	Office Star Flex Back Scooter Chair with White Frame	Muhammed Yedwab	50725	-89.9	110.98	30	Quebec	Chairs & Chairmats	0.71
\N	3803	Avery 510	Clay Ludtke	50982	35.62	3.75	0.5	Quebec	Labels	0.37
\N	3804	Martin-Yale Premier Letter Opener	Michael Chen	51008	-59.13	12.88	4.59	Quebec	Scissors, Rulers and Trimmers	0.82
\N	3805	Xerox 1922	Liz Willingham	51463	-18.55	4.98	7.44	Quebec	Paper	0.36
\N	3806	StarTAC Series	Liz Willingham	51463	-147.88	65.99	3.9	Quebec	Telephones and Communication	0.55
\N	3807	Southworth 25% Cotton Linen-Finish Paper & Envelopes	Dorris Love	51943	-53.25	9.06	9.86	Quebec	Paper	0.4
\N	3808	GBC Laser Imprintable Binding System Covers, Desert Sand	Dorris Love	51943	2.13	14.27	7.27	Quebec	Binders and Binder Accessories	0.38
\N	3809	Avery 508	Dorris Love	51943	66.71	4.91	0.5	Quebec	Labels	0.36
\N	3810	Imation Printable White 80 Minute CD-R Spindle, 50/Pack	Justin MacKendrick	52039	840.46	40.98	1.99	Quebec	Computer Peripherals	0.44
\N	3811	Ibico EB-19 Dual Function Manual Binding System	Dennis Kane	52290	149.5	172.99	19.99	Quebec	Binders and Binder Accessories	0.39
\N	3812	T193	Dennis Kane	52290	185.94	65.99	4.99	Quebec	Telephones and Communication	0.57
\N	3813	Executive Impressions 14" Two-Color Numerals Wall Clock	Anne Pryor	52480	173.94	22.72	8.99	Quebec	Office Furnishings	0.44
\N	3814	Gyration Ultra Professional Cordless Optical Suite	Dorris Love	52486	4160.88	300.97	7.18	Quebec	Computer Peripherals	0.48
\N	3815	Kensington 6 Outlet Guardian Standard Surge Protector	Bill Eplett	52519	-29.77	20.48	6.32	Quebec	Appliances	0.58
\N	3816	6120	Bill Eplett	53152	350.36	65.99	8.8	Quebec	Telephones and Communication	0.58
\N	3817	Acco Perma® 2700 Stacking Storage Drawers	Dorris Love	53188	-42.35	29.74	6.64	Quebec	Storage & Organization	0.7
\N	3818	Storex DuraTech Recycled Plastic Frosted Binders	Stewart Visinsky	53223	-10.33	4.24	5.41	Quebec	Binders and Binder Accessories	0.35
\N	3819	Bretford CR4500 Series Slim Rectangular Table	Brenda Bowman	53248	-94.27	348.21	40.19	Quebec	Tables	0.62
\N	3820	Belkin MediaBoard 104- Keyboard	Brenda Bowman	53411	-57.53	27.48	4	Quebec	Computer Peripherals	0.75
\N	3821	Fiskars® Softgrip Scissors	Dorris Love	53668	-10.38	10.98	3.37	Quebec	Scissors, Rulers and Trimmers	0.57
\N	3822	Avery® Durable Plastic 1" Binders	Shirley Schmidt	53730	-144.74	4.54	5.83	Quebec	Binders and Binder Accessories	0.36
\N	3823	Xerox 1887	Jennifer Ferguson	54020	182.63	18.97	5.21	Quebec	Paper	0.37
\N	3824	Xerox 204	Jennifer Ferguson	54020	-140.48	6.48	6.86	Quebec	Paper	0.37
\N	3825	Rediform Wirebound "Phone Memo" Message Book, 11 x 5-3/4	Kimberly Carter	54368	-48.07	7.64	5.83	Quebec	Paper	0.36
\N	3826	Xerox 1952	Kimberly Carter	54368	-48.55	4.98	5.49	Quebec	Paper	0.38
\N	3827	KF 788	Kimberly Carter	54368	383.09	45.99	4.99	Quebec	Telephones and Communication	0.56
\N	3828	Hon 4-Shelf Metal Bookcases	Liz Willingham	54721	151.09	100.98	26.22	Quebec	Bookcases	0.6
\N	3829	Avery 508	Brian Thompson	55013	3.14	4.91	0.5	Quebec	Labels	0.36
\N	3830	Boston 16801 Nautilus™ Battery Pencil Sharpener	Brian Thompson	55013	19.37	22.01	5.53	Quebec	Pens & Art Supplies	0.59
\N	3831	TDK 4.7GB DVD+RW	Stewart Visinsky	55077	-44.39	14.48	1.99	Quebec	Computer Peripherals	0.49
\N	3832	Accessory28	Stewart Visinsky	55077	-283.23	55.99	2.5	Quebec	Telephones and Communication	0.83
\N	3833	Wilson Jones Easy Flow II™ Sheet Lifters	Kimberly Carter	55206	-64.88	1.8	4.79	Quebec	Binders and Binder Accessories	0.37
\N	3834	Timeport L7089	Stewart Visinsky	55492	-126.45	125.99	7.69	Quebec	Telephones and Communication	0.58
\N	3835	Accessory15	Sarah Brown	55744	-44.13	20.99	0.99	Quebec	Telephones and Communication	0.83
\N	3836	Crayola Anti Dust Chalk, 12/Pack	Carol Triggs	55968	0.86	1.82	1	Quebec	Pens & Art Supplies	0.4
\N	3837	Jet-Pak Recycled Peel 'N' Seal Padded Mailers	Mathew Reese	56288	140.35	35.89	14.72	Quebec	Envelopes	0.4
\N	3838	Park Ridge™ Embossed Executive Business Envelopes	Mathew Reese	56288	269.26	15.57	1.39	Quebec	Envelopes	0.38
\N	3839	Panasonic KX-P3626 Dot Matrix Printer	Shirley Daniels	56291	1869.86	517.48	16.63	Quebec	Office Machines	0.59
\N	3840	White GlueTop Scratch Pads	Shirley Daniels	56291	151.4	15.04	1.97	Quebec	Paper	0.39
\N	3841	2300 Heavy-Duty Transfer File Systems by Perma	Shirley Daniels	56291	-37.27	24.98	8.79	Quebec	Storage & Organization	0.66
\N	3842	Xerox 1947	Sheri Gordon	56486	-23.5	5.98	5.35	Quebec	Paper	0.4
\N	3843	GBC Linen Binding Covers	Shirley Daniels	56514	-24.43	30.98	11.63	Quebec	Binders and Binder Accessories	0.37
\N	3844	Xerox 1961	Shirley Daniels	56514	-153.2	4.98	7.54	Quebec	Paper	0.38
\N	3845	Dixon Ticonderoga Core-Lock Colored Pencils, 48-Color Set	Clay Ludtke	56672	77.45	36.55	13.89	Quebec	Pens & Art Supplies	0.41
\N	3846	Barricks Non-Folding Utility Table with Steel Legs, Laminate Tops	Clay Ludtke	56672	65.25	85.29	60	Quebec	Tables	0.56
\N	3847	StarTAC Analog	Clay Ludtke	56672	317.2	65.99	8.99	Quebec	Telephones and Communication	0.6
\N	3848	Bell Sonecor JB700 Caller ID	Dionis Lloyd	56931	-110.59	7.99	5.03	Quebec	Telephones and Communication	0.6
\N	3849	Cardinal Slant-D® Ring Binder, Heavy Gauge Vinyl	Fred Chung	57025	2.29	8.69	2.99	Quebec	Binders and Binder Accessories	0.39
\N	3850	Avery Flip-Chart Easel Binder, Black	Dionis Lloyd	57061	-80.11	22.38	15.1	Quebec	Binders and Binder Accessories	0.38
\N	3851	Avery 51	Dionis Lloyd	57061	6.22	6.3	0.5	Quebec	Labels	0.39
\N	3852	Seth Thomas 13 1/2" Wall Clock	Dionis Lloyd	57061	46.84	17.78	5.03	Quebec	Office Furnishings	0.54
\N	3853	Hunt BOSTON® Vista® Battery-Operated Pencil Sharpener, Black	Alan Haines	57217	-116.02	11.66	7.95	Quebec	Pens & Art Supplies	0.58
\N	3854	Security-Tint Envelopes	Sarah Brown	57504	160.02	7.64	1.39	Quebec	Envelopes	0.36
\N	3855	Boston 1799 Powerhouse™ Electric Pencil Sharpener	Mathew Reese	57666	304.2	25.98	4.08	Quebec	Pens & Art Supplies	0.57
\N	3856	Tennsco Lockers, Gray	Mathew Reese	57666	-2111.36	20.98	53.03	Quebec	Storage & Organization	0.78
\N	3857	Xerox 1997	Dionis Lloyd	58496	-123.94	6.48	10.05	Quebec	Paper	0.37
\N	3858	Balt Split Level Computer Training Table	Dionis Lloyd	58628	-335.32	138.75	52.42	Quebec	Tables	0.74
\N	3859	Rush Hierlooms Collection 1" Thick Stackable Bookcases	Arthur Gainer	58854	583.15	170.98	35.89	Quebec	Bookcases	0.66
\N	3860	1726 Digital Answering Machine	Arthur Gainer	58854	-52.24	20.99	4.81	Quebec	Telephones and Communication	0.58
\N	3861	Sharp AL-1530CS Digital Copier	John Stevenson	58917	6279.18	499.99	24.49	Quebec	Copiers and Fax	0.36
\N	3862	Panasonic KP-310 Heavy-Duty Electric Pencil Sharpener	John Stevenson	58917	-25.96	21.98	2.87	Quebec	Pens & Art Supplies	0.55
\N	3863	GBC Laser Imprintable Binding System Covers, Desert Sand	Aaron Smayling	59104	3.46	14.27	7.27	Quebec	Binders and Binder Accessories	0.38
\N	3864	Staples Gold Paper Clips	Aaron Smayling	59104	2.63	2.98	1.58	Quebec	Rubber Bands	0.39
\N	3865	StarTAC 7797	Aaron Smayling	59104	1016.97	115.99	2.5	Quebec	Telephones and Communication	0.55
\N	3866	Xerox 197	John Stevenson	59937	-32.28	30.98	17.08	Quebec	Paper	0.4
\N	3868	Avery Hi-Liter Pen Style Six-Color Fluorescent Set	Tracy Poddar	386	-1.59	3.85	0.7	Ontario	Pens & Art Supplies	0.44
\N	3869	5190	Stuart Calhoun	416	88.52	65.99	7.69	Ontario	Telephones and Communication	0.59
\N	3870	Global Leather & Oak Executive Chair, Burgundy	Arthur Prichep	513	-684.57	150.89	60.2	Ontario	Chairs & Chairmats	0.77
\N	3871	Portfile® Personal File Boxes	Arthur Prichep	611	-131.27	17.7	9.47	Ontario	Storage & Organization	0.59
\N	3872	Fellowes Binding Cases	Kean Nguyen	802	12.72	11.7	5.63	Ontario	Binders and Binder Accessories	0.4
\N	3873	AT&T Black Trimline Phone, Model 210	Kean Nguyen	802	-52.14	15.99	9.4	Ontario	Office Machines	0.49
\N	3874	DAX Wood Document Frame.	Jim Kriz	960	-22.72	13.73	6.85	Ontario	Office Furnishings	0.54
\N	3875	Global Adaptabilities™ Conference Tables	Jas O'Carroll	965	-679.04	280.98	35.67	Ontario	Tables	0.66
\N	3876	Rubbermaid ClusterMat Chairmats, Mat Size- 66" x 60", Lip 20" x 11" -90 Degree Angle	Stuart Calhoun	1127	1215.28	110.98	13.99	Ontario	Office Furnishings	0.69
\N	3877	Adesso Programmable 142-Key Keyboard	Harold Ryan	1507	126.62	152.48	4	Ontario	Computer Peripherals	0.79
\N	3878	Accessory35	John Lucas	1665	149.17	35.99	1.1	Ontario	Telephones and Communication	0.55
\N	3879	Hon 94000 Series Round Tables	Alejandro Grove	1952	-715.78	296.18	54.12	Ontario	Tables	0.76
\N	3880	Heavy-Duty E-Z-D® Binders	Sam Zeldin	1953	19.59	10.91	2.99	Ontario	Binders and Binder Accessories	0.38
\N	3881	Xerox 1924	Sam Zeldin	2213	-32.27	5.78	8.09	Ontario	Paper	0.36
\N	3882	Holmes Replacement Filter for HEPA Air Cleaner, Large Room	Sally Hughsby	2368	-229.67	14.81	13.32	Ontario	Appliances	0.43
\N	3883	Microsoft Internet Keyboard	Harold Ryan	2560	-84.07	20.97	6.5	Ontario	Computer Peripherals	0.78
\N	3884	Xerox 1952	Harold Ryan	2560	-65.62	4.98	5.49	Ontario	Paper	0.38
\N	3885	Kensington 6 Outlet MasterPiece® HOMEOFFICE Power Control Center	Philip Brown	2754	422.8	90.24	0.99	Ontario	Appliances	0.56
\N	3886	Xerox 1938	Philip Brown	2754	144.05	47.9	5.86	Ontario	Paper	0.37
\N	3887	Large Capacity Hanging Post Binders	Jane Waco	2755	259.07	24.95	2.99	Ontario	Binders and Binder Accessories	0.39
\N	3888	Xerox 1904	Jane Waco	2755	-76.54	6.48	5.86	Ontario	Paper	0.36
\N	3889	Belkin F5C206VTEL 6 Outlet Surge	Sandra Flanagan	3333	162.17	22.98	4.5	Ontario	Appliances	0.55
\N	3890	Xerox 207	Sandra Flanagan	3333	-24.09	6.48	5.4	Ontario	Paper	0.37
\N	3891	Perma STOR-ALL™ Hanging File Box, 13 1/8"W x 12 1/4"D x 10 1/2"H	Steve Nguyen	3460	-95.15	5.98	4.69	Ontario	Storage & Organization	0.68
\N	3892	Avanti 1.7 Cu. Ft. Refrigerator	Herbert Flentye	3591	-100.05	100.98	15.66	Ontario	Appliances	0.57
\N	3893	Global Leather Task Chair, Black	Herbert Flentye	3591	-311.54	89.99	42	Ontario	Chairs & Chairmats	0.66
\N	3894	Snap-A-Way® Black Print Carbonless Ruled Speed Letter, Triplicate	Jas O'Carroll	4006	624.84	37.94	5.08	Ontario	Paper	0.38
\N	3895	Avery 491	Sandra Flanagan	4193	14.42	4.13	0.99	Ontario	Labels	0.39
\N	3896	Executive Impressions 14" Two-Color Numerals Wall Clock	Sandra Flanagan	4193	64.25	22.72	8.99	Ontario	Office Furnishings	0.44
\N	3897	Iceberg OfficeWorks 42" Round Tables	Sandra Flanagan	4387	-388.52	150.98	39.25	Ontario	Tables	0.75
\N	3898	Bevis Round Conference Table Top & Single Column Base	Sandra Flanagan	4512	-353.66	146.34	43.75	Ontario	Tables	0.64
\N	3899	Bevis Round Conference Table Top, X-Base	Liz Willingham	4773	-433.29	179.29	29.21	Ontario	Tables	0.76
\N	3900	Xerox 227	Sally Hughsby	4839	-120.59	6.48	8.73	Ontario	Paper	0.37
\N	3901	*Staples* vLetter Openers, 2/Pack	Xylona Price	4935	-31.95	3.68	1.32	Ontario	Scissors, Rulers and Trimmers	0.83
\N	3902	Smead Adjustable Mobile File Trolley with Lockable Top	John Lucas	6403	6247.95	419.19	19.99	Ontario	Storage & Organization	0.58
\N	3903	i470	Bill Overfelt	6754	191	205.99	5.26	Ontario	Telephones and Communication	0.56
\N	3904	Maxell Pro 80 Minute CD-R, 10/Pack	Sally Hughsby	7619	-24.48	17.48	1.99	Ontario	Computer Peripherals	0.45
\N	3905	Ibico EB-19 Dual Function Manual Binding System	Kean Nguyen	7744	1416.7	172.99	19.99	Ontario	Binders and Binder Accessories	0.39
\N	3906	#10- 4 1/8" x 9 1/2" Security-Tint Envelopes	Kean Nguyen	7744	-3.44	7.64	1.39	Ontario	Envelopes	0.36
\N	3907	Xerox 1977	Stuart Calhoun	8006	-23.34	6.68	5.2	Ontario	Paper	0.37
\N	3908	Quartet Alpha® White Chalk, 12/Pack	John Grady	8224	9.92	2.21	1	Ontario	Pens & Art Supplies	0.38
\N	3909	Accessory37	Jas O'Carroll	8323	-88.25	20.99	2.5	Ontario	Telephones and Communication	0.81
\N	3910	Xerox 1984	Robert Marley	8480	-58.4	6.48	8.74	Ontario	Paper	0.36
\N	3911	Timeport L7089	Robert Marley	8480	-558.42	125.99	7.69	Ontario	Telephones and Communication	0.58
\N	3912	Honeywell Enviracaire® Portable Air Cleaner for up to 8 x 10 Room	John Lucas	9568	748.67	76.72	19.95	Ontario	Appliances	0.54
\N	3913	Mead 1st Gear 2" Zipper Binder, Asst. Colors	Herbert Flentye	9701	25.13	12.97	1.49	Ontario	Binders and Binder Accessories	0.35
\N	3914	T18	Herbert Flentye	9701	-153.92	110.99	2.5	Ontario	Telephones and Communication	0.57
\N	3915	DAX Cubicle Frames - 8x10	Mick Hernandez	9926	-56.97	5.77	5.92	Ontario	Office Furnishings	0.55
\N	3916	Xerox 21	Sally Hughsby	10373	-71.73	6.48	6.6	Ontario	Paper	0.37
\N	3917	Acco Smartsocket® Color-Coded Six-Outlet AC Adapter Model Surge Protectors	Guy Phonely	10470	490.77	44.01	3.5	Ontario	Appliances	0.59
\N	3918	GBC Pre-Punched Binding Paper, Plastic, White, 8-1/2" x 11"	Guy Phonely	10470	-54.61	15.99	13.18	Ontario	Binders and Binder Accessories	0.37
\N	3919	5165	Guy Phonely	10470	333.72	175.99	4.99	Ontario	Telephones and Communication	0.59
\N	3920	Eldon Econocleat® Chair Mats for Low Pile Carpets	Guy Phonely	11111	-59.85	41.47	34.2	Ontario	Office Furnishings	0.73
\N	3921	Xerox 210	Guy Phonely	11111	-119.72	6.48	7.37	Ontario	Paper	0.37
\N	3922	Imation 3.5" IBM-Formatted Diskettes, 10/Pack	Janet Molinari	11173	-95.17	5.98	3.85	Ontario	Computer Peripherals	0.68
\N	3923	Bevis Round Conference Table Top, X-Base	Jay Kimmel	11239	-433.29	179.29	29.21	Ontario	Tables	0.74
\N	3924	Ibico Hi-Tech Manual Binding System	Matt Connell	11396	4842.37	304.99	19.99	Ontario	Binders and Binder Accessories	0.4
\N	3925	Iceberg OfficeWorks 42" Round Tables	Tracy Poddar	11808	25.21	150.98	39.25	Ontario	Tables	0.75
\N	3926	Fellowes Internet Keyboard, Platinum	Tracy Poddar	11874	-82.13	30.42	8.65	Ontario	Computer Peripherals	0.74
\N	3927	Blue String-Tie & Button Interoffice Envelopes, 10 x 13	Tracy Poddar	11874	179.37	39.98	9.83	Ontario	Envelopes	0.4
\N	3928	Deflect-o RollaMat Studded, Beveled Mat for Medium Pile Carpeting	Jay Kimmel	12322	-398.11	92.23	39.61	Ontario	Office Furnishings	0.67
\N	3929	O'Sullivan Cherrywood Estates Traditional Barrister Bookcase	Steve Nguyen	12480	-203.27	137.48	32.18	Ontario	Bookcases	0.78
\N	3930	Lexmark Z25 Color Inkjet Printer	Vivek Grady	12516	66.22	80.97	33.6	Ontario	Office Machines	0.37
\N	3931	Xerox 231	Vivek Grady	12516	-23.53	6.48	5.11	Ontario	Paper	0.37
\N	3932	Bravo II™ Megaboss® 12-Amp Hard Body Upright, Replacement Belts, 2 Belts per Pack	Ben Ferrer	13088	-2149.8	3.25	49	Ontario	Appliances	0.56
\N	3933	Logitech Internet Navigator Keyboard	Xylona Price	13121	-27.99	30.98	6.5	Ontario	Computer Peripherals	0.79
\N	3934	Talkabout T8097	Xylona Price	13121	1049.54	205.99	8.99	Ontario	Telephones and Communication	0.58
\N	3935	Fellowes Strictly Business® Drawer File, Letter/Legal Size	Jim Kriz	13348	310.51	140.85	19.99	Ontario	Storage & Organization	0.73
\N	3936	Staples Copy Paper (20Lb. and 84 Bright)	Karen Daniels	13413	-50.86	4.98	4.7	Ontario	Paper	0.38
\N	3937	1726 Digital Answering Machine	Pamela Coakley	13447	0.85	20.99	4.81	Ontario	Telephones and Communication	0.58
\N	3938	TDK 4.7GB DVD+RW	Steve Nguyen	13638	165.2	14.48	1.99	Ontario	Computer Peripherals	0.49
\N	3939	Space Solutions™ Industrial Galvanized Steel Shelving.	Katherine Nockton	13761	-949.09	78.8	35	Ontario	Storage & Organization	0.83
\N	3940	Acco® Hot Clips™ Clips to Go	Denny Blanton	14247	-2.49	3.29	1.35	Ontario	Rubber Bands	0.4
\N	3941	Avery Hi-Liter Pen Style Six-Color Fluorescent Set	Steve Nguyen	14755	29.57	3.85	0.7	Ontario	Pens & Art Supplies	0.44
\N	3942	5170	Steve Nguyen	14755	454.38	65.99	4.2	Ontario	Telephones and Communication	0.59
\N	3943	Tenex Personal Self-Stacking Standard File Box, Black/Gray	Robert Marley	14854	-27.98	16.91	6.25	Ontario	Storage & Organization	0.58
\N	3944	Xerox 1899	Katherine Nockton	15078	-36.9	5.78	4.96	Ontario	Paper	0.36
\N	3945	Boston 1645 Deluxe Heavier-Duty Electric Pencil Sharpener	Sean O'Donnell	15718	360.63	43.98	8.99	Ontario	Pens & Art Supplies	0.58
\N	3946	OIC Thumb-Tacks	Sean O'Donnell	15718	-3.05	1.14	0.7	Ontario	Rubber Bands	0.38
\N	3947	Eaton Premium Continuous-Feed Paper, 25% Cotton, Letter Size, White, 1000 Shts/Box	Jas O'Carroll	15744	290.77	55.48	6.79	Ontario	Paper	0.37
\N	3948	Wilson Jones Hanging View Binder, White, 1"	Chris Selesnick	16454	-29.49	7.1	6.05	Ontario	Binders and Binder Accessories	0.39
\N	3949	SouthWestern Bell FA970 Digital Answering Machine with Time/Day Stamp	Sally Hughsby	16676	-12.08	28.99	8.59	Ontario	Telephones and Communication	0.56
\N	3950	Hon 4070 Series Pagoda™ Round Back Stacking Chairs	Sally Hughsby	16897	-183.09	320.98	58.95	Ontario	Chairs & Chairmats	0.57
\N	3951	Quartet Alpha® White Chalk, 12/Pack	Sally Hughsby	16897	14.97	2.21	1	Ontario	Pens & Art Supplies	0.38
\N	3952	Kensington 7 Outlet MasterPiece Power Center with Fax/Phone Line Protection	Stuart Calhoun	16999	1081.62	207.48	0.99	Ontario	Appliances	0.55
\N	3953	8860	Kean Nguyen	17091	750.87	65.99	5.26	Ontario	Telephones and Communication	0.56
\N	3954	Keytronic French Keyboard	Matt Connell	17249	225.28	73.98	14.52	Ontario	Computer Peripherals	0.65
\N	3955	Avery 494	Sean O'Donnell	17670	10.05	2.61	0.5	Ontario	Labels	0.39
\N	3956	Bush Westfield Collection Bookcases, Dark Cherry Finish, Fully Assembled	Vivek Grady	17797	-486.12	100.98	57.38	Ontario	Bookcases	0.78
\N	3957	Colored Envelopes	Vivek Grady	17797	-8.89	3.69	2.5	Ontario	Envelopes	0.39
\N	3958	White Dual Perf Computer Printout Paper, 2700 Sheets, 1 Part, Heavyweight, 20 lbs., 14 7/8 x 11	Guy Phonely	18213	21.6	40.99	19.99	Ontario	Paper	0.36
\N	3959	IBM 80 Minute CD-R Spindle, 50/Pack	Denny Blanton	18241	-55.11	20.89	1.99	Ontario	Computer Peripherals	0.48
\N	3960	Bretford CR8500 Series Meeting Room Furniture	Denny Blanton	18241	-969.05	400.98	76.37	Ontario	Tables	0.6
\N	3961	Hon Olson Stacker Stools	Chris Selesnick	18244	-73.22	140.81	24.49	Ontario	Chairs & Chairmats	0.57
\N	3962	Space Solutions Commercial Steel Shelving	Laura Armstrong	18465	-353.71	64.65	35	Ontario	Storage & Organization	0.8
\N	3963	Staples Surge Protector 6 outlet	Jas O'Carroll	18528	-22.82	10.98	3.99	Ontario	Appliances	0.58
\N	3964	Xerox 196	Jas O'Carroll	18528	-96.22	5.78	7.96	Ontario	Paper	0.36
\N	3965	Round Ring Binders	Steve Nguyen	18917	-8.36	2.08	1.49	Ontario	Binders and Binder Accessories	0.38
\N	3966	Laminate Occasional Tables	Bill Overfelt	19493	-372.49	154.13	69	Ontario	Tables	0.68
\N	3967	Boston Model 1800 Electric Pencil Sharpener, Gray	Katherine Nockton	19616	-28.95	28.15	6.17	Ontario	Pens & Art Supplies	0.55
\N	3968	Newell 318	Katherine Nockton	19616	-10.01	2.78	1.25	Ontario	Pens & Art Supplies	0.59
\N	3969	Fellowes EZ Multi-Media Keyboard	Sandra Flanagan	20390	-62.82	34.98	7.53	Ontario	Computer Peripherals	0.76
\N	3970	Serrated Blade or Curved Handle Hand Letter Openers	Sandra Flanagan	20390	-25.26	3.14	1.92	Ontario	Scissors, Rulers and Trimmers	0.84
\N	3971	Recycled Desk Saver Line "While You Were Out" Book, 5 1/2" X 4"	Bill Overfelt	20451	2.82	8.95	2.01	Ontario	Paper	0.39
\N	3972	Recycled Steel Personal File for Standard File Folders	Bill Overfelt	20451	454.49	55.29	5.08	Ontario	Storage & Organization	0.59
\N	3973	Chromcraft Bull-Nose Wood Oval Conference Tables & Bases	Bill Overfelt	20451	-1331.55	550.98	45.7	Ontario	Tables	0.71
\N	3974	Wirebound Message Books, Four 2 3/4" x 5" Forms per Page, 600 Sets per Book	Alejandro Grove	20486	18.73	9.27	4.39	Ontario	Paper	0.38
\N	3975	Avery Hi-Liter Pen Style Six-Color Fluorescent Set	Alejandro Grove	20486	55.73	3.85	0.7	Ontario	Pens & Art Supplies	0.44
\N	3976	Xerox 1940	Arthur Prichep	20899	110.36	54.96	10.75	Ontario	Paper	0.36
\N	3977	Global High-Back Leather Tilter, Burgundy	Vivek Grady	21089	-331.08	122.99	70.2	Ontario	Chairs & Chairmats	0.74
\N	3978	1.7 Cubic Foot Compact "Cube" Office Refrigerators	Lindsay Shagiari	21634	-314.61	208.16	68.02	Ontario	Appliances	0.58
\N	3979	Polycom ViewStation™ Adapter H323 Videoconferencing Unit	Lindsay Shagiari	21634	-4017.62	1938.02	13.99	Ontario	Office Machines	0.38
\N	3980	DPC 650 Piper	Arthur Prichep	21665	-407.26	115.99	2.5	Ontario	Telephones and Communication	0.58
\N	3981	ACCOHIDE® Binder by Acco	Xylona Price	21729	-92.85	4.13	5.34	Ontario	Binders and Binder Accessories	0.38
\N	4097	Adams "While You Were Out" Message Pads	Sean O'Donnell	38370	43.05	3.14	1.14	Ontario	Paper	0.4
\N	3982	Eldon Cleatmat Plus™ Chair Mats for High Pile Carpets	Xylona Price	21729	-256.93	79.52	48.2	Ontario	Office Furnishings	0.74
\N	3983	US Robotics 56K V.92 External Faxmodem	Vivek Grady	21796	1033.38	99.99	19.99	Ontario	Computer Peripherals	0.52
\N	3984	1726 Digital Answering Machine	Vivek Grady	21796	-99.98	20.99	4.81	Ontario	Telephones and Communication	0.58
\N	3985	#10 White Business Envelopes,4 1/8 x 9 1/2	Vivek Grady	21796	274.66	15.67	1.39	Ontario	Envelopes	0.38
\N	3986	OIC Thumb-Tacks	Vivek Grady	21796	-3.19	1.14	0.7	Ontario	Rubber Bands	0.38
\N	3987	Hoover WindTunnel™ Plus Canister Vacuum	Sally Hughsby	21958	1092.94	363.25	19.99	Ontario	Appliances	0.57
\N	3988	Premium Transparent Presentation Covers by GBC	Steve Nguyen	22468	41.52	20.98	8.83	Ontario	Binders and Binder Accessories	0.37
\N	3989	Adams Write n' Stick Phone Message Book, 11" X 5 1/4", 200 Messages	Steve Nguyen	22468	13.31	5.68	1.46	Ontario	Paper	0.39
\N	3990	Staples Plastic Wall Frames	Steve Nguyen	22468	23.61	7.96	4.95	Ontario	Office Furnishings	0.41
\N	3991	Array® Memo Cubes	John Lucas	22626	14.19	5.18	2.04	Ontario	Paper	0.36
\N	3992	BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	John Lucas	22626	-528.65	218.75	69.64	Ontario	Tables	0.77
\N	3993	Kensington 6 Outlet SmartSocket Surge Protector	Stuart Calhoun	23205	-16.64	40.98	7.2	Ontario	Appliances	0.6
\N	3994	Imation Neon Mac Format Diskettes, 10/Pack	Stuart Calhoun	23205	-59.73	8.12	2.83	Ontario	Computer Peripherals	0.77
\N	3995	Bevis Boat-Shaped Conference Table	Stuart Calhoun	23205	-633.44	262.11	62.74	Ontario	Tables	0.75
\N	3996	Round Ring Binders	Kean Nguyen	23394	-5.99	2.08	1.49	Ontario	Binders and Binder Accessories	0.38
\N	3997	Microsoft Natural Multimedia Keyboard	Katherine Nockton	24390	-234.66	50.98	6.5	Ontario	Computer Peripherals	0.73
\N	3998	Accessory8	Ben Ferrer	24643	1181.3	85.99	1.25	Ontario	Telephones and Communication	0.39
\N	3999	Imation Primaris 3.5" 2HD Unformatted Diskettes, 10/Pack	Janet Molinari	24679	-25.86	4.77	2.39	Ontario	Computer Peripherals	0.72
\N	4000	Holmes Odor Grabber	Sally Hughsby	25062	-21.29	14.42	6.75	Ontario	Appliances	0.52
\N	4001	GBC DocuBind 200 Manual Binding Machine	Sally Hughsby	25062	1343.25	420.98	19.99	Ontario	Binders and Binder Accessories	0.35
\N	4002	SANFORD Major Accent™ Highlighters	Matt Connell	25152	16.4	7.08	2.35	Ontario	Pens & Art Supplies	0.47
\N	4003	6162m	Jim Kriz	25478	1578.7	115.99	2.5	Ontario	Telephones and Communication	0.57
\N	4004	Staples Bulk Pack Metal Binder Clips	Jim Kriz	25478	77.2	6.08	1.82	Ontario	Rubber Bands	0.35
\N	4005	Ibico EPK-21 Electric Binding System	Arthur Prichep	26469	701.22	1889.99	19.99	Ontario	Binders and Binder Accessories	0.36
\N	4006	HP Office Paper (20Lb. and 87 Bright)	Arthur Prichep	26469	-133.43	6.68	6.93	Ontario	Paper	0.37
\N	4007	GBC DocuBind 200 Manual Binding Machine	Harold Ryan	26470	8822.28	420.98	19.99	Ontario	Binders and Binder Accessories	0.35
\N	4008	Smead Adjustable Mobile File Trolley with Lockable Top	Cathy Prescott	26565	7606	419.19	19.99	Ontario	Storage & Organization	0.58
\N	4009	Xerox 1897	Jim Kriz	26852	-9.88	4.98	6.07	Ontario	Paper	0.36
\N	4010	Luxo Economy Swing Arm Lamp	Liz Willingham	27299	-293.45	19.94	14.87	Ontario	Office Furnishings	0.57
\N	4011	Keytronic French Keyboard	Stephanie Ulpright	27300	-85.03	73.98	4	Ontario	Computer Peripherals	0.79
\N	4012	Sanford EarthWrite® Recycled Pencils, Medium Soft, #2	Stephanie Ulpright	27300	0.26	2.1	0.7	Ontario	Pens & Art Supplies	0.57
\N	4013	Avery File Folder Labels	Robert Marley	27557	-58.47	2.88	5.33	Ontario	Labels	0.36
\N	4014	Security-Tint Envelopes	Lindsay Shagiari	27654	29.87	7.64	1.39	Ontario	Envelopes	0.36
\N	4015	Staples Battery-Operated Desktop Pencil Sharpener	John Lucas	27684	-6.62	10.48	2.89	Ontario	Pens & Art Supplies	0.6
\N	4016	Avery Self-Adhesive Photo Pockets for Polaroid Photos	Odella Nelson	27811	-73.62	6.81	5.48	Ontario	Binders and Binder Accessories	0.37
\N	4017	Prismacolor Color Pencil Set	Arthur Prichep	28064	265.1	19.84	4.1	Ontario	Pens & Art Supplies	0.44
\N	4018	Quartet Omega® Colored Chalk, 12/Pack	Arthur Prichep	28064	-2.31	5.84	1	Ontario	Pens & Art Supplies	0.38
\N	4019	Carina 42"Hx23 3/4"W Media Storage Unit	Guy Phonely	28225	-330.14	80.98	35	Ontario	Storage & Organization	0.83
\N	4020	i2000	Denny Blanton	28258	-604.41	125.99	2.5	Ontario	Telephones and Communication	0.6
\N	4021	US Robotics 56K V.92 External Faxmodem	Denny Blanton	28258	293.66	99.99	19.99	Ontario	Computer Peripherals	0.52
\N	4022	Avery 511	Steve Nguyen	28321	24.71	3.08	0.99	Ontario	Labels	0.37
\N	4023	Xerox 215	Sean O'Donnell	28454	-84	6.48	6.74	Ontario	Paper	0.37
\N	4024	8260	Sally Hughsby	29255	-136.09	65.99	8.99	Ontario	Telephones and Communication	0.58
\N	4025	Imation 3.5 IBM Formatted Diskettes, 10/Box	Jas O'Carroll	29383	-46.89	8.32	2.38	Ontario	Computer Peripherals	0.74
\N	4026	Xerox 227	Jas O'Carroll	29383	-129.42	6.48	8.73	Ontario	Paper	0.37
\N	4027	DPC 650 Piper	Jas O'Carroll	29383	556.83	115.99	2.5	Ontario	Telephones and Communication	0.58
\N	4028	Master Giant Foot® Doorstop, Safety Yellow	Jas O'Carroll	29383	16.97	7.59	4	Ontario	Office Furnishings	0.42
\N	4029	Global Adaptabilities™ Conference Tables	Sally Hughsby	29507	-679.04	280.98	35.67	Ontario	Tables	0.66
\N	4030	Accessory35	Sally Hughsby	29507	416.99	35.99	1.1	Ontario	Telephones and Communication	0.55
\N	4031	Iceberg OfficeWorks 42" Round Tables	Sally Hughsby	29572	126.28	150.98	16.01	Ontario	Tables	0.7
\N	4032	Dixon Ticonderoga® Erasable Colored Pencil Set, 12-Color	Odella Nelson	29889	23.87	5.98	1.67	Ontario	Pens & Art Supplies	0.51
\N	4033	DAX Wood Document Frame.	Matt Connell	29894	21.08	13.73	6.85	Ontario	Office Furnishings	0.54
\N	4034	Xerox 1898	Matt Connell	29894	-162.54	6.68	6.92	Ontario	Paper	0.37
\N	4035	Fellowes Twister Kit, Gray/Clear, 3/pkg	Guy Phonely	29985	-18.26	8.04	8.94	Ontario	Binders and Binder Accessories	0.4
\N	4036	Eldon Expressions Punched Metal & Wood Desk Accessories, Black & Cherry	Alejandro Grove	30054	-9.18	9.38	4.93	Ontario	Office Furnishings	0.57
\N	4037	600 Series Non-Flip	Lindsay Shagiari	30208	356.35	45.99	4.99	Ontario	Telephones and Communication	0.57
\N	4038	Xerox 1961	Denny Blanton	30369	-55.77	4.98	7.54	Ontario	Paper	0.38
\N	4039	Acme® Elite Stainless Steel Scissors	Denny Blanton	30369	-1.23	8.34	2.64	Ontario	Scissors, Rulers and Trimmers	0.59
\N	4040	Fellowes Mighty 8 Compact Surge Protector	Harold Ryan	30726	140.57	20.27	3.99	Ontario	Appliances	0.57
\N	4041	Fellowes 8 Outlet Superior Workstation Surge Protector	Kean Nguyen	30727	302.86	41.71	4.5	Ontario	Appliances	0.56
\N	4042	Premium Writing Pencils, Soft, #2 by Central Association for the Blind	Xylona Price	30915	-17.75	2.98	2.03	Ontario	Pens & Art Supplies	0.57
\N	4043	M70	Xylona Price	30915	561.13	125.99	8.99	Ontario	Telephones and Communication	0.59
\N	4044	Ibico EB-19 Dual Function Manual Binding System	Sean O'Donnell	31072	4.56	172.99	19.99	Ontario	Binders and Binder Accessories	0.39
\N	4045	Howard Miller 13" Diameter Goldtone Round Wall Clock	Arthur Prichep	31073	843.12	46.94	6.77	Ontario	Office Furnishings	0.44
\N	4046	Office Impressions Heavy Duty Welded Shelving & Multimedia Storage Drawers	Arthur Prichep	31073	-618.95	167.27	35	Ontario	Storage & Organization	0.85
\N	4047	Hon iLevel™ Computer Training Table	Arthur Prichep	31138	-1756.44	31.76	45.51	Ontario	Tables	0.65
\N	4048	Bell Sonecor JB700 Caller ID	Sally Hughsby	31173	-84.14	7.99	5.03	Ontario	Telephones and Communication	0.6
\N	4049	White Dual Perf Computer Printout Paper, 2700 Sheets, 1 Part, Heavyweight, 20 lbs., 14 7/8 x 11	Laura Armstrong	31812	25.19	40.99	19.99	Ontario	Paper	0.36
\N	4050	Bagged Rubber Bands	Laura Armstrong	31812	-17.34	1.26	0.7	Ontario	Rubber Bands	0.81
\N	4051	Logitech Internet Navigator Keyboard	Jim Kriz	32002	-73.77	30.98	6.5	Ontario	Computer Peripherals	0.79
\N	4052	9-3/4 Diameter Round Wall Clock	Jim Kriz	32002	23.16	13.79	8.78	Ontario	Office Furnishings	0.43
\N	4053	Imation 3.5", RTS 247544 3M 3.5 DSDD, 10/Pack	Lena Radford	32323	-31.43	8.46	3.62	Ontario	Computer Peripherals	0.61
\N	4054	Xerox 1991	Lena Radford	32323	-21.13	22.84	8.18	Ontario	Paper	0.39
\N	4055	Bell Sonecor JB700 Caller ID	Lena Radford	32323	-118.48	7.99	5.03	Ontario	Telephones and Communication	0.6
\N	4056	Avery Self-Adhesive Photo Pockets for Polaroid Photos	Ryan Akin	32454	-29.59	6.81	5.48	Ontario	Binders and Binder Accessories	0.37
\N	4057	Acco Suede Grain Vinyl Round Ring Binder	Robert Marley	32516	-0.24	2.78	1.49	Ontario	Binders and Binder Accessories	0.39
\N	4058	Staples #10 Colored Envelopes	Robert Marley	32516	6.44	7.78	2.5	Ontario	Envelopes	0.38
\N	4059	Tripp Lite Isotel 8 Ultra 8 Outlet Metal Surge	Xylona Price	32608	312.52	70.97	3.5	Ontario	Appliances	0.59
\N	4060	Eldon Expressions Mahogany Wood Desk Collection	Vivek Grady	33510	-96.95	6.24	5.22	Ontario	Office Furnishings	0.6
\N	4061	Xerox 1893	Vivek Grady	33510	13.21	40.99	17.48	Ontario	Paper	0.36
\N	4062	Advantus Panel Wall Certificate Holder - 8.5x11	John Lucas	33541	16.14	12.2	6.02	Ontario	Office Furnishings	0.43
\N	4063	Iceberg OfficeWorks 42" Round Tables	Vivek Grady	33573	111.05	150.98	16.01	Ontario	Tables	0.7
\N	4064	Okidata ML520 Series Dot Matrix Printers	Scott Cohen	34371	1886.66	510.14	14.7	Ontario	Office Machines	0.56
\N	4065	Fellowes Command Center 5-outlet power strip	Karen Daniels	34530	493.03	67.84	0.99	Ontario	Appliances	0.58
\N	4066	Maxell Pro 80 Minute CD-R, 10/Pack	Karen Daniels	34530	168.04	17.48	1.99	Ontario	Computer Peripherals	0.45
\N	4067	Iceberg OfficeWorks 42" Round Tables	Karen Daniels	34530	-364.87	150.98	16.01	Ontario	Tables	0.7
\N	4068	Maxell 4.7GB DVD-R	John Lucas	34562	57.82	28.38	1.99	Ontario	Computer Peripherals	0.51
\N	4069	Computer Printout Paper with Letter-Trim Perforations	John Lucas	34562	22.77	18.97	9.03	Ontario	Paper	0.37
\N	4070	Rubbermaid ClusterMat Chairmats, Mat Size- 66" x 60", Lip 20" x 11" -90 Degree Angle	Liz Willingham	35430	608.74	110.98	13.99	Ontario	Office Furnishings	0.69
\N	4071	SANFORD Liquid Accent™ Tank-Style Highlighters	Liz Willingham	35430	9.5	2.84	0.93	Ontario	Pens & Art Supplies	0.54
\N	4072	5180	Liz Willingham	35430	173.93	65.99	8.99	Ontario	Telephones and Communication	0.56
\N	4073	O'Sullivan 3-Shelf Heavy-Duty Bookcases	Cathy Prescott	35588	-694.9	58.14	36.61	Ontario	Bookcases	0.61
\N	4074	Gyration Ultra Cordless Optical Suite	Steve Nguyen	35712	1174.02	100.97	7.18	Ontario	Computer Peripherals	0.46
\N	4075	Xerox 1963	Steve Nguyen	35712	-122.21	5.28	8.16	Ontario	Paper	0.4
\N	4076	Belkin 107-key enhanced keyboard, USB/PS/2 interface	Lindsay Shagiari	36130	-113.8	17.98	4	Ontario	Computer Peripherals	0.79
\N	4077	Xerox 1998	Sean O'Donnell	36416	-98.53	6.48	5.82	Ontario	Paper	0.37
\N	4078	Sanford Colorific Colored Pencils, 12/Box	Sean O'Donnell	36416	6.93	2.88	1.01	Ontario	Pens & Art Supplies	0.55
\N	4079	Avery Hole Reinforcements	Robert Marley	36418	-124.84	6.23	6.97	Ontario	Binders and Binder Accessories	0.36
\N	4080	Belkin Premiere Surge Master II 8-outlet surge protector	Katherine Nockton	36517	218.97	48.58	3.99	Ontario	Appliances	0.56
\N	4081	Fellowes Basic 104-Key Keyboard, Platinum	Katherine Nockton	36517	-63.78	20.95	4	Ontario	Computer Peripherals	0.6
\N	4082	KI Conference Tables	Sam Zeldin	36705	54.23	70.89	89.3	Ontario	Tables	0.72
\N	4083	Xerox 1959	Harold Ryan	36833	-73.33	6.68	7.3	Ontario	Paper	0.37
\N	4084	Avery 494	Xylona Price	36896	10.58	2.61	0.5	Ontario	Labels	0.39
\N	4085	Executive Impressions 13" Chairman Wall Clock	Xylona Price	36896	69.31	25.38	8.99	Ontario	Office Furnishings	0.5
\N	4086	Office Impressions Heavy Duty Welded Shelving & Multimedia Storage Drawers	Xylona Price	36896	-546.98	167.27	35	Ontario	Storage & Organization	0.85
\N	4087	Anderson Hickey Conga Table Tops & Accessories	Lena Radford	37123	11.65	15.23	27.75	Ontario	Tables	0.76
\N	4088	Wilson Jones 14 Line Acrylic Coated Pressboard Data Binders	Jas O'Carroll	37572	2.42	5.34	2.99	Ontario	Binders and Binder Accessories	0.38
\N	4089	Hoover Commercial Lightweight Upright Vacuum with E-Z Empty™ Dirt Cup	Alejandro Grove	37669	2485.54	232.58	19.99	Ontario	Appliances	0.59
\N	4090	Quality Park Security Envelopes	Alejandro Grove	37669	402.37	26.17	1.39	Ontario	Envelopes	0.38
\N	4091	Eldon Jumbo ProFile™ Portable File Boxes Graphite/Black	Alejandro Grove	37669	-30.63	15.31	8.78	Ontario	Storage & Organization	0.57
\N	4092	Hanging Personal Folder File	Mick Hernandez	38117	-128.89	15.7	11.25	Ontario	Storage & Organization	0.6
\N	4093	Xerox 1922	Ben Ferrer	38210	-49.53	4.98	7.44	Ontario	Paper	0.36
\N	4094	Hon Olson Stacker Stools	Todd Sumrall	38274	0.98	140.81	24.49	Ontario	Chairs & Chairmats	0.57
\N	4095	Trav-L-File Heavy-Duty Shuttle II, Black	Todd Sumrall	38274	23.7	43.57	16.36	Ontario	Storage & Organization	0.55
\N	4096	Accessory2	Todd Sumrall	38274	-33.79	55.99	1.25	Ontario	Telephones and Communication	0.55
\N	4098	Master Giant Foot® Doorstop, Safety Yellow	Laura Armstrong	38405	14.77	7.59	4	Ontario	Office Furnishings	0.42
\N	4099	Xerox 1983	Jane Waco	38466	-43.26	5.98	5.46	Ontario	Paper	0.36
\N	4100	Avery 498	Jane Waco	38466	46.46	2.89	0.5	Ontario	Labels	0.38
\N	4101	Xerox 210	Jane Waco	38466	-53.99	6.48	7.37	Ontario	Paper	0.37
\N	4102	Xerox 1894	Guy Phonely	38501	-29.07	6.48	6.22	Ontario	Paper	0.37
\N	4103	Newell 338	Pamela Coakley	38532	16.51	2.94	0.7	Ontario	Pens & Art Supplies	0.58
\N	4104	Microsoft Multimedia Keyboard	Vivek Grady	38564	-53.4	30.97	4	Ontario	Computer Peripherals	0.74
\N	4105	Avery 506	Vivek Grady	38564	45.93	4.13	0.5	Ontario	Labels	0.39
\N	4106	Hoover Commercial Soft Guard Upright Vacuum And Disposable Filtration Bags	Ben Ferrer	38915	-83.65	7.77	9.23	Ontario	Appliances	0.58
\N	4107	Master Giant Foot® Doorstop, Safety Yellow	Ben Ferrer	38915	24.39	7.59	4	Ontario	Office Furnishings	0.42
\N	4108	DAX Clear Channel Poster Frame	Chris Selesnick	38947	4.91	14.58	7.4	Ontario	Office Furnishings	0.48
\N	4109	Newell 337	Matt Connell	39078	-27.72	3.28	3.97	Ontario	Pens & Art Supplies	0.56
\N	4110	Hayes Optima 56K V.90 Internal Voice Modem	Matt Connell	39078	-267.63	256.99	11.25	Ontario	Computer Peripherals	0.51
\N	4111	Xerox 23	Matt Connell	39078	-33.67	6.48	5.14	Ontario	Paper	0.37
\N	4112	Staples Colored Interoffice Envelopes	Jim Kriz	39141	-163.53	30.98	19.51	Ontario	Envelopes	0.36
\N	4113	Electrix Fluorescent Magnifier Lamps & Weighted Base	Jim Kriz	39141	554.77	49.34	10.25	Ontario	Office Furnishings	0.57
\N	4114	Wilson Jones Hanging View Binder, White, 1"	Stephanie Ulpright	39460	-71.6	7.1	6.05	Ontario	Binders and Binder Accessories	0.39
\N	4115	i2000	Stephanie Ulpright	39460	251.2	125.99	2.5	Ontario	Telephones and Communication	0.6
\N	4116	6" Cubicle Wall Clock, Black	Alejandro Grove	39904	-144.56	8.09	7.96	Ontario	Office Furnishings	0.49
\N	4117	5165	Chris Selesnick	39909	2547.3	175.99	4.99	Ontario	Telephones and Communication	0.59
\N	4118	Xerox Blank Computer Paper	Sandra Flanagan	40100	333.18	19.98	5.77	Ontario	Paper	0.38
\N	4119	Howard Miller 16" Diameter Gallery Wall Clock	Sally Hughsby	40224	404.29	63.94	14.48	Ontario	Office Furnishings	0.46
\N	4120	StarTAC 7760	Jim Kriz	40422	517.82	65.99	3.99	Ontario	Telephones and Communication	0.59
\N	4121	Hewlett-Packard Deskjet 5550 Color Inkjet Printer	Scott Cohen	40802	26.05	115.99	56.14	Ontario	Office Machines	0.4
\N	4122	Hewlett-Packard 2600DN Business Color Inkjet Printer	Guy Phonely	40839	-100.47	119.99	56.14	Ontario	Office Machines	0.39
\N	4123	Xerox 1951	Odella Nelson	40997	61.47	30.98	9.18	Ontario	Paper	0.4
\N	4124	Boston KS Multi-Size Manual Pencil Sharpener	Odella Nelson	40997	18.27	22.99	8.99	Ontario	Pens & Art Supplies	0.57
\N	4125	Pizazz® Global Quick File™	Odella Nelson	40997	-8.4	14.97	7.51	Ontario	Storage & Organization	0.57
\N	4126	Bush Advantage Collection® Round Conference Table	Odella Nelson	40997	-513.79	212.6	110.2	Ontario	Tables	0.73
\N	4127	Xerox 196	Ben Ferrer	41185	-12.83	5.78	7.96	Ontario	Paper	0.36
\N	4128	Gyration Ultra Professional Cordless Optical Suite	Steve Nguyen	41253	-807.59	300.97	7.18	Ontario	Computer Peripherals	0.48
\N	4129	Office Star - Ergonomic Mid Back Chair with 2-Way Adjustable Arms	Harold Ryan	41378	446.26	180.98	30	Ontario	Chairs & Chairmats	0.69
\N	4130	Verbatim DVD-RAM, 5.2GB, Rewritable, Type 1, DS	Harold Ryan	41378	433.34	29.89	1.99	Ontario	Computer Peripherals	0.5
\N	4131	Bush Westfield Collection Bookcases, Fully Assembled	Matt Connell	41474	-6.8	100.98	35.84	Ontario	Bookcases	0.62
\N	4132	Imation Primaris 3.5" 2HD Unformatted Diskettes, 10/Pack	Matt Connell	41474	-89.13	4.77	2.39	Ontario	Computer Peripherals	0.72
\N	4133	Global Troy™ Executive Leather Low-Back Tilter	Liz Willingham	41508	4822.42	500.98	26	Ontario	Chairs & Chairmats	0.6
\N	4134	Xerox 1881	Kean Nguyen	41569	47.1	12.28	6.47	Ontario	Paper	0.38
\N	4135	Boston 19500 Mighty Mite Electric Pencil Sharpener	Katherine Nockton	41571	-2.66	20.15	8.99	Ontario	Pens & Art Supplies	0.58
\N	4136	GBC DocuBind TL300 Electric Binding System	Alejandro Grove	41728	9527.47	896.99	19.99	Ontario	Binders and Binder Accessories	0.38
\N	4137	Hon Deluxe Fabric Upholstered Stacking Chairs	Alejandro Grove	41728	41.53	243.98	62.94	Ontario	Chairs & Chairmats	0.57
\N	4138	Chromcraft 48" x 96" Racetrack Double Pedestal Table	Katherine Nockton	41764	467.12	320.64	29.2	Ontario	Tables	0.66
\N	4139	TOPS Voice Message Log Book, Flash Format	Kean Nguyen	42082	-3.95	4.76	3.01	Ontario	Paper	0.36
\N	4140	Logitech Internet Navigator Keyboard	Harold Ryan	42279	-55.78	30.98	6.5	Ontario	Computer Peripherals	0.79
\N	4141	Eldon Imàge® Series Desk Accessories, Clear	Sam Zeldin	42308	-56.56	4.86	7.1	Ontario	Office Furnishings	0.42
\N	4142	Newell 338	Jas O'Carroll	42375	24.34	2.94	0.7	Ontario	Pens & Art Supplies	0.58
\N	4143	Plymouth Boxed Rubber Bands by Plymouth	Robert Marley	42851	-2.97	4.71	0.7	Ontario	Rubber Bands	0.8
\N	4144	Accessory32	Robert Marley	42851	-22.9	55.99	1.25	Ontario	Telephones and Communication	0.35
\N	4145	Eaton Premium Continuous-Feed Paper, 25% Cotton, Letter Size, White, 1000 Shts/Box	Stephanie Ulpright	43585	374.19	55.48	6.79	Ontario	Paper	0.37
\N	4146	SAFCO Folding Chair Trolley	Harold Ryan	43590	804.2	128.24	12.65	Ontario	Chairs & Chairmats	\N
\N	4147	Newell 35	Mick Hernandez	43874	-161.21	3.28	5	Ontario	Pens & Art Supplies	0.56
\N	4148	Fellowes Internet Keyboard, Platinum	Tony Chapman	45059	-116.18	30.42	8.65	Ontario	Computer Peripherals	0.74
\N	4149	Rediform Wirebound "Phone Memo" Message Book, 11 x 5-3/4	Robert Marley	45542	-50.96	7.64	5.83	Ontario	Paper	0.36
\N	4150	Bevis 36 x 72 Conference Tables	Robert Marley	45542	-300.85	124.49	51.94	Ontario	Tables	0.63
\N	4151	Ibico EB-19 Dual Function Manual Binding System	Jay Kimmel	45698	2307.57	172.99	19.99	Ontario	Binders and Binder Accessories	0.39
\N	4152	Black Print Carbonless 8 1/2" x 8 1/4" Rapid Memo Book	Jay Kimmel	45698	-5.68	7.28	4.23	Ontario	Paper	0.39
\N	4153	EcoTones® Memo Sheets	Laura Armstrong	45987	37.25	4	1.3	Ontario	Paper	0.37
\N	4154	Howard Miller 16" Diameter Gallery Wall Clock	Bill Overfelt	46052	878.21	63.94	14.48	Ontario	Office Furnishings	0.46
\N	4155	Seth Thomas 13 1/2" Wall Clock	Bill Overfelt	46052	194.15	17.78	5.03	Ontario	Office Furnishings	0.54
\N	4156	Bevis Round Bullnose 29" High Table Top	Herbert Flentye	46374	-627.64	259.71	66.67	Ontario	Tables	0.65
\N	4157	Deflect-o SuperTray™ Unbreakable Stackable Tray, Letter, Black	Ryan Akin	46402	322.88	29.18	8.55	Ontario	Office Furnishings	0.42
\N	4158	Panasonic All Digital Answering System with Caller ID*, KX-TM150B	Ryan Akin	46402	166.37	66.99	13.99	Ontario	Telephones and Communication	0.6
\N	4159	StarTAC 7797	Ryan Akin	46402	52.93	115.99	2.5	Ontario	Telephones and Communication	0.55
\N	4160	T61	John Lucas	46404	507.33	45.99	2.5	Ontario	Telephones and Communication	0.56
\N	4161	GBC DocuBind P100 Manual Binding Machine	Vivek Grady	46468	2745.87	165.98	19.99	Ontario	Binders and Binder Accessories	0.4
\N	4162	80 Minute CD-R Spindle, 100/Pack - Staples	Vivek Grady	46468	504.71	39.48	1.99	Ontario	Computer Peripherals	0.54
\N	4163	Xerox 207	Vivek Grady	46468	-8.89	6.48	5.4	Ontario	Paper	0.37
\N	4164	Boston 19500 Mighty Mite Electric Pencil Sharpener	Jane Waco	46497	-30.07	20.15	8.99	Ontario	Pens & Art Supplies	0.58
\N	4165	GBC Linen Binding Covers	Xylona Price	47303	226.53	30.98	11.63	Ontario	Binders and Binder Accessories	0.37
\N	4166	#10- 4 1/8" x 9 1/2" Security-Tint Envelopes	Xylona Price	47303	12.64	7.64	1.39	Ontario	Envelopes	0.36
\N	4167	Xerox 210	Xylona Price	47303	-143.58	6.48	7.37	Ontario	Paper	0.37
\N	4168	Fellowes Internet Keyboard, Platinum	Bill Overfelt	47492	-157.51	30.42	8.65	Ontario	Computer Peripherals	0.74
\N	4169	Ames Color-File® Green Diamond Border X-ray Mailers	Steve Nguyen	47682	1620.23	83.98	5.01	Ontario	Envelopes	0.38
\N	4170	Quartet Alpha® White Chalk, 12/Pack	Steve Nguyen	48483	10.01	2.21	1	Ontario	Pens & Art Supplies	0.38
\N	4171	Xerox 1982	John Lucas	48961	-143.66	22.84	16.87	Ontario	Paper	0.39
\N	4172	Super Decoflex Portable Personal File	John Lucas	48961	-76.9	14.98	7.69	Ontario	Storage & Organization	0.57
\N	4173	Array® Parchment Paper, Assorted Colors	Laura Armstrong	49350	-331.63	7.28	11.15	Ontario	Paper	0.37
\N	4174	XtraLife® ClearVue™ Slant-D® Ring Binders by Cardinal	Harold Ryan	49505	-8.5	7.84	4.71	Ontario	Binders and Binder Accessories	0.35
\N	4175	Memorex Slim 80 Minute CD-R, 10/Pack	Harold Ryan	49505	85.83	9.78	1.99	Ontario	Computer Peripherals	0.43
\N	4176	Staples 6 Outlet Surge	Lena Radford	49797	-4.75	11.97	4.98	Ontario	Appliances	0.58
\N	4177	Xerox 217	Lena Radford	49797	-116.56	6.48	8.19	Ontario	Paper	0.37
\N	4178	Panasonic KP-350BK Electric Pencil Sharpener with Auto Stop	Vivek Grady	50017	214.05	34.58	8.99	Ontario	Pens & Art Supplies	0.56
\N	4179	Fellowes Officeware™ Wire Shelving	Vivek Grady	50017	-794.94	89.83	35	Ontario	Storage & Organization	0.83
\N	4180	Eldon Expressions™ Desk Accessory, Wood Photo Frame, Mahogany	Jas O'Carroll	50051	91.08	19.04	6.38	Ontario	Office Furnishings	0.56
\N	4181	Hewlett-Packard Deskjet 1220Cse Color Inkjet Printer	John Castell	50083	5711.96	400.97	48.26	Ontario	Office Machines	0.36
\N	4182	Maxell Pro 80 Minute CD-R, 10/Pack	Bill Overfelt	50307	161.37	17.48	1.99	Ontario	Computer Peripherals	0.45
\N	4183	Xerox 1940	Bill Overfelt	50307	647.25	54.96	10.75	Ontario	Paper	0.36
\N	4184	Euro Pro Shark Stick Mini Vacuum	Jim Kriz	50663	-716.55	60.98	49	Ontario	Appliances	0.59
\N	4185	Memorex 80 Minute CD-R Spindle, 100/Pack	Sally Hughsby	50917	498.15	43.98	1.99	Ontario	Computer Peripherals	0.44
\N	4186	CF 688	Sean O'Donnell	50981	1550.88	155.99	8.99	Ontario	Telephones and Communication	0.58
\N	4187	Eureka Sanitaire ® Multi-Pro Heavy-Duty Upright, Disposable Bags	Sean O'Donnell	51140	-93.12	4.37	5.15	Ontario	Appliances	0.59
\N	4188	Verbatim DVD-RAM, 9.4GB, Rewritable, Type 1, DS, DataLife Plus	Sean O'Donnell	51140	24.56	45.19	1.99	Ontario	Computer Peripherals	0.55
\N	4189	3M Polarizing Task Lamp with Clamp Arm, Light Gray	Sean O'Donnell	51140	352.38	136.98	24.49	Ontario	Office Furnishings	0.59
\N	4190	Mead 1st Gear 2" Zipper Binder, Asst. Colors	Nat Carroll	51205	88.88	12.97	1.49	Ontario	Binders and Binder Accessories	0.35
\N	4191	Blue String-Tie & Button Interoffice Envelopes, 10 x 13	Nat Carroll	51205	16.65	39.98	9.83	Ontario	Envelopes	0.4
\N	4192	3285	John Lucas	51237	1138.58	205.99	5.99	Ontario	Telephones and Communication	0.59
\N	4193	Quartet Alpha® White Chalk, 12/Pack	Stephanie Ulpright	51619	11.55	2.21	1	Ontario	Pens & Art Supplies	0.38
\N	4194	Economy Rollaway Files	Stephanie Ulpright	51619	-77.09	165.2	19.99	Ontario	Storage & Organization	0.59
\N	4195	Avery Binder Labels	Stephanie Ulpright	51619	-11.42	3.89	7.01	Ontario	Binders and Binder Accessories	0.37
\N	4196	Hon 4700 Series Mobuis™ Mid-Back Task Chairs with Adjustable Arms	Stephanie Ulpright	51619	1660.92	355.98	58.92	Ontario	Chairs & Chairmats	0.64
\N	4197	Rubber Band Ball	Bill Overfelt	51713	-15.96	3.74	0.94	Ontario	Rubber Bands	0.83
\N	4198	Avery 507	Alejandro Grove	52007	22.2	2.88	0.5	Ontario	Labels	0.39
\N	4199	Chromcraft Bull-Nose Wood Oval Conference Tables & Bases	Alejandro Grove	52007	-1331.55	550.98	45.7	Ontario	Tables	0.71
\N	4200	6120	John Lucas	52164	364.23	65.99	8.8	Ontario	Telephones and Communication	0.58
\N	4201	Staples 6 Outlet Surge	Jim Kriz	52512	-21.77	11.97	4.98	Ontario	Appliances	0.58
\N	4202	Binder Posts	Jim Kriz	52512	-52.84	5.74	5.01	Ontario	Binders and Binder Accessories	0.39
\N	4203	Advantus Push Pins	Cathy Prescott	52611	-5.14	2.18	1.38	Ontario	Rubber Bands	0.44
\N	4204	Logitech Cordless Access Keyboard	Vivek Grady	52805	60.7	29.99	5.5	Ontario	Computer Peripherals	0.51
\N	4205	Companion Letter/Legal File, Black	Todd Sumrall	52833	-33.09	37.76	12.9	Ontario	Storage & Organization	0.57
\N	4206	#10- 4 1/8" x 9 1/2" Recycled Envelopes	Sarah Foster	52930	44.12	8.74	1.39	Ontario	Envelopes	0.38
\N	4207	Xerox 1924	Sarah Foster	52930	-183.05	5.78	8.09	Ontario	Paper	0.36
\N	4208	Accessory24	Sarah Foster	52930	140.81	55.99	3.3	Ontario	Telephones and Communication	0.59
\N	4209	Accessory32	Sarah Foster	52930	972.9	55.99	1.25	Ontario	Telephones and Communication	0.35
\N	4210	Vinyl Sectional Post Binders	Tony Chapman	53127	857.34	37.7	2.99	Ontario	Binders and Binder Accessories	0.35
\N	4211	iDEN i95	Tony Chapman	53127	-137.95	65.99	19.99	Ontario	Telephones and Communication	0.59
\N	4212	Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back	Alejandro Grove	53349	2349.29	243.98	43.32	Ontario	Chairs & Chairmats	0.55
\N	4213	Xerox 1932	Steve Nguyen	53476	150.72	35.44	5.09	Ontario	Paper	0.38
\N	4214	4009® Highlighters by Sanford	Steve Nguyen	53476	19.42	3.98	0.7	Ontario	Pens & Art Supplies	0.52
\N	4215	Newell 310	Steve Nguyen	53476	3.13	1.76	0.7	Ontario	Pens & Art Supplies	0.56
\N	4216	Fellowes Staxonsteel® Drawer Files	Steve Nguyen	53476	1141.07	193.17	19.99	Ontario	Storage & Organization	0.71
\N	4217	Binder Posts	Laura Armstrong	53671	-82.79	5.74	5.01	Ontario	Binders and Binder Accessories	0.39
\N	4218	Fellowes Strictly Business® Drawer File, Letter/Legal Size	Laura Armstrong	53671	693.26	140.85	19.99	Ontario	Storage & Organization	0.73
\N	4219	GBC Prepunched Paper, 19-Hole, for Binding Systems, 24-lb	Laura Armstrong	53671	25.99	15.01	8.4	Ontario	Binders and Binder Accessories	0.39
\N	4220	Bevis Rectangular Conference Tables	Laura Armstrong	53766	-574.56	145.98	46.2	Ontario	Tables	0.69
\N	4221	Xerox 1894	Sandra Flanagan	53795	-93.06	6.48	6.22	Ontario	Paper	0.37
\N	4222	688	Sandra Flanagan	53795	370.33	195.99	4.2	Ontario	Telephones and Communication	0.6
\N	4223	Accessory41	Arthur Prichep	54209	170.46	35.99	5.99	Ontario	Telephones and Communication	0.38
\N	4224	80 Minute Slim Jewel Case CD-R , 10/Pack - Staples	Ryan Akin	54369	82.31	8.33	1.99	Ontario	Computer Peripherals	0.52
\N	4225	Hot File® 7-Pocket, Floor Stand	Nat Carroll	54850	587.64	178.47	19.99	Ontario	Storage & Organization	0.55
\N	4226	StarTAC ST7762	Nat Carroll	54850	-249.33	125.99	8.08	Ontario	Telephones and Communication	0.57
\N	4227	Acme® Design Stainless Steel Bent Scissors	Stephanie Ulpright	54950	-57.17	6.84	4.42	Ontario	Scissors, Rulers and Trimmers	0.58
\N	4228	Bush Advantage Collection® Racetrack Conference Table	Stephanie Ulpright	54950	-1025.19	424.21	110.2	Ontario	Tables	0.67
\N	4229	Imation DVD-RAM discs	Katherine Nockton	55172	-120.97	35.41	1.99	Ontario	Computer Peripherals	0.43
\N	4230	6340	Jane Waco	55235	730.51	85.99	2.79	Ontario	Telephones and Communication	0.58
\N	4231	Eureka Disposable Bags for Sanitaire® Vibra Groomer I® Upright Vac	Sally Hughsby	55300	-185.17	4.06	6.89	Ontario	Appliances	0.6
\N	4232	Avery 510	Sally Hughsby	55300	82.38	3.75	0.5	Ontario	Labels	0.37
\N	4233	Dana Swing-Arm Lamps	Sally Hughsby	55300	-231.05	10.68	13.04	Ontario	Office Furnishings	0.6
\N	4234	Sanford EarthWrite® Recycled Pencils, Medium Soft, #2	Lena Radford	55398	2.38	2.1	0.7	Ontario	Pens & Art Supplies	0.57
\N	4235	Staples Standard Envelopes	John Castell	55553	52.61	5.68	1.39	Ontario	Envelopes	0.38
\N	4236	Global Troy™ Executive Leather Low-Back Tilter	John Lucas	55747	4801.82	500.98	26	Ontario	Chairs & Chairmats	0.6
\N	4237	Chromcraft Bull-Nose Wood 48" x 96" Rectangular Conference Tables	John Lucas	55747	-1331.55	550.98	64.59	Ontario	Tables	0.66
\N	4238	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Katherine Nockton	55779	376.21	160.98	30	Ontario	Chairs & Chairmats	0.62
\N	4239	Multi-Use Personal File Cart and Caster Set, Three Stacking Bins	John Lucas	56418	226.76	34.76	8.22	Ontario	Storage & Organization	0.57
\N	4240	Southworth 25% Cotton Antique Laid Paper & Envelopes	Karen Daniels	56580	-17.03	8.34	4.82	Ontario	Paper	0.4
\N	4241	Tennsco Lockers, Gray	Karen Daniels	56580	-2103.05	20.98	53.03	Ontario	Storage & Organization	0.78
\N	4242	Riverside Furniture Stanwyck Manor Table Series	Karen Daniels	56580	-693.23	286.85	61.76	Ontario	Tables	0.78
\N	4243	Belkin F9M820V08 8 Outlet Surge	Scott Cohen	56807	-24.63	42.98	4.62	Ontario	Appliances	0.56
\N	4244	Office Star - Task Chair with Contemporary Loop Arms	Steve Nguyen	56837	-71.48	90.98	30	Ontario	Chairs & Chairmats	0.61
\N	4245	Binder Posts	Sarah Foster	56995	-57.06	5.74	5.01	Ontario	Binders and Binder Accessories	0.39
\N	4246	Alliance Rubber Bands	Vivek Grady	57091	-2.79	1.68	1.02	Ontario	Rubber Bands	0.81
\N	4247	Xerox 1993	Stuart Calhoun	57155	-133.73	6.48	9.68	Ontario	Paper	0.36
\N	4248	File Shuttle II and Handi-File, Black	Stuart Calhoun	57155	60.82	33.89	5.1	Ontario	Storage & Organization	0.6
\N	4249	Electrix Fluorescent Magnifier Lamps & Weighted Base	Matt Connell	57185	385.03	49.34	10.25	Ontario	Office Furnishings	0.57
\N	4250	Logitech Cordless Elite Duo	John Castell	57409	-259.63	100.98	7.18	Ontario	Computer Peripherals	0.4
\N	4251	6185	John Castell	57409	1928.66	205.99	3	Ontario	Telephones and Communication	0.58
\N	4252	Eaton Premium Continuous-Feed Paper, 25% Cotton, Letter Size, White, 1000 Shts/Box	John Lucas	57542	517.03	55.48	6.79	Ontario	Paper	0.37
\N	4253	Electrix Architect's Clamp-On Swing Arm Lamp, Black	John Castell	57639	330.5	95.46	18.13	Ontario	Office Furnishings	0.56
\N	4254	Wilson Jones Hanging View Binder, White, 1"	Vivek Grady	57856	-42.17	7.1	6.05	Ontario	Binders and Binder Accessories	0.39
\N	4255	Newell 339	Vivek Grady	57856	5.7	2.78	0.97	Ontario	Pens & Art Supplies	0.59
\N	4256	Avery Flip-Chart Easel Binder, Black	Arthur Prichep	58435	-35.62	22.38	15.1	Ontario	Binders and Binder Accessories	0.38
\N	4257	Xerox 197	Sally Hughsby	59009	-7.02	30.98	17.08	Ontario	Paper	0.4
\N	4258	Fellowes PB300 Plastic Comb Binding Machine	Greg Hansen	59491	5528.5	387.99	19.99	Ontario	Binders and Binder Accessories	0.38
\N	4259	Belkin 107-key enhanced keyboard, USB/PS/2 interface	Karen Daniels	59554	-81.49	17.98	4	Ontario	Computer Peripherals	0.79
\N	4260	Nu-Dell Leatherette Frames	Greg Hansen	59559	7.69	14.34	5	Ontario	Office Furnishings	0.49
\N	4261	GBC DocuBind 300 Electric Binding Machine	Alejandro Grove	59745	7917.76	525.98	19.99	Ontario	Binders and Binder Accessories	0.37
\N	4262	Black Print Carbonless Snap-Off® Rapid Letter, 8 1/2" x 7"	Lindsay Shagiari	59906	81.29	9.11	2.15	Ontario	Paper	0.4
\N	4263	Staples Bulk Pack Metal Binder Clips	Darrin Martin	454	56.22	6.08	1.82	Ontario	Rubber Bands	0.35
\N	4264	Xerox 1922	Ken Brennan	549	-59.75	4.98	7.44	Ontario	Paper	0.36
\N	4265	Xerox 1984	Ken Brennan	549	-27.57	6.48	8.74	Ontario	Paper	0.36
\N	4266	Eldon Base for stackable storage shelf, platinum	Ken Brennan	549	-911.56	38.94	35	Ontario	Storage & Organization	0.8
\N	4267	Fellowes Stor/Drawer® Steel Plus™ Storage Drawers	Max Jones	999	-179.5	95.43	19.99	Ontario	Storage & Organization	0.79
\N	4268	Wilson Jones Impact Binders	Lena Creighton	1286	-144.68	5.18	5.74	Ontario	Binders and Binder Accessories	0.36
\N	4269	Accessory20	Lena Creighton	1286	229.78	85.99	3.3	Ontario	Telephones and Communication	0.37
\N	4270	Sauder Facets Collection Locker/File Cabinet, Sky Alder Finish	Ken Brennan	1831	619.71	370.98	99	Ontario	Storage & Organization	0.65
\N	4271	Ibico Presentation Index for Binding Systems	Joe Kamberova	1892	-152.52	3.98	5.26	Ontario	Binders and Binder Accessories	0.38
\N	4272	Xerox 207	Joe Kamberova	1892	-18.85	6.48	5.4	Ontario	Paper	0.37
\N	4273	3M Polarizing Task Lamp with Clamp Arm, Light Gray	Barry Franz	1991	921.7	136.98	24.49	Ontario	Office Furnishings	0.59
\N	4274	Okidata ML320 Series Turbo Dot Matrix Printers	Barry Franz	1991	5050.1	399.98	12.06	Ontario	Office Machines	0.56
\N	4275	80 Minute Slim Jewel Case CD-R , 10/Pack - Staples	Odella Nelson	4610	-17.01	8.33	1.99	Ontario	Computer Peripherals	0.52
\N	4276	#10 White Business Envelopes,4 1/8 x 9 1/2	Odella Nelson	4610	203.01	15.67	1.39	Ontario	Envelopes	0.38
\N	4277	X-Rack™ File for Hanging Folders	Max Jones	5697	-13.32	11.29	5.03	Ontario	Storage & Organization	0.59
\N	4278	Belkin 325VA UPS Surge Protector, 6'	Filia McAdams	5986	1638.48	120.98	3.99	Ontario	Appliances	0.6
\N	4279	Global Deluxe Stacking Chair, Gray	Filia McAdams	5986	64.81	50.98	14.19	Ontario	Chairs & Chairmats	0.56
\N	4280	Maxell 3.5" DS/HD IBM-Formatted Diskettes, 10/Pack	Filia McAdams	5986	-148.77	4.89	4.93	Ontario	Computer Peripherals	0.66
\N	4281	Durable Pressboard Binders	Maureen Fritzler	6053	-3.75	3.8	1.49	Ontario	Binders and Binder Accessories	0.38
\N	4282	Belkin 6 Outlet Metallic Surge Strip	Lena Creighton	6432	-38.45	10.89	4.5	Ontario	Appliances	0.59
\N	4283	Rediform Wirebound "Phone Memo" Message Book, 11 x 5-3/4	Max Jones	6502	-36.46	7.64	5.83	Ontario	Paper	0.36
\N	4284	Xerox 1948	Max Jones	6502	13.46	9.99	5.12	Ontario	Paper	0.4
\N	4285	Ibico Recycled Linen-Style Covers	Dennis Bolton	6656	508.96	39.06	10.55	Ontario	Binders and Binder Accessories	0.37
\N	4286	Vinyl Sectional Post Binders	Dennis Bolton	6656	805.43	37.7	2.99	Ontario	Binders and Binder Accessories	0.35
\N	4287	GBC Standard Plastic Binding Systems Combs	Maureen Fritzler	7072	-15.96	8.85	5.6	Ontario	Binders and Binder Accessories	0.36
\N	4288	Keytronic Designer 104- Key Black Keyboard	Art Foster	7429	-470.85	40.48	19.99	Ontario	Computer Peripherals	0.77
\N	4289	DAX Natural Wood-Tone Poster Frame	Art Foster	7429	101.78	26.48	6.93	Ontario	Office Furnishings	0.49
\N	4290	Tenex B1-RE Series Chair Mats for Low Pile Carpets	Erica Hackney	7910	346.43	45.98	4.8	Ontario	Office Furnishings	0.68
\N	4291	Xerox 1932	Erica Hackney	7910	250.43	35.44	5.09	Ontario	Paper	0.38
\N	4292	Holmes Odor Grabber	Don Weiss	8035	-24.2	14.42	6.75	Ontario	Appliances	0.52
\N	4293	Microsoft Natural Keyboard Elite	Jessica Myrick	8961	-12.02	39.98	4	Ontario	Computer Peripherals	0.7
\N	4294	Round Specialty Laser Printer Labels	Darrin Martin	9606	263.4	12.53	0.49	Ontario	Labels	0.38
\N	4295	Array® Memo Cubes	Darrin Martin	9606	37.31	5.18	2.04	Ontario	Paper	0.36
\N	4296	Multimedia Mailers	Bruce Degenhardt	9857	703.8	162.93	19.99	Ontario	Envelopes	0.39
\N	4297	9-3/4 Diameter Round Wall Clock	Bruce Degenhardt	9857	-17.49	13.79	8.78	Ontario	Office Furnishings	0.43
\N	4298	Accessory39	Bruce Degenhardt	9857	-93.61	20.99	3.3	Ontario	Telephones and Communication	0.81
\N	4299	600 Series Non-Flip	Jenna Caffey	10851	3.96	45.99	4.99	Ontario	Telephones and Communication	0.57
\N	4300	Manila Recycled Extra-Heavyweight Clasp Envelopes, 6" x 9"	Kalyca Meade	11233	35.72	10.98	4.8	Ontario	Envelopes	0.36
\N	4301	Staples Pen Style Liquid Stix; Assorted (yellow, pink, green, blue, orange), 5/Pack	Dennis Bolton	11493	38.03	6.47	1.22	Ontario	Pens & Art Supplies	0.4
\N	4302	Hon Olson Stacker Stools	Jenna Caffey	11684	53.87	140.81	24.49	Ontario	Chairs & Chairmats	0.57
\N	4303	Wilson Jones Impact Binders	Max Jones	11975	-145.72	5.18	5.74	Ontario	Binders and Binder Accessories	0.36
\N	4304	It's Hot Message Books with Stickers, 2 3/4" x 5"	Lena Creighton	13537	110.34	7.4	1.71	Ontario	Paper	0.4
\N	4305	Avery 501	Art Foster	13670	57.63	3.69	0.5	Ontario	Labels	0.38
\N	4306	Newell 336	Ken Brennan	13764	11.93	4.28	0.94	Ontario	Pens & Art Supplies	0.56
\N	4307	Xerox 188	Jenna Caffey	13953	67.6	11.34	5.01	Ontario	Paper	0.36
\N	4308	Eldon® Image Series Desk Accessories, Burgundy	Troy Blackwell	14119	-95.41	4.18	6.92	Ontario	Office Furnishings	0.49
\N	4309	Accessory24	Troy Blackwell	14119	296.66	55.99	3.3	Ontario	Telephones and Communication	0.59
\N	4310	Accessory27	Troy Blackwell	14119	-158.61	35.99	5	Ontario	Telephones and Communication	0.85
\N	4311	Office Star - Mid Back Dual function Ergonomic High Back Chair with 2-Way Adjustable Arms	Jessica Myrick	14402	-106.33	160.98	30	Ontario	Chairs & Chairmats	0.62
\N	4312	Microsoft Internet Keyboard	Harry Marie	14499	-148.87	20.97	6.5	Ontario	Computer Peripherals	0.78
\N	4313	Logitech Cordless Navigator Duo	Erica Hackney	15079	1276.25	80.98	7.18	Ontario	Computer Peripherals	0.48
\N	4314	Xerox 1917	Erica Hackney	15079	468.19	48.91	5.97	Ontario	Paper	0.38
\N	4315	Heavy-Duty E-Z-D® Binders	Lena Creighton	15236	71.5	10.91	2.99	Ontario	Binders and Binder Accessories	0.38
\N	4316	Eldon® 500 Class™ Desk Accessories	Lena Creighton	15236	31.24	12.07	6.2	Ontario	Office Furnishings	0.52
\N	4317	DS/HD IBM Formatted Diskettes, 10/Pack - Staples	Troy Blackwell	15397	-111.89	4.98	4.32	Ontario	Computer Peripherals	0.64
\N	4318	Targus USB Numeric Keypad	Troy Blackwell	15397	-53.81	40.98	6.5	Ontario	Computer Peripherals	0.74
\N	4319	12 Colored Short Pencils	Troy Blackwell	15397	-51.3	2.6	2.4	Ontario	Pens & Art Supplies	0.58
\N	4320	Global Leather and Oak Executive Chair, Black	Troy Blackwell	15719	604.46	300.98	64.73	Ontario	Chairs & Chairmats	0.56
\N	4321	Large Capacity Hanging Post Binders	Patricia Hirasaki	16098	333.53	24.95	2.99	Ontario	Binders and Binder Accessories	0.39
\N	4322	Wausau Papers Astrobrights® Colored Envelopes	Dennis Bolton	16450	5.71	5.98	2.5	Ontario	Envelopes	0.36
\N	4323	Eldon ClusterMat Chair Mat with Cordless Antistatic Protection	Ken Brennan	17186	-1549.14	90.98	56.2	Ontario	Office Furnishings	0.74
\N	4324	Xerox 1947	Ken Brennan	17186	-29.98	5.98	5.35	Ontario	Paper	0.4
\N	4325	Sauder Camden County Collection Libraries, Planked Cherry Finish	Harry Marie	17379	-1248.58	114.98	58.72	Ontario	Bookcases	0.76
\N	4326	DAX Two-Tone Rosewood/Black Document Frame, Desktop, 5 x 7	Clytie Kelty	17573	-25.86	9.48	7.29	Ontario	Office Furnishings	0.45
\N	4327	Hoover Commercial Soft Guard Upright Vacuum And Disposable Filtration Bags	Mark Cousins	17702	-305.91	7.77	9.23	Ontario	Appliances	0.58
\N	4328	Honeywell Quietcare HEPA Air Cleaner	Art Foster	18595	-35.19	78.65	13.99	Ontario	Appliances	0.52
\N	4329	Acme® Elite Stainless Steel Scissors	Art Foster	18595	0.9	8.34	2.64	Ontario	Scissors, Rulers and Trimmers	0.59
\N	4330	Xerox 1935	Odella Nelson	19205	479.62	26.38	5.86	Ontario	Paper	0.39
\N	4331	Avery Hi-Liter GlideStik Fluorescent Highlighter, Yellow Ink	Odella Nelson	19205	2.36	3.26	1.86	Ontario	Pens & Art Supplies	0.41
\N	4332	Executive Impressions 14" Contract Wall Clock with Quartz Movement	Clytie Kelty	19494	195.71	22.23	8.99	Ontario	Office Furnishings	0.41
\N	4333	Rogers Handheld Barrel Pencil Sharpener	Clytie Kelty	19494	-6.79	2.74	3.5	Ontario	Pens & Art Supplies	0.58
\N	4334	Telephone Message Books with Fax/Mobile Section, 4 1/4" x 6"	Jim Sink	19523	-10	3.6	2.2	Ontario	Paper	0.39
\N	4335	Sauder Camden County Barrister Bookcase, Planked Cherry Finish	Steven Roelle	20482	-1143.15	120.98	60.19	Ontario	Bookcases	0.71
\N	4336	Xerox 1907	Steven Roelle	20482	92.46	12.28	5.09	Ontario	Paper	0.38
\N	4337	Letter Slitter	Harry Marie	21414	-72.86	2.52	1.92	Ontario	Scissors, Rulers and Trimmers	0.82
\N	4338	Eureka Disposable Bags for Sanitaire® Vibra Groomer I® Upright Vac	Clytie Kelty	21445	-63.53	4.06	6.89	Ontario	Appliances	0.6
\N	4339	Sharp EL501VB Scientific Calculator, Battery Operated, 10-Digit Display, Hard Case	Clytie Kelty	21445	-38.58	9.49	5.76	Ontario	Office Machines	0.39
\N	4340	Avery 511	Don Weiss	21573	24.05	3.08	0.99	Ontario	Labels	0.37
\N	4341	DAX Charcoal/Nickel-Tone Document Frame, 5 x 7	Don Weiss	21573	8.02	9.48	3.72	Ontario	Office Furnishings	0.4
\N	4342	KI Conference Tables	Don Weiss	21573	54.23	70.89	89.3	Ontario	Tables	0.69
\N	4343	Avery Flip-Chart Easel Binder, Black	Fred Wasserman	21636	-52.65	22.38	15.1	Ontario	Binders and Binder Accessories	0.38
\N	4344	Perma STOR-ALL™ Hanging File Box, 13 1/8"W x 12 1/4"D x 10 1/2"H	Fred Wasserman	21636	-24.44	5.98	4.69	Ontario	Storage & Organization	0.68
\N	4345	Belkin MediaBoard 104- Keyboard	Jessica Myrick	21795	-77.36	27.48	4	Ontario	Computer Peripherals	0.75
\N	4346	Computer Printout Paper with Letter-Trim Perforations	Jessica Myrick	21795	4.54	18.97	9.03	Ontario	Paper	0.37
\N	4347	Staples 10" Round Wall Clock	Kalyca Meade	21859	13.31	9.74	5.71	Ontario	Office Furnishings	0.41
\N	4348	Eldon® 500 Class™ Desk Accessories	Lena Creighton	21989	30.8	12.07	6.2	Ontario	Office Furnishings	0.52
\N	4349	i1000plus	Lena Creighton	21989	1077.13	125.99	4.2	Ontario	Telephones and Communication	0.57
\N	4350	GBC Standard Therm-A-Bind Covers	Beth Thompson	22151	9.82	24.92	12.98	Ontario	Binders and Binder Accessories	0.39
\N	4351	2190	Maureen Fritzler	22688	334.53	65.99	5.63	Ontario	Telephones and Communication	0.56
\N	4352	Xerox 1997	Pete Takahito	22916	-115	6.48	10.05	Ontario	Paper	0.37
\N	4353	StarTAC Analog	Lena Creighton	22951	34.36	65.99	8.99	Ontario	Telephones and Communication	0.6
\N	4354	Xerox 1952	Rob Haberlin	22980	-27.73	4.98	5.49	Ontario	Paper	0.38
\N	4355	Pressboard Data Binder, Crimson, 12" X 8 1/2"	Beth Thompson	23429	-82.82	5.34	5.63	Ontario	Binders and Binder Accessories	0.39
\N	4356	8860	Beth Thompson	23429	107.08	65.99	5.26	Ontario	Telephones and Communication	0.56
\N	4357	Safco Industrial Wire Shelving	Jenna Caffey	23681	-785.36	95.99	35	Ontario	Storage & Organization	\N
\N	4358	Metal Folding Chairs, Beige, 4/Carton	Rob Haberlin	24263	-177.07	33.94	19.19	Ontario	Chairs & Chairmats	0.58
\N	4359	IBM 80 Minute CD-R Spindle, 50/Pack	Fred Wasserman	24455	-10.59	20.89	1.99	Ontario	Computer Peripherals	0.48
\N	4360	Fluorescent Highlighters by Dixon	Fred Wasserman	24455	27.38	3.98	0.83	Ontario	Pens & Art Supplies	0.51
\N	4361	3M Polarizing Task Lamp with Clamp Arm, Light Gray	Don Weiss	24707	761.04	136.98	24.49	Ontario	Office Furnishings	0.59
\N	4362	Binder Clips by OIC	Don Weiss	24707	-1.76	1.48	0.7	Ontario	Rubber Bands	0.37
\N	4363	GBC Recycled Grain Textured Covers	Lena Creighton	25091	-25.43	34.54	14.72	Ontario	Binders and Binder Accessories	0.37
\N	4364	Avery Flip-Chart Easel Binder, Black	Max Jones	26305	-122.79	22.38	15.1	Ontario	Binders and Binder Accessories	0.38
\N	4365	Bevis Boat-Shaped Conference Table	Max Jones	26305	-633.44	262.11	62.74	Ontario	Tables	0.75
\N	4366	Xerox 194	Clytie Kelty	26982	585.03	55.48	14.3	Ontario	Paper	0.37
\N	4367	Heavy-Duty E-Z-D® Binders	Lena Creighton	27106	-4.7	10.91	2.99	Ontario	Binders and Binder Accessories	0.38
\N	4368	Laser & Ink Jet Business Envelopes	Lena Creighton	27106	232.58	10.67	1.39	Ontario	Envelopes	0.39
\N	4369	Office Star - Contemporary Task Swivel chair with 2-way adjustable arms, Plum	Lena Creighton	27106	-570.18	130.98	30	Ontario	Chairs & Chairmats	0.78
\N	4370	Executive Impressions 14" Contract Wall Clock	Lena Creighton	27106	297.11	22.23	3.63	Ontario	Office Furnishings	0.52
\N	4371	Sanford Liquid Accent Highlighters	Lena Creighton	27106	3.77	6.68	1.5	Ontario	Pens & Art Supplies	0.48
\N	4372	Executive Impressions 8-1/2" Career Panel/Partition Cubicle Clock	Rob Haberlin	27527	1.33	10.4	5.4	Ontario	Office Furnishings	0.51
\N	4373	Sharp AL-1530CS Digital Copier	Jenna Caffey	27746	-1572.64	499.99	24.49	Ontario	Copiers and Fax	0.36
\N	4374	GBC Pre-Punched Binding Paper, Plastic, White, 8-1/2" x 11"	Odella Nelson	27811	-39.64	15.99	13.18	Ontario	Binders and Binder Accessories	0.37
\N	4375	SAFCO Optional Arm Kit for Workspace® Cribbage Stacking Chair	Art Foster	27974	127.17	26.64	5.3	Ontario	Chairs & Chairmats	\N
\N	4376	Eldon® 500 Class™ Desk Accessories	Art Foster	27974	-6.7	12.07	6.2	Ontario	Office Furnishings	0.52
\N	4377	Perma STOR-ALL™ Hanging File Box, 13 1/8"W x 12 1/4"D x 10 1/2"H	Jessica Myrick	28774	-111.8	5.98	4.69	Ontario	Storage & Organization	0.68
\N	4378	Xerox 1907	Ken Brennan	29607	21.05	12.28	5.09	Ontario	Paper	0.38
\N	4379	Iceberg OfficeWorks 42" Round Tables	Ken Brennan	29730	-364.87	150.98	39.25	Ontario	Tables	0.75
\N	4380	BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	Joe Kamberova	30144	-528.65	218.75	69.64	Ontario	Tables	0.77
\N	4381	Okidata ML320 Series Turbo Dot Matrix Printers	Rob Haberlin	31266	1197.05	399.98	12.06	Ontario	Office Machines	0.56
\N	4382	Acco D-Ring Binder w/DublLock®	Lena Creighton	31456	64.14	21.38	2.99	Ontario	Binders and Binder Accessories	0.36
\N	4383	Executive Impressions 14" Contract Wall Clock	Max Jones	31522	134.21	22.23	3.63	Ontario	Office Furnishings	0.52
\N	4384	Global Stack Chair without Arms, Black	Max Jones	31522	-226.41	25.98	14.36	Ontario	Chairs & Chairmats	0.6
\N	4385	Global Leather & Oak Executive Chair, Burgundy	Don Weiss	33319	-505.76	150.89	60.2	Ontario	Chairs & Chairmats	0.77
\N	4386	Lexmark Z55se Color Inkjet Printer	Darrin Martin	33635	-173.1	90.97	28	Ontario	Office Machines	0.38
\N	4387	Tennsco Commercial Shelving	Darrin Martin	33635	-96.16	20.34	35	Ontario	Storage & Organization	0.84
\N	4388	Imation 3.5, DISKETTE 44766 HGHLD3.52HD/FM, 10/Pack	Rob Haberlin	33988	-128.47	5.02	5.14	Ontario	Computer Peripherals	0.79
\N	4389	636	Jim Sink	34087	745.48	115.99	5.26	Ontario	Telephones and Communication	0.57
\N	4390	Hoover Commercial Soft Guard Upright Vacuum And Disposable Filtration Bags	Clytie Kelty	34691	-168.75	7.77	9.23	Ontario	Appliances	0.58
\N	4391	Okidata ML184 Turbo Dot Matrix Printers	Clytie Kelty	34691	1425.11	306.14	26.53	Ontario	Office Machines	0.56
\N	4392	Xerox 1939	Clytie Kelty	34691	-7.39	18.97	9.54	Ontario	Paper	0.37
\N	4393	Bretford CR8500 Series Meeting Room Furniture	Jim Sink	34785	-969.05	400.98	42.52	Ontario	Tables	0.71
\N	4394	Accessory41	Pete Takahito	34883	248.67	35.99	5.99	Ontario	Telephones and Communication	0.38
\N	4395	Newell 343	Michael Dominguez	35077	-2.07	2.94	0.96	Ontario	Pens & Art Supplies	0.58
\N	4396	Chromcraft Rectangular Conference Tables	Hallie Redmond	36132	-572.69	236.97	59.24	Ontario	Tables	0.61
\N	4397	Southworth 25% Cotton Premium Laser Paper and Envelopes	Katrina Willman	36133	-7.84	19.98	8.68	Ontario	Paper	0.37
\N	4398	Xerox 21	Steven Roelle	37891	-65.54	6.48	6.6	Ontario	Paper	0.37
\N	4399	Brites Rubber Bands, 1 1/2 oz. Box	Steven Roelle	37891	-9.09	1.98	0.7	Ontario	Rubber Bands	0.83
\N	4400	Bevis Round Bullnose 29" High Table Top	Steven Roelle	37891	-627.64	259.71	66.67	Ontario	Tables	0.61
\N	4401	VTech VT20-2481 2.4GHz Two-Line Phone System w/Answering Machine	Steven Roelle	37891	1184.68	179.99	13.99	Ontario	Telephones and Communication	0.57
\N	4402	Sanyo 2.5 Cubic Foot Mid-Size Office Refrigerators	Rob Haberlin	38021	834.96	279.81	23.19	Ontario	Appliances	0.59
\N	4403	Avery 508	Rob Haberlin	38021	81.77	4.91	0.5	Ontario	Labels	0.36
\N	4404	Luxo Economy Swing Arm Lamp	Erica Hackney	38146	-253.74	19.94	14.87	Ontario	Office Furnishings	0.57
\N	4405	ACCOHIDE® Binder by Acco	John Castell	38656	-148.4	4.13	5.34	Ontario	Binders and Binder Accessories	0.38
\N	4406	Global Ergonomic Managers Chair	John Castell	38656	-199.46	180.98	26.2	Ontario	Chairs & Chairmats	0.59
\N	4407	Talkabout T8367	Benjamin Patterson	38756	308.93	65.99	8.99	Ontario	Telephones and Communication	0.56
\N	4408	Wilson Jones Hanging View Binder, White, 1"	Maureen Fritzler	39268	-89.75	7.1	6.05	Ontario	Binders and Binder Accessories	0.39
\N	4409	Rubber Band Ball	Maureen Fritzler	39268	-32.52	3.74	0.94	Ontario	Rubber Bands	0.83
\N	4410	Ampad #10 Peel & Seel® Holiday Envelopes	Michael Dominguez	39488	8.6	4.48	2.5	Ontario	Envelopes	0.37
\N	4411	Global Leather Task Chair, Black	Jessica Myrick	39650	-189.02	89.99	42	Ontario	Chairs & Chairmats	0.66
\N	4412	Master Caster Door Stop, Large Neon Orange	Jessica Myrick	39650	-175.15	7.28	7.98	Ontario	Office Furnishings	0.42
\N	4413	Fellowes Stor/Drawer® Steel Plus™ Storage Drawers	Jim Sink	39844	-286.47	95.43	19.99	Ontario	Storage & Organization	0.79
\N	4414	Xerox 216	Jim Sink	40800	-175.26	6.48	7.91	Ontario	Paper	0.37
\N	4415	Hon Non-Folding Utility Tables	Mark Cousins	40965	-385	159.31	60	Ontario	Tables	0.55
\N	4416	Accessory36	Mark Cousins	40965	-139.84	55.99	5	Ontario	Telephones and Communication	0.83
\N	4417	Avery Premier Heavy-Duty Binder with Round Locking Rings	John Castell	41316	21	14.28	2.99	Ontario	Binders and Binder Accessories	0.39
\N	4418	3285	John Castell	41316	-787.7	205.99	5.99	Ontario	Telephones and Communication	0.59
\N	4419	Super Bands, 12/Pack	Mark Cousins	41476	-104.8	1.86	2.58	Ontario	Rubber Bands	0.82
\N	4420	Xerox 1936	Kalyca Meade	41861	110.44	19.98	5.97	Ontario	Paper	0.38
\N	4421	US Robotics 56K V.92 External Faxmodem	Lena Creighton	42274	241.15	99.99	19.99	Ontario	Computer Peripherals	0.52
\N	4422	Eldon® 500 Class™ Desk Accessories	Lena Creighton	42274	-28.81	12.07	6.2	Ontario	Office Furnishings	0.52
\N	4423	Staples 6 Outlet Surge	Michael Dominguez	42882	-22.55	11.97	4.98	Ontario	Appliances	0.58
\N	4424	Eldon® Wave Desk Accessories	Max Jones	43360	-178.29	2.08	5.33	Ontario	Office Furnishings	0.43
\N	4425	12 Colored Short Pencils	Odella Nelson	43713	-17.69	2.6	2.4	Ontario	Pens & Art Supplies	0.58
\N	4426	SAFCO Mobile Desk Side File, Wire Frame	Max Jones	44322	43.55	42.76	6.22	Ontario	Storage & Organization	\N
\N	4427	Lifetime Advantage™ Folding Chairs, 4/Carton	Clytie Kelty	44579	755.28	218.08	18.06	Ontario	Chairs & Chairmats	0.57
\N	4428	Space Solutions Commercial Steel Shelving	Duane Benoit	44737	-309.48	64.65	35	Ontario	Storage & Organization	0.8
\N	4429	Accessory25	Duane Benoit	44737	38.91	20.99	0.99	Ontario	Telephones and Communication	0.57
\N	4430	Sanford EarthWrite® Recycled Pencils, Medium Soft, #2	Max Jones	44738	6.87	2.1	0.7	Ontario	Pens & Art Supplies	0.57
\N	4431	Hon 4700 Series Mobuis™ Mid-Back Task Chairs with Adjustable Arms	Mark Cousins	44768	3083.98	355.98	58.92	Ontario	Chairs & Chairmats	0.64
\N	4432	Global Troy™ Executive Leather Low-Back Tilter	Max Jones	44867	7360.43	500.98	26	Ontario	Chairs & Chairmats	0.6
\N	4433	Bevis Boat-Shaped Conference Table	Gene McClure	45029	-633.44	262.11	62.74	Ontario	Tables	0.75
\N	4434	KI Conference Tables	Denny Joy	45543	-1615.59	70.89	89.3	Ontario	Tables	0.69
\N	4435	Memorex 80 Minute CD-R Spindle, 100/Pack	Denny Joy	45635	731.72	43.98	1.99	Ontario	Computer Peripherals	0.44
\N	4436	Accessory31	Odella Nelson	46436	840.05	35.99	0.99	Ontario	Telephones and Communication	0.35
\N	4437	Fellowes Stor/Drawer® Steel Plus™ Storage Drawers	John Castell	46848	-67.68	95.43	19.99	Ontario	Storage & Organization	0.79
\N	4438	US Robotics 56K V.92 Internal PCI Faxmodem	Clytie Kelty	47009	-22.33	49.99	19.99	Ontario	Computer Peripherals	0.45
\N	4439	M70	Benjamin Patterson	47138	-506.31	125.99	8.99	Ontario	Telephones and Communication	0.59
\N	4440	Tripp Lite Isotel 8 Ultra 8 Outlet Metal Surge	Michael Dominguez	47236	-45.43	70.97	3.5	Ontario	Appliances	0.59
\N	4441	Newell 325	Michael Dominguez	47686	3.32	4.13	1.23	Ontario	Pens & Art Supplies	0.55
\N	4442	Eldon® 300 Class™ Desk Accessories, Black	Duane Benoit	47971	-53.06	4.95	5.32	Ontario	Office Furnishings	0.41
\N	4443	Office Star - Contemporary Task Swivel chair with 2-way adjustable arms, Plum	Michael Dominguez	48261	-113.77	130.98	30	Ontario	Chairs & Chairmats	0.78
\N	4444	Wirebound Message Books, 2 7/8" x 5", 3 Forms per Page	Amy Cox	48773	3.27	7.04	2.17	Ontario	Paper	0.38
\N	4445	Xerox 220	Benjamin Patterson	48902	-28.88	6.48	7.49	Ontario	Paper	0.37
\N	4446	Canon P1-DHIII Palm Printing Calculator	Maureen Fritzler	49221	-15.42	17.98	8.51	Ontario	Office Machines	0.4
\N	4447	Xerox 20	Maureen Fritzler	49221	-103.28	6.48	6.57	Ontario	Paper	0.37
\N	4448	Safco Value Mate Steel Bookcase, Baked Enamel Finish on Steel, Black	Mark Cousins	49255	-102.3	70.98	26.85	Ontario	Bookcases	\N
\N	4449	Wilson Jones Elliptical Ring 3 1/2" Capacity Binders, 800 sheets	Kalyca Meade	49575	170.9	42.8	2.99	Ontario	Binders and Binder Accessories	0.36
\N	4450	GBC VeloBinder Electric Binding Machine	Michael Dominguez	50144	1765.54	120.98	9.07	Ontario	Binders and Binder Accessories	0.35
\N	4451	Global Deluxe High-Back Office Chair in Storm	Odella Nelson	50181	-246.21	135.99	28.63	Ontario	Chairs & Chairmats	0.76
\N	4452	Office Star - Ergonomic Mid Back Chair with 2-Way Adjustable Arms	Hallie Redmond	52324	-224.35	180.98	30	Ontario	Chairs & Chairmats	0.69
\N	4453	Ibico Ibimaster 300 Manual Binding System	Lena Creighton	52896	3545.89	367.99	19.99	Ontario	Binders and Binder Accessories	0.4
\N	4454	Avery 506	Lena Creighton	52896	77.02	4.13	0.5	Ontario	Labels	0.39
\N	4455	Bretford CR8500 Series Meeting Room Furniture	Lena Creighton	52896	-969.05	400.98	76.37	Ontario	Tables	0.6
\N	4456	Xerox 1937	Clytie Kelty	53441	84.34	48.04	5.79	Ontario	Paper	0.37
\N	4457	Boston 16765 Mini Stand Up Battery Pencil Sharpener	Odella Nelson	53445	-44.33	11.66	8.99	Ontario	Pens & Art Supplies	0.59
\N	4458	Acco® Hot Clips™ Clips to Go	Odella Nelson	53445	11.23	3.29	1.35	Ontario	Rubber Bands	0.4
\N	4459	O'Sullivan Living Dimensions 2-Shelf Bookcases	Lena Creighton	54055	-1330.5	120.98	58.64	Ontario	Bookcases	0.75
\N	4460	Adams Write n' Stick Phone Message Book, 11" X 5 1/4", 200 Messages	Amy Cox	54151	65.88	5.68	1.46	Ontario	Paper	0.39
\N	4461	Prang Dustless Chalk Sticks	Amy Cox	54151	1.42	1.68	1	Ontario	Pens & Art Supplies	0.35
\N	4462	Panasonic KX-P2130 Dot Matrix Printer	Duane Benoit	54181	67.36	213.45	14.7	Ontario	Office Machines	0.59
\N	4463	Laminate Occasional Tables	Amy Cox	54243	-634.73	154.13	69	Ontario	Tables	0.68
\N	4464	GBC DocuBind 200 Manual Binding Machine	Maureen Fritzler	54407	3857.57	420.98	19.99	Ontario	Binders and Binder Accessories	0.35
\N	4465	Anderson Hickey Conga Table Tops & Accessories	Benjamin Patterson	55394	11.65	15.23	27.75	Ontario	Tables	0.76
\N	4466	Iceberg OfficeWorks 42" Round Tables	Katrina Willman	56003	-364.87	150.98	16.01	Ontario	Tables	0.7
\N	4467	Boston KS Multi-Size Manual Pencil Sharpener	Hallie Redmond	56128	-49.66	22.99	8.99	Ontario	Pens & Art Supplies	0.57
\N	4468	Hon 61000 Series Interactive Training Tables	Hallie Redmond	56128	33.99	44.43	46.59	Ontario	Tables	0.67
\N	4469	Hoover Portapower™ Portable Vacuum	Steven Roelle	56384	-2172.14	4.48	49	Ontario	Appliances	0.6
\N	4470	BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	Steven Roelle	56384	-528.65	218.75	69.64	Ontario	Tables	0.77
\N	4471	i2000	Duane Benoit	56646	1059.08	125.99	2.5	Ontario	Telephones and Communication	0.6
\N	4472	Micro Innovations Micro Digital Wireless Keyboard and Mouse, Gray	Ken Brennan	56967	311.58	83.1	6.13	Ontario	Computer Peripherals	0.45
\N	4473	Avery 496	Amy Cox	57479	54.78	3.75	0.5	Ontario	Labels	0.37
\N	4474	Imation Printable White 80 Minute CD-R Spindle, 50/Pack	Pete Takahito	57699	752.96	40.98	1.99	Ontario	Computer Peripherals	0.44
\N	4475	Tyvek Interoffice Envelopes, 9 1/2" x 12 1/2", 100/Box	Pete Takahito	57699	485.02	60.98	19.99	Ontario	Envelopes	0.38
\N	4476	Eldon® Wave Desk Accessories	Pete Takahito	57699	-72.23	2.08	5.33	Ontario	Office Furnishings	0.43
\N	4477	BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	Kristen Hastings	58690	-1068.01	218.75	69.64	Ontario	Tables	0.77
\N	4478	Global Leather Executive Chair	Kristen Hastings	58784	2372.08	350.99	39	Ontario	Chairs & Chairmats	0.55
\N	4479	AT&T Black Trimline Phone, Model 210	Kristen Hastings	58784	-67.38	15.99	9.4	Ontario	Office Machines	0.49
\N	4480	Hon Valutask™ Swivel Chairs	Katrina Willman	59428	-728.18	100.98	45	Ontario	Chairs & Chairmats	0.69
\N	4481	Howard Miller Distant Time Traveler Alarm Clock	Katrina Willman	59428	-125.79	27.42	19.46	Ontario	Office Furnishings	0.44
\N	4482	Xerox 1979	Noel Staavos	1444	181.98	30.98	8.74	Ontario	Paper	0.4
\N	4483	Sanyo Counter Height Refrigerator with Crisper, 3.6 Cubic Foot, Stainless Steel/Black	Benjamin Venier	1921	541.47	328.14	91.05	Ontario	Appliances	0.57
\N	4484	Epson LQ-870 Dot Matrix Printer	Katherine Murray	1985	4407.44	535.64	14.7	Ontario	Office Machines	0.59
\N	4485	2160i	Alan Schoenberger	2978	947.31	200.99	4.2	Ontario	Telephones and Communication	0.59
\N	4486	StarTAC 7797	Mark Packer	7521	400.82	115.99	2.5	Ontario	Telephones and Communication	0.55
\N	4487	Zoom V.92 USB External Faxmodem	Eric Barreto	11206	-17.03	49.99	19.99	Ontario	Computer Peripherals	0.41
\N	4488	Motorola SB4200 Cable Modem	Karl Brown	13351	484.15	179.99	19.99	Ontario	Computer Peripherals	0.48
\N	4489	Fellowes 17-key keypad for PS/2 interface	Noel Staavos	13476	10.96	30.73	4	Ontario	Computer Peripherals	0.75
\N	4490	V3682	Benjamin Venier	15399	969.86	125.99	4.2	Ontario	Telephones and Communication	0.59
\N	4491	Hon Metal Bookcases, Putty	Benjamin Venier	15687	-892.79	70.98	46.74	Ontario	Bookcases	0.56
\N	4492	Logitech Cordless Navigator Duo	Karl Brown	23169	346.54	80.98	7.18	Ontario	Computer Peripherals	0.48
\N	4493	Newell 309	Ben Peterman	32292	-6.73	11.55	2.36	Ontario	Pens & Art Supplies	0.55
\N	4494	6120	Dave Poirier	32389	-257.41	65.99	8.8	Ontario	Telephones and Communication	0.58
\N	4495	Fiskars® Softgrip Scissors	Aaron Hawkins	37863	23.12	10.98	3.37	Ontario	Scissors, Rulers and Trimmers	0.57
\N	4496	Honeywell Enviracaire Portable HEPA Air Cleaner for 17' x 22' Room	Rick Duston	40866	-236.6	300.65	24.49	Ontario	Appliances	0.52
\N	4497	Adams Telephone Message Book W/Dividers/Space For Phone Numbers, 5 1/4"X8 1/2", 200/Messages	Alex Grayson	48263	37.5	5.68	1.21	Ontario	Paper	0.4
\N	4498	Gyration Ultra Professional Cordless Optical Suite	Dianna Wilson	49989	-559.78	300.97	7.18	Ontario	Computer Peripherals	0.48
\N	4499	Acme® Elite Stainless Steel Scissors	Erica Hernandez	54595	6.79	8.34	2.64	Ontario	Scissors, Rulers and Trimmers	0.59
\N	4500	Staples Pen Style Liquid Stix; Assorted (yellow, pink, green, blue, orange), 5/Pack	Christy Brittain	55392	40.2	6.47	1.22	Ontario	Pens & Art Supplies	0.4
\N	4501	Tenex Traditional Chairmats for Medium Pile Carpet, Standard Lip, 36" x 48"	David Kendrick	57249	365.25	60.65	12.23	Ontario	Office Furnishings	0.64
\N	4502	Okidata ML395C Color Dot Matrix Printer	Noel Staavos	1444	1759.34	1360.14	14.7	Ontario	Office Machines	0.59
\N	4503	Xerox 196	Paul Lucas	4965	-186.31	5.78	7.96	Ontario	Paper	0.36
\N	4504	Eldon Jumbo ProFile™ Portable File Boxes Graphite/Black	Raymond Fair	5639	-71.95	15.31	8.78	Ontario	Storage & Organization	0.57
\N	4505	Linden® 12" Wall Clock With Oak Frame	Debra Catini	7297	-0.74	33.98	19.99	Ontario	Office Furnishings	0.55
\N	4506	Canon P1-DHIII Palm Printing Calculator	Fred McMath	8513	-43.03	17.98	8.51	Ontario	Office Machines	0.4
\N	4507	Global High-Back Leather Tilter, Burgundy	Astrea Jones	10245	-896.94	122.99	70.2	Ontario	Chairs & Chairmats	0.74
\N	4508	Atlantic Metals Mobile 2-Shelf Bookcases, Custom Colors	Fred McMath	11011	1383.32	240.98	60.2	Ontario	Bookcases	0.56
\N	4509	Anderson Hickey Conga Table Tops & Accessories	Tracy Poddar	12320	11.65	15.23	27.75	Ontario	Tables	0.76
\N	4510	Seth Thomas 14" Putty-Colored Wall Clock	Troy Staebel	12326	-0.37	29.34	57.87	Ontario	Office Furnishings	0.54
\N	4511	Logitech Cordless Elite Duo	Raymond Fair	13056	1413.52	100.98	7.18	Ontario	Computer Peripherals	0.4
\N	4512	Fellowes 17-key keypad for PS/2 interface	Alejandro Savely	13125	56.39	30.73	4	Ontario	Computer Peripherals	0.75
\N	4513	Elite 5" Scissors	Noel Staavos	17410	-203.68	8.45	7.77	Ontario	Scissors, Rulers and Trimmers	0.55
\N	4514	Staples Colored Interoffice Envelopes	Troy Staebel	17953	-6.72	30.98	19.51	Ontario	Envelopes	0.36
\N	4515	Hewlett-Packard 2600DN Business Color Inkjet Printer	Chris Cortes	20711	-101.66	119.99	56.14	Ontario	Office Machines	0.39
\N	4516	PC Concepts 116 Key Quantum 3000 Keyboard	Troy Staebel	21606	-90.3	32.98	5.5	Ontario	Computer Peripherals	0.75
\N	4517	Imation 3.5" DS/HD IBM Formatted Diskettes, 10/Pack	Craig Yedwab	22820	-116.21	5.98	4.38	Ontario	Computer Peripherals	0.75
\N	4518	Xerox 231	Karl Brown	23169	-42.97	6.48	5.11	Ontario	Paper	0.37
\N	4519	Telescoping Adjustable Floor Lamp	Alan Shonely	23522	-44.86	19.99	11.17	Ontario	Office Furnishings	0.6
\N	4520	Canon PC-428 Personal Copier	Becky Martin	23616	2787.59	199.99	24.49	Ontario	Copiers and Fax	0.46
\N	4521	Quartet Omega® Colored Chalk, 12/Pack	Katrina Willman	25092	95.91	5.84	1	Ontario	Pens & Art Supplies	0.38
\N	4522	Newell 312	Tony Molinari	25157	52.74	5.84	1.2	Ontario	Pens & Art Supplies	0.55
\N	4523	Heavy-Duty E-Z-D® Binders	Stefania Perrino	25280	36.78	10.91	2.99	Ontario	Binders and Binder Accessories	0.38
\N	4524	Boston 16801 Nautilus™ Battery Pencil Sharpener	Karl Brown	25313	22.88	22.01	5.53	Ontario	Pens & Art Supplies	0.59
\N	4525	Peel-Off® China Markers	Amy Cox	25536	71.55	9.93	1.09	Ontario	Pens & Art Supplies	0.43
\N	4526	Portable Personal File Box	Hunter Lopez	25666	-37.85	12.21	4.81	Ontario	Storage & Organization	0.58
\N	4527	Luxo Professional Fluorescent Magnifier Lamp with Clamp-Mount Base	Dianna Arnett	28001	2593.14	209.84	21.21	Ontario	Office Furnishings	0.59
\N	4528	Imation Neon 80 Minute CD-R Spindle, 50/Pack	Giulietta Dortch	28999	420.05	33.98	1.99	Ontario	Computer Peripherals	0.45
\N	4529	Imation 3.5 IBM Formatted Diskettes, 10/Box	Dave Poirier	29666	-54.47	8.32	2.38	Ontario	Computer Peripherals	0.74
\N	4530	Wirebound Voice Message Log Book	Michael Kennedy	30599	33.47	4.76	0.88	Ontario	Paper	0.39
\N	4531	Riverside Furniture Stanwyck Manor Table Series	Eleni McCrary	31232	-715.11	286.85	61.76	Ontario	Tables	0.78
\N	4532	Imation Neon 80 Minute CD-R Spindle, 50/Pack	Eleni McCrary	31239	196.36	33.98	1.99	Ontario	Computer Peripherals	0.45
\N	4533	Space Solutions™ Industrial Galvanized Steel Shelving.	George Zrebassa	31392	-1326.29	78.8	35	Ontario	Storage & Organization	0.83
\N	4534	Anderson Hickey Conga Table Tops & Accessories	Dave Poirier	32389	11.65	15.23	27.75	Ontario	Tables	0.76
\N	4535	Companion Letter/Legal File, Black	Deanra Eno	33090	63.41	37.76	12.9	Ontario	Storage & Organization	0.57
\N	4536	Office Star - Task Chair with Contemporary Loop Arms	Sara Luxemburg	33987	-189.55	90.98	30	Ontario	Chairs & Chairmats	0.61
\N	4537	Xerox 1951	Pierre Wener	37731	172.94	30.98	9.18	Ontario	Paper	0.4
\N	4538	Newell 340	Tracy Poddar	38337	18.75	2.88	0.7	Ontario	Pens & Art Supplies	0.56
\N	4539	Lesro Sheffield Collection Coffee Table, End Table, Center Table, Corner Table	Eric Barreto	38369	54.6	71.37	69	Ontario	Tables	0.68
\N	4540	Belkin 105-Key Black Keyboard	Pierre Wener	38723	-68.93	19.98	4	Ontario	Computer Peripherals	0.68
\N	4541	Euro Pro Shark Stick Mini Vacuum	Dan Campbell	39266	-500.35	60.98	49	Ontario	Appliances	0.59
\N	4542	Bionaire Personal Warm Mist Humidifier/Vaporizer	Amy Cox	40103	72.55	46.89	5.1	Ontario	Appliances	0.46
\N	4543	Southworth 25% Cotton Linen-Finish Paper & Envelopes	Katherine Murray	40131	-119.31	9.06	9.86	Ontario	Paper	0.4
\N	4544	Tenex Personal Filing Tote With Secure Closure Lid, Black/Frost	Paul Knutson	41504	-30.2	15.51	5.8	Ontario	Storage & Organization	0.6
\N	4545	Avoid Verbal Orders Carbonless Minifold Book	Jennifer Patt	43588	-0.74	3.38	1.09	Ontario	Paper	0.39
\N	4546	Eldon® Gobal File Keepers	Michael Kennedy	43751	-130.96	15.14	4.53	Ontario	Storage & Organization	0.81
\N	4547	Imation Neon 80 Minute CD-R Spindle, 50/Pack	Raymond Fair	44448	331.27	33.98	1.99	Ontario	Computer Peripherals	0.45
\N	4548	Wilson Jones Hanging View Binder, White, 1"	Chuck Sachs	46531	-14.38	7.1	6.05	Ontario	Binders and Binder Accessories	0.39
\N	4549	AT&T 2230 Dual Handset Phone With Caller ID/Call Waiting	Chris Cortes	46534	5.55	99.99	19.99	Ontario	Office Machines	0.52
\N	4550	Avery Legal 4-Ring Binder	Denise Leinenbach	47459	56.88	20.98	1.49	Ontario	Binders and Binder Accessories	0.35
\N	4551	Canon F603 Scientific Calculator	Amy Cox	48455	-29.29	9.99	6.24	Ontario	Office Machines	0.36
\N	4552	Accessory6	Cathy Hwang	49056	-260.35	55.99	5	Ontario	Telephones and Communication	0.8
\N	4553	Adams Phone Message Book, 200 Message Capacity, 8 1/16” x 11”	Evan Henry	49190	-4.45	6.88	2	Ontario	Paper	0.39
\N	4554	Xerox 1937	Brian Stugart	51783	244.13	48.04	5.79	Ontario	Paper	0.37
\N	4555	Staples Battery-Operated Desktop Pencil Sharpener	Carlos Meador	52006	13.91	10.48	2.89	Ontario	Pens & Art Supplies	0.6
\N	4556	Office Star - Contemporary Task Swivel chair with 2-way adjustable arms, Plum	Erica Hernandez	54595	-421.76	130.98	30	Ontario	Chairs & Chairmats	0.78
\N	4557	LX 788	Bobby Elias	55202	1620.23	155.99	8.99	Ontario	Telephones and Communication	0.58
\N	4558	Hoover Upright Vacuum With Dirt Cup	Kean Thornton	55431	777.28	289.53	19.99	Ontario	Appliances	0.56
\N	4559	Global High-Back Leather Tilter, Burgundy	Alan Schoenberger	55713	-2426.55	122.99	70.2	Ontario	Chairs & Chairmats	0.74
\N	4560	Xerox 1885	Daniel Raglin	57570	204.08	48.04	7.23	Ontario	Paper	0.37
\N	4561	Quartet Alpha® White Chalk, 12/Pack	Brian Stugart	58372	4.34	2.21	1	Ontario	Pens & Art Supplies	0.38
\N	4562	Acco Four Pocket Poly Ring Binder with Label Holder, Smoke, 1"	Pierre Wener	59552	-71.05	7.45	6.28	Ontario	Binders and Binder Accessories	0.4
\N	4563	Bush Advantage Collection® Round Conference Table	Grant Donatelli	2272	-513.79	212.6	52.2	Ontario	Tables	0.64
\N	4564	Imation Neon Mac Format Diskettes, 10/Pack	Julie Prescott	6498	-40.76	8.12	2.83	Ontario	Computer Peripherals	0.77
\N	4565	Bretford CR8500 Series Meeting Room Furniture	Cari MacIntyre	16260	-969.05	400.98	42.52	Ontario	Tables	0.71
\N	4566	Jet-Pak Recycled Peel 'N' Seal Padded Mailers	Grant Donatelli	16359	137.86	35.89	14.72	Ontario	Envelopes	0.4
\N	4567	Eldon Spacemaker® Box, Quick-Snap Lid, Clear	Grant Donatelli	16359	-39.07	3.34	7.49	Ontario	Pens & Art Supplies	0.54
\N	4568	Global Troy™ Executive Leather Low-Back Tilter	Jason Fortune	21922	2383.42	500.98	26	Ontario	Chairs & Chairmats	0.6
\N	4569	DAX Solid Wood Frames	Jason Fortune	21922	10.58	9.77	6.02	Ontario	Office Furnishings	0.48
\N	4570	Newell 329	Jason Fortune	21922	8.07	3.28	0.98	Ontario	Pens & Art Supplies	0.59
\N	4571	Xerox 1949	Julie Prescott	23558	-10.19	4.98	4.72	Ontario	Paper	0.36
\N	4572	Hon iLevel™ Computer Training Table	Julie Prescott	23558	24.3	31.76	45.51	Ontario	Tables	0.65
\N	4573	Imation 3.5" DS-HD Macintosh Formatted Diskettes, 10/Pack	Jason Fortune	27205	-43.65	7.28	3.52	Ontario	Computer Peripherals	0.68
\N	4574	Avery 507	Candace McMahon	27461	51.23	2.88	0.5	Ontario	Labels	0.39
\N	4575	White Dual Perf Computer Printout Paper, 2700 Sheets, 1 Part, Heavyweight, 20 lbs., 14 7/8 x 11	Candace McMahon	27461	110.78	40.99	19.99	Ontario	Paper	0.36
\N	4576	Xerox 1885	Dave Brooks	29957	576.39	48.04	7.23	Ontario	Paper	0.37
\N	4577	Eldon® Image Series Desk Accessories, Burgundy	Jim Karlsson	30593	-90.07	4.18	6.92	Ontario	Office Furnishings	0.49
\N	4578	Panasonic KP-350BK Electric Pencil Sharpener with Auto Stop	Jim Karlsson	30593	176.63	34.58	8.99	Ontario	Pens & Art Supplies	0.56
\N	4579	Micro Innovations 104 Keyboard	Jim Karlsson	32871	-57.65	10.97	6.5	Ontario	Computer Peripherals	0.64
\N	4580	Panasonic KX-P1150 Dot Matrix Printer	Jim Karlsson	32871	179.05	145.45	17.85	Ontario	Office Machines	0.56
\N	4581	Xerox 1893	Cari MacIntyre	35878	48.88	40.99	17.48	Ontario	Paper	0.36
\N	4582	Model L Table or Wall-Mount Pencil Sharpener	Philip Fox	37924	-80.53	17.99	8.65	Ontario	Pens & Art Supplies	0.57
\N	4583	DAX Wood Document Frame.	Candace McMahon	38400	28.08	13.73	6.85	Ontario	Office Furnishings	0.54
\N	4584	Verbatim DVD-R, 4.7GB, Spindle, WE, Blank, Ink Jet/Thermal, 20/Spindle	Grant Carroll	38498	1070.18	115.79	1.99	Ontario	Computer Peripherals	0.49
\N	4585	Sanford Prismacolor® Professional Thick Lead Art Pencils, 36-Color Set	Grant Carroll	38498	-15.03	37.44	4.27	Ontario	Pens & Art Supplies	0.46
\N	4586	Keytronic Designer 104- Key Black Keyboard	Jason Fortune	39492	-564.06	40.48	19.99	Ontario	Computer Peripherals	0.77
\N	4587	Xerox 199	Jason Fortune	39492	-134.76	4.28	5.68	Ontario	Paper	0.4
\N	4588	Sanyo Counter Height Refrigerator with Crisper, 3.6 Cubic Foot, Stainless Steel/Black	Philip Fox	39686	-473.66	328.14	91.05	Ontario	Appliances	0.57
\N	4589	8860	Philip Fox	39686	791.9	65.99	5.26	Ontario	Telephones and Communication	0.56
\N	4590	Advantus 10-Drawer Portable Organizer, Chrome Metal Frame, Smoke Drawers	Dave Brooks	42693	554.22	59.76	9.71	Ontario	Storage & Organization	0.57
\N	4591	Logitech Cordless Access Keyboard	Julie Prescott	42850	141.28	29.99	5.5	Ontario	Computer Peripherals	0.51
\N	4592	Canon PC940 Copier	Julie Prescott	46050	-571.24	449.99	24.49	Ontario	Copiers and Fax	0.52
\N	4593	Fellowes Stor/Drawer® Steel Plus™ Storage Drawers	Julie Prescott	46050	44.58	95.43	19.99	Ontario	Storage & Organization	0.79
\N	4594	Chromcraft Bull-Nose Wood Oval Conference Tables & Bases	Grant Donatelli	46212	-1331.55	550.98	45.7	Ontario	Tables	0.71
\N	4595	Eldon Expressions Punched Metal & Wood Desk Accessories, Black & Cherry	Grant Carroll	49313	-22.88	9.38	4.93	Ontario	Office Furnishings	0.57
\N	4596	Accessory23	Grant Carroll	49313	574.16	35.99	1.25	Ontario	Telephones and Communication	0.36
\N	4597	Rediform Wirebound "Phone Memo" Message Book, 11 x 5-3/4	Grant Carroll	49477	-16.56	7.64	5.83	Ontario	Paper	0.36
\N	4598	Ibico Covers for Plastic or Wire Binding Elements	Philip Fox	49889	-50.21	11.5	7.19	Ontario	Binders and Binder Accessories	0.4
\N	4599	Premium Writing Pencils, Soft, #2 by Central Association for the Blind	Philip Fox	49889	-22.32	2.98	2.03	Ontario	Pens & Art Supplies	0.57
\N	4600	Rediform Wirebound "Phone Memo" Message Book, 11 x 5-3/4	Dave Brooks	52416	-16.95	7.64	5.83	Ontario	Paper	0.36
\N	4601	BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	Dave Brooks	52416	-528.65	218.75	69.64	Ontario	Tables	0.72
\N	4602	Harmony HEPA Quiet Air Purifiers	Candace McMahon	55140	-84.19	11.7	6.96	Ontario	Appliances	0.5
\N	4603	Xerox Blank Computer Paper	Frank Hawley	56550	166.85	19.98	5.77	Ontario	Paper	0.38
\N	4604	Imation 3.5", RTS 247544 3M 3.5 DSDD, 10/Pack	Grant Carroll	57447	-60.4	8.46	3.62	Ontario	Computer Peripherals	0.61
\N	4605	Logitech Internet Navigator Keyboard	Grant Carroll	57447	-113.6	30.98	6.5	Ontario	Computer Peripherals	0.79
\N	4606	Xerox 194	Ionia McGrath	1185	20.03	55.48	14.3	New Brunswick	Paper	0.37
\N	4607	Eldon Expressions Punched Metal & Wood Desk Accessories, Black & Cherry	Lori Olson	2149	21.21	9.38	4.93	New Brunswick	Office Furnishings	0.57
\N	4608	Tenex Contemporary Contur Chairmats for Low and Medium Pile Carpet, Computer, 39" x 49"	Quincy Jones	2466	553.7	107.53	5.81	New Brunswick	Office Furnishings	0.65
\N	4609	Adesso Programmable 142-Key Keyboard	Patrick Jones	3493	1027.63	152.48	6.5	New Brunswick	Computer Peripherals	0.74
\N	4610	Staples 4 Outlet Surge Protector	Patrick Jones	3588	-1.16	8.67	3.5	New Brunswick	Appliances	0.58
\N	4611	Keytronic French Keyboard	Patrick Jones	3588	-123.81	73.98	4	New Brunswick	Computer Peripherals	0.79
\N	4612	Advantus Employee of the Month Certificate Frame, 11 x 13-1/2	Patrick Jones	3588	226.72	30.93	3.92	New Brunswick	Office Furnishings	0.44
\N	4613	Lexmark Z54se Color Inkjet Printer	Patrick Jones	3588	326.56	90.97	14	New Brunswick	Office Machines	0.36
\N	4614	Xerox 1927	Ionia McGrath	5957	-66.72	4.28	6.72	New Brunswick	Paper	0.4
\N	4615	Bush Mission Pointe Library	Ionia McGrath	5957	-258.8	150.98	66.27	New Brunswick	Bookcases	0.65
\N	4616	1726 Digital Answering Machine	Ionia McGrath	5957	-38.02	20.99	4.81	New Brunswick	Telephones and Communication	0.58
\N	4617	Xerox 1916	Ionia McGrath	6183	951.5	48.94	5.86	New Brunswick	Paper	0.35
\N	4618	Acme® Box Cutter Scissors	Nathan Mautz	6402	-22.18	10.23	4.68	New Brunswick	Scissors, Rulers and Trimmers	0.59
\N	4619	Wilson Jones Impact Binders	Patrick Jones	6720	-93.71	5.18	5.74	New Brunswick	Binders and Binder Accessories	0.36
\N	4620	O'Sullivan Living Dimensions 2-Shelf Bookcases	Patrick Jones	6720	-1393.69	120.98	58.64	New Brunswick	Bookcases	0.75
\N	4621	Avery 48	Patrick Jones	6720	17.63	6.3	0.5	New Brunswick	Labels	0.39
\N	4622	Executive Impressions 13" Chairman Wall Clock	Nathan Mautz	6785	80.32	25.38	8.99	New Brunswick	Office Furnishings	0.5
\N	4623	Accessory35	Karen Seio	8295	158.18	35.99	1.1	New Brunswick	Telephones and Communication	0.55
\N	4624	i2000	Karen Seio	8295	-295.43	125.99	2.5	New Brunswick	Telephones and Communication	0.6
\N	4625	Peel-Off® China Markers	Quincy Jones	8704	198.83	9.93	1.09	New Brunswick	Pens & Art Supplies	0.43
\N	4626	Quartet Alpha® White Chalk, 12/Pack	Quincy Jones	8704	5.48	2.21	1	New Brunswick	Pens & Art Supplies	0.38
\N	4627	Canon MP41DH Printing Calculator	Ken Lonsdale	8834	2872.88	150.98	13.99	New Brunswick	Office Machines	0.38
\N	4628	Wilson Jones Elliptical Ring 3 1/2" Capacity Binders, 800 sheets	Lori Olson	8933	640.84	42.8	2.99	New Brunswick	Binders and Binder Accessories	0.36
\N	4629	Seth Thomas 12" Clock w/ Goldtone Case	Lori Olson	8933	154.99	22.98	7.58	New Brunswick	Office Furnishings	0.51
\N	4630	Xerox 188	Ionia McGrath	9222	78.2	11.34	5.01	New Brunswick	Paper	0.36
\N	4631	Avery Reinforcements for Hole-Punch Pages	Patrick Gardner	10243	-44.08	1.98	4.77	New Brunswick	Binders and Binder Accessories	0.4
\N	4632	Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back	Karen Seio	10502	1523.46	243.98	43.32	New Brunswick	Chairs & Chairmats	0.55
\N	4633	Executive Impressions 13" Chairman Wall Clock	Karen Seio	10502	182.72	25.38	8.99	New Brunswick	Office Furnishings	0.5
\N	4634	Eldon Regeneration Recycled Desk Accessories, Smoke	Quincy Jones	10886	-112.92	1.74	4.08	New Brunswick	Office Furnishings	0.53
\N	4635	Hewlett-Packard 2600DN Business Color Inkjet Printer	Quincy Jones	10886	432.98	119.99	56.14	New Brunswick	Office Machines	0.39
\N	4636	Holmes Replacement Filter for HEPA Air Cleaner, Very Large Room, HEPA Filter	Ionia McGrath	11047	-528.09	68.81	60	New Brunswick	Appliances	0.41
\N	4637	Chromcraft Bull-Nose Wood 48" x 96" Rectangular Conference Tables	Ionia McGrath	11047	2271.68	550.98	64.59	New Brunswick	Tables	0.66
\N	4638	Portable Personal File Box	Patrick Jones	12803	-21.15	12.21	4.81	New Brunswick	Storage & Organization	0.58
\N	4639	BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	Nona Balk	13767	-381.04	218.75	69.64	New Brunswick	Tables	0.72
\N	4640	OIC Thumb-Tacks	Nathan Mautz	14117	-1.5	1.14	0.7	New Brunswick	Rubber Bands	0.38
\N	4641	Staples Copy Paper (20Lb. and 84 Bright)	Quincy Jones	14976	-81.86	4.98	4.7	New Brunswick	Paper	0.38
\N	4642	Memorex 4.7GB DVD-RAM, 3/Pack	Lori Olson	14980	325.88	31.78	1.99	New Brunswick	Computer Peripherals	0.42
\N	4643	Hewlett-Packard Deskjet 6122 Color Inkjet Printer	Erin Mull	16133	872.13	200.97	15.59	New Brunswick	Office Machines	0.36
\N	4644	Hewlett-Packard cp1700 [D, PS] Series Color Inkjet Printers	Nathan Mautz	16134	10521.33	500.98	28.14	New Brunswick	Office Machines	0.38
\N	4645	Xerox 1949	Nona Balk	16258	-6.78	4.98	4.72	New Brunswick	Paper	0.36
\N	4646	SANFORD Major Accent™ Highlighters	Nona Balk	16258	45.31	7.08	2.35	New Brunswick	Pens & Art Supplies	0.47
\N	4647	Aluminum Document Frame	John Lee	16289	96.95	12.22	2.85	New Brunswick	Office Furnishings	0.55
\N	4648	V70	Erin Mull	16993	-433.49	205.99	2.5	New Brunswick	Telephones and Communication	0.59
\N	4649	Maxell DVD-RAM Discs	John Lee	18945	168.54	16.48	1.99	New Brunswick	Computer Peripherals	0.42
\N	4650	Harmony HEPA Quiet Air Purifiers	Emily Phan	19975	-83.96	11.7	6.96	New Brunswick	Appliances	0.5
\N	4651	Staples 6 Outlet Surge	John Lee	20036	-31.55	11.97	4.98	New Brunswick	Appliances	0.58
\N	4652	Micro Innovations Micro 3000 Keyboard, Black	John Lee	20036	-25.23	26.31	5.89	New Brunswick	Computer Peripherals	0.75
\N	4653	V 3600 Series	Patrick Gardner	20964	-120.09	65.99	8.99	New Brunswick	Telephones and Communication	0.58
\N	4654	Fellowes PB300 Plastic Comb Binding Machine	Erin Mull	21121	9373.96	387.99	19.99	New Brunswick	Binders and Binder Accessories	0.38
\N	4655	Avery Printable Repositionable Plastic Tabs	Patrick Jones	21314	-20.39	8.6	6.19	New Brunswick	Binders and Binder Accessories	0.38
\N	4656	OIC Colored Binder Clips, Assorted Sizes	Patrick Jones	21314	13.24	3.58	1.63	New Brunswick	Rubber Bands	0.36
\N	4657	Balt Solid Wood Rectangular Table	Patrick Jones	21314	-973.3	105.49	41.64	New Brunswick	Tables	0.75
\N	4658	Global High-Back Leather Tilter, Burgundy	Nathan Mautz	21702	-1461.65	122.99	70.2	New Brunswick	Chairs & Chairmats	0.74
\N	4659	Micro Innovations Media Access Pro Keyboard	Patrick Jones	21925	-339.95	77.51	4	New Brunswick	Computer Peripherals	0.76
\N	4660	Tyvek Interoffice Envelopes, 9 1/2" x 12 1/2", 100/Box	Ionia McGrath	22432	664.15	60.98	19.99	New Brunswick	Envelopes	0.38
\N	4661	Binney & Smith inkTank™ Erasable Desk Highlighter, Chisel Tip, Yellow, 12/Box	Patrick Jones	22819	-3.66	2.52	4.28	New Brunswick	Pens & Art Supplies	0.44
\N	4662	Canon imageCLASS 2200 Advanced Copier	Nathan Mautz	22917	-11769.17	3499.99	24.49	New Brunswick	Copiers and Fax	0.37
\N	4663	Acco PRESSTEX® Data Binder with Storage Hooks, Dark Blue, 9 1/2" X 11"	Lori Olson	23107	-39.12	5.38	7.57	New Brunswick	Binders and Binder Accessories	0.36
\N	4664	Hoover WindTunnel™ Plus Canister Vacuum	Patrick Gardner	23556	3302.03	363.25	19.99	New Brunswick	Appliances	0.57
\N	4665	Fellowes Bankers Box™ Stor/Drawer® Steel Plus™	Emily Phan	23777	-67.54	31.98	6.72	New Brunswick	Storage & Organization	0.75
\N	4666	Tuff Stuff™ Recycled Round Ring Binders	Erin Mull	24098	46.31	4.82	1.49	New Brunswick	Binders and Binder Accessories	0.36
\N	4667	Rediform Wirebound "Phone Memo" Message Book, 11 x 5-3/4	Erin Mull	24098	-20.49	7.64	5.83	New Brunswick	Paper	0.36
\N	4668	LX 788	Erin Mull	24098	836.15	155.99	8.99	New Brunswick	Telephones and Communication	0.58
\N	4669	6340	Karen Seio	24227	424.64	85.99	2.79	New Brunswick	Telephones and Communication	0.58
\N	4670	Microsoft Natural Multimedia Keyboard	Ionia McGrath	24614	-52.92	50.98	6.5	New Brunswick	Computer Peripherals	0.73
\N	4671	Bevis Round Bullnose 29" High Table Top	Erin Mull	25637	50.95	259.71	66.67	New Brunswick	Tables	0.61
\N	4672	REDIFORM Incoming/Outgoing Call Register, 11" X 8 1/2", 100 Messages	Justin Deggeller	26695	163.42	8.34	1.43	New Brunswick	Paper	0.35
\N	4673	Xerox 1904	Nathan Mautz	27078	-40.76	6.48	5.86	New Brunswick	Paper	0.36
\N	4674	Dual Level, Single-Width Filing Carts	Karen Seio	29376	569.08	155.06	7.07	New Brunswick	Storage & Organization	0.59
\N	4675	Polycom ViewStation™ ISDN Videoconferencing Unit	Emily Phan	29766	27220.69	6783.02	24.49	New Brunswick	Office Machines	0.39
\N	4676	TimeportP7382	Emily Phan	29766	1623.7	205.99	8.99	New Brunswick	Telephones and Communication	0.56
\N	4677	8860	Ionia McGrath	30278	832.62	65.99	5.26	New Brunswick	Telephones and Communication	0.56
\N	4678	Peel-Off® China Markers	Nathan Mautz	30626	77.68	9.93	1.09	New Brunswick	Pens & Art Supplies	0.43
\N	4679	Boston 1730 StandUp Electric Pencil Sharpener	Emily Phan	30851	-52.14	21.38	8.99	New Brunswick	Pens & Art Supplies	0.59
\N	4680	5190	Nona Balk	31718	168.46	65.99	7.69	New Brunswick	Telephones and Communication	0.59
\N	4681	StarTAC Analog	Nona Balk	31718	-115.3	65.99	8.99	New Brunswick	Telephones and Communication	0.6
\N	4682	Regeneration Desk Collection	Patrick Jones	32070	-185.34	1.76	4.86	New Brunswick	Office Furnishings	0.41
\N	4683	Linden® 12" Wall Clock With Oak Frame	Nathan Mautz	34661	-175.47	33.98	19.99	New Brunswick	Office Furnishings	0.55
\N	4684	Snap-A-Way® Black Print Carbonless Ruled Speed Letter, Triplicate	Patrick Jones	34754	235.51	37.94	5.08	New Brunswick	Paper	0.38
\N	4685	Xerox 1993	Erin Mull	35392	-50.2	6.48	9.68	New Brunswick	Paper	0.36
\N	4686	Magna Visual Magnetic Picture Hangers	Nathan Mautz	36103	-28.85	4.82	5.72	New Brunswick	Office Furnishings	0.47
\N	4687	Accessory31	Nathan Mautz	36103	701.66	35.99	0.99	New Brunswick	Telephones and Communication	0.35
\N	4688	Astroparche® Fine Business Paper	Nathan Mautz	37157	-71.09	5.28	5.06	New Brunswick	Paper	0.37
\N	4689	Xerox 1981	Nathan Mautz	38176	-79.08	5.28	5.57	New Brunswick	Paper	0.4
\N	4690	Dixon Ticonderoga Core-Lock Colored Pencils	Nathan Mautz	38176	74.75	9.11	2.25	New Brunswick	Pens & Art Supplies	0.52
\N	4691	Important Message Pads, 50 4-1/4 x 5-1/2 Forms per Pad	Ionia McGrath	38531	11.96	4.2	2.26	New Brunswick	Paper	0.36
\N	4692	Avery Heavy-Duty EZD ™ Binder With Locking Rings	Patrick Jones	40354	12.55	5.58	2.99	New Brunswick	Binders and Binder Accessories	0.37
\N	4693	Bush Advantage Collection® Round Conference Table	Patrick Jones	40354	-93.16	212.6	52.2	New Brunswick	Tables	0.64
\N	4694	DAX Contemporary Wood Frame with Silver Metal Mat, Desktop, 11 x 14 Size	Erin Mull	40832	122.78	20.24	6.67	New Brunswick	Office Furnishings	0.49
\N	4695	Accessory36	Patrick Jones	41632	-238.16	55.99	5	New Brunswick	Telephones and Communication	0.83
\N	4696	Keytronic 105-Key Spanish Keyboard	Patrick Gardner	41825	286.01	73.98	4	New Brunswick	Computer Peripherals	0.77
\N	4697	Heavy-Duty E-Z-D® Binders	Emily Phan	42373	22.96	10.91	2.99	New Brunswick	Binders and Binder Accessories	0.38
\N	4698	Eldon® 200 Class™ Desk Accessories, Burgundy	Nona Balk	44423	-69.27	6.28	5.29	New Brunswick	Office Furnishings	0.43
\N	4699	688	Patrick Jones	45863	-653.49	195.99	4.2	New Brunswick	Telephones and Communication	0.6
\N	4700	Avery 493	Karen Seio	47078	34.1	4.91	0.5	New Brunswick	Labels	0.36
\N	4701	Adams Telephone Message Books, 5 1/4” x 11”	Karen Seio	47078	77.04	6.04	2.14	New Brunswick	Paper	0.38
\N	4702	Xerox 1989	Karen Seio	47078	-49.64	4.98	5.02	New Brunswick	Paper	0.38
\N	4703	Eldon® Wave Desk Accessories	Patrick Gardner	47747	-138.51	2.08	5.33	New Brunswick	Office Furnishings	0.43
\N	4704	Newell 312	Ionia McGrath	47810	-5.35	5.84	1.2	New Brunswick	Pens & Art Supplies	0.55
\N	4705	Xerox 1939	Patrick Jones	48896	106.93	18.97	9.54	New Brunswick	Paper	0.37
\N	4706	Boston School Pro Electric Pencil Sharpener, 1670	Ionia McGrath	49830	26.36	30.98	8.99	New Brunswick	Pens & Art Supplies	0.58
\N	4707	Boston 1730 StandUp Electric Pencil Sharpener	Justin Deggeller	52389	-57.16	21.38	8.99	New Brunswick	Pens & Art Supplies	0.59
\N	4708	Lexmark Z54se Color Inkjet Printer	Tony Sayre	52576	126.81	90.97	14	New Brunswick	Office Machines	0.36
\N	4709	3M Office Air Cleaner	Karen Seio	53605	105.69	25.98	5.37	New Brunswick	Appliances	0.5
\N	4710	Rush Hierlooms Collection 1" Thick Stackable Bookcases	Karen Seio	53605	886.35	170.98	35.89	New Brunswick	Bookcases	0.66
\N	4711	Eldon Econocleat® Chair Mats for Low Pile Carpets	Karen Seio	53605	-73.1	41.47	34.2	New Brunswick	Office Furnishings	0.73
\N	4712	Motorola SB4200 Cable Modem	Nathan Mautz	53891	812.38	179.99	19.99	New Brunswick	Computer Peripherals	0.48
\N	4713	Deflect-o RollaMat Studded, Beveled Mat for Medium Pile Carpeting	Nathan Mautz	53891	-237.6	92.23	39.61	New Brunswick	Office Furnishings	0.67
\N	4714	8890	Nathan Mautz	53891	553.36	115.99	5.92	New Brunswick	Telephones and Communication	0.58
\N	4715	Fellowes 8 Outlet Superior Workstation Surge Protector	Patrick Jones	55460	496.43	41.71	4.5	New Brunswick	Appliances	0.56
\N	4716	Wilson Jones 14 Line Acrylic Coated Pressboard Data Binders	Patrick Jones	55460	-10.45	5.34	2.99	New Brunswick	Binders and Binder Accessories	0.38
\N	4717	Avery 511	Erin Mull	55877	52.94	3.08	0.99	New Brunswick	Labels	0.37
\N	4718	Xerox 1920	Erin Mull	55877	-73.38	5.98	7.5	New Brunswick	Paper	0.4
\N	4719	Eldon® Expressions™ Wood and Plastic Desk Accessories, Oak	Tony Sayre	56647	-309.06	9.98	12.52	New Brunswick	Office Furnishings	0.57
\N	4720	Acco Pressboard Covers with Storage Hooks, 14 7/8" x 11", Light Blue	Tony Sayre	57475	-93.23	4.91	5.68	New Brunswick	Binders and Binder Accessories	0.36
\N	4721	GBC Pre-Punched Binding Paper, Plastic, White, 8-1/2" x 11"	Tony Sayre	57475	-145.33	15.99	13.18	New Brunswick	Binders and Binder Accessories	0.37
\N	4722	Wilson Jones® Four-Pocket Poly Binders	Tony Sayre	57475	-79.81	6.54	5.27	New Brunswick	Binders and Binder Accessories	0.36
\N	4723	Xerox 21	Tony Sayre	57475	-76.53	6.48	6.6	New Brunswick	Paper	0.37
\N	4724	Wilson Jones Turn Tabs Binder Tool for Ring Binders	Patrick Jones	57537	-29.69	4.82	5.24	New Brunswick	Binders and Binder Accessories	0.39
\N	4725	Gyration Ultra Cordless Optical Suite	Patrick Jones	57537	888.62	100.97	7.18	New Brunswick	Computer Peripherals	0.46
\N	4726	Unpadded Memo Slips	Patrick Jones	57537	-7.08	3.98	2.97	New Brunswick	Paper	0.35
\N	4727	Hoover Commercial Soft Guard Upright Vacuum And Disposable Filtration Bags	Patrick Jones	57698	-66.91	7.77	9.23	New Brunswick	Appliances	0.58
\N	4728	Hoover WindTunnel™ Plus Canister Vacuum	Patrick Jones	57698	1127.31	363.25	19.99	New Brunswick	Appliances	0.57
\N	4729	EcoTones® Memo Sheets	Patrick Jones	58241	38.63	4	1.3	New Brunswick	Paper	0.37
\N	4730	Martin-Yale Premier Letter Opener	Patrick Jones	58241	-95.3	12.88	4.59	New Brunswick	Scissors, Rulers and Trimmers	0.82
\N	4731	SC7868i	Keith Dawkins	96	1228.89	125.99	8.99	Manitoba	Telephones and Communication	0.55
\N	4732	Xerox 195	Joe Elijah	610	-29.21	6.68	5.41	Manitoba	Paper	0.37
\N	4733	Xerox 1928	Sheri Gordon	612	-166.29	5.28	6.26	Manitoba	Paper	0.4
\N	4734	6190	Sheri Gordon	612	881.68	65.99	2.5	Manitoba	Telephones and Communication	0.55
\N	4735	Executive Impressions 12" Wall Clock	Stefanie Holloman	1440	52.47	17.67	8.99	Manitoba	Office Furnishings	0.47
\N	4736	Mead 1st Gear 2" Zipper Binder, Asst. Colors	Ken Black	3749	140.15	12.97	1.49	Manitoba	Binders and Binder Accessories	0.35
\N	4737	Memorex 4.7GB DVD+RW, 3/Pack	Joe Elijah	4070	237.75	28.48	1.99	Manitoba	Computer Peripherals	0.4
\N	4738	PC Concepts 116 Key Quantum 3000 Keyboard	Lindsay Williams	4774	-125.99	32.98	5.5	Manitoba	Computer Peripherals	0.75
\N	4739	Deflect-o EconoMat Nonstudded, No Bevel Mat	Logan Currie	6947	-51.01	51.65	18.45	Manitoba	Office Furnishings	0.65
\N	4740	TI 30X Scientific Calculator	Keith Dawkins	6979	-1.44	11.99	5.99	Manitoba	Office Machines	0.36
\N	4741	Eldon Advantage® Foldable Chair Mats for Low Pile Carpets	Steve Chapman	7107	143.08	54.2	11.1	Manitoba	Office Furnishings	0.64
\N	4742	Snap-A-Way® Black Print Carbonless Ruled Speed Letter, Triplicate	Steve Chapman	7107	-21.23	37.94	5.08	Manitoba	Paper	0.38
\N	4743	Recycled Steel Personal File for Standard File Folders	Steve Chapman	7107	407.8	55.29	5.08	Manitoba	Storage & Organization	0.59
\N	4744	GBC Recycled Regency Composition Covers	Marc Crier	8288	407.12	59.78	10.29	Manitoba	Binders and Binder Accessories	0.39
\N	4745	Acco Perma® 2700 Stacking Storage Drawers	Ken Black	8678	27.12	29.74	6.64	Manitoba	Storage & Organization	0.7
\N	4746	Xerox 1954	Dave Brooks	10659	-92.07	5.28	5.61	Manitoba	Paper	0.4
\N	4747	V70	Deborah Brumfield	10695	1421.89	205.99	2.5	Manitoba	Telephones and Communication	0.59
\N	4748	Epson Stylus 1520 Color Inkjet Printer	Keith Dawkins	11719	-1044.92	500.97	69.3	Manitoba	Office Machines	0.37
\N	4749	Boston 1730 StandUp Electric Pencil Sharpener	Keith Dawkins	11719	-74.88	21.38	8.99	Manitoba	Pens & Art Supplies	0.59
\N	4750	SouthWestern Bell FA970 Digital Answering Machine with Time/Day Stamp	Keith Dawkins	11719	-56.05	28.99	8.59	Manitoba	Telephones and Communication	0.56
\N	4751	Hon 2090 “Pillow Soft” Series Mid Back Swivel/Tilt Chairs	Marc Crier	11908	-556.18	280.98	57	Manitoba	Chairs & Chairmats	0.78
\N	4752	Dixon Ticonderoga Core-Lock Colored Pencils, 48-Color Set	Scot Wooten	13765	180.88	36.55	13.89	Manitoba	Pens & Art Supplies	0.41
\N	4753	Executive Impressions 14" Contract Wall Clock	Keith Dawkins	14055	167.18	22.23	3.63	Manitoba	Office Furnishings	0.52
\N	4754	Gyration Ultra Professional Cordless Optical Suite	Deborah Brumfield	14342	3857.43	300.97	7.18	Manitoba	Computer Peripherals	0.48
\N	4755	Executive Impressions 13" Clairmont Wall Clock	Steve Chapman	14756	-25.38	19.23	6.15	Manitoba	Office Furnishings	0.44
\N	4756	Avery 493	Nicole Brennan	14785	39.69	4.91	0.5	Manitoba	Labels	0.36
\N	4757	Boston Model 1800 Electric Pencil Sharpener, Gray	Nicole Brennan	14785	146.51	28.15	6.17	Manitoba	Pens & Art Supplies	0.55
\N	4758	Avery Poly Binder Pockets	John Lee	14855	-150.9	3.58	5.47	Manitoba	Binders and Binder Accessories	0.37
\N	4759	Eldon Pizzaz™ Desk Accessories	John Lee	14855	-150.53	2.23	4.57	Manitoba	Office Furnishings	0.41
\N	4760	Bevis 36 x 72 Conference Tables	John Lee	14855	-168.48	124.49	51.94	Manitoba	Tables	0.63
\N	4761	Global High-Back Leather Tilter, Burgundy	Logan Currie	15045	-640.6	122.99	70.2	Manitoba	Chairs & Chairmats	0.74
\N	4762	V2397	John Lee	16289	2040.87	125.99	2.5	Manitoba	Telephones and Communication	0.58
\N	4763	Serrated Blade or Curved Handle Hand Letter Openers	Marc Crier	19621	-30.4	3.14	1.92	Manitoba	Scissors, Rulers and Trimmers	0.84
\N	4764	Iris Project Case	Marc Crier	19621	-43.26	7.98	6.5	Manitoba	Storage & Organization	0.59
\N	4765	Bush Mission Pointe Library	John Lee	20036	-533.44	150.98	66.27	Manitoba	Bookcases	0.65
\N	4766	T60	John Lee	20036	307.25	95.99	4.9	Manitoba	Telephones and Communication	0.56
\N	4767	Heavy-Duty E-Z-D® Binders	Denise Monton	20773	122.54	10.91	2.99	Manitoba	Binders and Binder Accessories	0.38
\N	4768	Hewlett Packard LaserJet 3310 Copier	Deborah Brumfield	20967	13340.26	599.99	24.49	Manitoba	Copiers and Fax	0.37
\N	4769	M3682	Deborah Brumfield	20967	-397.53	125.99	8.08	Manitoba	Telephones and Communication	0.57
\N	4770	Executive Impressions 13" Chairman Wall Clock	Keith Dawkins	21478	126.95	25.38	8.99	Manitoba	Office Furnishings	0.5
\N	4771	Xerox 1937	Keith Dawkins	21478	728.49	48.04	5.79	Manitoba	Paper	0.37
\N	4772	Executive Impressions 13-1/2" Indoor/Outdoor Wall Clock	Keith Dawkins	21633	69.63	18.7	8.99	Manitoba	Office Furnishings	0.47
\N	4773	GBC Durable Plastic Covers	Marc Crier	21696	-51.91	19.35	12.79	Manitoba	Binders and Binder Accessories	0.39
\N	4774	Memorex 4.7GB DVD+RW, 3/Pack	Denise Monton	22851	218.89	28.48	1.99	Manitoba	Computer Peripherals	0.4
\N	4775	Eldon® Wave Desk Accessories	Denise Monton	22851	-48.55	2.08	5.33	Manitoba	Office Furnishings	0.43
\N	4776	KF 788	Denise Monton	22851	233.56	45.99	4.99	Manitoba	Telephones and Communication	0.56
\N	4777	3M Polarizing Task Lamp with Clamp Arm, Light Gray	Keith Dawkins	23557	547.96	136.98	24.49	Manitoba	Office Furnishings	0.59
\N	4778	Xerox 1929	Steve Chapman	24577	20.09	22.84	5.47	Manitoba	Paper	0.39
\N	4779	O'Sullivan 3-Shelf Heavy-Duty Bookcases	Ken Black	24961	-205.29	58.14	36.61	Manitoba	Bookcases	0.61
\N	4780	Iceberg Mobile Mega Data/Printer Cart ®	Deborah Brumfield	24966	817.98	120.33	19.99	Manitoba	Storage & Organization	0.59
\N	4781	DAX Contemporary Wood Frame with Silver Metal Mat, Desktop, 11 x 14 Size	Deborah Brumfield	27363	98.34	20.24	6.67	Manitoba	Office Furnishings	0.49
\N	4782	Epson FX-980 Dot Matrix Printer	Marc Crier	29028	4722.77	400.97	14.7	Manitoba	Office Machines	0.59
\N	4783	Microsoft Internet Keyboard	Denise Monton	29156	-76.58	20.97	4	Manitoba	Computer Peripherals	0.77
\N	4784	Xerox 1905	Scot Wooten	29282	-26.44	6.48	9.54	Manitoba	Paper	0.37
\N	4785	Global Deluxe Office Fabric Chairs	Dave Brooks	29957	-824.91	95.98	58.2	Manitoba	Chairs & Chairmats	0.58
\N	4786	Lexmark Z25 Color Inkjet Printer	Marc Crier	30053	349.22	80.97	33.6	Manitoba	Office Machines	0.37
\N	4787	Fellowes Twister Kit, Gray/Clear, 3/pkg	Denise Monton	30081	-136.45	8.04	8.94	Manitoba	Binders and Binder Accessories	0.4
\N	4788	Avery® 3 1/2" Diskette Storage Pages, 10/Pack	Keith Dawkins	30214	-21.26	10.44	5.75	Manitoba	Binders and Binder Accessories	0.39
\N	4789	Premium Transparent Presentation Covers by GBC	Steve Chapman	30497	85.68	20.98	8.83	Manitoba	Binders and Binder Accessories	0.37
\N	4790	Xerox 1947	Steve Chapman	30497	-61.9	5.98	5.35	Manitoba	Paper	0.4
\N	4791	Imation Neon Mac Format Diskettes, 10/Pack	Marc Crier	30917	-45.6	8.12	2.83	Manitoba	Computer Peripherals	0.77
\N	4792	Soundgear TeleForum DX Desktop Conference Phone	Marc Crier	30917	-32.3	96.45	13.99	Manitoba	Office Machines	0.38
\N	4793	Xerox 4200 Series MultiUse Premium Copy Paper (20Lb. and 84 Bright)	Steve Chapman	31681	-93.78	5.28	5.66	Manitoba	Paper	0.4
\N	4794	Global Leather Highback Executive Chair with Pneumatic Height Adjustment, Black	Logan Currie	31777	1590.95	200.98	23.76	Manitoba	Chairs & Chairmats	0.58
\N	4795	Xerox 1881	Logan Currie	31777	1.85	12.28	6.47	Manitoba	Paper	0.38
\N	4796	Eldon Simplefile® Box Office®	John Lee	32710	-59.06	12.44	6.27	Manitoba	Storage & Organization	0.57
\N	4797	Accohide Poly Flexible Ring Binders	Keith Dawkins	33060	-11.04	3.74	4.69	Manitoba	Binders and Binder Accessories	0.35
\N	4798	Eldon Radial Chair Mat for Low to Medium Pile Carpets	Keith Dawkins	33254	159.25	39.98	9.2	Manitoba	Office Furnishings	0.65
\N	4799	Self-Adhesive Ring Binder Labels	John Lee	33605	-218.53	3.52	6.83	Manitoba	Binders and Binder Accessories	0.38
\N	4800	Xerox 1924	Marc Crier	34180	-4.9	5.78	8.09	Manitoba	Paper	0.36
\N	4801	Wilson Jones 14 Line Acrylic Coated Pressboard Data Binders	Joe Elijah	35137	7.3	5.34	2.99	Manitoba	Binders and Binder Accessories	0.38
\N	4802	Recycled Interoffice Envelopes with String and Button Closure, 10 x 13	Joe Elijah	35137	283.79	23.99	6.71	Manitoba	Envelopes	0.35
\N	4803	Avery 51	Marc Crier	36838	11.29	6.3	0.5	Manitoba	Labels	0.39
\N	4804	Tripp Lite Isotel 8 Ultra 8 Outlet Metal Surge	Steve Chapman	37252	408.73	70.97	3.5	Manitoba	Appliances	0.59
\N	4805	Imation 3.5 IBM Formatted Diskettes, 10/Box	Steve Chapman	37252	-31.2	8.32	2.38	Manitoba	Computer Peripherals	0.74
\N	4806	US Robotics 56K V.92 Internal PCI Faxmodem	Steve Chapman	37252	-37.19	49.99	19.99	Manitoba	Computer Peripherals	0.45
\N	4807	Riverside Palais Royal Lawyers Bookcase, Royale Cherry Finish	Steve Chapman	37252	7497.55	880.98	44.55	Manitoba	Bookcases	0.62
\N	4808	Situations Contoured Folding Chairs, 4/Set	Steve Chapman	38979	-1701.96	70.98	59.81	Manitoba	Chairs & Chairmats	0.6
\N	4809	Micro Innovations Micro Digital Wireless Keyboard and Mouse, Gray	Steve Chapman	38979	1021.07	82.99	5.5	Manitoba	Computer Peripherals	0.44
\N	4810	Avery Hi-Liter Comfort Grip Fluorescent Highlighter, Yellow Ink	Steve Chapman	38979	-16.63	1.95	1.63	Manitoba	Pens & Art Supplies	0.46
\N	4811	Electrix Fluorescent Magnifier Lamps & Weighted Base	Ken Black	39619	265.87	49.34	10.25	Manitoba	Office Furnishings	0.57
\N	4812	US Robotics 56K V.92 Internal PCI Faxmodem	John Lee	40101	33.77	49.99	19.99	Manitoba	Computer Peripherals	0.45
\N	4813	Bevis 36 x 72 Conference Tables	Marc Crier	41542	-194.83	124.49	51.94	Manitoba	Tables	0.63
\N	4814	Cardinal Slant-D® Ring Binder, Heavy Gauge Vinyl	Joe Elijah	42565	47.52	8.69	2.99	Manitoba	Binders and Binder Accessories	0.39
\N	4815	Xerox 1980	Steve Chapman	42823	-22.56	4.28	6.18	Manitoba	Paper	0.4
\N	4816	Hon Non-Folding Utility Tables	John Lee	43398	-193.97	159.31	60	Manitoba	Tables	0.55
\N	4817	Xerox 1923	John Lee	44002	-66.48	6.68	5.66	Manitoba	Paper	0.37
\N	4818	Portfile® Personal File Boxes	John Lee	44002	-52.33	17.7	9.47	Manitoba	Storage & Organization	0.59
\N	4819	Array® Memo Cubes	Cynthia Delaney	44196	7.5	5.18	2.04	Manitoba	Paper	0.36
\N	4820	Zebra Zazzle Fluorescent Highlighters	Keith Dawkins	44359	24.83	6.08	0.91	Manitoba	Pens & Art Supplies	0.51
\N	4821	Newell 351	Denise Monton	44871	-75.09	3.28	4.2	Manitoba	Pens & Art Supplies	0.56
\N	4822	Microsoft Natural Multimedia Keyboard	Marc Crier	46055	-5.6	50.98	6.5	Manitoba	Computer Peripherals	0.73
\N	4823	Avery 506	Keith Dawkins	46624	42.84	4.13	0.5	Manitoba	Labels	0.39
\N	4824	Xerox 1927	Keith Dawkins	46624	-50.6	4.28	6.72	Manitoba	Paper	0.4
\N	4825	Hon iLevel™ Computer Training Table	Ed Braxton	47079	-1179.39	31.76	45.51	Manitoba	Tables	0.65
\N	4826	Verbatim DVD-RAM, 9.4GB, Rewritable, Type 1, DS, DataLife Plus	Marc Crier	47494	659.6	45.19	1.99	Manitoba	Computer Peripherals	0.55
\N	4827	Xerox 1897	Marc Crier	47494	-28.14	4.98	6.07	Manitoba	Paper	0.36
\N	4828	Soundgear Copyboard Conference Phone, Optional Battery	Lindsay Williams	47622	3702	204.1	13.99	Manitoba	Office Machines	0.37
\N	4829	Accessory37	Lindsay Williams	47938	-113.05	20.99	2.5	Manitoba	Telephones and Communication	0.81
\N	4830	Hoover Commercial Soft Guard Upright Vacuum And Disposable Filtration Bags	John Lee	48032	-283.31	7.77	9.23	Manitoba	Appliances	0.58
\N	4831	Eldon® Gobal File Keepers	John Lee	48032	-104.43	15.14	4.53	Manitoba	Storage & Organization	0.81
\N	4832	Premium Writing Pencils, Soft, #2 by Central Association for the Blind	Ed Braxton	49062	-25.68	2.98	2.03	Manitoba	Pens & Art Supplies	0.57
\N	4833	Fellowes Personal Hanging Folder Files, Navy	Joe Elijah	49541	16.46	13.43	5.5	Manitoba	Storage & Organization	0.57
\N	4834	Bretford Rectangular Conference Table Tops	Keith Dawkins	49799	-593.15	376.13	85.63	Manitoba	Tables	0.74
\N	4835	T28 WORLD	Keith Dawkins	49799	-6.57	195.99	8.99	Manitoba	Telephones and Communication	0.6
\N	4836	Xerox 21	Ed Braxton	49828	-91.48	6.48	6.6	Manitoba	Paper	0.37
\N	4837	AT&T 2230 Dual Handset Phone With Caller ID/Call Waiting	Cynthia Delaney	50054	1370.26	99.99	19.99	Manitoba	Office Machines	0.52
\N	4838	Fellowes Bases and Tops For Staxonsteel®/High-Stak® Systems	Cynthia Delaney	50054	182.46	33.29	8.74	Manitoba	Storage & Organization	0.61
\N	4839	Storex DuraTech Recycled Plastic Frosted Binders	Marc Crier	50370	-67.6	4.24	5.41	Manitoba	Binders and Binder Accessories	0.35
\N	4840	Eldon® Image Series Desk Accessories, Burgundy	Scot Wooten	51009	-29.14	4.18	6.92	Manitoba	Office Furnishings	0.49
\N	4841	Plastic Binding Combs	Joe Elijah	55200	-56.91	15.15	10.13	Manitoba	Binders and Binder Accessories	0.38
\N	4842	ELITE Series	Joe Elijah	55200	-830.72	205.99	2.79	Manitoba	Telephones and Communication	0.58
\N	4843	Global High-Back Leather Tilter, Burgundy	Ed Braxton	55808	-382.98	122.99	70.2	Manitoba	Chairs & Chairmats	0.74
\N	4844	1726 Digital Answering Machine	Ed Braxton	55808	104.33	20.99	4.81	Manitoba	Telephones and Communication	0.58
\N	4845	IBM Active Response Keyboard, Black	Stefanie Holloman	55937	-146.2	39.98	7.12	Manitoba	Computer Peripherals	0.67
\N	4846	Bretford Rectangular Conference Table Tops	Stefanie Holloman	55937	53.79	376.13	85.63	Manitoba	Tables	0.74
\N	4847	Zoom V.92 V.44 PCI Internal Controllerless FaxModem	Ed Braxton	56161	118.97	39.99	10.25	Manitoba	Computer Peripherals	0.55
\N	4848	Acco 6 Outlet Guardian Premium Surge Suppressor	Ed Braxton	57477	119.12	14.56	3.5	Manitoba	Appliances	0.58
\N	4849	Accessory12	Ed Braxton	57477	1560.96	85.99	2.5	Manitoba	Telephones and Communication	0.35
\N	4850	Avery 481	Phillip Flathmann	59044	1.25	3.08	0.99	Manitoba	Labels	0.37
\N	4851	Wilson Jones “Snap” Scratch Pad Binder Tool for Ring Binders	Corey Catlett	59204	-66.24	5.8	5.59	Manitoba	Binders and Binder Accessories	0.4
\N	4852	#6 3/4 Gummed Flap White Envelopes	Ed Braxton	59969	205.7	9.9	1.39	Manitoba	Envelopes	0.37
\N	4853	Hanging Personal Folder File	Ed Braxton	59969	-87.11	15.7	11.25	Manitoba	Storage & Organization	0.6
\N	4854	i270	Valerie Takahito	166	-126.09	65.99	8.99	Manitoba	Telephones and Communication	0.55
\N	4855	Acme® 8" Straight Scissors	Penelope Sewall	197	33.22	12.98	3.14	Manitoba	Scissors, Rulers and Trimmers	0.6
\N	4856	Hoover WindTunnel™ Plus Canister Vacuum	Sean Braxton	231	-490.84	363.25	19.99	Manitoba	Appliances	0.57
\N	4857	Belkin 6 Outlet Metallic Surge Strip	Valerie Dominguez	487	-18.96	10.89	4.5	Manitoba	Appliances	0.59
\N	4858	Avery Poly Binder Pockets	Susan MacKendrick	710	-150.37	3.58	5.47	Manitoba	Binders and Binder Accessories	0.37
\N	4859	Deflect-o EconoMat Studded, No Bevel Mat for Low Pile Carpeting	Susan MacKendrick	710	89.03	41.32	8.66	Manitoba	Office Furnishings	0.76
\N	4860	Panasonic KX-P1150 Dot Matrix Printer	Susan MacKendrick	710	731.32	145.45	17.85	Manitoba	Office Machines	0.56
\N	4861	Rogers Handheld Barrel Pencil Sharpener	Thais Sissman	801	-47.41	2.74	3.5	Manitoba	Pens & Art Supplies	0.58
\N	4862	Tripp Lite Isotel 8 Ultra 8 Outlet Metal Surge	Valerie Dominguez	870	475.54	70.97	3.5	Manitoba	Appliances	0.59
\N	4863	Fellowes Bankers Box™ Stor/Drawer® Steel Plus™	Tanja Norvell	1253	-30.19	31.98	6.72	Manitoba	Storage & Organization	0.75
\N	4864	Belkin Premiere Surge Master II 8-outlet surge protector	Linda Southworth	1542	586.93	48.58	3.99	Manitoba	Appliances	0.56
\N	4865	Steel Personal Filing/Posting Tote	Linda Southworth	1542	27.2	35.51	6.31	Manitoba	Storage & Organization	0.58
\N	4866	i470	Michael Moore	2497	636.03	205.99	5.26	Manitoba	Telephones and Communication	0.56
\N	4867	While You Were Out Pads, 50 per Pad, 4 x 5 1/4, Green Cycle	Patrick Ryan	2630	37.14	4.73	1.52	Manitoba	Paper	0.36
\N	4868	Sanyo 2.5 Cubic Foot Mid-Size Office Refrigerators	Troy Blackwell	2657	2108.8	279.81	23.19	Manitoba	Appliances	0.59
\N	4869	i270	Troy Blackwell	2657	464.36	65.99	8.99	Manitoba	Telephones and Communication	0.55
\N	4870	Accessory8	Thais Sissman	2688	844.9	85.99	1.25	Manitoba	Telephones and Communication	0.39
\N	4871	Microsoft Internet Keyboard	Thais Sissman	2688	-98.46	20.97	6.5	Manitoba	Computer Peripherals	0.78
\N	4872	T39m	Thais Sissman	2688	61.24	155.99	3.9	Manitoba	Telephones and Communication	0.55
\N	4873	Panasonic KP-310 Heavy-Duty Electric Pencil Sharpener	Ross Baird	2816	220.04	21.98	2.87	Manitoba	Pens & Art Supplies	0.55
\N	4874	Artistic Insta-Plaque	Ross Baird	2818	192.39	15.68	3.73	Manitoba	Office Furnishings	0.46
\N	4875	GE 4 Foot Flourescent Tube, 40 Watt	Ross Baird	2818	44.71	14.98	8.99	Manitoba	Office Furnishings	0.39
\N	4876	Xerox 1892	Ross Baird	2818	-42.72	38.76	13.26	Manitoba	Paper	0.36
\N	4877	Xerox 21	Tracy Zic	3040	-31.54	6.48	6.6	Manitoba	Paper	0.37
\N	4878	Crayola Anti Dust Chalk, 12/Pack	Jack Garza	3108	-0.46	1.82	1	Manitoba	Pens & Art Supplies	0.4
\N	4879	LX 677	Gary McGarr	3459	218.87	110.99	8.99	Manitoba	Telephones and Communication	0.57
\N	4880	Global High-Back Leather Tilter, Burgundy	Mick Crebagga	3488	-1864.08	122.99	70.2	Manitoba	Chairs & Chairmats	0.74
\N	4881	Panasonic KP-310 Heavy-Duty Electric Pencil Sharpener	Mick Crebagga	3488	-0.31	21.98	2.87	Manitoba	Pens & Art Supplies	0.55
\N	4882	Catalog Binders with Expanding Posts	Roy Skaria	3492	524.88	67.28	19.99	Manitoba	Binders and Binder Accessories	0.4
\N	4883	O'Sullivan Elevations Bookcase, Cherry Finish	Roy Skaria	3492	-1195.12	130.98	54.74	Manitoba	Bookcases	0.69
\N	4884	Newell 318	Roy Skaria	3492	-6.34	2.78	1.25	Manitoba	Pens & Art Supplies	0.59
\N	4885	Newell 343	Roy Skaria	3553	-4.04	2.94	0.96	Manitoba	Pens & Art Supplies	0.58
\N	4886	Storex DuraTech Recycled Plastic Frosted Binders	Steven Ward	3622	-48.51	4.24	5.41	Manitoba	Binders and Binder Accessories	0.35
\N	4887	Hoover Portapower™ Portable Vacuum	Tanja Norvell	3810	-1845.66	4.48	49	Manitoba	Appliances	0.6
\N	4888	Avery 479	Tanja Norvell	3810	35.09	2.61	0.5	Manitoba	Labels	0.39
\N	4889	Boston 1730 StandUp Electric Pencil Sharpener	Tanja Norvell	4451	-65.21	21.38	8.99	Manitoba	Pens & Art Supplies	0.59
\N	4890	HP Office Paper (20Lb. and 87 Bright)	Ryan Crowe	4516	-113.45	6.68	6.93	Manitoba	Paper	0.37
\N	4891	Xerox 215	Roy Skaria	4578	-141.44	6.48	6.74	Manitoba	Paper	0.37
\N	4892	Holmes Replacement Filter for HEPA Air Cleaner, Large Room	Roy Skaria	4578	-250.53	14.81	13.32	Manitoba	Appliances	0.43
\N	4893	DAX Contemporary Wood Frame with Silver Metal Mat, Desktop, 11 x 14 Size	Roy Skaria	4578	86.33	20.24	6.67	Manitoba	Office Furnishings	0.49
\N	4894	Hewlett-Packard cp1700 [D, PS] Series Color Inkjet Printers	Steven Ward	4611	7176.12	500.98	28.14	Manitoba	Office Machines	0.38
\N	4895	Hon Every-Day® Chair Series Swivel Task Chairs	Irene Maddox	5281	624.36	120.98	30	Manitoba	Chairs & Chairmats	0.64
\N	4896	Luxo Professional Fluorescent Magnifier Lamp with Clamp-Mount Base	Irene Maddox	5281	1107.53	209.84	21.21	Manitoba	Office Furnishings	0.59
\N	4897	Ibico Covers for Plastic or Wire Binding Elements	Nick Radford	5635	-28.35	11.5	7.19	Manitoba	Binders and Binder Accessories	0.4
\N	4898	DAX Cubicle Frames - 8x10	Nick Radford	5635	-161.56	5.77	5.92	Manitoba	Office Furnishings	0.55
\N	4899	GBC DocuBind 300 Electric Binding Machine	Theresa Swint	5696	251.43	525.98	19.99	Manitoba	Binders and Binder Accessories	0.37
\N	4900	JM Magazine Binder	Theresa Swint	5696	190.53	16.51	2.99	Manitoba	Binders and Binder Accessories	0.37
\N	4901	Imation 3.5" IBM-Formatted Diskettes, 10/Pack	Theresa Swint	5696	-93.41	5.98	3.85	Manitoba	Computer Peripherals	0.68
\N	4902	Fellowes Personal Hanging Folder Files, Navy	Maurice Satty	5921	2.69	13.43	5.5	Manitoba	Storage & Organization	0.57
\N	4903	Quartet Omega® Colored Chalk, 12/Pack	Henry Goldwyn	6241	45	5.84	1	Manitoba	Pens & Art Supplies	0.38
\N	4904	StarTAC 8000	Henry Goldwyn	6241	1365.28	205.99	8.99	Manitoba	Telephones and Communication	0.6
\N	4905	Kleencut® Forged Office Shears by Acme United Corporation	Mick Crebagga	6406	-70.8	2.08	2.56	Manitoba	Scissors, Rulers and Trimmers	0.55
\N	4906	Riverside Palais Royal Lawyers Bookcase, Royale Cherry Finish	Roy Skaria	6625	5713.53	880.98	44.55	Manitoba	Bookcases	0.62
\N	4907	GBC VeloBinder Strips	Victor Price	6854	-2.39	7.68	6.16	Manitoba	Binders and Binder Accessories	0.35
\N	4908	G.E. Longer-Life Indoor Recessed Floodlight Bulbs	Victor Price	6854	2.39	6.64	4.95	Manitoba	Office Furnishings	0.37
\N	4909	T60	Maureen Grace	7335	1196.44	95.99	4.9	Manitoba	Telephones and Communication	0.56
\N	4910	Tyvek Interoffice Envelopes, 9 1/2" x 12 1/2", 100/Box	Eric Hoffmann	7457	624.64	60.98	19.99	Manitoba	Envelopes	0.38
\N	4911	Newell 309	Eric Hoffmann	7457	124.24	11.55	2.36	Manitoba	Pens & Art Supplies	0.55
\N	4912	Xerox 1910	Jill Stevenson	7653	597.31	48.04	5.09	Manitoba	Paper	0.37
\N	4913	GBC Standard Plastic Binding Systems Combs	Evan Bailliet	7783	-14.62	8.85	5.6	Manitoba	Binders and Binder Accessories	0.36
\N	4914	Bevis Round Bullnose 29" High Table Top	Meg Tillman	7905	183.9	259.71	66.67	Manitoba	Tables	0.61
\N	4915	Hon Deluxe Fabric Upholstered Stacking Chairs	Gary McGarr	8064	1069.61	243.98	62.94	Manitoba	Chairs & Chairmats	0.57
\N	4916	ACCOHIDE® 3-Ring Binder, Blue, 1"	Russell D'Ascenzo	8130	-47.23	4.13	5.04	Manitoba	Binders and Binder Accessories	0.38
\N	4917	Bell Sonecor JB700 Caller ID	Gary Hwang	8294	-90.84	7.99	5.03	Manitoba	Telephones and Communication	0.6
\N	4918	Sauder Forest Hills Library, Woodland Oak Finish	Meg Tillman	8384	-698.09	140.98	36.09	Manitoba	Bookcases	0.77
\N	4919	Peel & Seel® Recycled Catalog Envelopes, Brown	Joseph Airdo	8580	-3.95	11.58	6.97	Manitoba	Envelopes	0.35
\N	4920	Hoover Commercial Soft Guard Upright Vacuum And Disposable Filtration Bags	Joseph Airdo	8580	-215.57	7.77	9.23	Manitoba	Appliances	0.58
\N	4921	Hoover Portapower™ Portable Vacuum	Emily Ducich	8646	-327.65	4.48	49	Manitoba	Appliances	0.6
\N	4922	Global Leather Executive Chair	Emily Ducich	8646	4161.98	350.99	39	Manitoba	Chairs & Chairmats	0.55
\N	4923	Targus USB Numeric Keypad	Emily Ducich	8646	-127.11	40.98	6.5	Manitoba	Computer Peripherals	0.74
\N	4924	SAFCO PlanMaster Heigh-Adjustable Drafting Table Base, 43w x 30d x 30-37h, Black	Emily Ducich	8646	2154.07	349.45	60	Manitoba	Tables	\N
\N	4925	Avery 52	Stewart Visinsky	8993	86.78	3.69	0.5	Manitoba	Labels	0.38
\N	4926	SC-3160	Tanja Norvell	8996	-48.85	65.99	8.99	Manitoba	Telephones and Communication	0.59
\N	4927	Eureka The Boss® Cordless Rechargeable Stick Vac	Linda Southworth	8998	66.47	50.98	13.66	Manitoba	Appliances	0.58
\N	4928	Verbatim DVD-R, 3.95GB, SR, Mitsubishi Branded, Jewel	Linda Southworth	8998	49.82	22.24	1.99	Manitoba	Computer Peripherals	0.43
\N	4929	Fellowes Personal Hanging Folder Files, Navy	Linda Southworth	8998	-19.75	13.43	5.5	Manitoba	Storage & Organization	0.57
\N	4930	Adesso Programmable 142-Key Keyboard	Henry Goldwyn	9124	-0.84	152.48	6.5	Manitoba	Computer Peripherals	0.74
\N	4931	Xerox 1926	Henry Goldwyn	9124	-118.56	4.98	7.28	Manitoba	Paper	0.38
\N	4932	Bell Sonecor JB700 Caller ID	Steven Cartwright	9152	-129.69	7.99	5.03	Manitoba	Telephones and Communication	0.6
\N	4933	Global Stack Chair without Arms, Black	Steven Cartwright	9312	-179.17	25.98	14.36	Manitoba	Chairs & Chairmats	0.6
\N	4934	Serrated Blade or Curved Handle Hand Letter Openers	Sue Ann Reed	9700	-59.74	3.14	1.92	Manitoba	Scissors, Rulers and Trimmers	0.84
\N	4935	Maxell Pro 80 Minute CD-R, 10/Pack	Irene Maddox	9826	-7.3	17.48	1.99	Manitoba	Computer Peripherals	0.45
\N	4936	Hon 2090 “Pillow Soft” Series Mid Back Swivel/Tilt Chairs	Thais Sissman	9954	-381.16	280.98	57	Manitoba	Chairs & Chairmats	0.78
\N	4937	Xerox 1922	Thais Sissman	9954	-166.44	4.98	7.44	Manitoba	Paper	0.36
\N	4938	Fluorescent Highlighters by Dixon	Thais Sissman	9954	22.06	3.98	0.83	Manitoba	Pens & Art Supplies	0.51
\N	4939	Seth Thomas 8 1/2" Cubicle Clock	Sanjit Engle	10081	245	20.28	6.68	Manitoba	Office Furnishings	0.53
\N	4940	Tyvek® Side-Opening Peel & Seel® Expanding Envelopes	Katherine Ducich	10272	-50.43	90.48	19.99	Manitoba	Envelopes	0.4
\N	4941	Xerox 1991	Katherine Ducich	10272	76.43	22.84	8.18	Manitoba	Paper	0.39
\N	4942	T18	Victor Price	10530	-411.65	110.99	2.5	Manitoba	Telephones and Communication	0.57
\N	4943	Avery Printable Repositionable Plastic Tabs	Tanja Norvell	11270	-21.85	8.6	6.19	Manitoba	Binders and Binder Accessories	0.38
\N	4944	TOPS Money Receipt Book, Consecutively Numbered in Red,	Eric Hoffmann	11431	-6.71	8.01	2.87	Manitoba	Paper	0.4
\N	4945	Talkabout T8097	Eric Hoffmann	11431	-615.67	205.99	8.99	Manitoba	Telephones and Communication	0.58
\N	4946	Acme Galleria® Hot Forged Steel Scissors with Colored Handles	Mike Gockenbach	11815	-37.22	15.73	7.42	Manitoba	Scissors, Rulers and Trimmers	0.56
\N	4947	Xerox 1897	Tanja Norvell	12097	-30.84	4.98	6.07	Manitoba	Paper	0.36
\N	4948	Accessory4	Tanja Norvell	12097	-139.98	85.99	0.99	Manitoba	Telephones and Communication	0.85
\N	4949	Canon P1-DHIII Palm Printing Calculator	Tracy Zic	12196	25.14	17.98	8.51	Manitoba	Office Machines	0.4
\N	4950	Smead Adjustable Mobile File Trolley with Lockable Top	Tracy Zic	12196	2914.56	419.19	19.99	Manitoba	Storage & Organization	0.58
\N	4951	O'Sullivan Elevations Bookcase, Cherry Finish	Thais Sissman	12451	-372.82	130.98	54.74	Manitoba	Bookcases	0.69
\N	4952	Eldon® Gobal File Keepers	Thais Sissman	12451	-53.57	15.14	4.53	Manitoba	Storage & Organization	0.81
\N	4953	GBC VeloBinder Electric Binding Machine	Tom Zandusky	12483	607.5	120.98	9.07	Manitoba	Binders and Binder Accessories	0.35
\N	4954	Bush Westfield Collection Bookcases, Dark Cherry Finish, Fully Assembled	Tom Zandusky	12483	-701.91	100.98	57.38	Manitoba	Bookcases	0.78
\N	4955	Advantus 10-Drawer Portable Organizer, Chrome Metal Frame, Smoke Drawers	Tom Zandusky	12483	338.95	59.76	9.71	Manitoba	Storage & Organization	0.57
\N	4956	Belkin 105-Key Black Keyboard	Thais Sissman	12867	-57.95	19.98	4	Manitoba	Computer Peripherals	0.68
\N	4957	Accessory17	Sue Ann Reed	12903	-191.79	35.99	5	Manitoba	Telephones and Communication	0.82
\N	4958	Hewlett-Packard 4.7GB DVD+R Discs	Theresa Swint	13540	34.79	8.5	1.99	Manitoba	Computer Peripherals	0.49
\N	4959	Stockwell Push Pins	Theresa Swint	13540	-0.05	2.18	0.78	Manitoba	Rubber Bands	0.52
\N	4960	Recycled Eldon Regeneration Jumbo File	Theresa Swint	13540	-26.78	12.28	6.13	Manitoba	Storage & Organization	0.57
\N	4961	GBC Standard Plastic Binding Systems' Combs	Denny Joy	13762	-23.62	6.28	5.36	Manitoba	Binders and Binder Accessories	0.4
\N	4962	Security-Tint Envelopes	Denny Joy	13762	7.4	7.64	1.39	Manitoba	Envelopes	0.36
\N	4963	Avery 520	Denny Joy	13762	39.81	3.15	0.5	Manitoba	Labels	0.37
\N	4964	Zoom V.92 V.44 PCI Internal Controllerless FaxModem	Steven Ward	14336	-114.39	39.99	10.25	Manitoba	Computer Peripherals	0.55
\N	4965	Peel & Stick Add-On Corner Pockets	Henia Zydlo	14400	-166.55	2.16	6.05	Manitoba	Binders and Binder Accessories	0.37
\N	4966	Xerox 21	Henia Zydlo	14400	-99.08	6.48	6.6	Manitoba	Paper	0.37
\N	4967	BPI Conference Tables	Henia Zydlo	14400	-2110.56	146.05	80.2	Manitoba	Tables	0.71
\N	4968	Xerox Blank Computer Paper	Tracy Collins	14500	211.79	19.98	5.77	Manitoba	Paper	0.38
\N	4969	Panasonic KP-350BK Electric Pencil Sharpener with Auto Stop	Tracy Collins	14500	289.02	34.58	8.99	Manitoba	Pens & Art Supplies	0.56
\N	4970	Logitech Access Keyboard	Valerie Dominguez	14534	226.09	15.98	4	Manitoba	Computer Peripherals	0.37
\N	4971	T60	Michael Moore	14884	-301.68	95.99	4.9	Manitoba	Telephones and Communication	0.56
\N	4972	Howard Miller 16" Diameter Gallery Wall Clock	Natalie Webber	15075	622.89	63.94	14.48	Manitoba	Office Furnishings	0.46
\N	4973	Imation 3.5, DISKETTE 44766 HGHLD3.52HD/FM, 10/Pack	Natalie Webber	15075	-56.3	5.02	5.14	Manitoba	Computer Peripherals	0.79
\N	4974	StarTAC ST7868	Toby Knight	15234	268.01	125.99	8.99	Manitoba	Telephones and Communication	0.55
\N	4975	M3682	Toby Knight	15234	-34.73	125.99	8.08	Manitoba	Telephones and Communication	0.57
\N	4976	Adams Phone Message Book, Professional, 400 Message Capacity, 5 3/6” x 11”	Maria Zettner	15270	90.86	6.98	1.6	Manitoba	Paper	0.38
\N	4977	Fellowes Super Stor/Drawer® Files	Nick Radford	15296	1082.21	161.55	19.99	Manitoba	Storage & Organization	0.66
\N	4978	Memorex 4.7GB DVD-RAM, 3/Pack	Thea Hudgings	15335	240.06	31.78	1.99	Manitoba	Computer Peripherals	0.42
\N	4979	O'Sullivan 2-Shelf Heavy-Duty Bookcases	Natalie Webber	15712	-81.89	48.58	54.11	Manitoba	Bookcases	0.69
\N	4980	Panasonic KX-P1131 Dot Matrix Printer	Ross Baird	15906	-223.89	264.98	17.86	Manitoba	Office Machines	0.58
\N	4981	Avery Self-Adhesive Photo Pockets for Polaroid Photos	Maurice Satty	16005	-21.38	6.81	5.48	Manitoba	Binders and Binder Accessories	0.37
\N	4982	Prismacolor Color Pencil Set	Maria Zettner	16103	104.77	19.84	4.1	Manitoba	Pens & Art Supplies	0.44
\N	4983	Portfile® Personal File Boxes	Tanja Norvell	16225	-82.5	17.7	9.47	Manitoba	Storage & Organization	0.59
\N	4984	Array® Memo Cubes	Linda Southworth	16262	9.53	5.18	2.04	Manitoba	Paper	0.36
\N	4985	Letter Size Cart	Roy Skaria	16321	1871.26	142.86	19.99	Manitoba	Storage & Organization	0.56
\N	4986	Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back	Ryan Crowe	16679	846.23	243.98	43.32	Manitoba	Chairs & Chairmats	0.55
\N	4987	Xerox 1916	Natalie Webber	16775	1244.81	48.94	5.86	Manitoba	Paper	0.35
\N	4988	Acco Recycled 2" Capacity Laser Printer Hanging Data Binders	Sue Ann Reed	16834	14.2	14.45	7.17	Manitoba	Binders and Binder Accessories	0.38
\N	4989	Global Enterprise™ Series Seating Low-Back Swivel/Tilt Chairs	Jill Stevenson	16837	-307.96	258.98	54.31	Manitoba	Chairs & Chairmats	0.55
\N	4990	StarTAC 7760	Penelope Sewall	16866	538.49	65.99	3.99	Manitoba	Telephones and Communication	0.59
\N	4991	Xerox 1927	Gary Hwang	17058	-62.37	4.28	6.72	Manitoba	Paper	0.4
\N	4992	Newell 310	Roy Skaria	17508	11.28	1.76	0.7	Manitoba	Pens & Art Supplies	0.56
\N	4993	Fiskars® Softgrip Scissors	Nora Pelletier	18592	-15.5	10.98	3.37	Manitoba	Scissors, Rulers and Trimmers	0.57
\N	4994	Adams Phone Message Book, Professional, 400 Message Capacity, 5 3/6” x 11”	Matthew Clasen	18757	123.15	6.98	1.6	Manitoba	Paper	0.38
\N	4995	Xerox 1895	Thea Hudgings	18851	-204.81	5.98	10.39	Manitoba	Paper	0.4
\N	4996	Sanford Liquid Accent Highlighters	Gary Hwang	18853	55.21	6.68	1.5	Manitoba	Pens & Art Supplies	0.48
\N	4997	Global Stack Chair without Arms, Black	Nora Pelletier	18884	-70.43	25.98	14.36	Manitoba	Chairs & Chairmats	0.6
\N	4998	Canon PC940 Copier	Nora Pelletier	18884	3825.69	449.99	24.49	Manitoba	Copiers and Fax	0.52
\N	4999	Rediform Wirebound "Phone Memo" Message Book, 11 x 5-3/4	Denny Joy	19300	-22.36	7.64	5.83	Manitoba	Paper	0.36
\N	5000	Vinyl Sectional Post Binders	Valerie Takahito	19361	317.53	37.7	2.99	Manitoba	Binders and Binder Accessories	0.35
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.session (sid, sess, expire) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (username, email, cakeday, password, id) FROM stdin;
GandalfTea	contact@octavian.work	2023-01-04	$2a$06$1XcvglP07B8yBybn1if9pufihVWnElinBOH10z7UlkjzPzyufKtwG	1
demousername	demoemail@example.com	2023-02-23	$2a$06$kMhGrVTqI65afloJ2gJJeOQFBFi.AtVXcKcO5sL8sjYOYcfnXjWNm	83
demousername	420demoemail@example.com	2023-02-23	$2a$06$SUwZwEpu1vC.Cbz2Zf1T/utB10vrEut6qmyoLeYT2Qb5h9kJrzZDW	84
\.


--
-- Name: ds_frontend_ds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ds_frontend_ds_id_seq', 1, false);


--
-- Name: ds_metadata_dataset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ds_metadata_dataset_id_seq', 89, true);


--
-- Name: issues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.issues_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 90, true);


--
-- Name: contributors contributors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contributors
    ADD CONSTRAINT contributors_pkey PRIMARY KEY (user_id);


--
-- Name: ds_frontend ds_frontend_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ds_frontend
    ADD CONSTRAINT ds_frontend_pkey PRIMARY KEY (ds_id);


--
-- Name: ds_metadata ds_metadata_ds_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ds_metadata
    ADD CONSTRAINT ds_metadata_ds_name_key UNIQUE (ds_name);


--
-- Name: ds_metadata ds_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ds_metadata
    ADD CONSTRAINT ds_metadata_pkey PRIMARY KEY (ds_id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_session_expire" ON public.session USING btree (expire);


--
-- PostgreSQL database dump complete
--

