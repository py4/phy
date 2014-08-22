--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: answers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE answers (
    id integer NOT NULL,
    question_id integer,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    choice_index integer,
    exam_answer_id integer
);


--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE answers_id_seq OWNED BY answers.id;


--
-- Name: choices; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE choices (
    id integer NOT NULL,
    exam_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    content character varying(255),
    question_id integer
);


--
-- Name: choices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE choices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: choices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE choices_id_seq OWNED BY choices.id;


--
-- Name: exam_answers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE exam_answers (
    id integer NOT NULL,
    exam_id integer,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    status boolean DEFAULT false,
    score integer,
    scores hstore
);


--
-- Name: exam_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE exam_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exam_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE exam_answers_id_seq OWNED BY exam_answers.id;


--
-- Name: exams; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE exams (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    special boolean DEFAULT false,
    subject hstore
);


--
-- Name: exams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE exams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE exams_id_seq OWNED BY exams.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE questions (
    id integer NOT NULL,
    exam_id integer,
    content character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    mask character varying(255)
);


--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE questions_id_seq OWNED BY questions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: task_statuses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE task_statuses (
    id integer NOT NULL,
    task_id integer,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    value boolean
);


--
-- Name: task_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE task_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: task_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE task_statuses_id_seq OWNED BY task_statuses.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    title character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_type integer DEFAULT 0,
    age integer,
    name character varying(255),
    surname character varying(255),
    username character varying(255),
    adviser_id integer,
    user_code character varying(255),
    status integer,
    adviser_message character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers ALTER COLUMN id SET DEFAULT nextval('answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY choices ALTER COLUMN id SET DEFAULT nextval('choices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY exam_answers ALTER COLUMN id SET DEFAULT nextval('exam_answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY exams ALTER COLUMN id SET DEFAULT nextval('exams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions ALTER COLUMN id SET DEFAULT nextval('questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY task_statuses ALTER COLUMN id SET DEFAULT nextval('task_statuses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: choices_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY choices
    ADD CONSTRAINT choices_pkey PRIMARY KEY (id);


--
-- Name: exam_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY exam_answers
    ADD CONSTRAINT exam_answers_pkey PRIMARY KEY (id);


--
-- Name: exams_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY exams
    ADD CONSTRAINT exams_pkey PRIMARY KEY (id);


--
-- Name: questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: task_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY task_statuses
    ADD CONSTRAINT task_statuses_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_answers_on_question_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_answers_on_question_id ON answers USING btree (question_id);


--
-- Name: index_answers_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_answers_on_user_id ON answers USING btree (user_id);


--
-- Name: index_choices_on_exam_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_choices_on_exam_id ON choices USING btree (exam_id);


--
-- Name: index_exam_answers_on_exam_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_exam_answers_on_exam_id ON exam_answers USING btree (exam_id);


--
-- Name: index_exam_answers_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_exam_answers_on_user_id ON exam_answers USING btree (user_id);


--
-- Name: index_exams_on_subject; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_exams_on_subject ON exams USING gist (subject);


--
-- Name: index_questions_on_exam_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_questions_on_exam_id ON questions USING btree (exam_id);


--
-- Name: index_task_statuses_on_task_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_task_statuses_on_task_id ON task_statuses USING btree (task_id);


--
-- Name: index_task_statuses_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_task_statuses_on_user_id ON task_statuses USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140619102257');

INSERT INTO schema_migrations (version) VALUES ('20140619102302');

INSERT INTO schema_migrations (version) VALUES ('20140619103027');

INSERT INTO schema_migrations (version) VALUES ('20140619104331');

INSERT INTO schema_migrations (version) VALUES ('20140619105012');

INSERT INTO schema_migrations (version) VALUES ('20140619105228');

INSERT INTO schema_migrations (version) VALUES ('20140619105249');

INSERT INTO schema_migrations (version) VALUES ('20140619105310');

INSERT INTO schema_migrations (version) VALUES ('20140619105328');

INSERT INTO schema_migrations (version) VALUES ('20140619110737');

INSERT INTO schema_migrations (version) VALUES ('20140621195547');

INSERT INTO schema_migrations (version) VALUES ('20140621210958');

INSERT INTO schema_migrations (version) VALUES ('20140624203651');

INSERT INTO schema_migrations (version) VALUES ('20140624203708');

INSERT INTO schema_migrations (version) VALUES ('20140624203732');

INSERT INTO schema_migrations (version) VALUES ('20140624203930');

INSERT INTO schema_migrations (version) VALUES ('20140624203945');

INSERT INTO schema_migrations (version) VALUES ('20140624204741');

INSERT INTO schema_migrations (version) VALUES ('20140624204848');

INSERT INTO schema_migrations (version) VALUES ('20140624204916');

INSERT INTO schema_migrations (version) VALUES ('20140624205739');

INSERT INTO schema_migrations (version) VALUES ('20140624214657');

INSERT INTO schema_migrations (version) VALUES ('20140624214905');

INSERT INTO schema_migrations (version) VALUES ('20140624214932');

INSERT INTO schema_migrations (version) VALUES ('20140624215810');

INSERT INTO schema_migrations (version) VALUES ('20140625080948');

INSERT INTO schema_migrations (version) VALUES ('20140625081149');

INSERT INTO schema_migrations (version) VALUES ('20140625081230');

INSERT INTO schema_migrations (version) VALUES ('20140625090012');

INSERT INTO schema_migrations (version) VALUES ('20140625090034');

INSERT INTO schema_migrations (version) VALUES ('20140625092135');

INSERT INTO schema_migrations (version) VALUES ('20140626222931');

INSERT INTO schema_migrations (version) VALUES ('20140812195422');

INSERT INTO schema_migrations (version) VALUES ('20140812195837');

INSERT INTO schema_migrations (version) VALUES ('20140812202744');

INSERT INTO schema_migrations (version) VALUES ('20140812211457');

INSERT INTO schema_migrations (version) VALUES ('20140822190409');
