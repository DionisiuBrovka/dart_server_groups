--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-06-10 14:48:05

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
-- TOC entry 854 (class 1247 OID 24944)
-- Name: work_size; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.work_size AS ENUM (
    'administration',
    'worker',
    'employee'
);


ALTER TYPE public.work_size OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 24965)
-- Name: groups_table; Type: TABLE; Schema: public; Owner: server_group_admin
--

CREATE TABLE public.groups_table (
    id bigint NOT NULL,
    group_name character varying NOT NULL,
    start_year integer NOT NULL,
    create_at information_schema.time_stamp DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.groups_table OWNER TO server_group_admin;

--
-- TOC entry 218 (class 1259 OID 24971)
-- Name: group_id_seq; Type: SEQUENCE; Schema: public; Owner: server_group_admin
--

ALTER TABLE public.groups_table ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 24972)
-- Name: students_table; Type: TABLE; Schema: public; Owner: server_group_admin
--

CREATE TABLE public.students_table (
    id bigint NOT NULL,
    first_name character varying NOT NULL,
    second_name character varying NOT NULL,
    third_name character varying NOT NULL,
    student_group bigint,
    birthday date NOT NULL
);


ALTER TABLE public.students_table OWNER TO server_group_admin;

--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN students_table.first_name; Type: COMMENT; Schema: public; Owner: server_group_admin
--

COMMENT ON COLUMN public.students_table.first_name IS 'Имя';


--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN students_table.second_name; Type: COMMENT; Schema: public; Owner: server_group_admin
--

COMMENT ON COLUMN public.students_table.second_name IS 'Фамилия';


--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN students_table.third_name; Type: COMMENT; Schema: public; Owner: server_group_admin
--

COMMENT ON COLUMN public.students_table.third_name IS 'Отчество';


--
-- TOC entry 220 (class 1259 OID 24977)
-- Name: students_table_id_seq; Type: SEQUENCE; Schema: public; Owner: server_group_admin
--

ALTER TABLE public.students_table ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.students_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 24978)
-- Name: work_type_table; Type: TABLE; Schema: public; Owner: server_group_admin
--

CREATE TABLE public.work_type_table (
    id bigint NOT NULL,
    work_name character varying NOT NULL,
    work_role public.work_size NOT NULL
);


ALTER TABLE public.work_type_table OWNER TO server_group_admin;

--
-- TOC entry 222 (class 1259 OID 24983)
-- Name: work_type_table_id_seq; Type: SEQUENCE; Schema: public; Owner: server_group_admin
--

ALTER TABLE public.work_type_table ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.work_type_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 24984)
-- Name: worker_to_work_type; Type: TABLE; Schema: public; Owner: server_group_admin
--

CREATE TABLE public.worker_to_work_type (
    worker_id bigint NOT NULL,
    work_type_id bigint NOT NULL
);


ALTER TABLE public.worker_to_work_type OWNER TO server_group_admin;

--
-- TOC entry 224 (class 1259 OID 24987)
-- Name: workers_table; Type: TABLE; Schema: public; Owner: server_group_admin
--

CREATE TABLE public.workers_table (
    id bigint NOT NULL,
    first_name character varying NOT NULL,
    second_name character varying NOT NULL,
    third_name character varying NOT NULL,
    birthday date NOT NULL
);


ALTER TABLE public.workers_table OWNER TO server_group_admin;

--
-- TOC entry 225 (class 1259 OID 24992)
-- Name: workers_table_id_seq; Type: SEQUENCE; Schema: public; Owner: server_group_admin
--

ALTER TABLE public.workers_table ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.workers_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4921 (class 0 OID 24965)
-- Dependencies: 217
-- Data for Name: groups_table; Type: TABLE DATA; Schema: public; Owner: server_group_admin
--



--
-- TOC entry 4923 (class 0 OID 24972)
-- Dependencies: 219
-- Data for Name: students_table; Type: TABLE DATA; Schema: public; Owner: server_group_admin
--



--
-- TOC entry 4925 (class 0 OID 24978)
-- Dependencies: 221
-- Data for Name: work_type_table; Type: TABLE DATA; Schema: public; Owner: server_group_admin
--



--
-- TOC entry 4927 (class 0 OID 24984)
-- Dependencies: 223
-- Data for Name: worker_to_work_type; Type: TABLE DATA; Schema: public; Owner: server_group_admin
--



--
-- TOC entry 4928 (class 0 OID 24987)
-- Dependencies: 224
-- Data for Name: workers_table; Type: TABLE DATA; Schema: public; Owner: server_group_admin
--



--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 218
-- Name: group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: server_group_admin
--

SELECT pg_catalog.setval('public.group_id_seq', 63, true);


--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 220
-- Name: students_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: server_group_admin
--

SELECT pg_catalog.setval('public.students_table_id_seq', 5, true);


--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 222
-- Name: work_type_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: server_group_admin
--

SELECT pg_catalog.setval('public.work_type_table_id_seq', 1, false);


--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 225
-- Name: workers_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: server_group_admin
--

SELECT pg_catalog.setval('public.workers_table_id_seq', 1, false);


--
-- TOC entry 4766 (class 2606 OID 24994)
-- Name: groups_table group_pk; Type: CONSTRAINT; Schema: public; Owner: server_group_admin
--

ALTER TABLE ONLY public.groups_table
    ADD CONSTRAINT group_pk PRIMARY KEY (id);


--
-- TOC entry 4768 (class 2606 OID 24996)
-- Name: students_table students_table_pk; Type: CONSTRAINT; Schema: public; Owner: server_group_admin
--

ALTER TABLE ONLY public.students_table
    ADD CONSTRAINT students_table_pk PRIMARY KEY (id);


--
-- TOC entry 4770 (class 2606 OID 24998)
-- Name: work_type_table work_type_table_pk; Type: CONSTRAINT; Schema: public; Owner: server_group_admin
--

ALTER TABLE ONLY public.work_type_table
    ADD CONSTRAINT work_type_table_pk PRIMARY KEY (id);


--
-- TOC entry 4772 (class 2606 OID 25000)
-- Name: workers_table workers_table_pk; Type: CONSTRAINT; Schema: public; Owner: server_group_admin
--

ALTER TABLE ONLY public.workers_table
    ADD CONSTRAINT workers_table_pk PRIMARY KEY (id);


--
-- TOC entry 4773 (class 2606 OID 25001)
-- Name: students_table students_table_groups_table_fk; Type: FK CONSTRAINT; Schema: public; Owner: server_group_admin
--

ALTER TABLE ONLY public.students_table
    ADD CONSTRAINT students_table_groups_table_fk FOREIGN KEY (student_group) REFERENCES public.groups_table(id);


--
-- TOC entry 4774 (class 2606 OID 25006)
-- Name: worker_to_work_type to_work_fk; Type: FK CONSTRAINT; Schema: public; Owner: server_group_admin
--

ALTER TABLE ONLY public.worker_to_work_type
    ADD CONSTRAINT to_work_fk FOREIGN KEY (work_type_id) REFERENCES public.work_type_table(id);


--
-- TOC entry 4775 (class 2606 OID 25011)
-- Name: worker_to_work_type to_worker_fk; Type: FK CONSTRAINT; Schema: public; Owner: server_group_admin
--

ALTER TABLE ONLY public.worker_to_work_type
    ADD CONSTRAINT to_worker_fk FOREIGN KEY (worker_id) REFERENCES public.workers_table(id);


--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO server_group_admin;


-- Completed on 2025-06-10 14:48:05

--
-- PostgreSQL database dump complete
--

