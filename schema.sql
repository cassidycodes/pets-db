--
-- PostgreSQL database dump
--

-- Dumped from database version 15.6
-- Dumped by pg_dump version 15.6

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
-- Name: humans; Type: TABLE; Schema: public; Owner: cassidy
--

CREATE TABLE public.humans (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.humans OWNER TO cassidy;

--
-- Name: humans_id_seq; Type: SEQUENCE; Schema: public; Owner: cassidy
--

CREATE SEQUENCE public.humans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.humans_id_seq OWNER TO cassidy;

--
-- Name: humans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cassidy
--

ALTER SEQUENCE public.humans_id_seq OWNED BY public.humans.id;


--
-- Name: humans_pets; Type: TABLE; Schema: public; Owner: cassidy
--

CREATE TABLE public.humans_pets (
    human_id integer NOT NULL,
    pet_id integer NOT NULL
);


ALTER TABLE public.humans_pets OWNER TO cassidy;

--
-- Name: pets; Type: TABLE; Schema: public; Owner: cassidy
--

CREATE TABLE public.pets (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.pets OWNER TO cassidy;

--
-- Name: pets_id_seq; Type: SEQUENCE; Schema: public; Owner: cassidy
--

CREATE SEQUENCE public.pets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pets_id_seq OWNER TO cassidy;

--
-- Name: pets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cassidy
--

ALTER SEQUENCE public.pets_id_seq OWNED BY public.pets.id;


--
-- Name: pgbench_history; Type: TABLE; Schema: public; Owner: cassidy
--

CREATE TABLE public.pgbench_history (
    tid integer,
    bid integer,
    aid integer,
    delta integer,
    mtime timestamp without time zone,
    filler character(22)
);


ALTER TABLE public.pgbench_history OWNER TO cassidy;

--
-- Name: humans id; Type: DEFAULT; Schema: public; Owner: cassidy
--

ALTER TABLE ONLY public.humans ALTER COLUMN id SET DEFAULT nextval('public.humans_id_seq'::regclass);


--
-- Name: pets id; Type: DEFAULT; Schema: public; Owner: cassidy
--

ALTER TABLE ONLY public.pets ALTER COLUMN id SET DEFAULT nextval('public.pets_id_seq'::regclass);


--
-- Name: humans_pets humans_pets_pkey; Type: CONSTRAINT; Schema: public; Owner: cassidy
--

ALTER TABLE ONLY public.humans_pets
    ADD CONSTRAINT humans_pets_pkey PRIMARY KEY (human_id, pet_id);


--
-- Name: humans humans_pkey; Type: CONSTRAINT; Schema: public; Owner: cassidy
--

ALTER TABLE ONLY public.humans
    ADD CONSTRAINT humans_pkey PRIMARY KEY (id);


--
-- Name: pets pets_pkey; Type: CONSTRAINT; Schema: public; Owner: cassidy
--

ALTER TABLE ONLY public.pets
    ADD CONSTRAINT pets_pkey PRIMARY KEY (id);


--
-- Name: humans_pets_human_id_pet_id_idx; Type: INDEX; Schema: public; Owner: cassidy
--

CREATE INDEX humans_pets_human_id_pet_id_idx ON public.humans_pets USING btree (human_id, pet_id);


--
-- Name: humans_pets humans_pets_human_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cassidy
--

ALTER TABLE ONLY public.humans_pets
    ADD CONSTRAINT humans_pets_human_id_fkey FOREIGN KEY (human_id) REFERENCES public.humans(id);


--
-- Name: humans_pets humans_pets_pet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cassidy
--

ALTER TABLE ONLY public.humans_pets
    ADD CONSTRAINT humans_pets_pet_id_fkey FOREIGN KEY (pet_id) REFERENCES public.pets(id);


--
-- Name: pets; Type: ROW SECURITY; Schema: public; Owner: cassidy
--

ALTER TABLE public.pets ENABLE ROW LEVEL SECURITY;

--
-- Name: pets read_pets; Type: POLICY; Schema: public; Owner: cassidy
--

CREATE POLICY read_pets ON public.pets FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.humans_pets
  WHERE ((humans_pets.pet_id = pets.id) AND (humans_pets.human_id = 1)))));


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO policy_tester;


--
-- Name: TABLE humans; Type: ACL; Schema: public; Owner: cassidy
--

GRANT SELECT ON TABLE public.humans TO policy_tester;


--
-- Name: TABLE humans_pets; Type: ACL; Schema: public; Owner: cassidy
--

GRANT SELECT ON TABLE public.humans_pets TO policy_tester;


--
-- Name: TABLE pets; Type: ACL; Schema: public; Owner: cassidy
--

GRANT SELECT ON TABLE public.pets TO policy_tester;


--
-- PostgreSQL database dump complete
--

