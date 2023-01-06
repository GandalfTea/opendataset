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
-- Name: ds_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ds_metadata (
    ds_id integer NOT NULL,
    ds_name character varying(150) NOT NULL,
    score integer DEFAULT 0,
    contribution smallint NOT NULL,
    owner integer NOT NULL,
    num_contributors integer DEFAULT 0,
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
-- Name: ds_metadata ds_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ds_metadata ALTER COLUMN ds_id SET DEFAULT nextval('public.ds_metadata_dataset_id_seq'::regclass);


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
-- Data for Name: ds_metadata; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ds_metadata (ds_id, ds_name, score, contribution, owner, num_contributors) FROM stdin;
1	hello	0	0	1	0
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (username, email, cakeday, password, id) FROM stdin;
GandalfTea	contact@octavian.work	2023-01-04	$2a$06$1XcvglP07B8yBybn1if9pufihVWnElinBOH10z7UlkjzPzyufKtwG	1
\.


--
-- Name: ds_metadata_dataset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ds_metadata_dataset_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: contributors contributors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contributors
    ADD CONSTRAINT contributors_pkey PRIMARY KEY (user_id);


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
-- PostgreSQL database dump complete
--

