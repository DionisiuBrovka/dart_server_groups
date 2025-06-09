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



GRANT ALL ON TABLE public."group" TO group_db_admin;
