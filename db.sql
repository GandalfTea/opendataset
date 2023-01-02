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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    uuid uuid NOT NULL,
    username character varying(50) NOT NULL,
    cakeday date,
    email character varying(100)
);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (uuid, username, cakeday, email) FROM stdin;
ef5ee1ff-bc8f-44cd-b4e5-4e32d64aaec1	GandalfTea	2001-07-09	contact@octavian.work
9035e483-8c7b-4c16-a204-4bd2fd119163	dipsticksafety	1987-02-25	ventus@gmail.com
d795becc-020b-45e0-98e4-e906969e8fcd	pioneer10	2005-01-19	pioneer10@gmail.com
8c8e003f-a4b4-4544-a160-bc478c938bbb	GandalfTea	2023-01-02	octavian.concept@gmail.com
6082e51e-67d5-41f6-b6e7-d59db8df0e96	spartacus991	2023-01-02	spartacus@spartacus.com
\.


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (uuid);


--
-- PostgreSQL database dump complete
--

