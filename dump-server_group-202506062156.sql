--
-- PostgreSQL database dump
--

-- Dumped from database version 15.7
-- Dumped by pg_dump version 15.3

-- Started on 2025-06-06 21:56:22

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3325 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16497)
-- Name: group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."group" (
    id bigint NOT NULL,
    name character varying NOT NULL,
    start_year integer NOT NULL,
    create_at information_schema.time_stamp DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."group" OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16496)
-- Name: group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."group" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3319 (class 0 OID 16497)
-- Dependencies: 215
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."group" (id, name, start_year, create_at) FROM stdin;
1	91ТП	2023	2025-06-06 21:30:23.03+03
2	92ТП	2023	2025-06-06 21:30:51.37+03
\.


--
-- TOC entry 3327 (class 0 OID 0)
-- Dependencies: 214
-- Name: group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.group_id_seq', 2, true);


--
-- TOC entry 3175 (class 2606 OID 16501)
-- Name: group group_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pk PRIMARY KEY (id);


--
-- TOC entry 3326 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE "group"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."group" TO group_db_admin;


-- Completed on 2025-06-06 21:56:22

--
-- PostgreSQL database dump complete
--

