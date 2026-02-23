--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18 (Ubuntu 14.18-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.18 (Ubuntu 14.18-0ubuntu0.22.04.1)

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
-- Name: Logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Logs" (
    id integer NOT NULL,
    action character varying(255) NOT NULL,
    "table" character varying(255) NOT NULL,
    "userId" integer,
    "values" jsonb,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Logs" OWNER TO postgres;

--
-- Name: Logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Logs_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Logs_id_seq" OWNER TO postgres;

--
-- Name: Logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Logs_id_seq" OWNED BY public."Logs".id;


--
-- Name: ProductImages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProductImages" (
    id integer NOT NULL,
    "productId" integer NOT NULL,
    image character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."ProductImages" OWNER TO postgres;

--
-- Name: ProductImages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ProductImages_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ProductImages_id_seq" OWNER TO postgres;

--
-- Name: ProductImages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProductImages_id_seq" OWNED BY public."ProductImages".id;


--
-- Name: ages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ages (
    id integer NOT NULL,
    age character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.ages OWNER TO postgres;

--
-- Name: ages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ages_id_seq OWNER TO postgres;

--
-- Name: ages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ages_id_seq OWNED BY public.ages.id;


--
-- Name: banners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.banners (
    id integer NOT NULL,
    text character varying(255),
    link character varying(255) DEFAULT 0,
    image character varying(255) DEFAULT 0,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.banners OWNER TO postgres;

--
-- Name: banners_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.banners_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.banners_id_seq OWNER TO postgres;

--
-- Name: banners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.banners_id_seq OWNED BY public.banners.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255),
    address1 character varying(255),
    address2 character varying(255),
    city character varying(255),
    state character varying(255),
    phone character varying(255),
    website character varying(255),
    email character varying(255),
    zipcode character varying(255),
    country character varying(255),
    nature character varying(255),
    brand character varying(255),
    lookfor character varying(255),
    area character varying(255),
    size character varying(255),
    request character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: deliveries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deliveries (
    id integer NOT NULL,
    merchant_id integer NOT NULL,
    phone character varying(255) DEFAULT 0 NOT NULL,
    address character varying(255) DEFAULT 0 NOT NULL,
    status integer DEFAULT 0,
    price numeric(10,2) DEFAULT 0 NOT NULL,
    comment character varying(255) DEFAULT 0 NOT NULL,
    driver_id integer,
    is_reported boolean DEFAULT false NOT NULL,
    report_id integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    is_deleted boolean DEFAULT false,
    receiver_address character varying(255),
    image character varying(255),
    driver_comment character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.deliveries OWNER TO postgres;

--
-- Name: deliveries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deliveries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deliveries_id_seq OWNER TO postgres;

--
-- Name: deliveries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deliveries_id_seq OWNED BY public.deliveries.id;


--
-- Name: delivery_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_items (
    id integer NOT NULL,
    delivery_id integer NOT NULL,
    good_id integer,
    quantity integer DEFAULT 1 NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.delivery_items OWNER TO postgres;

--
-- Name: delivery_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.delivery_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.delivery_items_id_seq OWNER TO postgres;

--
-- Name: delivery_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.delivery_items_id_seq OWNED BY public.delivery_items.id;


--
-- Name: doctors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctors (
    id integer NOT NULL,
    prof character varying(255),
    name character varying(255) DEFAULT 0,
    image character varying(255) DEFAULT 0,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.doctors OWNER TO postgres;

--
-- Name: doctors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.doctors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.doctors_id_seq OWNER TO postgres;

--
-- Name: doctors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doctors_id_seq OWNED BY public.doctors.id;


--
-- Name: goods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goods (
    id integer NOT NULL,
    ware_id integer,
    merchant_id integer DEFAULT 0,
    stock integer DEFAULT 0,
    name character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.goods OWNER TO postgres;

--
-- Name: goods_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goods_id_seq OWNER TO postgres;

--
-- Name: goods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.goods_id_seq OWNED BY public.goods.id;


--
-- Name: infos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.infos (
    id integer NOT NULL,
    richtext character varying(255),
    doctor character varying(255) DEFAULT 0,
    image character varying(255) DEFAULT 0,
    audio character varying(255) DEFAULT 0,
    title character varying(255) DEFAULT 0,
    isactive character varying(255) DEFAULT 1,
    category character varying(255) DEFAULT 0,
    gender character varying(255) DEFAULT 0,
    age character varying(255) DEFAULT 0,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.infos OWNER TO postgres;

--
-- Name: infos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.infos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.infos_id_seq OWNER TO postgres;

--
-- Name: infos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.infos_id_seq OWNED BY public.infos.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    title character varying(255),
    body character varying(255),
    type integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    merchant_id integer,
    phone character varying(255) DEFAULT 0,
    address character varying(255) DEFAULT 0,
    status integer DEFAULT 0,
    driver_id integer DEFAULT 0,
    comment character varying(255) DEFAULT 0,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id integer NOT NULL,
    module character varying(255) NOT NULL,
    action character varying(255) NOT NULL,
    description character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_id_seq OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: privacies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.privacies (
    id integer NOT NULL,
    privacy character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.privacies OWNER TO postgres;

--
-- Name: privacies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.privacies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.privacies_id_seq OWNER TO postgres;

--
-- Name: privacies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.privacies_id_seq OWNED BY public.privacies.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(255),
    status integer DEFAULT 0,
    "catId" integer,
    description character varying(255),
    stock integer DEFAULT 0,
    image character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id integer NOT NULL,
    lastname character varying(255),
    firstname character varying(255) DEFAULT 0,
    email character varying(255) DEFAULT 0,
    role character varying(255) DEFAULT 'user'::character varying,
    phone integer DEFAULT 0,
    isactive character varying(255) DEFAULT 1,
    school character varying(255) DEFAULT 0,
    member_type character varying(255) DEFAULT 0,
    start_date character varying(255) DEFAULT 0,
    end_date character varying(255) DEFAULT 0,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profiles_id_seq OWNER TO postgres;

--
-- Name: profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profiles_id_seq OWNED BY public.profiles.id;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regions (
    id integer NOT NULL,
    name character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.regions OWNER TO postgres;

--
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regions_id_seq OWNER TO postgres;

--
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regions_id_seq OWNED BY public.regions.id;


--
-- Name: requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.requests (
    id integer NOT NULL,
    ware_id integer,
    merchant_id integer DEFAULT 0,
    stock integer DEFAULT 0,
    status integer DEFAULT 0,
    good_id integer DEFAULT 0,
    name character varying(255),
    type integer NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.requests OWNER TO postgres;

--
-- Name: requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.requests_id_seq OWNER TO postgres;

--
-- Name: requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.requests_id_seq OWNED BY public.requests.id;


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.statuses (
    id integer NOT NULL,
    status character varying(255),
    color character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.statuses OWNER TO postgres;

--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.statuses_id_seq OWNER TO postgres;

--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.statuses_id_seq OWNED BY public.statuses.id;


--
-- Name: summaries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.summaries (
    id integer NOT NULL,
    merchant_id integer,
    number_delivery integer,
    total numeric(10,2) DEFAULT 0 NOT NULL,
    driver numeric(10,2) DEFAULT 0 NOT NULL,
    account numeric(10,2) DEFAULT 0 NOT NULL,
    comment character varying(255) DEFAULT 0 NOT NULL,
    driver_id integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.summaries OWNER TO postgres;

--
-- Name: summaries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.summaries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.summaries_id_seq OWNER TO postgres;

--
-- Name: summaries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.summaries_id_seq OWNED BY public.summaries.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(255),
    password character varying(255),
    role_id integer,
    phone character varying(255),
    address character varying(255),
    "firstName" character varying(255),
    "lastName" character varying(255),
    status integer DEFAULT 1 NOT NULL,
    "registerationNumber" character varying(255),
    email character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    name character varying(255),
    account_number character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: wares; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wares (
    id integer NOT NULL,
    name character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.wares OWNER TO postgres;

--
-- Name: wares_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wares_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wares_id_seq OWNER TO postgres;

--
-- Name: wares_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wares_id_seq OWNED BY public.wares.id;


--
-- Name: words; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.words (
    id integer NOT NULL,
    ware_id character varying(255),
    merchant_id integer DEFAULT 0,
    stock integer DEFAULT 0,
    name character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.words OWNER TO postgres;

--
-- Name: words_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.words_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.words_id_seq OWNER TO postgres;

--
-- Name: words_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.words_id_seq OWNED BY public.words.id;


--
-- Name: Logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Logs" ALTER COLUMN id SET DEFAULT nextval('public."Logs_id_seq"'::regclass);


--
-- Name: ProductImages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductImages" ALTER COLUMN id SET DEFAULT nextval('public."ProductImages_id_seq"'::regclass);


--
-- Name: ages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ages ALTER COLUMN id SET DEFAULT nextval('public.ages_id_seq'::regclass);


--
-- Name: banners id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banners ALTER COLUMN id SET DEFAULT nextval('public.banners_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: deliveries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveries ALTER COLUMN id SET DEFAULT nextval('public.deliveries_id_seq'::regclass);


--
-- Name: delivery_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_items ALTER COLUMN id SET DEFAULT nextval('public.delivery_items_id_seq'::regclass);


--
-- Name: doctors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctors ALTER COLUMN id SET DEFAULT nextval('public.doctors_id_seq'::regclass);


--
-- Name: goods id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods ALTER COLUMN id SET DEFAULT nextval('public.goods_id_seq'::regclass);


--
-- Name: infos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infos ALTER COLUMN id SET DEFAULT nextval('public.infos_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: privacies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privacies ALTER COLUMN id SET DEFAULT nextval('public.privacies_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles ALTER COLUMN id SET DEFAULT nextval('public.profiles_id_seq'::regclass);


--
-- Name: regions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions ALTER COLUMN id SET DEFAULT nextval('public.regions_id_seq'::regclass);


--
-- Name: requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests ALTER COLUMN id SET DEFAULT nextval('public.requests_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statuses ALTER COLUMN id SET DEFAULT nextval('public.statuses_id_seq'::regclass);


--
-- Name: summaries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.summaries ALTER COLUMN id SET DEFAULT nextval('public.summaries_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: wares id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wares ALTER COLUMN id SET DEFAULT nextval('public.wares_id_seq'::regclass);


--
-- Name: words id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.words ALTER COLUMN id SET DEFAULT nextval('public.words_id_seq'::regclass);


--
-- Data for Name: Logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Logs" (id, action, "table", "userId", "values", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: ProductImages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ProductImages" (id, "productId", image, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: ages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ages (id, age, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: banners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.banners (id, text, link, image, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, address1, address2, city, state, phone, website, email, zipcode, country, nature, brand, lookfor, area, size, request, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: deliveries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deliveries (id, merchant_id, phone, address, status, price, comment, driver_id, is_reported, report_id, "createdAt", "updatedAt", is_deleted, receiver_address, image, driver_comment) FROM stdin;
6	2	99110000	test location	1	18600.00	0	\N	f	0	2025-06-16 07:51:30.646+00	2025-06-17 09:20:26.54+00	t	\N	\N	\N
7	2	99107092	Test. comment	1	6500.00	0	\N	f	0	2025-06-16 07:54:12.545+00	2025-06-17 09:20:26.54+00	t	\N	\N	\N
4976	2	80882898	Улаанбаатар, Баянгол 26-р хорооНарны Хороолол 7-р байр 2-р орц 10 давхарт 108тоот\n 	3	6500.00	0	6	f	0	2025-06-16 09:13:02.308+00	2025-06-18 11:31:14.42+00	f	\N	\N	\N
4991	2	85779007	Дархан-Уул, Дархан сум darkhan huuchin horoolol 13bag 32 bair 56t Дархан уул аймаг \nАлтангэрэл 85779007. 99379007\n	3	6500.00	0	7	f	0	2025-06-16 10:23:06.698+00	2025-06-18 08:42:47.293+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
4	2	99110000	test location	5	18600.00	0	4	f	0	2025-06-16 05:26:31.497+00	2025-06-17 06:04:25.424+00	f	\N	\N	\N
8	2	99107092	Test. comment	1	6500.00	0	\N	f	0	2025-06-16 08:08:43.476+00	2025-06-17 09:32:49.811+00	t	\N	\N	\N
9	2	99107092	Test. comment	1	6500.00	0	\N	f	0	2025-06-16 08:08:46.497+00	2025-06-17 09:32:49.811+00	t	\N	\N	\N
4982	2	99737510	Өмнөговь, Даланзадгад Дундсайхан 4а-20\n Ямар үнэтэй юм бэ 	3	6500.00	0	\N	f	0	2025-06-16 09:13:48.494+00	2025-06-18 17:28:08.264+00	f	\N	\N	\N
4992	2	95011008	Улаанбаатар, Сүхбаатар 11-р хорооцагдаагийн 64-54 тоот 	3	6500.00	0	4	f	0	2025-06-16 10:57:32.096+00	2025-06-19 04:48:05.1+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
4974	2	99100202	Улаанбаатар, Баянзүрх 42-р хорооБЗД Ахмадын хороолол 106 дугаар байр эсвэл 6 гэсэн байгаа 2орц 3давхар 17тоот Орцны код:3ба8ийг зэрэг дардаг хуучины код 99100202 	3	6500.00	0	9	f	0	2025-06-16 09:12:37.287+00	2025-06-18 17:27:38.321+00	f	\N	\N	\N
4990	2	99608520	Улаанбаатар, Баянгол Нарны хорооллын өндөр 25-р байр 21 давхар 2104 тоот 1#2501 90402277	3	6500.00	0	6	f	0	2025-06-16 10:15:00.704+00	2025-06-18 09:01:42.283+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
4981	2	99930405	Улаанбаатар, Хан-Уул 11-р хорооZaisan Astra villa 207-1 8 dawhar 41 toot Orts kodgv	3	6500.00	0	\N	f	0	2025-06-16 09:13:42.842+00	2025-06-22 05:37:50.719+00	f	\N	\N	\N
4977	2	99987074	Улаанбаатар, Хан-Уул 04-р хорооМөнххада хажууд Төгөлдөр апартмент А блок 2р орц 13 давхар 1309 тоот 	3	6500.00	0	\N	f	0	2025-06-16 09:13:13.124+00	2025-06-19 08:00:03.649+00	f	\N	\N	\N
4972	2	99679325	Улаанбаатар, Хан-Уул 15-р хорооHunnu2222 115 байр 18давхар 18С тоот  Орц код:##1061#	3	6500.00	0	\N	f	0	2025-06-16 09:10:37.507+00	2025-06-18 17:22:57.927+00	f	\N	\N	\N
4970	2	89371934	Улаанбаатар, Баянгол 19-р хороо64-р байр 8н давхар 56тоот 	3	6500.00	0	\N	f	0	2025-06-16 09:08:27.342+00	2025-06-18 17:21:48.529+00	f	\N	\N	\N
4973	2	99013325	Улаанбаатар, Баянгол, 7-р хороо27-р Байр 27-R Bair, Говь сауны урд 27р байр\n 	3	6500.00	0	\N	f	0	2025-06-16 09:12:08.608+00	2025-06-18 17:23:11.932+00	f	\N	\N	\N
4984	2	89028192	Улаанбаатар, Сонгинохайрхан 34-р хорооХилчин 58-р гудамж 14тоот 	3	6500.00	0	7	f	0	2025-06-16 09:14:02.614+00	2025-06-18 17:24:24.728+00	f	\N	\N	\N
4975	2	88028849	Орхон, Баян-Өндөр сум, Зэстerdeneted irhed uursduu ochij avna 88028849, erdeneted irhed uursduu ochij avna  erdenet yavah mashind hurgulne	3	6500.00	0	7	f	0	2025-06-16 09:12:52.167+00	2025-06-18 08:38:36.231+00	f	\N	\N	\N
2	2	99110000	test location	1	18600.00	0	\N	f	0	2025-06-15 09:07:17.966+00	2025-06-17 09:19:00.242+00	t	\N	\N	\N
4985	2	99109210	Улаанбаатар, Баянзүрх 26-р хорооУлаанбаатар, Баянзүрх, 26-р хороо asdfasdfasdfasf etst	1	6500.00	0	\N	f	0	2025-06-16 09:42:49.145+00	2025-06-18 09:37:35.779+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5909	15	99380036	SHD 35r horoo orbitiin 66 1g	1	1.00	1	\N	f	0	2025-07-23 03:01:38.036+00	2025-07-23 03:03:18.686+00	t	\N	\N	\N
4971	2	96641333	Сүхбаатар, Баруун-Урт сум Цэлмэг хотхон 2-р байрны 2 давхар 6 тоот\n Тэнгэр плаза дээрээс Сүхбаатар Баруун-Урт гэсэн унаанд тавиад өгөөрэй	3	6500.00	0	\N	f	0	2025-06-16 09:09:11.155+00	2025-06-18 17:20:54.763+00	f	\N	\N	\N
4988	2	96644224	Улаанбаатар, Хан-Уул 23-р хорооNuhteer deeshee ugsuud postoor garaad Й-1eer zuun tiishee ergeed urgeljilsen urt saaral bair bga. tanan urguu. Google map deer hiiwel garaad irne. orts yrtuntsiin zugeer zuun taldaa. 201 toot 1 ortstoi 	3	6500.00	0	\N	f	0	2025-06-16 10:14:06.634+00	2025-06-20 03:57:09.88+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
4989	2	80001275	Улаанбаатар, Баянзүрх 25-р хорооГангарын 170Б 1 орц 11 давхар 49 тоот \nорцны код 88884487 	3	12100.00	0	\N	f	0	2025-06-16 10:14:45.866+00	2025-06-22 05:39:17.257+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
4983	2	88117714	Улаанбаатар, Хан-Уул 18-р хорооХУД,  хүннү-2222,  116 байр,  1302 тоот,  88117714 	3	6500.00	0	\N	f	0	2025-06-16 09:13:52.729+00	2025-06-18 17:29:27.91+00	f	\N	\N	\N
4987	2	99747311	Улаанбаатар, Баянзүрх, 5-р хорооИнээмсэглэл хотхон , 77а байр 171 тоот 	3	6500.00	0	9	f	0	2025-06-16 09:49:17.714+00	2025-06-18 17:29:46.785+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
4986	2	99110000	test location	1	18600.00	0	\N	f	0	2025-06-16 09:42:49.413+00	2025-06-18 09:37:35.779+00	t	test location	\N	\N
4978	2	86082626	Улаанбаатар, Баянгол 01-р хорооТөмөр зам premium appartment 10р байр Б блок 9 давхар 901тоот hurgeltiin umnu zalgah 	3	6500.00	0	4	f	0	2025-06-16 09:13:18.115+00	2025-06-18 13:32:31.042+00	f	\N	\N	\N
4979	2	99003456	Улаанбаатар, Баянзүрх 14-р хорооЗүүн 4 зам Зүүнхүрээ хотхон 203-р байр 2-р орц 8 давхарт 73тоот\n\n 	3	6500.00	0	9	f	0	2025-06-16 09:13:23.476+00	2025-06-21 03:01:03.994+00	f	\N	\N	\N
4980	2	99003456	Улаанбаатар, Баянзүрх 14-р хорооЗүүн 4 зам Зүүнхүрээ хотхон 203-р байр 2-р орц 8 давхарт 73тоот\n\n 	3	6500.00	0	9	f	0	2025-06-16 09:13:29.466+00	2025-06-22 13:35:01.538+00	f	\N	\N	\N
5910	15	99380036	SHD 35r horoo orbitiin 66 1g	1	1.00	1	\N	f	0	2025-07-23 03:01:38.194+00	2025-07-23 03:03:18.686+00	t	\N	\N	\N
5	2	99110000	test location	5	18600.00	0	4	f	0	2025-06-16 05:28:25.112+00	2025-06-17 06:04:21.841+00	f	\N	\N	\N
3	2	99107092	Test. comment	1	6500.00	0	\N	f	0	2025-06-16 02:35:01.201+00	2025-06-17 09:19:00.242+00	t	\N	\N	\N
4966	2	99107092	Test. comment	1	6500.00	0	\N	f	0	2025-06-16 08:11:32.659+00	2025-06-17 09:32:49.811+00	t	\N	\N	\N
5015	2	88330770	Улаанбаатар, Багануур 8 байр 16 тоот утас 88330770 99021634 БАГАНУУР дүүргийн 8 байр 16 тоот	3	12100.00	0	\N	f	0	2025-06-17 01:11:01.942+00	2025-06-20 04:01:10.639+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5005	2	91717199	Увс, Зүүнхангай Сумын холбоонд хүлээж авна\n\n 	3	6500.00	0	7	f	0	2025-06-16 12:13:40.465+00	2025-06-19 01:18:20.103+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5004	2	88186333	Улаанбаатар, Хан-Уул 17-р хорооKhan hills Turbo tent delguurt  Uurka 91941177 Turbo tent dr ochood zalgaarai 	3	6500.00	0	\N	f	0	2025-06-16 12:11:08.08+00	2025-06-19 08:01:24.769+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
4999	2	88161236	Ховд, Жаргалант сум 521-30тоот Сайн баглаад 1 болгоод явуулаарай.	3	6500.00	0	7	f	0	2025-06-16 11:45:29.474+00	2025-06-19 02:50:17.188+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5000	2	88440018	Баянхонгор, Баянхонгор сум 5-5-533\n Баянхонгор аймаг Баянхонгор сум руу тавиад өгөөрэй. Баярлалаа 88440018 	3	6500.00	0	7	f	0	2025-06-16 11:45:53.742+00	2025-06-19 02:50:20.548+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5009	2	94546088	Төв, Батсүмбэр Crystal\n Батсүмбэр чиглэлийн автобусанд тавих	3	6500.00	0	7	f	0	2025-06-16 13:47:31.814+00	2025-06-19 02:50:23.692+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
4998	2	95263629	Өвөрхангай, Арвайхээр сум 13р баг  60 айлийн орон сууцны хажууд баялаг ундраа дэлгүүртэй 409-р байр в1-4  95263629 Буманчимэгт	3	6500.00	0	7	f	0	2025-06-16 11:43:23.742+00	2025-06-19 02:50:28.861+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5007	2	98033010	Өвөрхангай, Хужирт сум ӨВ. Хужирт сум 5-р баг  өв. хужирт сум 13-14 цагт автобус явдаг	3	12100.00	0	7	f	0	2025-06-16 12:29:10.326+00	2025-06-19 02:50:32.412+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5006	2	88019626	Улаанбаатар, Сүхбаатар 01-р хорооХүүхдийн ордны хойно, Central Park Office, 8 давхар Ирээд залгах	3	6500.00	0	7	f	0	2025-06-16 12:21:50.524+00	2025-06-19 13:40:56.678+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5008	2	88011368	Улаанбаатар, Хан-Уул 17-р хорооKing Tower, 126 bair, 1-r orts, 6 dawhar, 122 toot 	3	6500.00	0	\N	f	0	2025-06-16 13:42:17.789+00	2025-06-22 05:36:43.656+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5002	2	99830999	Улаанбаатар, Баянзүрх, 36-р хорооБаянмонгол хороолол 412 байр 3 орц 3 давхар 147 тоот, Орцны код #4123 	3	6500.00	0	\N	f	0	2025-06-16 11:48:55.336+00	2025-06-19 08:02:37.88+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
4993	2	80091076	Дорноговь, Замын-Үүд сум mandah naran 148a bairnii 2r orts neg davhart 44 toot \n 	3	6500.00	0	7	f	0	2025-06-16 11:00:35.071+00	2025-06-18 08:57:30.657+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5001	2	99372342	Дархан-Уул, Дархан сум Төмөр замын 16 р байр 89 тоот 	3	6500.00	0	7	f	0	2025-06-16 11:48:19.992+00	2025-06-18 08:43:29.139+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
4995	2	88822208	Улаанбаатар, Хан-Уул 18-р хорооGerlug Vista 58-6-204  99126012 irhes umnu zalgah	3	6500.00	0	\N	f	0	2025-06-16 11:32:18.431+00	2025-06-18 17:30:36.338+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5013	2	99055224	Улаанбаатар, Хан-Уул, 11-р хороо16-41, \nхөдөө аж ахуйн сургуулийн баруун талд алтанбогд 16-41 тоот\n\n худ 22р хороо зайсан хөдөө аж ахуйн сургуулийн баруун талд алтанбогд 16-41 тоот\n\n\n	3	6500.00	0	\N	f	0	2025-06-16 23:40:58.799+00	2025-06-22 05:38:22.842+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
4994	2	86609596	Улаанбаатар, Сүхбаатар 09-р хорооДөлгөөн нуур апартмэнт-4 653 байр 15 давхар 89 тоот орцны код#2580 	3	6500.00	0	\N	f	0	2025-06-16 11:22:56.391+00	2025-06-20 04:00:04.23+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5010	2	94949756	Увс, Улаангом Увс, Улаангом, 7-р баг  залуучуудын хороолол 7гудамж 717тоот 94949756 	3	6500.00	0	7	f	0	2025-06-16 13:50:24.578+00	2025-06-21 13:35:00.928+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
4997	2	90919529	Завхан, Улиастай сум Дэлгэрхийн 205\n 	3	6500.00	0	7	f	0	2025-06-16 11:37:26.997+00	2025-06-19 01:18:39.905+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5014	2	88686686	Улаанбаатар, Хан-Уул 18-р хорооХан Уул дүүрэг 18р хороо Токио Таун1 50Д байр 1002 тоот. Доор хаалганаас 1002 гэж залгана нэг орцтой. 88686686 	3	6500.00	0	\N	f	0	2025-06-16 23:57:52.978+00	2025-06-22 13:31:23.129+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5012	2	96553859	Улаанбаатар, Баянгол 30-р хорооУлаанбаатар, Баянгол, 30-р хороо ХД-36-113тоот 	3	6500.00	0	\N	f	0	2025-06-16 20:07:43.861+00	2025-06-22 05:39:39.929+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
4996	2	88115644	Улаанбаатар, Хан-Уул 03-р хорооМеханик инженерийн сургуулийн баруун талд 61-р байр, 5 давхар 39 тоот 	3	6500.00	0	6	f	0	2025-06-16 11:33:41.637+00	2025-06-18 11:02:11.677+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5011	2	95108222	Хөвсгөл, Их-Уул 3.16.5 Хөвсгөл аймаг ИХ-УУЛ сум автобуснд тавих	3	6500.00	0	7	f	0	2025-06-16 15:25:52.229+00	2025-06-19 02:50:11.524+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6322	31	90798989 	Бгд, 7 хороо, Гэмтлээс Модны 2 явах зам дагуу, 78р сургуулийн баруун талын 5 давхар шар 21 байр, 2-14 тоот 	3	1.00	й	18	f	0	2025-08-17 03:35:37.154+00	2025-08-18 03:48:34.661+00	f	\N	\N	\N
5017	2	86162204	Улаанбаатар, Баянгол 21-р хорооГэмтэлийн арын автобусны хажуугаар Сайн авто ламбардаар өгсөөд төгс хотхон 95в байр 503 тоот 	3	6500.00	0	\N	f	0	2025-06-17 01:40:46.331+00	2025-06-22 13:31:23.129+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5033	2	85270406	Улаанбаатар, Сонгинохайрхан 27-р хороо 21-р хороолол, Чухаг хотхон, 32Б байр, 8 давхар, 40 тоот Чингис Соосэ автобусны буудлын ар талын /цагаан, ягаантай/ байр	5	6500.00	0	\N	f	0	2025-06-17 04:33:47.025+00	2025-06-22 13:31:48.966+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
5018	2	99080958	Улаанбаатар, Баянгол 12-р хорооHayg BGD 12r khoroo 6-bichil horoolol 28-r surguuliin baruun tald 12,13 bairnii gold Talimaa emneleg deer urdaa CU tei 	3	6500.00	0	7	f	0	2025-06-17 01:47:40.727+00	2025-06-18 12:51:50.317+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5062	2	89680199	Баян-Өлгий, Өлгий сум 01-03\n Баян-Өлгий аймаг	3	6500.00	0	7	f	0	2025-06-17 09:05:10.296+00	2025-06-19 02:50:39.698+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5061	2	88017506	Сүхбаатар, Баруун-Урт сум Soyombo hothon 2toot Svhbaatar aimgiin tow soyombo hothon 	3	6500.00	0	9	f	0	2025-06-17 08:32:07.32+00	2025-06-21 03:01:03.994+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5032	2	99261482	Улаанбаатар, Хан-Уул 17-р хороо Modun town, 703 байр, 10006, орц код 1234# 	3	6500.00	0	6	f	0	2025-06-17 04:08:58.007+00	2025-06-19 14:13:39.832+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5023	2	88017506	Сүхбаатар, Баруун-Урт сум Soyombo hothon 2toot Svhbaatar aimgiin tow soyombo hothon 	3	6500.00	0	\N	f	0	2025-06-17 02:36:00.435+00	2025-06-22 13:35:15.93+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5035	2	85008615	Улаанбаатар, Баянгол 10-р хороо BGD 10r horoo 13r surguulin ard huhsuwd 504-2toot (#2345) 	3	6500.00	0	\N	f	0	2025-06-17 04:49:44.739+00	2025-06-22 13:35:31.463+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5024	2	88653945	Улаанбаатар, Хан-Уул 04-р хороо New garden hothon 1414r bair level e sport hoid haalgaar orno 	3	6500.00	0	6	f	0	2025-06-17 02:37:41.868+00	2025-06-18 10:27:06.378+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5028	2	99106052	Улаанбаатар, Баянзүрх 26-р хороо Crystal town 802-905 тоот, код #3025  	3	6500.00	0	\N	f	0	2025-06-17 03:40:37.763+00	2025-06-19 08:05:07.437+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6205	2	90509696	Улаанбаатар, Сүхбаатар 06-р хороо СБД, 6 хороо, Хүнсний 4 дэлгүүрийн хажууд 40 байр (улбар шар 9 давхар), 7 давхар, 21 тоот, код:21В. Утас: 90509696\n 	3	12100.00	0	\N	f	0	2025-08-09 03:20:38.198+00	2025-08-11 07:12:11.39+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5019	2	99293278	Дорноговь, Айраг Дорноговь, Айраг, Цагаан дөрвөлж Tomor zam 23-15toot 	3	6500.00	0	7	f	0	2025-06-17 01:48:15.661+00	2025-06-18 08:57:39.909+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5021	2	88008860	Улаанбаатар, Сүхбаатар 01-р хороо Blue sky tower 6 davhar 603 toot  	3	6500.00	0	7	f	0	2025-06-17 02:20:20.854+00	2025-06-19 11:47:10.068+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5029	2	99192705	Улаанбаатар, Баянгол 02-р хороо 25-р Эмийн сангийн Монос Эмийн сантай залгаа Монос Улаанбаатар ХХК-ийн Төв Оффис 	3	6500.00	0	7	f	0	2025-06-17 03:46:27.117+00	2025-06-19 02:50:36.12+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5016	2	88330770	Улаанбаатар, Багануур 8 байр 16 тоот утас 88330770 99021634 	3	6500.00	0	\N	f	0	2025-06-17 01:17:43.888+00	2025-06-22 05:39:39.929+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5037	2	88107997	Улаанбаатар, Сүхбаатар 03-р хороо Ub central recidence 27 bair A block 8 davhar 63 toot 	3	6500.00	0	7	f	0	2025-06-17 05:12:23.187+00	2025-06-19 12:34:20.332+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5110	2	88833771	Улаанбаатар, Баянзүрх 03-р хороо БЗД 3-р хороо Сансрын Имарт 6 давхарт UGG MONGOLIA\n 	3	6500.00	0	9	f	0	2025-06-18 10:16:15.629+00	2025-06-22 13:38:20.73+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5090	2	94582380	Оюут, Орхон, Баян-Өндөр сум, Оюут чимэг төвийн зүүн талд тесеро төв.\t	3	6500.00	a	7	f	0	2025-06-18 04:36:45.49+00	2025-06-18 10:36:12.708+00	f	\N	\N	\N
5027	2	88440018	Баянхонгор, Баянхонгор сум 5-5-533\n 	3	6500.00	0	7	f	0	2025-06-17 03:38:38.715+00	2025-06-19 02:51:06.594+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5020	2	89042134	Улаанбаатар, Баянгол 26-р хорооNarnii horoolol 19-r bair 2003 toot 20 davhar 	3	6500.00	0	6	f	0	2025-06-17 01:57:32.975+00	2025-06-19 12:12:09.347+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5025	2	95015588	Улаанбаатар, Хан-Уул, 15-р хорооГлобал таун , Глобал таун хотхон, А блок, 2 давхар 203 тоот 	3	6500.00	0	\N	f	0	2025-06-17 02:45:13.374+00	2025-06-19 08:04:37.373+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5034	2	88164209	Улаанбаатар, Сонгинохайрхан 13-р хороо Цамбагарав 8-р байр 2-р орц 44 тоот 	3	6500.00	0	7	f	0	2025-06-17 04:47:00.652+00	2025-06-18 14:37:05.013+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5031	2	99100202	БЗД Ахмадын хороолол 106 дугаар байр эсвэл 6 гэсэн байгаа 2орц 3давхар 17тоот Орцны код:3ба8ийг зэрэг дардаг хуучины код.	1	6500.00	a	\N	f	0	2025-06-17 04:02:12.163+00	2025-06-18 17:32:32.269+00	t	\N	\N	\N
5030	2	94565866	Ховд, Жаргалант сум Ховд, Жаргалант сум, Жаргалан 3:5 	3	6500.00	0	7	f	0	2025-06-17 03:47:53.313+00	2025-06-19 01:20:37.424+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5059	2	90441180	Улаанбаатар, Хан-Уул 16-р хороо элиганс хотхон 905 байр 12 давхар 94 тоот ll	3	6500.00	0	\N	f	0	2025-06-17 08:15:44.18+00	2025-06-19 08:07:45.43+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5058	2	99142896	Дархан-Уул, Дархан сум 4-12-16 99142896 Darkhan-uul aimag 4-12-16 toot	3	6500.00	0	7	f	0	2025-06-17 08:08:13.058+00	2025-06-19 01:19:18.644+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5057	2	99323035	Өвөрхангай, Арвайхээр сум 103 3 	3	6500.00	0	\N	f	0	2025-06-17 08:06:28.056+00	2025-06-22 13:49:06.303+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
5060	2	99406592	Дархан-Уул, Дархан сум Хуучин Дархан Микр 4р байр 99406592	3	6500.00	0	7	f	0	2025-06-17 08:16:01.284+00	2025-06-19 02:51:16.673+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5041	2	99207929	26-р хороо, Нарны хороолол, 26-р байр, 3 давхарт, 301 тоот, орцны код: 1826#.\t	3	6500.00	2	6	t	1	2025-06-17 05:49:02.437+00	2025-06-18 07:43:10.777+00	f	\N	\N	\N
5056	2	94289306	Улаанбаатар, Хан-Уул, 11-р хорооХан Оргил 62-р байр  Khan orgil 62-r bair, 1-р орц 4 давхар 12 тоот орц код: 39b 89153649 94289306	3	12100.00	0	\N	f	0	2025-06-17 08:02:58.705+00	2025-06-22 16:21:13.562+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5052	2	89447391	Булган, Хишиг-Өндөр 89447391 дугаарлуу ярих унаа олж тавина\n 	3	6500.00	0	\N	f	0	2025-06-17 07:53:22.074+00	2025-06-24 14:23:24.713+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5047	2	99306168	Хөвсгөл, Мөрөн сум Хөвсгөл, Мөрөн сум, Эрхэл 12.5.23бтоот 	3	6500.00	0	7	f	0	2025-06-17 07:07:14.574+00	2025-06-19 01:23:09.905+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6204	17	89119093	1р хороолол цамбагараваархойшоо эргээд 11р байр 12р орц 8э давхар 427 тоот 	3	43000.00	Очихдоо ярих. орцны код нь 427b	18	f	0	2025-08-09 02:59:38.689+00	2025-08-09 12:30:46.711+00	f	\N	\N	\N
5044	2	80008635	Улаанбаатар, Чингэлтэй 03-р хороо 24р сургуулийн зүүн хойд талын 51р байр,  	3	6500.00	0	\N	f	0	2025-06-17 06:23:23.337+00	2025-06-22 13:36:14.231+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5050	2	88019626	Улаанбаатар, Сүхбаатар 01-р хороо Хүүхдийн ордны хойно, Central Park Office, 8 давхар Ирээд залгах	3	6500.00	0	7	f	0	2025-06-17 07:47:19.529+00	2025-06-19 13:40:53.2+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5048	2	99362533	Орхон, Баян-Өндөр сум 11 дүгээр хороолол, 5 дугаар байр, 902 тоот.\n 	3	6500.00	0	7	f	0	2025-06-17 07:09:54.788+00	2025-06-19 02:51:10.319+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5055	2	88115644	Улаанбаатар, Хан-Уул 03-р хороо Механик инженерийн сургуулийн баруун талд 61-р байр, 5 давхар 39 тоот 	3	6500.00	0	6	f	0	2025-06-17 08:02:51.83+00	2025-06-19 11:57:32.234+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5051	2	90919529	Завхан, Улиастай сум Дэлгэрхийн 205\n 	3	6500.00	0	7	f	0	2025-06-17 07:51:08.293+00	2025-06-19 02:51:21.058+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5689	16	88100088	hud orgil hudaldaanii tuv urd skatavor bair 	3	26000.00	a	18	f	0	2025-07-10 04:33:12.395+00	2025-08-08 08:39:15.619+00	f	\N	\N	\N
6132	2	95110046	Улаанбаатар, Баянзүрх 08-р хороо БЗД Офицероос Улаанхуаран руу эргээд 7б байр 3 давхар 14 тоот.  	3	6500.00	0	9	f	0	2025-08-04 08:06:10.687+00	2025-08-12 07:58:28.357+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5043	2	88692009	Дорнод, Хэрлэн сум Дорнод, Хэрлэн сум, 11-р баг Дэлгүүртэй байрны хамгийн урд талын орц 2 давхар шатны өөдөөс харсан хаалга 	3	6500.00	0	\N	f	0	2025-06-17 06:21:11.689+00	2025-06-22 13:48:40.319+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5049	2	99553970	Дархан-Уул, Дархан сум Дархан-Уул, Дархан сум, 7-р баг 99553970  	3	6500.00	0	\N	f	0	2025-06-17 07:35:20.376+00	2025-06-22 13:48:40.319+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5054	2	94544544	Улаанбаатар, Баянзүрх 05-р хороо 115-р цэцэрлэгийн хойд талд байрлах Миний дэлгүүртэй Dream apartment хотхон, аркаар ороод баруун гар талд байрлах 94A байр, 9-р давхарт 906 тоот Яаралтай	3	6500.00	0	9	f	0	2025-06-17 08:01:09.356+00	2025-06-21 03:01:03.994+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6292	2	99471727	Улаанбаатар, Хан-Уул, 4-р хорооХанбогд хотхон 408Khanbogd residence 408, Han uul duureg 4 horoo, Khanbogd residence 408 bair 2 orts 8 davhar 97 toot \nOrtsnii kod:#040802# 99471762	1	6500.00	0	\N	f	0	2025-08-15 14:28:28.737+00	2025-08-15 14:28:28.752+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6390	33	99949405	5 шар 12 байр 39 тоот	3	35000.00	хоол өмд	18	f	0	2025-08-19 01:09:04.415+00	2025-08-19 09:57:04.688+00	f	\N	\N	\N
5038	2	99897597	Улаанбаатар, Чингэлтэй 11-р хороо Нуурын 13-218 тоот Чингэлтэй дүүргийн 11-р хороо нуурын 13-218 тоот 57-р сургуулийн автобусны арын буудлын хажууд анар авто сервисээр хойшоо эргээд зүүн гар талруугаа иргэнэ	3	6500.00	0	4	f	0	2025-06-17 05:23:29.526+00	2025-06-19 08:51:01.04+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5045	2	86915579	Говь-Алтай, Есөнбулаг Индэрт9 49 Говь Алтай 	3	6500.00	0	7	f	0	2025-06-17 06:40:18.432+00	2025-06-19 02:51:03.19+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5039	2	99180660	Улаанбаатар, Баянзүрх 26-р хороо Time tower 217-2-16-146 kod 1702#\nHaalgaa tailahgui bol 12 davhriin 126d uldeenuu Irehdee zalgana uu. 99180660	3	6500.00	0	\N	f	0	2025-06-17 05:39:38.378+00	2025-06-19 08:05:59.307+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5040	2	89361919	Улаанбаатар, Баянзүрх 41-р хороо Kino uildverees hoisho bolovsrol television ii bair ungruud dooro joy supermarket tai 21r bairni 5 davhar 14 toot 	3	6500.00	0	9	f	0	2025-06-17 05:45:02.987+00	2025-06-21 03:01:03.994+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5072	2	88049750	Улаанбаатар, Сүхбаатар, 5-р хорооГоломт хотхон Б Golomt Hothon B, 15 давхар, 60 тоот 	3	6500.00	0	7	f	0	2025-06-17 16:15:47.885+00	2025-06-19 06:04:10.929+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
4967	2	99110000	test location	1	18600.00	0	\N	f	0	2025-06-16 08:15:54.438+00	2025-06-17 09:32:49.811+00	t	\N	\N	\N
4968	2	99107092	Test. comment	1	6500.00	0	\N	f	0	2025-06-16 08:22:28.503+00	2025-06-17 09:32:49.811+00	t	\N	\N	\N
4969	2	99107092	est	1	6500.00	0	\N	f	0	2025-06-16 08:46:30.696+00	2025-06-17 09:32:49.811+00	t	\N	\N	\N
5108	2	99265094	Улаанбаатар, Баянгол 12-р хороо Улаанбаатар, Баянгол, 12-р хороо 6р бичил сайхан хувцас угаалга 6р бичил сайхан хувцас угаалга	3	6500.00	0	\N	f	0	2025-06-18 10:02:16.421+00	2025-06-22 13:46:11.177+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5075	2	85118733	Улаанбаатар, Сонгинохайрхан 22-р хороо Хилчин 31-14 	3	12100.00	0	7	f	0	2025-06-18 02:13:08.118+00	2025-06-23 07:05:21.373+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5074	2	98000327	Улаанбаатар, Баянгол 18-р хороо 4-р хороолол дэлгэмэл цэнхэр 43-р байр 1 давхар 132 тоот 	3	6500.00	0	7	f	0	2025-06-18 02:02:41.229+00	2025-06-18 14:37:31.275+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5076	2	88026048	Улаанбаатар, Хан-Уул 07-р хороо Encanto orange town 200b, F15-141, 0805# 	3	6500.00	0	\N	f	0	2025-06-18 02:25:42.119+00	2025-06-19 08:09:40.213+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5063	2	80002474	Улаанбаатар, Чингэлтэй 04-р хороо Max toweriin ard, barilgachdiin talbain zuun tald hiimori 1 hothon 4/6 bair 2r orts 8 davhart 44 toot  Ireheesee umnu utsaar zalgah 18:00 hoish hurtel baival sain bn 	3	12100.00	0	7	f	0	2025-06-17 09:06:01.206+00	2025-06-19 11:27:10.099+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5070	2	80120001	Улаанбаатар, Хан-Уул 06-р хороо Улаанбаатар, Хан-Уул, 6-р хороо ХУД цагдаагийн хоёрдугаар хэлтсийн зүүн талд, МТ колонкын баруун талд Гардан вилла хотхоны 186 дугаар байрны 1 дүгээр орц 12 давхарт 89 тоот 	3	6500.00	0	7	f	0	2025-06-17 14:23:53.197+00	2025-06-28 09:28:27.604+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5065	2	94248544	Баян-Өлгий, Цэнгэл .\n Баян-Өлгий аймгийн унаанд тавьж өгнө үү? Утас:94248544	3	6500.00	0	\N	f	0	2025-06-17 10:10:35.139+00	2025-06-22 13:47:45.896+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5067	2	99109210	Улаанбаатар, Сүхбаатар, 10-р хорооУлаанбаатар, Сүхбаатар, 10-р хороо, yyccych yyccych test 	1	6500.00	0	\N	f	0	2025-06-17 10:16:39.429+00	2025-06-19 08:08:12.366+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5078	2	99612006	Улаанбаатар, Хан-Уул 15-р хороо Их наяд плазагийн зүүн талд Ривер Вилла, 8/1, 14 давхарт 199 тоот Хай	3	12100.00	0	\N	f	0	2025-06-18 02:26:07.526+00	2025-06-20 03:55:16.712+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5069	2	88139595	Улаанбаатар, Баянзүрх 22-р хороо Bayanzurkh duurgiin emnelegiin ard Delgereh hothon 103a Bair 2r orts 4 davhart 4030 toot\n 	3	6500.00	0	\N	f	0	2025-06-17 10:33:43.367+00	2025-06-22 13:47:45.896+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5071	2	91828111	Улаанбаатар, Хан-Уул, 16-р хорооДулаахан байр 3 Dulaakhan bair 3, Буянт ухаа 1 ард дулаахан байр-3 815 байр 8 давхар 73 тоот 	3	6500.00	0	\N	f	0	2025-06-17 15:39:02.871+00	2025-06-22 13:47:45.896+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5111	2	90729977	Булган, Хутаг-Өндөр 3гудам 217тоот\n 90729977 	3	6500.00	0	7	f	0	2025-06-18 10:25:54.76+00	2025-06-21 13:34:55.617+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5066	2	85207193	Завхан, Их-Уул Ирээдүй 21:2 Завхан аймаг Их-Уул сум 	3	6500.00	0	7	f	0	2025-06-17 10:12:45.222+00	2025-06-19 02:50:58.341+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5073	2	90412285	Улаанбаатар, Хан-Уул 18-р хороо 115 surguulin hajud 91 bair 11 davhar 46 toot\n Han uul duureg 19horoo 115 surgulin hajud 91 bair 11 davhar 46 toot	3	6500.00	0	\N	f	0	2025-06-18 01:38:23.766+00	2025-06-22 05:35:52.087+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5080	2	80822403	Дундговь, Сайнцагаан 11-1 Хагарна	3	6500.00	0	9	f	0	2025-06-18 02:26:22.964+00	2025-06-22 13:38:20.73+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5369	2	99991819	Улаанбаатар, Баянзүрх 36-р хороо Emerald Residence 509-3орц 17 давхар 1708 	3	6500.00	0	12	f	0	2025-06-28 17:15:35.973+00	2025-07-02 10:53:45.443+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5077	2	99203727	Улаанбаатар, Баянзүрх 36-р хороо Crystal town, 802 bair, 1 orts, 402 toot\n 	3	6500.00	0	12	f	0	2025-06-18 02:26:00.036+00	2025-06-24 06:53:40.449+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5212	2	80014312	Улаанбаатар, Баянгол 17-р хороо 28-1/47 toot 12 davhar 	3	6500.00	0	\N	f	0	2025-06-23 10:22:11.76+00	2025-06-26 12:49:32.659+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5283	2	80998696	Улаанбаатар, Сонгинохайрхан 38-р хороо сутайн буянт зах а2-64 	3	6500.00	0	9	f	0	2025-06-25 11:14:01.702+00	2025-06-30 06:07:17.123+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5430	2	99583388	Улаанбаатар, Баянзүрх 39-р хороо Тэнгэр плаза дорнод явах унаанд 	3	6500.00	0	9	f	0	2025-07-01 07:31:07.326+00	2025-07-07 10:18:24.237+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5068	2	99682030	Улаанбаатар, Сүхбаатар 02-р хороо 1 r surguulitai zalgaa oros elchingiin uuduuus harsan Twin tower office center 2r bair gs25tai haalgaar orood 6 davhart	6	6500.00	0	\N	f	0	2025-06-17 10:17:15.304+00	2025-07-18 06:03:19.821+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5690	16	95081889	niseh denjin buudal 481. 2 orts  501 toot 	3	1.00	a	7	f	0	2025-07-10 04:33:44.866+00	2025-07-10 12:39:32.671+00	f	\N	\N	\N
5098	2	99703201	1-р хороо, Талбай Төв шуудан байр баруун хаалга утас 99703201. Ажлын цагаар талбай төв шуудан байр баруун хаалга\t	3	6500.00	a	4	f	0	2025-06-18 06:16:05.95+00	2025-06-19 05:03:53.946+00	f	\N	\N	\N
5103	2	88108658	Улаанбаатар, Хан-Уул 15-р хороо Академи 1 хотхон 34г байр 104 тоот 	3	6500.00	0	6	f	0	2025-06-18 07:29:53.68+00	2025-06-19 13:30:25.168+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5109	2	90777776	Улаанбаатар, Сүхбаатар 02-р хороо Era hotel\n 	3	6500.00	0	\N	f	0	2025-06-18 10:08:51.321+00	2025-06-22 16:23:33.018+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5087	2	99092544	Улаанбаатар, Хан-Уул 17-р хороо Улаанбаатар, Хан-Уул, 17-р хороо 122 байр, 1 орц, 8 давхарт, 117 тоот 	3	6500.00	0	6	f	0	2025-06-18 03:17:30.587+00	2025-06-19 13:56:09.971+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5101	2	89809570	Улаанбаатар, Баянзүрх 26-р хороо Wells Residence 1 r orts 5 davhar 504 toot orts kod-9999tsooj456456 99931570 ruu zalgana uu	3	6500.00	0	\N	f	0	2025-06-18 07:07:00.712+00	2025-06-22 13:46:41.681+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6206	2	99510045	Улаанбаатар, Баянзүрх 03-р хороо Сансар Гарден хотхон 39/5 байр 2-р орц 24 давхарт 2403 тоот 	3	12100.00	0	\N	f	0	2025-08-09 07:02:08.476+00	2025-08-11 07:12:01.023+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5097	2	86062971	hud 25-р хороо, 4бэрх хотхон 421 байр 9давхар 47тоот 91012722. 91012722	3	6500.00	a	\N	f	0	2025-06-18 06:14:35.34+00	2025-06-20 08:22:42.611+00	f	\N	\N	\N
5093	2	90292202	Увс, Улаангом 5 Uvs aimag 90292202\n	3	6500.00	0	7	f	0	2025-06-18 05:05:51.006+00	2025-06-21 13:36:26.102+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5105	2	99936933	Улаанбаатар, Хан-Уул 08-р хороо Toirog niseh actuve garden 504-16dawhar121 Active 504-121	3	6500.00	0	\N	f	0	2025-06-18 09:22:31.969+00	2025-06-22 13:46:29.276+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5092	2	99659195	Москва Шинэ апартмент, Москва Шинэ апартмент, Москва апартмент 132-2байр 1301тоот.\t	3	6500.00	a	7	f	0	2025-06-18 04:38:58.087+00	2025-06-18 14:58:03.127+00	f	\N	\N	\N
5091	2	89028192	Улаанбаатар, Сонгинохайрхан 34-р хорооХилчин 58-р гудамж 14тоот	3	6500.00	a	7	f	0	2025-06-18 04:38:14.075+00	2025-06-18 17:24:35.945+00	f	\N	\N	\N
5083	2	88882475	Улаанбаатар, Хан-Уул 22-р хороо Зайсан, Сарнайхаар богд хан уул буюу дугуй цагаанруу өгсөөд Күнз сургуулийн эсрэг талд Villa verde хотхон, 112/6 байр 1 р орц 1002 тоот, орц код 2-1002 дуудлага хийх Ок	3	6500.00	0	\N	f	0	2025-06-18 02:26:41.48+00	2025-06-22 05:38:03.307+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5094	2	99660662	hud 15-р хороо, Соларис резиденс, 66/4байр, 901тоот.	3	6500.00	a	6	f	0	2025-06-18 06:06:29.287+00	2025-06-18 12:34:34.551+00	f	\N	\N	\N
5086	2	89047769	Улаанбаатар, Хан-Уул 21-р хороо Улаанбаатар, Хан-Уул, 21-р хороо Niseh Buynt-Uhaa tsogtsolboriin baruun talaar uragshaa ywaad 161 surguuliin baruun tald 436 1-1304 toot\n\n Hiseh Buynt 	3	6500.00	0	\N	f	0	2025-06-18 02:51:35.639+00	2025-06-22 13:47:01.305+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5085	2	86097606	Улаанбаатар, Чингэлтэй 05-р хороо Holidayinn Hotel Ulaanbaatar  	3	6500.00	0	7	f	0	2025-06-18 02:30:10.32+00	2025-06-20 03:43:34.091+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5084	2	88601514	Улаанбаатар, Сүхбаатар 10-р хороо 16 р сургуулийн зүүн талд 23 р байр в1 давхар Ирхээсээ өмнө залгах 88601514	3	6500.00	0	4	f	0	2025-06-18 02:27:08.681+00	2025-06-19 09:17:22.543+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5100	2	86040886	dornod unaand	3	6500.00	a	4	f	0	2025-06-18 07:06:18.991+00	2025-06-18 08:01:18.499+00	f	\N	\N	\N
5102	2	99648399	16-р хороо, Офицероос Цайз өгсөх замд байх генерал худалдааны төвийн автобусны буудлын наагуур баруун эргэж ороод хашааны цаад байх 41в байр 48 тоот.\t	3	6500.00	a	4	f	0	2025-06-18 07:07:33.846+00	2025-06-18 08:11:50.149+00	f	\N	\N	\N
5089	2	99691310	erdenet	3	6500.00	a	7	f	0	2025-06-18 04:36:18.752+00	2025-06-18 08:37:47.316+00	f	\N	\N	\N
5088	2	88301931	Дархан хуучин хороолол 19-60тоот. Дархан уул аймаг\t	3	6500.00	z	7	f	0	2025-06-18 04:33:46.241+00	2025-06-18 08:42:25.177+00	f	\N	\N	\N
5104	2	99024390	Дархан-Уул, Дархан сум 25р хороолол 1-9 тоот 99024390 Дархан\n	3	6500.00	0	7	f	0	2025-06-18 08:48:35.582+00	2025-06-21 13:39:52.088+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5096	2	99612445	Баянзүрх - 22-р хороо 72r bair 44toot  Nemelt dugaar 89191190	3	6500.00	a	9	f	0	2025-06-18 06:12:10.78+00	2025-06-21 03:01:03.994+00	f	\N	\N	\N
6282	30	1212121	hayag	5	11111.00	data	29	t	10	2025-08-14 14:26:25.33+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
6586	32	80872626	Jukow muize zvvn tald 50/2bair	3	39000.00		9	t	13	2025-08-21 01:54:22.692+00	2025-08-23 03:27:20.819+00	f	\N	\N	\N
5026	2	94101552	Улаанбаатар, Баянзүрх, 26-р хорооtime tower, Time tower 218-131 	3	6500.00	0	6	f	0	2025-06-17 02:45:41.812+00	2025-06-18 10:26:44.63+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5099	2	99177586	Улаанбаатар, Баянгол, 24-р хороо 2-р орц 12 давхарт 154 тоот.\t	3	6500.00	a	6	f	0	2025-06-18 06:20:46.145+00	2025-06-18 10:52:02.164+00	f	\N	\N	\N
5106	2	94965566	Улаанбаатар, Хан-Уул, 3-р хорооРиверстоун хотхон 26А байр Riverstone hothon 26A bair Riverstone hothon 26A bair, Алтай хотхоны урд талын River stone2. Нарны гүүр даваад гэрлэн дохиогоор баруун эргээд ривер стоне2 	3	6500.00	0	6	f	0	2025-06-18 09:27:16.798+00	2025-06-20 11:26:08.759+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5095	2	99095434	Жэпэн Таун C3 байр Japan Town C3 bair, Жэпэн Таун C3 байр Japan Town C3 bair, C орц, 6 давхарт 604 тоот.\t	3	6500.00	a	\N	f	0	2025-06-18 06:09:08.654+00	2025-06-22 05:38:43.752+00	f	\N	\N	\N
5107	2	89182576	Улаанбаатар, Баянзүрх 02-р хороо 104.5pm iin oiroltsoo 	3	6500.00	0	9	f	0	2025-06-18 10:01:18.472+00	2025-06-22 13:38:20.73+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5042	2	99114654	Улаанбаатар, Хан-Уул 02-р хороо Улаанбаатар, Хан-Уул, 2-р хороо Хан уул дүүрэг 19р хороолол үйлчилгээний төвийн баруун тийш хийморь 19 хотхон 33-55 тоот  	3	6500.00	0	6	f	0	2025-06-17 06:12:01.722+00	2025-06-18 11:09:05.985+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5115	2	95183281	Улаанбаатар, Сонгинохайрхан 02-р хороо толгойтын эцэс 	3	6500.00	0	7	f	0	2025-06-18 13:39:50.17+00	2025-06-21 13:36:44.578+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5112	2	99109210	Улаанбаатар, Сүхбаатар 06-р хороо , Улаанбаатар, Сүхбаатар, ene ub hayag test hiine ene ub hayag test hiine vgjvuyuo	1	6500.00	0	\N	f	0	2025-06-18 10:45:06.255+00	2025-06-23 03:32:38.1+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5121	2	99646524	Улаанбаатар, Сонгинохайрхан 05-р хороо Ханын материалаас дээшээ Ган хийцийн замд сүүлд баригдсан 2 ихэр шар улаантай байр 99646524 	3	6500.00	0	7	f	0	2025-06-18 15:31:15.886+00	2025-06-20 11:43:22.47+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5116	2	99947900	Өвөрхангай, Арвайхээр сум Burhiin 9,8,8 baynzurh delguur 99947900 99947900 Ovorhangai Arvaikheer\n	3	12100.00	0	7	f	0	2025-06-18 14:28:29.921+00	2025-06-21 13:36:35.282+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5117	2	99947900	Өвөрхангай, Арвайхээр сум Burhiin 9,8,8 baynzurh delguur 99947900 	3	12100.00	0	7	f	0	2025-06-18 14:29:14.369+00	2025-06-21 13:37:03.482+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5113	2	99289121	Орхон, Баян-Өндөр сум Erdenet 99289121\n Erdenet 99289121\n	3	6500.00	0	7	f	0	2025-06-18 13:07:05.825+00	2025-06-21 13:39:57.005+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5118	2	88880826	Улаанбаатар, Хан-Уул 17-р хороо Улаанбаатар, Хан-Уул, 17-р хороо Ривэр гарден 319 байр 2р орц 7 давхар 702 тоот 	3	6500.00	0	6	f	0	2025-06-18 14:41:13.2+00	2025-06-21 03:39:01.608+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5129	2	99951197	Улаанбаатар, Сонгинохайрхан 20-р хороо 12 байр \n 	3	6500.00	0	7	f	0	2025-06-19 03:26:11.457+00	2025-06-20 12:30:29.24+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5120	2	99696998	Улаанбаатар, Баянзүрх 26-р хороо Olymp hothon, 428, 2r orts,8, 112 toot 	3	6500.00	0	12	f	0	2025-06-18 15:27:09.787+00	2025-06-20 07:36:17.583+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5125	2	86112127	Говьсүмбэр, Сүмбэр, 3-р багЧОЙРЫН ТАКСИНД НАРАН ТУУЛ ДЭЭР  ТАВЬЖ ЯВУУЛАХ БОЛОМЖТОЙ БӨГӨӨД 9977 1114 \n88047786 РУУ МЭДЭГДЭХ 	5	6500.00	0	7	f	0	2025-06-19 00:12:29.491+00	2025-06-24 06:18:33.784+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5127	2	99907100	Улаанбаатар, Хан-Уул, 17-р хорооRiver garden 2, River garden 2, 401r bair, 6n davhart, 604 toot 	3	6500.00	0	6	f	0	2025-06-19 01:46:05.295+00	2025-06-20 14:43:43.618+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5124	2	88692950	Улаанбаатар, Хан-Уул 11-р хороо Улаанбаатар, Хан-Уул, 11-р хороо Зайсан эцэс Хан-түшээ хотхон 201байр 	3	6500.00	0	\N	f	0	2025-06-18 22:32:58.386+00	2025-06-22 05:37:01.271+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5122	2	95572300	Элст, 13-17-10 toot.\t	3	6500.00	z	9	f	0	2025-06-18 15:33:20.229+00	2025-06-20 08:17:51.573+00	f	\N	\N	\N
5119	2	86859230	Улаанбаатар, Багануур Улаанбаатар, Багануур, 1-р хороо 8-р байр 51 тоот  	3	6500.00	0	9	f	0	2025-06-18 15:03:05.171+00	2025-06-25 05:54:49.781+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5036	2	89447391	Булган, Хишиг-Өндөр 89447391 дугаарлуу ярих унаа олж тавина\n 89447391 дугаарлуу залгам замын унаа олж өгнө	3	6500.00	0	7	f	0	2025-06-17 05:10:56.447+00	2025-06-19 01:22:19.484+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5128	2	94589999	Улаанбаатар, Хан-Уул 18-р хороо ub town uulzvar  zuun tald minii ger hothonii zuun tald 60a bair 1r orts 5 toot 94589999	3	6500.00	0	\N	f	0	2025-06-19 02:36:27.903+00	2025-06-22 13:45:07.234+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5114	2	88786872	Улаанбаатар, Баянгол 08-р хороо 77-r surguuliin urd 7-3r bair 71 toot 	3	12100.00	0	\N	f	0	2025-06-18 13:18:00.902+00	2025-06-22 13:45:37.599+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5064	2	95263629	Өвөрхангай, Арвайхээр сум 13р баг  60 айлийн орон сууцны хажууд баялаг ундраа дэлгүүртэй 409-р байр в1-4  	3	6500.00	0	7	f	0	2025-06-17 09:55:05.907+00	2025-06-19 02:50:48.542+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5131	2	99108503	5-р хороолол 12Б байр , 5-р хороолол 12Б байр , Циркийн баруун талын time classic tower чулуун шар фасадтай байр 1р орц 15давхарт 1502тоот Орц код 1502#.\t	3	6500.00	a	7	f	0	2025-06-19 03:48:52.243+00	2025-06-19 12:06:24.752+00	f	\N	\N	\N
5123	2	99055975	Улаанбаатар, Хан-Уул 15-р хороо Khan uul KH apartment 6a 2 orts 10dawhart 135 tiit 99055975	3	6500.00	0	6	f	0	2025-06-18 16:03:43.178+00	2025-06-20 13:41:47.56+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5130	2	88888113	Сүхбаатар - 8-р хороо - Централ Таувер Central Tower Централ Таувер Central Tower, Central tower 14th floor, Unitel	3	6500.00	a	7	f	0	2025-06-19 03:39:36.394+00	2025-06-19 06:04:00.871+00	f	\N	\N	\N
5713	15	99537046	 Хан-Уул дүүрэг 2р хороо Нутгийн буян хотхон 35б байр 2р орц 106 тоот	3	1.00	a	21	f	0	2025-07-11 12:51:47.179+00	2025-07-12 10:24:59.244+00	f	\N	\N	\N
6207	17	89222887	Нарны хороолол 6р байр 7давхар 27тоот	3	56000.00	a	6	t	5	2025-08-09 08:15:41.97+00	2025-08-18 18:43:50.086+00	f	\N	\N	\N
5154	2	99544300	Улаанбаатар, Хан-Уул 20-р хороо Xan uul tower oos uragsha organik zaxiin xajud Xos zuu 100A bair 	3	6500.00	0	6	f	0	2025-06-19 15:08:46.279+00	2025-06-20 12:16:22.011+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6016	2	90304424	Улаанбаатар, Сонгинохайрхан 20-р хороо Шинэ драгон 	3	12100.00	0	9	f	0	2025-07-29 02:21:23.117+00	2025-07-31 05:18:55.067+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5138	2	99744990	Төв, Заамар Төв, Заамар, Хайлааст заамар сумын шижир алт тосгон\nөгөөмөр 1..1тоот 	3	6500.00	0	7	f	0	2025-06-19 05:55:42.914+00	2025-06-22 16:20:22.304+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5136	2	99981962	Увс, Улаангом, 4-р баггэр хороолол, 8 11toot Шинэ драгон дөл тээш 	3	6500.00	0	7	f	0	2025-06-19 05:23:36.031+00	2025-06-21 13:37:49.689+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5148	2	99122780	Улаанбаатар, Хан-Уул 11-р хороо Гэрэлт хотхон Жүр үр-тэй байр 1 давхарт Niji Japanese restaurant  	3	12100.00	0	\N	f	0	2025-06-19 08:45:23.421+00	2025-06-22 13:39:19.987+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5134	2	99955449	Баянхонгор, Баянхонгор сум Ногон Лувсанданзанжанцан өргөн чөлөө 5р гудамж 508р байр 12 тоот 	3	6500.00	0	7	f	0	2025-06-19 04:03:09.574+00	2025-06-21 13:37:59.978+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5139	2	99400737	Дархан-Уул, Дархан сум мангирт 8-р хэсэг 1-64 тоот 	3	6500.00	0	7	f	0	2025-06-19 05:59:01.482+00	2025-06-21 13:38:48.905+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5140	2	80117044	Улаанбаатар, Сүхбаатар 11-р хороо Хангай хотхон 510-р байр 3 давхарт 18тоот  	3	6500.00	0	9	f	0	2025-06-19 06:13:00.177+00	2025-06-25 05:54:49.781+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5151	2	88008794	Улаанбаатар, Хан-Уул 18-р хороо Улаанбаатар, Хан-Уул, 18-р хороо Han uul 18 horoo. Hunnu 2222, 118-4D Han uul 18 horoo. Hunnu 2222, 118-4D   Утас : 99118578	3	12100.00	0	\N	f	0	2025-06-19 12:16:59.928+00	2025-06-22 13:43:31.359+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5156	2	99102333	Улаанбаатар, Хан-Уул 15-р хороо Бүти Таун 107-90 тоот 8 давхар 	3	6500.00	0	12	f	0	2025-06-20 00:43:27.254+00	2025-06-22 09:12:50.569+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5133	2	85960301	Төв, Борнуур 2r gudamj 4 toot\n 	3	6500.00	0	7	f	0	2025-06-19 03:58:07.751+00	2025-06-29 07:40:48.807+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5155	2	89936116	Улаанбаатар, Сүхбаатар 07-р хороо Saruul hothon 23A bair, 5n davhar,10n toot 	3	6500.00	0	\N	f	0	2025-06-19 19:38:23.928+00	2025-06-27 04:48:53.65+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5147	2	86112127	Говьсүмбэр, Сүмбэр, 3-р багЧОЙРЫН ТАКСИНД НАРАН ТУУЛ ДЭЭР  ТАВЬЖ ЯВУУЛАХ БОЛОМЖТОЙ БӨГӨӨД 9977 1114 \n88047786 РУУ МЭДЭГДЭХ 	3	6500.00	0	9	f	0	2025-06-19 08:10:11.154+00	2025-06-27 05:26:34.58+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5149	2	99323035	Өвөрхангай, Арвайхээр сум 103 3 	3	6500.00	0	\N	f	0	2025-06-19 09:23:11.612+00	2025-06-22 13:44:10.24+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
5141	2	89334003	sbd 12 horoo 12gudamj 485b	3	6500.00	a	4	f	0	2025-06-19 06:14:56.352+00	2025-06-19 09:03:58.634+00	f	\N	\N	\N
5146	2	89591171	Хөвсгөл, Мөрөн сум Хөвсшөл аймаг мөрөн сум 5р хороо 1р гудамж 15 тоот 	3	6500.00	0	7	f	0	2025-06-19 08:07:48.18+00	2025-06-23 07:05:21.373+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5142	2	80803767	СХД 39 хороо Хангайн 53-18 тоот	3	6500.00	a	\N	f	0	2025-06-19 06:16:52.369+00	2025-06-22 13:44:26.959+00	f	\N	\N	\N
5132	2	80002474	Улаанбаатар, Чингэлтэй 04-р хороо Max toweriin ard, barilgachdiin talbain zuun tald hiimori 1 hothon 4/6 bair 2r orts 8 davhart 44 toot Ireheesee umnu utsaar zalgah 18:00 hoish hurtel baival sain bn	3	6500.00	a	7	f	0	2025-06-19 03:49:54.519+00	2025-06-19 11:26:48.807+00	f	\N	\N	\N
5135	2	95930495	Улаанбаатар, Хан-Уул 18-р хороо Gerlug hothon 58/7 bair  	3	6500.00	0	\N	f	0	2025-06-19 04:05:33.685+00	2025-06-22 13:44:48.223+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5714	15	92035070	Эрдэнэтрүү унаанд тавих	3	1.00	a	21	f	0	2025-07-11 12:52:10.265+00	2025-07-12 08:15:18.408+00	f	\N	\N	\N
6208	15	86888887	хүннү2222,214-601	5	1.00	1	18	f	0	2025-08-09 09:56:55.421+00	2025-08-12 00:12:51.855+00	f	\N	\N	\N
5145	2	99589988	Улаанбаатар, Хан-Уул, 11-р хорооКинг Таувер 126 байр King tower 126 bair, ХУД, 17-р хороо, Кинг товер, 2 орц, 9 давхар, 226 тоот 	3	12100.00	0	\N	f	0	2025-06-19 07:42:14.438+00	2025-06-24 14:23:01.072+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5152	2	94111051	Улаанбаатар, Чингэлтэй 07-р хороо ХВ10 гудам 456 тоот\n\n\n\n 88144063	3	6500.00	0	\N	f	0	2025-06-19 12:37:51.626+00	2025-07-01 01:24:33.182+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5143	2	80114249	Хөвсгөл, Мөрөн сум 5р баг 32р гудамж 10н тоот\n 	3	6500.00	0	9	f	0	2025-06-19 06:28:31.113+00	2025-06-22 13:38:20.73+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6256	2	88094295	Улаанбаатар, Сонгинохайрхан 25-р хороо Одонт 21-96а тоот\n 	3	6500.00	0	9	f	0	2025-08-12 09:08:25.979+00	2025-08-14 08:31:53.3+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5144	2	88822208	Улаанбаатар, Хан-Уул 18-р хороо Gerlug Vista 58-6-204  99126012 irhes umnu zalgah	3	6500.00	0	12	f	0	2025-06-19 07:07:48.916+00	2025-06-22 09:26:58.73+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5150	2	95558118	Баян-Өлгий, Өлгий сум 12-09 тоот 	3	6500.00	0	9	f	0	2025-06-19 09:32:04.802+00	2025-06-22 13:38:20.73+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5165	2	99109210	Улаанбаатар, Сонгинохайрхан 01-р хороо undefined test1234 test	1	6500.00	0	\N	f	0	2025-06-20 03:19:20.02+00	2025-06-23 03:30:54.508+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5167	2	99805342	Улаанбаатар, Хан-Уул 02-р хороо Бадрах хотхон, 18-р байр, 8 давхар, 801 тоот Хүргэлтэнд гархаасаа өмнө залгана уу	3	12100.00	0	\N	f	0	2025-06-20 03:27:03.317+00	2025-06-23 03:34:30.248+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6318	2	99975080	Улаанбаатар, Баянзүрх 15-р хороо БЗД 25р хороо Эрэл 40р байр 1р орц 9 давхар 34 тоот 99975080 , Хүргэлт ирхээс 1-2 цагын өмнө залгаж мэдэгднэ үү , баярлалаа\n	3	6500.00	0	44	f	0	2025-08-17 00:45:30.827+00	2025-08-23 05:29:10.925+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5173	2	89951123	Улаанбаатар, Баянзүрх 14-р хороо Нийслэл худалдааны төв 8давхарт 812\n\n 	3	12100.00	0	\N	f	0	2025-06-20 04:35:17.973+00	2025-06-24 14:22:36.201+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5175	2	99109210	Улаанбаатар, Сонгинохайрхан 01-р хороо Улаанбаатар, Сонгинохайрхан, 1-р хороо test1234 	1	6500.00	0	\N	f	0	2025-06-20 06:18:33.474+00	2025-06-23 03:31:26.533+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5161	3	88064537	narnii horoolol	3	1000.00	comment bhgu	13	f	0	2025-06-20 03:13:45.614+00	2025-08-22 14:31:40.71+00	f	\N	https://res.cloudinary.com/dgpk9aqnc/image/upload/v1750416625/deliveries/ft1u6ftxikidcffgbqcu.jpg	\N
6209	2	86754464	Улаанбаатар, Баянзүрх 11-р хороо Bagatenger city\n 	2	6500.00	0	29	f	0	2025-08-09 12:13:13.449+00	2025-08-24 11:48:55.775+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5159	2	99109210	Улаанбаатар, Сонгинохайрхан 01-р хороо Улаанбаатар, Сонгинохайрхан, 1-р хороо test1234 xD	1	6500.00	0	\N	f	0	2025-06-20 02:33:55.288+00	2025-06-23 03:31:57.287+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5174	2	88102995	Улаанбаатар, Сүхбаатар 09-р хороо Улаанбаатар, Сүхбаатар, 9-р хороо 220r байр 204 тоот код 204в 220.204 тоот 88102995  	3	6500.00	0	9	f	0	2025-06-20 05:18:14.641+00	2025-06-25 05:54:49.781+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5157	2	99983380	Завхан, Улиастай сум, Богдын гол 6-20, Завхан аймаг Улиастай сум богдын гол баг 6-20 Завхан Улиастай Утас: 99983380	3	12100.00	0	7	f	0	2025-06-20 02:11:49.05+00	2025-06-21 13:39:38.368+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5163	2	88883127	Улаанбаатар, Хан-Уул 24-р хороо Vip residence 474-r bair 9 davhart 23 toot 	6	6500.00	0	\N	f	0	2025-06-20 03:14:22.426+00	2025-07-18 06:03:19.821+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5160	2	99109210	Улаанбаатар, Сонгинохайрхан 01-р хороо undefined test1234 	1	6500.00	0	\N	f	0	2025-06-20 02:47:15.782+00	2025-06-23 03:31:57.287+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5079	2	99612006	Улаанбаатар, Хан-Уул 15-р хороо Их наяд плазагийн зүүн талд Ривер Вилла, 8/1, 14 давхарт 199 тоот Хай	3	12100.00	0	\N	f	0	2025-06-18 02:26:12.855+00	2025-06-20 03:55:16.712+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5081	2	99612006	Улаанбаатар, Хан-Уул 15-р хороо Их наяд плазагийн зүүн талд Ривер Вилла, 8/1, 14 давхарт 199 тоот Хай	3	12100.00	0	\N	f	0	2025-06-18 02:26:26.529+00	2025-06-20 03:55:16.712+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5082	2	99612006	Улаанбаатар, Хан-Уул 15-р хороо Их наяд плазагийн зүүн талд Ривер Вилла, 8/1, 14 давхарт 199 тоот Хай	3	12100.00	0	\N	f	0	2025-06-18 02:26:34.902+00	2025-06-20 03:55:16.712+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5003	2	98291180	Улаанбаатар, Чингэлтэй 06-р хороо61р байр 6давхарт 6н тоот 61р байр 16 тоот	3	6500.00	0	\N	f	0	2025-06-16 11:49:19.934+00	2025-06-20 04:00:04.23+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5164	2	99109210	Улаанбаатар, Сонгинохайрхан 01-р хороо undefined test1234 	1	6500.00	0	\N	f	0	2025-06-20 03:15:05.7+00	2025-06-23 03:31:57.287+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6294	2	99194081	Улаанбаатар, Баянзүрх 16-р хороо , Улаанбаатар, Баянзүрх, Мөнх худалдааны төв Munkh hudaldaanii tuv 99194081  Мөнх худалдааны төв Munkh hudaldaanii tuv 99194081  	3	6500.00	0	44	f	0	2025-08-15 15:31:59.854+00	2025-08-24 09:22:36.049+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6257	2	91019949	Улаанбаатар, Сүхбаатар 03-р хороо Altanjoloo tower 17 давхарт 	3	6500.00	0	29	t	10	2025-08-12 11:47:55.801+00	2025-08-20 15:43:31.284+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5169	2	88858436	120 мянгат, 17-р байр, 1-р орц, 2 давхар, 6 тоот . Орцны код 1701#.	3	6500.00	a	12	f	0	2025-06-20 03:30:32.458+00	2025-06-20 06:14:31.431+00	f	\N	\N	\N
5176	2	94949756	Увс, Улаангом , Увс, Улаангом, 94949756 94949756 	3	6500.00	0	7	f	0	2025-06-20 06:36:49.746+00	2025-06-21 13:39:22.472+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
5168	2	88406970	shd 27-р хороо, Хангай захын эсрэг талд шар өнгийн таван давхар 19дугаар байр 5давхарт 21 тоот.	3	6500.00	a	7	f	0	2025-06-20 03:27:03.688+00	2025-06-20 11:33:40.348+00	f	\N	\N	\N
5166	2	99109210	Улаанбаатар, Сонгинохайрхан 01-р хороо undefined test1234 	1	6500.00	0	\N	f	0	2025-06-20 03:25:50.565+00	2025-06-23 03:30:54.508+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5170	2	99109210	Улаанбаатар, Баянзүрх 26-р хороо undefined 26-р хороо asdfasdfasdfasf test	1	6500.00	0	\N	f	0	2025-06-20 03:32:12+00	2025-06-23 03:30:54.508+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5198	2	99412316	Улаанбаатар, Хан-Уул 21-р хороо Буянт-Ухаа2 шүрт хотхон 812р байр 1орц 3давхар 12тоот\n 	3	6500.00	0	7	f	0	2025-06-21 12:35:16.688+00	2025-06-28 10:10:31.474+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5177	2	99109210	Улаанбаатар, Сүхбаатар 10-р хороо Улаанбаатар, Сүхбаатар, 10-р хороо yyccych 	1	6500.00	0	\N	f	0	2025-06-20 06:36:57.353+00	2025-06-23 03:32:38.1+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6210	2	88920007	Улаанбаатар, Баянзүрх 08-р хороо Эрдэнэ толгой 40 МС граж, Леогийн Ветнам засвар. 88370009 рүү залгах 289r tsetserlegiin zamiin esreg tald bairaldag. \n99144502, 88370009 ruu zalgaarai	1	6500.00	0	\N	f	0	2025-08-09 14:07:50.079+00	2025-08-09 14:07:50.091+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5192	2	99200447	Дархан-Уул, Дархан сум, 13-р баг, 4р байр 26 тоот альфа хотхон\t	3	6500.00	a	9	f	0	2025-06-21 02:54:43.095+00	2025-06-26 12:50:10.68+00	f	\N	\N	\N
5184	2	99400737	Дархан-Уул, Дархан сум мангирт 8-р хэсэг 1-64 тоот 	3	6500.00	0	7	f	0	2025-06-20 07:57:50.09+00	2025-06-24 06:18:04.402+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5189	2	89809570	Улаанбаатар, Баянзүрх 26-р хороо Wells Residence 1 r orts 5 davhar 504 toot orts kod-9999tsooj456456 99931570 ruu zalgana uu	3	6500.00	0	12	f	0	2025-06-20 15:13:24.566+00	2025-06-24 13:07:07.502+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5197	2	99573250	Улаанбаатар, Чингэлтэй 01-р хороо 6/1 18 	3	6500.00	0	9	f	0	2025-06-21 12:34:31.858+00	2025-06-26 12:50:10.68+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5214	2	85921081	Улаанбаатар, Хан-Уул 16-р хороо Neshin toirogiin noin denj der b one hothon 250-r bair 4 dawhar 16 toot  Nisehin toirgin hoin	3	6500.00	0	7	f	0	2025-06-23 10:37:09.407+00	2025-06-28 09:38:27.716+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5181	2	88990017	19 uilchilgeenii tuv	3	6500.00	a	6	f	0	2025-06-20 07:13:16.235+00	2025-06-20 12:17:03.781+00	f	\N	\N	\N
5187	2	80115898	Баянхонгор, Баянхонгор сум 216 1 тоот 80115898 bayankhongor 	3	6500.00	0	7	f	0	2025-06-20 13:46:24.159+00	2025-06-26 10:31:48.74+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5185	2	99635535	Улаанбаатар, Баянгол, 20-р хорооЭсБи төв SB center, Эсби төв 57 лангуу Buruu gazar ochson bna sapporo salbar deer zahialsan	3	6500.00	0	7	f	0	2025-06-20 08:10:36.657+00	2025-06-27 07:44:04.559+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6295	2	95322191	Улаанбаатар, Сүхбаатар 01-р хороо Diplomat apartment C orts 4 davhar 409 toot 	3	6500.00	0	\N	f	0	2025-08-15 16:08:17.37+00	2025-08-22 06:40:41.2+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5213	2	99116301	Улаанбаатар, Сүхбаатар 09-р хороо The Corporate hotel ulaanbaatar Hurdan hurgeed uguurei	3	6500.00	0	4	f	0	2025-06-23 10:35:25.543+00	2025-06-25 08:53:08.917+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5183	2	95015588	Улаанбаатар, Хан-Уул 18-р хороо hunnu 2222 109-r bair 1r orts 8 dawhar 8b  	3	6500.00	0	12	f	0	2025-06-20 07:14:29.243+00	2025-06-22 15:04:18.279+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5053	2	99182555	Улаанбаатар, Баянзүрх 01-р хороо 30-2r orts-13davhr-244 	3	6500.00	0	9	f	0	2025-06-17 07:56:13.725+00	2025-06-21 03:01:03.994+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5046	2	95589955	Дорнод, Хэрлэн сум 25р байр 60 тоот 	3	6500.00	0	9	f	0	2025-06-17 06:53:57.695+00	2025-06-21 03:01:03.994+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5186	2	86640307	Улаанбаатар, Баянзүрх 19-р хороо Саруултэнгэр2 хотхон 102-р байр 1-р орц 10 давхар 44 тоот БЗД 19-хороо Саруултэнгэр 2 хотхон 102-р байр	3	6500.00	0	9	f	0	2025-06-20 10:32:57.646+00	2025-06-25 05:54:49.781+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5191	2	88887981	Улаанбаатар, Хан-Уул 18-р хороо Гэрлүг Виста, 58/6 байр, 1105 тоот 	3	6500.00	0	12	f	0	2025-06-21 02:40:47.11+00	2025-06-24 13:06:33.591+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5182	2	88676873	Улаанбаатар, Баянгол 14-р хороо 13в байр 2р орц 7давхар 62тоот\nКод 62b\n 	3	6500.00	0	6	f	0	2025-06-20 07:13:49.029+00	2025-06-26 12:49:32.659+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5193	2	80831700	Улаанбаатар, Хан-Уул Bayn-zurh duureg 26-r horoo Sunny town 830r bair 1r orts 42 toot ireed zalgaarai	3	6500.00	0	12	f	0	2025-06-21 03:56:28.855+00	2025-06-24 13:06:42.098+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5188	2	88012747	Улаанбаатар, Хан-Уул 17-р хороо King tower 145r bair 1r orts 4 davhar 109toot\n 	3	6500.00	0	\N	f	0	2025-06-20 14:31:17.261+00	2025-06-26 12:49:32.659+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6326	31	88100573	Сбд, 1 хороо, замых цагдаагийн ард, Appartment145, 28в байр, 10д 50тоот  ( Тооцоо 35’000₮ авах) 	3	35000.00	й	18	f	0	2025-08-17 03:37:20.585+00	2025-08-18 03:48:34.661+00	f	\N	\N	\N
5178	2	99109210	Архангай, Хашаат Архангай, Хашаат, Жаргалант Жаргалант dsfasdfasdfasdfasdf 	1	6500.00	0	\N	f	0	2025-06-20 06:51:55.708+00	2025-06-23 03:31:26.533+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5158	2	86110600	Улаанбаатар, Баянзүрх 18-р хороо 22a 3orts 8 dawhar 103 toot  	3	6500.00	0	9	f	0	2025-06-20 02:23:01.942+00	2025-06-22 13:38:20.73+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5715	15	89091249	Баянзүрх дүүрэг 5 дугаар хороо 87-99 тоот	3	1.00	a	21	f	0	2025-07-11 12:52:52.38+00	2025-07-12 12:11:04.548+00	f	\N	\N	\N
5196	2	99591774	Улаанбаатар, Баянзүрх 26-р хороо Narlag urguu hothon 723 bair 12 davhart 45 toot Bairnii kod 72301#	3	6500.00	0	12	f	0	2025-06-21 11:18:52.789+00	2025-06-24 13:06:47.874+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5126	2	80001591	Улаанбаатар, Баянгол 30-р хороо Улаанбаатар, Баянгол, 30-р хороо Саппорогоос гэмтэл явах замд дашваанжил колонкын зүүн урд,далангийн зам.эрхэм чанар эмнэлэгтэй залгаа 3 байрны зүүн талынх.хд-2 баяр 6тоот.80001591,9415011,80570012 	3	6500.00	0	7	f	0	2025-06-19 01:08:12.746+00	2025-06-21 13:39:30.952+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5210	2	99365093	Улаанбаатар, Баянзүрх 07-р хороо 38B-30 	3	6500.00	0	9	f	0	2025-06-23 08:30:02.456+00	2025-06-26 12:50:10.68+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6211	2	80670297	Улаанбаатар, Баянзүрх 37-р хороо Сэрэнэ таун 85/1 77\n 	1	6500.00	0	\N	f	0	2025-08-09 14:39:40.562+00	2025-08-09 14:39:40.575+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5202	2	99173714	Улаанбаатар, Хан-Уул, 18-р хорооАкадеми хотхон 34б байр, ХУД, 18 хороо, академи 1 хотхон, 34б байр, 22 давхар,2201 тоот, орцны код 2201 \n	3	6500.00	0	6	f	0	2025-06-22 09:15:10.723+00	2025-06-26 10:13:47.194+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5022	2	95561036	Улаанбаатар, Чингэлтэй 20-р хороо Зурагтын Шинэбуудал Цагаануул дэлгүүрт авна. Зурагтын Шинэбуудал Цагаануул дэлгүүрт хүлээн авна. Утас: 95561036	3	6500.00	0	\N	f	0	2025-06-17 02:34:48.603+00	2025-06-22 13:31:23.129+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5153	2	80833331	Улаанбаатар, Баянзүрх 07-р хороо Сансарын Home plaza замын урд талд Тайж буудай буудлын баруун гар талаар ороод 41 байр 2 орц 2 давхарт 27 тоот 80833331 	3	6500.00	0	9	f	0	2025-06-19 14:14:25.766+00	2025-06-22 13:38:20.73+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5137	2	99764168	Улаанбаатар, Баянгол 20-р хороо Хархорингийн хажууд Москва47 байр 11 давхар 144 тоот 	3	6500.00	0	9	f	0	2025-06-19 05:43:27.207+00	2025-06-22 13:38:20.73+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5201	2	98821220	Улаанбаатар, Хан-Уул 21-р хороо Юу аппартмент ИХ ХУРГАН ХХТ 	3	6500.00	0	7	f	0	2025-06-21 23:39:55.613+00	2025-06-29 07:40:57.113+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5204	2	86031877	Улаанбаатар, Хан-Уул, 17-р хорооRiver garden, River garden town house 216 	3	6500.00	0	6	f	0	2025-06-23 03:26:08.618+00	2025-06-24 10:01:58.622+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5171	2	99109210	Улаанбаатар, Сонгинохайрхан 01-р хороо Улаанбаатар, Сонгинохайрхан, 1-р хороо test1234 	1	6500.00	0	\N	f	0	2025-06-20 04:17:14.293+00	2025-06-23 03:30:54.508+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5172	2	99109210	Улаанбаатар, Сонгинохайрхан 01-р хороо Улаанбаатар, Сонгинохайрхан, 1-р хороо test1234 	1	6500.00	0	\N	f	0	2025-06-20 04:19:22.774+00	2025-06-23 03:30:54.508+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5179	2	99109210	Улаанбаатар, Сонгинохайрхан 01-р хороо Улаанбаатар, Сонгинохайрхан, 1-р хороо test1234 	1	6500.00	0	\N	f	0	2025-06-20 06:58:52.357+00	2025-06-23 03:31:26.533+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5180	2	99109210	Улаанбаатар, Сонгинохайрхан 01-р хороо Улаанбаатар, Сонгинохайрхан, 1-р хороо test1234 	1	6500.00	0	\N	f	0	2025-06-20 07:03:42.835+00	2025-06-23 03:31:26.533+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6259	2	99030331	Улаанбаатар, Хан-Уул 11-р хороо Улаанбаатар, Хан-Уул, 11-р хороо Зайсан Соёмботой уулын хормой Astra town60r bair 3 dabhar 17 toot 99030331 	3	6500.00	0	19	f	0	2025-08-12 23:12:18.69+00	2025-08-15 06:54:28.568+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5199	2	99703201	Улаанбаатар, Сүхбаатар 01-р хороо Талбай Төв шуудан байр баруун хаалга утас 99703201 Ажлын цагаар талбай төв шуудан байр баруун хаалга	3	6500.00	0	\N	f	0	2025-06-21 16:20:21.518+00	2025-06-26 12:49:32.659+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5209	2	80131446	Улаанбаатар, Хан-Уул 20-р хороо Мишээл экспогийн зүүн урд river view хотхог \nГ блок 2 давхар 10тоот код 1124# 	3	6500.00	0	\N	f	0	2025-06-23 06:30:03.377+00	2025-07-01 01:24:33.182+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5207	2	99195608	Улаанбаатар, Баянзүрх 26-р хороо Time tower 218 14 davhart 62 toot 1801# ortsni kod \n 	3	6500.00	0	12	f	0	2025-06-23 06:12:35.446+00	2025-06-25 10:48:16.542+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5206	2	88110344	Улаанбаатар, Хан-Уул 02-р хороо Khan uul dvvrgiin zvvn tald moriton buyu kfctei bairnii urd taliin ulaan toosgon 6 davhar 75 r bair 2 orts 2 davhar t 32 toot orts kod 1302# 	3	6500.00	0	6	f	0	2025-06-23 04:50:04.353+00	2025-06-28 12:25:52.512+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6296	2	96646576	Улаанбаатар, Баянгол 04-р хороо Төмөр зам Ханбүргэдэй дэлгүүрийн зүүн урд талд 7-р байр 2-р орц 3 давхарт 23 тоот код 23#308 96646576 	1	6500.00	0	\N	f	0	2025-08-16 02:15:58.84+00	2025-08-16 02:15:58.853+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5203	2	88536761	Өмнөговь, Даланзадгад Өмнөговь, Даланзадгад, Цагаан булаг Arslan hothon 42-57 Өмнөговь аймгийн төв Даланзадгад хотын унаанд тавиулана	3	6500.00	0	7	f	0	2025-06-23 02:17:27.033+00	2025-06-26 10:31:38.373+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5211	2	86282528	Улаанбаатар, Баянгол 17-р хороо Ганьт хотхон 40д байр 69тоот 4давхар  	3	6500.00	0	\N	f	0	2025-06-23 09:55:34.525+00	2025-06-26 12:49:32.659+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5218	2	90922220	Улаанбаатар, Хан-Уул 07-р хороо Яармагийн шинэ эцсийн буудал дээр Болор дэлгүүрт үлдээх\n 	3	6500.00	0	7	f	0	2025-06-23 11:30:55.265+00	2025-06-29 07:41:07.035+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5221	2	99612006	Улаанбаатар, Хан-Уул 15-р хороо Их наяд плазагийн зүүн талд Ривер Вилла, 8/1, 14 давхарт 199 тоот 	3	12100.00	0	\N	f	0	2025-06-23 11:44:49.545+00	2025-06-24 14:22:23.646+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5216	2	88867645	Улаанбаатар, Хан-Уул 23-р хороо Artsat urguu 2dugaar bair 1dvgeer orts 6n dawhart 124 toot 	3	6500.00	0	7	f	0	2025-06-23 11:09:01.47+00	2025-06-29 09:49:20.304+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6212	2	88556455	Улаанбаатар, Баянзүрх 31-р хороо , Улаанбаатар, Баянзүрх, 35р гудам 47тоот хашаа 35р гудам 47тоот хашаа 	3	6500.00	0	9	f	0	2025-08-10 00:56:56.364+00	2025-08-12 09:00:38.747+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5240	2	88833381	Улаанбаатар, Сонгинохайрхан 23-р хороо Улаанбаатар, Сонгинохайрхан, 23-р хороо Hangain 27-19 toot Ажлын цагаар Хархорин зах Б1 75тоот лангуу	3	6500.00	0	7	f	0	2025-06-23 16:48:42.583+00	2025-06-26 12:19:27.994+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5242	2	95340440	Улаанбаатар, Хан-Уул, 17-р хорооModun town , Modun town 703/1303 	3	6500.00	0	\N	f	0	2025-06-23 23:41:06.827+00	2025-06-26 12:49:32.659+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5205	2	99433886	Улаанбаатар, Баянзүрх 42-р хороо , Улаанбаатар, Баянзүрх, Цагаан хуаран хотхон 92б байр 4 давхар 33 тоот.  Цагаан хуаран хотхон 92б байр 4 давхар 33 тоот.  	3	6500.00	0	9	f	0	2025-06-23 04:26:21.174+00	2025-06-25 05:54:49.781+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5220	2	80755211	Улаанбаатар, Баянгол 29-р хороо хар хорин хороолол 55/15 10давхар 48тоот 	3	6500.00	0	7	f	0	2025-06-23 11:38:18.175+00	2025-06-26 14:34:25.535+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6260	2	80883752	Улаанбаатар, Баянзүрх 43-р хороо Сэлбэ хотхон, 97/2-р байр, 14 давхар, 92тоот\n 	3	6500.00	0	9	f	0	2025-08-13 01:35:07.015+00	2025-08-15 05:29:59.345+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5241	2	99204498	Улаанбаатар, Багануур , Улаанбаатар, Багануур, 16-75 16-75 тэнгэр плаза дээрээс багануурын унаанд тавих	3	6500.00	0	9	f	0	2025-06-23 22:03:55.848+00	2025-06-26 03:12:14.304+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5244	2	80722229	Улаанбаатар, Хан-Уул 21-р хороо Нисэх Шүрт  хотхон  816 байр  2орц давхар 7давхар 114 тоот 	3	6500.00	0	7	f	0	2025-06-24 00:02:37.777+00	2025-06-28 09:56:17.066+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5222	2	99229646	Улаанбаатар, Сонгинохайрхан 08-р хороо Баянцагаан 5 гудамж 13 тоот\n 	3	6500.00	0	7	f	0	2025-06-23 12:28:13.45+00	2025-06-27 11:31:55.32+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5224	15	99999999	test	1	1.00	test123	\N	f	0	2025-06-23 13:37:16.46+00	2025-06-24 04:38:27.237+00	t	\N	\N	\N
5223	2	85158505	Улаанбаатар, Сонгинохайрхан, 34-р хорооБуман өлзий хороолол, 764-р байр, 3-р орц, 204 тоот 95835936 kholbigdood hvrgeed uguurei	3	6500.00	0	7	f	0	2025-06-23 13:08:27.342+00	2025-06-27 10:21:21.285+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5231	2	80548145	Улаанбаатар, Сүхбаатар 09-р хороо Lago verde hothon, 426r bair 9-3 80548145	3	6500.00	0	9	f	0	2025-06-23 14:22:09.833+00	2025-06-26 12:50:10.68+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5232	2	89908057	Улаанбаатар, Хан-Уул 10-р хороо moringin dawaa 12r gudam 493toot 	3	6500.00	0	7	f	0	2025-06-23 15:12:18.619+00	2025-06-29 11:10:31.63+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5243	2	80440045	Улаанбаатар, Хан-Уул 21-р хороо Нисэх шүрт хотхон 808 байр 3 давхарт 9 тоот 	3	6500.00	0	7	f	0	2025-06-23 23:55:57.369+00	2025-06-28 10:10:27.27+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5219	2	94589999	Улаанбаатар, Хан-Уул 18-р хороо ub town uulzvar  zuun tald minii ger hothonii zuun tald 60a bair 1r orts 5 toot 94589999	3	6500.00	0	\N	f	0	2025-06-23 11:33:23.713+00	2025-07-02 06:56:22.245+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5233	2	99104929	Улаанбаатар, Баянзүрх 43-р хороо Натур төвийн урд 91/3 р байр 4 давхар 15 тоот 	3	6500.00	0	9	f	0	2025-06-23 15:37:41.529+00	2025-06-26 12:50:10.68+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5225	15	99999999	test123	1	6000.00	hulduh ayultai	\N	f	0	2025-06-23 13:37:48.854+00	2025-06-24 04:38:27.237+00	t	\N	\N	\N
5226	15	94152403	erdenet	1	6000.00	хөвсгөл цэцэрлэг	\N	f	0	2025-06-23 13:38:48.429+00	2025-06-24 04:38:27.237+00	t	\N	\N	\N
5228	15	88064537	29-р хороо. Шинэ драгоны 6 давхарт American BBQ restaurantwqwq	1	14000.00	etet	\N	f	0	2025-06-23 13:51:07.013+00	2025-06-24 04:38:27.237+00	t	\N	\N	\N
5229	15	88064537	narnii horoolol	1	1000.00	etet	\N	f	0	2025-06-23 13:57:46.51+00	2025-06-24 04:38:27.237+00	t	\N	\N	\N
5217	2	88100966	Улаанбаатар, Хан-Уул 23-р хороо Арцат 2 апартмент 1442 байр 1р орц 4давхар 15 тоот 	3	12100.00	0	\N	f	0	2025-06-23 11:27:58.177+00	2025-06-24 14:22:09.127+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5215	2	86060120	Улаанбаатар, Сүхбаатар 09-р хороо СБД-ийн 9хороо 7 хороолол 293байр 52 тоот 	3	6500.00	0	9	f	0	2025-06-23 11:07:01.873+00	2025-06-25 05:54:49.781+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5716	15	95191229	Khan-uul, 2-r horoo, Paragon (35G),	3	1.00	a	21	f	0	2025-07-11 12:53:14.689+00	2025-07-12 10:19:03.006+00	f	\N	\N	\N
5258	2	91996080	Улаанбаатар, Сонгинохайрхан 20-р хороо Хар хорин зах эсрэг талд 32 хаан банк хажууд саарал төмөр хаалга 2 давхар 307 тоот 	3	12100.00	0	7	f	0	2025-06-24 09:45:47.584+00	2025-06-27 09:49:33.558+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5230	15	88064537	narnii horoolol	1	1000.00	etet	\N	f	0	2025-06-23 13:58:16.552+00	2025-06-24 04:38:27.237+00	t	\N	\N	\N
5239	15	88064537	narnii horoolol	1	90.00	etet	\N	f	0	2025-06-23 16:31:56.568+00	2025-06-24 04:38:27.237+00	t	\N	\N	\N
5255	2	80094444	Улаанбаатар, Баянзүрх 26-р хороо National park town 503r bair 901toot\n 	3	6500.00	0	12	f	0	2025-06-24 09:28:49.373+00	2025-06-25 11:16:22.577+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5248	2	88004238	Улаанбаатар, Баянгол 30-р хороо 10 р хороолол замын хойд талдаа хд27- р байо 24 тоот 	3	6500.00	0	7	f	0	2025-06-24 05:09:13.401+00	2025-06-26 15:59:28.9+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5246	2	88178107	Улаанбаатар, Сонгинохайрхан 42-р хороо Хайрханы 13-81а 	3	6500.00	0	7	f	0	2025-06-24 04:30:18.012+00	2025-06-27 11:57:39.622+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
5263	2	86996090	Улаанбаатар, Баянгол 20-р хороо 1р хороолол хархорин эрин хороолол 53/12 5тоот 1орц код #5321 заавал залгах 86996090	3	6500.00	0	7	f	0	2025-06-24 15:32:07.218+00	2025-06-26 14:20:44.518+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5247	2	95764699	Улаанбаатар, Баянзүрх 40-р хороо БЗД,16-р хороо,Шинэ гэр хотхон,55б байр,6 давхар,71тоот 	3	12100.00	0	9	f	0	2025-06-24 04:58:55.355+00	2025-06-26 12:50:10.68+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5256	2	60709994	Улаанбаатар, Сонгинохайрхан 07-р хороо 25-р гудамийн 22тоот 	3	12100.00	0	7	f	0	2025-06-24 09:33:48.795+00	2025-07-01 09:07:05.012+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
5253	2	88597240	Улаанбаатар, Хан-Уул 15-р хороо Хансвилл хотхон 101-1-403 тоот 	3	6500.00	0	12	f	0	2025-06-24 07:41:39.049+00	2025-06-26 06:12:45.023+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5264	2	99089576	Улаанбаатар, Баянзүрх 26-р хороо Tsetserlegt hureelen, Park View hothon 752 bair 11 davhart 257 toot uudnii kod,  #1752#. Utas: 99089576, 99105562 Utas: 99089576, 99105562 chemodan hurguuleh	6	6500.00	0	\N	f	0	2025-06-24 22:04:04.001+00	2025-06-26 12:52:07.658+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5254	2	86228224	Улаанбаатар, Баянгол 24-р хороо Altai hothon 50b bair 14davhar 75toot\n 	3	6500.00	0	6	f	0	2025-06-24 08:12:42.318+00	2025-06-26 09:45:05.975+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5257	2	99873034	Улаанбаатар, Сонгинохайрхан, 1-р хорооДрагон, Драгон авто вокзал Говь-Алтайн автобус  3 tsagaas 	3	6500.00	0	7	f	0	2025-06-24 09:45:21.638+00	2025-06-27 11:31:10.032+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6213	15	90702177	Хаяг: БЗД, 8-р хороо, Ботаникийн эцсээс хойш Шархад руу тавигдсан шинэ зам (залгавал замаа заагаад өгнө.)	3	1.00	1	9	f	0	2025-08-10 03:44:09.58+00	2025-08-10 08:43:58.81+00	f	\N	\N	\N
5249	2	88100417	Улаанбаатар, Сүхбаатар 03-р хороо Хүүхдийн 100, наран их дэлгүүрийн урд 40-р байр. Орцны код 1478#, Утас: 88100417 	3	6500.00	0	7	f	0	2025-06-24 05:14:10.948+00	2025-06-27 06:46:33.207+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6297	2	85755354	Улаанбаатар, Баянзүрх 01-р хороо Consul tower 79 байр 3-р орц 12-р давхар 208 тоот 	1	6500.00	0	\N	f	0	2025-08-16 03:45:11.225+00	2025-08-16 03:45:11.238+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5262	2	99825116	Улаанбаатар, Баянзүрх 26-р хороо Олимп village 201r bair 3orts 11dvhr 252 toot  	3	6500.00	0	12	f	0	2025-06-24 13:41:29.969+00	2025-06-28 02:18:02.373+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5260	2	96702098	Улаанбаатар, Сонгинохайрхан 11-р хороо Улаанбаатар, Сонгинохайрхан, 11-р хороо Баянхошуу 112-н буудал 105-р сургуулийн урд Мандал 8-162а тоот 	3	6500.00	0	7	f	0	2025-06-24 11:31:06.518+00	2025-06-26 13:50:57.913+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5252	2	99003456	Улаанбаатар, Баянзүрх 14-р хороо Зүүн 4 зам Зүүнхүрээ хотхон 203-р байр 2-р орц 8 давхарт 73тоот\n\n 	3	6500.00	0	9	f	0	2025-06-24 07:10:18.349+00	2025-06-30 06:07:17.123+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5250	2	99797725	Улаанбаатар, Баянзүрх 08-р хороо Улаанбаатар хот. Баянзүрх дүүрэг,  8-р хороо, Эрдэнэтолгой 81-р байшин 18 тоот\n 	3	6500.00	0	9	f	0	2025-06-24 05:15:29.757+00	2025-06-27 05:26:34.58+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6261	15	99082112	Хан ууул, хүннү2222, 112 байр 1 орц 14 давхарт 1401 тоот	3	1.00	1	19	f	0	2025-08-13 04:15:20.311+00	2025-08-14 15:39:21.82+00	f	\N	\N	\N
5261	2	99041399	Улаанбаатар, Сүхбаатар 07-р хороо , Улаанбаатар, Сүхбаатар, 39-р Байр 39-R Bair 39а-52 тоот Дүүрэн төвтэй байр 39-р Байр 39-R Bair 39а-52 тоот Дүүрэн төвтэй байр 99041399	3	6500.00	0	\N	f	0	2025-06-24 12:11:51.581+00	2025-06-27 04:48:53.65+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5251	2	99116968	Улаанбаатар, Баянзүрх, 26-р хороо351 АОС, Үндэсний Цэцэрлэгт Хүрээлэн зам дагуу Мандала хотхоны урд 7 давхар байр (дээрээ КОNE самбартай) 	3	6500.00	0	12	f	0	2025-06-24 06:08:15.5+00	2025-06-25 11:16:28.389+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6552	3	88064537	ete	1	0.00		\N	f	0	2025-08-20 14:53:18.603+00	2025-08-20 14:58:07.545+00	t	\N	\N	\N
6553	3	88064537	ete	1	0.00		\N	f	0	2025-08-20 14:53:20.891+00	2025-08-20 14:58:07.545+00	t	\N	\N	\N
5278	2	99646524	Улаанбаатар, Сонгинохайрхан 05-р хороо Ханын материалаас дээшээ Ган хийцийн замд сүүлд баригдсан 2 ихэр шар улаантай байр 99646524 99646524	3	6500.00	0	7	f	0	2025-06-25 08:09:56.537+00	2025-06-26 13:50:23.307+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5270	2	94099487	Улаанбаатар, Баянзүрх 26-р хороо Улаанбаатар, Баянзүрх, 26-р хороо Олимп хотхон 429-109 тоот утасны дугаар 94848494 	5	6500.00	0	\N	f	0	2025-06-25 03:55:57.095+00	2025-06-26 12:53:20.299+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5265	2	86218879	Улаанбаатар, Баянгол 03-р хороо Гэгээрэл сургууль Гадаад хүн байгаа	3	6500.00	0	\N	f	0	2025-06-24 22:42:52.078+00	2025-06-28 02:25:27.575+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5281	2	86228224	Улаанбаатар, Баянгол 24-р хороо Altai hothon 50b bair 14davhar 75toot\n 	3	6500.00	0	6	f	0	2025-06-25 10:16:12.102+00	2025-06-26 09:44:59.523+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5282	2	80755211	Улаанбаатар, Баянгол 29-р хороо хар хорин хороолол 55/15 10давхар 48тоот 	3	6500.00	0	7	f	0	2025-06-25 10:26:48.712+00	2025-06-26 14:34:11.794+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5280	2	86007187	Улаанбаатар, Баянгол 31-р хороо SHVVT hothon 55.2-7 toot 	3	6500.00	0	7	f	0	2025-06-25 09:40:36.197+00	2025-06-29 07:41:17.417+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5276	2	96016065	Улаанбаатар, Сонгинохайрхан 18-р хороо , Улаанбаатар, Сонгинохайрхан, СХД 5н шар  18р хороо VERDE apartment 21p байр 1р орц 2давхарт 14тоот СХД 5н шар  18р хороо VERDE apartment 21p байр 1р орц 2давхарт 14тоот 	3	6500.00	0	7	f	0	2025-06-25 07:10:10.686+00	2025-06-27 13:15:39.853+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5194	2	94946236	Улаанбаатар, Баянзүрх 43-р хороо 96 байр, сэлбэ хотхоны хажууд шаргал байр. Доороо дэлгэрэх гээд дэлгүүртэй 88887083 залгана ууе	3	6500.00	0	9	f	0	2025-06-21 09:18:07.081+00	2025-06-25 05:54:49.781+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5195	2	88177053	Улаанбаатар, Баянзүрх, 28-р хороо62 гудамж 4р хэсэг, 62.1876 	3	6500.00	0	9	f	0	2025-06-21 10:35:05.513+00	2025-06-25 05:54:49.781+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5227	2	72204598	Улаанбаатар, Баянзүрх 19-р хороо Улаанбаатар, Баянзүрх, 19-р хороо БЗд 19 хороо тамирчний гудамж 53 бурамхан чихрийн үйлдвэрийн байр  88469837 	3	6500.00	0	9	f	0	2025-06-23 13:44:42.149+00	2025-06-25 05:54:49.781+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5273	2	90908821	Улаанбаатар, Баянзүрх 31-р хороо Монелийн 34-54 тоот Энэ дугаар луу залгаад хүргээд өгөөрэй 95164261	3	6500.00	0	9	f	0	2025-06-25 06:41:49.049+00	2025-07-07 10:18:24.237+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5277	2	96552699	Улаанбаатар, Сүхбаатар 10-р хороо Улаанбаатар, Сүхбаатар, 10-р хороо 100 ail haan  bank utas 96552699\n 	3	6500.00	0	9	f	0	2025-06-25 08:03:22.282+00	2025-06-26 12:50:10.68+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5274	2	95096446	Улаанбаатар, Хан-Уул 15-р хороо , Улаанбаатар, Хан-Уул, River Villa, 8/1-р орц, 14 давхар, 199 тоот River Villa, 8/1-р орц, 14 давхар, 199 тоот 95096446, 99612006	3	6500.00	0	6	f	0	2025-06-25 07:03:08.464+00	2025-06-26 11:02:38.072+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5279	15	95466499, 99022793	БЗД, 30-р хороо, 60-85 тоот 10 давхарт	3	126000.00	Өдрийн цагаар эзгүй	9	t	3	2025-06-25 09:18:47.397+00	2025-06-26 13:05:26.58+00	f	\N	\N	\N
5268	2	99975080	Улаанбаатар, Сүхбаатар 09-р хороо Есөн хишиг барилгын материалын дэлгүүр 2 давхар 2-1\n 99975080 , Хүргэлт ирхээс 1-2 цагын өмнө залгаж мэдэгднэ үү , баярлалаа\n	3	6500.00	0	\N	f	0	2025-06-25 02:34:27.413+00	2025-06-27 04:48:53.65+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5275	2	95096446	Улаанбаатар, Хан-Уул 15-р хороо , Улаанбаатар, Хан-Уул, River Villa, 8/1-р орц, 14 давхар, 199 тоот River Villa, 8/1-р орц, 14 давхар, 199 тоот 95096446, 99612006	3	6500.00	0	6	f	0	2025-06-25 07:03:51.958+00	2025-06-26 11:02:34.576+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5271	2	99021091	Улаанбаатар, Баянзүрх, 26-р хорооОлимп Хотхон 428-р Байр Olymp Hothon 428-R Bair, Olymp 428r bair 82 toot \n99021091 irhees umnu zalga	3	6500.00	0	12	f	0	2025-06-25 05:21:06.988+00	2025-06-30 06:07:17.123+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5266	2	88102515	Улаанбаатар, Баянзүрх, 26-р хорооGlobal park, Global park, B2 Block, 17th floor, 1705 	3	6500.00	0	12	f	0	2025-06-25 02:21:56.53+00	2025-06-26 06:42:45.865+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5272	2	91330509	Улаанбаатар, Сонгинохайрхан 29-р хороо Dragon Bus terminal 	3	6500.00	0	7	f	0	2025-06-25 05:47:17.916+00	2025-06-26 12:18:08.402+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6214	2	80704815	Улаанбаатар, Хан-Уул 18-р хороо tselmeg hothoniii baruuun taliiin hashaaa shine dur turh hothon 96r bair 3n davhr 8n toot\n bhq	3	6500.00	0	19	f	0	2025-08-10 05:31:16.009+00	2025-08-13 03:04:27.001+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5267	2	80779799	Улаанбаатар, Баянгол 13-р хороо Улаанбаатар, Баянгол, 13-р хороо Дако таувер Dako tower дако центр 3н давхар 309 тоот 	3	6500.00	0	\N	f	0	2025-06-25 02:25:47.181+00	2025-06-26 12:52:34.753+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6554	3	88064537	ete	1	0.00		\N	f	0	2025-08-20 14:53:38.462+00	2025-08-20 14:58:07.545+00	t	\N	\N	\N
6518	20	89322244	Shd 42 horoo odont 29-20a	3	1.00	a	22	t	14	2025-08-20 05:38:25.935+00	2025-08-23 07:38:12.958+00	f	\N	\N	\N
6505	35	80585221	Багануурт	5	19000.00	,	9	t	12	2025-08-20 03:59:48.867+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
5286	2	90096966	Улаанбаатар, Хан-Уул 08-р хороо Яармагийн 2, Нүхтийн зам өгсөөд Шүншиг вилла-3 241-1 3давхар 11тоот (2411#) 	3	6500.00	0	7	f	0	2025-06-25 13:41:20.159+00	2025-06-28 11:03:11.422+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5295	2	99109210	Улаанбаатар, Сонгинохайрхан 01-р хороо Улаанбаатар, Сонгинохайрхан, 1-р хороо test1234 	1	6500.00	0	\N	f	0	2025-06-26 04:19:15.062+00	2025-07-01 02:46:37.995+00	t	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5289	2	95496831	Улаанбаатар, Баянгол 20-р хороо 5 шарын нүхэн гарцаар гараад энхжин худалдааны төвөөр буцаж эргээд цагдаагийн хэлтэс өнгөрөөд ковш сэлбэг гэсэн модон хашаагаар урагшаа эргээд 48 байр 16 тоот 	3	6500.00	0	9	f	0	2025-06-25 15:25:26.726+00	2025-06-30 06:07:17.123+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5306	2	80882898	Улаанбаатар, Баянгол 26-р хороо Нарны Хороолол 7-р байр 2-р орц 10 давхарт 108тоот\n 	3	6500.00	0	6	f	0	2025-06-26 12:37:25.732+00	2025-06-29 08:43:51.751+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5304	3	80803767	24 bair 	3	6500.00	a	7	f	0	2025-06-26 10:50:08.815+00	2025-06-26 11:14:48.345+00	f	\N	\N	\N
5288	2	99119955	Улаанбаатар, Сүхбаатар 08-р хороо Улаанбаатар, Сүхбаатар, 8-р хороо 11хороолол, оюутны гудамж, 20 байр 2. Тоот 99119955 	3	6500.00	0	\N	f	0	2025-06-25 14:17:31.588+00	2025-06-30 06:06:06.049+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5293	2	80488616	Улаанбаатар, Хан-Уул 04-р хороо Арцатын 1-20тоот\nYarmag 1r buudal Carrefour ireed zalaghad bolno Yarmag 1r buudal Carrefour deer ireed zalga 80488616	3	6500.00	0	7	f	0	2025-06-26 03:42:20.963+00	2025-06-29 08:33:14.929+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5287	2	94005758	Улаанбаатар, Баянгол 13-р хороо Улаанбаатар, Баянгол, 13-р хороо Дако цэнтр 7 давхар 711 тоот 94005758 	3	6500.00	0	\N	f	0	2025-06-25 13:55:58.599+00	2025-07-01 01:44:41.753+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5290	2	95011008	Улаанбаатар, Сүхбаатар 11-р хороо цагдаагийн 64-54 тоот 	3	6500.00	0	4	f	0	2025-06-25 21:21:52.038+00	2025-06-27 07:45:33.553+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5296	2	88049707	Улаанбаатар, Сүхбаатар 09-р хороо 7 хороолол Алтайн гудамж 208 байр 12 тоот  	3	6500.00	0	4	f	0	2025-06-26 05:40:13.78+00	2025-06-27 08:55:53.115+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5298	2	88443839	Улаанбаатар, Хан-Уул 15-р хороо Solaris hothon 66/2 104toot\n 	3	6500.00	0	12	f	0	2025-06-26 06:25:24.071+00	2025-06-28 02:17:54.907+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5294	2	94496421	Улаанбаатар, Баянзүрх 16-р хороо , Улаанбаатар, Баянзүрх, 94496421 94496421 ирэхдээ утсаар ярина уу?	3	6500.00	0	9	f	0	2025-06-26 03:45:48.353+00	2025-06-30 06:07:17.123+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5285	2	94017085	Улаанбаатар, Баянзүрх 37-р хороо Serene town 82-6 , 2 orts , 71 toot\n Ortsnii kod #4257	3	6500.00	0	9	f	0	2025-06-25 13:19:24.556+00	2025-06-27 05:26:34.58+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5292	15	80185003	Sukhbaatar duurgiin 1-r khoroo Hayg: buyngiin zam daguu IC tower	3	76000.00	0	4	t	4	2025-06-26 02:19:20.219+00	2025-06-26 13:05:42.141+00	f	\N	\N	\N
5303	15	99070790	Han uul duureg 11r horoo zaisangin orgilin esreg tald bairlsn Electrolux gesen bichigtei bair 62r bair 1r orts 13r toot, code n 13b	3	1.00	America huns baraa gesn jijig delguur hajuud n bdg deeshee gardg jijig guurte	\N	f	0	2025-06-26 10:41:18.891+00	2025-06-27 04:55:33.331+00	f	\N	\N	\N
5302	2	95597557	Улаанбаатар, Хан-Уул, 18-р хорооХүннү стандарт хотхон 208-р байр, Хүннү-2222 208-р байр 1601 тоот 	3	6500.00	0	12	f	0	2025-06-26 07:58:01.845+00	2025-06-27 08:11:07.036+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5297	2	90073585	Улаанбаатар, Баянгол 24-р хороо Koyo town 54-1 bair 6 davhar 603 toot\n\n 	3	6500.00	0	6	f	0	2025-06-26 05:46:05.694+00	2025-06-27 10:47:10.066+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5305	2	80019821	Улаанбаатар, Баянзүрх, 3-р хороо48a bair, Orts 2, 19 toot, 7422# 	3	6500.00	0	9	f	0	2025-06-26 11:45:37.974+00	2025-06-27 05:26:34.58+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5190	2	96777737	Улаанбаатар, Хан-Уул 18-р хороо , Улаанбаатар, Хан-Уул, поларис-2 хотхон 292-р байр 1-р орц 1202 тоот поларис-2 хотхон 292-р байр 1-р орц 1202 тоот 	3	6500.00	0	\N	f	0	2025-06-21 02:22:46.377+00	2025-06-26 12:49:32.659+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5300	15	99251861	Дарханы унаанд тавьна	3	1.00	0	7	t	2	2025-06-26 07:17:11.345+00	2025-06-26 13:04:38.634+00	f	\N	\N	\N
5301	15	88224111	Хуучин Драгоноос Өвөрхангайн автобусанд тавих	3	1.00	0	7	t	2	2025-06-26 07:19:11.091+00	2025-06-26 13:04:38.634+00	f	\N	\N	\N
5299	2	94505050	Улаанбаатар, Сүхбаатар 08-р хороо Улаанбаатар, Сүхбаатар, 8-р хороо 14-2-и байр 28 тоот Хаяг: сбд, 8-р хороо, 14/2 и байр 2-р орц 2 давхар 28 тоот (багшийн дээд ҮЙ ЦАЙ сургуулийн хажууд)\nУтас: 94505050\nэнэ хаяган дээрээ Даваа-Баасан хүртэл байдаг шүү 	3	6500.00	0	\N	f	0	2025-06-26 06:44:07.459+00	2025-06-30 06:06:06.049+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6298	2	85755354	Улаанбаатар, Баянзүрх 01-р хороо Consul tower 79 байр 3-р орц 12-р давхар 208 тоот 	3	6500.00	0	9	f	0	2025-08-16 03:46:08.084+00	2025-08-22 05:15:16.552+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6215	2	95250618	Улаанбаатар, Баянгол 08-р хороо Хөгжил хотхоны гадаа ирээд залгах 	3	6500.00	0	9	f	0	2025-08-10 05:40:41.38+00	2025-08-21 04:48:15.507+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5200	2	89256700	Улаанбаатар, Баянзүрх 16-р хороо Ulgii gudamj, 4-65 Utas 89256700.\nOfficerin hoid taliin autobusnii buudlin batlan hamgaalahiin yamnii baruun talaar deeshe tultal yvad 69A gsn bairnii chiptei haalganii uudend ireed zalgachih, bayrllaa	3	6500.00	0	\N	f	0	2025-06-21 17:20:27.208+00	2025-06-26 12:49:32.659+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5208	2	94005758	Улаанбаатар, Баянгол 13-р хороо Улаанбаатар, Баянгол, 13-р хороо Дако цэнтр 7 давхар 711 тоот 94005758 	3	6500.00	0	\N	f	0	2025-06-23 06:17:57.55+00	2025-06-26 12:49:32.659+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5245	2	88998192	Улаанбаатар, Баянзүрх, 8-р хороо176 toot, 71a bair, Comfort town, БЗД 8-р хороо, Улаанхуарангийн эцэс Комфорт хотхон 71а, 11давхар, 176тоот, 1орцтой\n\nҮүдний код: #654123# Нярай хүүхэдтэй тул гарч авах боломжгүй	3	6500.00	0	9	f	0	2025-06-24 03:54:41.951+00	2025-06-26 12:50:10.68+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5269	2	88888023	Улаанбаатар, Баянзүрх 16-р хороо Улаанбаатар, Баянзүрх, 16-р хороо 72 хотхон аос 52 тоот Монмарт супермаркет залгаа 2 давхар шар байшин 72 хотхон дотор CU-тай 61 байрны баруун талд замын урд талдаа	3	6500.00	0	9	f	0	2025-06-25 03:11:43.093+00	2025-06-26 12:50:10.68+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5320	2	99168988	Улаанбаатар, Хан-Уул 24-р хороо Хан-уул дүүрэг 4 хороо Хүннү малл зүүн талд Хан-богд хотхон 202 байр ,2-р орц , 7давхар 94тоот,орц 5323#\n 	3	6500.00	0	7	f	0	2025-06-27 03:20:37.894+00	2025-06-28 12:42:53.913+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5309	15	99714813	БЗД 36-р хороо Emerald residence хотхон 501-р байр B1 давхар 2001 тоот	3	1.00	0	12	f	0	2025-06-26 13:58:05.404+00	2025-06-28 02:17:50.392+00	f	\N	\N	\N
5308	2	80290126	Улаанбаатар, Хан-Уул 24-р хороо Туул кондониум 109-р байр 15давхарт 69тоот\n Туул кондониум 109-р байр 15давхарт 69тоот	3	6500.00	0	7	f	0	2025-06-26 13:09:22.194+00	2025-06-29 11:10:36.998+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5321	15	 99355752	Эрдэнэтийн унаанд тавих	3	1.00	1	7	f	0	2025-06-27 03:39:59.442+00	2025-06-27 09:30:16.543+00	f	\N	\N	\N
5317	2	98118330	Улаанбаатар, Сонгинохайрхан 27-р хороо , Улаанбаатар, Сонгинохайрхан, орчлон 47 байр 82 тоот орчлон 47 байр 82 тоот 	3	6500.00	0	7	f	0	2025-06-27 00:23:31.868+00	2025-06-30 03:16:39.356+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5315	2	99044305	Улаанбаатар, Баянгол 06-р хороо БГД, 10-р хороолол, 25-р эмийн сан,  Орхон худалдааны төвийн 2 давхарт \nПүрэв гаригт амарна.\nОрой 8 цагт хаана. 	3	6500.00	0	9	f	0	2025-06-26 14:58:36.666+00	2025-07-07 10:18:24.237+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5314	2	88489977	Улаанбаатар, Баянгол 29-р хороо Эрин хороолол 53/12-р байр 1-р орц 2давхар 9тоот нэмэлт	3	6500.00	0	7	f	0	2025-06-26 14:49:34.072+00	2025-06-28 09:01:30.448+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5312	2	99792674	Улаанбаатар, Баянзүрх 38-р хороо 68 surguuliin urd 303 bair 51 toot 	3	6500.00	0	\N	f	0	2025-06-26 14:04:16.199+00	2025-06-30 06:06:06.049+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5311	15	86759986	Архангай аймгийн төв Эрдэнэбулган сум	3	1.00	0	7	f	0	2025-06-26 14:04:12.926+00	2025-06-27 10:22:49.693+00	f	\N	\N	\N
5310	2	86129222	Улаанбаатар, Сүхбаатар 08-р хороо River castle / B block 18 dawhar 1801 toot \nUlaanbaatar teatriin zuun tald 88129222 86709222 	3	6500.00	0	4	f	0	2025-06-26 14:01:50.346+00	2025-06-27 08:41:00.988+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5313	2	99987046	Улаанбаатар, Сүхбаатар, 2-р хорооАльфа цогцолбор, нарны зам дагуу Урбанек төвийн хашаа дотор Альфа цогцолбор 1 давхар харуулд үлдээж болно. 	3	6500.00	0	4	f	0	2025-06-26 14:10:44.153+00	2025-06-29 09:58:03.959+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5307	15	99373033	Дарханы унаанд тавих	3	1.00	1	7	f	0	2025-06-26 13:00:21.035+00	2025-06-27 09:30:26.049+00	f	\N	\N	\N
5319	2	99050470	Улаанбаатар, Хан-Уул 24-р хороо Хүннү вилла хотхон, 1403 байр, 6 давхар, 35 тоот 	3	6500.00	0	7	f	0	2025-06-27 02:30:45.535+00	2025-06-28 11:44:38.629+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5316	2	89999872	Улаанбаатар, Хан-Уул 02-р хороо ХУД 2-р хороо Ажилчдын соёлын ордны хажууд, KFC-тэй Морьтон 77а байрны 1-р орц\n7 давхар 703 тоот 	3	6500.00	0	6	f	0	2025-06-26 23:26:42.645+00	2025-06-27 11:21:29.559+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5322	2	90117748	Улаанбаатар, Хан-Уул 18-р хороо Google Map Moto House гэж хайгаад энэ байршлаар ирнэ үү. Хан-уул Имарт уулзварын урд Мото Хаус Мото граш \n 	3	6500.00	0	6	f	0	2025-06-27 03:58:12.435+00	2025-06-29 09:58:23.427+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6555	3	88064537	narnii horoolol	1	0.00		\N	f	0	2025-08-20 14:57:10.941+00	2025-08-20 14:58:07.545+00	t	\N	\N	\N
6263	15	99201012	Сүхбаатар 10-р хороо 15-18	3	1.00	1	29	t	10	2025-08-13 04:51:04.265+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
6622	35	86877980	налайх /хар/	5	28000.00		9	t	12	2025-08-21 03:54:30.69+00	2025-08-22 12:22:38.795+00	f	\N	\N	\N
6682	41	80042912	erdenet	1	0.00		\N	f	0	2025-08-22 03:18:31.514+00	2025-08-22 06:54:56.778+00	t	\N	\N	\N
6633	35	99380221	их наяд б1-65тоот 	3	19000.00		6	f	0	2025-08-21 04:16:19.7+00	2025-08-22 09:42:11.26+00	f	\N	\N	\N
6520	20	95517227	Dragon terminal	3	1.00	a	22	t	14	2025-08-20 05:38:46.894+00	2025-08-23 07:38:12.958+00	f	\N	\N	\N
5339	2	99792674	Улаанбаатар, Баянзүрх 38-р хороо 68 surguuliin urd 303 bair 51 toot Hurgeltiin hun irheese omno zalgaj asuugaarai guij bn ene bairshil deere hungu baij mgdgu ucraas asuugaarai	3	6500.00	0	9	f	0	2025-06-27 10:36:09.743+00	2025-06-30 06:07:17.123+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5259	2	88178107	Улаанбаатар, Сонгинохайрхан 42-р хороо Хайрханы 13-81а 	3	6500.00	0	7	f	0	2025-06-24 10:14:09.699+00	2025-06-27 11:57:28.991+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
5329	2	99696998	Улаанбаатар, Баянзүрх 26-р хороо Olymp hothon, 428, 2r orts,8, 112 toot 	3	6500.00	0	12	f	0	2025-06-27 06:17:07.809+00	2025-06-28 04:21:42.747+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5335	2	89004100	Улаанбаатар, Баянзүрх 26-р хороо Crystal town, 802 байр, 3 орц, 6 давхар, 607 тоот 	3	6500.00	0	12	f	0	2025-06-27 08:56:25.768+00	2025-06-28 04:52:57.158+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5431	2	94754643	Улаанбаатар, Хан-Уул 24-р хороо Global garden 1271-р байр 15 тоот 	3	6500.00	0	13	f	0	2025-07-01 08:00:42.9+00	2025-08-08 08:37:50.194+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5327	2	99067767	Улаанбаатар, Баянзүрх 26-р хороо Энканто молл 2 давхар Wowacc дэлгүүр  	3	12100.00	0	\N	f	0	2025-06-27 06:03:43.035+00	2025-06-30 06:06:06.049+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5337	2	80737389	Улаанбаатар, Хан-Уул 23-р хороо Nova vista business apartment 1458-р байр 2-р орц 1701 тоот 	3	6500.00	0	7	f	0	2025-06-27 09:37:46.01+00	2025-06-29 11:10:23.713+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5333	2	99050470	Улаанбаатар, Хан-Уул 24-р хороо Хүннү вилла хотхон, 1403 байр, 6 давхар, 35 тоот 	3	6500.00	0	7	f	0	2025-06-27 07:42:03.721+00	2025-06-28 12:43:07.477+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5325	2	85133399	Улаанбаатар, Баянзүрх, 26-р хорооSanto life 714, Santo life 714 2 orts 205 toot 	3	6500.00	0	12	f	0	2025-06-27 05:19:36.84+00	2025-06-28 04:52:52.83+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6264	15	99139907	Dornod aimag unaand tawiulna	3	1.00	1	9	f	0	2025-08-13 07:17:19.311+00	2025-08-14 11:02:06.249+00	f	\N	\N	\N
5343	2	99991375	Улаанбаатар, Баянгол 26-р хороо narnii horoolol 35A bair  	3	6500.00	0	6	f	0	2025-06-27 13:16:56.727+00	2025-06-29 09:42:46.897+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5291	2	89757562	Улаанбаатар, Хан-Уул 03-р хороо Дэлгэрэх хотхон 80/4 байр\n Гэр ажил 2 ойрхон тул, Ажлын цагаар хүргэлт хийвэл cosmo trade llc ажил дээрээ авна. Google map дээр cosmo trade гээд хайхаар гараад ирнэ шүү. Баярлалаа ☺️	3	6500.00	0	6	f	0	2025-06-25 23:33:06.22+00	2025-06-27 10:08:19.017+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5332	2	94204459	Улаанбаатар, Сүхбаатар 01-р хороо Gerege Tower, 14n davhar 	3	6500.00	0	4	f	0	2025-06-27 07:25:59.414+00	2025-07-01 10:11:54.276+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5334	2	99063011	Улаанбаатар, Хан-Уул 15-р хороо Vegacity 201 bair 14 in 1404  	3	6500.00	0	\N	f	0	2025-06-27 08:07:19.146+00	2025-07-02 02:42:05.385+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5326	2	96064142	Улаанбаатар, Хан-Уул, Тэлмүүн хотхон 43Б байр 1-р орц 11 давхар 106 тоот  Hurgeltees umnu zaaval yrix	3	6500.00	a	6	f	0	2025-06-27 06:03:39.531+00	2025-08-12 03:57:59.903+00	f	\N	\N	\N
5340	2	99827686	Улаанбаатар, Баянгол 02-р хороо Tumur zamiin deed surguuliin baruun taliin 47a bair 7 davhart 31 toot 	3	6500.00	0	7	f	0	2025-06-27 12:07:01.906+00	2025-06-30 04:45:28.465+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5342	15	99453558	Схд 37р хороо содон хороолол 104р байр 8 давхар 51 тоот	3	1.00	1	7	f	0	2025-06-27 13:12:17.345+00	2025-06-30 04:45:00.458+00	f	\N	\N	\N
6217	2	99936933	Улаанбаатар, Хан-Уул 08-р хороо Toirog niseh actuve garden 504-16dawhar121 	3	12100.00	0	\N	f	0	2025-08-10 12:48:35.433+00	2025-08-14 08:56:45.037+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5331	2	88088530	Улаанбаатар, Баянгол 01-р хороо 74-р байр \n 	3	6500.00	0	7	f	0	2025-06-27 06:23:57.691+00	2025-07-01 07:52:58.483+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5370	2	89757562	Улаанбаатар, Хан-Уул 03-р хороо Дэлгэрэх хотхон 80/4 байр\n 	3	6500.00	0	6	f	0	2025-06-29 01:02:18.944+00	2025-07-01 08:11:13.141+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5328	2	94846141	Улаанбаатар, Баянзүрх 26-р хороо olimp plaza pizza hut\n 	3	6500.00	0	12	f	0	2025-06-27 06:08:42.497+00	2025-06-28 04:30:11.948+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5341	2	95050902	Улаанбаатар, Хан-Уул 21-р хороо Buyntuhaa 2 horoolol 1002r bair 2 toot 	3	12100.00	0	7	f	0	2025-06-27 13:08:33.506+00	2025-06-29 08:22:00.992+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5336	2	94597000	Улаанбаатар, Баянгол 20-р хороо 738 4dawhar\n15toot 	3	6500.00	0	9	f	0	2025-06-27 09:05:59.146+00	2025-06-30 06:07:17.123+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5338	2	88602015	Улаанбаатар, Сонгинохайрхан 06-р хороо 6-р хороо хайрхан хорооолол 54а байр 89тоот 	3	12100.00	0	7	f	0	2025-06-27 10:29:09.307+00	2025-07-08 12:12:07.44+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5547	2	94101552	Улаанбаатар, Баянзүрх, 26-р хорооtime tower, Time tower 218-131 	3	6500.00	0	12	f	0	2025-07-04 07:11:16.962+00	2025-07-05 04:17:59.762+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5330	2	99013480	Улаанбаатар, Сүхбаатар 08-р хороо Танан төвийн ард МКМ-ийн 24р байр 1р орц 4 тоот 	3	6500.00	0	\N	f	0	2025-06-27 06:17:11.503+00	2025-07-19 13:14:33.36+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6311	2	86965896	Улаанбаатар, Баянзүрх 36-р хороо Их Монгол хороолол 903-р байр 1-р орц 5 давхар 32 тоот (Орцны код #9031) 	3	6500.00	0	22	f	0	2025-08-16 10:43:25.181+00	2025-08-20 05:01:45.984+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5359	2	99286969	Улаанбаатар, Баянзүрх 26-р хороо , Улаанбаатар, Баянзүрх, TrueL hothon 716 r bair 407 toot TrueL hothon 716 r bair 407 toot 	3	6500.00	0	12	f	0	2025-06-28 10:34:43.079+00	2025-06-29 12:04:21.113+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5348	2	95096446	Улаанбаатар, Хан-Уул 15-р хороо , Улаанбаатар, Хан-Уул, River Villa, 8/2-р орц, 10 давхар, 137 тоот River Villa, 8/2-р орц, 10 давхар, 137 тоот 99612006, 95096446	3	6500.00	0	6	f	0	2025-06-27 16:12:42.628+00	2025-07-01 10:39:24.816+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5356	2	94606399	Улаанбаатар, Сонгинохайрхан 29-р хороо 22а байр 19тоот 	3	6500.00	0	\N	f	0	2025-06-28 06:04:30.651+00	2025-07-18 06:05:06.812+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6300	2	86802821	Улаанбаатар, Хан-Уул 02-р хороо Саруул шилтгээн хотхон, В-2, 12 давхар 	1	6500.00	0	\N	f	0	2025-08-16 06:23:25.996+00	2025-08-16 06:23:26.008+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5365	2	88642629	Улаанбаатар, Хан-Уул 20-р хороо Khan Uul Toweriin urd taliin 32-r bair, Od hunsnii delguur 	3	6500.00	0	6	f	0	2025-06-28 14:26:34.08+00	2025-07-01 08:47:40.479+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5368	2	88012419	Улаанбаатар, Хан-Уул 01-р хороо 120 мянгат 21р байр 2р орц 22 тоо  	3	6500.00	0	12	f	0	2025-06-28 16:29:52.084+00	2025-07-01 09:14:38.876+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5353	2	91913369	Улаанбаатар, Сүхбаатар 10-р хороо 45 б байр 1-р давхар дүүрэн супермаркет 91913369 	3	6500.00	0	4	f	0	2025-06-28 04:06:05.918+00	2025-07-01 10:46:13.491+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5394	2	95690070	Улаанбаатар, Хан-Уул 12-р хороо ХУД- Био комбинат 53-17 Мөнх ундарам дэлгүүр утасны дугаар 9	3	6500.00	0	13	f	0	2025-06-30 03:11:29.843+00	2025-08-08 08:37:50.194+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6265	2	99719207	Улаанбаатар, Баянгол 05-р хороо Temuulel hothon 101-129toot 11davhar  	3	6500.00	0	\N	f	0	2025-08-13 08:09:10.222+00	2025-08-14 12:37:02.089+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5355	2	89310001	Улаанбаатар, Сонгинохайрхан 13-р хороо Улаанбаатар, Сонгинохайрхан, 13-р хороо 9р байр 4. 0 тоот оёдол гэсэн хаягтай цамбагаравын зүүн талд 89310001 	3	6500.00	0	7	f	0	2025-06-28 05:49:26.704+00	2025-07-01 11:36:19.302+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5354	2	88105643	Улаанбаатар, Хан-Уул 17-р хороо King tower 134-4-127 toot King tower 134-4-127	3	6500.00	0	\N	f	0	2025-06-28 05:04:37.182+00	2025-07-02 06:56:22.245+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5364	2	89221866	Улаанбаатар, Сүхбаатар 07-р хороо 11-р хороолол 39а байр 22 тоот.( хятад элчингийн зүүн тал шинэ гэмтлийн урд дүүрэн төвтэй улбар шар саарал барилга) 	3	6500.00	0	4	f	0	2025-06-28 13:52:45.82+00	2025-07-01 10:36:07.302+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5684	16	89040535	bgd 30r horoo 10r horoolol 18 bair 10toot	3	26000.00	a	18	f	0	2025-07-10 04:29:39.181+00	2025-07-10 16:25:31.629+00	f	\N	\N	\N
5358	2	86440409	Улаанбаатар, Баянгол 05-р хороо 10 хороолол 202-71 цоглог хотхон 10 хороолол 202-71	3	6500.00	0	7	f	0	2025-06-28 07:22:51.023+00	2025-07-01 13:16:56.145+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5349	2	99040606	Улаанбаатар, Баянзүрх 26-р хороо , Улаанбаатар, Баянзүрх, Nationalpark town Dunjingarav hudaldaa tuviin chanh urd Nationalpark town Dunjingarav hudaldaa tuviin chanh urd Nationalpark 502 bair 2orts 15davhar 1506	3	12100.00	0	7	f	0	2025-06-28 01:25:05.337+00	2025-07-01 02:46:03.038+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5347	2	99857935	Улаанбаатар, Баянгол 02-р хороо 2А байр 2-р орц 30 тоот 	3	6500.00	0	9	f	0	2025-06-27 16:09:39.614+00	2025-06-30 06:07:17.123+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5366	2	99393818	Улаанбаатар, Баянзүрх 13-р хороо Улаанбаатар, Баянзүрх, 13-р хороо Баянзүрх дүүргийн цагдаагийн газар гэсний 4 давхарт 99393818 	3	6500.00	0	9	f	0	2025-06-28 15:28:49.452+00	2025-07-07 10:18:24.237+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5350	2	88882350	Улаанбаатар, Хан-Уул 18-р хороо Улаанбаатар, Хан-Уул, 19-р хороо ХУД Зайсангийн 115р сургуулийн урд 57р байр 8тоот  	3	6500.00	0	\N	f	0	2025-06-28 02:51:12.348+00	2025-07-02 11:25:10.843+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5352	15	99114864	Хан уул дүүрэг Голден будда хотхон 4-7-17 тоот 	3	1.00	1	13	f	0	2025-06-28 03:41:51.46+00	2025-06-30 05:22:35.088+00	f	\N	\N	\N
5392	2	80755211	Улаанбаатар, Баянгол 29-р хороо хар хорин хороолол 55/15 10 давхар 48 тоот\n 	3	6500.00	0	7	f	0	2025-06-30 01:52:20.44+00	2025-07-02 04:47:22.685+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5363	2	80722229	Улаанбаатар, Хан-Уул 21-р хороо Нисэх Шүрт  хотхон  816 байр  2орц давхар 7давхар 114 тоот 	3	6500.00	0	\N	f	0	2025-06-28 13:14:46.71+00	2025-07-18 06:05:06.812+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5372	2	99659195	Улаанбаатар, Сонгинохайрхан, 29-р хорооМосква Шинэ апартмент, Москва апартмент 132-2байр  1301тоот 	3	6500.00	0	9	f	0	2025-06-29 03:54:28.875+00	2025-07-07 10:18:24.237+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
6266	2	88883043	Улаанбаатар, Сүхбаатар, 3-р хорооЮү Би Цэнтрал Рисайдэнс 27-р байр UB central residence 27-r bair, A block 11 davhar 88 toot 	3	6500.00	0	29	t	10	2025-08-13 08:52:03.628+00	2025-08-20 15:43:31.284+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5377	16	99046566 90086566\t	Урбанекийн хажууд Үзэсгэлэнт эмнэлэг	3	6000.00	hurgeltiin mungu avna shu	18	f	0	2025-06-29 03:58:11.772+00	2025-08-20 04:57:42.341+00	f	\N	\N	\N
5374	16	86615353	Niseh Polaris hothon 292/1-701 toot	3	6000.00	hurgeltiin mungu avna shu	7	f	0	2025-06-29 03:56:43.829+00	2025-06-29 08:54:45.793+00	f	\N	\N	\N
5381	2	99134936	Улаанбаатар, Сонгинохайрхан 06-р хороо Улаанбаатар, Сонгинохайрхан, 6-р хороо СХД-гийн 37р хороо содон хороолол 107–104тооь 	3	6500.00	0	7	f	0	2025-06-29 07:16:46.003+00	2025-07-01 10:39:26.016+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5388	2	95011008	Улаанбаатар, Сүхбаатар 11-р хороо цагдаагийн 64-54 тоот 	3	6500.00	0	4	f	0	2025-06-29 21:04:48.781+00	2025-07-01 11:14:00.81+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5379	15	89988106	Баянзүрх дүүрэг 32 хороо фунтик автобусны буудал дээр ирэхэд болно	3	1.00	1	9	f	0	2025-06-29 04:56:37.35+00	2025-07-01 16:52:24.799+00	f	\N	\N	\N
5378	16	99867085	Нисэх шүрт Хотхон 813-14 тоот	3	6000.00	hurgeltiin mungu avna shu	7	f	0	2025-06-29 03:58:39.013+00	2025-06-29 09:19:35.674+00	f	\N	\N	\N
5375	16	99557330	Хан уул эрэлийн байр 43-9 тоот	3	6000.00	hurgeltiin mungu avna shu	6	f	0	2025-06-29 03:57:16.535+00	2025-06-29 09:25:47.931+00	f	\N	\N	\N
5390	2	86060120	Улаанбаатар, Сүхбаатар 09-р хороо Улаанбаатар, Сүхбаатар, 9-р хороо СБДийн 9 хороо 7 хороолол 293 байр 52 тоот 	3	6500.00	0	4	f	0	2025-06-29 23:20:24.514+00	2025-07-01 10:55:10.516+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6219	2	90344431	Улаанбаатар, Чингэлтэй 23-р хороо Сурагчын 49-1150  96740218 дугаар луу залгана уу.	3	6500.00	0	\N	f	0	2025-08-11 01:12:12.808+00	2025-08-14 12:19:13.381+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5393	2	80019079	Улаанбаатар, Баянзүрх 26-р хороо Global park 712, 1705 	3	6500.00	0	12	f	0	2025-06-30 02:56:33.202+00	2025-07-02 11:40:46.023+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5389	2	86063605	Улаанбаатар, Сонгинохайрхан 08-р хороо Гүнжийн нүдэн нуур 1-р гудамж 14-р тоот 	3	6500.00	0	7	f	0	2025-06-29 23:12:43.36+00	2025-07-01 09:28:03.127+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5383	2	96505359	Улаанбаатар, Баянгол 27-р хороо Хермес-н эсрэг талын 4а байр 2-р орц 24 тоот 	3	6500.00	0	7	f	0	2025-06-29 08:51:01.166+00	2025-07-01 11:57:37.852+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5387	2	89310001	Улаанбаатар, Сонгинохайрхан 13-р хороо Улаанбаатар, Сонгинохайрхан, 13-р хороо 9р байр 4. 0 тоот оёдол гэсэн хаягтай цамбагаравын зүүн талд 89310001 Схд 13 хороо цамбагарав 9 4 0 тоот 89310001	3	6500.00	0	7	f	0	2025-06-29 14:30:25.866+00	2025-07-08 12:10:08.241+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5360	15	89187747	Бзд кино үйлдвэр 5р хороо хаппи таун 73-3-15-235 тоот	3	1.00	1	13	f	0	2025-06-28 10:45:48.079+00	2025-06-30 05:22:35.088+00	f	\N	\N	\N
5385	2	90208900	Улаанбаатар, Баянзүрх 22-р хороо Улаанбаатар, Баянзүрх, 22-р хороо Баянзүрх дүүргийн эсрэг талын автобусны буудлын яг хойно 16 давхар шинэ байр, баруун зүг харсан 1 орцтой, 5 давхарт, 25 тоот 	3	6500.00	0	9	f	0	2025-06-29 09:34:21.183+00	2025-07-07 10:18:24.237+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5344	2	99194081	Улаанбаатар, Баянзүрх 16-р хороо , Улаанбаатар, Баянзүрх, Мөнх худалдааны төв Munkh hudaldaanii tuv 99194081  Мөнх худалдааны төв Munkh hudaldaanii tuv 99194081  	3	6500.00	0	9	f	0	2025-06-27 13:51:11.059+00	2025-06-30 06:07:17.123+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5373	16	94995711	chd 6 50р сургуулийн баруун талд 21байр 18тоот	3	6000.00	hurgeltiin mungu avna shu	9	f	0	2025-06-29 03:56:15.96+00	2025-06-30 06:07:17.123+00	f	\N	\N	\N
5382	15	95118969	Dragon deer ochihoor baynhongoriin avtobus nd taviulchih ymaa 	3	1.00	1	7	f	0	2025-06-29 08:06:40.171+00	2025-06-30 14:43:54.501+00	f	\N	\N	\N
5371	2	95051521	Улаанбаатар, Сүхбаатар 01-р хороо , Улаанбаатар, Сүхбаатар, ЭМ ПИ ЭМ Оффис MPM Office  Натурын гүүр MPM office ЭМ ПИ ЭМ Оффис MPM Office  Натурын гүүр MPM office Ирэхээсээ өмнө залгаарай	3	6500.00	0	\N	f	0	2025-06-29 02:01:19.34+00	2025-07-18 06:05:06.812+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5376	16	99888007 99093712\t	HUD Villa verde hothon 112/3 bair 1012 toot	3	6000.00	hurgeltiin mungu avna shu	\N	f	0	2025-06-29 03:57:45.468+00	2025-06-30 14:15:43.211+00	f	\N	\N	\N
5380	15	99180572	Улаанхуаран Батлан хамгаалахын их сургууль. Маргааш 15 цагаас өмнө ажил дээрээ авч болох уу? .	3	1.00	1	9	f	0	2025-06-29 06:05:34.341+00	2025-06-30 14:16:00.744+00	f	\N	\N	\N
5384	15	99065787	Хаяг: Баянзүрх дүүрэг, 25-р хороо, Гангар-Орд хотхон 170с байр, 2-р орц, 12 давхарт 119 тоот	3	1.00	1	9	f	0	2025-06-29 08:54:29.369+00	2025-06-30 14:16:00.744+00	f	\N	\N	\N
5391	2	86640307	Улаанбаатар, Баянзүрх 19-р хороо Саруултэнгэр2 хотхон 102-р байр 1-р орц 10 давхар 44 тоот БЗД 19-хороо Саруултэнгэр 2 хотхон 102-р байр	3	6500.00	0	\N	f	0	2025-06-30 00:14:35.542+00	2025-07-18 06:05:06.812+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5401	2	85959278	Улаанбаатар, Баянгол 05-р хороо 3р эмнэлгийн байруун талд Найрамдал эмнэлэг 	3	6500.00	0	7	f	0	2025-06-30 07:02:14.84+00	2025-07-08 12:10:08.241+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5397	15	80220604	Хан-уул дүүрэг, 7-р хороо, жаргалантын 6 гудамж, 156 тоот	3	1.00	1	6	f	0	2025-06-30 04:43:43.564+00	2025-07-01 16:52:24.799+00	f	\N	\N	\N
5318	2	99007006	Улаанбаатар, Сүхбаатар, 7-р хорооӨвөрмонгол зочид буудал Uvurmongol zochid buudal, 21р байр 2 тоот Орцны код 5789#. \n3 давхарт 2 тоот. 99007006	3	12100.00	0	\N	f	0	2025-06-27 02:26:40.268+00	2025-06-30 06:06:06.049+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5323	2	86007187	Улаанбаатар, Баянгол 31-р хороо SHVVT hothon 55.2-7 toot 	3	6500.00	0	\N	f	0	2025-06-27 04:47:26.051+00	2025-06-30 06:06:06.049+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5324	2	99792674	Улаанбаатар, Баянзүрх 38-р хороо 68 surguuliin urd 303 bair 51 toot 	3	6500.00	0	\N	f	0	2025-06-27 05:14:13.345+00	2025-06-30 06:06:06.049+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5345	2	99447716	Улаанбаатар, Баянзүрх 17-р хороо Da huree zah Da huree zah	3	6500.00	0	9	f	0	2025-06-27 14:26:18.17+00	2025-06-30 06:07:17.123+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5362	2	88127243	Улаанбаатар, Сонгинохайрхан 03-р хороо Улаанбаатар, Сонгинохайрхан, 3-р хороо баганарангийн 18ийн 23 баганарнгийн 18ийн 23 	3	6500.00	0	9	f	0	2025-06-28 12:53:55.308+00	2025-06-30 06:07:17.123+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5357	2	99595747	Улаанбаатар, Баянзүрх 14-р хороо centrall mall -н арын байр 18б-215 тоот -99465615 зөвхөн 99465615 луу залгаарай	3	6500.00	0	9	f	0	2025-06-28 06:08:31.97+00	2025-06-30 06:07:17.123+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5351	2	96594445	Улаанбаатар, Сонгинохайрхан 26-р хороо Улаанбаатар, Сонгинохайрхан, 26-р хороо Mandal owoo 23 -19 toot 	3	6500.00	0	9	f	0	2025-06-28 03:19:31.324+00	2025-06-30 06:07:17.123+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6267	2	88683780	Улаанбаатар, Баянзүрх 16-р хороо Улаанбаатар хот баянзүрх дүүрэг 16-р хороо 49а байр 37 тоот\n Ирэхээсээ өмнө 1 цагийн өмнө залгах	3	6500.00	0	9	f	0	2025-08-13 09:35:20.307+00	2025-08-15 07:02:04.713+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6220	15	80103033	төрийн ордны зүүн хаалга 	3	1.00	1	4	f	0	2025-08-11 03:42:15.062+00	2025-08-12 01:03:55.672+00	f	\N	\N	\N
5399	2	99029476	Улаанбаатар, Баянзүрх 06-р хороо БЗД-13хороолол бөхийн өргөө баруун урд талд баянзүрх захын зүүн талд эрхэт 75 байр 	3	6500.00	0	\N	f	0	2025-06-30 06:18:07.549+00	2025-07-18 06:05:06.812+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5396	2	99615848	Улаанбаатар, Сүхбаатар 09-р хороо Улаанбаатар, Сүхбаатар, 9-р хороо Castle town 622-р байр 11н давхар 57 тоот  	3	6500.00	0	4	f	0	2025-06-30 04:19:31.847+00	2025-07-01 10:59:57.451+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6099	15	80024828	Баянзүрх дүүрэг, 36р хороо,  Баянмонгол 412	3	1.00	1	6	t	6	2025-08-01 08:16:00.472+00	2025-08-18 18:44:52.271+00	f	\N	\N	\N
5400	2	80582743	Улаанбаатар, Баянзүрх 26-р хороо may seven hotel 1davhar sakana restaurant  	3	6500.00	0	12	f	0	2025-06-30 06:46:12.502+00	2025-07-02 11:33:39.414+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6309	2	99510045	Улаанбаатар, Баянзүрх 03-р хороо Сансар Гарден хотхон 39/5 байр 2-р орц 24 давхарт 2403 тоот 	3	12100.00	0	9	f	0	2025-08-16 10:39:41.941+00	2025-08-17 08:11:30.898+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6102	17	94122149	ХУД, 15-р хороо, Хурд рапидын улаан байр 28-р байр, 191 тоот	3	90000.00	Үдээс өмнө 11,12с авья тэгээд аваад хөдөө гарах юм гэсэн. Орц нь кодгүй 	6	t	6	2025-08-01 09:27:03.266+00	2025-08-18 18:44:52.271+00	f	\N	\N	\N
5386	15	89014771	Баянгол 31р хороо ШҮҮТ хотхоны зүүн талд улбар шар, хар шилэн 47р байр 3-17 тоот	3	1.00	Ирэхээсээ өмнө ярихгү бол, эзэнгүй бж мэднэ. Ярьж бгаад ирэхгү бол, ажлын өдөр оройтож ажлаасаа ирэх юм.	7	f	0	2025-06-29 10:05:54.342+00	2025-06-30 14:43:54.501+00	f	\N	\N	\N
5405	2	99193929	Улаанбаатар, Баянзүрх 01-р хороо БЗД 1р хороо, Америк элчингийн зүүн талд, БарилгаМега стори, Сэлбэ апартмент 91-1-165тоот 88406080 99193929	3	12100.00	0	\N	f	0	2025-06-30 10:44:05.383+00	2025-07-18 06:05:06.812+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5404	2	85105019	Улаанбаатар, Хан-Уул 18-р хороо Токио Таун 1, 50Д байр, 2 давхар, 203 тоот Нэмэлт утас 99997206	3	12100.00	0	\N	f	0	2025-06-30 09:30:06.968+00	2025-07-02 02:52:06.349+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5402	15	99970223	Хуучин драгоноос Эрдэнэтийн автобусанд тавих	3	1.00	1	7	f	0	2025-06-30 07:03:57.475+00	2025-07-01 08:24:12.417+00	f	\N	\N	\N
5398	2	99929238	Улаанбаатар, Баянзүрх 08-р хороо Улаанбаатар, Баянзүрх, 8-р хороо Batanikiin etses 27 surguuliin hajuu taliin duuheetei bair 1 ortstoi 6 davhar 35 toot 	3	6500.00	0	9	f	0	2025-06-30 05:34:13.268+00	2025-07-07 10:18:24.237+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5403	2	80865251	аааа	3	6500.00	0	9	f	0	2025-06-30 08:58:36.354+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5429	2	80101666	Улаанбаатар, Баянзүрх 13-р хороо Улаанбаатар, Баянзүрх, 13-р хороо Кино үйлдвэр 82-52 тоот 	3	6500.00	0	9	f	0	2025-07-01 06:43:32.002+00	2025-07-07 10:18:24.237+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5412	2	86070125	Улаанбаатар, Сонгинохайрхан 01-р хороо Толгойт 7-70в 42р сургууль дээр ирээд залгах  	3	6500.00	0	7	f	0	2025-07-01 02:05:10.524+00	2025-07-08 12:10:08.241+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5407	2	95099429	Улаанбаатар, Хан-Уул 24-р хороо Temuuge Tsogtgerel, 976-95099429, Монгол улс\nУлаанбаатар Хан-Уул 24-р хороо Yarmag, Belmonte\ntower 12th floor "REMAX Eagle"/Яармаг, Бельмонте\nтаур 12 давхар, "REMAX Eagle" 	3	6500.00	0	13	f	0	2025-06-30 14:05:13.521+00	2025-08-08 08:37:50.194+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5413	2	99856054	Улаанбаатар, Баянгол 28-р хороо Энхтайвны өргөн чөлөө-125 Техник импорт ХК-ын байр Харуулд үлдээх	3	6500.00	0	9	f	0	2025-07-01 02:07:01.726+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6221	2	99228999	Улаанбаатар, Баянгол 08-р хороо Улаанбаатар, Баянгол, 8-р хороо БГДҮҮРЭГ 8-хороо 15-1 байр 12 давхар 62 тоот/К4 апартмент/ 	3	6500.00	0	9	f	0	2025-08-11 04:38:21.141+00	2025-08-12 04:25:42.966+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5411	2	86000595	Улаанбаатар, Хан-Уул 15-р хороо Solongos elchin saidiin yam ( haruul deer hurgej ogno uu) 	3	6500.00	0	6	f	0	2025-07-01 01:59:14.418+00	2025-07-02 12:10:41.031+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5410	2	88842290	Улаанбаатар, Хан-Уул, 1-р хороо41 bair 22 toot, Khan - Uul duureg, 1 khoroo, 41 bair 3 orts 22 toot 2 orts 22 toot 	3	6500.00	0	\N	f	0	2025-06-30 14:36:08.78+00	2025-07-18 06:05:06.812+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5408	2	80440045	Улаанбаатар, Хан-Уул 21-р хороо Нисэх шүрт хотхон 808 байр 3 давхарт 9 тоот 	3	6500.00	0	13	f	0	2025-06-30 14:10:20.044+00	2025-08-08 08:37:50.194+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5424	2	99245524	Улаанбаатар, Хан-Уул 21-р хороо Улаанбаатар, Хан-Уул, 21-р хороо Eagle town 426 байр 11-в тоот 	3	6500.00	0	13	f	0	2025-07-01 04:54:28.309+00	2025-08-08 08:37:50.194+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5415	2	99234747	Улаанбаатар, Баянзүрх 36-р хороо Bayanmongol residence 406-2r orts 3dawhar 43toot\n 	3	6500.00	0	\N	f	0	2025-07-01 02:52:30.649+00	2025-07-18 06:05:06.812+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5416	2	99188363	Улаанбаатар, Хан-Уул 23-р хороо , Улаанбаатар, Хан-Уул, Нүхт палас-1101 байр 077 тоот Нүхт палас-1101 байр 077 тоот Нүхт палас 1101 байр 77 тоот утас99188363	3	6500.00	0	\N	f	0	2025-07-01 03:38:50.928+00	2025-07-18 06:05:06.812+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5426	15	86002900	Налайхын унаанд тавиулах юм офицороос	3	1.00	1	9	f	0	2025-07-01 05:02:06.92+00	2025-07-03 06:07:14.443+00	f	\N	\N	\N
5414	2	86041475	Улаанбаатар, Баянзүрх 26-р хороо Parkside residence, 823-р байр, 2-р орц, 406 тоот 	3	6500.00	0	12	f	0	2025-07-01 02:25:38.91+00	2025-07-04 02:56:25.445+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5420	2	99822851	Улаанбаатар, Хан-Уул, 15-р хорооVega city hothon, Tara center, 102-р байр, 13 давхар, 1301 тоот\nОрц код - 1301 залгах\n 	3	6500.00	0	6	f	0	2025-07-01 04:06:27.977+00	2025-07-02 12:38:57.046+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6268	15	89806588	Hayag: BZD , 18 horoo, 14 r bair, 8 davhart 102 toot 	3	1.00	1	9	f	0	2025-08-13 11:15:53.396+00	2025-08-17 05:03:37.202+00	f	\N	\N	\N
5417	2	99506478	Улаанбаатар, Сонгинохайрхан 35-р хороо Орбит 61-05 тоот 	3	6500.00	0	9	f	0	2025-07-01 03:57:57.428+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5425	2	99092544	Улаанбаатар, Хан-Уул 17-р хороо Улаанбаатар, Хан-Уул, 17-р хороо King tower 122 байр, 1 орц, 8 давхарт, 117 тоот 	3	6500.00	0	13	f	0	2025-07-01 04:58:09.778+00	2025-08-08 08:37:50.194+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5421	2	99174514	Улаанбаатар, Сүхбаатар 10-р хороо 7-р хороолол 24-а байр 6-н давхар 21 тоот. 	3	6500.00	0	4	f	0	2025-07-01 04:45:14.201+00	2025-07-02 11:13:33.47+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6323	31	Бзд, Улаанхуаран эцэс, Шинн Амгалан хотхон, 520 байр, 1орц, 1 тоот  ( Тооцоо 64’000₮ авах) 	95104057	1	64000.00	й	\N	f	0	2025-08-17 03:36:03.902+00	2025-08-17 03:36:13.681+00	t	\N	\N	\N
5428	2	88092209	Улаанбаатар, Хан-Уул 24-р хороо Улаанбаатар, Хан-Уул, 24-р хороо VIP residence 479 bair hayaggu orts 3 davhar 6 doot 	3	6500.00	0	13	f	0	2025-07-01 06:02:15.226+00	2025-08-08 08:37:50.194+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6302	17	89806267	Цамбын 43р хороон дээр ирээд залгахад болно	3	76000.00	Ирэхдээ залгах өөр газар явж байж магадгүй гэсэн	9	f	0	2025-08-16 06:29:36.578+00	2025-08-17 06:57:03.465+00	f	\N	\N	\N
6341	2	88607771	Улаанбаатар, Баянгол 14-р хороо БГД, 16Р ХОРОО, гандангын уулзвар, туулын 1-26, 86221579 	1	6500.00	0	\N	f	0	2025-08-17 16:58:08.672+00	2025-08-17 16:58:08.685+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5284	2	80044412	Улаанбаатар, Сонгинохайрхан 24-р хороо баянхайрхан 10-9 	3	6500.00	0	7	f	0	2025-06-25 12:16:46.327+00	2025-07-01 09:27:16.423+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5409	2	99029476	Улаанбаатар, Баянзүрх 06-р хороо БЗД-13хороолол бөхийн өргөө баруун урд талд баянзүрх захын зүүн талд эрхэт 75 байр 	3	6500.00	0	4	f	0	2025-06-30 14:22:49.144+00	2025-07-02 10:49:58.573+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6269	2	95543388	Улаанбаатар, Баянзүрх 08-р хороо Ботаник, ус 15 хотхон 4-р байр 60 тоот 	3	6500.00	0	9	f	0	2025-08-13 13:33:57.675+00	2025-08-15 06:20:48.86+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5452	2	80922140	Улаанбаатар, Хан-Уул 08-р хороо Улаанбаатар, Хан-Уул, 8-р хороо Яармаг 8-р хороо сонсголон-22-750д тоот Яармаг Оргил супермаркетийн урдуур гарч баруун талаар нь хойшоо эргэсэн засмалаар эргээд 80922140 рүү залгах	3	6500.00	0	7	f	0	2025-07-01 16:03:13.342+00	2025-07-09 08:06:32.18+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5451	2	95050430	Улаанбаатар, Баянзүрх 02-р хороо Сүлд хотхон 21-2орц 11 давхар 74 тоот 	3	6500.00	0	9	f	0	2025-07-01 14:50:15.75+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5441	2	86228224	Улаанбаатар, Баянгол 24-р хороо Altai hothon 50b bair 14davhar 75toot\n 	3	6500.00	0	6	f	0	2025-07-01 10:21:35.258+00	2025-07-02 15:48:36.049+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5446	2	95050902	Улаанбаатар, Хан-Уул 21-р хороо Buyntuhaa 2 horoolol 1002r bair 2 toot 	3	6500.00	0	13	f	0	2025-07-01 12:17:30.183+00	2025-07-21 05:12:54.464+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5440	2	80582743	Улаанбаатар, Баянзүрх 26-р хороо may seven hotel 1davhar sakana restaurant  	3	6500.00	0	12	f	0	2025-07-01 10:15:47.895+00	2025-07-04 02:31:12.57+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5442	15	94171862	БЗД 4р хороо Американ дэнжийн хойно 48б байр 2р орц 15н тоот	3	1.00	1	9	f	0	2025-07-01 10:33:31.781+00	2025-07-02 13:48:06.251+00	f	\N	\N	\N
5437	2	80501717	Улаанбаатар, Хан-Уул 21-р хороо Шүрт хотхон, 812-р байр, flowers&gifts дэлгүүр 	3	12100.00	0	13	f	0	2025-07-01 09:56:46.936+00	2025-08-08 08:37:50.194+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5432	15	91812313	Драгоноос Говь-Алтайн 	3	1.00	1	7	f	0	2025-07-01 08:37:37.973+00	2025-07-02 13:48:27.296+00	f	\N	\N	\N
6222	2	99077854	Улаанбаатар, Сүхбаатар 03-р хороо Улаанбаатар, Сүхбаатар, 3-р хороо 5 р хороолол45-3 Наран малл н урд 5 давхар\n 	3	12100.00	0	\N	f	0	2025-08-11 04:47:01.51+00	2025-08-14 11:55:10.756+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6303	2	80991253	Улаанбаатар, Хан-Уул 18-р хороо Akademy 1 hothon 34 “Г” байр 1901\n 80991253 залгаарай 	1	6500.00	0	\N	f	0	2025-08-16 06:57:47.865+00	2025-08-16 06:57:47.881+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5449	2	88086787	Улаанбаатар, Баянгол, 8-р хороо9а Байр 9a Bair, 25 toot 9а байр байр биш шүү. 9б байр нь 1 орц 8 давхарт 29 тоот	3	6500.00	0	18	f	0	2025-07-01 14:23:14.124+00	2025-07-06 10:17:27.635+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5685	16	88068780	mandala garden 1480-86 toot	3	26000.00	a	18	f	0	2025-07-10 04:30:12.779+00	2025-07-10 16:25:55.327+00	f	\N	\N	\N
5436	2	80148610	Улаанбаатар, Чингэлтэй 06-р хороо Corporation tower 1311 	3	6500.00	0	4	f	0	2025-07-01 09:47:02.108+00	2025-07-04 09:55:34.968+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5717	15	88157905	Khan-uul duureg, 15r khoroo, kHan-uul emartaar baruun ergeed ywahad Vega city hothon	3	1.00	a	21	f	0	2025-07-11 12:53:56.443+00	2025-07-12 11:25:15.211+00	f	\N	\N	\N
6321	31	95988835	Бгд, 10 хороолол замын урд талдаа, Уран мотелтой залгаа 49.3 байр, 1 орц, 6 тоот  ( Тооцоо 35’000₮ авах ) 	5	35000.00	й	9	f	0	2025-08-17 03:35:09.069+00	2025-08-17 09:27:55.46+00	f	\N	\N	\N
6324	31	95104057	Бзд, Улаанхуаран эцэс, Шинн Амгалан хотхон, 520 байр, 1орц, 1 тоот  ( Тооцоо 64’000₮ авах) 	3	64000.00	й	9	f	0	2025-08-17 03:36:30.047+00	2025-08-17 14:55:44.179+00	f	\N	\N	\N
6304	2	80991253	Улаанбаатар, Хан-Уул 18-р хороо Akademy 1 hothon 34 “Г” байр 1901\n 80991253 залгаарай 	3	6500.00	0	19	f	0	2025-08-16 06:57:48.13+00	2025-08-25 08:30:55.003+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5445	2	86690420	Улаанбаатар, Сонгинохайрхан 18-р хороо Улаанбаатар, Сонгинохайрхан, 18-р хороо 48 байр  	3	6500.00	0	9	f	0	2025-07-01 12:10:24.495+00	2025-07-07 10:18:24.237+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6353	2	80433221	Улаанбаатар, Баянзүрх 08-р хороо Баганат хороолол 405-р байр 3давхар 77тоот \n Oroi 18tsagaas hoosh avna 	1	6500.00	0	\N	f	0	2025-08-18 05:26:29.938+00	2025-08-18 05:26:29.953+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5439	2	80190989	Улаанбаатар, Баянгол 01-р хороо Богд ар хороолол 10A байр 12 давхар 1202 тоот google map( Premium apartment) 	3	6500.00	0	\N	f	0	2025-07-01 10:01:46.839+00	2025-07-18 06:05:06.812+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5456	15	86823366	Хөвсгөл Мөрөнгийн унаанд тавих	3	1.00	1	7	f	0	2025-07-02 03:13:43.975+00	2025-07-02 13:48:06.251+00	f	\N	\N	\N
5444	2	99113394	Улаанбаатар, Хан-Уул 18-р хороо АКА-1 хотхон 34 г 902 	3	6500.00	0	\N	f	0	2025-07-01 11:43:51.502+00	2025-07-18 06:05:06.812+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5448	2	99830999	Улаанбаатар, Баянзүрх, 36-р хорооБаянмонгол хороолол 412 байр 3 орц 3 давхар 147 тоот, Орцны код #4123 	3	12100.00	0	\N	f	0	2025-07-01 13:58:26.963+00	2025-07-18 06:05:06.812+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5453	2	99103014	Улаанбаатар, Хан-Уул, 17-р хорооКинг тауэр, Кинг тауэр 121р баыр 1р орц 4 давхарт 112тоот 	3	6500.00	0	\N	f	0	2025-07-01 23:56:03.414+00	2025-07-18 06:05:06.812+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5454	2	88109681	Улаанбаатар, Хан-Уул 21-р хороо шүрт хотхон 817 байр 1 орц 7 давхар 37 тоот 	3	6500.00	0	\N	f	0	2025-07-02 03:07:44.639+00	2025-07-18 06:05:06.812+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5479	2	99805342	Улаанбаатар, Хан-Уул 02-р хороо Бадрах хотхон, 18-р байр, 8 давхар, 801 тоот Гархаасаа өмнө залгана уу	3	12100.00	0	\N	f	0	2025-07-02 08:10:12.713+00	2025-07-19 13:17:42.218+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5466	2	96112425	Улаанбаатар, Хан-Уул 21-р хороо Улаанбаатар, Хан-Уул, 21-р хороо Бунт ухаа 2 Буянт Ухаа2 1009,8давхар.47тоот 	3	6500.00	0	4	f	0	2025-07-02 04:44:39.672+00	2025-07-19 08:08:55.796+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5463	2	88100966	Улаанбаатар, Хан-Уул 23-р хороо Арцат 2 апартмент 1442 байр 1р орц 4давхар 15 тоот 	3	6500.00	0	\N	f	0	2025-07-02 04:35:37.283+00	2025-07-19 13:14:01.642+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6521	20	99590052	Erdenet	3	1.00	a	22	t	14	2025-08-20 05:38:59.437+00	2025-08-23 07:38:12.958+00	f	\N	\N	\N
5474	2	99626246	Улаанбаатар, Баянзүрх 14-р хороо jukowin urd buudal apple hotelin urd huree house 11dawhar shar bair 81A 4-16 toot kod *#5678/hoid talin orts/ 	3	6500.00	0	\N	f	0	2025-07-02 05:58:22.665+00	2025-07-19 13:15:29.027+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6223	2	99164567	Улаанбаатар, Сүхбаатар 11-р хороо 100n ail buudai tuv 7davhart coffee shop ajliin tsgaar\n 	4	6500.00	0	\N	f	0	2025-08-11 05:29:03.542+00	2025-08-14 12:18:17.453+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5467	2	96112425	Улаанбаатар, Хан-Уул 21-р хороо Улаанбаатар, Хан-Уул, 21-р хороо Бунт ухаа 2 Буянт Ухаа2 1009,8давхар.47тоот 	3	6500.00	0	7	f	0	2025-07-02 04:45:41.066+00	2025-07-09 08:06:47.519+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5423	2	86063605	Улаанбаатар, Сонгинохайрхан 08-р хороо Гүнжийн нүдэн нуур 1-р гудамж 14-р тоот 	3	6500.00	0	9	f	0	2025-07-01 04:54:08.151+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5465	17	99931623	Хан-Уул дүүрэг, 18-р хороо, japan town, C4 байр 7 давхар 701 тоот 	1	55000.00	Солонгос хүн учир англиар яриад өгч болно. Боломжгүй бол Монголоороо мсж бичих юм байна очихдоо	\N	f	0	2025-07-02 04:44:14.342+00	2025-07-02 06:31:51.488+00	t	\N	\N	\N
5464	17	99670904	Хан-Уул дүүрэг, 20-р хороо, мишээл expo, 84-р байр 	1	44000.00	Хүүхдийн загастай тоглоом 	\N	f	0	2025-07-02 04:38:38.174+00	2025-07-02 06:55:07.985+00	t	\N	\N	\N
5476	17	99670904	Хан-Уул дүүрэг, 20-р хороо, мишээл expo, 84-р байр	3	44000.00	хүүхдийн загастай тоглоом 	6	f	0	2025-07-02 06:56:19.895+00	2025-07-03 03:23:19.498+00	f	\N	\N	\N
6325	31	99124301	 Бгд, 10 хороолол, Happyness town, 109 байр 2 тоот  ( Тооцоо 35’000₮ авах)	3	35000.00	й	9	f	0	2025-08-17 03:37:02.095+00	2025-08-17 07:12:55.489+00	f	\N	\N	\N
5470	17	99931623	Хан-Уул дүүрэг, 18-р хороо, japan town, C4 байр 7 давхар 701 тоот	3	120000.00	Солонгос хүн учир англиар яриад өгч болно. Боломжгүй бол Монголоороо мсж бичих юм байна очихдоо	\N	f	0	2025-07-02 05:23:54.502+00	2025-07-02 09:07:21.484+00	f	\N	\N	\N
5471	17	94001184	БЗД, 26-р хороо, 722-р байр	3	38000.00	Цэцэрлэгт хүрээлэнгийн хойд талын байр. Ирээд залгахад гараад авна 	12	f	0	2025-07-02 05:28:13.565+00	2025-07-02 12:36:29.209+00	f	\N	\N	\N
5478	17	99242114	1р хороолол, хархорингийн хойд талын 40-р байр 	3	60000.00	Очоод залгахад болно хө 	9	f	0	2025-07-02 07:29:32.63+00	2025-07-03 12:30:41.715+00	f	\N	\N	\N
5475	15	99831576	Алтай хотхоны 27 байр, 7 давхарт, 40 тоот	3	1.00	1	6	f	0	2025-07-02 06:31:52.92+00	2025-07-02 15:51:07.34+00	f	\N	\N	\N
5477	17	94001462	барс захын баруун хойно. yulong restauran-тай байрны зүүн талын 12 давхар байр 	3	38000.00	Өдөр бол grand plaza гэсэн. Очхоосоо өмнө асуугаарай хө. гарч ирээд авна 	4	f	0	2025-07-02 06:59:11.697+00	2025-07-02 10:32:07.11+00	f	\N	\N	\N
5481	15	88094305	СБД, 8-р хороо, Оюутны гудамж, МКМ24-р байр, 2-р орц, 6-71	3	1.00	1	4	f	0	2025-07-02 08:42:31.847+00	2025-07-03 11:15:58.31+00	f	\N	\N	\N
5472	2	80831700	Улаанбаатар, Хан-Уул Bayn-zurh duureg 26-r horoo Sunny town 830r bair 1r orts 42 toot ireed zalgaarai	3	6500.00	0	12	f	0	2025-07-02 05:48:32.896+00	2025-07-04 02:46:42.08+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5686	16	99037530	hud duurgiin hajuud 32r bair 2r orts  2 davhart  141 toot	4	6000.00	a	18	f	0	2025-07-10 04:31:06.847+00	2025-07-11 14:09:39.238+00	f	\N	\N	\N
5460	2	99104929	Улаанбаатар, Баянзүрх 43-р хороо Натур төвийн урд 91/3 р байр 4 давхар 15 тоот 	3	6500.00	0	\N	f	0	2025-07-02 04:29:10.578+00	2025-07-18 06:05:06.812+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5461	2	99104929	Улаанбаатар, Баянзүрх 43-р хороо Натур төвийн урд 91/3 р байр 4 давхар 15 тоот 	3	6500.00	0	\N	f	0	2025-07-02 04:30:12.846+00	2025-07-18 06:05:06.812+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5462	2	88119815	Улаанбаатар, Баянгол 26-р хороо нарны хороолол 7 байр 4 орц 10 давхарт 220 тоот 	3	6500.00	0	\N	f	0	2025-07-02 04:31:42.255+00	2025-07-18 06:05:06.812+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6354	15	99821637	Сонгинохайрхан дүүрэг 16-р хороо 41Б байр 2 тоот Хаалганы код 2#102	3	1.00	1	22	f	0	2025-08-18 05:57:02.378+00	2025-08-20 07:45:18.601+00	f	\N	\N	\N
6556	24	88064537	test	1	12000.00	etet	\N	f	0	2025-08-20 14:57:52.204+00	2025-08-20 14:58:07.545+00	t	\N	\N	\N
6683	41	94775626	hentii umnudelger	3	0.00		44	f	0	2025-08-22 03:19:21.96+00	2025-08-23 07:12:53.143+00	f	\N	\N	\N
6270	2	99942846	Улаанбаатар, Баянгол 24-р хороо Алтай хотхон 10-р байр 42-тоот 	3	6500.00	0	6	f	0	2025-08-13 14:49:49.795+00	2025-08-22 07:06:16.893+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6659	41	80337272	bzd 25 horoo 40bair 3orts 68toot	3	46000.00		9	t	13	2025-08-22 02:14:08.497+00	2025-08-23 03:27:20.819+00	f	\N	\N	\N
6708	41	80042912	erdenet	3	0.00		37	f	0	2025-08-22 09:48:53.97+00	2025-08-22 11:18:39.561+00	f	\N	\N	\N
5486	2	99034625	Улаанбаатар, Хан-Уул 11-р хороо Маршалын гүүр Кинг Товер хотхон 143-1 2-давхар Syra Salon \n 99034625	3	17600.00	0	\N	f	0	2025-07-02 09:30:08.133+00	2025-07-19 13:18:41.913+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5489	2	99174700	Улаанбаатар, Хан-Уул 23-р хороо Улаанбаатар, Хан-Уул, 23-р хороо Яармаг.Garden city 1301-1-302. xaalgani kod #107301#\nUtas 99174700 	3	6500.00	0	\N	f	0	2025-07-02 10:31:13.408+00	2025-07-19 13:19:27.787+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5443	15	99263468	Улаанбаатарын вокзал дээр 99218943 Отгонбаатар нэртэй таксины жолоочид өгөөрэй. 99263468 миний дугаар	3	1.00	1	7	f	0	2025-07-01 11:34:15.652+00	2025-07-02 09:06:57.312+00	f	\N	\N	\N
5480	17	99912003	Дарханы унаанд тавих 	3	1.00	Унааны мэдээлэл явуулаад өгөөрэй. Баярлалаа 	7	f	0	2025-07-02 08:16:43.351+00	2025-07-02 09:06:57.312+00	f	\N	\N	\N
5490	2	80831700	Улаанбаатар, Хан-Уул Bayn-zurh duureg 26-r horoo Sunny town 830r bair 1r orts 42 toot ireed zalgaarai	3	6500.00	0	\N	f	0	2025-07-02 10:51:35.996+00	2025-07-19 13:20:36.036+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5494	2	99103014	Улаанбаатар, Хан-Уул, 17-р хорооКинг тауэр, Кинг тауэр 121р баыр 1р орц 4 давхарт 112тоот 	3	6500.00	0	\N	f	0	2025-07-02 10:59:58.16+00	2025-07-19 13:21:59.312+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5498	2	99830999	Улаанбаатар, Баянзүрх, 36-р хорооБаянмонгол хороолол 412 байр 3 орц 3 давхар 147 тоот, Орцны код #4123 	3	12100.00	0	\N	f	0	2025-07-02 11:32:53.96+00	2025-07-19 13:23:32.574+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5495	2	99645907	Улаанбаатар, Сонгинохайрхан 10-р хороо Зүүнбаян-Уул 8-9 	3	6500.00	0	\N	f	0	2025-07-02 11:01:43.646+00	2025-07-19 13:21:59.312+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6224	2	99792674	Улаанбаатар, Баянзүрх 38-р хороо 68 surguuliin urd 303 bair 51 toot 	1	6500.00	0	\N	f	0	2025-08-11 05:31:17.033+00	2025-08-11 05:31:17.045+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5524	2	99094833	Улаанбаатар, Хан-Уул 11-р хороо Улаанбаатар, Хан-Уул, 11-р хороо 112 ХУД 11 хороо villa verde hoth 	3	6500.00	0	\N	f	0	2025-07-03 08:56:23.648+00	2025-07-19 13:31:28.244+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5525	2	90003005	Улаанбаатар, Баянгол 24-р хороо Алтай хотхон 31 байр 2-р орц, 3 давхар 92 тоот 	3	6500.00	0	\N	f	0	2025-07-03 09:35:12.737+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5487	2	99748777	Улаанбаатар, Хан-Уул 06-р хороо Улаанбаатар, Хан-Уул, 6-р хороо Яармаг барилгын матриалийн зах 123- р павилон 	3	6500.00	0	7	f	0	2025-07-02 09:48:10.017+00	2025-07-08 13:24:58.661+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6306	2	95177457	Улаанбаатар, Хан-Уул 12-р хороо Хан уул дүүрэг 24-р хороо Belmonte хотхон 1227 Хан уул дүүрэг 24-р хороо Belmonte хотхон 1227	3	6500.00	0	29	f	0	2025-08-16 08:33:37.492+00	2025-08-21 14:58:48.358+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5483	2	99034472	Улаанбаатар, Баянгол 18-р хороо Элбэг их дэлгүүрийн урд 42 байрны 4-р орц 3 давхар 119 тоот 	3	6500.00	0	\N	f	0	2025-07-02 08:57:28.546+00	2025-07-19 13:17:42.218+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5500	2	95090692	Улаанбаатар, Сүхбаатар 11-р хороо Хангай хотхон 520-р байр 2-р орц 3 давхар 86 тоот 	3	6500.00	0	4	f	0	2025-07-02 12:27:50.672+00	2025-07-04 09:41:01.995+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5488	2	88939608	Улаанбаатар, Баянзүрх 38-р хороо , Улаанбаатар, Баянзүрх, баганат өргөө 451-3 тоот баганат өргөө 451-3 тоот ирэхээс өмнө заавал утсаар холбогдох	3	6500.00	0	\N	f	0	2025-07-02 10:17:40.826+00	2025-07-28 08:19:33.436+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5484	2	88422330	Улаанбаатар, Чингэлтэй 19-р хороо Чингэлтэй дүүрэг 19-р хороо зээлийн 1-13 Хүргэлтээр авах	3	12100.00	0	\N	f	0	2025-07-02 09:14:07.045+00	2025-07-19 13:18:13.886+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5499	2	89028781	Улаанбаатар, Чингэлтэй 05-р хороо Улаанбаатар, Чингэлтэй, 5-р хороо ЧД 9-ийн А байр 7 тоот.  	3	6500.00	0	4	f	0	2025-07-02 11:53:18.415+00	2025-07-04 10:03:44.679+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5485	2	88178107	Улаанбаатар, Сонгинохайрхан 42-р хороо Хайрханы 13-81а 	3	6500.00	0	\N	f	0	2025-07-02 09:25:18.54+00	2025-07-19 13:18:13.886+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
5493	2	99174151	Улаанбаатар, Баянзүрх 01-р хороо Сансарын тунел, Цэцэг зочид буудлын чанх хойно Сансар 23А байр, 29 тоот 	3	6500.00	0	9	f	0	2025-07-02 10:57:16.922+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6557	24	999999	a	1	0.00		\N	f	0	2025-08-20 15:18:06.354+00	2025-08-20 15:18:14.661+00	t	\N	\N	\N
6383	32	99889092	Зайсангийн эцэс Виллаж хотхон 103.5 тоот	3	39000.00	y	6	t	8	2025-08-18 16:43:20.202+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6660	41	95119646	haniin material etses	3	0.00		12	f	0	2025-08-22 02:14:59.897+00	2025-08-22 13:45:46.733+00	f	\N	\N	\N
6684	41	95331021	baynhongor	3	0.00		12	f	0	2025-08-22 03:19:45.092+00	2025-08-22 12:33:54.84+00	f	\N	\N	\N
6709	41	99444485	zuun kharaa	3	0.00		37	f	0	2025-08-22 09:49:18.511+00	2025-08-22 11:18:45.453+00	f	\N	\N	\N
5505	2	86119348	Улаанбаатар, Хан-Уул, 21-р хорооЭвэл апартмэнт, 436р байр 2р орц 3 давхар 314 	3	6500.00	0	\N	f	0	2025-07-03 01:11:55.608+00	2025-07-19 13:31:28.244+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5512	2	80126432	Улаанбаатар, Баянзүрх 11-р хороо Baynzvrhiin tovchoo denj 2 43toot 	3	6500.00	0	9	f	0	2025-07-03 04:11:53.035+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5504	2	85105019	Улаанбаатар, Хан-Уул 18-р хороо Токио Таун 1, 50Д байр, 2 давхар, 203 тоот Нэмэлт утас 99997206	3	12100.00	0	6	f	0	2025-07-03 01:08:19.203+00	2025-07-17 07:54:42.742+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5506	2	99092471	Улаанбаатар, Баянгол 03-р хороо Orgoo kino teatriin baruun tald 2б bairnii 2r orts 8 dawhar 65t 11500	3	6500.00	0	18	f	0	2025-07-03 01:39:56.266+00	2025-07-06 10:29:06.755+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5501	2	86688878	Улаанбаатар, Хан-Уул 23-р хороо Garden city хотхон, 1306 байр, 2-р орц, 105тоот. 105 залгах товчыг дарж холбогдох. Очихоосоо өмнө 99007737 дугаарлуу залгаж гэрт хүн байгаа эсэхийг мэдээрэй. Би өөрөө хөдөө явж байгаамаа. Баярлалаа  	3	12100.00	0	22	f	0	2025-07-02 13:14:03.801+00	2025-07-21 10:37:37.107+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6272	2	80996604	Улаанбаатар, Баянзүрх 21-р хороо Улаанбаатар, Баянзүрх, 21-р хороо Ганц худаг. 127р сургуулийн хойно 202р цэцэрлэгийн баруун гудамж. 	3	6500.00	0	9	f	0	2025-08-13 17:55:36.877+00	2025-08-15 13:11:09.08+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5503	2	95556953	Улаанбаатар, Хан-Уул 07-р хороо jargalantiin2_14\n 	3	6500.00	0	13	f	0	2025-07-02 23:53:23.437+00	2025-08-08 08:39:15.619+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6225	2	91198202	Улаанбаатар, Баянзүрх 40-р хороо Хос Сувд Хотхон, 79б байр 82 тоот 	3	6500.00	0	9	f	0	2025-08-11 06:32:23.862+00	2025-08-12 07:29:54.157+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5514	2	80504679	Улаанбаатар, Сүхбаатар 14-р хороо ulaanbaatar ih delguuriin zamiin esreg tald mquuen delguur ugluu 9 oroi 9 hurtel ajilah 	3	6500.00	0	4	f	0	2025-07-03 04:57:44.271+00	2025-07-07 12:31:26.799+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5517	2	99039504	Улаанбаатар, Сүхбаатар 01-р хороо Баянгол зочид буудлын чанх урд талд landmark office 6 давхар 602 тоот 	3	6500.00	0	4	f	0	2025-07-03 06:59:59.38+00	2025-07-07 12:31:22.365+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5522	2	89658003	Улаанбаатар, Баянзүрх 26-р хороо Баянмонгол залгаа саруул хороолол 122/4/1  Яархлтай 07/04	3	6500.00	0	12	f	0	2025-07-03 07:42:53.915+00	2025-07-05 04:18:57.718+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6283	2	99999584	Улаанбаатар, Баянзүрх 16-р хороо Улаанбаатар, Баянзүрх, 16-р хороо 72-r hothon 60-r bair A orts 34toot 99999584 	3	6500.00	0	9	f	0	2025-08-14 15:16:06.429+00	2025-08-17 14:16:55.369+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6327	31	95832121	Замын-Үүд унаанд  ( Тооцоо 64’000₮ авах )	5	64000.00	й	9	f	0	2025-08-17 03:37:47.443+00	2025-08-17 09:41:07.328+00	f	\N	\N	\N
5509	17	99168001	СБД, Twin tower-н баруун урд 31-р байр 4-р орц, 129 тоот	3	98000.00	Өдөрт нь хүргэх 	6	f	0	2025-07-03 02:08:26.585+00	2025-07-03 06:19:56.847+00	f	\N	\N	\N
5513	2	94622888	Улаанбаатар, Баянзүрх 26-р хороо Chuhag 2 hothon 601 r bair 1 orts 	3	6500.00	0	12	f	0	2025-07-03 04:32:41.131+00	2025-07-05 05:12:51.357+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6343	2	88171507	Улаанбаатар, Хан-Уул, 20-р хороо112-2-14 тоот, РиверВив, Үйлпвэрчний гудамж, Мишээл экспо зүүн урд 	3	6500.00	0	29	f	0	2025-08-18 00:59:49.419+00	2025-08-24 11:23:53.215+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6286	2	88115640	Улаанбаатар, Хан-Уул 18-р хороо Hunnu 2222 hothonii hoid zam daguu DREAMY DRINKS Bubble Tea zahiral Battur 	3	6500.00	0	19	f	0	2025-08-15 05:06:12.149+00	2025-08-18 06:05:55.916+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5502	2	99041399	Улаанбаатар, Сүхбаатар 07-р хороо , Улаанбаатар, Сүхбаатар, 39-р Байр 39-R Bair 39а-52 тоот Дүүрэн төвтэй байр 39-р Байр 39-R Bair 39а-52 тоот Дүүрэн төвтэй байр 	3	6500.00	0	\N	f	0	2025-07-02 23:26:58.247+00	2025-07-19 13:24:28.312+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6357	2	88504332	Улаанбаатар, Сонгинохайрхан 04-р хороо “Орчлон хороолол 2” 29-р байр 61тоот 	3	6500.00	0	12	f	0	2025-08-18 07:19:55.399+00	2025-08-22 13:19:29.763+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5526	17	99646964	Натурын зам дагуу гүүрний яг баруун хойно MPM office 	3	90000.00	07.04 ны 13:00цагаас өмнө хүргэлтээ авах хэрэгтэй байгаа гэсэн	9	f	0	2025-07-03 09:59:01.475+00	2025-07-05 02:23:55.628+00	f	\N	\N	\N
5516	15	99852424	Тэнгэр плазагаас Багануурлуу унаанд тавих	3	1.00	1	9	f	0	2025-07-03 05:53:31.975+00	2025-07-04 06:32:05.314+00	f	\N	\N	\N
5528	15	99361629	Орхон аймгийн унаанд тавих	3	1.00	1	9	f	0	2025-07-03 12:47:17.673+00	2025-07-04 09:53:53.509+00	f	\N	\N	\N
5507	2	80403880	Улаанбаатар, Чингэлтэй 12-р хороо Булгийн 3-199 80403880 эсвэл  өдрийн цагаар гэвэл Улсын нэгдүгээр төв эмнэлэг авна	3	6500.00	0	\N	f	0	2025-07-03 01:44:23.943+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5541	2	88997770	Улаанбаатар, Баянзүрх 26-р хороо Хомэ плаза төвийн 2давхарт шүдний эмнэлэг\n 	3	6500.00	0	13	f	0	2025-07-04 04:17:28.931+00	2025-08-08 08:39:15.619+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6338	2	94991867	Улаанбаатар, Хан-Уул 11-р хороо Zaisan Orgil hothon 6-3/ Grass avto ugaalgaar zuun ergene/ Grass avto ugaalgaar zuun ergene	3	6500.00	0	19	f	0	2025-08-17 13:05:25.525+00	2025-08-18 06:06:30.983+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5532	2	80833331	Улаанбаатар, Баянзүрх 07-р хороо Сансарын Home plaza замын урд талд Тайж буудай буудлын баруун гар талаар ороод 41 байр 2 орц 2 давхарт 27 тоот 80833331 	3	6500.00	0	9	f	0	2025-07-03 22:32:07.649+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6273	2	94331111	Улаанбаатар, Хан-Уул 18-р хороо gerlug vista 58.4 bair 903toot hurdan 	1	6500.00	0	\N	f	0	2025-08-14 02:37:14.748+00	2025-08-14 02:37:14.761+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6226	2	96000721	Улаанбаатар, Хан-Уул 10-р хороо Нисэх 7р байр 114тоот 88868567 96000721 нисэхийн 7р байр 8р орц 114тоот 	3	6500.00	0	\N	f	0	2025-08-11 07:36:08.877+00	2025-08-14 12:22:33.25+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6355	2	98117469	Улаанбаатар, Баянзүрх 12-р хороо Serene town 82/6 bair 3dawhar 16 toot\n 	3	6500.00	0	12	f	0	2025-08-18 06:34:04.696+00	2025-08-20 11:19:50.2+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5538	2	99825279	Улаанбаатар, Баянзүрх 26-р хороо Elizabeth khothon, 215r bair, 2r orts, 1201 toot 	2	6500.00	0	13	f	0	2025-07-04 02:57:39.139+00	2025-07-08 04:59:37.132+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5492	2	99591774	Улаанбаатар, Баянзүрх 26-р хороо Narlag urguu hothon 723 bair 12 davhart 45 toot Bairnii kod 72301#	3	6500.00	0	12	f	0	2025-07-02 10:54:01.261+00	2025-07-04 02:58:04.108+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5496	2	94622888	Улаанбаатар, Баянзүрх 26-р хороо Chuhag 2 hothon 601 r bair 1 orts 	3	6500.00	0	12	f	0	2025-07-02 11:18:16.47+00	2025-07-04 03:21:57.078+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6351	2	99151986	Улаанбаатар, Хан-Уул 08-р хороо , Улаанбаатар, Хан-Уул, Шинэ Яармаг  Жаргалант яармаг проперти ххк Шинэ Яармаг  Жаргалант яармаг проперти ххк 	1	6500.00	0	\N	f	0	2025-08-18 05:04:32.989+00	2025-08-18 05:04:33.001+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6307	2	99280433	Улаанбаатар, Сонгинохайрхан 10-р хороо Зүүнбаянуулын 26.5А  	3	6500.00	0	22	f	0	2025-08-16 09:04:34.546+00	2025-08-20 10:34:51.215+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6344	31	89113589	King tower 131 байр 148 тоот	3	705.00	Худ 17-р хороо төлбөр төлсөн	19	f	0	2025-08-18 02:35:07.488+00	2025-08-18 06:10:58.797+00	f	\N	\N	\N
6350	2	99112592	Улаанбаатар, Сүхбаатар 01-р хороо СБД. 1-р хороо. Хотын түргэн 103-ын замын баруун талын улаан тоосгон 6 давхар байр. 12-2 байр. 1-р орц. 8 тоот. Хаалганы код 8В Утас 99112592 Утас 99112592; 99772534	3	6500.00	0	37	f	0	2025-08-18 04:57:41.972+00	2025-08-22 11:18:48.835+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5546	15	88116226	Khan-uul дүүрэг Ikh Mongol State Street 4, HUD - 15 khoroo, Ulaanbaatar 17009  Их наяд зүүн өндөр хажууд байрлах River villa хотхон 8-3 тэгээд дөхөөд залгавал гараад авна аа хө	3	1.00	1	4	f	0	2025-07-04 06:37:33.975+00	2025-07-06 10:05:55.103+00	f	\N	\N	\N
5534	2	88434233	Улаанбаатар, Баянзүрх 19-р хороо Саруул тэнгэр2 хотхон 101р байр 110 тоот 	3	6500.00	0	9	f	0	2025-07-04 01:33:56.8+00	2025-07-08 12:15:57.947+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6328	17	99552229	yarmag toirog	3	43000.00	Очихдоо ярих 	22	f	0	2025-08-17 04:03:08.425+00	2025-08-19 06:08:06.627+00	f	\N	\N	\N
5537	15	99059217	Хан-Уул дүүрэг, 20-р хороо, Хан-Уул тауэрын урд талын 32-р байр, 153 тоот	3	1.00	1	4	f	0	2025-07-04 02:43:59.555+00	2025-07-04 10:36:45.009+00	f	\N	\N	\N
5530	2	99626246	Улаанбаатар, Баянзүрх 14-р хороо jukowin urd buudal apple hotelin urd huree house 11dawhar shar bair 81A 4-16 toot kod *#5678/hoid talin orts/ 	3	6500.00	0	\N	f	0	2025-07-03 14:26:57.234+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5531	2	85584547	Улаанбаатар, Хан-Уул 25-р хороо Дөрвөн бэрх 424 байр 104 тоот Iphiin omno zalgaarai 	3	6500.00	0	\N	f	0	2025-07-03 17:29:50.764+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5533	2	86108066	Улаанбаатар, Хан-Уул 05-р хороо Яармаг 3р буудал МТ клонкын ард талд улбар шар байр Хан Вилла 1орц 17 давхар 121 тоот 	3	6500.00	0	\N	f	0	2025-07-04 00:52:20.312+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5535	2	89028781	Улаанбаатар, Чингэлтэй 05-р хороо Улаанбаатар, Чингэлтэй, 5-р хороо ЧД 9-ийн А байр 7 тоот.  	3	6500.00	0	\N	f	0	2025-07-04 01:58:54.289+00	2025-07-19 13:31:28.244+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5536	2	89206769	Улаанбаатар, Сонгинохайрхан, 28-р хорооНогоон чулуут 6-15, Баян хошуу 112 н автобусны буудал 	3	6500.00	0	\N	f	0	2025-07-04 02:01:17.601+00	2025-07-19 13:31:28.244+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5548	2	99508649	Улаанбаатар, Баянгол 25-р хороо Улаанбаатар, Баянгол, 25-р хороо 12-р байр 8давхар 801 тоот Нарны замын 12-р байр 8давхар 801тоот Hermes төв В-03 павилонд хүргүүлнэ 94140371	3	6500.00	0	4	f	0	2025-07-04 07:16:18.287+00	2025-07-08 16:18:32.146+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5552	2	96109798	Улаанбаатар, Баянзүрх 01-р хороо Улаанбаатар, Баянзүрх, 1-р хороо Sansariin emart zamiin hoino royel castel hothon 102 bair 8davhart 801 90811100	3	6500.00	0	\N	f	0	2025-07-04 09:36:25.856+00	2025-07-19 13:31:28.244+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5549	2	99669066	Улаанбаатар, Хан-Уул 15-р хороо River villa 8/3 3 davhart 30 toot 	3	6500.00	0	6	f	0	2025-07-04 07:48:40.336+00	2025-07-17 07:54:42.742+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5554	2	80131446	Улаанбаатар, Хан-Уул 20-р хороо Мишээл экспогийн зүүн урд river view хотхог \nГ блок 2 давхар 10тоот код 1124# Яаралтай хүргээд өгч болох уу ? Үүдэнд ирээд заавал залгаарай. 	3	6500.00	0	\N	f	0	2025-07-04 11:35:36.478+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5539	15	99015342, 88037528	Hayg 13 horoolol natur zam daguu 14 bair 38 toot utas 99015342, 88037528	3	1.00	1	4	f	0	2025-07-04 03:14:23.697+00	2025-07-04 10:59:11.59+00	f	\N	\N	\N
5540	15	95337773	Тэнгэр плаза Дорнодруу унаанд тавих	3	1.00	1	4	f	0	2025-07-04 03:49:59.666+00	2025-07-04 11:13:51.89+00	f	\N	\N	\N
5562	2	99246855	Улаанбаатар, Хан-Уул 15-р хороо Global Town, 132B, 16, 1609 	3	12100.00	0	6	f	0	2025-07-05 04:55:10.226+00	2025-08-06 08:45:43.884+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6227	2	99239909	Улаанбаатар, Баянзүрх 22-р хороо Улаанбаатар, Баянзүрх, 22-р хороо Дэлгэрэх апартмент 99б 4 давхарт 3024 тоот 	3	6500.00	0	9	f	0	2025-08-11 07:58:33.196+00	2025-08-12 08:07:01.081+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5556	2	86051506	Улаанбаатар, Чингэлтэй 16-р хороо Улаанбаатар, Чингэлтэй, 16-р хороо согоотын 25-342 тоот\n\n 	3	6500.00	0	\N	f	0	2025-07-04 14:59:33.964+00	2025-07-19 13:31:28.244+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5561	2	80885809	Улаанбаатар, Баянгол 26-р хороо narnii horoolol 1-44 irhees omno yrih	3	12100.00	0	\N	f	0	2025-07-05 02:31:45.26+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5566	15	99632868	Sukhbaatar duureg ,11horoo,100ail irgenii burtgel medeelliin tuv 64r bair 40toot	3	1.00	Aris uvchim sudlaliin emnelegiin hajuud	4	f	0	2025-07-05 07:28:07.547+00	2025-07-06 10:05:55.103+00	f	\N	\N	\N
5553	17	99501442	Дарханы унаанд тавиулах 	1	1.00	Төлбөрийг авсан. Унаанд тавиад мэдээллийг нь явуулахад болно. Баярлалаа 	\N	f	0	2025-07-04 10:12:42.701+00	2025-07-05 02:24:04.303+00	t	\N	\N	\N
5558	2	85775537	Улаанбаатар, Сонгинохайрхан 40-р хороо bayanhoshuu toirog voyage usnii uildverees uragsh 3 gudam 12-r gudam tultal yavaad 36 toot\n 	3	6500.00	0	9	f	0	2025-07-04 17:05:03.213+00	2025-07-07 10:18:24.237+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6299	2	94645656	Улаанбаатар, Баянзүрх 02-р хороо Сансарын тойрог Мамбадацан эмнэлэг 	3	6500.00	0	9	f	0	2025-08-16 05:29:36.019+00	2025-08-17 13:07:31.133+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5508	2	99585934	Улаанбаатар, Баянзүрх 36-р хороо Улаанбаатар, Баянзүрх, 36-р хороо Эмералд хотхон 511 байр 2орц 11давхарт 1104 тоот Эмеаралд хотхон 511 байр 11 давхар 2орц 1104 тоот 	3	6500.00	0	12	f	0	2025-07-03 01:48:10.549+00	2025-07-05 04:38:29.9+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5551	2	95805115 99265115	Улаанбаатар, Хан-Уул 15-р хороо Оддын Хотхон 37а Байр Oddiin Hothon 37a Bair, 37a bair 5davhart 10toot \ncode:#9307\ngert hungu bvl haalgani hajuud uldeegeed yvhad blno huren ungu  yg shatnii baruun taliin haalgani devsger deer uldeehed blno  	3	6500.00	0	6	f	0	2025-07-04 09:19:38.6+00	2025-07-17 07:54:42.742+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5550	2	91915156	Улаанбаатар, Хан-Уул 18-р хороо Хан-Уул дүүрэг 19-р хороо Дөл хотхон 97Г Байр 2 тоот 99355401, 99907823 	3	6500.00	0	21	f	0	2025-07-04 07:57:24.04+00	2025-07-15 10:16:15.666+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5564	2	98140511	Улаанбаатар, Хан-Уул 11-р хороо Он н Офф Продакшн Хаус 1 давхарт харуул дээр үлдээнэ 	3	6500.00	0	21	f	0	2025-07-05 06:35:06.17+00	2025-07-12 11:41:22.061+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6345	31	89894779	Их наядын урд Саруул хороолол 118- р байр 1р орц 6 тоот	3	35000.00	тооцоо авна	22	f	0	2025-08-18 02:38:54.924+00	2025-08-18 15:30:03.335+00	f	\N	\N	\N
5565	2	99658436	Улаанбаатар, Баянзүрх 26-р хороо Хүннүгийн гудамж, Time tower хотхон, 218-р байр, 2р орц, код:1802#, 8давхар, 108 тоот 	3	6500.00	0	\N	f	0	2025-07-05 07:10:25.697+00	2025-07-09 13:41:05.36+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5559	17	99501442	Дарханы унаанд тавих	3	2.00	Төлбөрөө төлсөн учир унаанд тавиад мэдээллийг нь явуулахад болно. Баярлалаа	9	f	0	2025-07-05 02:25:38.279+00	2025-07-06 01:10:34.308+00	f	\N	\N	\N
5560	17	80061268	21-р хороолол 8а байр 53 тоот 	3	44000.00	38,0+6,0=44.0 очихдоо залгах 	9	f	0	2025-07-05 02:27:18.98+00	2025-07-06 01:10:34.308+00	f	\N	\N	\N
5563	2	99246855	Улаанбаатар, Хан-Уул 15-р хороо Global Town, 132B, 16, 1609 	3	12100.00	0	6	f	0	2025-07-05 04:55:48.376+00	2025-07-17 07:54:42.742+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5588	2	99099578	Улаанбаатар, Сүхбаатар 02-р хороо Shine tugul hothon 19c Bair 59 toot 99099578, 	5	12100.00	0	\N	f	0	2025-07-07 06:31:47.699+00	2025-07-22 10:34:14.677+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5586	15	88003619	ХУД, 19-р хороо, 52р байр 59	3	1.00	Хан-уул дүүргээс урагш, улаанбаатар сувиллын баруун талын байр	19	f	0	2025-07-07 05:48:40.358+00	2025-07-08 13:58:26.446+00	f	\N	\N	\N
5572	2	88508828	Улаанбаатар, Баянзүрх 38-р хороо BZD 38r horoo awto onoshilgoonii towin hajuud hilchnii gudamj garden residence 428-127 \n https://maps.app.goo.gl/4FfTSozqb659Qow49?g_st=ic	3	6500.00	0	9	f	0	2025-07-06 10:27:02.666+00	2025-07-08 12:16:08.54+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6228	2	80704815	Улаанбаатар, Хан-Уул 18-р хороо tselmeg hothoniii baruuun taliiin hashaaa shine dur turh hothon 96r bair 3n davhr 8n toot\n Ortsnii kod 1247#	3	6500.00	0	19	f	0	2025-08-11 09:20:26.771+00	2025-08-15 04:22:31.976+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5581	2	88054539	Улаанбаатар, Хан-Уул 23-р хороо Арвай вилла хотхон 737-р бар 2-р орц 10д 153 тоот\n 	3	6500.00	0	22	f	0	2025-07-07 03:10:25.232+00	2025-07-21 09:54:36.319+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5570	2	91119318	Улаанбаатар, Баянзүрх 06-р хороо Бөхийн өргөө 75р байр2 орц 6 давхар 83 тоот баянзүрх захын зүүн талд  	3	12100.00	0	\N	f	0	2025-07-06 09:21:49.6+00	2025-07-19 13:31:28.244+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5582	17	99125128	Дэнжийн манга, шинэчлэл хороолол	3	76000.00	2 төрлийн sequence 	4	f	0	2025-07-07 04:15:02.842+00	2025-07-07 14:03:12.309+00	f	\N	\N	\N
5576	17	99051057	нарны хороолол , 4-р байр , 10 давхар, 170тоот *#1951	3	43000.00	38.0+5.0=43.0	6	f	0	2025-07-06 12:48:53.979+00	2025-07-07 13:50:12.333+00	f	\N	\N	\N
5574	15	88031083	altai hothonii urd gerlen dohiotoi uulzwar deer hongor apartment 2r orts 11davhart 114toot ortsnii kod 114#114 han-uul duureg 3r horoo 	3	1.00	1	6	f	0	2025-07-06 12:06:10.414+00	2025-07-07 13:49:42.944+00	f	\N	\N	\N
5569	15	80240311	Худ 3-р хороо 61-р байр 2р орц 1 давхарт 21тоот (нарны гүүр алтай хотхоны уулзварын баруун талд, шутисын механик инженерийн сургуулийн зүүн талд 5давхар шар байшин)	3	1.00	1	6	f	0	2025-07-06 05:51:28.396+00	2025-07-07 13:56:45.485+00	f	\N	\N	\N
5575	17	85553370	Хорооллйын бичилд	3	90000.00	өр хүн захиад энэ хүнд хүргээд өгөөрэй гэсэн болхоор очихдоо залгаарай хө. Баярлалаа 	6	f	0	2025-07-06 12:47:05.015+00	2025-07-07 15:00:14.979+00	f	\N	\N	\N
5578	17	88891809	Яармаг, Хангарьд сити 2-р хороолол, 1552-р байр 1-р орц 10н давхар, 37 тоот 	3	94000.00	Дундын катан нь trade build 	\N	f	0	2025-07-07 00:57:22.68+00	2025-07-07 15:01:02.641+00	f	\N	\N	\N
5585	15	95112410	БГД 20-р хороо БХН 48 байр 16 тоот	3	1.00	1	7	f	0	2025-07-07 05:18:58.035+00	2025-07-10 07:53:58.135+00	f	\N	\N	\N
6308	2	95829338	Улаанбаатар, Сүхбаатар 08-р хороо Улаанбаатар, Сүхбаатар, 8-р хороо багшийн хөгжлийн ордон 1-р давхарт 3 дугаар эмнэлэгийн урд талын зогсоол мөнгөн чагнуур эмнэлэг	1	6500.00	0	\N	f	0	2025-08-16 09:10:29.645+00	2025-08-16 09:10:29.66+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5580	15	99909629, 99898522	Дарханы унаанд тавих	3	1.00	1	4	f	0	2025-07-07 03:08:15.451+00	2025-07-07 12:44:51.742+00	f	\N	\N	\N
5590	15	95828203	Bzd 1 horoo sansrin evtei dorvn amitn, 22r bair	3	1.00	1	9	f	0	2025-07-07 08:57:09.289+00	2025-07-08 10:33:17.616+00	f	\N	\N	\N
5583	17	80857715	Khan tower 	3	90000.00	6 хүртэл Хаан товер дээрээ байна гэсэн. Очихдоо холбогдоорой баярлалаа 	4	f	0	2025-07-07 04:22:41.921+00	2025-07-07 13:19:57.741+00	f	\N	\N	\N
5459	2	89160107	Хөвсгөл, Мөрөн сум , Хөвсгөл, Мөрөн сум, 13-47-8  13-47-8  Xowsgol Moron Mron sum 89160107	3	6500.00	0	9	f	0	2025-07-02 04:14:27.925+00	2025-07-07 10:18:24.237+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5361	2	99042396	Улаанбаатар, Баянзүрх 41-р хороо Ромео Жульетта хотхон 46Б байр 15 давхарт 125 тоот  	3	6500.00	0	9	f	0	2025-06-28 11:18:28.568+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5395	2	99047496	Улаанбаатар, Баянзүрх 25-р хороо , Улаанбаатар, Баянзүрх, 123-р байр 47 тоот 123-р байр 47 тоот Хаягаар очихдоо 99167263 руу яриарай. 	3	6500.00	0	9	f	0	2025-06-30 03:12:02.846+00	2025-07-07 10:18:24.237+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5584	17	99001155	Santo life хүтхүн 713-р байр 1-р орц, 22-2202 тоот 	3	29000.00	Өнөөдөр хүргээд өгвөл их сайн байна. Баярлалаа	12	f	0	2025-07-07 04:57:17.567+00	2025-07-08 07:02:33.752+00	f	\N	\N	\N
5579	2	88109681	Улаанбаатар, Хан-Уул 21-р хороо шүрт хотхон 817 байр 1 орц 7 давхар 37 тоот 	3	6500.00	0	7	f	0	2025-07-07 02:37:00.256+00	2025-07-09 08:07:05.066+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5587	2	99103611	Улаанбаатар, Хан-Уул 18-р хороо Хүннү2222 хороолол, 110-р байр, 602 тоот, 99103611 	3	6500.00	0	12	f	0	2025-07-07 06:27:31.273+00	2025-07-08 06:34:59.015+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5568	2	85202911	Улаанбаатар, Хан-Уул 24-р хороо Яармаг Хүннү молл замын урд талд Твин Товер 52-401   85202911 	3	6500.00	0	7	f	0	2025-07-06 04:53:23.04+00	2025-07-08 14:09:09.566+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5573	2	88883043	Улаанбаатар, Сүхбаатар, 3-р хорооЮү Би Цэнтрал Рисайдэнс 27-р байр UB central residence 27-r bair, A block 11 davhar 88 toot 	3	6500.00	0	4	f	0	2025-07-06 11:18:22.369+00	2025-07-08 13:20:57.96+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6358	32	99999999	test123	1	10000.00	a	\N	f	0	2025-08-18 07:22:16.751+00	2025-08-18 07:43:40.545+00	t	\N	\N	\N
5427	2	89700584	Улаанбаатар, Баянзүрх 38-р хороо Баганат хотхон, 471-байр, 71 тоот Гоё дэлгүүрийн өөдөөс харсан хажуудаа хогийн букертай байр	3	6500.00	0	9	f	0	2025-07-01 05:44:24.439+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5419	2	80865251	Улаанбаатар, Баянзүрх 30-р хороо Доржийн гудамж 28/5 байр 2орц 2давхар 81тоот 	3	6500.00	0	9	f	0	2025-07-01 04:00:55.149+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5418	2	91861004	Улаанбаатар, Баянзүрх 24-р хороо Цахлай 13-28 Da huree haan bank ogsood zalgah	3	6500.00	0	9	f	0	2025-07-01 03:59:22.817+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5450	2	86014628	Улаанбаатар, Сонгинохайрхан 29-р хороо москва аппарт мед 132-4 байр\n701 тоот 	3	6500.00	0	9	f	0	2025-07-01 14:49:43.817+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5435	2	96662064	Улаанбаатар, Баянзүрх 39-р хороо X apertment2 11 dawhar 88 toot  96662064	3	6500.00	0	9	f	0	2025-07-01 09:45:52.073+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5447	2	99626246	Улаанбаатар, Баянзүрх 14-р хороо jukowin urd buudal apple hotelin urd huree house 11dawhar shar bair 81A 4-16 toot kod *#5678/hoid talin orts/ 	3	6500.00	0	9	f	0	2025-07-01 13:30:49.782+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5438	2	91540509	Улаанбаатар, Сонгинохайрхан 39-р хороо Улаанбаатар, Сонгинохайрхан, 39-р хороо Схд 39-р хороо хангай 63гудамж 10а тоот  	3	6500.00	0	9	f	0	2025-07-01 09:57:35.66+00	2025-07-07 10:18:24.237+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5468	2	99904656	Улаанбаатар, Баянзүрх 31-р хороо monel 19r gudam 441 toot 	3	6500.00	0	9	f	0	2025-07-02 05:07:47.478+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5473	2	99141241	Улаанбаатар, Баянгол 02-р хороо kfc-ийн хойно 44р байр 6 давхар 23 тоот орцны код 234В хойшоо харсан ганц орцтой 	3	6500.00	0	9	f	0	2025-07-02 05:55:31.904+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5469	2	99005893	Улаанбаатар, Сүхбаатар 09-р хороо Улаанбаатар, Сүхбаатар, 9-р хороо хоймор оффисын ард 98 айлын байр 70 тоот  Дөлгөөн нуур Хоймор офисс ард 278 р байр 11.70 тоот	3	6500.00	0	9	f	0	2025-07-02 05:20:23.394+00	2025-07-07 10:18:24.237+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5482	2	88191874	Улаанбаатар, Баянзүрх 42-р хороо Нарт хотхон 2 94в байр 2-р орц 7 давхар 95тоот 	3	6500.00	0	9	f	0	2025-07-02 08:47:00.197+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5497	2	99646524	Улаанбаатар, Сонгинохайрхан 05-р хороо Ханын материалаас дээшээ Ган хийцийн замд сүүлд баригдсан 2 ихэр шар улаантай байр 99646524 	3	6500.00	0	9	f	0	2025-07-02 11:18:38.731+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5523	2	90313240	Улаанбаатар, Сүхбаатар Гэгээн Өргөө 2 , 10 давхар , 1005 тоот\nhttps://maps.app.goo.gl/EA1va426qBWrzwRA7?g_st=ipc 	3	6500.00	0	9	f	0	2025-07-03 08:24:24.762+00	2025-07-07 10:18:24.237+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5434	2	88353113	Улаанбаатар, Сонгинохайрхан 01-р хороо 34р байрны 34р гүүр гараад эрчим худалдааны төвийн цайны газарт Улаанбаатар сонгинохайрхан дүүрэг 1р хороо 34р байрны 34р гүүр гараад эрчим худалдааны төвийн цайны газарт	3	6500.00	0	9	f	0	2025-07-01 09:29:05.269+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5422	2	89310001	Улаанбаатар, Сонгинохайрхан 13-р хороо Улаанбаатар, Сонгинохайрхан, 13-р хороо 9р байр 4. 0 тоот оёдол гэсэн хаягтай цамбагаравын зүүн талд 89310001 	3	6500.00	0	9	f	0	2025-07-01 04:46:05.713+00	2025-07-07 10:18:24.237+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5518	2	86070125	Улаанбаатар, Сонгинохайрхан 01-р хороо Толгойт 7-70в 42р сургууль дээр ирээд залгах  	3	6500.00	0	9	f	0	2025-07-03 07:01:06.301+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5545	2	88649838	Улаанбаатар, Баянзүрх 14-р хороо 14р хороо Жаст хотхоны яг хажууд Хөгжил хотхон 50р байр 12давхар 73тоот. Орцны код 4780# 	3	6500.00	0	9	f	0	2025-07-04 05:21:07.51+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5529	2	89698922	Улаанбаатар, Баянзүрх 14-р хороо 70-р байр 7 давхар 32 тоот 88926337 руу залгана уу? хүргэлт очих газар	3	6500.00	0	9	f	0	2025-07-03 13:18:06.546+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5544	2	99623940	Улаанбаатар, Сүхбаатар 11-р хороо Hangai hothonii zuun tald 310 bair 2 Orts 10 dawhar 185 toot ortsnii kod 1990# 	3	6500.00	0	9	f	0	2025-07-04 05:07:45.776+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6363	2	86916968	hud 23 horoo shunshig villa 2 hothon  57b 5toot 	3	6500.00	a	29	f	0	2025-08-18 09:17:59.997+00	2025-08-21 14:41:33.475+00	f	\N	\N	\N
6661	41	91320808	zamiin uud	1	0.00		\N	f	0	2025-08-22 02:28:54.988+00	2025-08-22 06:54:56.778+00	t	\N	\N	\N
5543	2	94990222	Улаанбаатар, Баянзүрх 40-р хороо 72 хотхон 2р байр 2орц -20тоот #4532 орцны код 	3	6500.00	0	9	f	0	2025-07-04 04:53:55.133+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5555	2	95893417	Улаанбаатар, Баянгол 28-р хороо 78 bair 2 toot  3 emnelgiin urd jargalant tsetserlegiin hajuu cozy dent emnelegtei bair Bayngol duureg 28 horoo 78 bair 2 toot	3	6500.00	0	9	f	0	2025-07-04 11:41:07.238+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5527	2	91861004	Улаанбаатар, Баянзүрх 24-р хороо Цахлай 13-28 Da huree haan bank ogsood zalgah	3	6500.00	0	9	f	0	2025-07-03 10:19:21.749+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5557	2	99589309	Улаанбаатар, Сонгинохайрхан 05-р хороо songinhairhan duurgiin oodos harsan cu\n 	3	6500.00	0	9	f	0	2025-07-04 16:02:59.814+00	2025-07-07 10:18:24.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5602	2	99951001	Улаанбаатар, Хан-Уул 15-р хороо Khans vill 101 r bair 1 orts 15 dawhart 1502 toot (Utas 99909269 ) 	3	12100.00	0	22	f	0	2025-07-08 01:52:46.046+00	2025-07-22 05:19:03.837+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5592	2	80470475	Улаанбаатар, Сонгинохайрхан 36-р хороо алтан овоо 32 р гудамж 1а тоот 	3	6500.00	0	7	f	0	2025-07-07 11:03:17.508+00	2025-07-10 07:54:07.998+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5601	17	83119339	Хөвсгөл аймаг - Их уул сумын каргод тавих 	3	1.00	Каргонд тавиад өгвөл сайн байна гэсэн	9	f	0	2025-07-08 01:39:57.178+00	2025-07-09 00:36:55.403+00	f	\N	\N	\N
5594	2	96899968	Улаанбаатар, Баянзүрх 08-р хороо , Улаанбаатар, Баянзүрх, Тэнүүн хотхон 25А байр Tenuun hothon 25A bair 41 Тэнүүн хотхон 25А байр Tenuun hothon 25A bair 41 бзд одоогын 39-р хороо тэнүүн хотхон 25а байр хаалганы кодгүй 41 тоот	3	6500.00	0	9	f	0	2025-07-07 11:14:46.313+00	2025-07-20 07:50:59.138+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5596	2	95050902	Улаанбаатар, Хан-Уул 21-р хороо Buyntuhaa 2 horoolol 1002r bair 2 toot 	3	6500.00	0	22	f	0	2025-07-07 12:07:29.251+00	2025-07-21 09:22:54.353+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5597	2	99092263	Улаанбаатар, Хан-Уул 18-р хороо Гэрлүг Виста 58/03 байр, 2205 тоот 99155936 гэрт байгаа хүний дугаар	3	12100.00	0	12	f	0	2025-07-07 12:40:33.791+00	2025-07-10 00:54:11.025+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5571	15	80902381	БЗД, 13р хороолол, 43р хороо, натурын зам, шинэ монгол технологийн сургуулийн яг чанх өөдөөс нь харсан 6 давхар шар байшин (42р байр, 5 давхар, 20тоот) орцны код:4578#	3	1.00	1	4	f	0	2025-07-06 09:49:00.21+00	2025-07-07 13:39:56.142+00	f	\N	\N	\N
5598	2	99000255	Улаанбаатар, Хан-Уул 24-р хороо Богд вилла хотхон 1205 байр 134 тоот 	3	6500.00	0	22	f	0	2025-07-07 15:23:20.503+00	2025-07-21 10:48:54.759+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5606	2	88222736	Улаанбаатар, Сонгинохайрхан 24-р хороо Баруун салаа  3р буудал \nбаянхайрхан 1-11 	3	6500.00	0	7	f	0	2025-07-08 03:34:31.662+00	2025-07-10 07:54:03.828+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5593	2	88051413	Улаанбаатар, Сүхбаатар 11-р хороо , Улаанбаатар, Сүхбаатар, irgenii burtgeliin hashaanluu orood agarfarm emiin santai bair ortsnii kod 2580# 5 davhar 31 toot irgenii burtgeliin hashaanluu orood agarfarm emiin santai bair ortsnii kod 2580# 5 davhar 31 toot	3	6500.00	0	4	f	0	2025-07-07 11:10:54.691+00	2025-07-09 06:41:44.307+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6275	2	80262817	Улаанбаатар, Хан-Уул 15-р хороо Kh hotgon c1 (yrtonciin zugeer hamgiin hoid taliin haalga) orcnii code 5555#\n4 davhrt 11 toot\n 	1	6500.00	0	\N	f	0	2025-08-14 04:02:41.167+00	2025-08-14 04:02:41.177+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6229	2	80066665	Улаанбаатар, Баянзүрх 11-р хороо Бага Тэнгэр, G1002  	3	6500.00	0	\N	f	0	2025-08-11 09:40:56.685+00	2025-08-14 12:41:09.507+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5604	2	99595955	nuht 	3	6500.00	0	7	f	0	2025-07-08 03:07:23.6+00	2025-07-10 11:46:38.478+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5607	17	88058613	ХУД, 1-р хороо, 40р байр, 15 тоот - Эрлийн байрны баруун талд 67-р цэцэрлэгийн хойд тал	3	43000.00	38,0+5,0=43.0 очихдоо хүн байгаа эсэхийг залгаж асуух 	6	f	0	2025-07-08 03:50:36.697+00	2025-07-08 08:53:06.521+00	f	\N	\N	\N
5600	2	94999976	Улаанбаатар, Баянзүрх 22-р хороо Улаанбаатар, Баянзүрх, 22-р хороо Xд 82-Р Байр  XD 82-R Bair БЗД-ийн эмнэлэгийн ард 82-р байр 15тоот 	3	6500.00	0	4	f	0	2025-07-08 00:24:03.711+00	2025-07-09 07:53:04.539+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5591	2	80470475	Улаанбаатар, Сонгинохайрхан 36-р хороо алтан овоо 32 р гудамж 1а тоот 	3	6500.00	0	\N	f	0	2025-07-07 10:56:35.238+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6312	2	88104545	Улаанбаатар, Баянзүрх 41-р хороо Кино үйлдвэрийн  баруун талд Соёлцэцэрлэг , 3 давхар шар тоосгон байшин\n\n 	3	6500.00	0	9	f	0	2025-08-16 10:52:21.837+00	2025-08-17 13:23:19.941+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5605	17	99729530	Хан-Уул дүүрэг, 15-р хороо, Buti 108-89	3	142000.00	Хүргэхээсээ өмнө заавал залгаарай гэсэн 	12	f	0	2025-07-08 03:18:42.586+00	2025-07-08 07:27:55.114+00	f	\N	\N	\N
5595	2	80885809	Улаанбаатар, Баянгол 26-р хороо narnii horoolol 1-44 irhees omno yrih	3	12100.00	0	\N	f	0	2025-07-07 11:17:05.452+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5617	2	88078727	Улаанбаатар, Сүхбаатар 01-р хороо MCS plaza 1 давхарт, Худалдаа хөгжлийн банк Б. Бат-Идэр\n(Жижүүр дээр нь үлдээж болно)	3	6500.00	0	4	f	0	2025-07-08 08:44:15.046+00	2025-07-09 07:22:08.506+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5632	15	91202882	Han uul duureg 11r horoo Zaisan suld hothon 100/5r bair 1r orts	3	1.00	4tsagaas gadagshaagaa garah bolod baigamaa	19	f	0	2025-07-09 01:31:44.343+00	2025-07-09 12:49:14.556+00	f	\N	\N	\N
5612	2	80899981	Улаанбаатар, Баянзүрх 36-р хороо Crystal town 801 bair 3 orts #3016 9 davhar 909 	3	6500.00	0	12	f	0	2025-07-08 05:51:48.213+00	2025-07-10 01:11:33.173+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5613	2	99092263	Улаанбаатар, Хан-Уул 18-р хороо Гэрлүг Виста 58/03 байр, 2205 тоот 99155936 гэрт байгаа хүний дугаар	3	6500.00	0	6	f	0	2025-07-08 06:10:08.938+00	2025-07-22 12:33:31.418+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5631	2	89700584	Улаанбаатар, Баянзүрх 38-р хороо Баганат хотхон, 471-байр, 71 тоот Гоё дэлгүүрийн өөдөөс харсан хажуудаа хогийн букертай байр	3	6500.00	0	21	f	0	2025-07-09 01:20:58.164+00	2025-07-14 10:15:40.817+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5616	2	85522855	Улаанбаатар, Баянзүрх 38-р хороо Баганат өргөө хороолол 453-р байр 1-р орц 12-р давхар 59 тоот 85522855	3	6500.00	0	21	f	0	2025-07-08 08:04:01.449+00	2025-07-14 10:26:32.405+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5630	2	85105019	Улаанбаатар, Хан-Уул 18-р хороо Токио Таун 1, 50Д байр, 2 давхар, 203 тоот Нэмэлт утас 99997206	3	6500.00	0	22	f	0	2025-07-09 01:10:43.616+00	2025-07-17 09:35:51.437+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5609	16	95985338	Баруун 4 зам жэм пласа 805	3	1.00	a	9	f	0	2025-07-08 04:40:33.145+00	2025-07-08 10:33:41.677+00	f	\N	\N	\N
5627	2	86108066	Улаанбаатар, Хан-Уул 05-р хороо Яармаг 3р буудал МТ клонкын ард талд улбар шар байр Хан Вилла 1орц 17 давхар 121 тоот 	3	6500.00	0	\N	f	0	2025-07-08 18:33:20.377+00	2025-07-22 10:37:06.817+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5610	16	99074265	Тэнгис кинотеатрын урд 20давхар MN Tower iin 18 davhart 1807 toot	3	1.00	a	9	f	0	2025-07-08 04:40:50.864+00	2025-07-08 11:29:07.675+00	f	\N	\N	\N
5619	2	99855887	Улаанбаатар, Хан-Уул 03-р хороо Govin zam daguu River stone2 26a bair dooroo delguurtei 2r orts 912 toot kod 12345678# Irhesee umnu zalgah	3	6500.00	0	6	f	0	2025-07-08 11:47:56.511+00	2025-07-17 07:54:42.742+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6230	2	96005310	Улаанбаатар, Сүхбаатар 01-р хороо 1 байр 56 тоот 	3	6500.00	0	\N	f	0	2025-08-11 10:04:26.961+00	2025-08-14 12:41:09.507+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5620	15	96668856	Сүхбаатар дүүрэг, 1-р хороо, Авто замчдын гудамж, 40-р байр, 6н давхар 35б тоот	3	1.00	1	4	f	0	2025-07-08 13:27:44.821+00	2025-07-10 10:05:33.967+00	f	\N	\N	\N
5614	2	99991350	Улаанбаатар, Хан-Уул 17-р хороо Khan Hills hothon, 526r bair, 1r orts, 2davhar, 203 toot, code #123456# 	3	6500.00	0	\N	f	0	2025-07-08 06:22:04.913+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5615	2	99974488	Улаанбаатар, Баянгол 08-р хороо Хөгжил хотхон 25ын 2 ын 1орцнын 209 тоот 	3	6500.00	0	21	f	0	2025-07-08 07:58:25.73+00	2025-07-14 09:08:16.615+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5623	17	99195156	Hunnu 2222 CU дээр ирээд залгахад болно	3	54000.00	Очхоосоо өмнө залгах	19	f	0	2025-07-08 15:40:42.442+00	2025-07-09 12:52:34.526+00	f	\N	\N	\N
5611	2	95194901	Увс, Улаангом 7р баг 19-р гудамж 1127 тоот Содон хороолол 107-р байр2орц 15давхарын 224тоот хүргэх	3	6500.00	0	7	f	0	2025-07-08 05:02:38.254+00	2025-07-10 07:54:28.085+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5622	2	88100966	Улаанбаатар, Хан-Уул 23-р хороо Арцат 2 апартмент 1442 байр 1р орц 4давхар 15 тоот 	3	6500.00	0	7	f	0	2025-07-08 14:55:19.128+00	2025-07-10 10:44:50.163+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5687	16	88784817	bichil horoolol huree deed surguuli unguruud  zam daguu 9 bair  5davhart 28toot	3	0.10	a	4	f	0	2025-07-10 04:32:06.051+00	2025-07-10 09:03:42.552+00	f	\N	\N	\N
5624	17	80989620	ХУД, 20-р хороо, мишээл экспогийн хажууд Цагаан орд хотхон 	3	43000.00	7,8ны өдрийн 3с өмнө авах. Хөдөө явчих учраас эртхэн хүргээд өгөөрэй. Баярлалаа 	\N	f	0	2025-07-08 15:43:21.083+00	2025-07-09 08:48:36.406+00	f	\N	\N	\N
5625	17	91193381	Натурийн ард талын хаалганаас баруун эргээд 44а байр 8 давхар 801 тоот	3	43000.00	Очихдоо залгах. Өдөрт нь хүргэх шаардлагатай 	4	f	0	2025-07-08 15:45:02.674+00	2025-07-09 09:12:45.75+00	f	\N	\N	\N
5628	2	86108066	Улаанбаатар, Хан-Уул 05-р хороо Яармаг 3р буудал МТ клонкын ард талд улбар шар байр Хан Вилла 1орц 17 давхар 121 тоот 	3	6500.00	0	7	f	0	2025-07-08 18:33:20.671+00	2025-07-10 12:07:03.024+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5608	2	86082626	Улаанбаатар, Баянгол 01-р хороо Төмөр зам premium appartment 10р байр Б блок 9 давхар 901тоот hurgeltiin umnu zalgah 	3	6500.00	0	7	f	0	2025-07-08 04:09:25.722+00	2025-07-10 07:54:13.55+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6347	31	80836201	Сэлэнгэ аймаг Хүдэр сум унаанд тавих	3	35.00	тооцоо хийсэн	4	t	7	2025-08-18 03:15:02.774+00	2025-08-18 18:48:28.633+00	f	\N	\N	\N
6710	41	99307239	urihan/darhan unaand/	3	0.00		37	f	0	2025-08-22 09:49:34.777+00	2025-08-22 11:18:55.633+00	f	\N	\N	\N
6662	33	99371363	Дархан	3	7000.00	цамц 2	37	f	0	2025-08-22 02:36:39.148+00	2025-08-22 11:18:52.221+00	f	\N	\N	\N
5650	2	98115512	Улаанбаатар, Хан-Уул 11-р хороо Аппер Хаус Резиденс - 3 давхар - 301 тоот\nHUD - 11 khoroo, Ulaanbaatar 17023 	5	12100.00	0	\N	f	0	2025-07-09 07:05:41.59+00	2025-08-04 07:56:16.803+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5629	2	99991350	Улаанбаатар, Хан-Уул 17-р хороо Khan Hills hothon, 526r bair, 1r orts, 2davhar, 203 toot, code #123456# 	3	12100.00	0	19	f	0	2025-07-08 20:29:01.152+00	2025-07-22 10:33:31.567+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6231	15	95547300	SBD, narnii zam zamiin tsagdaagiin hoid tald tsagaan 12 davhar 59A bair , 7 davhart 21 toot ortsnii kod 2580#	3	1.00	1	4	f	0	2025-08-11 10:07:44.762+00	2025-08-12 00:48:46.434+00	f	\N	\N	\N
5648	2	99106216	horoolol moskva ikh delguur 1-16 12 tsagaas hoish	3	6500.00	0	4	f	0	2025-07-09 06:21:13.21+00	2025-07-19 06:28:52.283+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5646	2	96413232	Улаанбаатар, Сонгинохайрхан 20-р хороо Улаанбаатар, Сонгинохайрхан, 20-р хороо Драгон Увс улаангом сум  	3	6500.00	0	21	f	0	2025-07-09 05:37:45.439+00	2025-07-14 06:59:17.628+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
6277	2	80082020	Улаанбаатар, Баянзүрх 06-р хороо Орчлон комплекс худалдааны төв в1 давхар 9а\n89 667199 утсаар ярина уу Дэлгүүрт хүргэх	1	12100.00	0	\N	f	0	2025-08-14 06:07:31.198+00	2025-08-14 06:07:31.21+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5653	2	88160358	Улаанбаатар, Хан-Уул 23-р хороо Хангарьд сити 1 хотхон, 1461р байр, 4 давхар, 78 тоот 	3	6500.00	0	7	f	0	2025-07-09 07:20:30.895+00	2025-07-10 11:03:43.042+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5688	16	99995364	100 ail altan shagai delguur	5	26000.00	a	4	f	0	2025-07-10 04:32:35.826+00	2025-07-10 09:13:18.414+00	f	\N	\N	\N
5651	2	88109187	Улаанбаатар, Чингэлтэй 24-р хороо Doloon buudal deer huleej avna 	3	6500.00	0	22	f	0	2025-07-09 07:07:32.91+00	2025-07-19 05:12:36.383+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5634	2	88103715	Улаанбаатар, Хан-Уул 04-р хороо Artsat luxury hothon 1441-r bair 2 ar orts 10 dawhart 10 toot\n88103715 	3	6500.00	0	18	f	0	2025-07-09 02:01:57.714+00	2025-08-08 08:39:15.619+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5633	2	80885809	Улаанбаатар, Баянгол 26-р хороо narnii horoolol 1-44 irhees omno yrih	5	6500.00	0	22	f	0	2025-07-09 01:53:46.93+00	2025-07-19 06:14:22.763+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5654	2	99286969	Улаанбаатар, Баянзүрх 26-р хороо , Улаанбаатар, Баянзүрх, TrueL hothon 716 r bair 407 toot TrueL hothon 716 r bair 407 toot 	3	12100.00	0	\N	f	0	2025-07-09 08:52:35.241+00	2025-07-19 13:35:25.394+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5599	2	89118617	Улаанбаатар, Баянзүрх 14-р хороо Улаанбаатар, Баянзүрх, 14-р хороо         Цагаан хуаран 86в байр 2 тоот БЗД 14р хороолол 86в байр 2тоот.эсвэл ажилын цагаар ХӨСҮТөв эмнэлэгт өглөө8 цагаас өдөр 4 цагийн хооронд авч бно\n 	3	6500.00	0	4	f	0	2025-07-07 19:42:40.521+00	2025-07-09 08:13:17.888+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5652	2	99107441	Увс, Улаангом галданбошигт 321/1-406 тоот \n увс -99107441 \nдрагоноос 11 15 17 цагаас автобус явна 	3	6500.00	0	21	f	0	2025-07-09 07:19:47.765+00	2025-07-14 06:57:40.362+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5649	2	96011805	Улаанбаатар, Баянгол 10-р хороо 23 байр 7 давхар 26 тоот 	3	6500.00	0	38	f	0	2025-07-09 06:50:31.851+00	2025-08-21 08:34:31.153+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6330	15	85990477	Цамбагаравын 11-р байр 5-р орц 9 давхарт 177 тоот	3	1.00	1	29	t	10	2025-08-17 05:32:06.365+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
5647	2	95959181	Улаанбаатар, Сүхбаатар 07-р хороо 2-р сургууль чанх урд 44 байр 6 тоот  95959181 өмнө нь залгаж мэдэгдээрэй	3	6500.00	0	\N	f	0	2025-07-09 05:58:36.405+00	2025-07-19 13:34:08.707+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5637	2	99552647	bzd sondor appartment 97a 1103 toot	3	6500.00	0	21	f	0	2025-07-09 02:18:39.661+00	2025-07-14 09:42:08.012+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5702	17	99781289	Сансарын Чингис зочид буудлын эсрэг талын 8-р байр 1 орц 4 давхар 12 тоот #3267	3	49000.00	Очихдоо ярих	21	f	0	2025-07-10 10:22:25.979+00	2025-07-13 08:46:08.549+00	f	\N	\N	\N
5635	17	86500501	Дорнод аймгийн унаанд 	3	1.00	Төлбөрийг авсан. Өнөөдөртөө унаанд тавих	4	f	0	2025-07-09 02:08:59.442+00	2025-07-09 07:41:53.952+00	f	\N	\N	\N
5709	17	88016009	Hunnu mall замын урд арцат 1 хотхон 1441 / dream plaza / бичигтэй байр 5 давхар 503 тоот	5	115000.00	Очихдоо залгах. Маргааш хөдө явах учраас өнөөдөртөө хүргэх	7	f	0	2025-07-11 02:30:32.418+00	2025-07-21 06:51:53.131+00	f	\N	\N	\N
5626	17	90451920	Баянзүрх дүүрэг 4-р хорооо 14р байр 8орц 126 тоот	3	18000.00	Хүргэлттэйгээ 18,0 . Очихдоо залгах 	4	f	0	2025-07-08 15:46:39.544+00	2025-07-09 13:05:31.599+00	f	\N	\N	\N
5640	16	95759928	Өвөрхангай  аймаг Бат-Өлзий сум\t0₮	3	1.00	a	7	f	0	2025-07-09 04:55:25.186+00	2025-07-10 06:00:35.378+00	f	\N	\N	\N
5644	2	99605505	Улаанбаатар, Сонгинохайрхан 01-р хороо 17-р хороо 33 байр 77 тоот  СХД 1р хороолол 33 байр 77 тоот утас 88105574	3	6500.00	0	\N	f	0	2025-07-09 05:13:07.134+00	2025-07-28 04:37:39.596+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5638	2	99810666	Улаанбаатар, Хан-Уул 21-р хороо Буянт ухаа 2 хороолол 1010-р байр 7 давхар 38 тоот. 99810666 	3	6500.00	0	22	f	0	2025-07-09 04:14:39.058+00	2025-07-21 09:33:25.67+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5659	2	86881955	Улаанбаатар, Сонгинохайрхан 33-р хороо 122р сургуулийн 1р гудамж 10а 89691955 86881955 utsnii dugaar	3	6500.00	0	7	f	0	2025-07-09 09:11:57.612+00	2025-07-12 08:28:15.045+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5660	2	88338241	Улаанбаатар, Баянгол, 24-р хорооKoyo town 105r bair, Koyo town 54-4r bair 2r orts 13 davhar 1311 toot (ortsnii kod ##2580) 	3	6500.00	0	22	f	0	2025-07-09 09:30:18.958+00	2025-07-17 09:00:42.292+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5656	2	99134936	Улаанбаатар, Сонгинохайрхан 06-р хороо Улаанбаатар, Сонгинохайрхан, 6-р хороо СХД-гийн 37р хороо содон хороолол 107–104тооь сСХД-ийн содон хороолол 107-104 тоот	3	6500.00	0	21	f	0	2025-07-09 09:03:24.959+00	2025-07-14 08:48:19.693+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5678	16	88559828	bgd 6  horoo 25r emiin sangiin baruun tald kyukishi center ternii baruun tald 39r bair 2 orts  43 toot  	3	1.00	udees hoish	\N	f	0	2025-07-10 04:24:25.388+00	2025-07-11 14:05:52.456+00	f	\N	\N	\N
5665	2	85105019	Улаанбаатар, Хан-Уул 18-р хороо Токио Таун 1, 50Д байр, 2 давхар, 203 тоот Нэмэлт утас 99997206	3	6500.00	0	22	f	0	2025-07-09 12:17:12.03+00	2025-07-17 09:35:56.581+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5657	2	80330716	Улаанбаатар, Сонгинохайрхан 18-р хороо 11 байр 2 орц 5 давхар 28 тоот\n 	3	6500.00	0	21	f	0	2025-07-09 09:05:47.265+00	2025-07-14 06:31:43.84+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5662	2	86282528	Улаанбаатар, Баянгол 17-р хороо Ганьт хотхон 40д байр 69тоот 4давхар  	3	6500.00	0	6	f	0	2025-07-09 09:38:55.505+00	2025-07-27 09:32:00.4+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5669	2	88454522	Улаанбаатар, Баянгол 02-р хороо Улаанбаатар, Баянгол, 2-р хороо Hillside хотхон 9в байр Д орц 11давхарт 174тоот 	3	6500.00	0	22	f	0	2025-07-09 16:39:24.417+00	2025-07-19 06:51:16.948+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5675	15	99094435	Хан-Уул дүүрэг, 15-р хороо, Цэнгэлдэх хотхон 213-р байр 2203 тоот	3	1.00	a	4	f	0	2025-07-10 04:21:16.045+00	2025-07-10 10:37:33.552+00	f	\N	\N	\N
5668	2	88177053	Улаанбаатар, Баянзүрх, 28-р хороо62 гудамж 4р хэсэг, 62.1876 	3	6500.00	0	9	f	0	2025-07-09 15:00:09.16+00	2025-07-24 11:39:10.211+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5667	2	91119318	Ховд, Жаргалант сум АЙМГИЙН ТӨВРҮҮ УНААНД ТАВЬЖ ЯВУУЛАХ\n Өргөтгөлөөс ховдын машинд тавьж явуулах	3	6500.00	0	21	f	0	2025-07-09 14:09:25.345+00	2025-07-14 06:51:51.043+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5666	2	86453636	Улаанбаатар, Баянзүрх 02-р хороо Сансар шатахуун түгээхээс дарь эхрүүгээ эргээд M-Oil клонк зөрөөд баруун дээшээ засмал замаар эргэнэ Хурд фото студио google map дээр бичээд хайвал олдоно\n 	3	6500.00	0	21	f	0	2025-07-09 12:47:45.544+00	2025-07-14 09:26:39.532+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5658	2	88050019	Улаанбаатар, Сонгинохайрхан 20-р хороо Хүнсчдийн гудамж, 29-р байр, 27тот 	3	12100.00	0	\N	f	0	2025-07-09 09:10:37.79+00	2025-07-22 10:39:14.96+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5672	2	99991350	Улаанбаатар, Хан-Уул 17-р хороо Khan Hills hothon, 526r bair, 1r orts, 2davhar, 203 toot, code #123456# 	3	12100.00	0	\N	f	0	2025-07-10 03:58:05.329+00	2025-07-19 14:26:55.234+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5663	2	96212821	dornod unaand	3	6500.00	0	9	f	0	2025-07-09 11:03:51.946+00	2025-07-24 11:50:31.996+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6278	2	90303636	Улаанбаатар, Баянзүрх, 8-р хорооХаруул алтай хотхон, 100а 26тоот 	3	6500.00	0	9	f	0	2025-08-14 06:20:05.643+00	2025-08-15 06:32:17.018+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5671	17	99187547	Яармаг bogd villa 1202-60 toot	3	43000.00	Ochihdoo holbogdoh	7	f	0	2025-07-09 17:15:30.379+00	2025-07-10 13:25:59.234+00	f	\N	\N	\N
5682	16	99362848	laundtyzone  bars salbar	3	26000.00	a	18	f	0	2025-07-10 04:27:09.616+00	2025-07-10 16:25:31.629+00	f	\N	\N	\N
5681	16	99626080	yarmag garden city hothon 1309 bair 	3	26000.00	a	7	f	0	2025-07-10 04:26:37.095+00	2025-07-10 11:46:31.971+00	f	\N	\N	\N
5673	15	99983809	Ogoomor zahiin zuun tal ahmadiin horoololiin ard Green рессорт 77 bair  7 davhar 39 тоот	3	1.00	й	4	f	0	2025-07-10 04:20:21.961+00	2025-07-10 09:48:21.581+00	f	\N	\N	\N
5661	2	90544545	Увс, Улаангом увс улаангом унаанд дайх\nнарантуул өргөтгөл\n uvs ulaangom	3	6500.00	0	21	f	0	2025-07-09 09:32:27.429+00	2025-07-14 06:52:53.16+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5683	16	88133064	bzd baganat urguu horoolol 452-32 toot 	5	26000.00	a	4	f	0	2025-07-10 04:28:53.206+00	2025-07-10 09:31:54.885+00	f	\N	\N	\N
5679	16	96657577	bgd 27r  hotoo naranbulag 28r bair 	3	6000.00	hurgeltiin mungu avna 	\N	f	0	2025-07-10 04:25:25.279+00	2025-07-11 14:06:12.069+00	f	\N	\N	\N
5674	15	99821787	suhbaatar duurgin 5r horoo, 30r bair 14toot - uguujin urd taliin 39bairnii yrtuntsiin zugeer urd tald n gantshan sondgoi 30r bair geed bga ternii 14toot	3	1.00	a	18	f	0	2025-07-10 04:20:53.906+00	2025-07-10 09:20:01.017+00	f	\N	\N	\N
5676	15	95347027	Эрдэнэтийн унаанд тавих	3	1.00	a	18	f	0	2025-07-10 04:21:42.953+00	2025-07-10 09:20:01.017+00	f	\N	\N	\N
5680	16	85050282	7 buudald ireed zalga	3	26000.00	a	\N	f	0	2025-07-10 04:25:57.193+00	2025-07-11 14:06:23.182+00	f	\N	\N	\N
5664	2	80771104	Улаанбаатар, Хан-Уул 21-р хороо Нисэх шүрт хотхон 807 байр 1 орц 33 тоот 	3	6500.00	0	7	f	0	2025-07-09 11:59:23.574+00	2025-07-11 14:10:18.732+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6232	2	90757563	Улаанбаатар, Сонгинохайрхан 35-р хороо Нарангийн голын эцэс 	3	6500.00	0	9	f	0	2025-08-11 10:10:01.306+00	2025-08-14 07:10:42.554+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5693	2	88405624	Улаанбаатар, Сонгинохайрхан 26-р хороо Мандал овол 20 гудамж 9б тоот\n\n\n 	3	6500.00	0	9	f	0	2025-07-10 04:38:57.901+00	2025-07-22 05:01:17.933+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5670	17	89997239	нарны гүүр wellnws эсрэг талын байр cozy apartment	1	43000.00	Зогсоол байдаггүй гараад авья гэсэн	\N	f	0	2025-07-09 17:13:21.633+00	2025-07-10 04:37:29.29+00	t	\N	\N	\N
5699	2	95331616	Улаанбаатар, Баянзүрх 01-р хороо Sansariin Golden Vill hothon, 105 bair 2 orts 703 toot 	3	12100.00	0	9	f	0	2025-07-10 08:50:02.169+00	2025-07-21 09:43:12.325+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5694	2	80833402	Улаанбаатар, Сонгинохайрхан 04-р хороо Их наран 8 25 тоот 	3	6500.00	0	22	f	0	2025-07-10 04:39:24.974+00	2025-07-19 11:59:26.765+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5641	16	88710996	Москва хороолол 131-6 байр 1-орц5 давхар 24тоот, 24В\t6000₮	3	6000.00	a	7	f	0	2025-07-09 04:55:55.478+00	2025-07-10 06:00:35.378+00	f	\N	\N	\N
5642	16	99102653	Дархан	3	1.00	a	7	f	0	2025-07-09 04:56:21.741+00	2025-07-10 06:00:35.378+00	f	\N	\N	\N
5645	16	91018087	ХУД алтай хотхоны урд талд технологын дээдийн хашаанд 9- р байр 46 тоот, #2123	3	26000.00	й	6	f	0	2025-07-09 05:14:08.644+00	2025-07-10 06:00:35.378+00	f	\N	\N	\N
5700	2	99769241	Улаанбаатар, Хан-Уул 02-р хороо Бадрах хотхон в2 блок 18байр 303тоот  	3	6500.00	0	6	f	0	2025-07-10 09:56:20.703+00	2025-07-24 12:45:17.169+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5697	2	99510045	Улаанбаатар, Баянзүрх 03-р хороо Сансар Гарден хотхон 39/5 байр 2-р орц 24 давхарт 2403 тоот 	3	12100.00	0	\N	f	0	2025-07-10 05:00:21.983+00	2025-08-04 07:58:01.725+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5704	2	99909353	Улаанбаатар, Сонгинохайрхан 38-р хороо Улаанбаатар, Сонгинохайрхан, 38-р хороо Залуус хотгон 48а байр 5- орц 756 тоот 	3	6500.00	0	9	f	0	2025-07-10 11:34:57.913+00	2025-07-22 04:08:29.996+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5695	17	88710733	СБД эмнэлгийн зүүн талд Anand tower-n tend 11b 3 dawhar 19 toot 	3	43000.00	очихдоо ярих 	4	f	0	2025-07-10 04:45:49.591+00	2025-07-10 09:29:45.894+00	f	\N	\N	\N
5691	2	85959973	Улаанбаатар, Сонгинохайрхан 08-р хороо Baynhoshuu jantsangiin urd autobusnii buudal sor kargotoi bairnii 2 dawhar 3 toot Baynhoshuu jantsangiin autobusnii buudal sor kargotoi bairnii 2 dawhar 3 toot	3	6500.00	0	9	f	0	2025-07-10 04:37:25.698+00	2025-07-22 05:28:50.706+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5655	2	99939802	Улаанбаатар, Хан-Уул 21-р хороо Ханбогд хорооло 409-р байр 2р орц 4давхар 409тоот ХУД Хүннү малл1ийн урд Фүүдсити	3	6500.00	0	7	f	0	2025-07-09 08:55:45.582+00	2025-07-10 10:14:19.407+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6233	2	88046978	Улаанбаатар, Хан-Уул 18-р хороо 69а байр 55тоот 	1	6500.00	0	\N	f	0	2025-08-11 10:16:51.506+00	2025-08-11 10:16:51.518+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5696	17	88001080	6-с өмнө бол sahngrilla b1 davhar oracle spa, 8с хойш бол ХУД цэнгэлдэх хотхон 209-1105	3	30000.00	Очихдоо хаана байгааг нь асуух 	4	f	0	2025-07-10 04:47:33.051+00	2025-07-10 10:22:29.818+00	f	\N	\N	\N
5677	15	88835569	ХУД, 11-р хороо, Зайсан толгойн Америк сургуулийн ар талын ‘Рома таун, 8001-байр (манаачийн хажуугийн орц), 5-давхар, 504-тоот. 	3	1.00	a	4	f	0	2025-07-10 04:22:11.898+00	2025-07-10 10:49:17.803+00	f	\N	\N	\N
5701	2	86260406	Улаанбаатар, Сонгинохайрхан 23-р хороо 5shard emarttai dragon 3davhart sunshine delguurt Onoodorto avah blomjtoiyu	3	6500.00	0	9	f	0	2025-07-10 10:00:03.844+00	2025-07-22 04:29:02.754+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5692	2	88405624	Улаанбаатар, Сонгинохайрхан 26-р хороо Мандал овол 20 гудамж 9б тоот\n\n\n 	3	6500.00	0	\N	f	0	2025-07-10 04:38:57.585+00	2025-07-22 10:40:38.895+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5698	2	88100966	Улаанбаатар, Хан-Уул 23-р хороо Арцат 2 апартмент 1442 байр 1р орц 4давхар 15 тоот 	3	6500.00	0	\N	f	0	2025-07-10 07:54:05.116+00	2025-07-29 16:22:05.809+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5706	2	95443068	Улаанбаатар, Баянзүрх 12-р хороо Amgalan davhariin 15-7 	5	6500.00	0	\N	f	0	2025-07-10 13:08:39.362+00	2025-07-29 16:21:05.64+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5705	20	88064537	narnii horoolol	1	1000.00	etet	\N	f	0	2025-07-10 11:56:28.307+00	2025-07-19 13:44:48.067+00	t	\N	\N	\N
5708	2	95250618	Улаанбаатар, Баянгол 08-р хороо Хөгжил хотхоны гадаа ирээд залгах 	3	6500.00	0	4	f	0	2025-07-10 16:39:52.132+00	2025-08-12 00:17:15.829+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5710	2	96460022	Улаанбаатар, Чингэлтэй 21-р хороо , Улаанбаатар, Чингэлтэй, chingeltei dvvreg 21-r horoo bulgiin 19-iin997 chingeltei dvvreg 21-r horoo bulgiin 19-iin997 hvrgeed utasruu zalgana uu	3	6500.00	0	22	f	0	2025-07-11 06:49:29.912+00	2025-07-19 07:26:24.997+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6279	2	90784747	Улаанбаатар, Сүхбаатар 01-р хороо unesco gudamj one resident appertment 1 dawgar muchik restoran natur zam daguu one resident appertment 1 dawhar muchik restoran	3	6500.00	0	37	f	0	2025-08-14 09:11:58.145+00	2025-08-22 11:18:59.916+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5703	2	89816858	Улаанбаатар, Хан-Уул 13-р хороо Улаанбаатар, Хан-Уул, 13-р хороо туул тосгон буудал дээр 	3	6500.00	0	4	f	0	2025-07-10 11:15:44.789+00	2025-07-19 10:02:18.591+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5707	2	89115041	Улаанбаатар, Баянзүрх 16-р хороо 74-36 	3	6500.00	0	9	f	0	2025-07-10 13:24:46.549+00	2025-07-20 08:45:14.074+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5718	20	99889988	Marni horoolol	1	7000.00	test	\N	f	0	2025-07-11 14:39:35.639+00	2025-07-11 14:54:22.362+00	t	\N	\N	\N
5636	2	89098030	Улаанбаатар, Хан-Уул 09-р хороо Буянт ухаагийн 21-780  	3	6500.00	0	4	f	0	2025-07-09 02:14:15.352+00	2025-07-19 07:54:03.53+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5721	17	95203824	baynhoshuni etsest	1	48000.00	5 tsagaas umnu	\N	f	0	2025-07-12 06:25:52.291+00	2025-07-12 06:27:24.075+00	t	\N	\N	\N
5731	16	80102287	Дорнод хөлөнбуйр сум	5	1.00	a	\N	f	0	2025-07-12 12:41:25.574+00	2025-07-12 12:45:17.896+00	f	\N	\N	\N
5725	16	99091889	Сансар Emart ард Royal Castle 103 байр, 402 тоот	3	46000.00	a	\N	f	0	2025-07-12 12:39:13.958+00	2025-07-12 12:46:03.031+00	f	\N	\N	\N
5726	16	88045830	ХУД шинэ яармаг хороолол 	3	26000.00	a	\N	f	0	2025-07-12 12:39:40.06+00	2025-07-12 12:46:03.031+00	f	\N	\N	\N
5727	16	99937092	Зурагтын хуучин эцэс. Зүүн Ард Аюушийн 6-196	3	26000.00	a	\N	f	0	2025-07-12 12:40:06.698+00	2025-07-12 12:46:03.031+00	f	\N	\N	\N
5722	17	95203824	baynhoshuni etsest	3	48000.00	5 tsagaas umnu	21	f	0	2025-07-12 06:27:18.282+00	2025-07-12 07:31:09.375+00	f	\N	\N	\N
5729	16	99908440	Төв цэнгэлдэх хүрээлэн Рапид хороолол (12:00 өмнө)	3	26000.00	a	\N	f	0	2025-07-12 12:40:52.035+00	2025-07-12 12:46:03.031+00	f	\N	\N	\N
5723	17	88721697	Схд 23р хороо хангайн 6:14 монгол гэр хүрэмт	3	101000.00	6 tsagaas umnu	21	f	0	2025-07-12 06:28:12.566+00	2025-07-12 07:58:31.195+00	f	\N	\N	\N
5719	15	80263903	Ховдын унаанд тавих	3	1.00	1	21	f	0	2025-07-12 04:21:49.097+00	2025-07-12 08:07:23.795+00	f	\N	\N	\N
5712	17	80304851	Sansar garden 39/5r abir 2r orts 	3	1.00	Ochihdoo zalgah 	7	f	0	2025-07-11 12:46:35.675+00	2025-07-12 10:40:10.096+00	f	\N	\N	\N
5711	17	99922857	Bayngol duureg 32r horoo, 38A bair 	3	1.00	Horoollin etssin emartiin zamiin urd hawaii towiin yag urd 16 dawhar sky apartment 2. hoishoo harsan 1 ortstoi. ortsnii code #9999#. 9 dawhart 66 toot	7	f	0	2025-07-11 12:45:30.049+00	2025-07-12 11:18:33.186+00	f	\N	\N	\N
5730	16	90110390	Наран туул зах ахмадын хороо 51 байр ны 94 тоот	3	26000.00	a	\N	f	0	2025-07-12 12:41:08.67+00	2025-07-12 12:46:03.031+00	f	\N	\N	\N
5732	16	99704406	1р хороолол цамбагараваас дээшээ гэр хороололруу өгсөөд 31р хороон дээр ирээд утасдаарай	3	26000.00	a	\N	f	0	2025-07-12 12:41:44.033+00	2025-07-12 12:46:03.031+00	f	\N	\N	\N
5733	16	89278300	Нисэх 10 хороо Агапе христийн эмнэлэг	3	6000.00	a	\N	f	0	2025-07-12 12:42:07.909+00	2025-07-12 12:46:03.031+00	f	\N	\N	\N
5735	16	99085791	yarmag garden city 1204- r bair 3 davhart 303 toot #107001#	3	6000.00	a	\N	f	0	2025-07-12 12:42:47.367+00	2025-07-12 12:46:03.031+00	f	\N	\N	\N
5736	16	88112866	Чингэлтэй дүүрэг 3р хороо 51 байр 27 тоот	3	6000.00	a	\N	f	0	2025-07-12 12:43:07.743+00	2025-07-12 12:46:03.031+00	f	\N	\N	\N
5740	16	88150700	БГД 14р хороо 16 р байр 3 тоот 	3	6000.00	a	\N	f	0	2025-07-12 12:44:30.39+00	2025-07-12 12:46:03.031+00	f	\N	\N	\N
5741	16	гэртээ хүнтэй	Шинэчлэл хотхон 805 -3-96 тоот	3	26000.00	a	\N	f	0	2025-07-12 12:44:48.714+00	2025-07-12 12:46:03.031+00	f	\N	\N	\N
5720	2	99522975	Улаанбаатар, Баянзүрх 43-р хороо UB Tower 15давхар 1501 тоот 99522975 ажлын өдөр\n ажлын өдөр 1	3	6500.00	0	9	f	0	2025-07-12 05:59:10.395+00	2025-07-24 10:29:03.987+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5737	16	88134082	Ч.дүүрэг Denj 21. 234 тоот	4	26000.00	a	\N	f	0	2025-07-12 12:43:24.6+00	2025-07-12 12:55:31.924+00	f	\N	\N	\N
5743	2	86129222	Улаанбаатар, Сүхбаатар 08-р хороо River castle / B block 18 dawhar 1801 toot \nUlaanbaatar teatriin zuun tald 88129222 86709222 8812923	5	6500.00	0	22	f	0	2025-07-12 16:40:57.625+00	2025-07-19 10:51:08.611+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5742	17	888888	test123	1	10001.00	zalgah	\N	f	0	2025-07-12 13:47:11.676+00	2025-07-13 07:50:05.341+00	t	\N	\N	\N
5744	17	8888888	test123	1	50000.00	6s umnu	\N	f	0	2025-07-13 06:32:18.967+00	2025-07-13 07:50:05.341+00	t	\N	\N	\N
5751	2	80010918	Улаанбаатар, Хан-Уул 23-р хороо яармаг гарден сити хотхон,  1401 байр 14 давхар б блок 1401 тоот. 3-р орц код:#999666# 	3	6500.00	0	22	f	0	2025-07-14 09:36:08.102+00	2025-08-06 10:50:37.305+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5738	16	94117048	Har horin zahiin zuun tald erin horoolol 53/11 bair 1 orts 42 toot, Ortsni kod #1101 (19:00 хойш)	3	26000.00	a	21	f	0	2025-07-12 12:43:39.059+00	2025-07-13 13:35:53.811+00	f	\N	\N	\N
5750	2	99072048	narnii horoolol 27 bair 6 davhariin 604 toot	3	1.00	a	21	f	0	2025-07-14 04:55:10.584+00	2025-07-15 10:16:18.842+00	f	\N	\N	\N
5749	16	dornod	80102287	3	1.00	unaand taviad msg yvuulah	21	f	0	2025-07-14 04:54:31.379+00	2025-07-14 10:01:00.199+00	f	\N	\N	\N
5746	15	80015739 	Сүхбаатар дүүрэг 9 р хороо 225 байр 9 давхар 38 тоот	3	1.00	a	21	f	0	2025-07-13 07:54:51.337+00	2025-07-13 08:26:09.159+00	f	\N	\N	\N
5745	15	80899446	Дорнодруу унаанд тавих	3	1.00	a	21	f	0	2025-07-13 07:52:47.616+00	2025-07-13 09:01:41.602+00	f	\N	\N	\N
5728	16	99191987	Худ жапентаун С-3 Е болок 5- давхар 514	3	26000.00	a	21	f	0	2025-07-12 12:40:26.141+00	2025-07-13 09:19:45.527+00	f	\N	\N	\N
5747	15	91108535	khan uul duureg nisehiin toirog aero town. 304 bair	3	1.00	a	21	f	0	2025-07-13 07:55:23.248+00	2025-07-13 09:52:18.849+00	f	\N	\N	\N
5748	15	99942353	Irj avsan	3	1.00	a	\N	f	0	2025-07-13 10:01:56.434+00	2025-07-13 10:02:28.636+00	f	\N	\N	\N
5734	16	99186115	Хөвсгөл, мөрөн	3	1.00	a	21	f	0	2025-07-12 12:42:27.903+00	2025-07-13 10:37:10.845+00	f	\N	\N	\N
5724	15	95112410 	БГД 20-р хороо БХН 48 байр 16 тоот	1	1.00	tom nom	21	f	0	2025-07-12 06:32:19.278+00	2025-07-14 04:43:06.113+00	t	\N	\N	\N
5739	16	80102287	dornod unaand	1	6000.00	a	\N	f	0	2025-07-12 12:43:53.787+00	2025-08-03 19:30:55.516+00	t	\N	\N	\N
5752	2	85007980	Улаанбаатар, Хан-Уул 18-р хороо Хүннү 2222, \n224р байр 804 тоот 	3	6500.00	0	\N	f	0	2025-07-15 09:05:41.95+00	2025-07-29 16:27:09.653+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5753	2	89698922	Улаанбаатар, Баянзүрх 14-р хороо 70-р байр 7 давхар 32 тоот 	3	6500.00	0	9	f	0	2025-07-15 11:10:54.177+00	2025-07-20 09:54:40.703+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5754	2	85511088	Улаанбаатар, Баянгол 05-р хороо 3-р байр,10-р хороолол, Хаан Банкны арын цэнхэр байр, 23 тоот, 6 давхар (89702331 руу залгаарай) 	3	6500.00	0	\N	f	0	2025-07-15 18:51:45.888+00	2025-07-22 10:43:54.427+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5775	2	99321729	Улаанбаатар, Баянзүрх 08-р хороо Дотоод хэргийн их сургууль автобусны буудал урд Thrift shop 	3	6500.00	0	9	f	0	2025-07-18 03:30:05.802+00	2025-07-21 09:43:46.546+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5766	15	99604990	Сэлэнгэ аймаг Сүхбаатар сумруу вагоны тээшинд тавиулна	3	1.00	A	22	f	0	2025-07-17 07:36:09.005+00	2025-07-18 08:26:45.233+00	f	\N	\N	\N
5773	2	86068712	Улаанбаатар, Баянзүрх 36-р хороо Баянмонгол хороолол 406 байр 2 орц 38тоот 	3	6500.00	0	\N	f	0	2025-07-18 00:39:11.907+00	2025-07-29 16:28:29.681+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5761	15	95520876	Дарханы унаанд тавихад болно. Баруунхараа гэх газар тосож авна. Дархан явах замд байдаг.  (ТОМ, ЖИЖИГ хоёр ном)	3	1.00	a	22	f	0	2025-07-16 05:06:52.161+00	2025-07-16 05:49:33.289+00	f	\N	\N	\N
5759	15	89150446 	Дорнод, Хөлөнбуйр сумруу унаанд тавиулна. Тэнгэр плазагаас (ЖИЖИГ НОМ)	3	1.00	a	22	f	0	2025-07-16 05:05:38.108+00	2025-07-16 06:08:05.664+00	f	\N	\N	\N
5757	15	96705705 	 Ulaaanhuaran etsec next cinema-n Urd Shine amgalan horoolol 517-31 toot. (ЖИЖИГ НОМ)	3	1.00	a	22	f	0	2025-07-16 05:03:52.13+00	2025-07-16 06:23:28.178+00	f	\N	\N	\N
5756	17	88043200	Jumbo sequence nalaihin unaand tawiuli hu	3	65000.00	a	22	f	0	2025-07-16 04:35:12.22+00	2025-07-16 06:36:19.968+00	f	\N	\N	\N
5758	15	baihgui	Han uul duureg, 2- horoo 19 iin autobusnii buudliin hoid tald 35б Bair hondlono zuun talaasaa ortstoi 16 dawhar Bair 1- orts 1105toot, ortsnii code 1105. / huuchin 3 ondoriin zuun tald shineer barigdsan/ (ТОМ НОМ)	3	1.00	a	22	f	0	2025-07-16 05:05:02.852+00	2025-07-16 08:37:08.665+00	f	\N	\N	\N
5772	2	85055589	Улаанбаатар, Баянзүрх, 10-р хороо6- р байр 6-r bair, Амгалан цагдаа хотхон 75/5 байр 9 давхар 45 тоот орц код 45#305 	3	6500.00	0	\N	f	0	2025-07-17 16:24:05.21+00	2025-07-22 10:44:49.093+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5567	2	99769241	Улаанбаатар, Хан-Уул 02-р хороо Бадрах хотхон в2 блок 18байр 303тоот  	3	6500.00	0	6	f	0	2025-07-05 09:09:25.175+00	2025-07-17 07:54:42.742+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5762	8	96112425	Дарханы унаанд тавихад болно. Баруунхараа гэх газар тосож авна. Дархан явах замд байдаг. (ТОМ, ЖИЖИГ хоёр ном)	3	1.00	a	22	f	0	2025-07-16 14:22:49.461+00	2025-07-16 15:02:29.936+00	f	\N	\N	\N
6262	2	99302503	Улаанбаатар, Баянгол 19-р хороо Улаанбаатар, Баянгол, 19-р хороо 3,4-r horoolliin kfc giin zvvn tald torguud sports delgvvr ajliin 11:00-19:40 	3	6500.00	0	\N	f	0	2025-08-13 04:21:38.927+00	2025-08-14 12:37:20.808+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5776	2	95939719	Улаанбаатар, Сонгинохайрхан 15-р хороо Цамбагаравын хажууд байдаг PizzaHut-тай 44-р шар 7 давхар байр. 3-р орц, 5 давхарт 80 тоот 	3	6500.00	0	22	f	0	2025-07-18 05:45:27.101+00	2025-07-19 11:45:16.537+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5643	2	99272821	Улаанбаатар, Баянгол 20-р хороо ХУД, "МИШЭЭЛ" тавилгын их дэлгүүр. Утас: 90666004, 99272821 10:30 - 17:00 цагийн хооронд ажиллана.	3	6500.00	0	22	f	0	2025-07-09 05:00:49.072+00	2025-07-19 14:43:09.718+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5771	2	85055589	Улаанбаатар, Баянзүрх, 10-р хороо6- р байр 6-r bair, Амгалан цагдаа хотхон 75/5 байр 9 давхар 45 тоот орц код 45#305 	3	6500.00	0	9	f	0	2025-07-17 16:19:35.097+00	2025-07-20 07:19:57.764+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5639	2	85105019	Улаанбаатар, Хан-Уул 18-р хороо Токио Таун 1, 50Д байр, 2 давхар, 203 тоот Нэмэлт утас 99997206	3	6500.00	0	22	f	0	2025-07-09 04:15:57.321+00	2025-07-17 09:36:00.3+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5760	15	88318990	2nom niited ni awna  Tow aimg -Zuunmod ,  khandsuren (ТОМ, ЖИЖИГ хоёр ном)	3	1.00	a	18	f	0	2025-07-16 05:06:12.903+00	2025-07-17 10:02:03.135+00	f	\N	\N	\N
5765	15	90612332	Бгд 12 хороо 27р байр 1р орц	3	1.00	A	7	f	0	2025-07-17 07:35:48.345+00	2025-07-17 10:02:03.135+00	f	\N	\N	\N
5767	15	91011981	БЗД 3р хороо 32-2 тоот	3	1.00	A	7	f	0	2025-07-17 07:36:41.294+00	2025-07-17 10:02:03.135+00	f	\N	\N	\N
5768	15	94199109 	Говь- алтай аймаг есөнбулаг сум гээд автобусанд хүргүүлнэ хө утас. 15:00, 18:00 цагуудад автобус гарна	3	1.00	A	7	f	0	2025-07-17 07:37:50.409+00	2025-07-17 10:02:03.135+00	f	\N	\N	\N
5770	2	94003569	Улаанбаатар, Хан-Уул 11-р хороо Blue Sky hothon 44v bair 1r orts 2 toot\n 	3	6500.00	0	\N	f	0	2025-07-17 10:12:25.505+00	2025-07-29 16:27:40.975+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5769	2	90493040	Улаанбаатар, Баянгол 16-р хороо Улаанбаатар, Баянгол, 16-р хороо Гандан төв хаалганаас урагшаа ШАР ОРДОН B1 давхар эрхэм сонголт дэлгүүр 99061531 энэ дугаарлу залгаж байж очих 8аас хойш байхгүй 	3	6500.00	0	6	f	0	2025-07-17 09:08:46.432+00	2025-07-20 11:31:16.112+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5764	2	94101552	Улаанбаатар, Баянзүрх, 26-р хорооtime tower, Time tower 218-131 	3	6500.00	0	6	f	0	2025-07-17 05:47:58.719+00	2025-07-19 08:24:58.142+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5367	2	85511088	Улаанбаатар, Баянгол 05-р хороо 3-р байр,10-р хороолол, Хаан Банкны арын цэнхэр байр, 23 тоот, 6 давхар (89702331 руу залгаарай) 	3	12100.00	0	\N	f	0	2025-06-28 15:48:21.166+00	2025-07-18 06:05:06.812+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5844	2	88102515	Улаанбаатар, Баянзүрх, 26-р хорооGlobal park, Global park, B2 Block, 17th floor, 1705 	3	6500.00	0	6	f	0	2025-07-21 11:55:35.617+00	2025-07-22 10:25:28.984+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5774	2	86641004	Улаанбаатар, Баянзүрх 26-р хороо saruul horoolol, 112 bair, 2r orts, 2r dawhar 61n toot, #1122 kod 	3	6500.00	0	\N	f	0	2025-07-18 03:27:35.319+00	2025-07-29 16:28:29.681+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5406	2	89531300	Улаанбаатар, Сүхбаатар 09-р хороо Дөлгөөн нуур 4-р сургуулийн замын эсрэг талын 16 давхар байр 7давхарт 704 тоот Хүргэхийн өмнө 99956699 дугаарлуу залгах	3	6500.00	0	\N	f	0	2025-06-30 13:02:56.214+00	2025-07-18 06:05:06.812+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5433	2	80582743	Улаанбаатар, Баянзүрх 26-р хороо may seven hotel 1davhar sakana restaurant  	3	6500.00	0	\N	f	0	2025-07-01 09:03:21.347+00	2025-07-18 06:05:06.812+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5455	2	88109681	Улаанбаатар, Хан-Уул 21-р хороо шүрт хотхон 817 байр 1 орц 7 давхар 37 тоот 	3	6500.00	0	\N	f	0	2025-07-02 03:07:44.832+00	2025-07-18 06:05:06.812+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5457	2	95411450	Улаанбаатар, Баянзүрх 40-р хороо 72r hothon 49/14-14 5 davhar 	3	6500.00	0	\N	f	0	2025-07-02 04:03:48.685+00	2025-07-18 06:05:06.812+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5458	2	89117662	Улаанбаатар, Сүхбаатар 09-р хороо Дөлгөөн нуур авто малл хүдэр мөнх оффис 403 тоот 	3	6500.00	0	\N	f	0	2025-07-02 04:10:29.271+00	2025-07-18 06:05:06.812+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5794	2	88028249	Улаанбаатар, Сонгинохайрхан 37-р хороо 105 20 тоот 88028249 88080224	3	6500.00	0	22	f	0	2025-07-18 13:19:22.424+00	2025-07-19 10:51:20.459+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5792	2	86304945	Улаанбаатар, Хан-Уул 08-р хороо Сонсголон10-422тоот\nОргил худалдааны төвийн баруун талын засмалаар хоошоо яваад 	3	6500.00	0	22	f	0	2025-07-18 13:08:08.948+00	2025-07-21 10:58:56.63+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5795	2	99510045	Улаанбаатар, Баянзүрх 03-р хороо Сансар Гарден хотхон 39/5 байр 2-р орц 24 давхарт 2403 тоот 	3	12100.00	0	\N	f	0	2025-07-18 13:39:38.1+00	2025-08-04 07:58:01.725+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5777	2	99042161	Улаанбаатар, Баянзүрх 25-р хороо Шинэ Монгол сургуулийн хойно 37р байр 3 давхар 18 тоот 	3	6500.00	0	22	f	0	2025-07-18 06:07:30.101+00	2025-07-19 10:04:21.123+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5788	2	99116737	Улаанбаатар, Баянгол 06-р хороо Уб палас Дако 10а байр 104 тоот 	3	6500.00	0	4	f	0	2025-07-18 09:03:05.417+00	2025-07-19 06:42:41.242+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5789	2	86007187	Улаанбаатар, Баянгол 31-р хороо SHVVT hothon 55.2-7 toot 	3	6500.00	0	22	f	0	2025-07-18 11:22:32.523+00	2025-07-19 11:37:18.206+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5791	2	99142595	Улаанбаатар, Баянзүрх 01-р хороо 17-24 toot 24b 	3	6500.00	0	\N	f	0	2025-07-18 11:44:05.232+00	2025-07-29 16:28:29.681+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5787	2	98144866	Улаанбаатар, Чингэлтэй 14-р хороо Cu 365 дахь салбар 	3	6500.00	0	9	f	0	2025-07-18 08:11:06.381+00	2025-07-25 13:03:22.047+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
5781	15	88852636	25. Narnii horoolol 7r bair 4r orts 7dawhar 206 toot  (ТОМ НОМ)	3	1.00	a	22	f	0	2025-07-18 06:16:02.235+00	2025-07-18 09:00:10.782+00	f	\N	\N	\N
5793	2	99885113	Улаанбаатар, Баянзүрх 42-р хороо Улаанбаатар, Баянзүрх, 42-р хороо 72-р байр Өгөөмөр хотгон 	3	6500.00	0	9	f	0	2025-07-18 13:17:14.289+00	2025-07-20 09:33:19.399+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5780	15	80101686	24. Bzd 26r horoo, santo life hothon 714 bair 2 orts 15 davhar Tsetserlegt hureelengiin hoino  (ЖИЖИГ НОМ)	3	1.00	a	22	f	0	2025-07-18 06:15:30.053+00	2025-07-18 09:20:01.328+00	f	\N	\N	\N
5779	15	91011981	23. БЗД 3р хороо 32-2 тоот  (ЖИЖИГ НОМ)	3	1.00	a	22	f	0	2025-07-18 06:14:38.9+00	2025-07-18 09:33:06.849+00	f	\N	\N	\N
5778	15	99339999	22. Архангайн унаанд тавиулна  (ТОМ, ЖИЖИГ хоёр ном)	3	1.00	a	22	f	0	2025-07-18 06:13:33.722+00	2025-07-18 09:53:51.189+00	f	\N	\N	\N
5785	2	99104929	Улаанбаатар, Баянзүрх 43-р хороо Натур төвийн урд 91/3 р байр 4 давхар 15 тоот 	3	6500.00	0	22	f	0	2025-07-18 07:54:16.609+00	2025-07-19 10:04:03.752+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5790	2	80244524	Улаанбаатар, Сонгинохайрхан 02-р хороо Улаанбаатар, Сонгинохайрхан, 2-р хороо 56/2тоот 80244524	3	6500.00	0	9	f	0	2025-07-18 11:36:28.26+00	2025-07-22 04:41:31.905+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5786	2	86304945	Улаанбаатар, Хан-Уул 08-р хороо Сонсголон10-422тоот\nОргил худалдааны төвийн баруун талын засмалаар хоошоо яваад 	3	6500.00	0	22	f	0	2025-07-18 08:09:57.304+00	2025-07-21 10:59:02.603+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5782	2	98159769	Улаанбаатар, Чингэлтэй 20-р хороо Баян хошуу хөтөл 149-сургууль\n 98159769	3	6500.00	0	22	f	0	2025-07-18 07:04:31.359+00	2025-07-19 10:49:30.157+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5783	2	88692950	Улаанбаатар, Хан-Уул 11-р хороо Улаанбаатар, Хан-Уул, 11-р хороо Зайсан эцэс Хан-түшээ хотхон 201байр 	3	6500.00	0	19	f	0	2025-07-18 07:06:14.881+00	2025-08-06 10:19:17.871+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6234	2	99764168	Улаанбаатар, Баянгол 20-р хороо Бхн 2-27 байр 1 тоот 	3	6500.00	0	\N	f	0	2025-08-11 10:38:00.948+00	2025-08-14 12:39:10.305+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6331	2	80156561	Улаанбаатар, Баянзүрх 12-р хороо Чулуун овоо чулуут 6 127тоот 	3	6500.00	0	44	f	0	2025-08-17 05:49:40.237+00	2025-08-24 07:13:03.548+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5805	2	99131653	Улаанбаатар, Чингэлтэй, 6-р хороо58-р Байр 58-R Bair, Суис баруун талын 58 байр 70 тоот 	3	6500.00	0	9	f	0	2025-07-19 12:54:13.989+00	2025-07-22 08:19:57.892+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5796	2	96864455	Улаанбаатар, Баянзүрх 38-р хороо Шинэ сонголт хотхон 426-р байр, 6 давхар, 605 тоот 	3	6500.00	0	9	f	0	2025-07-18 13:41:28.864+00	2025-07-20 09:02:19.455+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5763	2	95295530	Улаанбаатар, Баянзүрх, 25-р хороо62-р байр, 13-р хороолол 25-р хороо шөнийн захын эсрэг талын байр 	3	6500.00	0	6	f	0	2025-07-17 05:23:34.87+00	2025-07-19 07:08:10.114+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5802	2	99270802	Улаанбаатар, Хан-Уул 15-р хороо Хан уулын emart- аас баруун тийш Тара центр вега Сити хотхон 201 байр 804 тоот 	3	6500.00	0	\N	f	0	2025-07-19 00:47:11.706+00	2025-07-22 11:40:23.547+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5491	2	99906141	Улаанбаатар, Баянгол 29-р хороо Монгол шуудангийн авто бааз 88142913\n 	5	6500.00	0	4	f	0	2025-07-02 10:54:00.987+00	2025-08-12 00:17:23.95+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5804	2	90091959	Улаанбаатар, Баянгол 03-р хороо Баянгол дүүрэг 3 хороо Гранд Вилла А блок 12 давхар 131 тоот 	3	12100.00	0	\N	f	0	2025-07-19 09:18:36.821+00	2025-07-23 06:18:42.516+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5798	2	89897177	Улаанбаатар, Баянгол 01-р хороо Богд-Ар хороолол 2а байр 1-р орц 5 тоот 	3	6500.00	0	22	f	0	2025-07-18 15:31:09.621+00	2025-07-19 16:21:34.466+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5784	2	91059977	Улаанбаатар, Сүхбаатар 08-р хороо Улаанбаатар чуулганы эсрэг талын шилэн барилга, River castle, B block, 17р давхар, 1701 тоот\n Сүхбаатар дүүрэг, 8р хороо, Улаанбаатар чуулганы эсрэг талын шилэн барилга, B block, 17р давхар, 1701 тоот	3	6500.00	0	6	f	0	2025-07-18 07:33:26.756+00	2025-07-19 06:02:55.498+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5803	2	88059231	Улаанбаатар, Сонгинохайрхан 33-р хороо Улаанбаатар, Сонгинохайрхан, 33-р хороо Тахилтын эцэс номингийн ажилчдын байр Тахилтын эцэст 88059231	3	12100.00	0	4	f	0	2025-07-19 01:32:14.701+00	2025-07-19 07:26:16.957+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5801	2	99081081 95958765 	Улаанбаатар, Хан-Уул, 21-р хорооHasu villa town 1003 toot, Hurdnii zam 100 modnii zam saldag uulzwar ub oil klonkoos 150 m unglued baruun irgene 95958765 dugaar luu zalgah hurgeltiin omno	3	6500.00	0	6	f	0	2025-07-18 22:41:34.298+00	2025-07-23 08:23:30.855+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5799	2	95508558	Улаанбаатар, Хан-Уул 15-р хороо Alpha zone 64/4 16давхар 63 тоот 	3	6500.00	0	6	f	0	2025-07-18 17:23:56.701+00	2025-07-19 08:45:19.062+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5797	2	96032425	Улаанбаатар, Хан-Уул 18-р хороо Hunnu2222 plus 210 10 davhar 1003 toot  	3	6500.00	0	19	f	0	2025-07-18 13:49:53.845+00	2025-08-06 10:19:13.637+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6237	2	90251881	Улаанбаатар, Хан-Уул 24-р хороо Хүннү вилла 1405-2А тоот 90251881 	3	6500.00	0	\N	f	0	2025-08-11 10:55:46.1+00	2025-08-14 12:39:36.179+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5510	2	95755536	Улаанбаатар, Баянгол 24-р хороо Алтай хотхон 25-р байр 2р орц 5 давхарт 105 тоот 	3	12100.00	0	\N	f	0	2025-07-03 02:13:41.121+00	2025-07-19 13:31:28.244+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5511	2	99393507	Улаанбаатар, Хан-Уул 17-р хороо Han uul 17 r horoo king tower 129 r bair 1 dawhar Zolo beauty salon\n99976601\n 	3	12100.00	0	\N	f	0	2025-07-03 03:52:24.635+00	2025-07-19 13:31:28.244+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5515	2	99856054	Улаанбаатар, Баянгол 28-р хороо Энхтайвны өргөн чөлөө-125 Техник импорт ХК-ын байр Харуулд үлдээх	3	6500.00	0	\N	f	0	2025-07-03 05:41:45.132+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6332	2	99902240	Улаанбаатар, Баянзүрх 13-р хороо Bayanzurkh 26 khoroo santo apartment 212-411 toot\n 2 ort ortsnii kod 2122#	1	6500.00	0	\N	f	0	2025-08-17 06:17:06.146+00	2025-08-17 06:17:06.159+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5800	17	80680507	СХДүүрэг хамбийм 1-37	5	43000.00	очихдоо залгах. хархорингоос хойшоо гэж ойлгосон 	9	f	0	2025-07-18 17:30:55.438+00	2025-07-20 04:08:51.997+00	f	\N	\N	\N
6280	2	80090914	Улаанбаатар, Баянзүрх 22-р хороо 97б 606 тоот 80090914 	3	6500.00	0	9	f	0	2025-08-14 13:10:40.465+00	2025-08-17 13:51:55.948+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6340	2	88771260	Улаанбаатар, Баянзүрх, 26-р хорооЭнканто таун 2-207  Encanto town 2-207, 207-r bair 6-r davhar 53 toot, ortsni kod tsagdaa tulhuur 4321 honh 	3	6500.00	0	6	f	0	2025-08-17 16:10:34.403+00	2025-08-23 12:19:19.033+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6348	31	88047805	, Хан-уул дүүрэг, 25-р хороо , Нисэх Буянтухаа нэгийн ард Тэнүүн хотхон 616рбайр  15.1509 тоот	3	35.00	тооцоо хийсэн	22	f	0	2025-08-18 03:18:43.657+00	2025-08-18 11:46:30.816+00	f	\N	\N	\N
6403	31	89894779	Их наядын урд Саруул хороолол 118-р байр 1-р орц 6 тоот	1	58000.00	тооцоо авах	\N	f	0	2025-08-19 01:53:13.136+00	2025-08-19 02:22:35.613+00	t	\N	\N	\N
6329	15	89093933	БЗД-15-р хороо, 13 хороолол 6 байр 5 орц 150 тоот	3	1.00	1	29	t	10	2025-08-17 05:30:59.479+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
5519	2	86006472	Улаанбаатар, Хан-Уул 13-р хороо Хан-Уул дүүрэг 13р хороо 4р гудамж 16 тоот 	3	6500.00	0	\N	f	0	2025-07-03 07:03:43.137+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5520	2	80063643	Улаанбаатар, Баянзүрх 43-р хороо Шинэ Монгол сургуулийн баруун урд Хийморь 13 хотхон 74Б байр 11давхарт 72 тоот 	3	6500.00	0	\N	f	0	2025-07-03 07:37:22.895+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5521	2	80403880	Улаанбаатар, Чингэлтэй 12-р хороо Булгийн 3-199 80403880 -улсын нэгдүгээр эмнэлэг ажлын цагаар 	3	6500.00	0	\N	f	0	2025-07-03 07:41:34.076+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5542	2	99117908	Улаанбаатар, Хан-Уул 18-р хороо Хүннү2222 113 байр 1орц 8давхарт 8а тоот код:##1131#\n 	3	6500.00	0	\N	f	0	2025-07-04 04:24:46.411+00	2025-07-19 13:31:28.244+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5577	2	94419421	Улаанбаатар, Хан-Уул encanto 3 204 bair 2orts 15davhar 97 toot 94419421-irched ene dugaarlu zalga  (95580828)- ene dugaarig deern naagad enacnto 3iin manaachid uldeecherei cargo bolon hurgeltin tulburig 94419421 ene dugaaras tulnu \n 	3	6500.00	0	\N	f	0	2025-07-06 15:44:36.062+00	2025-07-19 13:31:28.244+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5589	2	86041475	Улаанбаатар, Баянзүрх 26-р хороо Narlag Urguu hothon, 723-r bair, 3 davhart 5 toot. Zuun tiishee harsan orts ortsnii kod: 72301# 	3	6500.00	0	\N	f	0	2025-07-07 06:45:46.626+00	2025-07-19 13:31:28.244+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5603	2	88001480	Улаанбаатар, Сүхбаатар 04-р хороо Huuhdiin 100 Khan banknii 1r davhart Coffee shopd uldeeh \nAjliin udruuded 17:00 hurtel huleen avah bolomjtoi Hurgelt huleen avah hun 80252250	3	6500.00	0	\N	f	0	2025-07-08 02:37:03.377+00	2025-07-19 13:31:28.244+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5618	2	98000780	Улаанбаатар, Хан-Уул 11-р хороо Bella vista хотхон 100-р байр 103 тоот 2 давхарт 	3	6500.00	0	\N	f	0	2025-07-08 11:15:06.215+00	2025-07-19 13:31:28.244+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5621	2	99111191	Улаанбаатар, Баянзүрх 43-р хороо Натур худалдааны төв ард 86-р байр 8 давхар 29 тоот 1-р орц  код #5781 утас 99507050 83000803 	3	6500.00	0	\N	f	0	2025-07-08 14:35:28.372+00	2025-07-19 13:31:28.244+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5817	2	80711758	Улаанбаатар, Сонгинохайрхан 01-р хороо Схд 1-р хороо Нарангийн гол 75-р гудамж 10тоот 	3	6500.00	0	9	f	0	2025-07-20 05:37:35.174+00	2025-07-22 04:28:54.645+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5816	2	99111191	Улаанбаатар, Баянзүрх 43-р хороо Натур худалдааны төв ард 86-р байр 8 давхар 29 тоот 1-р орц  код #5781 утас 99507050 83000803 	3	6500.00	0	9	f	0	2025-07-20 05:16:03.317+00	2025-07-22 12:19:54.178+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5811	2	86228224	Улаанбаатар, Баянгол 24-р хороо Altai hothon 50b bair 14davhar 75toot\n 	3	6500.00	0	6	f	0	2025-07-19 16:52:15.3+00	2025-07-26 12:58:19.39+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5813	2	99003928	Улаанбаатар, Хан-Уул 15-р хороо Их наяд зүүн өндөр 6-н давхарт 601 тоот Md health care center  	3	6500.00	0	6	f	0	2025-07-20 03:18:49.079+00	2025-07-22 09:22:32.332+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5812	2	99186319	Улаанбаатар, Баянзүрх, 26-р хорооМандала хотхон 320-8-р байр Mandala hothon 320-8-r bair, 5 davhart 348 toot 	3	12100.00	0	6	f	0	2025-07-19 23:22:03.862+00	2025-07-24 05:25:01.207+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5819	2	99190342	Улаанбаатар, Хан-Уул 17-р хороо Sky garden, 716 bair, 3 davhar, 301 toot 	3	6500.00	0	6	f	0	2025-07-20 12:23:50.392+00	2025-07-22 13:02:31.85+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5820	17	99702810	СХДүүрэг,8-р хороо,баянцагаан 6-р гудамж189 тоот	3	6000.00	Хүргэхээсээ өмнө заавал залгах. Хүргэлтийн 6,000 авах. Мөн 6 оронтой баталгаажуулах код авахад89383886 ру явуулах 	9	f	0	2025-07-20 14:55:52.719+00	2025-07-22 05:29:21.324+00	f	\N	\N	\N
5815	15	99381859	ХУД 4-р хороо Viva city S5-5-6 тоот	3	1.00	a	6	f	0	2025-07-20 04:26:17.236+00	2025-07-20 06:34:26.912+00	f	\N	\N	\N
5806	15	91011981	БЗД 3р хороо 32-2 тоот	1	1.00	a	9	f	0	2025-07-19 13:40:15.794+00	2025-07-20 04:01:13.052+00	t	\N	\N	\N
5809	15	88168870	 Bayangol dureg, 26r khoroo, Narnii horoolol, 15r bair, 7 davhar, 701 toot	3	1.00	a	6	f	0	2025-07-19 13:41:29.052+00	2025-07-20 11:31:20.479+00	f	\N	\N	\N
5807	15	80101686	Bzd 26r horoo, santo life hothon 714 bair 2 orts 15 davhar Tsetserlegt hureelengiin hoino	1	1.00	a	18	f	0	2025-07-19 13:40:46.763+00	2025-07-20 04:01:32.002+00	t	\N	\N	\N
5808	15	88852636	Narnii horoolol 7r bair 4r orts 7dawhar 206 toot	1	1.00	a	18	f	0	2025-07-19 13:41:11.166+00	2025-07-20 04:02:29.415+00	t	\N	\N	\N
5814	15	92035070	Эрдэнэтрүү унаанд тавих	3	1.00	a	9	f	0	2025-07-20 03:35:31.795+00	2025-07-20 04:08:08.444+00	f	\N	\N	\N
5818	2	88058619	Улаанбаатар, Баянзүрх 04-р хороо бзд 4 хороо 46б байр 39б тоот (американ дэнж хотхоны ард 46б байр ) очхоос өмнө 88058619 залга	3	6500.00	0	9	f	0	2025-07-20 06:32:37.222+00	2025-07-23 12:36:28.147+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5821	15	91110736 	Баянгол дүүрэг Богд арын  24а-35тоот	3	1.00	1	6	f	0	2025-07-21 02:07:52.271+00	2025-07-21 07:23:05.382+00	f	\N	\N	\N
6238	2	99157957	Улаанбаатар, Баянгол 14-р хороо Улаанбаатар хот, Баянгол дүүрэг, 14-р хороо, 3-р хороолол Ачлал их дэлгүүрийн ард талын 9 давхар цагаан байрууд 13в байр 4 орц 144 тоот 	3	6500.00	0	\N	f	0	2025-08-11 11:16:29.112+00	2025-08-14 12:37:11.812+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6281	30	888999898	nehemjleh	5	1000.00	test	29	t	10	2025-08-14 14:26:00.567+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
5162	3	88064537	narnii horoolol	3	1111.00	comment bhgu	13	f	0	2025-06-20 03:13:53.59+00	2025-08-22 14:31:40.71+00	f	\N	\N	\N
6667	41	91320808	zamiin uud	3	0.00		37	f	0	2025-08-22 02:47:12.818+00	2025-08-22 11:19:04.467+00	f	\N	\N	\N
5830	2	80803125	Улаанбаатар, Хан-Уул 20-р хороо Улаанбаатар, Хан-Уул, 20-р хороо Misheel expo baruun tald misheel hothon 94r bair 2r orts  2davhar 79 toot 	3	6500.00	0	6	f	0	2025-07-21 06:40:51.938+00	2025-07-22 08:07:41.946+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5828	2	80497878	Улаанбаатар, Хан-Уул 17-р хороо King Tower хотгон 131 байр 7 давхар 146 тоот  	3	6500.00	0	\N	f	0	2025-07-21 05:48:24.278+00	2025-07-28 09:04:04.952+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5827	2	99011038	Улаанбаатар, Хан-Уул 15-р хороо , Улаанбаатар, Хан-Уул, замын цагдаагийн зүүн урд Их наяд төвийн зүүн талын Ривэр вилла хотхон 8-1 байр 4давхарт 30тоот  замын цагдаагийн зүүн урд Их наяд төвийн зүүн талын Ривэр вилла хотхон 8-1 байр 4давхарт 30тоот  	3	6500.00	0	\N	f	0	2025-07-21 05:08:18.257+00	2025-07-23 06:18:20.051+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5840	15	88096522	Улаанбаатар хот , Хануул дүүрэг , 3р хороо , үйлдвэрийн гудамж , риверстоун хотхоны замын чанх урд "19 авто сервис "	3	1.00	1	6	f	0	2025-07-21 10:44:45.547+00	2025-07-22 07:51:11.076+00	f	\N	\N	\N
5833	2	85400808	Улаанбаатар, Баянзүрх 25-р хороо Натур сэлбэ хотхоны хажууд Дако 96/1 байр 37тоот 6давхар орц кодгүй 	3	6500.00	0	9	f	0	2025-07-21 07:26:50.825+00	2025-07-23 14:07:20.334+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5837	2	95445523	Улаанбаатар, Хан-Уул 02-р хороо Улаанбаатар, Хан-Уул, 2-р хороо НЭХМЭЛ ХОТХОН 35В 6ДАВХАР 601ТООТ Орцны код 601#	3	12100.00	0	18	f	0	2025-07-21 08:09:01.992+00	2025-07-28 09:07:39.273+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5826	2	80264941	Улаанбаатар, Баянзүрх 26-р хороо , Улаанбаатар, Баянзүрх, Олимп Хотхон 427-р Байр Olymp Hothon 427-R Bair 1-р орц, 13 давхар, 50 тоот Олимп Хотхон 427-р Байр Olymp Hothon 427-R Bair 1-р орц, 13 давхар, 50 тоот 	3	6500.00	0	6	f	0	2025-07-21 04:41:38.059+00	2025-07-22 10:04:50.938+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5824	2	88050019	Улаанбаатар, Сонгинохайрхан 20-р хороо Хүнсчдийн гудамж, 29-р байр, 27тот 	3	12100.00	0	\N	f	0	2025-07-21 03:13:36.023+00	2025-07-28 09:02:53.316+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5843	2	88883043	Улаанбаатар, Сүхбаатар, 3-р хорооЮү Би Цэнтрал Рисайдэнс 27-р байр UB central residence 27-r bair, A block 11 davhar 88 toot 	3	6500.00	0	\N	f	0	2025-07-21 11:55:27.458+00	2025-07-28 09:08:16.709+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5832	2	89509420	Улаанбаатар, Баянзүрх 41-р хороо Баянзүрх дүүрэг 41 хороо Century apartment 2 орц 208тоот (орцны код #123456#) 	3	6500.00	0	9	f	0	2025-07-21 07:08:35.828+00	2025-07-24 12:29:01.607+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5831	2	99174514	Улаанбаатар, Сүхбаатар 10-р хороо 7-р хороолол 24-а байр 6-н давхар 21 тоот. 	3	6500.00	0	9	f	0	2025-07-21 06:58:01.762+00	2025-07-24 09:22:40.124+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5829	2	89655494	Улаанбаатар, Сүхбаатар 01-р хороо Ayud tower 6 dawhart 605 toot 	3	6500.00	0	\N	f	0	2025-07-21 06:17:40.37+00	2025-08-03 19:31:17.75+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6239	2	99233428	Улаанбаатар, Сонгинохайрхан 33-р хороо Tahilt 3 iin 3r gudamj 278 toot 99233428 munhjargal	3	6500.00	0	9	f	0	2025-08-11 11:25:31.382+00	2025-08-14 07:30:31.347+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5839	2	80044412	Улаанбаатар, Сонгинохайрхан 24-р хороо баянхайрхан 10-9 	3	6500.00	0	9	f	0	2025-07-21 09:55:32.889+00	2025-07-24 09:24:10.978+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5838	2	91112277	Улаанбаатар, Сүхбаатар 01-р хороо Централ парк оффис ( Хүүхдийн ордний хойд талд) 10:00-19:00 цагийн хооронд хүлээн авах боломжтой 	3	6500.00	0	9	f	0	2025-07-21 09:01:36.15+00	2025-07-22 13:25:58.755+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5825	2	96903837	Улаанбаатар, Баянзүрх 26-р хороо Олимп виллаж 201 байр 1р орц 6 давхар 42 тоот 	3	12100.00	0	\N	f	0	2025-07-21 03:16:27.127+00	2025-07-23 06:17:46.565+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5835	2	89509494	Улаанбаатар, Сүхбаатар, 1-р хорооҮйлдвэрчний Хотхон 60-р Байр Uildverchnii Hothon 60-R Bair, 11 dawhart 182 toot utas 89509494 85506448	3	6500.00	0	\N	f	0	2025-07-21 07:49:28.678+00	2025-07-29 16:29:18.853+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5842	2	99728223	Улаанбаатар, Хан-Уул 15-р хороо Vega City Ochhooroo zalgaj medegdeh utas 98110027	3	12100.00	0	\N	f	0	2025-07-21 11:23:29.337+00	2025-07-28 09:08:48.521+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5822	2	95590963	Улаанбаатар, Баянгол 28-р хороо Sapporo 106 dugaar tsetserleg haraldaa tuv zamiin esreg tald JDL hotel\n 	3	6500.00	0	9	f	0	2025-07-21 02:33:54.028+00	2025-07-27 05:09:23.593+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5834	2	94101552	Улаанбаатар, Баянзүрх, 26-р хорооtime tower, Time tower 218-131 	3	6500.00	0	6	f	0	2025-07-21 07:41:01.082+00	2025-07-22 09:49:45.993+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5823	2	95590963	Улаанбаатар, Баянгол 28-р хороо Sapporo 106 dugaar tsetserleg haraldaa tuv zamiin esreg tald JDL hotel\n 	3	6500.00	0	9	f	0	2025-07-21 02:35:03.169+00	2025-07-22 06:15:37.081+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6314	2	80055842	Улаанбаатар, Баянзүрх 39-р хороо Улаанхуаран скай ресидэнс 1 226 байр 63 тоот 	3	6500.00	0	44	f	0	2025-08-16 12:38:54.548+00	2025-08-24 12:21:53.837+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5850	2	99993168	Улаанбаатар, Баянзүрх 36-р хороо Emerald Residence, 505, 1, 103 	3	6500.00	0	6	f	0	2025-07-21 12:43:56.024+00	2025-07-22 10:40:02.206+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5863	2	99936933	Улаанбаатар, Хан-Уул 08-р хороо Toirog niseh actuve garden 504-16dawhar121 	3	12100.00	0	\N	f	0	2025-07-22 01:02:30.432+00	2025-07-28 09:08:57.426+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5845	2	91095007	Улаанбаатар, Хан-Уул 04-р хороо Huushiin am, Jade villa hothon, 609 r toot 	3	6500.00	0	18	f	0	2025-07-21 12:00:52.883+00	2025-07-28 09:08:26.518+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5849	2	99080958	Улаанбаатар, Баянгол 12-р хороо Hayg BGD 12r khoroo 6-bichil horoolol 28-r surguuliin baruun tald 12,13 bairnii gold Talimaa emneleg deer urdaa CU tei 	3	6500.00	0	6	f	0	2025-07-21 12:29:27.701+00	2025-07-26 12:30:02.634+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5847	2	99174514	Улаанбаатар, Сүхбаатар 10-р хороо 7-р хороолол 24-а байр 6-н давхар 21 тоот. 	3	6500.00	0	9	f	0	2025-07-21 12:09:45.837+00	2025-07-24 09:22:53.675+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5859	2	99646524	Улаанбаатар, Сонгинохайрхан 05-р хороо Ханын материалаас дээшээ Ган хийцийн замд сүүлд баригдсан 2 ихэр шар улаантай байр 99646524 99646524	3	6500.00	0	9	f	0	2025-07-21 16:16:21.632+00	2025-07-24 04:49:02.906+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5887	2	88886363	Улаанбаатар, Хан-Уул 15-р хороо Хүннү-2222, 224-р байр 102 тоот 	3	6500.00	0	\N	f	0	2025-07-22 08:14:40.396+00	2025-07-28 09:04:31.614+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5861	2	94082299	Улаанбаатар, Баянзүрх 38-р хороо Шинэ амгалан 3 хорооолол 303 байр 2-р орц 55 тоот нэмэлт утас 99034467\n Ирээд заавал залгах	3	6500.00	0	9	f	0	2025-07-21 23:03:54.471+00	2025-07-23 14:54:38.748+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5862	2	86873232	Улаанбаатар, Хан-Уул 03-р хороо Гэрэлт өрөө хотгон 47B (Монгол В) байр 2р орц 13давхар 105тоот 	3	6500.00	0	6	f	0	2025-07-22 00:28:51.996+00	2025-07-23 08:05:07.306+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5865	17	96554575	БЗДь 9-р хорооь шар хад 43-662 тоот	3	43000.00	Өнөөдөртөө хүргэх очхоосоо өмнө залгах 	9	f	0	2025-07-22 01:44:11.05+00	2025-07-22 10:29:13.554+00	f	\N	\N	\N
6240	2	89898224	Улаанбаатар, Хан-Уул 21-р хороо buynt uhaa2 1044 bair 5dawhar 25toot utasni dugar:89898224	3	6500.00	0	\N	f	0	2025-08-11 11:36:28.832+00	2025-08-14 12:39:19.061+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5848	2	99080958	Улаанбаатар, Баянгол 12-р хороо Hayg BGD 12r khoroo 6-bichil horoolol 28-r surguuliin baruun tald 12,13 bairnii gold Talimaa emneleg deer urdaa CU tei 	3	6500.00	0	\N	f	0	2025-07-21 12:27:59.781+00	2025-07-28 09:08:09.064+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5855	2	95331616	Улаанбаатар, Баянзүрх 01-р хороо Sansariin Golden Vill hothon, 105 bair 2 orts 703 toot 	3	6500.00	0	\N	f	0	2025-07-21 14:05:47.902+00	2025-07-28 04:37:39.596+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5864	2	88880464	Улаанбаатар, Баянзүрх 26-р хороо Sunrise town40a-23 6dawhart ortsnii code 1401# tsetserlegt hureelengiin zuun tald dunjingarawiin urd tald  	3	6500.00	0	6	f	0	2025-07-22 01:38:05.691+00	2025-07-23 10:31:20.87+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5852	2	86971130	Улаанбаатар, Баянзүрх 43-р хороо Натур худалдааны төв B1 давхар ногоо лангуу 1 	3	6500.00	0	9	f	0	2025-07-21 13:18:45.341+00	2025-07-24 10:43:14.02+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5857	2	85105019	Улаанбаатар, Хан-Уул 18-р хороо Токио Таун 1, 50Д байр, 2 давхар, 203 тоот Нэмэлт утас 99997206	3	6500.00	0	6	f	0	2025-07-21 14:32:08.022+00	2025-07-23 09:18:20.898+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5854	2	85147380	Улаанбаатар, Баянзүрх 38-р хороо Баганат Өргөө 405 байр 2 орц 6 давхар 91 тоот орц код: 91B\n 	3	6500.00	0	\N	f	0	2025-07-21 13:45:50.467+00	2025-07-28 09:10:03.665+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5851	2	99141421	Улаанбаатар, Баянзүрх 08-р хороо Хууль сахиулах хотгон 49в байр 9 давхар 39тоот ургашаа харсан нэг орцтой орцны код 7913# 	3	6500.00	0	9	f	0	2025-07-21 13:10:21.279+00	2025-07-23 14:48:58.166+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5856	2	89982119	Улаанбаатар, Сонгинохайрхан 20-р хороо 5н шар өнгөрөөд нефтийн автобусны буудлийн чанх ард улбар шар GS25 тай байр 6р давхар 30тоот ( чип) 	3	6500.00	0	9	f	0	2025-07-21 14:14:05.736+00	2025-07-24 04:18:51.264+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5846	2	89509494	Улаанбаатар, Сүхбаатар, 1-р хорооҮйлдвэрчний Хотхон 60-р Байр Uildverchnii Hothon 60-R Bair, 11 dawhart 182 toot 89509494	3	6500.00	0	9	f	0	2025-07-21 12:04:00.212+00	2025-07-22 12:31:09.739+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5860	2	89019119	Улаанбаатар, Баянзүрх 26-р хороо Саруул хотхон 117 байр 2 орц 7 давхар 84 тоот \nорцны код 2117# 	3	6500.00	0	6	f	0	2025-07-21 22:17:43.605+00	2025-07-23 10:57:52.563+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5858	2	85197104	Улаанбаатар, Хан-Уул 24-р хороо Yarmag Hunnu mall zamiin esreg tald New Garden 1420bair 9davhar ortsnii code 2019# 	3	12100.00	0	\N	f	0	2025-07-21 15:20:05.759+00	2025-07-28 09:06:45.967+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6393	2	80181106	Улаанбаатар, Сонгинохайрхан 27-р хороо 25р байр 9 тоот 	2	6500.00	0	9	f	0	2025-08-19 01:13:35.263+00	2025-08-25 06:49:32.247+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5872	2	95038585	Улаанбаатар, Сүхбаатар 01-р хороо Улаанбаатар, Сүхбаатар, 1-р хороо meru tower 302 	5	6500.00	0	\N	f	0	2025-07-22 02:59:24.657+00	2025-08-04 07:58:32.276+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5874	24	99152403	daddada	1	30000.00	sd\\fjgfjkgjkdjgdgjkdfgjdjgj	\N	f	0	2025-07-22 05:41:28.501+00	2025-08-10 04:49:32.904+00	t	\N	\N	\N
5879	2	99589309	Улаанбаатар, Сонгинохайрхан 05-р хороо songinhairhan duurgiin oodos harsan cu\n 	3	6500.00	0	9	f	0	2025-07-22 06:38:29.675+00	2025-07-24 04:35:22.62+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5885	2	88113509	Улаанбаатар, Хан-Уул 11-р хороо Kingtower хотхон, 122-р байр, 7-р давхар, 240 тоот 	3	6500.00	0	\N	f	0	2025-07-22 08:04:55.85+00	2025-07-28 08:17:40.496+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5878	15	99082916	Бзд 43 р хороо амартүвшин хотхон 2 орц 12 давхар 101-122	3	1.00	1	9	f	0	2025-07-22 06:34:01.114+00	2025-07-23 14:07:12.214+00	f	\N	\N	\N
5871	2	99859549	Улаанбаатар, Баянгол 21-р хороо Улаанбаатар, Баянгол, 21-р хороо 15-36015дуугаар гудамж 15-360 Баянгол 21р хороо горкий 15дугаар гудамж 360тоот 	3	6500.00	0	6	f	0	2025-07-22 02:39:13.96+00	2025-07-27 06:54:42.892+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5883	2	94071789	Улаанбаатар, Баянзүрх 22-р хороо Бзд дүүргийн эмнэлгийн зүүн талд  хойшоо харсан 10н давхар 89р байрны 2давхарт 6тоот 94071789 Бзд дүүргийн эмнэлгийн зүүн талд  хойшоо харсан 10н давхар 89р байрны 2давхарт 6тоот 94071789	3	6500.00	0	\N	f	0	2025-07-22 07:55:20.155+00	2025-08-04 07:59:15.326+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5755	2	85511088	Улаанбаатар, Баянгол 05-р хороо 3-р байр,10-р хороолол, Хаан Банкны арын цэнхэр байр, 23 тоот, 6 давхар (89702331 руу залгаарай) 	3	6500.00	0	9	f	0	2025-07-15 18:51:46.173+00	2025-07-22 03:28:34.352+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5886	2	86911026	Улаанбаатар, Сүхбаатар 16-р хороо Бэлхийн тоосогны үйлдрэвийн эцэс тэлмэн төв 	3	6500.00	0	9	f	0	2025-07-22 08:07:48.704+00	2025-07-27 07:34:39.739+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5870	2	95297722	Улаанбаатар, Баянгол 03-р хороо narnii horoolol 9-190 toot \n\n 	3	6500.00	0	6	f	0	2025-07-22 02:33:30.109+00	2025-07-23 14:29:27.059+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5884	2	99104929	Улаанбаатар, Баянзүрх 43-р хороо Натур төвийн урд 91/3 р байр 4 давхар 15 тоот 	3	6500.00	0	9	f	0	2025-07-22 07:59:09.596+00	2025-07-24 10:37:24.929+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5877	2	99042396	Улаанбаатар, Баянзүрх 41-р хороо Ромео Жульетта хотхон 46Б байр 15 давхарт 125 тоот  	3	6500.00	0	9	f	0	2025-07-22 06:17:53.307+00	2025-07-24 12:12:01.445+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5875	2	99141628	Улаанбаатар, Сонгинохайрхан 07-р хороо Хилчин хотхон 11-117\n\n 3-р орц 5 давхар	3	6500.00	0	9	f	0	2025-07-22 05:47:01.645+00	2025-07-25 05:31:54.764+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5873	2	88110632	Улаанбаатар, Сонгинохайрхан 24-р хороо Схд- бумбатын рашаан бумбат 1-2\n 	3	6500.00	0	9	f	0	2025-07-22 04:00:31.772+00	2025-07-25 05:47:28+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5881	17	88100896	СБД, 6р хорооь талбайн хойноь СБД ЧДүүргийн иргэний хэргийн анхан шатны тойргийн шүүх 	3	99000.00	Монофоли, загастай тоглоом - мөн адил ландаас очиж авч хүргэж өгөх 	22	f	0	2025-07-22 06:54:04.873+00	2025-07-22 07:20:45.391+00	f	\N	\N	\N
5880	17	91016100	Хан-Уул дүүрэг 11р хороо Могул тоун 94-р байр 201 тоот	3	103500.00	Компьтер ландаас очиж аваад хүргэж өгөх яаралтайгаар - Саятан 	22	f	0	2025-07-22 06:51:55.382+00	2025-07-22 07:48:28.253+00	f	\N	\N	\N
5882	2	88121182	Улаанбаатар, Баянзүрх 32-р хороо Улаанбаатар, Баянзүрх, 32-р хороо Алтансан хороолол  монелийн уулзварын зүүн хойд байрлах, Алтансан хороолол 2-р орц 104 тоот утас 88121182 	3	6500.00	0	9	f	0	2025-07-22 07:09:21.255+00	2025-07-25 09:46:24.08+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5866	2	88031885	Улаанбаатар, Баянзүрх, 19-р хорооДэвжих өргөө А блок, Бзд 16-р хороололын замын хойд талын автобусны буудлын зүүн талаар хойшоо эргээд шарга хүнсний дэлгүүрийн урдуур зүүн талруу эргээд байгаа Дэвжих өргөө 11давхар 1104т орцны код 0915# 	3	6500.00	0	\N	f	0	2025-07-22 02:06:35.779+00	2025-07-29 16:30:00.749+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5869	2	95297722	Улаанбаатар, Баянгол 03-р хороо narnii horoolol 9-190 toot \n\n 	3	6500.00	0	6	f	0	2025-07-22 02:32:35.43+00	2025-07-26 13:27:43.825+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5876	2	99116140	Улаанбаатар, Сүхбаатар 01-р хороо One Residence 26D-10 	3	6500.00	0	\N	f	0	2025-07-22 05:58:51.046+00	2025-08-14 05:14:16.074+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5868	15	99028651	Hayag: bayanzrukh 26 horoo Global park hothon 711 bair 1r orts 9 davhart 904  toot  (Sumber ordin urd talin bair avobusni buudlin Monosin hajuu talin orts Ortsni kod ##1346)	3	1.00	Nomoo ajlin bus tsagaar hurguulie Ajlin udur 20 tsagaas hoish eswel amraltin udur	6	f	0	2025-07-22 02:24:33.785+00	2025-07-22 13:07:21.384+00	f	\N	\N	\N
5841	15	96531224	Хан-уул дүүрэг 23р хороо nuhtiin zam daguu Green garden residence 722-705	3	1.00	1	6	f	0	2025-07-21 10:45:40.961+00	2025-07-22 14:32:55.312+00	f	\N	\N	\N
6241	2	80899981	Улаанбаатар, Баянзүрх 36-р хороо Crystal town 801 bair 3 orts #3016 9 davhar 909 	3	6500.00	0	6	t	5	2025-08-11 11:47:20.328+00	2025-08-18 18:43:50.086+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5888	2	88095192	Улаанбаатар, Сонгинохайрхан 37-р хороо Содон хороолол 116р байр 1-р орц 9давхар 57тоот 	3	6500.00	0	9	f	0	2025-07-22 08:30:16.884+00	2025-07-27 03:12:00.927+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5903	2	99790727	Улаанбаатар, Хан-Уул 18-р хороо Hunnu 2222, 205 bair, 2r orts, 15r Davhar, 1504 toot 	3	6500.00	0	\N	f	0	2025-07-23 00:02:16.985+00	2025-07-28 09:04:23.394+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5853	2	88109375	Улаанбаатар, Хан-Уул 15-р хороо Улаанбаатар, Хан-Уул, 15-р хороо Kh apartment 6b bair 2 orts 8 davhar 124 toot. Code b123b6073b 	3	6500.00	0	6	f	0	2025-07-21 13:19:40.172+00	2025-07-22 08:50:18.508+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5890	2	99103014	Улаанбаатар, Хан-Уул, 17-р хорооКинг тауэр, Кинг тауэр 121р баыр 1р орц 4 давхарт 112тоот 	3	6500.00	0	\N	f	0	2025-07-22 08:42:31.092+00	2025-07-28 08:17:29.718+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6101	17	94122149	ХУД,15-р хороо, Хурд 28-р байр 191тоот орц нь кодгүй 	1	60000.00	Очхоосоо өмнө холбогдох . Хурдын улаан байрнууд гэсэн	\N	f	0	2025-08-01 08:58:58.661+00	2025-08-01 09:23:50.18+00	t	\N	\N	\N
5810	2	80144040	Улаанбаатар, Сүхбаатар 08-р хороо Спортын ордны зүүн талд (аркаар дөнгөж ороод хойш эргэнэ) шар 43р байр 2р орц, 6 давхар 58 тоот код 58b. Сонор төвөөр эсвэл 64ийн тэрүүгээр тойрж орж ирж болно. ирэхийн өмнө залгах	3	6500.00	0	9	f	0	2025-07-19 14:35:07.423+00	2025-07-22 12:52:18.442+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6038	2	99658449	Улаанбаатар, Баянзүрх 26-р хороо Baynmongol hothon, 418r bair, 2 davhar, 195 toot 	3	6500.00	0	6	f	0	2025-07-29 11:36:35.651+00	2025-07-30 10:08:23.276+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5901	2	98260056	Улаанбаатар, Хан-Уул 15-р хороо Han-Uul, 15r horoo, Hurd horoolol, 2-r bair, 1r orts, 7 davhar 52 toot, ortsnii code : 0021#,\nutas : 98260056 	3	6500.00	0	6	f	0	2025-07-22 23:39:00.23+00	2025-07-24 06:00:39.42+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5900	2	86111718	Улаанбаатар, Баянгол, 4-р хороо16 байр 7 тоот, 164 цэцэрлэгийн чанх урд 5 давхар саарал тосгон байр хуучнаар Варьетте чуулганы баруун талд 	3	6500.00	0	6	f	0	2025-07-22 23:26:22.747+00	2025-07-25 10:52:25.166+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5896	2	95337328	Улаанбаатар, Баянзүрх 07-р хороо 41r bair 4r orts 4davhar 73toot\n 	3	6500.00	0	9	f	0	2025-07-22 14:32:10.573+00	2025-07-25 02:22:47.335+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5892	2	99991350	Улаанбаатар, Хан-Уул 17-р хороо Khan Hills hothon, 526r bair, 1r orts, 2davhar, 203 toot, code #123456# 	3	6500.00	0	\N	f	0	2025-07-22 09:31:42.025+00	2025-07-28 08:17:19.001+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5899	2	86966136	Улаанбаатар, Сонгинохайрхан 37-р хороо Sodon horoolol 105r bair 1r orts 3 davhrt 16 toot Oroin tsagaar hurguuleh huselte bn	3	6500.00	0	9	f	0	2025-07-22 16:46:58.912+00	2025-07-24 03:44:18.807+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5902	2	88222736	Улаанбаатар, Сонгинохайрхан 24-р хороо Баруун салаа  3р буудал \nбаянхайрхан 1-11 	3	6500.00	0	9	f	0	2025-07-22 23:55:47.235+00	2025-07-24 05:07:19.939+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5891	2	99111191	Улаанбаатар, Баянзүрх 43-р хороо Натур худалдааны төв ард 86-р байр 8 давхар 29 тоот 1-р орц  код #5781 утас 99507050 83000803 	3	12100.00	0	\N	f	0	2025-07-22 09:14:31.006+00	2025-07-28 09:07:13.146+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5904	2	88773770	Улаанбаатар, Сонгинохайрхан 24-р хороо Баруун салааны 6 р буудал дээр буугаад дээж гээд дэлгүүр бгаа тэнд ирээд залгана уу. Замаа заагаад өгнө  	3	6500.00	0	9	f	0	2025-07-23 01:44:07.232+00	2025-07-25 05:07:18.801+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5906	2	88009634	Улаанбаатар, Сүхбаатар 01-р хороо Soylj malliin zamiin esreg tald 4 dawhar shilen nogoon bair ento gsn barilga b1 dawhar uran ger ahiun delguur 	3	6500.00	0	9	f	0	2025-07-23 02:23:03.357+00	2025-07-26 05:50:55.273+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5907	2	90092035	Улаанбаатар, Баянгол 01-р хороо Богд-Ар хороолол, 16а байр, 2р орц, 3 давхар, 26 тоот Орцны хаалга утсаар онгойно.	3	6500.00	0	9	f	0	2025-07-23 02:25:18.012+00	2025-07-25 03:35:41.368+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6413	32	94354099	эрдэнэт унаанд тавих	3	1.00	мөнгө авсан	4	f	0	2025-08-19 03:50:36.066+00	2025-08-20 02:48:26.071+00	f	\N	\N	\N
5897	2	80722229	Улаанбаатар, Хан-Уул 21-р хороо Нисэх Шүрт  хотхон  816 байр  2орц давхар 7давхар 114 тоот 	3	6500.00	0	6	f	0	2025-07-22 14:39:34.422+00	2025-07-25 12:09:25.815+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5889	15	99282539	Tuw shuudangii zamiin esreg taliin Eco international trade tower iin 9 dawhar 907 toot	3	1.00	1	18	f	0	2025-07-22 08:38:57.158+00	2025-07-23 12:27:32.138+00	f	\N	\N	\N
5898	2	99612006	Улаанбаатар, Хан-Уул 15-р хороо Их наяд плазагийн зүүн талд Ривер Вилла, 8/1, 14 давхарт 199 тоот 	6	6500.00	0	\N	f	0	2025-07-22 16:07:15.768+00	2025-08-04 07:59:35.206+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5893	2	99141628	Улаанбаатар, Сонгинохайрхан 07-р хороо Хилчин хотхон 11-117\n\n 	3	6500.00	0	\N	f	0	2025-07-22 11:15:58.489+00	2025-07-29 16:31:07.903+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5894	2	99141628	Улаанбаатар, Сонгинохайрхан 07-р хороо Хилчин хотхон 11-117\n\n 	3	6500.00	0	\N	f	0	2025-07-22 13:35:47.513+00	2025-07-29 16:31:07.903+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6669	41	91136693	hud 15horoo global town b block	3	0.00		6	f	0	2025-08-22 02:48:41.592+00	2025-08-24 09:14:47.659+00	f	\N	\N	\N
5911	2	99198064	Улаанбаатар, Баянзүрх 43-р хороо Нарны зам, Миний хайпермаркет-ийн баруун талд Номноо хотхон, 147-р байр, 61 тоот 	3	6500.00	0	9	f	0	2025-07-23 04:08:14.087+00	2025-07-26 13:56:50.345+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5919	2	99092897	Улаанбаатар, Хан-Уул 17-р хороо King tower 145r bair, 2r orts, 10 davhar, 278 toot 	3	6500.00	0	\N	f	0	2025-07-23 10:45:38.333+00	2025-07-29 10:58:10.746+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5913	2	85105019	Улаанбаатар, Хан-Уул 18-р хороо Токио Таун 1, 50Д байр, 2 давхар, 203 тоот Нэмэлт утас 99997206	3	6500.00	0	6	f	0	2025-07-23 05:43:24.535+00	2025-07-25 11:00:59.683+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5914	2	88095192	Улаанбаатар, Сонгинохайрхан 37-р хороо Содон хороолол 116р байр 1-р орц 9давхар 57тоот 	3	6500.00	0	9	f	0	2025-07-23 06:51:11.481+00	2025-07-24 03:36:41.227+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5912	2	94170477	Улаанбаатар, Сүхбаатар, 10-р хорооТопаз Паб Topaz PUb, Сүхбаатар дүүрэг 10-р хороо Топаз пабын хажууд 45б байр 3 давхар 5 тоот 	3	12100.00	0	\N	f	0	2025-07-23 04:22:48.243+00	2025-07-28 09:06:13.73+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5915	2	99182555	Улаанбаатар, Баянзүрх 03-р хороо 11-a bair, 1r orts, 3 davhart, orts code 11b.\nutas 80080484 80080484-huleej avah	3	6500.00	0	9	f	0	2025-07-23 06:56:56.997+00	2025-07-26 07:04:58.605+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5920	2	80640056	Улаанбаатар, Хан-Уул 04-р хороо Хүннү Вилла, 1404-18, давхар 3. би монгол хүн биш. 80640056 дугаарт мессеж илгээх юмуу орон сууцны үүдний гадаа илгээмж үлдээнэ үү. 	3	6500.00	0	6	f	0	2025-07-23 12:15:42.988+00	2025-07-25 14:01:42.858+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5916	2	86807828	Улаанбаатар, Сүхбаатар 10-р хороо Tuushin tower 	3	6500.00	0	18	f	0	2025-07-23 08:16:55.89+00	2025-08-08 08:39:15.619+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5905	15	95147455	ХУД 8-р хороо сонсголон8 351 тоот Оргилийн цаад талаар эргээд засмал замаа дагаад чигээрэй явахаар  S&I гэсэн дэлгүүр дээр зогсонгууд сонс8 гудамж гарж ирнэ. Тэгээд 351 тоот	3	1.00	Өдрийн цагаар хүнгүй байх учир оройхондоо бол маш сайн байна.	18	f	0	2025-07-23 01:59:44.306+00	2025-07-23 11:37:01.409+00	f	\N	\N	\N
5928	2	88214424	Улаанбаатар, Баянгол 20-р хороо 738-р байр (доороо хаан банктай 6давхар улаан тоосгон ) 2давхар 5тот 	3	6500.00	0	9	f	0	2025-07-24 05:02:13.848+00	2025-07-27 04:30:58.978+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5895	15	95720464	Bayanzurkh duureg,26r khoroo, Elizabeth hothon 220r bair 2r orts 9 dawhar 156 toot	3	1.00	1	6	f	0	2025-07-22 14:15:31.348+00	2025-07-23 13:47:23.638+00	f	\N	\N	\N
5925	2	99664870	Улаанбаатар, Баянзүрх 42-р хороо БЗД 42-р хороо 69 байр 7 давхар 704-р тоот 99680048 ажлын өдөр 19:00 цагаас хойш авах боломжтой	3	6500.00	0	9	f	0	2025-07-23 16:37:58.061+00	2025-07-26 03:40:50.316+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5924	2	80057666	Улаанбаатар, Хан-Уул 15-р хороо 120 мянгат, ХААН Банк цамхаг ажлын цагаар хүргэж ирэх.	3	6500.00	0	6	f	0	2025-07-23 16:15:55.535+00	2025-08-07 08:24:27.018+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5917	2	86985919	Улаанбаатар, Сонгинохайрхан 30-р хороо 1-Р Хороолол СХД 30-хороо хилчин 7-гудамж 12 тоот 	3	6500.00	0	9	f	0	2025-07-23 08:21:07.808+00	2025-07-25 06:13:45.546+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5922	2	99677674	Улаанбаатар, Сонгинохайрхан 12-р хороо Саппорагийн ард 2-р байр 7 орц 5 давхарт 233 тоот\n 	3	6500.00	0	9	f	0	2025-07-23 13:39:49.164+00	2025-07-25 06:29:09.133+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6242	2	99108863	Улаанбаатар, Хан-Уул 15-р хороо Kh apartment\n6a bair\n1 orts \n5 davhart 20 toot 	3	12100.00	0	\N	f	0	2025-08-11 11:59:30.611+00	2025-08-14 12:39:00.876+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5926	15	80082665	Андуудын хажууд МТЗ-н дээд сургуулийн урд талын зогсоол Хөтөл явах машин байгаа.	3	1.00	1	6	f	0	2025-07-24 02:29:51.332+00	2025-07-24 04:31:02.293+00	f	\N	\N	\N
5927	2	88701100	Улаанбаатар, Хан-Уул 08-р хороо Shunshig 3 horoolol 244-49 10davhar  	3	6500.00	0	4	f	0	2025-07-24 04:12:52.091+00	2025-07-27 08:20:21.416+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5908	15	99380036	SHD 35r horoo orbitiin 66 1g	3	1.00	1	9	f	0	2025-07-23 03:01:37.678+00	2025-07-24 04:24:23.747+00	f	\N	\N	\N
5867	2	99612006	Улаанбаатар, Хан-Уул 15-р хороо Их наяд плазагийн зүүн талд Ривер Вилла, 8/1, 14 давхарт 199 тоот 	3	12100.00	0	6	f	0	2025-07-22 02:11:24.861+00	2025-07-24 05:44:29.833+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5921	15	99291156	Бгд, 32-р хороо, хороолол эцэст, хавай фитнесийн урд скай апартмкнт 16давхар байр бий. 1 тоот скай март гээд дэлгүүрт авна 99291156	3	1.00	1	6	f	0	2025-07-23 12:16:14.391+00	2025-07-24 06:44:35.99+00	f	\N	\N	\N
6333	2	99902240	Улаанбаатар, Баянзүрх 13-р хороо Bayanzurkh 26 khoroo santo apartment 212-411 toot\n 	1	6500.00	0	\N	f	0	2025-08-17 06:17:57.972+00	2025-08-17 06:17:57.983+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5923	2	85824433	Улаанбаатар, Хан-Уул 17-р хороо time square hothon 503-r bair 1 dwhr 102 toot 	3	6500.00	0	18	f	0	2025-07-23 14:32:00.685+00	2025-08-20 04:57:42.341+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5929	2	99991350	Улаанбаатар, Хан-Уул 17-р хороо Khan Hills hothon, 526r bair, 1r orts, 2davhar, 203 toot, code #123456# 	3	6500.00	0	\N	f	0	2025-07-24 05:08:43.324+00	2025-07-29 16:33:42.703+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5941	2	99019594	Улаанбаатар, Сүхбаатар, 9-р хороо811-41, Hoimor office iin ard Utas: 99019592	3	6500.00	0	\N	f	0	2025-07-24 11:17:49.146+00	2025-08-08 07:26:06.932+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5942	2	86859230	Улаанбаатар, Багануур Улаанбаатар, Багануур, 1-р хороо 8-р байр 51 тоот  	3	6500.00	0	9	f	0	2025-07-24 12:20:37.75+00	2025-07-27 06:33:58.704+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5940	15	99442684	БЗД 1-р хороо 21-р байр 6-р орц 4 давхар 60 тоот. Тунел дээр цэцэг зочид буудлаар  өгсөхөд байдаг 5 давхар шар байр  	3	1.00	1	9	f	0	2025-07-24 11:05:11.813+00	2025-07-26 06:44:19.443+00	f	\N	\N	\N
5947	2	95555562	Улаанбаатар, Хан-Уул 15-р хороо Хан-Уул дүүргийн 15-р хороо, Махатма ганди гудамж, Цэнгэлдэх хотхон, 207-р байр 102 тоот 	3	6500.00	0	\N	f	0	2025-07-25 03:21:32.45+00	2025-07-28 09:06:57.212+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
5939	2	86690420	Улаанбаатар, Сонгинохайрхан 18-р хороо Улаанбаатар, Сонгинохайрхан, 18-р хороо 48 байр  	3	6500.00	0	9	f	0	2025-07-24 10:34:00.765+00	2025-07-27 04:22:34.063+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5935	2	88741747	Улаанбаатар, Баянзүрх 43-р хороо Натур худалдааны төвийн баруун талаар урагшаа салж эргээд доороо GS 25-тай Plus Apartment 7 давхар 701 тоот 	3	6500.00	0	9	f	0	2025-07-24 09:24:03.345+00	2025-07-26 06:11:57.062+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5936	2	90077000	Улаанбаатар, Сонгинохайрхан 15-р хороо 1r horoolol 23bair 5 orts 8 daw 173toot #4520 	3	6500.00	0	9	f	0	2025-07-24 10:13:55.563+00	2025-07-27 02:51:12.118+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5918	2	94071789	Улаанбаатар, Баянзүрх 22-р хороо Бзд дүүргийн эмнэлгийн зүүн талд  хойшоо харсан 10н давхар 89р байрны 2давхарт 6тоот 94071789 Бзд дүүргийн эмнэлгийн зүүн талд  хойшоо харсан 10н давхар 89р байрны 2давхарт 6тоот 94071789	3	6500.00	0	9	f	0	2025-07-23 08:34:25.078+00	2025-07-24 12:00:19.179+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5933	2	99696198	Улаанбаатар, Сонгинохайрхан 30-р хороо 1r horoolliin ariin zamaar dalangiin guur dawaad hoishoo chigeeree shine guureer ogsono 	3	6500.00	0	9	f	0	2025-07-24 08:13:29.531+00	2025-07-27 02:33:09.925+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5948	2	86000595	Улаанбаатар, Хан-Уул 15-р хороо Solongos elchin saidiin yam ( haruul deer hurgej ogno uu) 	3	6500.00	0	6	f	0	2025-07-25 04:09:13.256+00	2025-07-27 09:09:07.866+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5937	15	95251165	Худ 11 хороо Зайсан Голден будда 2 орц 11 давхар 46 тоот	3	1.00	1	18	f	0	2025-07-24 10:22:26.097+00	2025-07-26 05:37:28.91+00	f	\N	\N	\N
5946	2	94002961	Улаанбаатар, Хан-Уул 18-р хороо Hunnu2222, 2r eelj 215r bair 103toot 	3	6500.00	0	\N	f	0	2025-07-25 03:02:48.123+00	2025-07-29 10:58:21.221+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5931	2	89031648	Улаанбаатар, Сонгинохайрхан 20-р хороо Tolgoit Neft 38r bair 1r orts 6 davhar 43 toot 	3	6500.00	0	\N	f	0	2025-07-24 06:12:46.413+00	2025-08-04 08:00:48.926+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5943	2	99595955	Улаанбаатар, Хан-Уул 04-р хороо нүхт н1 house хурдан л авий	3	6500.00	0	4	f	0	2025-07-24 12:54:37.976+00	2025-07-27 07:43:52.831+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5930	2	88885490	Улаанбаатар, Баянгол 06-р хороо Баянгол дүүрэг, 10-р хороолол, 6-р хороо, 20 байр, 51 тоот 80121241 	3	6500.00	0	9	f	0	2025-07-24 05:42:38.087+00	2025-07-25 04:07:40.931+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5932	2	95099429	Улаанбаатар, Хан-Уул 24-р хороо Temuuge Tsogtgerel, 976-95099429, Монгол улс\nУлаанбаатар Хан-Уул 24-р хороо Yarmag, Belmonte\ntower 12th floor "REMAX Eagle"/Яармаг, Бельмонте\nтаур 12 давхар, "REMAX Eagle" 	3	6500.00	0	4	f	0	2025-07-24 07:01:55.095+00	2025-07-27 08:28:33.816+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5934	2	80101002	Улаанбаатар, Баянзүрх, 26-р хороо512 	3	6500.00	0	\N	f	0	2025-07-24 09:12:54.893+00	2025-07-28 09:06:26.062+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5944	2	98806096	Улаанбаатар, Сүхбаатар 01-р хороо Замын цагдаагын хажуу талын үйлдвэрчин хотхон 60 байр 6 тоот 86034232 энэ дураар луу залгаад өгчихөөрэй баярлалаа. 	3	6500.00	0	9	f	0	2025-07-24 14:57:14.288+00	2025-07-26 05:58:51.526+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5945	2	88708480	Улаанбаатар, Хан-Уул 23-р хороо Artsatiin am Luxury village 108 	3	6500.00	0	4	f	0	2025-07-24 15:33:56.961+00	2025-07-29 12:34:44.452+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5938	15	99528555	Grammar in use Cambridge ielts  Төлбөрийн баримтыг dm-р илгээлээ Hayg: Яармаг нүхтийн ам Gumuda garden 728р байр 2р орц 15 давхарт 145 тоот . Орцны код байхгүй	3	1.00	1	6	f	0	2025-07-24 10:23:34.71+00	2025-07-25 12:33:44.351+00	f	\N	\N	\N
5949	2	88972018	park place office ajliin tsagaar	3	6500.00	0	4	f	0	2025-07-25 04:37:10.578+00	2025-07-30 11:39:06.111+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6243	2	88098626	Улаанбаатар, Хан-Уул 23-р хороо Арцат 2 хотхон, 1431 байр, 14 давхар, 51 тоот\n 	3	6500.00	0	\N	f	0	2025-08-11 12:18:59.412+00	2025-08-14 12:39:27.549+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6398	32	89039136	120 buudal temeetei hoshoo deer ireed zalgah	1	46000.00	a	\N	f	0	2025-08-19 01:34:41.302+00	2025-08-19 02:29:50.265+00	t	\N	\N	\N
5958	2	85105019	Улаанбаатар, Хан-Уул 18-р хороо Токио Таун 1, 50Д байр, 2 давхар, 203 тоот Нэмэлт утас 99997206	3	12100.00	0	4	f	0	2025-07-25 12:14:39.801+00	2025-07-29 08:41:08.268+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5952	2	88840413	Улаанбаатар, Баянгол 19-р хороо 52А байр 1 орц 3 давхар 14 тоот\n 94943180	3	6500.00	0	6	f	0	2025-07-25 06:22:12.996+00	2025-07-27 09:49:20.156+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5953	17	9999999	un	1	1000.00	5n tsagaas umnu	\N	f	0	2025-07-25 07:32:00.218+00	2025-07-25 07:33:03.958+00	t	\N	\N	\N
5962	2	99168988	Улаанбаатар, Хан-Уул 08-р хороо Хан-уул дүүрэг 8-р хороо нисэх тойрог зүүн талд Active garden хотхон 505-р байр 16 давхар 121 тоот 	3	6500.00	0	\N	f	0	2025-07-26 01:44:46.186+00	2025-08-04 08:01:53.715+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5960	2	89031648	Улаанбаатар, Сонгинохайрхан 20-р хороо Tolgoit Neft 38r bair 1r orts 6 davhar 43 toot 	3	6500.00	0	9	f	0	2025-07-25 18:20:03.033+00	2025-08-14 08:02:55.077+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5951	2	99100224	Улаанбаатар, Баянзүрх 26-р хороо Глобаль парк хотхон 711 байр 2-р орц 305 тоот 	3	12100.00	0	\N	f	0	2025-07-25 05:30:20.066+00	2025-07-28 09:06:36.818+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5963	15	99073562	Яармаг, ХУД, 23-р хороо, Мандала Гарден, 1484-134	3	1.00	1	4	f	0	2025-07-26 03:01:54.885+00	2025-07-28 11:54:52.287+00	f	\N	\N	\N
5959	2	99089612	Улаанбаатар, Хан-Уул 24-р хороо Bogd-Villa 1202 r bair 2 r orts 11 dawhar 136 tootI’m Utas 88105642	3	6500.00	0	4	f	0	2025-07-25 15:15:25.568+00	2025-07-28 12:08:09.874+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5956	2	99646524	Улаанбаатар, Сонгинохайрхан 05-р хороо Ханын материалаас дээшээ Ган хийцийн замд сүүлд баригдсан 2 ихэр шар улаантай байр 99646524 	3	6500.00	0	9	f	0	2025-07-25 09:40:15.96+00	2025-07-27 03:24:55.144+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5957	2	99141628	Улаанбаатар, Сонгинохайрхан 07-р хороо Хилчин хотхон 11-117\n\n 	3	6500.00	0	9	f	0	2025-07-25 11:35:39.091+00	2025-07-27 03:33:56.04+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5961	2	85661663	Улаанбаатар, Хан-Уул 21-р хороо Шүрт хотхон 812байр 10давхар 60тоот\n Ирхээр нь төлөх	3	6500.00	0	4	f	0	2025-07-26 00:23:50.299+00	2025-07-27 06:54:26.108+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5965	2	86070125	Улаанбаатар, Сонгинохайрхан 01-р хороо Толгойт 7-70в 42р сургууль дээр ирээд залгах  	3	6500.00	0	9	f	0	2025-07-26 06:44:15.224+00	2025-07-27 03:56:03.734+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5969	2	99168988	Улаанбаатар, Хан-Уул 08-р хороо Хан-уул дүүрэг 8-р хороо нисэх тойрог зүүн талд Active garden хотхон 505-р байр 16 давхар 121 тоот 	3	6500.00	0	4	f	0	2025-07-26 12:28:51.615+00	2025-07-27 06:40:17.29+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5950	2	99818184	Улаанбаатар, Баянзүрх 06-р хороо 13-р хороолол 40А-9 тоот Анагаах ухааны их сургуулийн дотуур 2 байрны урд талд Энх туруун эмэгтэйчүүдийн эмнэлэгтэй улаан тоосгон байр\n 	3	6500.00	0	9	f	0	2025-07-25 05:10:36.203+00	2025-07-26 06:25:00.308+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6014	2	99776503	Улаанбаатар, Баянзүрх 25-р хороо Shine mongol surguuliin baruun tald 60-r bair 2-r orts 1davhart 21toot ortsnii kod 4694 	3	6500.00	0	9	f	0	2025-07-28 15:38:42.37+00	2025-08-03 10:28:52.236+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5967	2	94726577	Улаанбаатар, Сонгинохайрхан 22-р хороо Хилчин 29-34тоот 94726577	3	6500.00	0	9	f	0	2025-07-26 10:27:16.784+00	2025-07-29 04:16:42.22+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6285	2	96963637	Улаанбаатар, Баянзүрх 14-р хороо central mall tai bair urd orts 1206toot (#8810) 	3	6500.00	0	9	f	0	2025-08-15 03:01:15.768+00	2025-08-22 07:40:02.399+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5964	2	86911026	Улаанбаатар, Сүхбаатар 16-р хороо Бэлхийн тоосогны үйлдрэвийн эцэс тэлмэн төв 	3	6500.00	0	9	f	0	2025-07-26 05:08:32.709+00	2025-07-27 07:34:46.866+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5970	2	95096446	Улаанбаатар, Хан-Уул 15-р хороо River Villa хотхон, 8/1-р байр, 199 тоот Нэмэлт утас: 99612006	3	6500.00	0	6	f	0	2025-07-26 12:30:08.259+00	2025-07-27 08:57:04.289+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6244	15	99602167	БЗД 8р хороо УС-15 1р байр 4р орц 51тоот	3	1.00	1	9	f	0	2025-08-11 12:42:13.618+00	2025-08-12 07:04:23.203+00	f	\N	\N	\N
5955	2	80881067	Улаанбаатар, Сонгинохайрхан 03-р хороо , Улаанбаатар, Сонгинохайрхан, бага нарангийн 16-11 80881067 бага нарангийн 16-11 80881067 80881067	3	6500.00	0	9	f	0	2025-07-25 08:34:32.211+00	2025-07-27 03:49:27.781+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6015	2	88840614	Улаанбаатар, Хан-Уул 23-р хороо Нүхтийн зам, Сансет хотхон, 770-р байр 02 тоот 	3	12100.00	0	\N	f	0	2025-07-29 02:10:27.063+00	2025-08-04 07:48:27.391+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5966	2	80707499	Улаанбаатар, Баянзүрх, 23-р хороо1646, Бзд 23-хороо сургууль 4а хэсэг 1646тоот 	3	6500.00	0	9	f	0	2025-07-26 10:07:03.899+00	2025-08-04 07:24:06.532+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5968	2	89992412	Улаанбаатар, Хан-Уул 06-р хороо гарден велла хотхон 180 байр 	3	6500.00	0	29	f	0	2025-07-26 11:06:08.173+00	2025-08-21 11:48:47.568+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5986	2	88406970	Улаанбаатар, Сонгинохайрхан 27-р хороо Хангай захын эсрэг талд шар өнгийн таван давхар 19дугаар байр 5давхарт 21 тоот 	3	6500.00	0	9	f	0	2025-07-27 14:54:22.911+00	2025-07-29 04:41:19.793+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5989	2	95445523	Улаанбаатар, Хан-Уул 02-р хороо , Улаанбаатар, Хан-Уул, НЭХМЭЛ ХОТХОН 35В 6ДАВХАР 601ТООТ НЭХМЭЛ ХОТХОН 35В 6ДАВХАР 601ТООТ m	3	6500.00	0	6	f	0	2025-07-28 02:16:53.856+00	2025-07-29 12:03:31.803+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5983	2	89898262	Улаанбаатар, Хан-Уул 18-р хороо Hunnu 2222 202 bair 1 orts 901toot 	3	6500.00	0	\N	f	0	2025-07-27 10:17:18.869+00	2025-08-04 08:02:53.6+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5991	2	99116737	Улаанбаатар, Баянгол 06-р хороо Уб палас Дако 10а байр 104 тоот zalgaarai	3	6500.00	0	\N	f	0	2025-07-28 02:46:51.812+00	2025-08-04 08:03:41.682+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5993	2	99771634	Улаанбаатар, Хан-Уул 17-р хороо Улаанбаатар, Хан-Уул, 17-р хороо Ривер Гарден хотхон 302-502 тоот код #*1302# 	3	6500.00	0	\N	f	0	2025-07-28 03:55:33.812+00	2025-08-04 08:04:26.89+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5981	2	99041399	Улаанбаатар, Сүхбаатар 07-р хороо , Улаанбаатар, Сүхбаатар, 39-р Байр 39-R Bair 39а-52 тоот Дүүрэн төвтэй байр 39-р Байр 39-R Bair 39а-52 тоот Дүүрэн төвтэй байр utasaar tarij bgaad ereerei	3	12100.00	0	\N	f	0	2025-07-27 04:06:30.053+00	2025-08-04 07:53:28.033+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5973	2	91659859	Улаанбаатар, Баянгол 18-р хороо Улаанбаатар, Баянгол, 18-р хороо Андуудад байрлалтай  Яаралтай 24-48 цагийн дотор хүргэнэ үү	3	6500.00	0	9	f	0	2025-07-26 15:13:17.538+00	2025-07-31 04:03:33.403+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5980	2	88094295	Улаанбаатар, Сонгинохайрхан 25-р хороо Одонт 21-96а тоот\n 	3	6500.00	0	9	f	0	2025-07-27 03:07:41.366+00	2025-08-05 07:01:48.119+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
5975	2	99805342	Улаанбаатар, Хан-Уул 02-р хороо Бадрах хотхон, 18-р байр, 8 давхар, 801 тоот 	3	12100.00	0	\N	f	0	2025-07-26 16:10:13.333+00	2025-08-04 07:53:44.39+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5976	2	99805342	Улаанбаатар, Хан-Уул 02-р хороо Бадрах хотхон, 18-р байр, 8 давхар, 801 тоот 	3	12100.00	0	\N	f	0	2025-07-26 16:10:13.78+00	2025-08-04 07:53:44.39+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5988	2	99988198	Улаанбаатар, Баянгол 03-р хороо , Улаанбаатар, Баянгол, tomor zamiin bars 1 hudaldaanii tov tomor zamiin bars 1 hudaldaanii tov ajiliin tsagaar avah 9 -18	3	6500.00	0	9	f	0	2025-07-28 01:20:26.642+00	2025-08-07 07:37:34.802+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
5972	2	99185095	Улаанбаатар, Хан-Уул 03-р хороо Таван Богд Группийн төв байр /ресепшин дээр үлдээх/ хаяг дээр ирээд 99185095 дугаараар холбогдох	3	6500.00	0	6	f	0	2025-07-26 12:42:17.399+00	2025-08-12 06:27:42.334+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5979	2	90880894	Улаанбаатар, Баянзүрх 23-р хороо Улиастай шинэ эцэс Баатар хайрхан 780 тоот\n Утас 90880894 	3	6500.00	0	9	f	0	2025-07-27 02:51:08.558+00	2025-07-31 09:09:38.394+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
5992	2	88665582	Улаанбаатар, Баянзүрх 30-р хороо 28.5r bair 2 orts 10 davhart 137 toot 	3	6500.00	0	9	f	0	2025-07-28 02:54:51.537+00	2025-07-29 06:12:17.556+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5984	2	86685236	Улаанбаатар, Чингэлтэй 15-р хороо Hailaast 15 horoo 71-1118 toot\n\n 	3	6500.00	0	9	f	0	2025-07-27 12:19:41.882+00	2025-08-05 07:49:00.237+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5987	2	99063769	Улаанбаатар, Хан-Уул 18-р хороо Gerlug vista 58-4 байр 2101 тоот  	3	6500.00	0	6	f	0	2025-07-27 16:00:48.893+00	2025-07-29 12:03:28.316+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5990	2	99081081	Улаанбаатар, Хан-Уул, 21-р хорооHasu villa town 1003 toot, Hurdnii zam 100 modnii zam saldag uulzwar ub oil klonkoos 150 m unglued baruun irgene 95958765 dugaar luu zalgah hurgeltiin omno	3	12100.00	0	4	f	0	2025-07-28 02:28:05.309+00	2025-07-29 08:08:40.354+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6245	2	99471727	Улаанбаатар, Хан-Уул 10-р хороо Han uul duureg moringiin davaa 1-9 \nDugaar-96607949 96607949 	3	6500.00	0	\N	f	0	2025-08-11 15:03:08.312+00	2025-08-14 12:40:06.907+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5985	17	99014296	Petrovisiin tuw office 	3	43000.00	Ажлын цагаар авна	6	f	0	2025-07-27 13:49:05.342+00	2025-07-30 08:09:41.772+00	f	\N	\N	\N
6284	17	96216696	Эрин хороолол 53/10байр, 2р орц, 2 давхар 67 тоот - 4с өмнө хүргэвэл энэ хаяг дээр 	3	66000.00	4-с хойш хүргэхээр болчихвол Цамбгаравын баруун талын 18-р байр, 4-р давхар 15 тоот 	9	f	0	2025-08-15 01:15:59.556+00	2025-08-15 09:47:50.957+00	f	\N	\N	\N
5974	2	95524568	Улаанбаатар, Баянгол 03-р хороо 4015 	3	6500.00	0	6	f	0	2025-07-26 15:40:44.913+00	2025-07-29 11:36:47.016+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5977	2	99805342	Улаанбаатар, Хан-Уул 02-р хороо Бадрах хотхон, 18-р байр, 8 давхар, 801 тоот 	3	12100.00	0	\N	f	0	2025-07-26 16:11:15.558+00	2025-08-04 07:53:44.39+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5995	2	99760418	Улаанбаатар, Баянзүрх 14-р хороо БЗД 14р хороо аман хуур хотхоны эсрэг талд 34А байр irehees omno zalgah	3	6500.00	0	9	f	0	2025-07-28 05:55:58.275+00	2025-07-31 13:28:30.347+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5997	2	95445523	Улаанбаатар, Хан-Уул 02-р хороо , Улаанбаатар, Хан-Уул, НЭХМЭЛ ХОТХОН 35В 6ДАВХАР 601ТООТ НЭХМЭЛ ХОТХОН 35В 6ДАВХАР 601ТООТ m	3	6500.00	0	\N	f	0	2025-07-28 06:59:05.42+00	2025-08-04 08:04:26.89+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6011	2	88444414	Улаанбаатар, Баянгол 24-р хороо Улаанбаатар, Баянгол, 24-р хороо four season village bair 35-1 12 davhar 50 toot "hajuuda dema emneleg bolno world wine tai" 	3	6500.00	0	\N	f	0	2025-07-28 12:58:12.936+00	2025-08-04 08:05:18.811+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5998	2	88008860	Улаанбаатар, Сүхбаатар 01-р хороо Blue sky tower 6 davhar 603 toot  	3	6500.00	0	6	f	0	2025-07-28 07:50:30.624+00	2025-07-31 07:43:23.437+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6013	2	90213383	Улаанбаатар, Баянзүрх 16-р хороо Хорго хотгоны ард 11р байр 6давхар 29тоот 	3	6500.00	0	9	f	0	2025-07-28 14:18:35.955+00	2025-07-31 08:26:35.936+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6000	2	80640056	Улаанбаатар, Хан-Уул 04-р хороо Хүннү Вилла, 1404-18, давхар 3. би монгол хүн биш. 80640056 дугаарт мессеж илгээх юмуу орон сууцны үүдний гадаа илгээмж үлдээнэ үү. Та ирэхдээ байрны үүдэнд хүргэж өгөх юм уу 80640056 дугаарт мессеж илгээнэ үү.	3	6500.00	0	4	f	0	2025-07-28 08:05:34.536+00	2025-08-01 08:57:29.152+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6001	2	89521858	Улаанбаатар, Сонгинохайрхан 34-р хороо Найрамдал Баянголын тэс колонк 	3	6500.00	0	9	f	0	2025-07-28 08:34:05.221+00	2025-07-31 05:28:14.848+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6012	2	88444414	Улаанбаатар, Баянгол 24-р хороо Улаанбаатар, Баянгол, 24-р хороо four season village bair 35-1 12 davhar 50 toot "hajuuda dema emneleg bolno world wine tai" 	3	6500.00	0	6	f	0	2025-07-28 12:58:14.363+00	2025-07-29 12:03:36.616+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6003	2	94639775	Улаанбаатар, Баянгол 07-р хороо Royal smile шүдний эмнэлэг в1 давхарт\n Art spa baysaa gedg xuni xurgelt geed xeleed uguurei	3	6500.00	0	6	f	0	2025-07-28 09:08:51.606+00	2025-07-30 12:17:20.699+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6004	2	94173909	Улаанбаатар, Баянгол 09-р хороо Шинэ хороолол хотхон 85б байр 9 давхар 69 тоот 	3	6500.00	0	6	f	0	2025-07-28 10:08:26.39+00	2025-07-30 12:31:18.756+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6235	2	99280997	Улаанбаатар, Сүхбаатар 04-р хороо Beattles хөшөөний хажуу Голомт банк 	3	6500.00	0	\N	f	0	2025-08-11 10:38:55.107+00	2025-08-15 03:21:57.969+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6006	2	99185095	Улаанбаатар, Хан-Уул 03-р хороо Таван Богд Группийн төв байр /ресепшин дээр үлдээх/ Ресепшин дээр ирээд 99185095 дугаараар заалгах	3	6500.00	0	4	f	0	2025-07-28 10:28:03.199+00	2025-08-01 07:48:41.819+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5994	2	89880093	Улаанбаатар, Хан-Уул 03-р хороо 5 богдын замын урд Номин Юнайтед 3.5 давхарт Оффис тул 9-18 цагийн хооронд авах	3	6500.00	0	6	f	0	2025-07-28 05:54:09.846+00	2025-07-30 08:40:17.81+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6008	2	86031877	Улаанбаатар, Баянзүрх 26-р хороо Mandala hothon 320/2r bair 8 davhar 85 toot code:honh1234 	3	6500.00	0	6	f	0	2025-07-28 11:02:47.787+00	2025-08-02 05:17:24.078+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5996	2	86638977	Улаанбаатар, Баянзүрх, 26-р хорооЧухаг 2 хотхон chuhag 2 hothon, Баянзүрх дүүрэг 26-р хороо ЧУХАГ-2 хотхон 602-р байр 5 давхар 12 тоот Өдрийн цагаар гэртэй байхгүй тул орой хүртэл авна. 	3	12100.00	0	\N	f	0	2025-07-28 06:26:51.867+00	2025-08-04 07:49:28.35+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6005	2	88009634	Улаанбаатар, Сүхбаатар 01-р хороо Soylj malliin zamiin esreg tald 4 dawhar shilen nogoon bair ento gsn barilga b1 dawhar uran ger ahiun delguur 	3	6500.00	0	\N	f	0	2025-07-28 10:16:43.251+00	2025-08-04 08:05:27.402+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6007	2	83000512	Улаанбаатар, Баянзүрх 02-р хороо Эпимон эмнэлэгийн арын хашаа 3 А тоот 	3	6500.00	0	9	f	0	2025-07-28 10:53:15.344+00	2025-07-29 05:42:54.251+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6010	2	88050019	Улаанбаатар, Сонгинохайрхан 20-р хороо Хүнсчдийн гудамж, 29-р байр, 27тот 	3	12100.00	0	\N	f	0	2025-07-28 12:35:28.367+00	2025-08-04 07:49:19.229+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6236	2	99280997	Улаанбаатар, Сүхбаатар 04-р хороо Beattles хөшөөний хажуу Голомт банк 	3	6500.00	0	\N	f	0	2025-08-11 10:38:55.314+00	2025-08-15 03:21:57.969+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
5999	2	89030031	Улаанбаатар, Баянзүрх 25-р хороо БЗД,25-р хороо, шөнийн захын замын эсрэг талын 62-р байр, 3-р орц, 12-229тоот  	3	6500.00	0	9	f	0	2025-07-28 07:57:05.92+00	2025-07-31 10:06:32.667+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6009	2	99771634	Улаанбаатар, Хан-Уул 17-р хороо Улаанбаатар, Хан-Уул, 17-р хороо Ривер Гарден хотхон 302-502 тоот код #*1302# 	3	6500.00	0	\N	f	0	2025-07-28 12:14:31.197+00	2025-08-04 08:05:27.402+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6246	15	99164971	ХУД, 18 хороо, Акояа рэзидэнс, 54-Б байр, 801 тоот	3	1.00	1	6	t	5	2025-08-12 01:24:59.226+00	2025-08-18 18:43:50.086+00	f	\N	\N	\N
6020	2	80318865	Улаанбаатар, Хан-Уул, 8-р хорооАктив гарден, Active Garden хотхон, 502 байр, 13 давхар, 85 тоот (орцны код: 502#) 	3	6500.00	0	\N	f	0	2025-07-29 03:27:51.45+00	2025-08-04 07:48:57.027+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6018	2	99090846	Улаанбаатар, Чингэлтэй 01-р хороо Гандирс 3-р давхарт ирэхээсээ өмнө залгах	3	6500.00	0	6	f	0	2025-07-29 02:26:28.18+00	2025-07-31 07:17:59.381+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6029	2	98159769	Улаанбаатар, Чингэлтэй 20-р хороо Баян хошуу хөтөл 149-сургууль\n 98159769	3	6500.00	0	9	f	0	2025-07-29 08:56:19.845+00	2025-07-31 06:34:52.459+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6026	2	99146884	Улаанбаатар, Баянзүрх 04-р хороо Hil hamgaalah yrunhii gazriin yrtuntsiin zugeer urd tald Unipress gd haygtai uildwer bgaa. Google map deer unipress hevleh uildwer gd bga 	3	6500.00	0	9	f	0	2025-07-29 07:34:16.812+00	2025-07-31 09:05:16.725+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6024	2	89985924	Улаанбаатар, Хан-Уул 17-р хороо River Garden 317 bair. 89740977, 99090396 	3	12100.00	0	\N	f	0	2025-07-29 05:09:34.657+00	2025-08-10 04:50:01.199+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6017	2	90304424	Улаанбаатар, Сонгинохайрхан 20-р хороо Шинэ драгон Шинэ драгоноос Архангай аймгийн автобусанд тавина. Өдөр бүр 08, 14, 19 цагуудад тус тус явна 	3	6500.00	0	9	f	0	2025-07-29 02:22:50.791+00	2025-07-31 05:19:14.254+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6027	2	95096446	Улаанбаатар, Хан-Уул 15-р хороо , Улаанбаатар, Хан-Уул, River Villa, 8/2-р орц, 10 давхар, 137 тоот River Villa, 8/2-р орц, 10 давхар, 137 тоот 	3	6500.00	0	6	f	0	2025-07-29 08:02:16.744+00	2025-07-30 10:47:44.329+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6035	2	99278103	Улаанбаатар, Баянгол, 4-р хороо018, Hermes барилгын материалын дэлгүүрийн замын зүүн урд талд, 018-р байр. 7 давхарт 44 тоот 	3	6500.00	0	9	f	0	2025-07-29 11:28:35.382+00	2025-08-03 03:12:01.809+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
5971	2	95515967	Улаанбаатар, Сонгинохайрхан 10-р хороо Баянхошуу шинэ эцэс збу 11-2б Баянхошуу шинэ эцэс дээр ирээд залгах	3	6500.00	0	9	f	0	2025-07-26 12:33:03.643+00	2025-07-29 04:55:05.568+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6028	2	94622883	Улаанбаатар, Сонгинохайрхан 33-р хороо Тахилт 1-1а 	3	6500.00	0	\N	f	0	2025-07-29 08:14:10.386+00	2025-08-14 05:14:16.074+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6025	2	80917750	Улаанбаатар, Сонгинохайрхан 36-р хороо Улаанчулуут эцэс  	3	6500.00	0	9	f	0	2025-07-29 07:27:30.528+00	2025-08-05 06:07:00.455+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6036	17	99314852	Бичил Энхболд зам, 100 метр яваад Баян Эрдэнэ дэлгүүр байгаа 	3	43000.00	Очихдоо ярих	6	f	0	2025-07-29 11:28:53.656+00	2025-07-31 05:27:36.436+00	f	\N	\N	\N
6002	2	99108289	Улаанбаатар, Баянзүрх 06-р хороо , Улаанбаатар, Баянзүрх, 13-р хороолол Баянзүрх захын зүүн урд талын К7 байр 9 давхарт 30 тоот, код:30B 13-р хороолол Баянзүрх захын зүүн урд талын К7 байр 9 давхарт 30 тоот, код:30B 	3	6500.00	0	9	f	0	2025-07-28 08:46:20.531+00	2025-07-29 07:52:56.809+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6022	2	99111141	Улаанбаатар, Баянгол 09-р хороо horoolliin etes e martiin bariin tald tti kampani \n tti	3	6500.00	0	6	f	0	2025-07-29 03:51:03.089+00	2025-07-31 06:20:39.484+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6247	2	95668348	Улаанбаатар, Баянгол 29-р хороо tsam garviin nomingiin 43r bair 3davhar 306 toot 95668348	3	6500.00	0	9	f	0	2025-08-12 01:27:36.264+00	2025-08-14 09:40:13.065+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6030	2	95901553	Улаанбаатар, Сүхбаатар 06-р хороо 37р байр 64 тоот 95901553 37р байр	3	6500.00	0	6	f	0	2025-07-29 09:12:03.343+00	2025-07-31 07:30:59.962+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6033	2	89000720	Улаанбаатар, Баянзүрх 05-р хороо Кино үйлдвэрийн хойно Happytown 73-167 	3	6500.00	0	9	f	0	2025-07-29 09:24:15.566+00	2025-07-31 08:53:45.412+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6032	2	90181506	Улаанбаатар, Чингэлтэй 24-р хороо Шадвилан 1-30 	3	6500.00	0	4	f	0	2025-07-29 09:22:36.028+00	2025-08-08 08:30:45.627+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6031	2	99757369	Улаанбаатар, Сонгинохайрхан 19-р хороо Схд 19 хороо Залуус 2 хотхон 3 орц 215 тоот\n 	3	6500.00	0	9	f	0	2025-07-29 09:21:27.122+00	2025-07-31 04:59:40.47+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6034	2	91095007	Улаанбаатар, Хан-Уул 04-р хороо Huushiin am, Jade villa hothon, 609 r toot 	3	6500.00	0	4	f	0	2025-07-29 10:05:19.836+00	2025-08-01 09:05:08.753+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6021	2	99677747	Улаанбаатар, Баянгол 29-р хороо Хархорин зах,Эрин хороолол 53/7байр 11давхар 50тоот орцны код*#5371 	3	6500.00	0	9	f	0	2025-07-29 03:34:43.932+00	2025-08-01 05:30:14.44+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6019	2	88885042	Улаанбаатар, Хан-Уул 15-р хороо Цэнгэлдэх хотхон 214 байр 2004 тоот 	3	6500.00	0	6	f	0	2025-07-29 03:04:26.533+00	2025-07-30 11:16:25.068+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6384	32	88118554	Хануул дүүрэг 17 дугаар хороо Кинг Таувер 143.220 тоот	3	39000.00	2	6	t	8	2025-08-18 16:45:19.2+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6052	2	88112075	Улаанбаатар, Сүхбаатар 01-р хороо Улаанбаатар, Сүхбаатар, 1-р хороо Selbe comfort хотхон  СБД, 1 хороо, Selbe comfort,  52, 3 орц, 135тоот	3	6500.00	0	\N	f	0	2025-07-29 19:31:22.913+00	2025-08-08 07:28:31.48+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6058	2	88009634	Улаанбаатар, Сүхбаатар 01-р хороо Soylj malliin zamiin esreg tald 4 dawhar shilen nogoon bair ento gsn barilga b1 dawhar uran ger ahiun delguur 	3	6500.00	0	\N	f	0	2025-07-30 05:09:35.966+00	2025-08-04 08:08:18.108+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6042	2	99141421	Улаанбаатар, Баянзүрх 08-р хороо Хууль сахиулах хотгон 49в байр 9 давхар 39тоот ургашаа харсан нэг орцтой орцны код 7913# 	3	6500.00	0	9	f	0	2025-07-29 12:39:25.739+00	2025-07-31 08:07:52.539+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6056	2	88840614	Улаанбаатар, Хан-Уул 23-р хороо Нүхтийн зам, Сансет хотхон, 770-р байр 02 тоот 	3	6500.00	0	\N	f	0	2025-07-30 04:26:16.701+00	2025-08-04 07:48:27.391+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6043	2	99728223	Улаанбаатар, Баянзүрх, 26-р хорооparadise plaza, 2 давхар 210 тоот Ochhooroo zalgaj medegdeh utas 98110027	3	6500.00	0	6	f	0	2025-07-29 12:57:25.398+00	2025-07-30 10:18:18.669+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6045	2	88109187	Улаанбаатар, Чингэлтэй 24-р хороо Doloon buudal deer huleej avna Doloon buudal duhuud zalgah 88109187, 88040145	3	6500.00	0	9	f	0	2025-07-29 13:35:07.356+00	2025-08-05 08:24:10.337+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6048	2	99018902	Улаанбаатар, Баянзүрх 12-р хороо Улаанбаатар, Баянзүрх, 12-р хороо 2гудамж жанжингийн 38 тоот " ботаник оргилийн зүүн талаар урагшаагаа эргээд хамгийн эхний гудамж 38 тоот"  	3	6500.00	0	9	f	0	2025-07-29 15:17:56.026+00	2025-08-09 03:48:57.592+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6047	2	99141628	Улаанбаатар, Сонгинохайрхан 07-р хороо Хилчин хотхон 11-117\n\n 	3	6500.00	0	9	f	0	2025-07-29 14:30:09.106+00	2025-07-31 06:08:24.52+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6055	2	88737183	Улаанбаатар, Баянзүрх, 8-р хорооБаянзүрх хотхон 104-р байр , Офцэр тэнгэр плаза баруун талд 5 байрны 104 байр 6 тоот  	3	6500.00	0	9	f	0	2025-07-30 03:37:57.961+00	2025-08-01 10:03:39.588+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
5836	2	89509494	Улаанбаатар, Хан-Уул 20-р хороо Uildwer, chingisiin urgun chuluu gudamj, tsagaan ord tower 92A bair 13 dawhar 166 toot ireheese umnu zalgana uu 89509494	3	12100.00	0	\N	f	0	2025-07-21 08:06:14.437+00	2025-07-29 16:29:18.853+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6057	2	99174700	Улаанбаатар, Хан-Уул 23-р хороо Улаанбаатар, Хан-Уул, 23-р хороо Яармаг.Garden city 1301-1-302. xaalgani kod #107301#\nUtas 99174700 	3	6500.00	0	\N	f	0	2025-07-30 04:48:36.124+00	2025-08-04 07:52:56.065+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6248	2	91867272	Улаанбаатар, Сонгинохайрхан, 12-р хороо6 байр, 12 horoo 6bair 6dawhar 35toot 91867272	3	6500.00	0	9	f	0	2025-08-12 02:00:43.929+00	2025-08-14 09:51:15.827+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6053	2	96880606	Улаанбаатар, Баянгол 16-р хороо 25р эмийн сан жэм молл 4 давхар 413 тоот 	3	6500.00	0	9	f	0	2025-07-30 01:41:15.835+00	2025-08-01 05:33:21.059+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6054	2	99278103	Улаанбаатар, Баянгол, 4-р хороо018, Hermes барилгын материалын дэлгүүрийн замын зүүн урд талд, 018-р байр. 7 давхарт 44 тоот 	3	6500.00	0	9	f	0	2025-07-30 03:08:44.817+00	2025-08-03 03:12:09.979+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6051	2	99866416	Улаанбаатар, Хан-Уул 02-р хороо 22-r bair, 4-r orts,3davhar, 53toot 	3	12100.00	0	\N	f	0	2025-07-29 16:46:17.714+00	2025-08-04 07:48:43.366+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6039	2	89103334	Улаанбаатар, Хан-Уул 18-р хороо Улаанбаатар, Хан-Уул, 19-р хороо ub town 81a 19 toot худ 19 хороо ubtown хотхон 81а байр 3 давхарт 19 тоот орцны код 4589# 	3	6500.00	0	\N	f	0	2025-07-29 12:01:00.373+00	2025-08-04 08:06:40.78+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6041	2	99771634	Улаанбаатар, Хан-Уул 17-р хороо Улаанбаатар, Хан-Уул, 17-р хороо Ривер Гарден хотхон 302-502 тоот код #*1302# 	3	6500.00	0	\N	f	0	2025-07-29 12:15:41.388+00	2025-08-04 08:07:02.834+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6040	2	89898224	Улаанбаатар, Хан-Уул 21-р хороо buynt uhaa2 1044 bair 5dawhar 25toot utasni dugar:89898224	3	6500.00	0	\N	f	0	2025-07-29 12:13:27.36+00	2025-08-08 07:26:47.425+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6044	2	88102515	Улаанбаатар, Баянзүрх, 26-р хорооGlobal park, Global park, B2 Block, 17th floor, 1705 	3	6500.00	0	6	f	0	2025-07-29 13:06:26.698+00	2025-07-30 11:03:10.744+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6049	2	88100459	Улаанбаатар, Хан-Уул 20-р хороо Улаанбаатар, Хан-Уул, 20-р хороо Хан уул дүүргийн урд Ивээл хотхон 41а байр 207тоот 	3	6500.00	0	4	f	0	2025-07-29 15:55:08.171+00	2025-08-20 11:10:55.912+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6067	2	99903382	Улаанбаатар, Сонгинохайрхан 23-р хороо Улаанбаатар, Сонгинохайрхан, 23-р хороо Баянголын ам. Задгай. Орбитын эцсийн буудал дээрээс авна. 	3	6500.00	0	9	f	0	2025-07-30 10:09:35.683+00	2025-08-08 06:34:05.128+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6061	2	88894388	Улаанбаатар, Чингэлтэй 01-р хороо Ard kino teathriin yg zuun tald Cozy decoration store Ард кино театрын хаяган дээр 8с өмнө хүргүүлэх боломжтой. Хэрвээ 8с хойш бол 5ш шарын 8р байрны 4р орцны 48тоотод авах.	3	6500.00	0	9	f	0	2025-07-30 06:11:13.158+00	2025-08-03 03:40:18.75+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6062	2	86988872	Улаанбаатар, Хан-Уул 21-р хороо Буянт-ухаа таур 603,605 	3	6500.00	0	4	f	0	2025-07-30 06:40:54.466+00	2025-08-01 08:23:31.565+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6079	2	99000060	Улаанбаатар, Хан-Уул 07-р хороо Encanto orange town 200c bair 8 davhart 171 toot, ireheesee umnu zalgah ireheesee umnu zalgah	3	6500.00	0	18	f	0	2025-07-31 03:02:10.149+00	2025-08-04 07:49:41.891+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6066	2	86685236	Улаанбаатар, Чингэлтэй 15-р хороо Hailaast 15 horoo 71-1118 toot\n\n Хайлааст 15 хороо 71-1118	3	6500.00	0	9	f	0	2025-07-30 09:54:03.452+00	2025-08-05 07:49:15.36+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6069	2	94639775	Улаанбаатар, Баянгол 07-р хороо Royal smile шүдний эмнэлэг в1 давхарт\n Art spa baysaa gedg xuni xurgelt geed xeleed uguurei	3	6500.00	0	\N	f	0	2025-07-30 10:25:00.176+00	2025-08-08 07:28:31.48+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6073	2	80569048	Улаанбаатар, Баянгол 20-р хороо Enhjin 19-surguulin  hajud us suwgiin 29dvgeer bair ehnii orts 4 dawhar 12 toot\n 	3	6500.00	0	9	f	0	2025-07-30 14:05:11.598+00	2025-08-05 05:44:00.703+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6059	2	88105129	Улаанбаатар, Хан-Уул 18-р хороо Хүннү2222 221Р байр 5 давхарт 504 тоот орцны код 2345confirm 	3	6500.00	0	\N	f	0	2025-07-30 05:44:32.821+00	2025-08-04 08:08:18.108+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6075	2	99025208	Улаанбаатар, Хан-Уул 24-р хороо Улаанбаатар, Хан-Уул, 24-р хороо Han Uul duureg 24r horoo Bogd Vista 1213 байр 2 давхарт 203toot 99007688 дугаарын утсан дээр хүлээн авна	3	6500.00	0	22	f	0	2025-07-30 15:50:52.426+00	2025-08-06 10:58:32.598+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6065	17	99196116	удирдлагын академи 1-67р байр, 3 давхар,5 тоот	3	60000.00	torgoljin mongolia hajuud - yaraltai hurgelt	\N	f	0	2025-07-30 09:24:23.956+00	2025-07-30 11:19:43.889+00	f	\N	\N	\N
6071	2	80305458	Улаанбаатар, Баянзүрх 23-р хороо 5хэсэг 1319 	3	6500.00	0	9	f	0	2025-07-30 11:54:37.54+00	2025-08-04 07:24:17.577+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6037	2	88805979	Улаанбаатар, Баянгол 08-р хороо 12-р байр, 5 тоот (Сэцэн мед эмнэлгийн зүүн талын 12р байр 	3	6500.00	0	6	f	0	2025-07-29 11:33:41.473+00	2025-07-30 12:01:11.683+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6068	2	80339911	Улаанбаатар, Хан-Уул, 15-р хорооЦэлмэг Хотхон 87-р байр Tselmeg Hothon 87-r bair, Улаанбахтар сувилалын баруун урд Цэлмэг хотхон 86-р байр 1орц 4давхар 8тоот 	3	6500.00	0	6	f	0	2025-07-30 10:14:39.413+00	2025-08-02 03:26:02.741+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6074	2	99746504	Улаанбаатар, Хан-Уул 04-р хороо Яармаг Шүншиг вилла 3 241-р байр 1-р орц 15 давхар 73 тоот код нь 2411# 	3	6500.00	0	4	f	0	2025-07-30 15:06:55.49+00	2025-08-01 08:41:36.651+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6077	2	88336006	tokyo town 	3	6500.00	0	6	f	0	2025-07-31 02:07:30.798+00	2025-08-06 08:06:37.641+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6249	2	99471727	Улаанбаатар, Хан-Уул 10-р хороо Han uul duureg moringiin davaa 1-9 \nDugaar-96607949 80998286	3	6500.00	0	\N	f	0	2025-08-12 03:06:22.465+00	2025-08-14 12:40:06.907+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6064	2	99222099	Улаанбаатар, Баянзүрх 16-р хороо 72-р хотхон 51/1 	3	6500.00	0	9	f	0	2025-07-30 07:29:24.058+00	2025-08-02 07:48:07.42+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6063	2	80977779	Улаанбаатар, Баянзүрх 37-р хороо 9-254тоот 	3	6500.00	0	9	f	0	2025-07-30 07:24:23.41+00	2025-08-03 07:03:37.683+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6078	2	88018954	Улаанбаатар, Баянгол 31-р хороо Нарлаг хотхон 103р байр 6д 51т орцны код51в Гэмтэл нарлаг хотхон 103-р байр 6д 51т 1орцтой орцны код 51в	3	6500.00	0	6	f	0	2025-07-31 02:44:27.538+00	2025-08-02 05:48:17.323+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6070	2	99992355 90954549	ХУД, Цэнгэлдэх хотхон, 208-б байр, 1903 тоот. Утас 90954549	3	6500.00	0	6	f	0	2025-07-30 10:28:21.143+00	2025-08-03 07:28:16.175+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6060	2	86061161	Улаанбаатар, Хан-Уул 17-р хороо King tower 145 bair 6 davhart 237 toot 	3	6500.00	0	\N	f	0	2025-07-30 05:49:17.722+00	2025-08-04 08:08:18.108+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6072	2	99147488	Улаанбаатар, Сүхбаатар 01-р хороо Замын цагдаа, 5 богдын чанх ард 34-р байр 2 давхарт 5 тоот.  	3	6500.00	0	\N	f	0	2025-07-30 13:12:53.73+00	2025-08-08 07:28:31.48+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6402	33	88389770	Хөвсгөл	3	35000.00	тооцоогоо авсан байгаа	18	f	0	2025-08-19 01:47:21.257+00	2025-08-19 09:57:04.688+00	f	\N	\N	\N
6408	31	89894779	Их наядын урд Саруул хороолол 118- р байр 1р орц 6 тоот	3	37000.00	a	6	t	8	2025-08-19 02:23:07.487+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6091	2	95543388	Улаанбаатар, Баянзүрх 08-р хороо Ботаник, ус 15 хотхон 4-р байр 60 тоот 	3	6500.00	0	9	f	0	2025-07-31 13:00:31.887+00	2025-08-03 10:01:07.471+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6085	2	89911961	Улаанбаатар, Сүхбаатар 11-р хороо Улаанбаатар, Сүхбаатар, 11-р хороо New recidence хотхон Нью ресиденсе 722 байр 11 давхар 137 тоот\n\n 	3	6500.00	0	9	f	0	2025-07-31 06:05:09.82+00	2025-08-05 13:30:58.182+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6097	2	90092035	Улаанбаатар, Баянгол 01-р хороо Богд-Ар хороолол, 16а байр, 2р орц, 3 давхар, 26 тоот Орцны хаалга утсаар онгойно.	3	6500.00	0	9	f	0	2025-08-01 04:15:48.843+00	2025-08-06 13:28:30.273+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6089	2	88741508	Улаанбаатар, Хан-Уул 24-р хороо Bogd villa hothon, 1205 bair, 1r orts, 12 davhar, 67 toot 	3	6500.00	0	6	f	0	2025-07-31 10:20:56.767+00	2025-08-05 11:13:42.381+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6086	2	80220510	Улаанбаатар, Сонгинохайрхан 35-р хороо 80н 45а 	3	6500.00	0	9	f	0	2025-07-31 07:34:12.589+00	2025-08-03 04:02:10.163+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6046	2	90208900	Улаанбаатар, Баянзүрх 22-р хороо Улаанбаатар, Баянзүрх, 22-р хороо Баянзүрх дүүргийн эсрэг талын автобусны буудлын яг хойно 16 давхар шинэ байр, баруун зүг харсан 1 орцтой, 5 давхарт, 25 тоот 	3	6500.00	0	9	f	0	2025-07-29 13:41:59.424+00	2025-07-31 08:42:44.363+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6287	2	99882626	Улаанбаатар, Хан-Уул 17-р хороо River garden-2, 403 bair, 6 davhar, 602 toot Orts kod: 401103, nemelt utas 80446367, 80336367	1	12100.00	0	\N	f	0	2025-08-15 06:35:33.279+00	2025-08-15 06:35:33.293+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6092	2	85133399	Улаанбаатар, Баянзүрх, 26-р хорооSanto life 714, Santo life 714 2 orts 205 toot Irheesee umnu holbogdooroi	3	6500.00	0	6	f	0	2025-07-31 13:20:04.207+00	2025-08-03 08:27:45.441+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6090	2	88703700	Улаанбаатар, Баянзүрх 04-р хороо Американ дэнж хотхон 44/6 2-р орц 9 давхар 100 тоот орцны код 1123# 8 сарын 1 20 цагаас хойш ирэх	3	6500.00	0	9	f	0	2025-07-31 11:49:57.275+00	2025-08-03 13:51:50.055+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6082	2	99918859	Улаанбаатар, Чингэлтэй 06-р хороо Баянбүрдийн тойргын чанх урд талын 9 давхар 26-р байр. 1-р орц 24тоот. Орц чиптэй тул доор ирээд залгах 80005278	3	12100.00	0	\N	f	0	2025-07-31 03:51:49.561+00	2025-08-08 07:28:31.48+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6080	2	99100224	Улаанбаатар, Баянзүрх 26-р хороо Глобаль парк хотхон 711 байр 2-р орц 305 тоот 	3	12100.00	0	6	f	0	2025-07-31 03:13:50.828+00	2025-08-03 08:15:08.074+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6081	2	80907887	Улаанбаатар, Хан-Уул, 16-р хорооХүннү2222-117 р байр, Хүннү 2222-117 р байр 3с тоот  Орцны код ##1171#\n	3	6500.00	0	\N	f	0	2025-07-31 03:31:04.919+00	2025-08-04 08:09:48.424+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6250	15	99880726	Эрдэнэтрүү унаанд тавих	3	1.00	1	18	f	0	2025-08-12 03:30:06.563+00	2025-08-12 11:26:56.719+00	f	\N	\N	\N
6088	2	88894388	Улаанбаатар, Сонгинохайрхан 18-р хороо 5n shar, 8r bair 48 toot 	3	6500.00	0	9	f	0	2025-07-31 09:38:06.852+00	2025-08-03 03:40:54.429+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6093	15	99087128	Кинг тауэр 129 байр 2 лрц 8 давхар 255 тоот	3	1.00	1	19	f	0	2025-07-31 13:22:54.557+00	2025-08-03 05:22:58.076+00	f	\N	\N	\N
6095	2	88840614	Улаанбаатар, Хан-Уул 23-р хороо Нүхтийн зам, Сансет хотхон, 770-р байр 02 тоот 	3	6500.00	0	\N	f	0	2025-07-31 23:52:34.252+00	2025-08-04 07:48:27.391+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6386	32	85116782	Хүннү молби нэг давхарт бенэттон дэлгүүр дээр авъя.	1	25000.00	4	\N	f	0	2025-08-18 16:48:20.651+00	2025-08-19 02:29:50.265+00	t	\N	\N	\N
6096	2	99939802	Улаанбаатар, Хан-Уул 21-р хороо Ханбогд хорооло 409-р байр 2р орц 4давхар 409тоот Вива сити замын эсрэг талд Фүүдситт	3	6500.00	0	6	t	8	2025-08-01 03:41:02.769+00	2025-08-20 15:41:14.642+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6083	2	99029476	Улаанбаатар, Баянзүрх 06-р хороо БЗД-13хороолол бөхийн өргөө баруун урд талд баянзүрх захын зүүн талд эрхэт 75 байр 	3	6500.00	0	9	f	0	2025-07-31 04:12:03.262+00	2025-08-02 08:36:26.454+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6084	2	94991867	Улаанбаатар, Хан-Уул 11-р хороо Zaisan Orgil hothon 6-3/ Grass avto ugaalgaar zuun ergene/ Grass avto ugaalgaar zuun ergene	3	6500.00	0	\N	f	0	2025-07-31 05:46:52.686+00	2025-08-04 08:09:48.424+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6076	2	89072311	Улаанбаатар, Баянзүрх 39-р хороо Тэнүүн хотхон 25-65 тоот. Орой 20 цагаас хойш хүргэх Орой 20 цагаас хойш хүргэнэ үү.	3	6500.00	0	9	f	0	2025-07-31 02:06:46.408+00	2025-08-02 12:49:34.407+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6094	15	95952281	japan town c-5 bair	3	1.00	1	19	f	0	2025-07-31 14:05:17.806+00	2025-08-03 05:22:58.076+00	f	\N	\N	\N
6103	2	99033652	Улаанбаатар, Чингэлтэй 05-р хороо Нисдэг машин эсрэг талд,18р байр,8 давхар 32 тоот байрны код 32Б/32B 	3	6500.00	0	9	f	0	2025-08-01 10:01:06.553+00	2025-08-05 13:07:28.915+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6104	15	99317683	ХУД 21-р хороо Эвэл апартмент 434 байр 1-р орц 7 давхар 709	3	1.00	1	4	f	0	2025-08-01 11:39:57.327+00	2025-08-02 09:32:24.138+00	f	\N	\N	\N
6100	17	80804662	Увс Улаангом автобусанд дугаарыг нь бичээд тавих	3	3.00	Орбит ордог номингийн тэндээс өглөө 11н цагт явдаг гэсэн. Тавиад дугаарлуу нь автобусны мэдээллийг нь явуулаад өгөөрэй. Баярлалаа 	18	f	0	2025-08-01 08:44:28.643+00	2025-08-02 03:31:30.068+00	f	\N	\N	\N
6123	17	89338931	Цамба, 13-р байр 3р орц 166 тоот	3	43000.00	5с өмнө очих 5с хөдлөх унаанд тавиад хөдөө явуулах гэж байгаа 	18	f	0	2025-08-04 00:18:15.305+00	2025-08-05 03:03:56.188+00	f	\N	\N	\N
6113	2	99937000	Улаанбаатар, Сонгинохайрхан 24-р хороо Улаанбаатар, Сонгинохайрхан, 24-р хороо Зээлийн 27-39тоот Баруун салааны 6-р буудал Дээж супермаркет  	3	6500.00	0	\N	f	0	2025-08-02 18:15:16.365+00	2025-08-08 07:30:04.051+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6112	2	86609596	Улаанбаатар, Сүхбаатар 09-р хороо Дөлгөөн нуур апартмэнт-4 653 байр 15 давхар 89 тоот орцны код#2580 	3	6500.00	0	\N	f	0	2025-08-02 16:09:57.251+00	2025-08-10 04:50:18.101+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6107	15	88880244	сансарын емартын хажууд 48 сургуулийн үүдэнд плаззо таур хойд орцоор 8 давхарт 8в тоот үүд код 29#436 ажлын өдрүүдэд ажлын цагаар	3	1.00	1	9	f	0	2025-08-01 15:01:57.062+00	2025-08-02 06:24:09.346+00	f	\N	\N	\N
6023	2	80833331	Улаанбаатар, Баянзүрх 07-р хороо Сансарын Home plaza замын урд талд Тайж буудай буудлын баруун гар талаар ороод 41 байр 2 орц 2 давхарт 27 тоот 80833331 	3	6500.00	0	9	f	0	2025-07-29 04:07:00.663+00	2025-08-02 06:31:08.587+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6108	17	99136767	БЗД, 41-Р хороо,15-р хороолол, 15-р байр,3-орц 3 давхар 34 тоот 34В	3	249000.00	30-р сургуулийн яг хойд талд 5н давхар шар байр	9	f	0	2025-08-01 17:28:57.715+00	2025-08-02 07:47:55.719+00	f	\N	\N	\N
6111	2	99702800	Улаанбаатар, Сүхбаатар, 1-р хороо46-r bair, LuxCenter barilga, Chagdarjav gudamj, Багшийн дээдээс урагш явах зам дагуу хотын түргэн тусламж 103-ын хойд талд Люкс төв, 1-орц, 11 давхарт, 1104тоот 	3	6500.00	0	\N	f	0	2025-08-02 14:34:56.712+00	2025-08-08 07:29:27.482+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6106	15	85750020, 99123338	Viva city, S3 1dawhar motorcycle delguur	3	1.00	1	4	f	0	2025-08-01 15:00:14.649+00	2025-08-02 08:14:07.928+00	f	\N	\N	\N
6115	2	80881067	Улаанбаатар, Сонгинохайрхан 03-р хороо , Улаанбаатар, Сонгинохайрхан, бага нарангийн 16-11 80881067 бага нарангийн 16-11 80881067 80881067	3	12100.00	0	\N	f	0	2025-08-03 02:39:48.75+00	2025-08-08 07:30:28.123+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6114	2	90903482	Улаанбаатар, Хан-Уул 21-р хороо Улаанбаатар, Хан-Уул, 21-р хороо Eagle town 426-р байр 5-А тоот 	3	6500.00	0	22	f	0	2025-08-03 01:03:52.808+00	2025-08-06 10:10:28.079+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6110	2	93111139	Улаанбаатар, Баянзүрх 18-р хороо Улаанбаатар, Баянзүрх, 18-р хороо 14 bair  Hard rockoos zvvn tiish zamiin hoid tald Zangia. mn te  14 bair 6 orts 192 toot 	3	6500.00	0	9	f	0	2025-08-02 10:59:31.82+00	2025-08-03 02:45:02.631+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6087	2	90117748	Улаанбаатар, Хан-Уул 18-р хороо Google Map Moto House гэж хайгаад энэ байршлаар ирнэ үү. Хан-уул Имарт уулзварын урд Мото Хаус Мото граш \n 	3	6500.00	0	6	f	0	2025-07-31 09:18:06.165+00	2025-08-03 07:50:08.012+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6105	15	99472283	Баянгол дүүрэг, 1-р хороо, төмөр зам, барс захын замын хойд/эсрэг талд 16 давхар бор Premium ulaanbaatar apt,орц-A  орцны үүдэнд ирээд залгахад болно оо баярлалаа😊	3	1.00	1	4	f	0	2025-08-01 11:51:03.164+00	2025-08-03 09:16:23.192+00	f	\N	\N	\N
6288	2	88877349	Улаанбаатар, Сонгинохайрхан 31-р хороо Алтай3-282 	3	6500.00	0	9	f	0	2025-08-15 08:14:04.146+00	2025-08-16 10:19:09.45+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6316	2	88171726	Улаанбаатар, Баянзүрх 24-р хороо Алтай хотхон 25байр 8 давхар 46тоот 88171726\n 	1	6500.00	0	\N	f	0	2025-08-16 16:13:29.781+00	2025-08-16 16:13:29.793+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6121	17	95546056	Дарханы унаанд өнөөдөртөө тавих 	3	1.00	Унааны мэдээллийг явуулах 	9	f	0	2025-08-04 00:15:01.168+00	2025-08-04 08:32:21.453+00	f	\N	\N	\N
6122	17	99623277	Тэнгэр плаза - Хэнтийн унаанд тавих 	3	60000.00	Унааны мэдээллээ явуулах. Тавихдаа төлбөрөө авах 	9	f	0	2025-08-04 00:16:07.268+00	2025-08-04 10:31:31.517+00	f	\N	\N	\N
6109	2	90086699	Улаанбаатар, Баянзүрх 26-р хороо Dunjingaraw hudaldaanii tuv 	3	6500.00	0	\N	f	0	2025-08-02 08:03:50.542+00	2025-08-08 07:28:31.48+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6118	2	99742589	Улаанбаатар, Сонгинохайрхан 29-р хороо Moskwa appartment 133/6 13F-1302 Shine moskwa horoolol 133/6 13F-1302	3	6500.00	0	9	f	0	2025-08-03 07:52:33.587+00	2025-08-05 04:19:31.194+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6116	15	89026116	БЗД 43-р хороо Нарт хотхон 95-4-р байр 4-р орц 2 давхар 2 тоот	3	1.00	1	9	f	0	2025-08-03 05:53:05.945+00	2025-08-04 14:31:12.867+00	f	\N	\N	\N
6392	33	99474999	Ховд	3	78000.00	сорочик малгайтай цамц	18	f	0	2025-08-19 01:11:55.328+00	2025-08-19 09:00:05.342+00	f	\N	\N	\N
6391	33	99831079	Завхан Улиастай	5	49000.00	сорочик	18	f	0	2025-08-19 01:10:21.923+00	2025-08-21 02:11:15.176+00	f	\N	\N	\N
6129	15	80943345	Itpark Өргөө 2 дээр өглөө 8-с орой 5 цагийн хооронд ажилдээрээ авна.	3	1.00	1	18	f	0	2025-08-04 04:56:54.29+00	2025-08-05 08:08:59.632+00	f	\N	\N	\N
6251	2	88806525	Улаанбаатар, Сүхбаатар 01-р хороо Олимпийн гудамж 28В байр 1 тоот Паркийн зүүн тал Замынмцагдаагийн хойно	1	6500.00	0	\N	f	0	2025-08-12 04:22:40.106+00	2025-08-12 04:22:40.117+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6139	2	99040606	Улаанбаатар, Баянзүрх 26-р хороо , Улаанбаатар, Баянзүрх, Nationalpark town Dunjingarav hudaldaa tuviin chanh urd Nationalpark town Dunjingarav hudaldaa tuviin chanh urd Utas holbogdohgui tul shuud hayag deer avaachad ogoorei. Haalgaa changahan togshooroi	3	12100.00	0	\N	f	0	2025-08-04 13:32:16.382+00	2025-08-08 07:29:44.067+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6131	2	95022929	Улаанбаатар, Сүхбаатар 04-р хороо Ub town, 37r bair 6-23, ortsni code 23bc 	3	6500.00	0	4	f	0	2025-08-04 07:43:46.695+00	2025-08-07 11:34:13.027+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5978	2	99058474	Улаанбаатар, Хан-Уул 22-р хороо Улаанбаатар, Хан-Уул, 22-р хороо Хан-уул дүүрэг, Зайсан Соёмботой уулын яг ар дахь (CU.тай байрны арын)51-1-р байр 61 тоот 	3	12100.00	0	\N	f	0	2025-07-27 01:18:21.535+00	2025-08-04 07:49:10.127+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5982	2	99041399	Улаанбаатар, Сүхбаатар 07-р хороо , Улаанбаатар, Сүхбаатар, 39-р Байр 39-R Bair 39а-52 тоот Дүүрэн төвтэй байр 39-р Байр 39-R Bair 39а-52 тоот Дүүрэн төвтэй байр utasaar tarij bgaad ereerei	3	12100.00	0	\N	f	0	2025-07-27 04:06:30.156+00	2025-08-04 07:53:28.033+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
5954	2	80881067	Улаанбаатар, Сонгинохайрхан 03-р хороо , Улаанбаатар, Сонгинохайрхан, бага нарангийн 16-11 80881067 бага нарангийн 16-11 80881067 80881067	3	6500.00	0	\N	f	0	2025-07-25 08:34:32.116+00	2025-08-04 08:01:10.644+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6134	15	80803060	1r xoroolol 32n buudal dr ub vista 57b-18 toot	3	1.00	1	9	f	0	2025-08-04 09:01:27.855+00	2025-08-08 06:21:14.886+00	f	\N	\N	\N
6126	17	88997097	ХУД,20-р хороо, мишээл expo баруун талд 92А - 180	3	34000.00	Очихдоо холбогдох. Өдөрт нь хүргэх 	22	f	0	2025-08-04 02:38:02.848+00	2025-08-04 11:20:41.96+00	f	\N	\N	\N
6135	2	99114593	Улаанбаатар, Хан-Уул, 18-р хорооЖапан Таун С5, Хан-Уул дүүрэг, 18-р хороо, Жапан Таун Хотхон, С5 байр, 12 давхар, 1203 тоот.  	3	6500.00	0	\N	f	0	2025-08-04 09:06:42.667+00	2025-08-09 12:19:45.877+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6133	2	95195445	Улаанбаатар, Сонгинохайрхан 04-р хороо Улаанбаатар, Сонгинохайрхан, 4-р хороо Орчлон 2 хотхон 28-р байр 5 давхарт 49 тоот Орцны гадаа ирээд 0501# гэж залгана уу. 	3	6500.00	0	9	f	0	2025-08-04 08:49:35.282+00	2025-08-05 04:54:53.34+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6128	2	94707052	Улаанбаатар, Сүхбаатар, 18-р хорооБэлх 36-103тоот, Сүхбаатар дүүрэг 18-хороо бэлх 36-103тоот Dambadarjaa etses deer tsagdaagiin 2_heseg gj bga ternees deesh ywaad zam daguu ноёо хуушуур gj bii tend ireed zalagwal bolni 94440037ene dugaarluu	6	6500.00	0	\N	f	0	2025-08-04 03:33:42.251+00	2025-08-10 04:50:32.087+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6136	2	99055224	Улаанбаатар, Хан-Уул, 11-р хороо16-41, \nхөдөө аж ахуйн сургуулийн баруун талд алтанбогд 16-41 тоот\n\n худ 22р хороо зайсан хөдөө аж ахуйн сургуулийн баруун талд алтанбогд 16-41 тоот\n\n\n	3	6500.00	0	19	f	0	2025-08-04 09:35:46.461+00	2025-08-09 05:19:09.192+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6120	15	99116323	3.4r horoolol 18 r khoroo 1000 neriin baraa delgvvr 1 dabhart 508 r tasag	3	1.00	1	22	f	0	2025-08-03 12:41:08.993+00	2025-08-04 10:19:18.713+00	f	\N	\N	\N
6117	15	88015308	Buyant-uhaa2 horoolol 1008-47toot	3	1.00	1	22	f	0	2025-08-03 07:26:07.117+00	2025-08-04 10:31:50.827+00	f	\N	\N	\N
6289	2	99471727	Улаанбаатар, Хан-Уул 15-р хороо tsengeldeh hothon 204-403 95557646 	1	6500.00	0	\N	f	0	2025-08-15 10:39:57.41+00	2025-08-15 10:39:57.424+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6127	17	88284762	Шар хадны эцэс 	3	65000.00	Өнөөдөр орйохондоо авья. Уг нь улиастайн эцэс гэсэн хүргэлтийн бүс шар хад гэж хэлсэн болхоор өөрөө цаанаасаа ирж авна тэгхээр эртхэн ярьсан нь дээр байх 	9	f	0	2025-08-04 02:57:11.603+00	2025-08-04 11:25:26.63+00	f	\N	\N	\N
6138	2	91912320	Улаанбаатар, Баянзүрх 36-р хороо Баянмонголын баруун талд Саруул хороолол 116-р байр 1-р орц 12 давхар 55тоот 1116# 	3	12100.00	0	\N	f	0	2025-08-04 11:33:38.751+00	2025-08-08 07:30:52.036+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6125	2	99119960	Улаанбаатар, Баянгол 26-р хороо Нарны хорооллын хажууд 9н эрдэнэ хотхон, 29/6 байр 11 давхар 62 тоот  	3	6500.00	0	6	t	6	2025-08-04 02:15:24.711+00	2025-08-18 18:44:52.271+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6124	15	88870974	Баянзүрх дүүрэг, 14р хороо, Түмэн наст хотхон, 36в байр, 3давхар, 15 тоот.Haldvartiin urd tald Tumen nast hothon 	3	1.00	1	9	f	0	2025-08-04 00:29:21.253+00	2025-08-05 14:09:25.782+00	f	\N	\N	\N
6161	2	98159769	Улаанбаатар, Чингэлтэй 20-р хороо Баян хошуу хөтөл 149-сургууль\n 98159769	3	6500.00	0	9	f	0	2025-08-05 10:42:58.492+00	2025-08-07 03:47:24.423+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6735	41	94002929	bgd modnii 2 79r bair	3	0.00	har, nogoon bair	38	f	0	2025-08-23 03:39:35.031+00	2025-08-23 12:09:56.144+00	f	\N	\N	\N
6670	41	99999381	hunnu2222 107-2 8davhar8c toot	3	0.00		19	f	0	2025-08-22 02:51:08.359+00	2025-08-26 06:05:13.363+00	f	\N	\N	\N
6485	35	88535353	Sbd 11horoo 54bair 31toot	3	35000.00	,	12	f	0	2025-08-20 03:04:39.809+00	2025-08-24 05:26:15.804+00	f	\N	\N	\N
6157	2	88085318	Улаанбаатар, Баянзүрх 39-р хороо Улаанхуаран awtus baaziin hajuu taliin pearl city hothon 1202 toot Бзд 39 р хороо улаанхуаран авто баазын хажууд	3	6500.00	0	9	f	0	2025-08-05 07:53:24.627+00	2025-08-10 08:58:17.363+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6142	2	85775537	Улаанбаатар, Сонгинохайрхан 40-р хороо bayanhoshuu toirog voyage usnii uildverees uragsh 3 gudam 12-r gudam tultal yavaad 36 toot\n 	3	6500.00	0	9	f	0	2025-08-05 00:18:19.705+00	2025-08-07 03:27:58.664+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6146	2	98159769	Улаанбаатар, Чингэлтэй 20-р хороо Баян хошуу хөтөл 149-сургууль\n 98159769	3	6500.00	0	9	f	0	2025-08-05 02:42:09.891+00	2025-08-07 03:47:17.492+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6141	2	85775537	Улаанбаатар, Сонгинохайрхан 40-р хороо bayanhoshuu toirog voyage usnii uildverees uragsh 3 gudam 12-r gudam tultal yavaad 36 toot\n 	3	6500.00	0	9	f	0	2025-08-05 00:16:45.797+00	2025-08-08 07:34:14.068+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6147	2	86129222	Улаанбаатар, Сүхбаатар 08-р хороо River castle / B block 18 dawhar 1801 toot \nUlaanbaatar teatriin zuun tald 88129222 86709222 8812923	3	6500.00	0	9	f	0	2025-08-05 03:45:28.224+00	2025-08-08 09:02:15.596+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6158	2	88085318	Улаанбаатар, Баянзүрх 39-р хороо Улаанхуаран awtus baaziin hajuu taliin pearl city hothon 1202 toot Бзд 39 р хороо улаанхуаран авто баазын хажууд	3	6500.00	0	9	f	0	2025-08-05 07:54:42.804+00	2025-08-07 06:31:09.721+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6150	2	90344431	Улаанбаатар, Чингэлтэй 23-р хороо Сурагчын 49-1150  Залгах дугаар 96740218	3	6500.00	0	\N	f	0	2025-08-05 04:55:22.405+00	2025-08-07 10:24:23.754+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6149	2	88075941	Улаанбаатар, Сонгинохайрхан 27-р хороо Чингис соосэ сургуулийн хажууд чухаг хотхон 12 давхар 63тоот 32б байр\n 	1	6500.00	0	\N	f	0	2025-08-05 04:50:27.873+00	2025-08-05 04:50:27.881+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6143	2	91566363	Улаанбаатар, Сүхбаатар 11-р хороо зүүн сэлбэ 7 гудам баян хайрхан худалдааний төв урд 102-хашаа\ngoogle map link - https://maps.app.goo.gl/sJ8wvYoRTydWqgex9\nimap link - https://www.imap.mn/geo/47.93435588373728/106.92566951094773?z=18 	3	6500.00	0	9	f	0	2025-08-05 00:47:13.56+00	2025-08-08 04:18:29.519+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6145	2	95581024	Улаанбаатар, Баянзүрх 08-р хороо Улаанбаатар, Баянзүрх, 8-р хороо Цагдаагийн академийн 16-р байр   Tsagdaagiin academiin 16-R Bair 32-р цэцэрлэгийн хойд талд, Дотоод хэргийн их сургуулийн зүүн талд 16р байр 	3	6500.00	0	9	f	0	2025-08-05 01:54:21.598+00	2025-08-09 04:00:43.222+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6154	2	99104479	Улаанбаатар, Хан-Уул, 11-р хороо1-67 байр, Скай гарден 304-р байр 703 тоот\n\n99104479 	3	6500.00	0	19	f	0	2025-08-05 06:23:23.749+00	2025-08-09 07:17:43.678+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6252	2	91171163	Улаанбаатар, Сонгинохайрхан 24-р хороо Зээлийн 25-26 тоот 	3	6500.00	0	9	f	0	2025-08-12 04:24:39.915+00	2025-08-14 08:32:06.255+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6156	2	99077854	Улаанбаатар, Сүхбаатар 03-р хороо Улаанбаатар, Сүхбаатар, 3-р хороо 5 р хороолол45-3 Наран малл н урд 5 давхар\n 45 байр 3 тоот	3	6500.00	0	\N	f	0	2025-08-05 07:32:32.318+00	2025-08-08 07:30:14.303+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6159	2	86190025	Улаанбаатар, Баянгол 18-р хороо Баянгол дүүрэг,эрүүл мэндийн 7 дугаар төвийн/шинэ/хажууд 41-р байр,9 давхар 35 тоот\nОрцны код 06#123 	3	12100.00	0	\N	f	0	2025-08-05 09:53:54.106+00	2025-08-14 08:55:42.772+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6140	2	95216857	Улаанбаатар, Баянзүрх 10-р хороо Амгалан Цагдаа хотхон 75-7 байр 2 орц 2давхар 67тоот орцны код #9898 	3	6500.00	0	\N	f	0	2025-08-04 15:00:59.362+00	2025-08-08 07:32:57.776+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6160	2	95298697	Улаанбаатар, Баянзүрх 16-р хороо tsaiz 16 Saruul tenger tsogtsolbor 47r bair 4r orts 6 davhar 176 toot\n 	3	6500.00	0	9	f	0	2025-08-05 10:29:22.743+00	2025-08-07 05:30:58.127+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6148	2	99012372	Улаанбаатар, Хан-Уул 03-р хороо Riverstone 1 hothon 24 a bair  	3	6500.00	0	6	t	6	2025-08-05 03:50:22.359+00	2025-08-18 18:44:52.271+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6144	2	95581024	Улаанбаатар, Баянзүрх 08-р хороо Улаанбаатар, Баянзүрх, 8-р хороо Цагдаагийн академийн 16-р байр   Tsagdaagiin academiin 16-R Bair 32-р цэцэрлэгийн хойд талд, Дотоод хэргийн их сургуулийн зүүн талд 16р байр 	3	6500.00	0	\N	f	0	2025-08-05 01:53:01.199+00	2025-08-08 07:32:57.776+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6152	15	90154530	HUD, 23-r horoo, Nukht palace, gol haalgaar orood baruun gar tiish ergeed liftend suugad 4 dawhart 18 toot.	3	1.00	1	6	t	6	2025-08-05 05:41:09.445+00	2025-08-18 18:44:52.271+00	f	\N	\N	\N
6171	2	99081012	Улаанбаатар, Баянгол 10-р хороо Баянгол дүүрэг 10р хороо буюу хорооллын эцсийн имартын ард ,141-р цэцэрлэгийн дэргэд 23-р байр 2р лоц 48 тоот ажлын бус цагаар	3	6500.00	0	\N	f	0	2025-08-06 06:21:44.113+00	2025-08-08 07:32:29.621+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6177	27	86510613	Ботаник	3	110000.00	ботаник дээр очоод залгах	9	f	0	2025-08-06 14:43:02.568+00	2025-08-07 10:04:15.12+00	f	\N	\N	\N
6176	2	96358399	Улаанбаатар, Сонгинохайрхан 22-р хороо 22ийн 1тоот шөнийн дэлгүүрийн автобусны буудал\n 	3	6500.00	0	9	f	0	2025-08-06 13:45:34.664+00	2025-08-09 06:43:53.202+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6162	2	89898262	Улаанбаатар, Хан-Уул 18-р хороо Hunnu 2222 202 bair 1 orts 901toot dooroos 901 gej zalgaj orno gert hun bhgu bol 77 salond tavina	3	6500.00	0	19	f	0	2025-08-05 11:37:56.487+00	2025-08-08 07:00:42.327+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6163	2	88406970	Улаанбаатар, Сонгинохайрхан 27-р хороо Хангай захын эсрэг талд шар өнгийн таван давхар 19дугаар байр 5давхарт 21 тоот 	3	6500.00	0	9	f	0	2025-08-05 13:03:17.511+00	2025-08-07 03:04:15.76+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6167	2	95155757	Улаанбаатар, Баянзүрх 12-р хороо баянзүрх дүүрэг 12р хороо жанжин 5р гудамж 128 тоот баянзүрх дүүрэг 12р хороо жанжин 5р гудамж 128 тоот	3	6500.00	0	9	f	0	2025-08-06 01:48:23.956+00	2025-08-07 09:56:52.062+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6170	2	99765259	Улаанбаатар, Чингэлтэй 01-р хороо Улаанбаатар, Чингэлтэй, 1-р хороо бага тойруу, Erdenes Mongol LLC Naranchimeg gedeg ner deer uudend baigaa haruuld ogooroo.	3	6500.00	0	4	f	0	2025-08-06 06:20:29.853+00	2025-08-08 09:14:37.317+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6181	2	80066665	Улаанбаатар, Баянзүрх 11-р хороо Бага Тэнгэр, G1002  88885991	3	12100.00	0	\N	f	0	2025-08-07 03:23:30.136+00	2025-08-08 10:33:05.857+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6151	2	99994022	Улаанбаатар, Хан-Уул 16-р хороо B one apartment, 250 bair, 2 dawhar, 3 toot. 88052188 dugaarluu zalgaj xaalgaa neelgeh Нэг орцтой орцонд ороод зүүн гар талын хаалган дээр очоод залгаарай.  88052188 дугаар руу залгахаар хаалга нээж өгнө. 	3	6500.00	0	22	f	0	2025-08-05 05:28:01.343+00	2025-08-06 09:51:04.345+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6173	2	89982119	Улаанбаатар, Сонгинохайрхан 20-р хороо 5н шар өнгөрөөд нефтийн автобусны буудлийн чанх ард улбар шар GS25 тай байр 6р давхар 30тоот ( чип) 	3	6500.00	0	9	f	0	2025-08-06 09:55:20.212+00	2025-08-09 07:08:00.639+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6179	2	99114864	Улаанбаатар, Хан-Уул 11-р хороо , Улаанбаатар, Хан-Уул, Golden budda hothon 4-7-17 toot Golden budda hothon 4-7-17 toot 99114864	3	6500.00	0	19	f	0	2025-08-06 23:00:51.094+00	2025-08-09 03:36:07.537+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6182	2	80897495	Улаанбаатар, Баянзүрх 10-р хороо Улаанбаатар, Баянзүрх, 10-р хороо Улаанхуаран 1б хэсэг  10р хороо 1б хэсэг бялхам алтай дэлгүүр  	3	6500.00	0	9	f	0	2025-08-07 04:28:20.025+00	2025-08-08 02:53:10.929+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6486	35	99160030	13horoolol 3bair 1 orts 7-27toot 	3	24000.00	,	29	t	10	2025-08-20 03:05:02.296+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
6168	2	95179782	Улаанбаатар, Баянзүрх 03-р хороо sansar garden 39/4 6dawhar 602 	3	6500.00	0	9	f	0	2025-08-06 01:48:52.483+00	2025-08-08 03:22:27.038+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6178	2	99117648	Улаанбаатар, Хан-Уул 24-р хороо Vip residence 477-9 	3	6500.00	0	29	f	0	2025-08-06 16:01:04.499+00	2025-08-22 07:24:46.011+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	ajilchlaa
6169	17	80159238	king tower, 125v6n dawhar 11 toot	3	103000.00	Өдөрт нь хүргэх 	19	f	0	2025-08-06 05:13:37.457+00	2025-08-07 02:19:04.066+00	f	\N	\N	\N
6165	17	88002703	Zaisan Bella Vista 400r bair, 0202toot 	3	84000.00	Очихдоо ярих 	19	f	0	2025-08-05 16:41:11.025+00	2025-08-07 02:23:17.564+00	f	\N	\N	\N
6172	2	88075941	Улаанбаатар, Сонгинохайрхан 27-р хороо Чингис соосэ сургуулийн хажууд чухаг хотхон 12 давхар 63тоот 32б байр\n 	3	6500.00	0	9	f	0	2025-08-06 08:56:13.435+00	2025-08-07 02:54:33.247+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6174	2	80679747	Улаанбаатар, Чингэлтэй 06-р хороо СУИС 72-р байр 122 тоот 80679747	3	6500.00	0	9	f	0	2025-08-06 10:35:39.698+00	2025-08-10 08:19:26.475+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6166	2	99116246	Улаанбаатар, Баянзүрх 26-р хороо Энканто-2 хотхон 208 байр 1 орц 11 давхарт 19 тоот орц 2081# 	3	6500.00	0	\N	f	0	2025-08-06 01:12:56.664+00	2025-08-09 05:54:52.64+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6164	2	89999872	Улаанбаатар, Баянзүрх 37-р хороо Чулуун овоо Өрнөх Хороолол 12-601 	3	6500.00	0	9	f	0	2025-08-05 14:37:03.728+00	2025-08-07 10:27:24.578+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6672	41	96620126	chd 24 horoo baruun salaa hustai 1a 13	3	0.00		12	f	0	2025-08-22 02:52:31.087+00	2025-08-22 14:25:37.699+00	f	\N	\N	\N
6742	41	96218973	narangiin gol guurnii buudal	3	0.00		9	f	0	2025-08-23 03:42:22.071+00	2025-08-23 07:47:44.703+00	f	\N	\N	\N
6185	17	86048006	Алтай хотхон 21-р байр 1-р орц 8 давхар 48 тоот	3	82500.00	Хөдөө авч гарах юм. Яаралтай хүргэлтээр явуулах 	\N	f	0	2025-08-07 06:38:10.443+00	2025-08-07 07:30:51.664+00	f	\N	\N	\N
6187	15	89890090	Хан Уул дүүрэг, Яармагийн 1р буудал, Шинэ Хангарьд ордон. 	3	1.00	8.8 нд авчихаж болох уу? Ажил дээрээ	4	f	0	2025-08-07 08:37:52.834+00	2025-08-08 11:17:30.473+00	f	\N	\N	\N
6191	15	80858311	geriin hayg: shd, orchlon horoolol 1. 41r bair 2r orts 6dawhar 156- 6s hoish  ajliin hayg: modnii 2t, ih mongol deed surguuli 36toot-6s umnu utas: 80858311	3	1.00	1	9	f	0	2025-08-08 03:59:19.458+00	2025-08-08 07:11:47.83+00	f	\N	\N	\N
6202	2	89776066	Улаанбаатар, Сүхбаатар 01-р хороо olympic street-19,Shangrilla,6-р байр,A 6a shangrilla lkhagvabayar \n\n	3	6500.00	0	4	f	0	2025-08-09 02:42:26.638+00	2025-08-12 00:36:38.196+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6193	17	80804662	Metromall ard ireed zalgah	3	1.00	seq-2 tulbur manaihaas	4	f	0	2025-08-08 08:23:46.413+00	2025-08-08 08:51:03.515+00	f	\N	\N	\N
6290	2	99041399	Улаанбаатар, Сүхбаатар 07-р хороо , Улаанбаатар, Сүхбаатар, 39-р Байр 39-R Bair 39а-52 тоот Дүүрэн төвтэй байр 39-р Байр 39-R Bair 39а-52 тоот Дүүрэн төвтэй байр yarih bgaad ereerei	1	6500.00	0	\N	f	0	2025-08-15 12:23:06.636+00	2025-08-15 12:23:06.649+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6183	2	89981177	Улаанбаатар, Хан-Уул 03-р хороо Хан-Уул дүүрэг 3р хороо 17071 88100569 	3	6500.00	0	6	t	8	2025-08-07 05:22:46.616+00	2025-08-20 15:41:14.642+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6198	2	90148100	Улаанбаатар, Сонгинохайрхан 22-р хороо Орбит Хилчин 85-р гудамж 3тоот 	3	6500.00	0	9	f	0	2025-08-08 22:40:00.135+00	2025-08-10 06:02:04.637+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6203	17	99161826	Өгөөмөр захын зүүн талд ахмадын хороолол 51р байранд	3	43000.00	Өнөөдөр 10- 17 цагийн хооронд авна	4	f	0	2025-08-09 02:56:51.601+00	2025-08-09 08:49:38.559+00	f	\N	\N	\N
6137	2	88887671	Улаанбаатар, Сүхбаатар, 2-р хороо15-4, хаяг: Нарны зам дагуу Моннис баруун талд шинэ баригдсан Platinum tower 15-4 байр 15 давхар 1502 тоот орцны код 2345confirm 88887671	3	6500.00	0	9	f	0	2025-08-04 11:10:00.612+00	2025-08-08 13:43:30.322+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6184	2	99033652	Улаанбаатар, Чингэлтэй 05-р хороо Нисдэг машин эсрэг талд,18р байр,8 давхар 32 тоот байрны код 32Б/32B 	3	6500.00	0	9	f	0	2025-08-07 05:49:46.911+00	2025-08-08 13:58:39.654+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6493	35	88073237	сүхбаатар аймаг	3	29900.00	,	12	t	9	2025-08-20 03:27:39.411+00	2025-08-20 15:42:43.062+00	f	\N	\N	\N
6189	2	99522462	Улаанбаатар, Сонгинохайрхан 34-р хороо Нарангын гол гүнгэрваа худалдааны төв 	3	6500.00	0	9	f	0	2025-08-08 01:15:30.186+00	2025-08-09 07:01:07.737+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6200	2	95095941	Улаанбаатар, Хан-Уул 17-р хороо River Plaza hothon. 512B bair. 4 davhar. 404 toot 	3	6500.00	0	\N	f	0	2025-08-09 02:15:03.809+00	2025-08-14 08:56:12.939+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6195	15	88999390	Баянзүрх дүүрэг 41р хороо 15р хороолол 30-1 тоот	3	1.00	1	9	f	0	2025-08-08 09:57:55.611+00	2025-08-09 04:32:55.972+00	f	\N	\N	\N
6197	15	95030055	Худ 25 хороо нисэхийн тойргийн ард викториа товн 205р байр 2р орц орц кодгүй 2 давхар 25 тоот	3	1.00	1	22	f	0	2025-08-08 11:53:07.464+00	2025-08-09 12:14:44.757+00	f	\N	\N	\N
6188	2	99142595	Улаанбаатар, Баянзүрх 01-р хороо 17-24 toot 24b 	3	6500.00	0	9	f	0	2025-08-07 08:47:34.712+00	2025-08-09 13:08:09.805+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6201	2	89119022	Улаанбаатар, Баянгол 12-р хороо Улаанбаатар, Баянгол, 12-р хороо 6-р бичил хороолол, 21-р байр, 22 тоот, 6 давхар 22тоот\nОрцны код 22В  	3	12100.00	0	\N	f	0	2025-08-09 02:23:20.402+00	2025-08-11 07:11:48.109+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6196	15	88229089	 баянгол хороолол 4хороо 015байр 15 тоот	3	1.00	1	18	f	0	2025-08-08 10:04:29.207+00	2025-08-09 08:23:33.545+00	f	\N	\N	\N
6253	2	88853345	Улаанбаатар, Сонгинохайрхан 17-р хороо UB Vista 57а байр, 9р давхар 32 тоот 95137553 адъяа гэдэг хүнтэй холбогдоорой. Ажлын цагаар БЗДүүргийн эсрэг талын цэргийн төв эмнэлэгт хүргүүлье	3	6500.00	0	9	f	0	2025-08-12 06:27:12.536+00	2025-08-15 13:38:14.046+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6349	2	99763015	Улаанбаатар, Хан-Уул 21-р хороо Буянт ухаа-2 1030 8 давхар 43 тоот 	1	6500.00	0	\N	f	0	2025-08-18 03:28:05.446+00	2025-08-18 03:28:05.462+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6186	2	99580774	Улаанбаатар, Хан-Уул 18-р хороо Uniq center 6р давхар polaris lounge karaoke 	3	6500.00	0	6	t	5	2025-08-07 06:41:32.128+00	2025-08-18 18:43:50.086+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6190	15	86646555	Dunjingarav chuhag hothon 8r bair	3	1.00	1	6	t	5	2025-08-08 03:30:12.346+00	2025-08-18 18:43:50.086+00	f	\N	\N	\N
6673	41	99174099	sbd 15 horoo dambadarjaa 26-46toot	3	0.00		22	t	14	2025-08-22 02:53:09.285+00	2025-08-23 07:38:12.958+00	f	\N	\N	\N
6745	41	86649905	suhbaatar aimag	3	0.00		44	t	16	2025-08-23 03:44:53.826+00	2025-08-25 04:30:28.934+00	f	\N	\N	\N
6356	2	88504332	Улаанбаатар, Сонгинохайрхан 04-р хороо “Орчлон хороолол 2” 29-р байр 61тоот 	3	6500.00	0	22	f	0	2025-08-18 07:19:24.28+00	2025-08-20 09:58:49.711+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6359	2	99192264	Улаанбаатар, Баянзүрх 26-р хороо Crystal town-ii zamiin baruun urd Arig banktai barilgiin 3 davhart Pearl shudnii emneleg (19 tsag hurtel ajillana) 	3	6500.00	0	6	t	8	2025-08-18 07:49:07.583+00	2025-08-22 10:03:51.946+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6380	2	89113812	Улаанбаатар, Баянзүрх 07-р хороо Кемпинскигийн зүүн талд 10давхар цэнхэр байр 1орцтой 10давхарт 32тоот эсвэл орц кодгүй чиптэй ирээд залгаж болноо 	3	6500.00	0	9	f	0	2025-08-18 13:51:10.627+00	2025-08-22 03:49:57.176+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6364	2	89191859	Улаанбаатар, Сонгинохайрхан 11-р хороо баян хошуу хөтөл овоотын 7р гудамж 126 тоот 	1	12100.00	0	\N	f	0	2025-08-18 09:45:50.013+00	2025-08-18 09:45:50.029+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6372	2	88504332	Улаанбаатар, Сонгинохайрхан 04-р хороо “Орчлон хороолол 2” 29-р байр 61тоот 	3	6500.00	0	12	f	0	2025-08-18 11:56:23.069+00	2025-08-21 13:12:03.772+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6388	2	99104238	Улаанбаатар, Баянзүрх 43-р хороо Натурын Сэлбэ хотхон 97/4 байр 4 давхарт 18 тоот 	3	6500.00	0	9	f	0	2025-08-18 17:26:55.193+00	2025-08-22 06:42:42.012+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6362	2	88178107	Улаанбаатар, Сонгинохайрхан 42-р хороо Хайрханы 13-81а 	3	6500.00	0	22	f	0	2025-08-18 08:39:33.918+00	2025-08-20 10:22:36.502+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6368	2	91198202	Улаанбаатар, Баянзүрх 40-р хороо Хос Сувд Хотхон, 79б байр 82 тоот 	1	12100.00	0	\N	f	0	2025-08-18 11:19:21.672+00	2025-08-18 11:19:21.686+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6369	2	99873034	Улаанбаатар, Сонгинохайрхан, 1-р хорооДрагон, Драгон авто вокзал Говь-Алтайн автобус 	3	6500.00	0	22	f	0	2025-08-18 11:33:39.065+00	2025-08-20 08:46:58.661+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6365	2	88040625	Улаанбаатар, Хан-Уул 16-р хороо Хуучин нисэх байрны буудал 801 байр ирээд залгах Ирээд залгах 88040625	3	6500.00	0	29	f	0	2025-08-18 09:48:02.243+00	2025-08-21 12:48:06.007+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6373	2	99993566	Улаанбаатар, Баянзүрх 03-р хороо Sansar garden 36r bair 2r orts 21 davhart 2103 toot\n 	3	6500.00	0	9	f	0	2025-08-18 12:10:24.893+00	2025-08-22 05:30:59.569+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6374	2	90023301	Улаанбаатар, Чингэлтэй 06-р хороо Баянбүрд 50р сургууль 60/3 байр 66#\n 90023301 энэ дугаарлуу залгаарай	1	6500.00	0	\N	f	0	2025-08-18 12:51:59.705+00	2025-08-18 12:51:59.719+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6370	2	89147760	Улаанбаатар, Хан-Уул 06-р хороо Буянт Ухаа 1 706р байр 5н давхар 29 тоот 	3	6500.00	0	29	f	0	2025-08-18 11:33:43.671+00	2025-08-21 12:32:38.799+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6379	2	89035005	Улаанбаатар, Сүхбаатар 19-р хороо Хандгайт, 1-30. 99189445 руу залгана уу. Энэ газар очоод 99189445,89139445 руу залгана уу.	4	6500.00	0	22	f	0	2025-08-18 13:22:04.077+00	2025-08-22 14:25:04.753+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6377	2	80809965	Улаанбаатар, Баянзүрх 08-р хороо Харуул-Алтай хотхон 102 байр 34 тоот 1р орц 5давхар\nОрцны код:34В Hhh	3	6500.00	0	12	f	0	2025-08-18 13:05:53.015+00	2025-08-20 12:21:22.444+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6375	2	90757563	Улаанбаатар, Сонгинохайрхан 35-р хороо Нарангийн голын эцэс 	3	6500.00	0	12	f	0	2025-08-18 12:55:01.173+00	2025-08-21 13:12:29.445+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6378	2	96818298	Улаанбаатар, Чингэлтэй 02-р хороо 40-50мянгат 28байр 2орц 26тоот (Computer land baruun taliin shar bair) 	3	6500.00	0	37	f	0	2025-08-18 13:07:07.177+00	2025-08-22 11:19:07.557+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6360	2	89111997	Улаанбаатар, Хан-Уул 17-р хороо Marshall king tower 143-r bair 2-r orts 9 davhar 274\n99098825 	3	6500.00	0	19	f	0	2025-08-18 07:50:55.308+00	2025-08-20 07:57:31.444+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6382	2	94965505	Улаанбаатар, Баянзүрх 36-р хороо Баян Монгол Хороолол 403 байр 2 орц 74 тоот 	1	12100.00	0	\N	f	0	2025-08-18 16:14:35.667+00	2025-08-18 16:14:35.684+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6376	2	99265248 99995427	Улаанбаатар, Сүхбаатар 01-р хороо Өргөө амаржих хажууд, 58р байр,79 тоот, 8 давхарт 	3	6500.00	0	44	f	0	2025-08-18 12:58:08.545+00	2025-08-23 06:10:59.356+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6192	17	99231248	Удирдлагын академын баруугаар урагшаа явж байгад күүн эргээд смайлтай супермаркет бйагаа. Тэрний наагуур урагшаа эргэхээр баруун гар талд улбар шар 6н давхар байр байгаа. Тэр байртай хамт нэг хашаанд бүдэг ягаан байр бий. 	3	54000.00	4-р байр. 6н давхар, 11 тоот 	6	t	5	2025-08-08 04:50:24.981+00	2025-08-18 18:43:50.086+00	f	\N	\N	\N
6194	2	80141692	myngan neriin baraanii  hoino 40r surguuliin chanh urd bgd 15 horoo  21 bair 1orts 24toot  	3	1.00	a	6	t	5	2025-08-08 08:43:55.397+00	2025-08-18 18:43:50.086+00	f	\N	\N	\N
6199	2	85824433	Улаанбаатар, Хан-Уул 17-р хороо time square hothon 503-r bair 1 dwhr 102 toot 	3	6500.00	0	6	t	5	2025-08-09 01:37:10.623+00	2025-08-18 18:43:50.086+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6218	2	86971818	Улаанбаатар, Баянгол 26-р хороо нарны хороолол 7р байр 4р орц 9 давхар 216тоот\n 	3	6500.00	0	6	t	5	2025-08-10 15:27:40.879+00	2025-08-18 18:43:50.086+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6258	2	80602201	Улаанбаатар, Хан-Уул 03-р хороо ХУД  3р хороо Сутай хотхон 115р байр А орц 2 давхар 204тоот (говь үйлдвэрийн хойно) 	3	6500.00	0	6	t	5	2025-08-12 13:04:18.412+00	2025-08-18 18:43:50.086+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6119	2	91102431	Улаанбаатар, Хан-Уул 18-р хороо Гэрлүг виста 58/5 байр 1808тоот 	3	6500.00	0	6	t	6	2025-08-03 09:56:06.976+00	2025-08-18 18:44:52.271+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6130	2	99448077	Улаанбаатар, Баянгол 26-р хороо Нарны хороолол 26-р байр 1 давхарт 103 тоот. Орцны код 1826# 	3	6500.00	0	6	t	6	2025-08-04 05:09:32.644+00	2025-08-18 18:44:52.271+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6153	15	88461416	Khan-Uul duureg, 1r horoo Shine ugluu tsogtsolbor ,23c bair hamgin hoid taliin orts 4 davhar 5 n toot	3	1.00	1	6	t	6	2025-08-05 06:07:52.538+00	2025-08-18 18:44:52.271+00	f	\N	\N	\N
6155	2	80188599	Улаанбаатар, Баянгол 18-р хороо Achlallin esreg tald 99243450 Achlal ih delguurin esreg tald ireed 99243450 dugaar zalga	3	6500.00	0	6	t	6	2025-08-05 07:06:21.755+00	2025-08-18 18:44:52.271+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6175	15	80023703	БГД, 9-р хороо, Сот2-1, 144 тоот,  утас: 	3	1.00	IELTS-н цагаа авчихсан байгаан, 24-48 таа багтаад хүргээд өгөөрэй.	6	t	6	2025-08-06 11:09:04.55+00	2025-08-18 18:44:52.271+00	f	\N	\N	\N
6412	2	99869592	Улаанбаатар, Баянзүрх 26-р хороо Park view hotgon 755/ bair 4-n davhar 519 toot #1755#\n 	3	6500.00	0	6	t	8	2025-08-19 03:32:01.622+00	2025-08-20 15:41:14.642+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6411	2	80116592	Улаанбаатар, Баянзүрх 13-р хороо 32r horoo baruun altan olgii 34-548b 32r horoo shuu 1000 oyutnii gerlen dohionoos hoishoo km ogsood emiin santai 2dawhar shar baishingiin ariin gudam 	3	6500.00	0	44	f	0	2025-08-19 02:37:47.229+00	2025-08-23 09:49:33.19+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6394	33	99058915	Тэнгис кино театрын зүүн хойд талд 57 байр 6 давхарт 28 тоот орц код 28в	1	49000.00	сорочик	\N	f	0	2025-08-19 01:15:34.145+00	2025-08-19 02:41:43.523+00	t	\N	\N	\N
6399	33	99699878	ХУД 17 хороо Маршал таун 125байр 1тоот аркаар ороод зүүн талд Greenger дэлгүүрт	1	35000.00	өмд	\N	f	0	2025-08-19 01:39:13.519+00	2025-08-19 02:46:46.728+00	t	\N	\N	\N
6396	2	80181106	Улаанбаатар, Баянзүрх, 16-р хороохос сувд хотхон, Батлан хамгаалахын сургуулийн баруун талд, Хос сувд хотхон, А блок, 2 давхар, 4 тоот 	5	6500.00	0	44	f	0	2025-08-19 01:17:40.498+00	2025-08-24 09:14:29.062+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6404	2	80501717	Улаанбаатар, Хан-Уул 21-р хороо Шүрт хотхон, 812-р байр, flowers&gifts дэлгүүр 	3	6500.00	0	36	f	0	2025-08-19 01:59:59.017+00	2025-08-20 06:10:46.335+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6405	31	99143921	Хөвсгөл, ,  , Даргон терминал 20цагын автобус	3	1.00	Даргон терминал 18 19 20 21цагуудад автобус явна  undefined	\N	f	0	2025-08-19 02:00:28.446+00	2025-08-19 08:21:37.851+00	f	\N	\N	\N
6414	2	86859230	Улаанбаатар, Багануур Улаанбаатар, Багануур, 1-р хороо 8-р байр 51 тоот  	3	6500.00	0	44	f	0	2025-08-19 03:56:18.539+00	2025-08-24 10:29:19.078+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6415	2	95152285	Улаанбаатар, Хан-Уул 23-р хороо Twin towers, 52r bair, 202, 2r davhart  	3	6500.00	0	29	f	0	2025-08-19 04:31:40.945+00	2025-08-24 10:57:41.568+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6395	33	99058915	Тэнгис кино театрын зүүн хойд талд 57 байр 6 давхарт 28 тоот орц код 28в	5	49000.00	сорочик	22	t	15	2025-08-19 01:16:17.855+00	2025-08-25 02:14:30.486+00	f	\N	\N	\N
6400	2	95668348	Улаанбаатар, Баянгол 29-р хороо tsam garviin nomingiin 43r bair 3davhar 306 toot 	3	6500.00	0	12	f	0	2025-08-19 01:40:40.901+00	2025-08-21 10:20:39.875+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6406	2	86886032	Улаанбаатар, Баянзүрх 11-р хороо Натур, Сэлбэ хотхон, 97/4-р байр 5 давхар 24 тоот 	3	6500.00	0	9	f	0	2025-08-19 02:21:33.786+00	2025-08-22 06:43:24.777+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6410	2	88061205	Улаанбаатар, Хан-Уул 23-р хороо Яармагын нэгдсэн эмнэлгээс дээшээ өгсөөд нова виста хотхон  1459 байр нарт дэлгүүр 	3	6500.00	0	36	f	0	2025-08-19 02:34:47.477+00	2025-08-20 08:26:14.688+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6401	33	99699878	Маршал таун 125 байр 1тоот аркаар ороод зүүн талд Greenger дэлгүүр	3	35000.00	18:30 өмнө авна	6	t	8	2025-08-19 01:42:10.564+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6407	32	94006049 94196054	HUD 3 TAVAN BOGD TV5 television	3	126000.00	t	6	t	8	2025-08-19 02:22:18.304+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6409	32	99163107	алтай хотхон баруун хойно middle river aparment 46b bair 4dawhar 22toot	3	1.00	mongo awahgvi	6	t	8	2025-08-19 02:24:02.319+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6435	2	94985701	Улаанбаатар, Баянзүрх 38-р хороо horoo garden residens hothon 51 b bair\nУтас-99278588  	3	6500.00	0	9	f	0	2025-08-19 13:11:04.223+00	2025-08-22 10:02:00.839+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6434	2	99112130	Улаанбаатар, Хан-Уул 02-р хороо , Улаанбаатар, Хан-Уул, Худ 2-р хороо, Бадрах апартмент Б2 блок 1305 тоот Худ 2-р хороо, Бадрах апартмент Б2 блок 1305 тоот ирэхээсээ өмнө залгах	3	6500.00	0	6	f	0	2025-08-19 12:25:48.579+00	2025-08-23 11:21:01.158+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6429	2	88427861	Улаанбаатар, Баянзүрх 11-р хороо Emiin-Urgamal monx delguur 	3	6500.00	0	9	f	0	2025-08-19 09:38:22.649+00	2025-08-22 09:58:47.027+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6432	15	88461416	Khan-Uul duureg, 1r horoo Shine ugluu tsogtsolbor ,23c bair hamgin hoid taliin orts 4 davhar 5 n toot	3	1.00	1	13	f	0	2025-08-19 12:01:40.537+00	2025-08-21 15:59:21.86+00	f	\N	\N	\N
6420	2	86111122	Улаанбаатар, Хан-Уул 04-р хороо Viva City S3, Husqvarna Moto\n 	1	6500.00	0	\N	f	0	2025-08-19 06:29:47.17+00	2025-08-19 06:29:47.181+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6421	2	80501717	Улаанбаатар, Хан-Уул 21-р хороо Шүрт хотхон, 812-р байр, flowers&gifts дэлгүүр 	3	6500.00	0	36	f	0	2025-08-19 06:44:49.115+00	2025-08-20 06:10:52.419+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6422	2	85951399	Улаанбаатар, Чингэлтэй 05-р хороо Хангай хотхон 510р байр 05 тоот Хангай хотхоны 510 дээр ирээд 85951399 залгаарай	1	6500.00	0	\N	f	0	2025-08-19 07:22:51.14+00	2025-08-19 07:22:51.157+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6423	2	99016567	Улаанбаатар, Баянзүрх 25-р хороо , Улаанбаатар, Баянзүрх, ногоон төгөл хотхон 75-63 13 давхар CU тэй орц ногоон төгөл хотхон 75-63 13 давхар CU тэй орц оройн цагаар	1	6500.00	0	\N	f	0	2025-08-19 07:55:11.818+00	2025-08-19 07:55:11.84+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6424	2	99080531	Улаанбаатар, Хан-Уул 13-р хороо 15r Khoroo rapid harsh 28-25 kod 2803 1r orts 7n davhar \n\n\n 	3	12100.00	0	6	f	0	2025-08-19 08:01:23.265+00	2025-08-22 09:03:40.414+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6419	2	94590090	Улаанбаатар, Хан-Уул 15-р хороо Tokyo Town 2, 125-1504 	3	6500.00	0	6	f	0	2025-08-19 06:27:41.181+00	2025-08-21 11:51:15.684+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6426	2	95515967	Улаанбаатар, Сонгинохайрхан 10-р хороо Баянхошуу шинэ эцэс збу 11-2б 	3	6500.00	0	12	f	0	2025-08-19 08:45:56.275+00	2025-08-21 14:10:34.899+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6427	2	86136722	Улаанбаатар, Сонгинохайрхан 09-р хороо Baruun bayn uul11-6 toot 86959797is 	3	6500.00	0	12	f	0	2025-08-19 09:03:41.069+00	2025-08-21 14:00:50.614+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6293	2	95543388	Улаанбаатар, Баянзүрх 08-р хороо Ботаник, ус 15 хотхон 4-р байр 60 тоот 	3	6500.00	0	44	f	0	2025-08-15 14:50:24.133+00	2025-08-24 08:01:29.566+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6425	2	89776066	Улаанбаатар, Сүхбаатар 01-р хороо olympic street-19,Shangrilla,6-р байр,A Lkhagvabayar 89776066	3	6500.00	0	37	f	0	2025-08-19 08:15:21.075+00	2025-08-22 11:19:10.72+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6676	41	86304303	hentii bor undur jargalant 1008	3	0.00		9	t	13	2025-08-22 03:12:31.119+00	2025-08-23 03:27:20.819+00	f	\N	\N	\N
6417	2	99447988	Улаанбаатар, Баянгол 17-р хороо Модны 2 Элеганс хотхон 44а-24 тоот 88802170	3	12100.00	0	12	t	9	2025-08-19 05:42:41.132+00	2025-08-20 15:42:43.062+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6416	2	85538292	Улаанбаатар, Баянзүрх 13-р хороо Нарт хотхон 95/3р байр 7р орц 160тоот\n 	3	6500.00	0	9	t	12	2025-08-19 05:32:13.872+00	2025-08-22 04:10:47.895+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6418	2	90022222	1r surguuliin esreg tald bid barilgiin 3 davhart 	3	6500.00	0	\N	f	0	2025-08-19 06:16:34.975+00	2025-08-22 06:40:26.286+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6389	33	89860104	БЗД 16 хороо Монгол хотхон 66е байр 67тоот	3	49000.00	улаан сорочик	18	f	0	2025-08-19 01:07:44.43+00	2025-08-20 01:46:33.42+00	f	\N	\N	\N
6310	2	86965896	Улаанбаатар, Баянзүрх 36-р хороо Их Монгол хороолол 903-р байр 1-р орц 5 давхар 32 тоот (Орцны код #9031) 	3	6500.00	0	6	t	8	2025-08-16 10:42:44.327+00	2025-08-20 15:41:14.642+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6385	32	88907419	Хануул дүүрэг Вива сити Моцарт ресторанд авна аа.	3	25000.00	3	6	t	8	2025-08-18 16:46:26.478+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6503	35	99070266	Да хүрээ зах дээр	5	29900.00	,	9	t	12	2025-08-20 03:58:51.543+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6732	41	85461109	3,4r horoolol 45r bair 2orts	3	0.00		38	f	0	2025-08-23 03:37:50.098+00	2025-08-23 08:33:33.968+00	f	\N	\N	\N
6433	2	91991950	Улаанбаатар, Баянзүрх 16-р хороо Энх-өргөө хотхон 41А байр 1003 тоот  	3	6500.00	0	44	f	0	2025-08-19 12:14:20.549+00	2025-08-24 12:21:43.603+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6830	35	80038831	Жобигийн баруун талд 24-р цэцэрлэг дээр	3	39000.00		9	f	0	2025-08-25 03:40:42.38+00	2025-08-25 09:22:17.415+00	f	\N	\N	\N
6789	35	88823169	Циркийн баруун талд төгөлдөр хотхон/шаргал өнгө/	2	28000.00		37	f	0	2025-08-24 04:09:50.678+00	2025-08-24 04:13:12.857+00	f	\N	\N	\N
6428	2	95092211	Улаанбаатар, Баянгол 26-р хороо Нарны хороолол 28-р байр 20 давхарт 2001 тоот\nОрцны код 1 түлхүүр 1234 	3	6500.00	0	6	f	0	2025-08-19 09:34:02.433+00	2025-08-24 08:28:09.252+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6825	35	88170907	6 буудал сэлбэ дулааны станцын зүүн талын журамын хашааны харуулд үлдээх	3	24000.00		9	f	0	2025-08-25 03:37:41.928+00	2025-08-25 11:04:02.117+00	f	\N	\N	\N
6437	2	90900801	Улаанбаатар, Хан-Уул 17-р хороо King tower 135r bair 1r orts 6n dawhar 113 toot 	1	6500.00	0	\N	f	0	2025-08-19 14:57:33.582+00	2025-08-19 14:57:33.595+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6438	32	89118611	Зайсан Эцэс Хан, Түшээ, хотхон 301.103 тоот	3	49000.00	tsvnh	19	f	0	2025-08-19 20:32:58.89+00	2025-08-21 00:31:29.287+00	f	\N	\N	\N
6439	32	99756589	Зайсан апармент 105 дугаар байр 207 тоот	3	25000.00	t	19	f	0	2025-08-19 20:37:54.099+00	2025-08-21 01:58:53.251+00	f	\N	\N	\N
6442	2	99133443	Улаанбаатар, Сүхбаатар, 1-р хороо"", Худалдаа Хөгжлийн банкны Төв байр 	3	6500.00	0	37	f	0	2025-08-19 23:34:40.754+00	2025-08-22 11:19:13.646+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6443	33	99668003	Зайсан Chinas шорлог	1	70000.00	өмд ажил дээр авна	\N	f	0	2025-08-20 00:47:17.418+00	2025-08-20 01:45:28.908+00	t	\N	\N	\N
6440	32	88442126	Андууд арын 86 дугаар байр	1	39000.00	n	\N	f	0	2025-08-19 20:39:18.47+00	2025-08-20 01:47:46.327+00	t	\N	\N	\N
6446	2	80470475	Улаанбаатар, Сонгинохайрхан 36-р хороо алтан овоо 32 р гудамж 1а тоот 	1	6500.00	0	\N	f	0	2025-08-20 01:49:54.13+00	2025-08-20 01:49:54.144+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6449	35	86805093 99159093	ЧД хуучин эцэс мини маркет дэлгүүр дээр худалдагчид өгөх очхоосоо өмнө залгах	1	50000.00	,	\N	f	0	2025-08-20 02:33:03.892+00	2025-08-20 02:40:14.142+00	t	\N	\N	\N
6450	35	86194910	Дарь эхийн шинэ буудал шунхлай клонк дээр /хар өнгө/	1	46000.00	,	\N	f	0	2025-08-20 02:34:13.75+00	2025-08-20 02:40:14.142+00	t	\N	\N	\N
6451	35	89837386, 99060652	американ дэнж 44ын6 2р орц 95 тоот 	1	35000.00	,	\N	f	0	2025-08-20 02:34:59.862+00	2025-08-20 02:40:14.142+00	t	\N	\N	\N
6452	35	89837386, 99060652	американ дэнж 44ын6 2р орц 95 тоот 	1	35000.00	,	\N	f	0	2025-08-20 02:34:59.965+00	2025-08-20 02:40:14.142+00	t	\N	\N	\N
6454	35	89571200	Шархадны эцэс дээр 17:00 цагаас хойш, ажлын цагаар багшийн дээд дээр авья	1	46000.00	,	\N	f	0	2025-08-20 02:35:57.413+00	2025-08-20 02:40:14.142+00	t	\N	\N	\N
6455	35	88706161	Shangrilla residence 27C тоот CU урд талын хаалгаар	1	46000.00	,	\N	f	0	2025-08-20 02:36:26.025+00	2025-08-20 02:40:14.142+00	t	\N	\N	\N
6456	35	91422488	яармаг global gardenны урд хүсэлийн төгөл хотхон	1	24000.00	,	\N	f	0	2025-08-20 02:37:03.623+00	2025-08-20 02:40:14.142+00	t	\N	\N	\N
6457	35	90598909	бзд 41р хороо 47а байр 72 тоот үзмэн ягаан	1	25000.00	,	\N	f	0	2025-08-20 02:37:29.477+00	2025-08-20 02:40:14.142+00	t	\N	\N	\N
6466	35	99430101	127р сургууль дээр очод залга хар	1	29900.00	,	\N	f	0	2025-08-20 02:52:29.809+00	2025-08-20 03:00:46.225+00	t	\N	\N	\N
6458	35	86805093 99159093	ЧД хуучин эцэс мини маркет дэлгүүр дээр худалдагчид өгөх очхоосоо өмнө залгах	1	50000.00	,	\N	f	0	2025-08-20 02:46:36.526+00	2025-08-20 03:13:07.556+00	t	\N	\N	\N
6587	33	86538653	Завхан аймаг Тосонцэнгэл	3	35000.00	өмд	12	t	11	2025-08-21 03:02:39.256+00	2025-08-21 15:13:05.67+00	f	\N	\N	\N
6470	35	80950166	наран туул комисийн лангуу 	3	19000.00	,	12	t	9	2025-08-20 02:54:51.262+00	2025-08-20 15:42:43.062+00	f	\N	\N	\N
6448	2	88966984	Улаанбаатар, Баянзүрх 05-р хороо Бзд-ийн яаралтай тусламжийн эсрэг талд байрлах 91А байр 5 давхар 503 тоот\n 	3	6500.00	0	44	f	0	2025-08-20 02:30:49.515+00	2025-08-24 09:40:19.028+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6444	33	99668003	Зайсан Chinas шорлог	3	70000.00	өмд ажил дээр авна	19	f	0	2025-08-20 00:47:17.695+00	2025-08-21 06:51:07.994+00	f	\N	\N	\N
6460	35	89837386	амеркан дэнж 44ын6 2р орц 95 тоот 99060652	3	35000.00	,	29	t	10	2025-08-20 02:48:37.442+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
6479	2	99447988	Улаанбаатар, Баянгол 17-р хороо Модны 2 Элеганс хотхон 44а-24 тоот 	3	12100.00	0	38	t	9	2025-08-20 03:01:59.656+00	2025-08-22 07:28:16.242+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6453	32	88864805	СХД 42р сургууль ирээд залгах	1	28000.00	1	\N	f	0	2025-08-20 02:35:25.746+00	2025-08-20 05:37:19.014+00	t	\N	\N	\N
6462	35	88706161	Shangrilla residence 27C тоот CU урд талын хаалгаар	3	46000.00	,	29	t	10	2025-08-20 02:49:24.82+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
6525	20	88024385 88085902	Marshal king tower 135bair 3-217toot	1	1.00	a	\N	f	0	2025-08-20 05:39:34.58+00	2025-08-20 05:39:52.672+00	t	\N	\N	\N
6632	35	90030414	худ хөрш заан хотхон 106а байр 1орц 10-127тоот	3	19000.00		29	f	0	2025-08-21 04:10:20.992+00	2025-08-24 11:14:04.16+00	f	\N	\N	\N
6459	35	86194910	Дарь эхийн шинэ буудал шунхлай клонк дээр /хар өнгө/	3	46000.00	,	7	f	0	2025-08-20 02:47:16.103+00	2025-08-21 09:16:15.424+00	f	\N	\N	\N
6447	32	88864805	схд 42р сургууль дээр ирээд залгахад болно	3	28000.00	т	22	t	15	2025-08-20 02:27:05.443+00	2025-08-23 07:38:17.935+00	f	\N	\N	\N
6591	33	88132656	Архангай Өлзийт сум	3	49000.00	сорочик	12	t	11	2025-08-21 03:17:36.792+00	2025-08-21 15:13:05.67+00	f	\N	\N	\N
6831	35	94945338, 91669699	дарь эхийн хуучин эцэс /хар/ 	3	29900.00		9	f	0	2025-08-25 03:41:27.977+00	2025-08-25 11:56:32.916+00	f	\N	\N	\N
6461	35	89571200	Шархадны эцэс дээр 17:00 цагаас хойш, ажлын цагаар багшийн дээд дээр авья	5	46000.00	,	9	t	12	2025-08-20 02:49:01.301+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6445	32	85111656	чд 18р хороо элбэг дэлгүүр	3	25000.00	т	7	f	0	2025-08-20 01:43:42.927+00	2025-08-21 08:02:59.121+00	f	\N	\N	\N
6465	35	90113809	хүүхэд залуучууд  теарийн баруун  талаар хойшоо өгсөөд цалгим дэлгүүр дээр хар	3	29900.00	,	22	t	15	2025-08-20 02:51:25.535+00	2025-08-23 07:38:17.935+00	f	\N	\N	\N
6616	35	88554018	нисэх гарден 326байр 105тоот /хар/	3	28000.00		29	f	0	2025-08-21 03:51:20.479+00	2025-08-21 12:26:06.354+00	f	\N	\N	\N
6678	41	99307239	urihan	1	0.00		\N	f	0	2025-08-22 03:14:14.138+00	2025-08-22 06:54:56.778+00	t	\N	\N	\N
6463	35	91422488	яармаг global gardenны урд хүсэлийн төгөл хотхон	5	24000.00	,	29	f	0	2025-08-20 02:49:51.932+00	2025-08-23 08:13:05.434+00	f	\N	\N	\N
6796	31	98990078	Баянхонгор аймаг	3	1.00		9	f	0	2025-08-24 11:23:53.885+00	2025-08-25 05:51:00.691+00	f	\N	\N	\N
6833	35	99772297	сүхбаатар дүүрэг  17р хороо 56р гудамж 58р сургуулийн ард очод залга шар өнгө	3	28000.00		9	f	0	2025-08-25 03:44:45.884+00	2025-08-25 11:11:51.298+00	f	\N	\N	\N
6680	41	99444485	zuunharaa	1	0.00		\N	f	0	2025-08-22 03:15:21.806+00	2025-08-22 06:54:56.778+00	t	\N	\N	\N
6504	35	99733729	хэнтий	5	46000.00	,	13	f	0	2025-08-20 03:59:20.308+00	2025-08-22 08:43:42.131+00	f	\N	\N	\N
6473	35	89998745	Нарантуул зах гэр ахуйн хуучин барааны хажууд 86502772	3	19000.00	,	12	t	9	2025-08-20 02:56:31.902+00	2025-08-20 15:42:43.062+00	f	\N	\N	\N
6492	35	88250609	БЗД 16 хороолол 53-р сургуулийн баруун талаар хойш өгсөөд хар өнгө	3	29900.00	,	29	t	10	2025-08-20 03:13:16.304+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
6494	35	99786918	svhbaatar  	3	1.00	тооцоо авахгүй 	12	t	9	2025-08-20 03:29:52.796+00	2025-08-20 15:42:43.062+00	f	\N	\N	\N
6471	35	80068262	 5р сургуурь 20ын 5р байр 32 тоот 	3	28000.00	хар	13	f	0	2025-08-20 02:55:16.926+00	2025-08-21 12:56:35.633+00	f	\N	\N	\N
6496	35	99020894	Аманхуур хотхон 33В 11 тоот	3	24000.00	,	12	t	9	2025-08-20 03:32:43.595+00	2025-08-20 15:42:43.062+00	f	\N	\N	\N
6506	35	99695797	032-р ангийн эсрэг талын шшг-н байр 36В байр 2-8 тоот 88652189	3	29900.00	,	29	t	10	2025-08-20 04:00:20.313+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
6509	2	89621177	Улаанбаатар, Баянзүрх 12-р хороо Tsaiz 16 16r bair 1r orts 8 toot \n 	3	6500.00	0	9	t	13	2025-08-20 04:18:32.147+00	2025-08-23 03:27:20.819+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6507	35	99181304	Баянзүрх хороолол 108 дээж маркеттай байр 6 давхар 55 тоот	3	24000.00	,	29	t	10	2025-08-20 04:01:00.434+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
6467	35	89027692	нисэхийн гэрлэн дохиогоор эргээд эхний буудал хар	3	29900.00	,	36	f	0	2025-08-20 02:52:51.546+00	2025-08-20 12:46:53.242+00	f	\N	\N	\N
6497	35	80556633	БЗД цагаан хуаран 88В 4 давхарт 95 тоот	3	19000.00	,	12	t	9	2025-08-20 03:43:40.776+00	2025-08-20 15:42:43.062+00	f	\N	\N	\N
6474	35	99196313	Яармаг хүннү малл эсрэг талд VIP residence 462-р байр	3	25000.00	,	36	f	0	2025-08-20 02:56:54.358+00	2025-08-20 09:42:01.746+00	f	\N	\N	\N
6588	33	99829930	Мөнгөн завъяа	3	35000.00	хөх өмд	\N	f	0	2025-08-21 03:03:19.106+00	2025-08-22 06:40:14.281+00	f	\N	\N	\N
6468	35	80801575	чингэлтэй 9р хороо усны 2ын 9 тоот хар 	3	28000.00	,	7	f	0	2025-08-20 02:53:14.895+00	2025-08-21 07:19:19.01+00	f	\N	\N	\N
6650	41	80919798	altai hothon 52a bair 2orts 128toot	3	0.00		6	f	0	2025-08-21 17:44:19.285+00	2025-08-22 07:21:52.891+00	f	\N	\N	\N
6366	2	88102145	Улаанбаатар, Хан-Уул 22-р хороо , Улаанбаатар, Хан-Уул, ХАЙС-ын баруун тал 45 р байр оранж дэлгүүр ХАЙС-ын баруун тал 45 р байр оранж дэлгүүр 	3	6500.00	0	19	f	0	2025-08-18 09:49:54.961+00	2025-08-20 06:03:36.19+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6469	35	95113966	 чингэлтэй эцэсийн наад буудал цогтийн ам очод залга гарч ирээд авна	5	25000.00	,	12	f	0	2025-08-20 02:53:57.402+00	2025-08-26 04:51:12.511+00	f	\N	\N	\N
6476	35	99224605	СИУС баруун талд 44-р байр 77 тоот /бэлэн мөнгө өгнө/	5	19000.00	бэлэн мөнгө өгнө хөгшин хүн шилжүүлж чадахгүй гсэн	13	f	0	2025-08-20 02:59:11.505+00	2025-08-21 12:56:03.883+00	f	\N	\N	\N
6508	35	91998820	Ботаник эцэсийн буудлын хойно хос маргад турк сургуулийн 55 байр 4 давхар 16 тоот	3	24000.00	,	12	t	9	2025-08-20 04:01:25.878+00	2025-08-20 15:42:43.062+00	f	\N	\N	\N
6464	35	90598909	бзд 41р хороо 47а байр 72 тоот үзмэн ягаан	3	25000.00	,	29	t	10	2025-08-20 02:50:47.903+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
6475	35	88052305	БЗД 22 хороо дэлгэрэх апартмент 103А байр 2 орц 7-4050 тоот	3	24000.00	,	29	t	10	2025-08-20 02:58:17.529+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
6477	35	99817553	89220102 БЗД Сувдан сондор 71Б 110 тоот	3	19000.00	,	29	t	10	2025-08-20 03:01:23.44+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
6480	35	99600962	Алтай хотхон 46а байр 1 орц 13 давхар 67 тоот /цайвар ягаан/	3	25000.00	,	6	t	8	2025-08-20 03:02:17.639+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6501	35	85896080	дорнод баяндун сум /шар/	5	28000.00	,	9	t	12	2025-08-20 03:57:43.48+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6805	41	95726768	tumur zamiin 81 bairnii 14toot	3	0.00		9	f	0	2025-08-24 21:23:56.39+00	2025-08-26 05:31:44.909+00	f	\N	\N	\N
6472	35	89472717	Хөвсгөл аймаг тариалан сум /Үзмэн ягаан/ 	3	25000.00	нарантуул дээрээс унаа явдаг	22	t	14	2025-08-20 02:56:08.713+00	2025-08-23 07:38:12.958+00	f	\N	\N	\N
6484	2	95092211	Улаанбаатар, Баянгол 26-р хороо Нарны хороолол 28-р байр 20 давхарт 2001 тоот\nОрцны код 1 түлхүүр 1234 	3	6500.00	0	6	f	0	2025-08-20 03:04:22.879+00	2025-08-22 07:44:21.226+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6478	35	99545445	Зайсан сүлд хотхон 100-7 байр 6 давхар 27 тоот 18:00 цагаас хойш	3	24000.00	,	19	f	0	2025-08-20 03:01:53.283+00	2025-08-22 11:01:12+00	f	\N	\N	\N
6481	35	99991332	худ 19хороо нутгийн буян 14байр 10-1006тоот	3	39000.00	,	6	t	8	2025-08-20 03:02:45.151+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6489	35	89118175	Гурвалжын гүүр даваад монгол тамхи со зүүн талын хашаа 4 улаан тоосгон байшин	3	19000.00	,	6	t	8	2025-08-20 03:07:01.734+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6495	35	88098454	Тэц 3 баруун хойно тод клонк дээр 96960242	3	39000.00	,	6	t	8	2025-08-20 03:30:25.039+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6500	35	88758621	hud 3 дэлгэрэх хотхон 80/6байр 7-58тоот	3	29900.00	99776691	6	t	8	2025-08-20 03:51:02.965+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6431	2	86669816	Улаанбаатар, Сонгинохайрхан 16-р хороо Схд дүүрэг 18-хороо 29-р байр Vita апартмент 8давхар 805 тоот 	1	6500.00	0	22	f	0	2025-08-19 11:21:55.424+00	2025-08-20 05:09:38.812+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6513	2	99119789	Улаанбаатар, Баянзүрх 26-р хороо , Улаанбаатар, Баянзүрх, Crystal town 803 203 Crystal town 803 203 	3	6500.00	0	38	f	0	2025-08-20 04:39:13.369+00	2025-08-24 13:17:05.612+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6483	35	80076488	дарь хуучин эцэс 132р сургууль /ягаан/ 	5	25000.00	,	12	f	0	2025-08-20 03:04:06.69+00	2025-08-26 04:51:12.511+00	f	\N	\N	\N
6487	35	89550814	Ганц худгын буудал 127-р сургууль дээр хар өнгө	3	28000.00	,	7	f	0	2025-08-20 03:05:38.039+00	2025-08-21 09:16:27.781+00	f	\N	\N	\N
6517	2	99404824	Улаанбаатар, Баянзүрх 26-р хороо Mandala town, 320/1, 4 davhar, 14 toot 	3	6500.00	0	6	f	0	2025-08-20 05:13:34.682+00	2025-08-22 10:33:38.676+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6519	20	99886041	Hud 23 horoo nutgiin buyn happy residence 883 bair 1orts 801toot 	3	1.00	a	36	f	0	2025-08-20 05:38:37.765+00	2025-08-20 08:59:07.43+00	f	\N	\N	\N
6320	2	90262200	Улаанбаатар, Баянзүрх 12-р хороо БЗД Амгалан төмөр зам призер замынхаа урд 79р байр 4 давхар 27 тоот 	3	6500.00	0	12	f	0	2025-08-17 03:05:07.99+00	2025-08-20 11:55:23.726+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6319	2	99048702	Улаанбаатар, Хан-Уул, 15-р хорооРивер вилла 8/1 байр, Ривер вилла 8/1  байр 24 тоот\n(Их наядын зүүн талд) 	3	6500.00	0	6	t	8	2025-08-17 00:59:12.978+00	2025-08-20 15:41:14.642+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6522	2	85977376	Улаанбаатар, Чингэлтэй 07-р хороо Zuragt huuchin etses awtobusnii buudal deer ireed zalgah 	3	6500.00	0	38	f	0	2025-08-20 05:39:09.738+00	2025-08-23 04:21:31.953+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6516	2	99404824	Улаанбаатар, Баянзүрх 26-р хороо Mandala town, 320/1, 4 davhar, 14 toot 	3	6500.00	0	6	f	0	2025-08-20 05:12:39.964+00	2025-08-24 14:05:08.496+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6352	2	88548003	Улаанбаатар, Сонгинохайрхан 18-р хороо 41 r bair (geologi 210) \n1r orts 1307 toot (13 dawhar) 	3	6500.00	0	22	f	0	2025-08-18 05:13:33.112+00	2025-08-20 08:37:56.764+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6498	35	88052669	Viva city N21 байр 4 давхар 3 тоот хар өнгө	3	29900.00	,	36	f	0	2025-08-20 03:44:22.521+00	2025-08-20 07:08:55.042+00	f	\N	\N	\N
6528	20	80883635	Bzd 12 horoo serene town 82b 1 orts 2 davhar 9toot	3	1.00	a	12	t	9	2025-08-20 06:00:44.431+00	2025-08-20 15:42:43.062+00	f	\N	\N	\N
6583	31	80213060	Улаанбаатар, Сүхбаатар дүүрэг, 10-р хороо, 100ail tsagdaagin gudamj 112dugar bair 6dawhar 23toot	3	1.00		37	f	0	2025-08-21 01:24:39.824+00	2025-08-22 15:02:19.543+00	f	\N	\N	\N
6361	15	99761009	Дарханы унаанд тавих	3	1.00	1	22	f	0	2025-08-18 07:50:57.384+00	2025-08-20 07:58:36.179+00	f	\N	\N	\N
6529	20	96961277	Nisehiin etses	5	46000.00	a	29	f	0	2025-08-20 06:09:43.819+00	2025-08-23 08:10:05.131+00	f	\N	\N	\N
6527	20	88024385 88085902	Marshal king tower 135bair 3-217toot	3	117000.00	a	19	f	0	2025-08-20 05:40:31.174+00	2025-08-20 08:42:46.865+00	f	\N	\N	\N
6371	2	88504332	Улаанбаатар, Сонгинохайрхан 04-р хороо “Орчлон хороолол 2” 29-р байр 61тоот 	3	6500.00	0	22	f	0	2025-08-18 11:55:46.586+00	2025-08-20 09:58:53.548+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6367	2	99280433	Улаанбаатар, Сонгинохайрхан 10-р хороо Зүүнбаянуулын 26.5А  	3	6500.00	0	22	f	0	2025-08-18 10:01:49.243+00	2025-08-20 10:34:59.309+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6482	35	85155085	Blue sky-н урд Silk road-н урд airmarket-н office дээр утсаа авахгүй бол харуул дээр үлдээх	3	19000.00	,	29	t	10	2025-08-20 03:03:31.671+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
6502	35	99142035	цагаан хуаран 1р байр гарч ирээд авна 	5	24000.00	,	29	t	10	2025-08-20 03:58:18.728+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
6317	2	89038827	Улаанбаатар, Баянзүрх 08-р хороо Улаанбаатар, Баянзүрх, 8-р хороо 89038827 90168827 	3	6500.00	0	12	f	0	2025-08-16 19:52:42.385+00	2025-08-20 12:26:09.199+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6339	2	99127999	Улаанбаатар, Баянзүрх 06-р хороо Улаанбаатар, Баянзүрх, 6-р хороо 13-р хороолол 31-р байр нэг орцтой орцоор зүүн жигүүрээр 6-р давхарт 19н тоот 	3	6500.00	0	9	f	0	2025-08-17 15:31:31.878+00	2025-08-22 06:11:59.702+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6573	33	88604438	БЗ худалдааны төвийн 2 давхарын шатан дээр	1	70000.00	цамц	\N	f	0	2025-08-21 01:06:22.929+00	2025-08-21 03:04:56.305+00	t	\N	\N	\N
6565	32	89826013	БЗД 16-р хороо Монгол хотхон 66с байр 1р орц 2давхар 18тоот	1	30000.00	Ө	\N	f	0	2025-08-20 16:48:12.466+00	2025-08-21 03:21:22.894+00	t	\N	\N	\N
6523	20	99850826 95210616 	Darhan	3	1.00	a	22	t	14	2025-08-20 05:39:09.793+00	2025-08-23 07:38:12.958+00	f	\N	\N	\N
6515	35	96580126	Баганат хороолол 407 байр 49 тоот 19:00 цагаас хойш	5	39000.00	,	9	t	12	2025-08-20 04:41:00.201+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6514	35	99183407	саруул зах 99042531	3	24000.00	ажлын цагаар	6	f	0	2025-08-20 04:40:16.404+00	2025-08-21 13:14:50.595+00	f	\N	\N	\N
6584	31	94000076	Улаанбаатар, Хан-уул дүүрэг, 17-р хороо, Оргил стар хотхон 59 байр 4 орц 2 давхар 5904#	3	1.00		19	f	0	2025-08-21 01:29:09.562+00	2025-08-22 04:45:25.332+00	f	\N	\N	\N
6510	35	99129289	4р дэлгүүрийн хажууд ногоон урлан хотхоны  ард талын 10р байр 21 тоот	5	19000.00	,	13	f	0	2025-08-20 04:26:25.876+00	2025-08-26 04:51:12.511+00	f	\N	\N	\N
6531	2	85454180	Улаанбаатар, Баянгол 12-р хороо Бичилийн арк, 6Б байр, 2р орц, 7давхар, 63тоот,\nорцний код: 2341 	1	6500.00	0	\N	f	0	2025-08-20 06:47:44.669+00	2025-08-20 06:47:44.692+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6532	2	80685959	Улаанбаатар, Баянгол 24-р хороо Алтай хотхон, 50в байр, 1-р орц, 1 тоот 	3	6500.00	0	6	f	0	2025-08-20 07:01:30.204+00	2025-08-23 10:30:00.712+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6533	2	95524568	Улаанбаатар, Баянгол 03-р хороо 4015 Төмөр замын удирдах газрын зүүн талл сөүл-40 байр 15 тоот	1	6500.00	0	\N	f	0	2025-08-20 07:02:06.974+00	2025-08-20 07:02:06.986+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6585	32	80020349	цагдаа хотхон 75-4	3	80000.00		9	t	13	2025-08-21 01:52:12.56+00	2025-08-23 03:27:20.819+00	f	\N	\N	\N
6551	20	88622730	Chd 10 horoo 39r surguuli ard tal shinechlel horoolol 807r bair 	3	46000.00	a	22	t	14	2025-08-20 14:41:34.328+00	2025-08-23 07:38:12.958+00	f	\N	\N	\N
6335	2	80501717	Улаанбаатар, Хан-Уул 21-р хороо Шүрт хотхон, 812-р байр, flowers&gifts дэлгүүр 	3	6500.00	0	36	f	0	2025-08-17 08:25:36.79+00	2025-08-20 07:51:07.691+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6535	2	99885378	Улаанбаатар, Баянзүрх 26-р хороо Global park 712 B1 20davhar 2004 toot 	3	6500.00	0	6	f	0	2025-08-20 07:28:36.454+00	2025-08-22 10:01:18.978+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6538	2	99080531	Улаанбаатар, Хан-Уул 13-р хороо 15r Khoroo rapid harsh 28-25 kod 2803 1r orts 7n davhar \n\n\n 	3	12100.00	0	6	f	0	2025-08-20 08:35:00.766+00	2025-08-22 09:03:59.038+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6550	2	99018902	Улаанбаатар, Баянзүрх 12-р хороо Улаанбаатар, Баянзүрх, 12-р хороо 2гудамж жанжингийн 38 тоот " ботаник оргилийн зүүн талаар урагшаагаа эргээд хамгийн эхний гудамж 38 тоот"  Hurgeltee tsag tuidan hiihgui 7 honood bhiinmaa\n	3	6500.00	0	44	f	0	2025-08-20 14:28:30.232+00	2025-08-24 07:40:19.62+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6546	2	99116737	Улаанбаатар, Баянгол 06-р хороо Уб палас Дако 10а байр 104 тоот 	3	6500.00	0	38	f	0	2025-08-20 13:06:26.765+00	2025-08-23 09:43:46.84+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6541	2	94965505	Улаанбаатар, Баянзүрх 36-р хороо Баян Монгол Хороолол 403 байр 2 орц 74 тоот 	1	6500.00	0	\N	f	0	2025-08-20 10:04:51.758+00	2025-08-20 10:04:51.772+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6499	35	90151591	Хайлаастын 84-н буудал 16:00 цагаас хойш хар өнгө	3	28000.00	,	7	f	0	2025-08-20 03:45:01.175+00	2025-08-21 07:51:16.097+00	f	\N	\N	\N
6050	2	88100459	Улаанбаатар, Хан-Уул 20-р хороо Улаанбаатар, Хан-Уул, 20-р хороо Хан уул дүүргийн урд Ивээл хотхон 41а байр 207тоот 	3	6500.00	0	4	f	0	2025-07-29 15:56:41.727+00	2025-08-20 11:10:55.912+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6441	32	88442126	Андууд арын 86 дугаар байр	3	39000.00	n	\N	f	0	2025-08-19 20:39:18.655+00	2025-08-20 11:13:48.564+00	f	\N	\N	\N
6545	34	89601113	11р хроолл 5р байр /5а биш/3р орц 5дав 91тоот #0605 номингын төв замын эсрэг талд бор алаг байр	3	16000.00	tootsoogui	40	f	0	2025-08-20 12:00:30.774+00	2025-08-22 05:56:00.329+00	f	\N	\N	\N
6539	2	98118448	Улаанбаатар, Чингэлтэй 13-р хороо Akuma zone chanh honino lexus rx harrier kuluger highlander zaswar selbegiin turn 	3	6500.00	0	12	f	0	2025-08-20 08:40:23.054+00	2025-08-23 11:56:03.557+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6534	2	86228224	Улаанбаатар, Баянгол 24-р хороо Altai hothon 50b bair 14davhar 75toot\n 	3	6500.00	0	6	f	0	2025-08-20 07:05:07.932+00	2025-08-23 10:29:53.074+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6548	20	89061207	Bzd 31 horoo monel 17r gudamj 369b 	5	46000.00	a	44	f	0	2025-08-20 13:10:48.397+00	2025-08-24 03:09:56.915+00	f	\N	\N	\N
6547	20	88154303	Ofitser atovusnii buudliin shunhlaa kolonkiin chanh urd 118bair 5toot 	3	46000.00	a	12	t	9	2025-08-20 13:10:29.891+00	2025-08-20 15:42:43.062+00	f	\N	\N	\N
6540	2	99939421	соёл урлагийн их сургууль	1	6500.00	0	\N	f	0	2025-08-20 10:04:27.93+00	2025-08-23 06:03:05.813+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6530	20	80870915	Bgd 26horoo teeverchdiin gudamj 11 bair 2 orts 6davhar 107toot	5	46000.00	a	6	t	8	2025-08-20 06:16:00.806+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6549	2	80941824	Улаанбаатар, Сонгинохайрхан 37-р хороо Содон хороолол, 110-байр, 1-орц, 10давхар, 66тоот, \n 	3	6500.00	0	12	f	0	2025-08-20 14:19:47.745+00	2025-08-22 13:37:43.784+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6542	2	89968031	Улаанбаатар, Сонгинохайрхан 09-р хороо Уул 4 12 тоот 	3	6500.00	0	12	f	0	2025-08-20 11:45:25.863+00	2025-08-22 14:17:59.993+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6543	34	93000270	Narnii horoolol 6r bair 1r orts 12 davhard 45toot	3	41000.00	Tootsoogui	6	f	0	2025-08-20 11:58:54.871+00	2025-08-21 06:54:43.069+00	f	\N	\N	\N
6590	33	90112619	Гэмтлийн эмнэлэгт	1	32000.00	өмд	\N	f	0	2025-08-21 03:16:54.003+00	2025-08-21 07:06:12.904+00	t	\N	\N	\N
6544	34	95575572	erin horoolol 53/10r bair 2r orts 5dawhar 85 toot kod-#5312	3	41000.00	tootsoogui	12	f	0	2025-08-20 11:59:24.563+00	2025-08-21 10:09:25.593+00	f	\N	\N	\N
6594	35	99181827	Нарантуул зүүн хаалга хром бакал дээр	3	24000.00		9	t	12	2025-08-21 03:37:03.905+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6597	35	88005627	Цагаан хуаран хотхон 86А байр 136 тоот 88839656	5	35000.00		9	t	12	2025-08-21 03:39:43.992+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6592	32	89186363	чойр унаанд тавих	5	25000.00		9	t	13	2025-08-21 03:32:35.422+00	2025-08-23 03:27:20.819+00	f	\N	\N	\N
6098	2	99208305	Улаанбаатар, Хан-Уул 20-р хороо Misheel expo baruun tald 92a bair 9d 109 toot  	3	6500.00	0	6	t	8	2025-08-01 05:04:49.172+00	2025-08-20 15:41:14.642+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6342	2	99192264	Улаанбаатар, Баянзүрх 26-р хороо Crystal town-ii zamiin baruun urd Arig banktai barilgiin 3 davhart Pearl shudnii emneleg (19 tsag hurtel ajillana) 	3	12100.00	0	6	t	8	2025-08-17 17:47:01.962+00	2025-08-20 15:41:14.642+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6387	32	85116782	Хүннү молби нэг давхарт бенэттон дэлгүүр дээр авъя.	3	25000.00	4	6	t	8	2025-08-18 16:48:21.058+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6397	32	89039136	120awto buudaldeer ired zalgah temeetei hoshoo	3	46000.00	1	6	t	8	2025-08-19 01:31:10.911+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6511	35	80806164	120 мянгат мөнх товер 1 давхарт 104 тоот хар өнгө	3	29900.00	,	6	t	8	2025-08-20 04:27:28.003+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6524	20	99639340	Bzd 26 horoo sunny town hothon big fish zagasbii delguur	3	1.00	a	6	t	8	2025-08-20 05:39:23.589+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6526	20	85599664	Hud 3 horoo elegansiin gudamj 12 bair 2 orts 9 davhar 908toot	3	46000.00	a	6	t	8	2025-08-20 05:39:48.057+00	2025-08-20 15:41:14.642+00	f	\N	\N	\N
6536	2	88061212	Улаанбаатар, Баянзүрх, халдварт нарт хотхон 95/1 9 давхар 88 тоот 80816289 энэ дугаарлуу залгаж заалгаж авч болно балжка явуулсан хүргэлт гэж хэлэрэй халдварт нарт хотхон 95/1 9 давхар 88 тоот 80816289 энэ дугаарлуу залгаж заалгаж авч болно 	3	6500.00	a	12	t	9	2025-08-20 08:21:29.274+00	2025-08-20 15:42:43.062+00	f	\N	\N	\N
6216	2	88383668 80779823	Улаанбаатар, Чингэлтэй, 4-р хороо10-р Байр 10-R Bair, ЧД 4-р хороо Хүнсний 1 хойно Пума 10-р байр 	3	6500.00	0	29	t	10	2025-08-10 06:11:55.241+00	2025-08-20 15:43:31.284+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6254	2	99098138	Улаанбаатар, Сүхбаатар 05-р хороо Хүүхдийн 100, Авлигатай тэмцэх газрын зүүн хаалга, Олон нийтийн төв 	3	6500.00	0	29	t	10	2025-08-12 06:50:57.409+00	2025-08-20 15:43:31.284+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6346	31	88035067	Баянбүрдийн тойрог 7799 авто засвар ирээд залгах	3	35000.00	тооцоо авах	29	t	10	2025-08-18 02:40:28.93+00	2025-08-20 15:43:31.284+00	f	\N	\N	\N
6561	32	88614171	Цагаан хуаран ард шилэн хүрэн 87б байр 10давхар 90тоот	3	28000.00	очихоосоо өмнө ярьж хаяг лавлаж асуух	9	t	13	2025-08-20 16:44:23.505+00	2025-08-23 03:27:20.819+00	f	\N	\N	\N
6576	33	80083795	Эрдэнэт хот	1	35000.00	заавал Эрдэнэтийн автобусаар авна	\N	f	0	2025-08-21 01:10:10.869+00	2025-08-21 05:41:23.798+00	t	\N	\N	\N
6574	2	99102142	Улаанбаатар, Хан-Уул 02-р хороо Улаанбаатар, Хан-Уул, 2-р хороо Хан уул дүүрэг 2 р хороо, Бадрах хотхон А1 блок. 13р байр, 14 давхар 1401 тоот Утас 99102142 	3	6500.00	0	6	f	0	2025-08-21 01:07:21.127+00	2025-08-23 11:20:57.904+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6581	31	99212677	Улаанбаатар, Хан-уул дүүрэг, 23-р хороо, Hidden hills luxury residence	3	1.00	Yarmag shine hotiin zahirgaanii ertuntsiin zugeer zuun talaar urshaa yavaad hidden hills luxury residense	29	f	0	2025-08-21 01:22:30.706+00	2025-08-21 15:50:22.074+00	f	\N	\N	\N
6558	2	89401008	Улаанбаатар, Баянзүрх, 12-р хорооБотаник центр хотхон, 104 bair 142 toot 	3	6500.00	0	44	f	0	2025-08-20 15:32:45.771+00	2025-08-23 08:16:55.709+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6577	33	80083795	Эрдэнэт хот	3	35000.00	заавал Эрдэнэтийн автобусаар авна	12	t	11	2025-08-21 01:10:11.126+00	2025-08-21 15:13:05.67+00	f	\N	\N	\N
6559	32	99005948	Замын цагдаа 61-р байр 14.250тоот	3	28000.00	О.х	\N	f	0	2025-08-20 16:41:38.124+00	2025-08-22 11:32:37.217+00	f	\N	\N	\N
6569	32	89895560	Модны 2н голын замын монген сургуулийн хажууд парис бильардны газрын хажуудах хими цэвэрлэгээны газар авна	3	49000.00		38	f	0	2025-08-20 18:47:53.607+00	2025-08-21 07:26:11.364+00	f	\N	\N	\N
6560	32	95030355	Архангай аймаг унаанд тавих	3	56000.00	О.х	12	t	11	2025-08-20 16:43:12.642+00	2025-08-21 15:13:05.67+00	f	\N	\N	\N
6570	32	80115007	7буудал дээрээс авна	3	49000.00	Очихоосоо өмнө ярих өвөрсогоотоос ирж авна	22	t	14	2025-08-20 18:49:03.455+00	2025-08-23 07:38:12.958+00	f	\N	\N	\N
6582	31	99092549	Bluesky 1 давхарт ирээд залгах	3	1.00		37	f	0	2025-08-21 01:23:43.85+00	2025-08-22 04:31:44.206+00	f	\N	\N	\N
6564	32	99842224	Дархан унаанд тавих	3	38000.00	Хө.х	12	t	11	2025-08-20 16:46:58.339+00	2025-08-21 15:13:05.67+00	f	\N	\N	\N
6578	33	99839888	Яармаг 3 буудал Гарден Вилла 180-47 тоот	3	49000.00	сорочик	29	f	0	2025-08-21 01:11:32.677+00	2025-08-22 05:47:08.852+00	f	\N	\N	\N
6575	33	80001652	ХУД 24 хороо Ханбогд хотхон409 байр 1 орц 8 давхар 39 тоот	3	49000.00	сорочик	29	f	0	2025-08-21 01:08:54.895+00	2025-08-22 05:36:30.717+00	f	\N	\N	\N
6562	32	99078545	Алтай хотхон 29-р байр 2р орц 12-156тоот	3	28000.00	О.х	6	f	0	2025-08-20 16:45:27.206+00	2025-08-22 07:15:33.213+00	f	\N	\N	\N
6579	33	99728719	Баянхошуу Жанцангийн буудал 50 айлын орон сууц	5	35000.00	өмд	9	f	0	2025-08-21 01:12:44.667+00	2025-08-25 06:59:56.402+00	f	\N	\N	\N
6567	32	85111656	ЧД 18р хороо Элбэг дэлгүүр дээр авна	5	25000.00		\N	f	0	2025-08-20 18:44:50.819+00	2025-08-24 03:45:46.054+00	f	\N	\N	\N
6563	32	88687852	зайсангийн оргил сүпермаркет дээр ирээд залгах	3	38000.00	Хө.х	19	f	0	2025-08-20 16:46:25.464+00	2025-08-25 01:29:48.537+00	f	\N	\N	\N
6589	33	88604438	БЗ худалдааны төвийн 2 давхарын шатан дээр	5	105000.00		9	t	13	2025-08-21 03:05:55.355+00	2025-08-23 03:27:20.819+00	f	\N	\N	\N
6488	35	99430101	127р сургууль дээр очод залга хар	1	25000.00	Үзмэн ягаан 	7	f	0	2025-08-20 03:06:34.439+00	2025-08-21 03:59:38.871+00	t	\N	\N	\N
6635	35	91147458	Хайлааст хаан банктай эцэс дээр очоод залгах хайлаастын завсар 3-р буудал 	3	25000.00		12	f	0	2025-08-21 04:17:47.867+00	2025-08-23 11:12:46.736+00	f	\N	\N	\N
6313	2	99595747	Улаанбаатар, Баянзүрх 14-р хороо centrall mall -н арын байр 18б-215 тоот -99465615 	3	6500.00	0	9	f	0	2025-08-16 12:01:52.415+00	2025-08-21 04:15:23.496+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6512	35	99320280	6 өмнө дарь эх радиатор сервис, 6 хойш бол дарь эхийн шинэ буудал монел эргээд оргиол дэлгүүр /хар/	3	29900.00	,	7	f	0	2025-08-20 04:37:41.421+00	2025-08-21 09:16:39.699+00	f	\N	\N	\N
6610	35	88080427	чулуун овооны номингийн урд new life хотхон ажлын цагаар	5	46000.00		9	t	12	2025-08-21 03:47:16.767+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6606	35	96322332	Бөмбөрийн boxmall бичиг дээр	5	24000.00		40	f	0	2025-08-21 03:44:50.473+00	2025-08-22 05:09:56.778+00	f	\N	\N	\N
6604	35	99124667	ХУД River garden 405 байр болдцэцэг эмнэлэг дээр	3	19000.00		6	f	0	2025-08-21 03:43:50.036+00	2025-08-21 07:31:29.979+00	f	\N	\N	\N
6625	2	88809011	Улаанбаатар, Баянгол 09-р хороо Sot-2/1 байр 2р орц 2 давхар 84 тоот  	3	6500.00	0	38	f	0	2025-08-21 03:57:03.722+00	2025-08-24 12:31:14.348+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6634	35	99021758	 хуучин бөмбөгөр гарч ирээд авна, 	5	24000.00		40	f	0	2025-08-21 04:17:07.29+00	2025-08-21 06:55:44.592+00	f	\N	\N	\N
6601	35	88579796	чухаг 2 хотхон 601байр 2орц 11-100тоот	3	19000.00		6	f	0	2025-08-21 03:42:03.858+00	2025-08-21 10:06:48.776+00	f	\N	\N	\N
6598	35	99638396	удирдлагын акамедын зүүн талд өргөтгөл баригдаж байгаа харуул дээр ганболд гэж хүнд "жолооч баатарт" гэж үлдээх	3	35000.00		6	f	0	2025-08-21 03:40:22.159+00	2025-08-21 07:13:50.533+00	f	\N	\N	\N
6620	35	91614920	100айлын зөгийн үүрийн баруун талын 906байр 19тоот /хар/	3	28000.00		7	f	0	2025-08-21 03:53:35.657+00	2025-08-21 11:37:05.271+00	f	\N	\N	\N
6608	35	95147250	ХУД 3 хороо нүхтийн 23-408 тоот	3	19000.00		29	f	0	2025-08-21 03:45:41.749+00	2025-08-22 05:51:37.867+00	f	\N	\N	\N
6630	32	88261660	Худ 10р хороо Оюу хотхон 74р байр 1001тоот	3	28000.00		29	f	0	2025-08-21 04:03:28.39+00	2025-08-22 06:17:04.276+00	f	\N	\N	\N
6593	35	99181827	 Нарантуул зүүн хаалга хром бакал дээр	1	0.00		9	f	0	2025-08-21 03:36:34.446+00	2025-08-21 11:48:45.009+00	t	\N	\N	\N
6631	2	99106752	Улаанбаатар, Хан-Уул, 18-р хорооHunnu2222, 214-р байр 2-р орц 18 давхар 1803 тоот 1 давхараас 1803 тоотруу залгана 	3	6500.00	0	19	f	0	2025-08-21 04:05:55.312+00	2025-08-25 08:19:49.36+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6600	35	99794896	Саруул хотхон 120р байр 5 давхар 87 тоот	5	39000.00		12	f	0	2025-08-21 03:41:27.039+00	2025-08-26 04:51:12.511+00	f	\N	\N	\N
6628	15	99070244	Bgd 7r horoo 72-3 toot. Gobi saunii urd taliin 5 davhar huren bairnii 2 davhart. Dooroo nature salontoi bair gsn ug	3	0.00	1	38	f	0	2025-08-21 04:02:50.523+00	2025-08-22 10:46:22.147+00	f	\N	\N	\N
6607	35	88027411	сонсголон 2р автобусны буудал очод залга	3	35000.00		29	f	0	2025-08-21 03:45:14.201+00	2025-08-22 11:09:13.332+00	f	\N	\N	\N
6611	35	91077717	нисэх шинэ яармаг хороолол 746байр 35тоот	3	24000.00		29	f	0	2025-08-21 03:47:56.342+00	2025-08-21 13:19:12.978+00	f	\N	\N	\N
6603	35	99347301	Тэнгис 5-р байр 1 орц 8 тоот /цайвар ягаан/	3	25000.00		40	f	0	2025-08-21 03:43:20.902+00	2025-08-21 15:29:16.736+00	f	\N	\N	\N
6618	35	98323874	11хороолол ардчлалын ордны арын 11байрны оёдлын цех урд талаас нь ордог  91014414	5	19000.00	хойд дугаарлуу яриад өгнө	7	f	0	2025-08-21 03:52:22.821+00	2025-08-22 14:23:24.949+00	f	\N	\N	\N
6626	35	99430101	127р сургууль дээр очод залга /2ш/	3	50000.00		7	f	0	2025-08-21 04:01:32.674+00	2025-08-21 08:30:31.203+00	f	\N	\N	\N
6640	33	80243113	БГД Модны 2 83 байр 1 орц 3 давхар 8тоот	3	35000.00	цамц	38	f	0	2025-08-21 05:49:22.57+00	2025-08-21 09:47:31.677+00	f	\N	\N	\N
6639	33	99474999	Ховд аймаг	1	78000.00	тооцоогоо авсан байгаа	\N	f	0	2025-08-21 05:48:14.136+00	2025-08-21 07:06:12.904+00	t	\N	\N	\N
6636	32	91091190	Сансар Америк дэнжийн хойно Сод эрхэс авто угаалга дээр авна	5	76000.00		9	t	13	2025-08-21 04:22:26.048+00	2025-08-23 03:27:20.819+00	f	\N	\N	\N
6337	2	99076669	Улаанбаатар, Чингэлтэй, 2-р хорооИх тойруу 29 , Алтжин бөмбөгөр худалдааны төв 11-19:30 хооронд байна	2	6500.00	0	37	f	0	2025-08-17 12:55:03.857+00	2025-08-21 08:53:45.409+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6637	35	99011763	Тэнгисийн хажуу уталд MN tower дээр очоод залгах	3	24000.00		40	f	0	2025-08-21 04:33:54.514+00	2025-08-21 15:29:08.887+00	f	\N	\N	\N
6638	2	99080531	Улаанбаатар, Хан-Уул 13-р хороо 15r Khoroo rapid harsh 28-25 kod 2803 1r orts 7n davhar \n\n\n 	3	12100.00	0	6	f	0	2025-08-21 05:18:45.439+00	2025-08-22 09:00:39.799+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6291	2	86205577	Улаанбаатар, Баянзүрх 38-р хороо 51B bair 2davhar 10toot 86205577  	3	6500.00	0	9	f	0	2025-08-15 12:50:02.56+00	2025-08-22 09:01:46.698+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6580	33	99728719	Баянхошуу Жанцангийн буудал 50 айлын орон сууц	1	35000.00	өмд	\N	f	0	2025-08-21 01:12:44.962+00	2025-08-21 05:41:23.798+00	t	\N	\N	\N
6641	2	99124048	Улаанбаатар, Хан-Уул 20-р хороо Organic zahiin zuun tald 100b bair 9 dawhar 69 toot 	1	6500.00	0	\N	f	0	2025-08-21 08:06:31.251+00	2025-08-21 08:06:31.269+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6617	35	88846211	олимп хотхон 427байр 9-105тоот	3	19000.00		6	f	0	2025-08-21 03:51:46.225+00	2025-08-21 09:20:45.386+00	f	\N	\N	\N
6627	35	88801999	БЗД 26 хороо encanto mall 2 өндөр лүү ороод залгах камер хянагчид өгөх	3	24000.00		6	f	0	2025-08-21 04:02:08.228+00	2025-08-21 08:19:46.521+00	f	\N	\N	\N
6255	2	85805566	Улаанбаатар, Баянгол 11-р хороо Хувьсгальчын д4-103 тоот Их нялхас талдаа 85805566	3	6500.00	0	38	f	0	2025-08-12 08:36:38.248+00	2025-08-21 08:59:19.122+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
6568	32	94554114	хүннү моллын хажуудах ногоон шинэ өргөө 614 байр	3	25000.00	лавлаж асуух	29	f	0	2025-08-20 18:45:59.528+00	2025-08-21 10:48:17.031+00	f	\N	\N	\N
6566	32	98903517	нисэх 65р байр 36тоот	3	30000.00	ө	29	f	0	2025-08-20 16:48:48.938+00	2025-08-21 15:08:21.153+00	f	\N	\N	\N
6571	32	88833497	Архангай унаанд тавих	3	49000.00		12	t	11	2025-08-21 00:57:31.281+00	2025-08-21 15:13:05.67+00	f	\N	\N	\N
6271	2	99212437	Улаанбаатар, Сонгинохайрхан, 35-р хорооорбит67-45А, Нарангийн гол грашийн буудал дээр ирээд залгана 99212437 грашийн буудал дээр ирээд залгана.	3	6500.00	0	12	f	0	2025-08-13 15:24:34.903+00	2025-08-21 13:12:24.24+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6301	2	86916968	hud 23 horoo shunshig villa 2 hothon 57b 5toot	3	12100.00	0	29	f	0	2025-08-16 06:28:46.251+00	2025-08-21 14:41:20.066+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6572	32	86041601	Хар хорингийн арын 24 байр 7-247	3	39000.00		12	t	11	2025-08-21 01:00:07.252+00	2025-08-21 15:13:05.67+00	f	\N	\N	\N
6612	35	96430888	чд нарантуул 2 зах дээр /хар/	3	28000.00		9	t	12	2025-08-21 03:49:09.426+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6613	35	86098643	дундговь /нарантуулаас/	5	24000.00		9	t	12	2025-08-21 03:49:36.085+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6615	35	99095647	нарантуул захын том машины зогсоол дээр 6хүртэл	3	24000.00		9	t	12	2025-08-21 03:50:55.686+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6657	41	90535595	Choibalsan hot dornod	3	0.00		9	t	13	2025-08-22 02:11:22.497+00	2025-08-23 03:27:20.819+00	f	\N	\N	\N
6681	41	94800200	hentii herlen sum	3	0.00		9	t	13	2025-08-22 03:15:41.686+00	2025-08-23 03:27:20.819+00	f	\N	\N	\N
6694	35	99695733	дарь эх ганцын 21р хорооны буудал /хар/	3	28000.00		22	t	14	2025-08-22 04:04:43.209+00	2025-08-23 07:38:12.958+00	f	\N	\N	\N
6614	35	90122281	дөлгөөн нуурын хойно mgl radio хойд талд  267байр 5-28тоот 85626351/үзмэн ягаан/	3	25000.00	хойд дугаарлуу яриад өгнө	40	f	0	2025-08-21 03:50:28.555+00	2025-08-22 05:55:57.524+00	f	\N	\N	\N
6642	2	80292289	Улаанбаатар, Баянгол 13-р хороо Улаанбаатар, Баянгол, 13-р хороо Orgoo kino teatriin baruun tald 2g bair 44 toot Bgd 13r horoo 2g bair 2r orts 44toot	3	6500.00	0	38	f	0	2025-08-21 08:49:18.428+00	2025-08-23 09:44:56.288+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6807	41	94313102	bgd 20horoo gatsuurt company	3	0.00		9	f	0	2025-08-24 21:25:20.155+00	2025-08-25 06:09:14.395+00	f	\N	\N	\N
6305	2	99103355	Улаанбаатар, Сүхбаатар 06-р хороо , Улаанбаатар, Сүхбаатар, Metromall дэлгүүрийн хойд талд Ногоон урлан хотхон. 73/2 байр 2орц 3давхарт 28тоот. орц код 28В Metromall дэлгүүрийн хойд талд Ногоон урлан хотхон. 73/2 байр 2орц 3давхарт 28тоот. орц код 28В 	2	6500.00	0	37	f	0	2025-08-16 08:16:52.228+00	2025-08-21 08:54:51.962+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6644	2	80428844	Улаанбаатар, Баянзүрх 26-р хороо Нарантуул захын өргөтгөл 91097744 	1	6500.00	0	\N	f	0	2025-08-21 10:56:54.993+00	2025-08-21 10:56:55.006+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6645	2	89299828	Багшын дээд  худалдааны төв 1 давхарт цаг засвар түлхүүр гэсэн өрөө бгаа	3	6500.00	0	37	f	0	2025-08-21 11:29:27.546+00	2025-08-26 02:57:44.716+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
6656	2	86031877	Улаанбаатар, Баянзүрх 26-р хороо Mandala hothon 320/2r bair 8 davhar 85 toot code:honh1234 	2	6500.00	0	6	f	0	2025-08-22 02:01:40.013+00	2025-08-23 03:07:23.067+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6647	2	85700222	Улаанбаатар, Баянзүрх 10-р хороо Ботоникийн эцэс вэллмарт сүлжээ дэлгүүрийн касс дээр 85700222 	3	6500.00	0	44	f	0	2025-08-21 14:11:29.858+00	2025-08-24 07:21:40.945+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6651	2	99142595	Улаанбаатар, Баянзүрх 01-р хороо 17-24 toot 24b 	1	6500.00	0	\N	f	0	2025-08-21 19:12:24.144+00	2025-08-21 19:12:24.158+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6654	2	99012372	Улаанбаатар, Хан-Уул 03-р хороо Riverstone 1 hothon 24 a bair  	1	6500.00	0	\N	f	0	2025-08-22 00:47:30.432+00	2025-08-22 00:47:30.444+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6655	15	91117129	Bzd 11 horoo dunjingarav gudamj zalaat house tour . Uuliin zam daguu, baga tenger.s 5 km, zalaat Korean bbq temdeg bgaa.	3	0.00	15-17 tsagt home plaza.n end Sakura tower deer bn. Tsag n taarval avchraad ugch bolno.	29	f	0	2025-08-22 01:44:28.548+00	2025-08-24 12:15:33.507+00	f	\N	\N	\N
6663	33	89036500	Нисэх Элеганс баруун талд Бест буйдан ХХК байр edited	1	35000.00	tsamts	\N	f	0	2025-08-22 02:39:35.781+00	2025-08-22 02:42:23.231+00	t	\N	\N	\N
6643	2	80428844	Улаанбаатар, Баянзүрх 26-р хороо Нарантуул захын өргөтгөл 91097744 Нарантуул захын өргөтгөл 91097744	2	6500.00	0	44	f	0	2025-08-21 10:55:58.146+00	2025-08-26 03:48:43.394+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6686	2	80319105	Улаанбаатар, Сүхбаатар 11-р хороо Marta lake hothon 1025bair 24toot\n 	1	6500.00	0	\N	f	0	2025-08-22 03:46:39.262+00	2025-08-22 03:46:39.275+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
6677	41	90001555	hud 12 horoo marshal tower 127r bair 2orts 4davhar 221tpot	3	7000.00		19	f	0	2025-08-22 03:13:52.233+00	2025-08-25 01:29:27.012+00	f	\N	\N	\N
6691	35	99838284	шинэчлэл хорооолол 805р байрны дэлгүүр чд 10хороо 39р сургуулийн хойно	3	39000.00		43	f	0	2025-08-22 04:03:27.214+00	2025-08-22 14:10:16.789+00	f	\N	\N	\N
6671	41	89111657	bgd 32 horoo korea town1 37a 1orts 5davhar 25toot	3	0.00		38	f	0	2025-08-22 02:51:58.97+00	2025-08-22 08:39:46.936+00	f	\N	\N	\N
6690	35	99440907 	88977632  чд 5 сургуулийн замын эсрэг талын 20байр 5орц 3давхар 	3	39000.00		43	f	0	2025-08-22 04:03:06.098+00	2025-08-22 13:18:46.935+00	f	\N	\N	\N
6653	31	86066619	Говь- Алтайн унаанд	3	1.00	15 эсвэл 18 цагт автобус явдаг	12	f	0	2025-08-21 22:44:53.187+00	2025-08-22 12:34:06.734+00	f	\N	\N	\N
6675	41	99161952	hud 24r horoo hanbogd 407bair 2orts 4 davhar 72toot	3	0.00		29	f	0	2025-08-22 03:02:12.406+00	2025-08-22 05:36:16.523+00	f	\N	\N	\N
6685	2	95523888	Улаанбаатар, Баянгол 11-р хороо Mon Kek company 	2	6500.00	0	38	f	0	2025-08-22 03:27:29.045+00	2025-08-26 03:18:40.813+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6687	35	11326021	тэдигийн урд мега электрон барааны дэлгүүриын эсрэг талд доктор нүдний шилний газар 4с өмнө	3	19000.00		4	f	0	2025-08-22 03:59:38.209+00	2025-08-22 08:13:23.172+00	f	\N	\N	\N
6665	33	80050916	СБД 10 хороо 16 байр 10 тоот	5	3500.00	цамц	13	f	0	2025-08-22 02:40:35.568+00	2025-08-25 02:14:46.279+00	f	\N	\N	\N
6668	41	80264241	zaisan etsesiin buudal suld hothon 100/2 6davhar 86toot	3	0.00		19	f	0	2025-08-22 02:48:03.932+00	2025-08-25 01:30:00.137+00	f	\N	\N	\N
6664	33	89036500	Нисэх Элеганс баруун талд Бест буйдан ХХК байр edited	3	35000.00	tsamts	29	f	0	2025-08-22 02:39:36.564+00	2025-08-22 13:32:11.295+00	f	\N	\N	\N
6649	41	80208087	hangai hothon 516bair 1orts 11davhar 63toot	3	0.00		\N	f	0	2025-08-21 17:43:42.852+00	2025-08-22 14:48:34.594+00	f	\N	\N	\N
6688	35	88103968	худ 1хороо 19байр 1орц 3-7тоот	3	39000.00		6	f	0	2025-08-22 03:59:59.998+00	2025-08-22 08:37:13.141+00	f	\N	\N	\N
6674	41	99507117	dari ehin dund buudal	3	0.00	dari eh deer ireed zalga	22	t	14	2025-08-22 02:53:54.841+00	2025-08-23 07:38:12.958+00	f	\N	\N	\N
6646	2	99119789	Улаанбаатар, Баянзүрх 26-р хороо , Улаанбаатар, Баянзүрх, Crystal town 803 203 Crystal town 803 203 2dawhar	3	6500.00	0	6	f	0	2025-08-21 11:36:37.597+00	2025-08-24 09:42:42.394+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6652	31	88067630	Сайншанд унаанд	3	1.00	80029688 дугаартай машины жолоочид өгөх, байхгүй бол өөр шандын унаанд өгөх	37	f	0	2025-08-21 22:43:35.779+00	2025-08-22 11:19:17.836+00	f	\N	\N	\N
6666	31	88098908	Говь-Алтай унаанд	3	1.00	15, 18 цагаас автобус нь явдаг	12	f	0	2025-08-22 02:43:48.202+00	2025-08-22 12:34:02.162+00	f	\N	\N	\N
6693	35	88508033 	нисэх буянт ухаа 1 717байр 28тоот 6с хойш	3	35000.00	88538343	29	f	0	2025-08-22 04:04:21.23+00	2025-08-24 09:49:46.025+00	f	\N	\N	\N
6689	35	88006062	ажлын цагаар туушин hotel-н урд, оройгуур уб их дэлгүүрийн зүүн талд ub town хотхон 38байр Б орц 11-131тоот	3	24000.00		4	f	0	2025-08-22 04:00:24.233+00	2025-08-23 06:48:15.51+00	f	\N	\N	\N
6648	41	88533759	тэц4 cu агуулах төгс төгөлдөр цайны газар	2	0.00	ТЭЦ 4ийн урагшаа байдаг монос эмийн үйлдвэр лүүгээ ороод чигээрэ шороон замаар явж бгд баруун гар талруу иргэхэд төгс төгөлдөр гээд цайны газар байгаа тэнд үлдээх	29	f	0	2025-08-21 17:41:52.883+00	2025-08-23 08:20:23.572+00	f	\N	\N	\N
6595	35	89975972	Халдварт сүреэгийн клиник дээр	5	28000.00	шаргал өнгө	9	t	12	2025-08-21 03:37:49.43+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6596	35	89971219	 Япон монголын хажуу талын эмнэлэг дээр 	5	28000.00		9	t	12	2025-08-21 03:38:20.93+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6599	35	91929210	бзд 13хороо алтан тэвш 31тоот	5	19000.00		9	t	12	2025-08-21 03:40:53.01+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6602	35	80084247	Шинэ амгалан хотхон 516 байр 2 орц 9-126 тоот	5	39000.00		9	t	12	2025-08-21 03:42:49.68+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6605	35	96967447	Халдварт түмэн наст хотхоны хажууд 34в байр 5 давхар 501 тоот	5	35000.00		9	t	12	2025-08-21 03:44:14.69+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6609	35	93137300	бзд офицер зах б1 оёдлын лангуу 99804203/үзмэн ягаан, ягаан/	5	50000.00		9	t	12	2025-08-21 03:46:42.812+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6619	35	96275599	Mandah naran horoolol 123b bair 140toot narantuulin hoino	5	19000.00		9	t	12	2025-08-21 03:52:51.245+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6621	35	94078747	сансар ктмс өгсөөд сүлд хотхон голын 2орц 12-82тоот /ягаан/	5	25000.00		9	t	12	2025-08-21 03:54:04.933+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6623	35	96480519	БЗД дүүргийн эмнэлэг дээр итгэл найдвар гэсэн эмнэлэг дээр	5	46000.00		9	t	12	2025-08-21 03:54:58.93+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6624	35	89950534	99600787 БЗД 6 хороо 21-р сургуулийн ард 39-р байр 34 тоот 19:00 цагаас хойш	5	29900.00		9	t	12	2025-08-21 03:56:07.512+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6629	35	85582333	бзд 4хороо американ дэнжийн урд талын 10байр 1орц 	5	35000.00		9	t	12	2025-08-21 04:03:01.983+00	2025-08-22 04:10:47.895+00	f	\N	\N	\N
6701	27	99854126	Opitser zahiin ard taliin shar 4ndawhar bair127r bair 8r orts chipeer ongoino ird zalgah	3	110000.00	17 tsagaas hoish	9	f	0	2025-08-22 05:02:11.76+00	2025-08-24 09:16:09.036+00	f	\N	\N	\N
6698	2	99119789	Улаанбаатар, Баянзүрх 26-р хороо , Улаанбаатар, Баянзүрх, Crystal town 803 203 Crystal town 803 203 2dawhar	3	6500.00	0	6	f	0	2025-08-22 04:09:15.815+00	2025-08-24 09:42:36.884+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6695	35	88855415	нисэх 9хороо буянт ухаа 14гудамж 511тоот /үзмэн ягаан/	3	25000.00		29	f	0	2025-08-22 04:05:39.169+00	2025-08-22 06:25:02.354+00	f	\N	\N	\N
6706	2	99871945	Улаанбаатар, Сүхбаатар 06-р хороо 2-22тоот hunsnii 4-r delguur gangnam\n korea restaurant  	2	6500.00	0	29	f	0	2025-08-22 06:59:30.577+00	2025-08-26 03:13:42.576+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6700	2	80069772	Улаанбаатар, Баянзүрх 28-р хороо Хужирбулан эцэс  	3	6500.00	0	44	f	0	2025-08-22 04:41:48.667+00	2025-08-24 07:45:44.438+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6679	41	95500227	bzd officer horgo hothon 2/6 bair 2 orts 8davhar 152toot	3	0.00		9	t	13	2025-08-22 03:15:00.825+00	2025-08-23 03:27:20.819+00	f	\N	\N	\N
6699	35	88923254	дэлгэрэх хотхон 80/3байр 2давхар 18тоот /хар/	3	29900.00		6	f	0	2025-08-22 04:23:41.882+00	2025-08-22 14:22:40.784+00	f	\N	\N	\N
6658	41	89680797	bgd 1 horoo 48bair 5orts 72toot	5	46000.00		38	f	0	2025-08-22 02:12:57.321+00	2025-08-26 04:51:26.45+00	f	\N	\N	\N
6180	2	96669569	Улаанбаатар, Сонгинохайрхан 29-р хороо Улаанбаатар, Сонгинохайрхан, 29-р хороо Емарттай Шинэ драгон терминалын ард 27/2 11 тоот . Байрны хүнсний дэлгүүрт үлдээж болно.  96409988 дэлгүүрт үлдээгээд энэ дугаарт мэдэгдэнэ	3	6500.00	0	\N	f	0	2025-08-07 00:53:30.226+00	2025-08-22 07:02:10.27+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6702	2	99012372	Улаанбаатар, Хан-Уул 03-р хороо Riverstone 1 hothon 24 a bair  	3	6500.00	0	6	f	0	2025-08-22 06:33:38.226+00	2025-08-23 10:10:45.369+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6697	35	99812348	яармаг худ 7хороо сонсголон 10гудамж 419б	3	39000.00		29	f	0	2025-08-22 04:06:21.852+00	2025-08-22 08:04:13.443+00	f	\N	\N	\N
6274	2	86107771	Улаанбаатар, Хан-Уул, 15-р хорооЖаргалан хотхон 1-р Байр Jargalan hothon 1-R Bair, Жаргалан хотхон, 1-р байр, 2р орц, 14 тоот (Хар хаалга) 	3	6500.00	0	6	f	0	2025-08-14 02:55:38.334+00	2025-08-22 09:20:35.356+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6704	2	90073125	Улаанбаатар, Хан-Уул 03-р хороо Дэлгэрэх хотхон  	3	6500.00	0	29	f	0	2025-08-22 06:37:11.384+00	2025-08-24 07:47:05.077+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6703	2	99728223	Улаанбаатар, Хан-Уул 15-р хороо Vega City 	5	12100.00	0	6	f	0	2025-08-22 06:34:27.297+00	2025-08-23 09:55:35.938+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6381	2	88055540	Улаанбаатар, Сүхбаатар 13-р хороо Rashaanii 4,272 	3	6500.00	0	22	f	0	2025-08-18 14:15:24.844+00	2025-08-22 13:40:29.432+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6696	35	99994972	нисдэг машины 11байр 46тоот гоё хоол цайны газар	3	39000.00		43	f	0	2025-08-22 04:05:59.566+00	2025-08-22 14:10:31.563+00	f	\N	\N	\N
6705	2	88076445	Улаанбаатар, Чингэлтэй 05-р хороо , Улаанбаатар, Чингэлтэй, Mplaza 13 davhart garaad zalgah Mplaza 13 davhart garaad zalgah ireheesee umnu hayag deeree bga esehiig zalgaj asuuh	3	6500.00	0	12	f	0	2025-08-22 06:52:39.032+00	2025-08-24 06:02:16.631+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6692	35	94320777	бзд 13хороолол 4-р эмнэлэгийн арын шинэ зуун хотхон 24а байр 39тоот 	3	35000.00		9	t	13	2025-08-22 04:03:50.39+00	2025-08-23 03:27:20.819+00	f	\N	\N	\N
6537	2	99089873	Улаанбаатар, Баянгол 04-р хороо Tbd anduudiin baruun urd, Bogd-Ariin zamiin baruun tald tumur zamiin artai shar bair,  10r bair, code 1015#, 7davhart 25toot, 99089873\n 	3	6500.00	0	38	f	0	2025-08-20 08:24:21.748+00	2025-08-22 09:07:28.852+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6721	31	98008833	хорооллын өргөөгийн замын урд талд 11-р байрны автобусны буудал руу харсан 11-р байр 7 -р орц 3 давхарт 225 тоот	3	1.00		7	f	0	2025-08-23 02:12:05.033+00	2025-08-24 10:23:15.499+00	f	\N	\N	\N
6718	2	80309923	Улаанбаатар, Сонгинохайрхан 01-р хороо 97-31 	2	6500.00	0	9	f	0	2025-08-22 13:35:42.791+00	2025-08-26 03:17:34.828+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6715	2	94660384	Улаанбаатар, Чингэлтэй 17-р хороо 12р гудамж 92 тоот  	1	6500.00	0	\N	f	0	2025-08-22 11:31:22.397+00	2025-08-22 11:31:22.411+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6716	2	94660384	Улаанбаатар, Чингэлтэй 17-р хороо 12р гудамж 92 тоот  	1	6500.00	0	\N	f	0	2025-08-22 11:31:54.59+00	2025-08-22 11:31:54.593+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6725	35	95251202	нисэх спортын цогцолборын ард 443байр 217тоот оройхон	3	39000.00		29	f	0	2025-08-23 03:13:07.617+00	2025-08-24 09:02:03.83+00	f	\N	\N	\N
6720	2	89823499	Улаанбаатар, Сонгинохайрхан 01-р хороо Harhorno Kfs Harhorno kfs	2	6500.00	0	9	f	0	2025-08-23 01:25:24.223+00	2025-08-26 03:20:16.2+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6737	35	99028249	СБД 13 хороо 23 гудам 73 тоот 88537006 	3	28000.00		12	f	0	2025-08-23 03:40:37.438+00	2025-08-24 07:37:41.097+00	f	\N	\N	\N
6712	2	80971103	Улаанбаатар, Чингэлтэй 19-р хороо Салхит завсар 3 4-76 а Хүргэлт хурдан шуурхай байх	2	6500.00	0	9	f	0	2025-08-22 11:03:35.212+00	2025-08-26 05:49:31+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6711	2	88876111	Улаанбаатар, Баянгол 01-р хороо Barsiin ard taliin huuchinii ugsarmal 9 davhar  gadnaa bor shargal passattai 68bair 71 toot Tumur zam bars zahiin ariin ugsarmal huuchnii 9 davhar gadnii bor passattai hundlun orts kodgui	3	6500.00	0	9	f	0	2025-08-22 10:30:10.992+00	2025-08-23 04:37:55.023+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6714	2	88849087	Улаанбаатар, Сонгинохайрхан 24-р хороо Баянхайрхан 48-11 тоот Гэрт хүргүүлэх	2	6500.00	0	9	f	0	2025-08-22 11:18:26.052+00	2025-08-26 03:14:33.774+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6729	35	95085988	уб их дэлгүүрийн баруун талын 22байр 4р орц 4-42тоот /цэнхэр/	3	25000.00		37	f	0	2025-08-23 03:14:44.052+00	2025-08-23 08:22:57.261+00	f	\N	\N	\N
6734	41	88804400	yarmag nuht green garden hothon 721-1505	3	0.00		29	f	0	2025-08-23 03:39:06.678+00	2025-08-24 10:30:25.848+00	f	\N	\N	\N
6730	17	99597610	Нисэхийн тойргийн хойд талын шинэ яармаг хороолол 8-р хороо 731-р байр 2орц 10 давхар 117 тоот 	3	124000.00	90069005 хүлээн авах хүний дугаар очихдоо ярих 	29	f	0	2025-08-23 03:16:42.129+00	2025-08-24 09:24:27.921+00	f	\N	\N	\N
6717	2	89923160	Улаанбаатар, Сонгинохайрхан 33-р хороо Тахилт 33р хороо 27гудам 14б тоот 89923160 ажилтай байгаа тохиолдолд шинэ 22авто худалдаа	5	6500.00	0	9	f	0	2025-08-22 13:12:55.99+00	2025-08-25 04:19:44.462+00	f	Саппоро, Миний дэлгүүрийн хойно HiCargo 09:00-23:00 цаг	\N	\N
6731	41	88508518	horoolliin etses gemtliin sain lombardtai buudal deeshee  yvaad tsenher hudagtai gudam 87b bair	3	0.00		38	f	0	2025-08-23 03:37:21.014+00	2025-08-23 10:06:16.038+00	f	\N	\N	\N
6741	41	96262188	baynhoshuu shd 8r horoo zuun bayntsagaanii 5r gudamj 10toot	3	0.00		9	f	0	2025-08-23 03:41:58.096+00	2025-08-23 07:03:48.264+00	f	\N	\N	\N
6736	41	99478586	altai hothon 27r bair 2orts 9 davhar 136toot	3	0.00		6	f	0	2025-08-23 03:40:24.822+00	2025-08-23 10:29:49.832+00	f	\N	\N	\N
6740	41	88749296	hangai hothonii zamiin urd 303bair 7davhar 705toot	3	0.00		12	f	0	2025-08-23 03:41:17.466+00	2025-08-23 12:27:15.522+00	f	\N	\N	\N
6738	35	98226163	яармаг агаартай хотхон 1425байр 1411тоот	3	28000.00		29	f	0	2025-08-23 03:40:54.644+00	2025-08-24 10:43:31.839+00	f	\N	\N	\N
6723	35	99677274	төв аймаг борнуур сум /хархорин дээрээс явдаг/	3	46000.00		9	f	0	2025-08-23 03:11:43.95+00	2025-08-23 08:04:18.895+00	f	\N	\N	\N
6727	35	80154640	Buynt uhaa 2 eh nyrai emegteichuudiin emneleg	7	35000.00		29	f	0	2025-08-23 03:14:02.923+00	2025-08-24 11:42:09.131+00	f	\N	\N	\N
6713	2	91065953	Улаанбаатар, Баянгол 29-р хороо , Улаанбаатар, Баянгол, Хархорин палас 51/2 байр 11 давхар 82 тоот  Хархорин палас 51/2 байр 11 давхар 82 тоот  ortsnii kod 123456	3	6500.00	0	9	f	0	2025-08-22 11:18:24.939+00	2025-08-24 07:44:43.496+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6739	35	80552626	замын цагдаа үйлдвэрчний хотхон 60байр 14-245тоот	2	28000.00		37	f	0	2025-08-23 03:41:12.572+00	2025-08-23 03:50:29.416+00	f	\N	\N	\N
6719	2	88004756	Улаанбаатар, Хан-Уул, 2-р хороо35В байр 35V Bair, Nekhmel hothon, 35V bair, 12 davhart, 1201 toot Очихоосоо өмнө залгах! 99053231, 88004756	3	12100.00	0	6	f	0	2025-08-22 14:03:41.493+00	2025-08-24 08:45:09.026+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6707	2	80161096	Улаанбаатар, Баянзүрх, 8-р хорооБаганат өргөө 407, 2р орц 2 давхар 74 тоот 	3	6500.00	0	44	t	16	2025-08-22 08:48:32.881+00	2025-08-25 04:30:28.934+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6724	35	89950534	99600787 БЗД 6 хороо 21-р сургуулийн ард 39-р байр 34 тоот 19:00 цагаас хойш	3	29900.00		44	t	16	2025-08-23 03:12:46.561+00	2025-08-25 04:30:28.934+00	f	\N	\N	\N
6726	35	99034099	бзд ахмадын хороо 76байр 14тоот оройхон	3	19000.00		44	t	16	2025-08-23 03:13:31.36+00	2025-08-25 04:30:28.934+00	f	\N	\N	\N
6728	35	99707958	bgd 25 Akuma-н bissiness center 4 давхар саарал байшин цогзолмаа	7	35000.00		9	f	0	2025-08-23 03:14:20.575+00	2025-08-24 10:24:26.123+00	f	\N	\N	\N
6743	41	99089215	bzd 16 horoo ulaanhuarangiin etses zamiin hoino 9 davhar 25r bair 5davhar 25toot	3	0.00		44	t	16	2025-08-23 03:43:05.678+00	2025-08-25 04:30:28.934+00	f	\N	\N	\N
6744	41	89088455	bzd 16 horoo dandarbaatriin gudamj 52-6bair 12davhar 112toot	3	0.00	44r surguuliin baruun tald bor bair	44	t	16	2025-08-23 03:44:33.952+00	2025-08-25 04:30:28.934+00	f	\N	\N	\N
6756	15	88383711	Сонгинохайрхан дүүрэг 29-р хороо, Москва хороолол, 119А байр, 5 павхар, 85 тоот	3	0.00	1	9	f	0	2025-08-23 08:46:52.735+00	2025-08-24 05:45:06.29+00	f	\N	\N	\N
6765	2	88081136	Улаанбаатар, Сүхбаатар, 8-р хороо1-р Байр 1-R Bair, 11 r horoolol auto plazagiin zuun urd hoisho tuv zam ru harsan ortstoi 1 r bair 5 orts 7 davhart 170 toot 88081136 	1	6500.00	0	\N	f	0	2025-08-23 15:16:35.366+00	2025-08-23 15:16:35.382+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6749	2	99273161	Улаанбаатар, Хан-Уул, 17-р хорооErdeniin togol hothon, Erdeniin tugul hothon, 25 dugaar house 	1	6500.00	0	\N	f	0	2025-08-23 04:09:38.444+00	2025-08-23 04:09:38.464+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6752	2	94280381	Улаанбаатар, Сонгинохайрхан 42-р хороо Хайрханы 9ын 148\n Зүүн салаа улаан худаг буудал дээр	1	6500.00	0	\N	f	0	2025-08-23 05:18:41.748+00	2025-08-23 05:18:41.766+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6747	35	88631989	схд содон хороолол арина электроникс	3	46000.00		9	f	0	2025-08-23 03:58:19.187+00	2025-08-23 06:42:34.164+00	f	\N	\N	\N
6755	2	89500300	Улаанбаатар, Сонгинохайрхан 37-р хороо Цахилгаан тээвэр 52байр 118тоот 	2	6500.00	0	9	f	0	2025-08-23 07:46:25.089+00	2025-08-26 03:19:10.765+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6746	2	86873232	Улаанбаатар, Хан-Уул 03-р хороо Гэрэлт өрөө хотгон 47B (Монгол В) байр 2р орц 13давхар 105тоот 	2	6500.00	0	6	f	0	2025-08-23 03:47:02.587+00	2025-08-26 03:30:17.296+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6757	2	89291050	Улаанбаатар, Хан-Уул 25-р хороо Нисэх гарден 326 р байр 201 тоот\n Baihgui	1	6500.00	0	\N	f	0	2025-08-23 08:57:05.18+00	2025-08-23 08:57:05.197+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6758	2	99084171	Улаанбаатар, Хан-Уул, 17-р хорооРивер плаза хотхон 512B байр, 1602 тоот 16 давхарт 2580# код 	1	6500.00	0	\N	f	0	2025-08-23 09:12:17.802+00	2025-08-23 09:12:17.817+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6759	2	80760906	Улаанбаатар, Хан-Уул, 2-р хорооХан-Уул цогцолбор 6в байр, 6В байр 601тоот 6давхар код 601# 	3	6500.00	0	6	f	0	2025-08-23 09:57:44.763+00	2025-08-24 08:53:07.689+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6761	2	99377553	Улаанбаатар, Сонгинохайрхан 01-р хороо Драгон терминал Дарханы унаанд дайварт\n 	1	12100.00	0	\N	f	0	2025-08-23 10:43:40.758+00	2025-08-23 10:43:40.774+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6436	2	95092211	Улаанбаатар, Баянгол 26-р хороо Нарны хороолол 28-р байр 20 давхарт 2001 тоот\nОрцны код 1 түлхүүр 1234 	3	6500.00	0	6	f	0	2025-08-19 14:05:23.238+00	2025-08-23 10:46:49.611+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6276	2	99992419	Улаанбаатар, Чингэлтэй 10-р хороо Auto onoshilgoo ongorood Anar hybrid service \nlocation: Anar501\n 	3	6500.00	0	12	f	0	2025-08-14 04:45:25.176+00	2025-08-23 11:25:42.806+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6762	2	99991236	Улаанбаатар, Сүхбаатар 06-р хороо 39 байр 4р орц 39 тоот. 39B 	1	6500.00	0	\N	f	0	2025-08-23 11:48:07.73+00	2025-08-23 11:48:07.752+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6748	35	99155329	32н тойргийн бүрд худалдааны төвийн эсрэг талйн 921байр 4-14тоот /хар/	3	29900.00		12	f	0	2025-08-23 03:58:35.993+00	2025-08-23 12:12:12.277+00	f	\N	\N	\N
6764	2	80470475	Улаанбаатар, Сонгинохайрхан 36-р хороо алтан овоо 32 р гудамж 1а тоот 	1	6500.00	0	\N	f	0	2025-08-23 13:56:26.88+00	2025-08-23 13:56:26.896+00	f	21-р хороолол, Миний захын Баруун урд Улаан тоосгон баруун хаалга. HiCargo 13:00-20:00 цаг	\N	\N
6769	17	94393993	 ХУД, 19-р хороо,цэлмэг хотхоны баруун талд 96-р байр 1-р орц 1 давхар 2 тоот  	1	78000.00	Очихдоо ярих өнөөдөртөө хүргэх шаардлагатай 	\N	f	0	2025-08-24 02:57:30.007+00	2025-08-24 11:58:48.799+00	t	\N	\N	\N
6811	41	99755500	koyo town 52-2 bair 4davhat 409 toot	2	0.00		6	f	0	2025-08-24 21:34:40.496+00	2025-08-25 06:39:47.52+00	f	\N	\N	\N
6766	2	90061926	Улаанбаатар, Сүхбаатар 07-р хороо 23б 55тоот  	1	6500.00	0	\N	f	0	2025-08-24 01:06:07.428+00	2025-08-24 01:06:07.443+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6754	2	91028990	Улаанбаатар, Баянзүрх 15-р хороо 13-р хороолол 5-р байр 194 тоот 	2	6500.00	0	44	f	0	2025-08-23 07:39:19.281+00	2025-08-26 03:18:13.115+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6768	2	99993566	Улаанбаатар, Баянзүрх 03-р хороо Sansar garden 36r bair 2r orts 21 davhart 2103 toot\n 	1	6500.00	0	\N	f	0	2025-08-24 02:06:41.904+00	2025-08-24 02:06:41.909+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6750	41	94882264	Han uul duureg, 18r horoo Time square hothon 501er bair 4davhar 403r toot	3	0.00		19	f	0	2025-08-23 04:52:27.875+00	2025-08-25 08:02:35.233+00	f	\N	\N	\N
6763	15	91696933	Бзд 36хороо нарны зам говь хангай мебель	3	0.00	1	6	f	0	2025-08-23 12:25:37.094+00	2025-08-24 09:33:57.687+00	f	\N	\N	\N
6751	15	89978124	bayngol 2 xoroolol 4r xoroo shar arktai bair	3	0.00	1	38	f	0	2025-08-23 05:09:38.251+00	2025-08-24 10:16:41.129+00	f	\N	\N	\N
6753	31	86311828	Дундговь аймаг унаанд захаас	3	1.00		44	t	16	2025-08-23 05:59:24.995+00	2025-08-25 04:30:28.934+00	f	\N	\N	\N
6767	2	99993566	Улаанбаатар, Баянзүрх 03-р хороо Sansar garden 36r bair 2r orts 21 davhart 2103 toot\n 	2	6500.00	0	44	f	0	2025-08-24 02:06:41.648+00	2025-08-26 03:15:04.714+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6430	2	88730797	Улаанбаатар, Баянзүрх 13-р хороо 92b bair skytown 10 davhar 1005 toot 105b ortsnii kod 	3	6500.00	0	44	f	0	2025-08-19 11:06:22.674+00	2025-08-24 05:23:07.8+00	f	120 мянгат, 22 байр, HiCargo 09:00-23:00 цаг	\N	\N
6773	35	80728853	бзд 21хороо ганцын задгай  127р сургууль	3	28000.00		9	f	0	2025-08-24 03:43:53.678+00	2025-08-25 12:16:22.205+00	f	\N	\N	\N
6783	35	86853055	Хангай хотхон номинтой байр 7-287 тоот	3	19000.00		12	f	0	2025-08-24 03:47:56.399+00	2025-08-24 06:50:35.746+00	f	\N	\N	\N
6771	35	88707570	Бүти tower 107р байр 1р орцын гадаа очод залга гарч ирээд авна /шаргал өнгө/ 	5	28000.00		6	f	0	2025-08-24 03:42:58.466+00	2025-08-24 09:16:45.447+00	f	\N	\N	\N
5346	2	89890481	Улаанбаатар, Баянзүрх 03-р хороо , Улаанбаатар, Баянзүрх, 12 хороолол 13-р байр 1-р орц 5-н давхарт 17-н тоот орцны код-1973# утас#89890481 12 хороолол 13-р байр 1-р орц 5-н давхарт 17-н тоот орцны код-1973# утас#89890481 95783238,89890481	3	6500.00	0	44	f	0	2025-06-27 15:56:16.055+00	2025-08-24 04:36:11.474+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6777	35	88124720	нисэх 4 бэрх хотхон 422ын 63 тоот	3	39000.00		29	f	0	2025-08-24 03:45:33.55+00	2025-08-24 10:12:30.868+00	f	\N	\N	\N
6793	2	95112622	Улаанбаатар, Хан-Уул 15-р хороо 27r bair, 1r orts, 12 davhar, 45 toot, 2701# kod\n 	1	6500.00	0	\N	f	0	2025-08-24 04:45:54.839+00	2025-08-24 04:45:54.844+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6781	35	88861486	Хангай хотхон зүүн талын 536-р байр 13-59 тоот	3	39000.00		12	f	0	2025-08-24 03:47:11.555+00	2025-08-24 06:50:41.869+00	f	\N	\N	\N
6315	2	99885113	Улаанбаатар, Баянзүрх 24-р хороо Улаанбаатар, Баянзүрх, 24-р хороо Өгөөмөр зах ШинэӨгөөмөр 73а байр 2 орц 6 давхар 91тоот 99885113 ytas	3	6500.00	0	44	f	0	2025-08-16 14:21:14.823+00	2025-08-24 05:49:17.994+00	f	15 хороолол, Jobi 72, HiCargo 09:00-23:00 цаг	\N	\N
6795	15	99002831	Хан уул, 19р хороо, Хүннү2222, 220р байр 7н давхах 701 тоотM	1	0.00	1	\N	f	0	2025-08-24 07:55:39.09+00	2025-08-24 07:55:39.09+00	f	\N	\N	\N
6774	35	86588811	яармаг ханбогд хороолол 401байр 1орц 3-18тоот	3	24000.00		29	f	0	2025-08-24 03:44:15.536+00	2025-08-24 07:56:19.453+00	f	\N	\N	\N
6780	35	96701020	Дарь эх хуучин эцэс сэлбийн задгай /хар өнгө/	1	29900.00		12	f	0	2025-08-24 03:46:49.364+00	2025-08-24 07:05:17.161+00	t	\N	\N	\N
6779	35	99778401	нисэх 7сургуулийн автобусны буудал /хар/	8	29900.00		29	f	0	2025-08-24 03:46:24.777+00	2025-08-24 11:41:57.012+00	f	\N	\N	\N
6778	35	99753724	дарь эх дунд буудал /хар/ 5-с хойш	2	29900.00		12	f	0	2025-08-24 03:45:57.05+00	2025-08-24 04:11:39.295+00	f	\N	\N	\N
6782	35	88745228	Яармаг ханбогд хотхон 403 байр 1 орц 3 тоот	3	19000.00		29	f	0	2025-08-24 03:47:37.156+00	2025-08-24 08:07:06.104+00	f	\N	\N	\N
6792	35	99869516	Алтай хотхон 14-р байр 3 орц 9-274 тоот /цайвар ягаан/	3	25000.00		6	f	0	2025-08-24 04:39:34.605+00	2025-08-24 08:09:36.147+00	f	\N	\N	\N
6776	35	80110198	 буянт ухаа 2ын 1022ын 13 тоот	5	24000.00		29	f	0	2025-08-24 03:45:08.453+00	2025-08-24 09:40:32.103+00	f	\N	\N	\N
6784	35	99163257	нисэх сөүл гарден 313байр 11давхар 1103тоот /шар-elephant/	3	49000.00		29	f	0	2025-08-24 03:55:39.546+00	2025-08-24 09:47:44.037+00	f	\N	\N	\N
6785	35	86136277	хайлааст 32н тойрог акумагийн хойно 3давхар нийтийн байр 1-96 /шар-elephant/	8	49000.00		12	f	0	2025-08-24 03:56:12.046+00	2025-08-24 09:33:49.822+00	f	\N	\N	\N
6787	35	90946664	СБД 13 хороо 159-р сургууль 5 буудал дээр /шоотой square/	8	49000.00		12	f	0	2025-08-24 03:57:36.815+00	2025-08-24 09:33:49.822+00	f	\N	\N	\N
6829	35	91237310	яармаг 2р буудал  арцадын 9бын 3 тоот	3	25000.00	ягаан 	29	f	0	2025-08-25 03:40:18.219+00	2025-08-25 07:56:52.866+00	f	\N	\N	\N
6760	2	95704407	Улаанбаатар, Баянзүрх 22-р хороо Дандарбаатрын гудамж 35-р байр 37 тоот / хүлээн авах хүн: 96454448/ Хүлээн авах хүний утас 96454448	3	6500.00	0	44	t	16	2025-08-23 10:09:20.957+00	2025-08-25 04:30:28.934+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6799	2	95159164	Улаанбаатар, Баянзүрх 26-р хороо Их Монгол Хорооллол 902-р байр, 1 давхар, Их Монголын Үрс цэцэрлэг, арын хаалгаар орно 	2	6500.00	0	6	f	0	2025-08-24 13:26:04.755+00	2025-08-26 03:19:33.601+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6786	35	80171072	Altai hothoni baruun talin delger hothoni urd oyutni orgoo3 /алаг-square/	3	49000.00		6	f	0	2025-08-24 03:56:56.73+00	2025-08-24 08:14:28.036+00	f	\N	\N	\N
6772	35	99777922	яармаг оргил энканто гадаа ирээд залгах дэлгүүрт үлдээж болно	3	35000.00		29	f	0	2025-08-24 03:43:20.805+00	2025-08-24 08:22:42.124+00	f	\N	\N	\N
6791	31	98008833	хорооллын өргөөгийн замын урд талд 11-р байрны автобусны буудал руу харсан 11р байр 7 р орц 3 давхарт 225 тоот	3	1.00		38	f	0	2025-08-24 04:15:41.494+00	2025-08-24 12:15:23.153+00	f	\N	\N	\N
6798	2	99108288	Улаанбаатар, Хан-Уул 15-р хороо home plaza hunsvill hothon 103-1-1103 toot 	2	6500.00	0	6	f	0	2025-08-24 13:11:17.402+00	2025-08-26 03:29:03.969+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6800	2	88096933	Улаанбаатар, Хан-Уул 18-р хороо Туул өргөө 85-43 тоот 2р орц 5 давхарт 43 тоот орцны код 3681# 	1	6500.00	0	\N	f	0	2025-08-24 14:11:18.648+00	2025-08-24 14:11:18.669+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6797	17	94393993	han uul duureg, 19r horoo, tselmeg hothonii baruun tald 96r bair, 1 orts, 1 dawhar, 2 toot	3	163000.00		39	f	0	2025-08-24 12:01:47.798+00	2025-08-24 14:40:04.539+00	f	\N	\N	\N
6794	2	88884799	Улаанбаатар, Чингэлтэй 03-р хороо ih delguurin ard 12r bair, 4-r orts, 2 davhart 55 toot 	2	6500.00	0	37	f	0	2025-08-24 07:34:41.473+00	2025-08-26 03:09:12.238+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6826	35	88079774	нисэх пирамид хотхон 297байр 10-77тоот	3	24000.00		29	f	0	2025-08-25 03:38:10.356+00	2025-08-25 09:01:14.223+00	f	\N	\N	\N
6813	41	88577067	sharhadiin etses	3	0.00		44	f	0	2025-08-24 21:35:39.575+00	2025-08-25 11:16:33.303+00	f	\N	\N	\N
6801	2	86060120	Улаанбаатар, Сүхбаатар 09-р хороо Улаанбаатар, Сүхбаатар, 9-р хороо СБДийн 9 хороо 7 хороолол 293 байр 52 тоот 	1	6500.00	0	\N	f	0	2025-08-24 14:50:28.55+00	2025-08-24 14:50:28.58+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6802	2	89122122	Улаанбаатар, Баянгол 17-р хороо , Улаанбаатар, Баянгол, 36и байр 3орц 3 давхарт 81 тоот 36и байр 3орц 3 давхарт 81 тоот 96882328 дугаарт залгаж очоорой	1	6500.00	0	\N	f	0	2025-08-24 15:39:42.379+00	2025-08-24 15:39:42.396+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6803	2	88887583	Улаанбаатар, Баянзүрх 25-р хороо , Улаанбаатар, Баянзүрх, 93-р Байр 93-R Bair Натур Төвийн урд 93р байр 5давхарт 25А тоот 0816#  93-р Байр 93-R Bair Натур Төвийн урд 93р байр 5давхарт 25А тоот 0816#  0816# 	1	6500.00	0	\N	f	0	2025-08-24 15:53:22.22+00	2025-08-24 15:53:22.245+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6860	35	88656567	СХД 152-р сургууль	2	19000.00		9	f	0	2025-08-26 03:21:14.891+00	2025-08-26 04:58:17.77+00	f	\N	\N	\N
6818	2	89862233	Улаанбаатар, Баянгол 01-р хороо Улаанбаатар, Баянгол, 1-р хороо Богд ар хороолол 22а байр 16 давхар 165 тоот Төмөр зам Богд ар хороолол 22а байр 16 давхар 165 тоот орцны код 6167# 	1	6500.00	0	\N	f	0	2025-08-25 01:02:44.696+00	2025-08-25 01:02:44.71+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6808	41	95561978	horoolol minj plaza zuun taliin 11davhar shar bair 28n 1r bair 2orts 3davhar 58toot	1	0.00		\N	f	0	2025-08-24 21:25:57.527+00	2025-08-25 02:01:41.742+00	t	\N	\N	\N
6819	2	99198976	Улаанбаатар, Хан-Уул 15-р хороо , Улаанбаатар, Хан-Уул, Хүннү2222, Хан-уул дүүрэг,  15-р хороо,  104байр, 404тоот Хүннү2222, Хан-уул дүүрэг,  15-р хороо,  104байр, 404тоот Хүннү2222, Хан-уул дүүрэг,  15-р хороо,  104байр, 404тоот 	1	12100.00	0	\N	f	0	2025-08-25 02:15:39.341+00	2025-08-25 02:15:39.356+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6820	2	99859549	Улаанбаатар, Баянгол 21-р хороо Улаанбаатар, Баянгол, 21-р хороо 15-36015дуугаар гудамж 15-360 Баянгол 21р хороо горкий 15дугаар гудамж 360тоот 	1	6500.00	0	\N	f	0	2025-08-25 02:50:56.093+00	2025-08-25 02:50:56.111+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6834	2	88069167	Улаанбаатар, Баянгол 06-р хороо 10 хороолол 44б байр 1-орц 12 тоот /Код 4458#/ 	1	6500.00	0	\N	f	0	2025-08-25 03:58:07.277+00	2025-08-25 03:58:07.295+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6810	41	95561978	horoolol minj plaza zuun taliin 12 davhar shar bair 28iin 1r bair 2orts 3davhar 58toot	3	10000.00		38	f	0	2025-08-24 21:33:00.556+00	2025-08-25 10:14:50.392+00	f	\N	\N	\N
6788	35	96701020	дарь эхийн хуучин эцэс сэлбийн задгай /хар өнгө/	5	29900.00		9	f	0	2025-08-24 03:58:11.696+00	2025-08-26 05:43:25.829+00	f	\N	\N	\N
6821	35	99820420	 Цэцэг төв gmobile-н урд mobicom дээр 	3	56000.00	хар-1 шар-1	37	f	0	2025-08-25 03:33:45.284+00	2025-08-25 13:05:49.91+00	f	\N	\N	\N
6814	41	99832789	bgd 13 horoo 13r surguulias zam daguu 7r bair 3orts 31toot	3	0.00		38	f	0	2025-08-24 21:36:16.242+00	2025-08-25 09:51:23.8+00	f	\N	\N	\N
6733	41	86267400	bzd 6 horoo 73r bair 1 orts 7davhar 23 toot	3	0.00		44	t	16	2025-08-23 03:38:32.889+00	2025-08-25 04:30:28.934+00	f	\N	\N	\N
6770	17	88866303	БЗДь офицерийн ордн баруун талд 	3	44000.00	Очихдоо ярьж хаягийг асуух. өдөрт нь хүргэх шаардлагатай 	44	t	16	2025-08-24 02:59:14.721+00	2025-08-25 04:30:28.934+00	f	\N	\N	\N
6804	41	88380255	ulaanhuaran cinema next 1 davhart tsetsegsiin delguur	3	0.00		44	f	0	2025-08-24 21:23:32.723+00	2025-08-25 09:16:13.802+00	f	\N	\N	\N
6828	35	91991373	Бөмбөгөрийн урд 22р байр 60 тоот /хар өнгө/	3	29900.00		37	f	0	2025-08-25 03:39:24.686+00	2025-08-25 09:48:58.299+00	f	\N	\N	\N
6806	41	94047612	bzd 26horoo sunshine village 332iin 701 toot	2	0.00		6	f	0	2025-08-24 21:24:55.888+00	2025-08-25 06:39:47.52+00	f	\N	\N	\N
6815	41	95659915	баянзүрх дүүрэг 19р хороо greenaparment 39в 12давхар 130тоот	2	0.00	butsaagdsan baraanaas zurhtei tsunh baigaa ternii haygiig soliod ene hurgeltiig ugmuur bnaa	13	f	0	2025-08-24 21:43:23.773+00	2025-08-25 06:40:16.533+00	f	\N	\N	\N
6775	35	96882662	бзд 30р хороо 496р худагын хажуу шар байшин 497р тоот	5	19000.00		9	f	0	2025-08-24 03:44:39.829+00	2025-08-25 11:41:44.702+00	f	\N	\N	\N
6809	41	91449977	bzd 4horoo 15 horoolol mergejiltnii 11bair 27toot	3	92000.00		44	f	0	2025-08-24 21:31:34.745+00	2025-08-25 12:13:12.928+00	f	\N	\N	\N
6817	2	86070125	Улаанбаатар, Сонгинохайрхан 01-р хороо Толгойт 7-70в 42р сургууль дээр ирээд залгах  	2	6500.00	0	9	f	0	2025-08-25 00:44:40.073+00	2025-08-26 03:13:13.083+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6822	35	88073769	100айл хангай хотхон 	5	39000.00		9	f	0	2025-08-25 03:34:18.565+00	2025-08-25 10:13:23.116+00	f	\N	\N	\N
6816	2	88808126	Улаанбаатар, Баянзүрх 37-р хороо serene town bzd botanik mongol ypon emneleg zuun tald cu bair 82/6 115toot 	2	6500.00	0	44	f	0	2025-08-24 23:55:13.356+00	2025-08-26 03:30:57.023+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6824	35	88549460	яармаг номин макро 	3	24000.00		29	f	0	2025-08-25 03:36:56.435+00	2025-08-25 08:15:11.228+00	f	\N	\N	\N
6823	35	88110198	буянт ухаа 2 1022байр 13тоот	3	24000.00		29	f	0	2025-08-25 03:34:58.571+00	2025-08-25 08:49:19.247+00	f	\N	\N	\N
6812	41	95402614	bzd 4horoo suldet urguu hothon 51b bair 2davhar 13 toot	3	0.00		44	f	0	2025-08-24 21:35:16.96+00	2025-08-25 11:51:24.251+00	f	\N	\N	\N
6835	35	96993700	циркийн баруун талын 10байр 4орц 5-64тоот 6-7цагаас хойш	3	24000.00		37	f	0	2025-08-25 04:32:15.869+00	2025-08-26 02:58:22.635+00	f	\N	\N	\N
6832	35	99525686	4р цахилгаан станын зүүн талд gs 25н агуулах	2	35000.00		29	f	0	2025-08-25 03:44:19.587+00	2025-08-25 05:03:38.681+00	f	\N	\N	\N
6836	2	89125097	Улаанбаатар, Сонгинохайрхан 06-р хороо Схд 39 хороо хангайн 47б гудамж 4 тоот  	1	6500.00	0	\N	f	0	2025-08-25 05:29:07.99+00	2025-08-25 05:29:08.006+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6837	2	99108288	Улаанбаатар, Хан-Уул 15-р хороо home plaza hunsvill hothon 103-1-1103 toot 	1	6500.00	0	\N	f	0	2025-08-25 05:47:47.572+00	2025-08-25 05:47:47.585+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6838	2	99290420	Улаанбаатар, Хан-Уул 21-р хороо Буянт-Ухаа2 1014 байр 9 тоот 	1	12100.00	0	\N	f	0	2025-08-25 06:13:29.519+00	2025-08-25 06:13:29.535+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6790	31	91050121	Дундговь унаанд	3	1.00	Нарантуулаас явдаг	44	f	0	2025-08-24 04:13:01.322+00	2025-08-25 06:48:13.9+00	f	\N	\N	\N
6334	2	88004994	Улаанбаатар, Баянзүрх 11-р хороо Google map zalaat tower. Marshalin gvvrnese uragshaa salaad 4 km yawaad baigaa. Baga tenger city tsogtsolboroos hoosho 	3	12100.00	0	\N	f	0	2025-08-17 06:38:11.877+00	2025-08-25 06:56:28.004+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6839	2	99124425	Улаанбаатар, Сүхбаатар 01-р хороо Shangrila mall, Ulemj grease salon \n 80 033779 Azaa	1	6500.00	0	\N	f	0	2025-08-25 07:21:37.952+00	2025-08-25 07:21:37.975+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6827	35	99997565	ХУД 26 хороо хүннү молын хажуу талын ханбогд хотхон 202 байр 18 тоот хар өнгө	3	29900.00		29	f	0	2025-08-25 03:38:47.972+00	2025-08-25 07:46:21.717+00	f	\N	\N	\N
6840	2	85977376	Улаанбаатар, Чингэлтэй 07-р хороо Zuragt huuchin etses awtobusnii buudal deer ireed zalgah 	1	6500.00	0	\N	f	0	2025-08-25 08:56:35.617+00	2025-08-25 08:56:35.633+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6722	2	99278103	Улаанбаатар, Баянгол, 4-р хороо018, Hermes барилгын материалын дэлгүүрийн замын зүүн урд талд, 018-р байр. 7 давхарт 44 тоот 	3	6500.00	0	38	f	0	2025-08-23 02:19:01.228+00	2025-08-25 09:20:17.702+00	f	4 хороолол, Амарсанаа 23-1, HiCargo 13:00-20:00 цаг	\N	\N
6841	2	89984722	Улаанбаатар, Баянзүрх, 25-р хорооНогоон Төгөл Хотхон 76-р Байр Nogoon Tugul Hothon 76-R Bair, 49тоот 	1	6500.00	0	\N	f	0	2025-08-25 11:22:58.113+00	2025-08-25 11:22:58.129+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6842	2	90179119	Улаанбаатар, Хан-Уул 08-р хороо Шүншиг Вилла 3 244-р байр 1-р орц 11давхар 54 тоот орцны код: 2441#  	1	6500.00	0	\N	f	0	2025-08-25 12:20:14.563+00	2025-08-25 12:20:14.579+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6843	2	88809131	Улаанбаатар, Баянзүрх 08-р хороо Батоник эцэс ус-15 байрны хажууд Саруул-Ухаа супермаркетад ирээд залгаарай 	1	6500.00	0	\N	f	0	2025-08-25 12:22:30.13+00	2025-08-25 12:22:30.146+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6844	2	99639449	Улаанбаатар, Хан-Уул, 8-р хорооАктив гарден Active garden, 501-5-36 	1	6500.00	0	\N	f	0	2025-08-25 12:30:14.631+00	2025-08-25 12:30:14.649+00	f	Арцат Апартмент, 1432-р байр B102 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6845	2	96358399	Улаанбаатар, Сонгинохайрхан 22-р хороо 22ийн 1тоот шөнийн дэлгүүрийн автобусны буудал\n 	1	6500.00	0	\N	f	0	2025-08-25 13:02:13.677+00	2025-08-25 13:02:13.697+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6846	2	96194002	Улаанбаатар, Хан-Уул 21-р хороо шүрт хотхон 806 байр 46 тоот 96194002 луу залгах	1	6500.00	0	\N	f	0	2025-08-25 14:17:37.39+00	2025-08-25 14:17:37.405+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6847	2	99949603	Улаанбаатар, Сонгинохайрхан 29-р хороо СХД 29р хороо 21 р байр 3 давхар 15 тоот /драгоны арын 13 давхар бор барилага / 99949603-99949602 	1	6500.00	0	\N	f	0	2025-08-25 17:17:46.532+00	2025-08-25 17:17:46.549+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6848	31	91088850	Улаанбаатар, Баянгол дүүрэг, 20-р хороо, Tsambagarav zamiin urd Unur xotxon 45r bair 1r orts 3 dawxar 18 toot	1	1.00		\N	f	0	2025-08-25 18:08:25.202+00	2025-08-25 18:08:25.202+00	f	\N	\N	\N
6849	2	80104009	Улаанбаатар, Сүхбаатар 08-р хороо Улаанбаатар, Сүхбаатар, 8-р хороо Velox office, 7 давхар, 705 тоот\n85994525 	1	6500.00	0	\N	f	0	2025-08-26 00:57:52.88+00	2025-08-26 00:57:52.9+00	f	Ногоон төгөл хотхон, 170а байр, HiCargo 09:00-23:00 цаг	\N	\N
6850	2	99104906	Улаанбаатар, Сүхбаатар 01-р хороо Нарны зам -91, Сан роуд булдинг 6 давхар. Терра Энержи ХХК 	1	6500.00	0	\N	f	0	2025-08-26 01:59:49.417+00	2025-08-26 01:59:49.44+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6336	2	88119490	Улаанбаатар, Хан-Уул 02-р хороо Улаанбаатар, Хан-Уул, 2-р хороо Han uul duureg 19iin uilchilgeenii tuv 24bair 133 toot 	3	6500.00	0	\N	f	0	2025-08-17 12:26:33.53+00	2025-08-26 03:00:31.642+00	f	New residence хотхон, 724 байр 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6853	35	80291968	худ нисэх гарден 323байр 305тоот /шоотой/	1	49000.00		\N	f	0	2025-08-26 03:12:54.309+00	2025-08-26 03:12:54.309+00	f	\N	\N	\N
6856	35	88072565	үйлдвэр технологи  их сургууль очод залга	1	28000.00		\N	f	0	2025-08-26 03:19:05.643+00	2025-08-26 03:19:05.643+00	f	\N	\N	\N
6858	35	88083240	тэдигийн зүүн талын нийслэлийн шүүх 7хүртэл /алаг/	1	49000.00		\N	f	0	2025-08-26 03:20:09.016+00	2025-08-26 03:20:09.016+00	f	\N	\N	\N
6855	35	99078826	худ 19хороо 15р сургуулийн баруун талын 34байр 70тоот	2	24000.00		19	f	0	2025-08-26 03:18:16.844+00	2025-08-26 04:18:48.063+00	f	\N	\N	\N
6859	35	99899111, 95657644	наадам центр баруун талын хотхон 207байр  1202тоот/бор/ 	1	49000.00		\N	f	0	2025-08-26 03:20:51.516+00	2025-08-26 03:20:51.516+00	f	\N	\N	\N
6867	2	88885708	Улаанбаатар, Хан-Уул 17-р хороо Time Square 501bair, 3 davhart 301 toot.  ortsnii code #*1456#	1	6500.00	0	\N	f	0	2025-08-26 03:28:52.614+00	2025-08-26 03:28:52.619+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6870	2	89019119	Улаанбаатар, Хан-Уул 21-р хороо Буянт ухаа хороолол Фемида хотхон 693-р байр 204тоот 99288258 Ирэхээс өмнө залгах	1	6500.00	0	\N	f	0	2025-08-26 04:06:48.54+00	2025-08-26 04:06:48.561+00	f	Циркийн баруун талд 18/3-р байр HiCargo 09:00-23:00 цаг	\N	\N
6852	35	98661939	19хороолол дэлгэрэх хотхоны 2давхарт наран мандах уламжлалт эмнэлэгт /шар/	2	28000.00		43	f	0	2025-08-26 03:12:25.089+00	2025-08-26 04:17:30.504+00	f	\N	\N	\N
6872	2	86169499	Улаанбаатар, Баянзүрх 40-р хороо Saruul tenger hothon 1 45r bair 220 toot 	1	6500.00	0	\N	f	0	2025-08-26 06:26:10.96+00	2025-08-26 06:26:10.981+00	f	Зайсангийн тойруу, 29/1 байр B1 2 тоот. HiCargo 13:00-20:00 цаг	\N	\N
6862	35	91012109	ХУД 19 хороо 115-р сургуулийн ард mon house  4-15 тоот /хар өнгө/	2	28000.00		19	f	0	2025-08-26 03:22:21.795+00	2025-08-26 04:18:48.063+00	f	\N	\N	\N
6861	35	88939916	ХУД 3 хороо Gem international-н байран дээр эрэлийн ард байхгүй харуул үлдээх /хар өнгө/	2	28000.00		6	f	0	2025-08-26 03:21:43.099+00	2025-08-26 04:57:33.361+00	f	\N	\N	\N
6866	35	89983771	Нисэх буянт ухаа 1 мт клонк дээр 19:00 цаг хүртэл байна	2	24000.00		29	f	0	2025-08-26 03:24:00.365+00	2025-08-26 04:58:06.599+00	f	\N	\N	\N
6868	35	85139194	Теди-н зүүн талд m office reception дээр /үзмэн ягаан/	2	25000.00		29	f	0	2025-08-26 03:31:38.171+00	2025-08-26 04:58:06.599+00	f	\N	\N	\N
6871	31	80704648	Сапоро замын урд Жаргалан сургууль	1	1.00	18 цагаас өмнө	\N	f	0	2025-08-26 05:26:27.239+00	2025-08-26 05:26:27.239+00	f	\N	\N	\N
6851	35	88803872	100ail hangai hothon 504bair 2orts 7-109 ygaan ongo	2	25000.00		9	f	0	2025-08-26 03:12:01.958+00	2025-08-26 05:39:30.325+00	f	\N	\N	\N
6854	35	90900233	32н тойрог номин /шар/	2	49000.00		9	f	0	2025-08-26 03:13:18.866+00	2025-08-26 05:39:30.325+00	f	\N	\N	\N
6857	35	99753724	дарь эх дунд буудал 	2	28000.00		9	f	0	2025-08-26 03:19:34.312+00	2025-08-26 05:39:30.325+00	f	\N	\N	\N
6863	35	85956446	32-с хойш 17-н уулзараар дарь эхрүү 100м яваад ачлал төвийн хажуу талын халуун ус дээр хүргэх	2	24000.00		9	f	0	2025-08-26 03:22:47.295+00	2025-08-26 05:39:30.325+00	f	\N	\N	\N
6864	35	60115082	хангай хотхон 513байр 1орц 4-22тоот	2	39000.00		9	f	0	2025-08-26 03:23:09.754+00	2025-08-26 05:39:30.325+00	f	\N	\N	\N
6865	35	99972995, 90696987	/саарал/ сбд 9хороо алтайн гудамж 212байр 65тоот 99972995	2	29900.00		9	f	0	2025-08-26 03:23:37.565+00	2025-08-26 05:39:30.325+00	f	\N	\N	\N
6869	35	96687890	хангай хотхон урд талын чд дүүргийн татварын хэлтэс 4с тарна, амжихгүй бол дарь эх 33н буудал 11-216тоот /хар/	2	29900.00	аль амжих дээр нь өгнө	9	f	0	2025-08-26 04:03:38.286+00	2025-08-26 05:39:30.325+00	f	\N	\N	\N
\.


--
-- Data for Name: delivery_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.delivery_items (id, delivery_id, good_id, quantity, "createdAt", "updatedAt") FROM stdin;
3	5279	8	1	2025-06-25 09:18:47.403+00	2025-06-25 09:18:47.403+00
4	5279	7	1	2025-06-25 09:18:47.403+00	2025-06-25 09:18:47.403+00
5	5292	8	1	2025-06-26 02:19:20.223+00	2025-06-26 02:19:20.223+00
6	5300	8	1	2025-06-26 07:17:11.348+00	2025-06-26 07:17:11.348+00
7	5301	7	1	2025-06-26 07:19:11.095+00	2025-06-26 07:19:11.095+00
8	5303	8	1	2025-06-26 10:41:18.894+00	2025-06-26 10:41:18.894+00
9	5307	8	1	2025-06-26 13:00:21.039+00	2025-06-26 13:00:21.039+00
2	5239	\N	90	2025-06-23 16:31:56.578+00	2025-06-23 16:31:56.578+00
10	5309	8	1	2025-06-26 13:58:05.41+00	2025-06-26 13:58:05.41+00
11	5311	8	1	2025-06-26 14:04:12.931+00	2025-06-26 14:04:12.931+00
12	5321	7	1	2025-06-27 03:39:59.445+00	2025-06-27 03:39:59.445+00
13	5342	8	1	2025-06-27 13:12:17.351+00	2025-06-27 13:12:17.351+00
14	5352	8	1	2025-06-28 03:41:51.463+00	2025-06-28 03:41:51.463+00
15	5360	8	1	2025-06-28 10:45:48.081+00	2025-06-28 10:45:48.081+00
16	5379	7	1	2025-06-29 04:56:37.353+00	2025-06-29 04:56:37.353+00
17	5380	8	1	2025-06-29 06:05:34.343+00	2025-06-29 06:05:34.343+00
18	5382	8	1	2025-06-29 08:06:40.173+00	2025-06-29 08:06:40.173+00
19	5384	8	1	2025-06-29 08:54:29.372+00	2025-06-29 08:54:29.372+00
20	5386	8	1	2025-06-29 10:05:54.345+00	2025-06-29 10:05:54.345+00
21	5397	8	1	2025-06-30 04:43:43.567+00	2025-06-30 04:43:43.567+00
22	5402	7	1	2025-06-30 07:03:57.478+00	2025-06-30 07:03:57.478+00
23	5402	8	1	2025-06-30 07:03:57.478+00	2025-06-30 07:03:57.478+00
24	5426	7	1	2025-07-01 05:02:06.922+00	2025-07-01 05:02:06.922+00
25	5432	8	1	2025-07-01 08:37:37.976+00	2025-07-01 08:37:37.976+00
26	5442	8	1	2025-07-01 10:33:31.783+00	2025-07-01 10:33:31.783+00
27	5443	8	1	2025-07-01 11:34:15.654+00	2025-07-01 11:34:15.654+00
28	5456	8	1	2025-07-02 03:13:43.977+00	2025-07-02 03:13:43.977+00
29	5465	33	1	2025-07-02 04:44:14.345+00	2025-07-02 04:44:14.345+00
30	5470	33	1	2025-07-02 05:23:54.504+00	2025-07-02 05:23:54.504+00
31	5470	22	1	2025-07-02 05:23:54.504+00	2025-07-02 05:23:54.504+00
32	5471	9	1	2025-07-02 05:28:13.567+00	2025-07-02 05:28:13.567+00
33	5475	7	1	2025-07-02 06:31:52.923+00	2025-07-02 06:31:52.923+00
34	5475	8	1	2025-07-02 06:31:52.923+00	2025-07-02 06:31:52.923+00
35	5476	19	1	2025-07-02 06:56:19.897+00	2025-07-02 06:56:19.897+00
36	5477	9	1	2025-07-02 06:59:11.699+00	2025-07-02 06:59:11.699+00
37	5478	11	1	2025-07-02 07:29:32.632+00	2025-07-02 07:29:32.632+00
38	5480	11	1	2025-07-02 08:16:43.353+00	2025-07-02 08:16:43.353+00
39	5481	8	1	2025-07-02 08:42:31.849+00	2025-07-02 08:42:31.849+00
40	5509	9	1	2025-07-03 02:08:26.587+00	2025-07-03 02:08:26.587+00
41	5509	24	1	2025-07-03 02:08:26.587+00	2025-07-03 02:08:26.587+00
42	5516	7	1	2025-07-03 05:53:31.978+00	2025-07-03 05:53:31.978+00
43	5516	8	1	2025-07-03 05:53:31.978+00	2025-07-03 05:53:31.978+00
44	5526	12	1	2025-07-03 09:59:01.478+00	2025-07-03 09:59:01.478+00
45	5528	8	1	2025-07-03 12:47:17.675+00	2025-07-03 12:47:17.675+00
46	5537	8	1	2025-07-04 02:43:59.557+00	2025-07-04 02:43:59.557+00
47	5539	8	1	2025-07-04 03:14:23.7+00	2025-07-04 03:14:23.7+00
48	5540	8	1	2025-07-04 03:49:59.669+00	2025-07-04 03:49:59.669+00
49	5546	8	1	2025-07-04 06:37:33.978+00	2025-07-04 06:37:33.978+00
50	5553	11	1	2025-07-04 10:12:42.703+00	2025-07-04 10:12:42.703+00
51	5559	22	1	2025-07-05 02:25:38.283+00	2025-07-05 02:25:38.283+00
52	5559	11	1	2025-07-05 02:25:38.283+00	2025-07-05 02:25:38.283+00
53	5560	9	1	2025-07-05 02:27:18.983+00	2025-07-05 02:27:18.983+00
54	5566	8	1	2025-07-05 07:28:07.552+00	2025-07-05 07:28:07.552+00
55	5569	8	1	2025-07-06 05:51:28.399+00	2025-07-06 05:51:28.399+00
56	5571	8	1	2025-07-06 09:49:00.213+00	2025-07-06 09:49:00.213+00
57	5574	8	1	2025-07-06 12:06:10.416+00	2025-07-06 12:06:10.416+00
58	5575	12	1	2025-07-06 12:47:05.02+00	2025-07-06 12:47:05.02+00
59	5576	9	1	2025-07-06 12:48:53.983+00	2025-07-06 12:48:53.983+00
60	5578	13	1	2025-07-07 00:57:22.682+00	2025-07-07 00:57:22.682+00
61	5578	19	1	2025-07-07 00:57:22.682+00	2025-07-07 00:57:22.682+00
62	5580	7	1	2025-07-07 03:08:15.453+00	2025-07-07 03:08:15.453+00
63	5582	9	1	2025-07-07 04:15:02.845+00	2025-07-07 04:15:02.845+00
64	5582	10	1	2025-07-07 04:15:02.845+00	2025-07-07 04:15:02.845+00
65	5583	12	1	2025-07-07 04:22:41.924+00	2025-07-07 04:22:41.924+00
66	5584	17	1	2025-07-07 04:57:17.57+00	2025-07-07 04:57:17.57+00
67	5585	7	1	2025-07-07 05:18:58.037+00	2025-07-07 05:18:58.037+00
68	5586	7	1	2025-07-07 05:48:40.361+00	2025-07-07 05:48:40.361+00
69	5590	8	1	2025-07-07 08:57:09.293+00	2025-07-07 08:57:09.293+00
70	5601	9	1	2025-07-08 01:39:57.181+00	2025-07-08 01:39:57.181+00
71	5605	13	1	2025-07-08 03:18:42.589+00	2025-07-08 03:18:42.589+00
72	5605	9	1	2025-07-08 03:18:42.589+00	2025-07-08 03:18:42.589+00
73	5605	18	1	2025-07-08 03:18:42.589+00	2025-07-08 03:18:42.589+00
74	5607	9	1	2025-07-08 03:50:36.699+00	2025-07-08 03:50:36.699+00
75	5620	8	1	2025-07-08 13:27:44.823+00	2025-07-08 13:27:44.823+00
76	5623	18	1	2025-07-08 15:40:42.444+00	2025-07-08 15:40:42.444+00
77	5624	9	1	2025-07-08 15:43:21.085+00	2025-07-08 15:43:21.085+00
78	5625	9	1	2025-07-08 15:45:02.677+00	2025-07-08 15:45:02.677+00
79	5626	23	1	2025-07-08 15:46:39.546+00	2025-07-08 15:46:39.546+00
80	5632	8	1	2025-07-09 01:31:44.347+00	2025-07-09 01:31:44.347+00
81	5635	27	1	2025-07-09 02:08:59.445+00	2025-07-09 02:08:59.445+00
82	5670	9	1	2025-07-09 17:13:21.636+00	2025-07-09 17:13:21.636+00
83	5671	9	1	2025-07-09 17:15:30.381+00	2025-07-09 17:15:30.381+00
84	5673	8	1	2025-07-10 04:20:21.963+00	2025-07-10 04:20:21.963+00
85	5674	8	1	2025-07-10 04:20:53.909+00	2025-07-10 04:20:53.909+00
86	5675	8	1	2025-07-10 04:21:16.05+00	2025-07-10 04:21:16.05+00
87	5676	8	1	2025-07-10 04:21:42.955+00	2025-07-10 04:21:42.955+00
88	5677	7	1	2025-07-10 04:22:11.9+00	2025-07-10 04:22:11.9+00
89	5695	30	1	2025-07-10 04:45:49.593+00	2025-07-10 04:45:49.593+00
90	5696	20	1	2025-07-10 04:47:33.053+00	2025-07-10 04:47:33.053+00
91	5702	23	1	2025-07-10 10:22:25.981+00	2025-07-10 10:22:25.981+00
92	5702	17	1	2025-07-10 10:22:25.981+00	2025-07-10 10:22:25.981+00
93	5709	33	1	2025-07-11 02:30:32.42+00	2025-07-11 02:30:32.42+00
94	5709	11	1	2025-07-11 02:30:32.42+00	2025-07-11 02:30:32.42+00
95	5711	9	1	2025-07-11 12:45:30.051+00	2025-07-11 12:45:30.051+00
96	5712	9	1	2025-07-11 12:46:35.678+00	2025-07-11 12:46:35.678+00
97	5713	8	1	2025-07-11 12:51:47.182+00	2025-07-11 12:51:47.182+00
98	5714	8	1	2025-07-11 12:52:10.267+00	2025-07-11 12:52:10.267+00
99	5715	7	1	2025-07-11 12:52:52.382+00	2025-07-11 12:52:52.382+00
100	5716	8	1	2025-07-11 12:53:14.692+00	2025-07-11 12:53:14.692+00
101	5717	8	1	2025-07-11 12:53:56.446+00	2025-07-11 12:53:56.446+00
104	5719	7	1	2025-07-12 04:21:49.1+00	2025-07-12 04:21:49.1+00
105	5721	29	1	2025-07-12 06:25:52.294+00	2025-07-12 06:25:52.294+00
106	5722	30	1	2025-07-12 06:27:18.286+00	2025-07-12 06:27:18.286+00
107	5723	27	1	2025-07-12 06:28:12.569+00	2025-07-12 06:28:12.569+00
108	5742	36	1	2025-07-12 13:47:11.678+00	2025-07-12 13:47:11.678+00
109	5742	36	1	2025-07-12 13:47:11.678+00	2025-07-12 13:47:11.678+00
110	5744	13	1	2025-07-13 06:32:18.971+00	2025-07-13 06:32:18.971+00
111	5744	13	1	2025-07-13 06:32:18.971+00	2025-07-13 06:32:18.971+00
112	5745	7	1	2025-07-13 07:52:47.622+00	2025-07-13 07:52:47.622+00
113	5746	8	2	2025-07-13 07:54:51.34+00	2025-07-13 07:54:51.34+00
114	5747	7	1	2025-07-13 07:55:23.25+00	2025-07-13 07:55:23.25+00
115	5748	8	1	2025-07-13 10:01:56.436+00	2025-07-13 10:01:56.436+00
102	5718	\N	1	2025-07-11 14:39:35.643+00	2025-07-11 14:39:35.643+00
103	5718	\N	3	2025-07-11 14:39:35.643+00	2025-07-11 14:39:35.643+00
116	5756	11	1	2025-07-16 04:35:12.224+00	2025-07-16 04:35:12.224+00
117	5757	7	1	2025-07-16 05:03:52.133+00	2025-07-16 05:03:52.133+00
118	5758	8	1	2025-07-16 05:05:02.855+00	2025-07-16 05:05:02.855+00
119	5759	7	1	2025-07-16 05:05:38.11+00	2025-07-16 05:05:38.11+00
120	5760	8	1	2025-07-16 05:06:12.905+00	2025-07-16 05:06:12.905+00
121	5760	7	1	2025-07-16 05:06:12.905+00	2025-07-16 05:06:12.905+00
122	5761	7	1	2025-07-16 05:06:52.163+00	2025-07-16 05:06:52.163+00
123	5761	8	1	2025-07-16 05:06:52.163+00	2025-07-16 05:06:52.163+00
124	5765	7	1	2025-07-17 07:35:48.347+00	2025-07-17 07:35:48.347+00
125	5766	8	1	2025-07-17 07:36:09.008+00	2025-07-17 07:36:09.008+00
126	5767	8	1	2025-07-17 07:36:41.297+00	2025-07-17 07:36:41.297+00
127	5768	7	1	2025-07-17 07:37:50.411+00	2025-07-17 07:37:50.411+00
128	5778	7	1	2025-07-18 06:13:33.727+00	2025-07-18 06:13:33.727+00
129	5778	8	1	2025-07-18 06:13:33.727+00	2025-07-18 06:13:33.727+00
130	5779	7	1	2025-07-18 06:14:38.902+00	2025-07-18 06:14:38.902+00
131	5780	7	1	2025-07-18 06:15:30.055+00	2025-07-18 06:15:30.055+00
132	5781	8	1	2025-07-18 06:16:02.239+00	2025-07-18 06:16:02.239+00
133	5800	29	1	2025-07-18 17:30:55.441+00	2025-07-18 17:30:55.441+00
134	5806	7	1	2025-07-19 13:40:15.797+00	2025-07-19 13:40:15.797+00
135	5807	7	1	2025-07-19 13:40:46.765+00	2025-07-19 13:40:46.765+00
136	5808	8	1	2025-07-19 13:41:11.169+00	2025-07-19 13:41:11.169+00
137	5809	7	1	2025-07-19 13:41:29.056+00	2025-07-19 13:41:29.056+00
138	5814	7	1	2025-07-20 03:35:31.798+00	2025-07-20 03:35:31.798+00
139	5815	7	1	2025-07-20 04:26:17.239+00	2025-07-20 04:26:17.239+00
140	5820	21	1	2025-07-20 14:55:52.721+00	2025-07-20 14:55:52.721+00
141	5821	8	1	2025-07-21 02:07:52.275+00	2025-07-21 02:07:52.275+00
142	5821	7	1	2025-07-21 02:07:52.275+00	2025-07-21 02:07:52.275+00
143	5840	8	1	2025-07-21 10:44:45.549+00	2025-07-21 10:44:45.549+00
144	5841	7	1	2025-07-21 10:45:40.963+00	2025-07-21 10:45:40.963+00
145	5865	9	1	2025-07-22 01:44:11.053+00	2025-07-22 01:44:11.053+00
146	5868	8	1	2025-07-22 02:24:33.788+00	2025-07-22 02:24:33.788+00
147	5868	7	1	2025-07-22 02:24:33.788+00	2025-07-22 02:24:33.788+00
148	5874	39	2	2025-07-22 05:41:28.504+00	2025-07-22 05:41:28.504+00
149	5878	8	1	2025-07-22 06:34:01.116+00	2025-07-22 06:34:01.116+00
150	5889	7	1	2025-07-22 08:38:57.16+00	2025-07-22 08:38:57.16+00
151	5895	8	1	2025-07-22 14:15:31.35+00	2025-07-22 14:15:31.35+00
152	5905	8	1	2025-07-23 01:59:44.308+00	2025-07-23 01:59:44.308+00
153	5908	7	1	2025-07-23 03:01:37.68+00	2025-07-23 03:01:37.68+00
154	5909	7	1	2025-07-23 03:01:38.039+00	2025-07-23 03:01:38.039+00
155	5910	7	1	2025-07-23 03:01:38.195+00	2025-07-23 03:01:38.195+00
156	5921	8	1	2025-07-23 12:16:14.394+00	2025-07-23 12:16:14.394+00
157	5921	7	1	2025-07-23 12:16:14.394+00	2025-07-23 12:16:14.394+00
158	5926	8	1	2025-07-24 02:29:51.335+00	2025-07-24 02:29:51.335+00
159	5926	7	1	2025-07-24 02:29:51.335+00	2025-07-24 02:29:51.335+00
160	5937	8	1	2025-07-24 10:22:26.1+00	2025-07-24 10:22:26.1+00
161	5937	7	1	2025-07-24 10:22:26.1+00	2025-07-24 10:22:26.1+00
162	5938	8	1	2025-07-24 10:23:34.712+00	2025-07-24 10:23:34.712+00
163	5938	7	1	2025-07-24 10:23:34.712+00	2025-07-24 10:23:34.712+00
164	5940	8	1	2025-07-24 11:05:11.816+00	2025-07-24 11:05:11.816+00
165	5940	7	1	2025-07-24 11:05:11.816+00	2025-07-24 11:05:11.816+00
166	5963	8	1	2025-07-26 03:01:54.888+00	2025-07-26 03:01:54.888+00
167	5985	9	1	2025-07-27 13:49:05.346+00	2025-07-27 13:49:05.346+00
168	6036	29	1	2025-07-29 11:28:53.66+00	2025-07-29 11:28:53.66+00
169	6065	13	1	2025-07-30 09:24:23.96+00	2025-07-30 09:24:23.96+00
170	6100	9	3	2025-08-01 08:44:28.645+00	2025-08-01 08:44:28.645+00
171	6101	13	1	2025-08-01 08:58:58.663+00	2025-08-01 08:58:58.663+00
172	6102	12	1	2025-08-01 09:27:03.269+00	2025-08-01 09:27:03.269+00
173	6104	8	1	2025-08-01 11:39:57.33+00	2025-08-01 11:39:57.33+00
174	6105	8	1	2025-08-01 11:51:03.167+00	2025-08-01 11:51:03.167+00
175	6106	8	1	2025-08-01 15:00:14.652+00	2025-08-01 15:00:14.652+00
176	6107	8	1	2025-08-01 15:01:57.065+00	2025-08-01 15:01:57.065+00
177	6108	24	1	2025-08-01 17:28:57.718+00	2025-08-01 17:28:57.718+00
178	6108	12	1	2025-08-01 17:28:57.718+00	2025-08-01 17:28:57.718+00
179	6108	19	1	2025-08-01 17:28:57.718+00	2025-08-01 17:28:57.718+00
180	6108	11	1	2025-08-01 17:28:57.718+00	2025-08-01 17:28:57.718+00
181	6116	8	1	2025-08-03 05:53:05.948+00	2025-08-03 05:53:05.948+00
182	6117	8	1	2025-08-03 07:26:07.12+00	2025-08-03 07:26:07.12+00
183	6120	8	1	2025-08-03 12:41:08.997+00	2025-08-03 12:41:08.997+00
184	6121	11	1	2025-08-04 00:15:01.171+00	2025-08-04 00:15:01.171+00
185	6122	13	1	2025-08-04 00:16:07.271+00	2025-08-04 00:16:07.271+00
186	6123	9	1	2025-08-04 00:18:15.307+00	2025-08-04 00:18:15.307+00
187	6124	8	1	2025-08-04 00:29:21.255+00	2025-08-04 00:29:21.255+00
188	6126	21	1	2025-08-04 02:38:02.85+00	2025-08-04 02:38:02.85+00
189	6127	11	1	2025-08-04 02:57:11.605+00	2025-08-04 02:57:11.605+00
190	6129	8	1	2025-08-04 04:56:54.293+00	2025-08-04 04:56:54.293+00
191	6134	8	1	2025-08-04 09:01:27.858+00	2025-08-04 09:01:27.858+00
192	6152	8	1	2025-08-05 05:41:09.448+00	2025-08-05 05:41:09.448+00
193	6153	8	1	2025-08-05 06:07:52.541+00	2025-08-05 06:07:52.541+00
194	6165	18	1	2025-08-05 16:41:11.028+00	2025-08-05 16:41:11.028+00
195	6165	28	1	2025-08-05 16:41:11.028+00	2025-08-05 16:41:11.028+00
196	6169	30	1	2025-08-06 05:13:37.46+00	2025-08-06 05:13:37.46+00
197	6169	11	1	2025-08-06 05:13:37.46+00	2025-08-06 05:13:37.46+00
198	6175	8	1	2025-08-06 11:09:04.552+00	2025-08-06 11:09:04.552+00
199	6185	32	1	2025-08-07 06:38:10.447+00	2025-08-07 06:38:10.447+00
200	6187	8	1	2025-08-07 08:37:52.837+00	2025-08-07 08:37:52.837+00
201	6190	8	1	2025-08-08 03:30:12.349+00	2025-08-08 03:30:12.349+00
202	6191	8	1	2025-08-08 03:59:19.46+00	2025-08-08 03:59:19.46+00
203	6192	18	1	2025-08-08 04:50:24.984+00	2025-08-08 04:50:24.984+00
204	6195	8	1	2025-08-08 09:57:55.614+00	2025-08-08 09:57:55.614+00
205	6196	8	1	2025-08-08 10:04:29.21+00	2025-08-08 10:04:29.21+00
206	6197	8	1	2025-08-08 11:53:07.467+00	2025-08-08 11:53:07.467+00
207	6203	9	1	2025-08-09 02:56:51.603+00	2025-08-09 02:56:51.603+00
208	6204	9	1	2025-08-09 02:59:38.693+00	2025-08-09 02:59:38.693+00
209	6207	18	1	2025-08-09 08:15:41.973+00	2025-08-09 08:15:41.973+00
210	6208	8	1	2025-08-09 09:56:55.424+00	2025-08-09 09:56:55.424+00
211	6213	8	1	2025-08-10 03:44:09.582+00	2025-08-10 03:44:09.582+00
212	6220	8	1	2025-08-11 03:42:15.064+00	2025-08-11 03:42:15.064+00
213	6231	8	1	2025-08-11 10:07:44.764+00	2025-08-11 10:07:44.764+00
214	6244	8	1	2025-08-11 12:42:13.62+00	2025-08-11 12:42:13.62+00
215	6246	8	1	2025-08-12 01:24:59.228+00	2025-08-12 01:24:59.228+00
216	6250	8	1	2025-08-12 03:30:06.566+00	2025-08-12 03:30:06.566+00
217	6261	8	1	2025-08-13 04:15:20.314+00	2025-08-13 04:15:20.314+00
218	6263	8	1	2025-08-13 04:51:04.267+00	2025-08-13 04:51:04.267+00
219	6264	8	1	2025-08-13 07:17:19.314+00	2025-08-13 07:17:19.314+00
220	6268	8	1	2025-08-13 11:15:53.399+00	2025-08-13 11:15:53.399+00
221	6284	22	1	2025-08-15 01:15:59.56+00	2025-08-15 01:15:59.56+00
222	6302	9	1	2025-08-16 06:29:36.582+00	2025-08-16 06:29:36.582+00
223	6302	10	1	2025-08-16 06:29:36.582+00	2025-08-16 06:29:36.582+00
224	6328	9	1	2025-08-17 04:03:08.429+00	2025-08-17 04:03:08.429+00
225	6329	42	1	2025-08-17 05:30:59.483+00	2025-08-17 05:30:59.483+00
226	6329	8	1	2025-08-17 05:30:59.483+00	2025-08-17 05:30:59.483+00
227	6330	42	1	2025-08-17 05:32:06.368+00	2025-08-17 05:32:06.368+00
228	6354	8	1	2025-08-18 05:57:02.382+00	2025-08-18 05:57:02.382+00
229	6361	42	1	2025-08-18 07:50:57.386+00	2025-08-18 07:50:57.386+00
230	6432	8	1	2025-08-19 12:01:40.541+00	2025-08-19 12:01:40.541+00
231	6450	55	1	2025-08-20 02:34:13.754+00	2025-08-20 02:34:13.754+00
232	6451	51	1	2025-08-20 02:34:59.865+00	2025-08-20 02:34:59.865+00
233	6452	51	1	2025-08-20 02:34:59.967+00	2025-08-20 02:34:59.967+00
234	6454	55	1	2025-08-20 02:35:57.417+00	2025-08-20 02:35:57.417+00
235	6458	46	4	2025-08-20 02:46:36.53+00	2025-08-20 02:46:36.53+00
236	6459	55	1	2025-08-20 02:47:16.107+00	2025-08-20 02:47:16.107+00
237	6460	51	1	2025-08-20 02:48:37.445+00	2025-08-20 02:48:37.445+00
238	6461	55	1	2025-08-20 02:49:01.304+00	2025-08-20 02:49:01.304+00
239	6462	55	1	2025-08-20 02:49:24.823+00	2025-08-20 02:49:24.823+00
240	6463	48	1	2025-08-20 02:49:51.934+00	2025-08-20 02:49:51.934+00
241	6464	54	1	2025-08-20 02:50:47.906+00	2025-08-20 02:50:47.906+00
245	6468	50	1	2025-08-20 02:53:14.899+00	2025-08-20 02:53:14.899+00
246	6469	46	2	2025-08-20 02:53:57.406+00	2025-08-20 02:53:57.406+00
247	6470	47	2	2025-08-20 02:54:51.266+00	2025-08-20 02:54:51.266+00
248	6471	50	1	2025-08-20 02:55:16.929+00	2025-08-20 02:55:16.929+00
242	6465	\N	1	2025-08-20 02:51:25.537+00	2025-08-20 02:51:25.537+00
243	6466	\N	1	2025-08-20 02:52:29.814+00	2025-08-20 02:52:29.814+00
244	6467	\N	1	2025-08-20 02:52:51.551+00	2025-08-20 02:52:51.551+00
249	6472	54	1	2025-08-20 02:56:08.716+00	2025-08-20 02:56:08.716+00
250	6473	47	2	2025-08-20 02:56:31.907+00	2025-08-20 02:56:31.907+00
251	6474	46	2	2025-08-20 02:56:54.363+00	2025-08-20 02:56:54.363+00
252	6475	48	1	2025-08-20 02:58:17.534+00	2025-08-20 02:58:17.534+00
253	6476	47	2	2025-08-20 02:59:11.508+00	2025-08-20 02:59:11.508+00
254	6477	47	2	2025-08-20 03:01:23.443+00	2025-08-20 03:01:23.443+00
255	6478	48	1	2025-08-20 03:01:53.29+00	2025-08-20 03:01:53.29+00
256	6480	52	1	2025-08-20 03:02:17.644+00	2025-08-20 03:02:17.644+00
257	6481	45	1	2025-08-20 03:02:45.155+00	2025-08-20 03:02:45.155+00
258	6482	47	2	2025-08-20 03:03:31.675+00	2025-08-20 03:03:31.675+00
259	6483	52	1	2025-08-20 03:04:06.693+00	2025-08-20 03:04:06.693+00
260	6485	51	1	2025-08-20 03:04:39.812+00	2025-08-20 03:04:39.812+00
261	6486	48	1	2025-08-20 03:05:02.303+00	2025-08-20 03:05:02.303+00
262	6487	50	1	2025-08-20 03:05:38.043+00	2025-08-20 03:05:38.043+00
263	6488	54	1	2025-08-20 03:06:34.442+00	2025-08-20 03:06:34.442+00
264	6489	47	2	2025-08-20 03:07:01.737+00	2025-08-20 03:07:01.737+00
267	6492	59	1	2025-08-20 03:13:16.307+00	2025-08-20 03:13:16.307+00
268	6493	44	1	2025-08-20 03:27:39.414+00	2025-08-20 03:27:39.414+00
269	6494	50	1	2025-08-20 03:29:52.799+00	2025-08-20 03:29:52.799+00
270	6495	45	1	2025-08-20 03:30:25.044+00	2025-08-20 03:30:25.044+00
271	6496	48	1	2025-08-20 03:32:43.598+00	2025-08-20 03:32:43.598+00
272	6497	47	2	2025-08-20 03:43:40.78+00	2025-08-20 03:43:40.78+00
273	6498	59	1	2025-08-20 03:44:22.526+00	2025-08-20 03:44:22.526+00
274	6499	50	1	2025-08-20 03:45:01.179+00	2025-08-20 03:45:01.179+00
275	6500	44	1	2025-08-20 03:51:02.97+00	2025-08-20 03:51:02.97+00
276	6501	49	1	2025-08-20 03:57:43.484+00	2025-08-20 03:57:43.484+00
277	6502	48	1	2025-08-20 03:58:18.732+00	2025-08-20 03:58:18.732+00
278	6503	44	1	2025-08-20 03:58:51.546+00	2025-08-20 03:58:51.546+00
279	6504	55	1	2025-08-20 03:59:20.312+00	2025-08-20 03:59:20.312+00
280	6505	47	2	2025-08-20 03:59:48.869+00	2025-08-20 03:59:48.869+00
281	6506	44	1	2025-08-20 04:00:20.317+00	2025-08-20 04:00:20.317+00
282	6507	48	1	2025-08-20 04:01:00.437+00	2025-08-20 04:01:00.437+00
283	6508	48	1	2025-08-20 04:01:25.881+00	2025-08-20 04:01:25.881+00
284	6510	47	2	2025-08-20 04:26:25.88+00	2025-08-20 04:26:25.88+00
285	6511	59	1	2025-08-20 04:27:28.005+00	2025-08-20 04:27:28.005+00
286	6512	59	1	2025-08-20 04:37:41.425+00	2025-08-20 04:37:41.425+00
287	6514	48	1	2025-08-20 04:40:16.407+00	2025-08-20 04:40:16.407+00
288	6515	45	1	2025-08-20 04:41:00.205+00	2025-08-20 04:41:00.205+00
289	6556	39	1	2025-08-20 14:57:52.208+00	2025-08-20 14:57:52.208+00
290	6594	48	1	2025-08-21 03:37:03.91+00	2025-08-21 03:37:03.91+00
291	6595	49	1	2025-08-21 03:37:49.434+00	2025-08-21 03:37:49.434+00
292	6596	50	1	2025-08-21 03:38:20.934+00	2025-08-21 03:38:20.934+00
293	6597	51	1	2025-08-21 03:39:43.997+00	2025-08-21 03:39:43.997+00
294	6598	51	1	2025-08-21 03:40:22.164+00	2025-08-21 03:40:22.164+00
295	6599	47	2	2025-08-21 03:40:53.012+00	2025-08-21 03:40:53.012+00
296	6600	45	1	2025-08-21 03:41:27.046+00	2025-08-21 03:41:27.046+00
297	6601	47	2	2025-08-21 03:42:03.861+00	2025-08-21 03:42:03.861+00
298	6602	45	1	2025-08-21 03:42:49.684+00	2025-08-21 03:42:49.684+00
299	6603	52	1	2025-08-21 03:43:20.906+00	2025-08-21 03:43:20.906+00
300	6604	47	2	2025-08-21 03:43:50.04+00	2025-08-21 03:43:50.04+00
301	6605	51	1	2025-08-21 03:44:14.696+00	2025-08-21 03:44:14.696+00
302	6606	48	1	2025-08-21 03:44:50.477+00	2025-08-21 03:44:50.477+00
303	6607	51	1	2025-08-21 03:45:14.211+00	2025-08-21 03:45:14.211+00
304	6608	47	2	2025-08-21 03:45:41.754+00	2025-08-21 03:45:41.754+00
305	6609	52	1	2025-08-21 03:46:42.817+00	2025-08-21 03:46:42.817+00
306	6609	54	1	2025-08-21 03:46:42.817+00	2025-08-21 03:46:42.817+00
307	6610	55	1	2025-08-21 03:47:16.772+00	2025-08-21 03:47:16.772+00
308	6611	48	1	2025-08-21 03:47:56.348+00	2025-08-21 03:47:56.348+00
309	6612	50	1	2025-08-21 03:49:09.431+00	2025-08-21 03:49:09.431+00
310	6613	48	1	2025-08-21 03:49:36.088+00	2025-08-21 03:49:36.088+00
311	6614	54	1	2025-08-21 03:50:28.558+00	2025-08-21 03:50:28.558+00
312	6615	48	1	2025-08-21 03:50:55.689+00	2025-08-21 03:50:55.689+00
313	6616	50	1	2025-08-21 03:51:20.483+00	2025-08-21 03:51:20.483+00
314	6617	47	2	2025-08-21 03:51:46.228+00	2025-08-21 03:51:46.228+00
315	6618	47	2	2025-08-21 03:52:22.826+00	2025-08-21 03:52:22.826+00
316	6619	47	2	2025-08-21 03:52:51.249+00	2025-08-21 03:52:51.249+00
317	6620	50	1	2025-08-21 03:53:35.662+00	2025-08-21 03:53:35.662+00
318	6621	52	1	2025-08-21 03:54:04.938+00	2025-08-21 03:54:04.938+00
319	6622	50	1	2025-08-21 03:54:30.694+00	2025-08-21 03:54:30.694+00
320	6623	55	1	2025-08-21 03:54:58.934+00	2025-08-21 03:54:58.934+00
321	6624	44	1	2025-08-21 03:56:07.518+00	2025-08-21 03:56:07.518+00
322	6626	52	1	2025-08-21 04:01:32.677+00	2025-08-21 04:01:32.677+00
323	6626	54	1	2025-08-21 04:01:32.677+00	2025-08-21 04:01:32.677+00
324	6627	48	1	2025-08-21 04:02:08.237+00	2025-08-21 04:02:08.237+00
325	6628	42	1	2025-08-21 04:02:50.528+00	2025-08-21 04:02:50.528+00
326	6629	60	1	2025-08-21 04:03:01.99+00	2025-08-21 04:03:01.99+00
327	6632	47	2	2025-08-21 04:10:20.997+00	2025-08-21 04:10:20.997+00
328	6633	47	2	2025-08-21 04:16:19.705+00	2025-08-21 04:16:19.705+00
329	6634	48	1	2025-08-21 04:17:07.294+00	2025-08-21 04:17:07.294+00
330	6635	46	2	2025-08-21 04:17:47.871+00	2025-08-21 04:17:47.871+00
331	6637	48	1	2025-08-21 04:33:54.519+00	2025-08-21 04:33:54.519+00
332	6655	8	1	2025-08-22 01:44:28.552+00	2025-08-22 01:44:28.552+00
333	6687	47	2	2025-08-22 03:59:38.212+00	2025-08-22 03:59:38.212+00
334	6688	45	1	2025-08-22 04:00:00.001+00	2025-08-22 04:00:00.001+00
335	6689	48	1	2025-08-22 04:00:24.235+00	2025-08-22 04:00:24.235+00
336	6690	45	1	2025-08-22 04:03:06.102+00	2025-08-22 04:03:06.102+00
337	6691	45	1	2025-08-22 04:03:27.218+00	2025-08-22 04:03:27.218+00
338	6692	51	1	2025-08-22 04:03:50.393+00	2025-08-22 04:03:50.393+00
339	6693	51	1	2025-08-22 04:04:21.233+00	2025-08-22 04:04:21.233+00
340	6694	50	1	2025-08-22 04:04:43.212+00	2025-08-22 04:04:43.212+00
341	6695	54	1	2025-08-22 04:05:39.172+00	2025-08-22 04:05:39.172+00
342	6696	45	1	2025-08-22 04:05:59.569+00	2025-08-22 04:05:59.569+00
343	6697	45	1	2025-08-22 04:06:21.855+00	2025-08-22 04:06:21.855+00
344	6699	59	1	2025-08-22 04:23:41.885+00	2025-08-22 04:23:41.885+00
345	6723	61	1	2025-08-23 03:11:43.954+00	2025-08-23 03:11:43.954+00
346	6724	44	1	2025-08-23 03:12:46.565+00	2025-08-23 03:12:46.565+00
347	6725	45	1	2025-08-23 03:13:07.627+00	2025-08-23 03:13:07.627+00
348	6726	47	2	2025-08-23 03:13:31.364+00	2025-08-23 03:13:31.364+00
349	6727	51	1	2025-08-23 03:14:02.928+00	2025-08-23 03:14:02.928+00
350	6728	51	1	2025-08-23 03:14:20.579+00	2025-08-23 03:14:20.579+00
351	6729	53	1	2025-08-23 03:14:44.055+00	2025-08-23 03:14:44.055+00
352	6730	19	1	2025-08-23 03:16:42.132+00	2025-08-23 03:16:42.132+00
353	6730	13	1	2025-08-23 03:16:42.132+00	2025-08-23 03:16:42.132+00
354	6730	14	1	2025-08-23 03:16:42.132+00	2025-08-23 03:16:42.132+00
355	6737	62	1	2025-08-23 03:40:37.447+00	2025-08-23 03:40:37.447+00
356	6738	62	1	2025-08-23 03:40:54.648+00	2025-08-23 03:40:54.648+00
357	6739	62	1	2025-08-23 03:41:12.576+00	2025-08-23 03:41:12.576+00
358	6747	55	1	2025-08-23 03:58:19.19+00	2025-08-23 03:58:19.19+00
359	6748	59	1	2025-08-23 03:58:35.996+00	2025-08-23 03:58:35.996+00
360	6751	42	1	2025-08-23 05:09:38.254+00	2025-08-23 05:09:38.254+00
361	6756	8	1	2025-08-23 08:46:52.739+00	2025-08-23 08:46:52.739+00
362	6763	42	1	2025-08-23 12:25:37.098+00	2025-08-23 12:25:37.098+00
363	6769	25	1	2025-08-24 02:57:30.012+00	2025-08-24 02:57:30.012+00
364	6769	18	1	2025-08-24 02:57:30.012+00	2025-08-24 02:57:30.012+00
365	6770	19	1	2025-08-24 02:59:14.725+00	2025-08-24 02:59:14.725+00
366	6771	49	1	2025-08-24 03:42:58.475+00	2025-08-24 03:42:58.475+00
367	6772	51	1	2025-08-24 03:43:20.809+00	2025-08-24 03:43:20.809+00
368	6773	62	1	2025-08-24 03:43:53.682+00	2025-08-24 03:43:53.682+00
369	6774	48	1	2025-08-24 03:44:15.54+00	2025-08-24 03:44:15.54+00
370	6775	47	2	2025-08-24 03:44:39.832+00	2025-08-24 03:44:39.832+00
371	6776	48	1	2025-08-24 03:45:08.458+00	2025-08-24 03:45:08.458+00
372	6777	45	1	2025-08-24 03:45:33.554+00	2025-08-24 03:45:33.554+00
373	6778	59	1	2025-08-24 03:45:57.053+00	2025-08-24 03:45:57.053+00
374	6779	59	1	2025-08-24 03:46:24.781+00	2025-08-24 03:46:24.781+00
375	6780	59	1	2025-08-24 03:46:49.368+00	2025-08-24 03:46:49.368+00
376	6781	45	1	2025-08-24 03:47:11.558+00	2025-08-24 03:47:11.558+00
377	6782	47	2	2025-08-24 03:47:37.16+00	2025-08-24 03:47:37.16+00
378	6783	47	2	2025-08-24 03:47:56.402+00	2025-08-24 03:47:56.402+00
379	6784	63	1	2025-08-24 03:55:39.549+00	2025-08-24 03:55:39.549+00
380	6785	63	1	2025-08-24 03:56:12.05+00	2025-08-24 03:56:12.05+00
381	6786	64	1	2025-08-24 03:56:56.735+00	2025-08-24 03:56:56.735+00
382	6787	64	1	2025-08-24 03:57:36.82+00	2025-08-24 03:57:36.82+00
383	6788	59	1	2025-08-24 03:58:11.7+00	2025-08-24 03:58:11.7+00
384	6789	49	1	2025-08-24 04:09:50.683+00	2025-08-24 04:09:50.683+00
385	6792	52	1	2025-08-24 04:39:34.61+00	2025-08-24 04:39:34.61+00
386	6795	8	1	2025-08-24 07:55:39.095+00	2025-08-24 07:55:39.095+00
387	6797	18	1	2025-08-24 12:01:47.802+00	2025-08-24 12:01:47.802+00
388	6797	25	1	2025-08-24 12:01:47.802+00	2025-08-24 12:01:47.802+00
389	6797	15	1	2025-08-24 12:01:47.802+00	2025-08-24 12:01:47.802+00
390	6797	16	1	2025-08-24 12:01:47.802+00	2025-08-24 12:01:47.802+00
391	6821	49	1	2025-08-25 03:33:45.288+00	2025-08-25 03:33:45.288+00
392	6821	50	1	2025-08-25 03:33:45.288+00	2025-08-25 03:33:45.288+00
393	6822	45	1	2025-08-25 03:34:18.569+00	2025-08-25 03:34:18.569+00
394	6823	48	1	2025-08-25 03:34:58.575+00	2025-08-25 03:34:58.575+00
395	6824	48	1	2025-08-25 03:36:56.439+00	2025-08-25 03:36:56.439+00
396	6825	48	1	2025-08-25 03:37:41.931+00	2025-08-25 03:37:41.931+00
397	6826	48	1	2025-08-25 03:38:10.36+00	2025-08-25 03:38:10.36+00
398	6827	59	1	2025-08-25 03:38:47.977+00	2025-08-25 03:38:47.977+00
399	6828	59	1	2025-08-25 03:39:24.69+00	2025-08-25 03:39:24.69+00
400	6829	52	1	2025-08-25 03:40:18.224+00	2025-08-25 03:40:18.224+00
401	6830	45	1	2025-08-25 03:40:42.383+00	2025-08-25 03:40:42.383+00
402	6831	59	1	2025-08-25 03:41:27.98+00	2025-08-25 03:41:27.98+00
403	6832	51	1	2025-08-25 03:44:19.591+00	2025-08-25 03:44:19.591+00
404	6833	50	1	2025-08-25 03:44:45.888+00	2025-08-25 03:44:45.888+00
405	6835	48	1	2025-08-25 04:32:15.872+00	2025-08-25 04:32:15.872+00
406	6851	52	1	2025-08-26 03:12:01.962+00	2025-08-26 03:12:01.962+00
407	6852	49	1	2025-08-26 03:12:25.092+00	2025-08-26 03:12:25.092+00
408	6853	64	1	2025-08-26 03:12:54.312+00	2025-08-26 03:12:54.312+00
409	6854	63	1	2025-08-26 03:13:18.869+00	2025-08-26 03:13:18.869+00
410	6855	48	1	2025-08-26 03:18:16.85+00	2025-08-26 03:18:16.85+00
411	6856	62	1	2025-08-26 03:19:05.647+00	2025-08-26 03:19:05.647+00
412	6857	59	1	2025-08-26 03:19:34.315+00	2025-08-26 03:19:34.315+00
413	6858	64	1	2025-08-26 03:20:09.021+00	2025-08-26 03:20:09.021+00
414	6859	65	1	2025-08-26 03:20:51.519+00	2025-08-26 03:20:51.519+00
415	6860	47	2	2025-08-26 03:21:14.898+00	2025-08-26 03:21:14.898+00
416	6861	50	1	2025-08-26 03:21:43.102+00	2025-08-26 03:21:43.102+00
417	6862	50	1	2025-08-26 03:22:21.799+00	2025-08-26 03:22:21.799+00
418	6863	48	1	2025-08-26 03:22:47.299+00	2025-08-26 03:22:47.299+00
419	6864	45	1	2025-08-26 03:23:09.757+00	2025-08-26 03:23:09.757+00
420	6865	58	1	2025-08-26 03:23:37.569+00	2025-08-26 03:23:37.569+00
421	6866	48	1	2025-08-26 03:24:00.369+00	2025-08-26 03:24:00.369+00
422	6868	54	1	2025-08-26 03:31:38.175+00	2025-08-26 03:31:38.175+00
423	6869	59	1	2025-08-26 04:03:38.292+00	2025-08-26 04:03:38.292+00
\.


--
-- Data for Name: doctors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctors (id, prof, name, image, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: goods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goods (id, ware_id, merchant_id, stock, name, "createdAt", "updatedAt") FROM stdin;
14	1	17	2	Catan - Extention / Жижиг улаан /	2025-07-02 03:22:57.564+00	2025-08-23 03:16:42.136+00
33	1	17	6	Rummikub 4 хүнийх - / Улаан ууттай /	2025-07-02 04:28:25.715+00	2025-08-01 08:04:19.179+00
10	1	17	1	Sequence kids - Амьтны зурагтай	2025-07-02 03:22:55.36+00	2025-08-16 06:29:36.586+00
9	1	17	12	Sequence - Цагаан 	2025-07-02 03:22:54.648+00	2025-08-17 04:03:08.433+00
41	1	15	5	Vocabulary in use	2025-08-17 05:21:44.125+00	2025-08-17 05:21:44.125+00
23	1	17	4	Uno - / Жижиг улаан карт /	2025-07-02 04:28:18.436+00	2025-07-11 14:10:46.892+00
28	1	17	2	Exploding kittens - Party pack / Ягаандуу / 	2025-07-02 04:28:23.78+00	2025-08-05 16:41:11.032+00
30	1	17	0	Idunk - / Уух уу? Яах уу? - жижиг цэнхэр карт /	2025-07-02 04:28:24.562+00	2025-08-06 05:13:37.462+00
11	1	17	2	Sequence jumbo - Том цэнхэр	2025-07-02 03:22:56.031+00	2025-08-06 05:13:37.462+00
29	1	17	0	Idunk - / Уух уу? Яах уу? - жижиг хар карт /	2025-07-02 04:28:24.131+00	2025-08-01 08:07:51.045+00
43	1	15	10	Cambridge 4-19	2025-08-17 05:21:46.42+00	2025-08-17 05:21:46.42+00
17	1	17	1	Exploding kittens - orginal edition / Улаан / 	2025-07-02 03:22:59.152+00	2025-08-01 08:25:59.507+00
65	1	35	1	Даавуун шүүгээ /бор/	2025-08-24 03:50:32.685+00	2025-08-26 03:20:51.522+00
32	1	17	2	Rummikub 6 хүнийх - / Хавтгай тщхайрцагтай /	2025-07-02 04:28:25.296+00	2025-08-07 06:38:10.45+00
39	1	24	77	Keyboard	2025-07-22 05:35:45.788+00	2025-08-20 14:57:52.212+00
47	1	35	16	Шигдсэн хумсны тос	2025-08-19 13:01:04.543+00	2025-08-26 03:21:14.9+00
51	1	35	1	Поршин шахагч	2025-08-19 13:01:15.759+00	2025-08-25 03:44:19.594+00
18	1	17	1	Secret hitler - / Улбар шар, урт гонзгой /	2025-07-02 04:28:15.876+00	2025-08-24 12:01:47.806+00
20	1	17	4	Twister - / Дөрвөлжин жижиг хайрцагтай /	2025-07-02 04:28:17.205+00	2025-07-10 04:47:33.054+00
24	1	17	1	Splendor - / хар саарал, шар хүрээтэй /	2025-07-02 04:28:18.791+00	2025-08-01 17:28:57.72+00
12	1	17	2	Catan - 25 edition / Бүр том /	2025-07-02 03:22:56.565+00	2025-08-01 17:28:57.721+00
25	1	17	0	Exploding kittens - orginal edition / Хар / 	2025-07-02 04:28:19.675+00	2025-08-24 12:01:47.807+00
15	1	17	0	Catan - Seafers / Дундынх цэнхэр /	2025-07-02 03:22:58.054+00	2025-08-24 12:01:47.808+00
26	1	17	3	Spot it - / Улаан бөөрөнхий жижиг савтай / 	2025-07-02 04:28:20.059+00	2025-07-02 04:28:20.059+00
31	1	17	3	Ticket to ride - / Вагоны зурагтай / 	2025-07-02 04:28:24.947+00	2025-07-02 04:28:24.947+00
7	1	15	0	Дүрмийн 3 ном ЖИЖИГ ЦАГААН УУТТАЙ	2025-06-25 09:15:31.039+00	2025-07-25 04:39:24.435+00
55	1	35	-2	Өлгүүртэй гутлын тавиур /хар/	2025-08-19 13:01:21.98+00	2025-08-23 03:58:19.192+00
16	1	17	0	Catan - Seafers Extention / Жижиг цэнхэр /	2025-07-02 03:22:58.7+00	2025-08-24 12:01:47.809+00
21	1	17	1	Halli Galli - / Жимсний зурагтай, хонхтой /	2025-07-02 04:28:17.662+00	2025-08-04 02:38:02.852+00
27	1	17	0	Саятан - / Шаргал том нарийн хайрцагтай / 	2025-07-02 04:28:22.771+00	2025-08-01 07:53:15.053+00
22	1	17	2	Monopoly classic 	2025-07-02 04:28:18.045+00	2025-08-15 01:15:59.564+00
40	1	27	9	Mongolz flag	2025-07-25 07:39:04.615+00	2025-08-15 05:34:23.612+00
36	1	17	3	Saboteur	2025-07-11 14:10:40.329+00	2025-08-01 07:53:38.374+00
50	1	35	5	Машины голын дэр /хар/	2025-08-19 13:01:13.316+00	2025-08-26 03:22:21.803+00
46	1	35	8	Гэрэл	2025-08-19 13:01:03.75+00	2025-08-21 04:54:23.579+00
42	1	15	9	Grammar in use	2025-08-17 05:21:45.268+00	2025-08-23 12:25:37.101+00
58	1	35	14	3 хос цүнх /саарал/	2025-08-20 02:43:38.586+00	2025-08-26 03:23:37.572+00
61	1	35	0	Өлгүүртэй гутлын тавиур /цагаан/	2025-08-21 04:54:18.352+00	2025-08-23 03:11:43.956+00
44	1	35	3	Гагнуурын маск	2025-08-19 13:01:01.692+00	2025-08-23 03:12:46.567+00
48	1	35	7	Машины шил цэвэрлэгч	2025-08-19 13:01:07.719+00	2025-08-26 03:24:00.372+00
52	1	35	16	5 хос цүнх /ягаан/	2025-08-19 13:01:16.119+00	2025-08-26 03:12:01.97+00
49	1	35	4	Машины голын дэр /шар/	2025-08-19 13:01:12.66+00	2025-08-26 03:12:25.095+00
54	1	35	17	5 хос цүнх /үзмэн ягаан/	2025-08-19 13:01:19.3+00	2025-08-26 03:31:38.178+00
19	1	17	0	Уурагтай загас 	2025-07-02 04:28:16.715+00	2025-08-24 02:59:14.727+00
60	1	35	1	Жижиг хар цүнх /эмэгтэй/	2025-08-21 03:47:36.709+00	2025-08-21 04:03:01.995+00
64	1	35	0	Даавуун шүүгээ /алаг/	2025-08-24 03:50:31.458+00	2025-08-26 04:00:38.166+00
63	1	35	0	Даавуун шүүгээ /шар/	2025-08-24 03:50:30.408+00	2025-08-26 04:01:00.076+00
53	1	35	6	5 хос цүнх /цэнхэр/	2025-08-19 13:01:18.357+00	2025-08-23 03:14:44.056+00
45	1	35	1	Бетоны буу	2025-08-19 13:01:02.732+00	2025-08-26 04:02:08.95+00
59	1	35	20	3 хос цүнх/хар/	2025-08-20 02:55:39.566+00	2025-08-26 05:43:25.833+00
13	1	17	3	Catan - Trade build / Дундынх улаан /	2025-07-02 03:22:57.079+00	2025-08-23 03:16:42.135+00
62	1	35	20	Лазертай метр	2025-08-23 03:28:22.067+00	2025-08-26 03:19:05.649+00
8	1	15	2	Cambridge IELTS 4-19 ном ТОМ ЦАГААН УУТТАЙ	2025-06-25 09:16:16.056+00	2025-08-24 07:55:39.097+00
\.


--
-- Data for Name: infos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.infos (id, richtext, doctor, image, audio, title, isactive, category, gender, age, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, title, body, type, "createdAt", "updatedAt") FROM stdin;
1	18tsag	18tsag	2	2025-06-17 05:57:14.822+00	2025-06-17 05:57:14.822+00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, merchant_id, phone, address, status, driver_id, comment, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, module, action, description, "createdAt", "updatedAt") FROM stdin;
1	delivery	create_delivery	create delivery	2025-06-14 14:23:09.177+00	2025-06-14 14:23:09.177+00
2	delivery	view_delivery	view delivery	2025-06-14 14:23:09.195+00	2025-06-14 14:23:09.195+00
3	delivery	update_delivery	update delivery	2025-06-14 14:23:09.2+00	2025-06-14 14:23:09.2+00
4	delivery	delete_delivery	delete delivery	2025-06-14 14:23:09.205+00	2025-06-14 14:23:09.205+00
5	delivery	allocate_delivery	allocate delivery	2025-06-14 14:23:09.21+00	2025-06-14 14:23:09.21+00
6	delivery	excel_import_delivery	excel_import delivery	2025-06-14 14:23:09.214+00	2025-06-14 14:23:09.214+00
7	delivery	manage_delivery	manage delivery	2025-06-14 14:23:09.219+00	2025-06-14 14:23:09.219+00
8	order	create_order	create order	2025-06-14 14:23:09.223+00	2025-06-14 14:23:09.223+00
9	order	view_order	view order	2025-06-14 14:23:09.228+00	2025-06-14 14:23:09.228+00
10	order	update_order	update order	2025-06-14 14:23:09.233+00	2025-06-14 14:23:09.233+00
11	order	delete_order	delete order	2025-06-14 14:23:09.238+00	2025-06-14 14:23:09.238+00
12	order	allocate_order	allocate order	2025-06-14 14:23:09.242+00	2025-06-14 14:23:09.242+00
13	order	excel_import_order	excel_import order	2025-06-14 14:23:09.246+00	2025-06-14 14:23:09.246+00
14	order	manage_order	manage order	2025-06-14 14:23:09.249+00	2025-06-14 14:23:09.249+00
15	product	create_product	create product	2025-06-14 14:23:09.253+00	2025-06-14 14:23:09.253+00
16	product	view_product	view product	2025-06-14 14:23:09.256+00	2025-06-14 14:23:09.256+00
17	product	update_product	update product	2025-06-14 14:23:09.259+00	2025-06-14 14:23:09.259+00
18	product	delete_product	delete product	2025-06-14 14:23:09.263+00	2025-06-14 14:23:09.263+00
19	product	allocate_product	allocate product	2025-06-14 14:23:09.266+00	2025-06-14 14:23:09.266+00
20	product	excel_import_product	excel_import product	2025-06-14 14:23:09.269+00	2025-06-14 14:23:09.269+00
21	product	manage_product	manage product	2025-06-14 14:23:09.272+00	2025-06-14 14:23:09.272+00
22	good	create_good	create good	2025-06-14 14:23:09.274+00	2025-06-14 14:23:09.274+00
23	good	view_good	view good	2025-06-14 14:23:09.277+00	2025-06-14 14:23:09.277+00
24	good	update_good	update good	2025-06-14 14:23:09.28+00	2025-06-14 14:23:09.28+00
25	good	delete_good	delete good	2025-06-14 14:23:09.283+00	2025-06-14 14:23:09.283+00
26	good	allocate_good	allocate good	2025-06-14 14:23:09.286+00	2025-06-14 14:23:09.286+00
27	good	excel_import_good	excel_import good	2025-06-14 14:23:09.289+00	2025-06-14 14:23:09.289+00
28	good	manage_good	manage good	2025-06-14 14:23:09.291+00	2025-06-14 14:23:09.291+00
29	user	create_user	create user	2025-06-14 14:23:09.294+00	2025-06-14 14:23:09.294+00
30	user	view_user	view user	2025-06-14 14:23:09.298+00	2025-06-14 14:23:09.298+00
31	user	update_user	update user	2025-06-14 14:23:09.3+00	2025-06-14 14:23:09.3+00
32	user	delete_user	delete user	2025-06-14 14:23:09.304+00	2025-06-14 14:23:09.304+00
33	user	allocate_user	allocate user	2025-06-14 14:23:09.307+00	2025-06-14 14:23:09.307+00
34	user	excel_import_user	excel_import user	2025-06-14 14:23:09.309+00	2025-06-14 14:23:09.309+00
35	user	manage_user	manage user	2025-06-14 14:23:09.312+00	2025-06-14 14:23:09.312+00
36	settings	create_settings	create settings	2025-06-14 14:23:09.315+00	2025-06-14 14:23:09.315+00
37	settings	view_settings	view settings	2025-06-14 14:23:09.317+00	2025-06-14 14:23:09.317+00
38	settings	update_settings	update settings	2025-06-14 14:23:09.32+00	2025-06-14 14:23:09.32+00
39	settings	delete_settings	delete settings	2025-06-14 14:23:09.322+00	2025-06-14 14:23:09.322+00
40	settings	allocate_settings	allocate settings	2025-06-14 14:23:09.325+00	2025-06-14 14:23:09.325+00
41	settings	excel_import_settings	excel_import settings	2025-06-14 14:23:09.328+00	2025-06-14 14:23:09.328+00
42	settings	manage_settings	manage settings	2025-06-14 14:23:09.331+00	2025-06-14 14:23:09.331+00
43	role	create_role	create role	2025-06-14 14:23:09.333+00	2025-06-14 14:23:09.333+00
44	role	view_role	view role	2025-06-14 14:23:09.336+00	2025-06-14 14:23:09.336+00
45	role	update_role	update role	2025-06-14 14:23:09.338+00	2025-06-14 14:23:09.338+00
46	role	delete_role	delete role	2025-06-14 14:23:09.342+00	2025-06-14 14:23:09.342+00
47	role	allocate_role	allocate role	2025-06-14 14:23:09.346+00	2025-06-14 14:23:09.346+00
48	role	excel_import_role	excel_import role	2025-06-14 14:23:09.348+00	2025-06-14 14:23:09.348+00
49	role	manage_role	manage role	2025-06-14 14:23:09.351+00	2025-06-14 14:23:09.351+00
50	warehouse	create_warehouse	create warehouse	2025-06-14 14:23:09.354+00	2025-06-14 14:23:09.354+00
51	warehouse	view_warehouse	view warehouse	2025-06-14 14:23:09.358+00	2025-06-14 14:23:09.358+00
52	warehouse	update_warehouse	update warehouse	2025-06-14 14:23:09.361+00	2025-06-14 14:23:09.361+00
53	warehouse	delete_warehouse	delete warehouse	2025-06-14 14:23:09.363+00	2025-06-14 14:23:09.363+00
54	warehouse	allocate_warehouse	allocate warehouse	2025-06-14 14:23:09.366+00	2025-06-14 14:23:09.366+00
55	warehouse	excel_import_warehouse	excel_import warehouse	2025-06-14 14:23:09.368+00	2025-06-14 14:23:09.368+00
56	warehouse	manage_warehouse	manage warehouse	2025-06-14 14:23:09.371+00	2025-06-14 14:23:09.371+00
57	status	create_status	create status	2025-06-14 14:23:09.373+00	2025-06-14 14:23:09.373+00
58	status	view_status	view status	2025-06-14 14:23:09.376+00	2025-06-14 14:23:09.376+00
59	status	update_status	update status	2025-06-14 14:23:09.379+00	2025-06-14 14:23:09.379+00
60	status	delete_status	delete status	2025-06-14 14:23:09.385+00	2025-06-14 14:23:09.385+00
61	status	allocate_status	allocate status	2025-06-14 14:23:09.388+00	2025-06-14 14:23:09.388+00
62	status	excel_import_status	excel_import status	2025-06-14 14:23:09.392+00	2025-06-14 14:23:09.392+00
63	status	manage_status	manage status	2025-06-14 14:23:09.396+00	2025-06-14 14:23:09.396+00
64	log	create_log	create log	2025-06-14 14:23:09.399+00	2025-06-14 14:23:09.399+00
65	log	view_log	view log	2025-06-14 14:23:09.402+00	2025-06-14 14:23:09.402+00
66	log	update_log	update log	2025-06-14 14:23:09.406+00	2025-06-14 14:23:09.406+00
67	log	delete_log	delete log	2025-06-14 14:23:09.409+00	2025-06-14 14:23:09.409+00
68	log	allocate_log	allocate log	2025-06-14 14:23:09.412+00	2025-06-14 14:23:09.412+00
69	log	excel_import_log	excel_import log	2025-06-14 14:23:09.415+00	2025-06-14 14:23:09.415+00
70	log	manage_log	manage log	2025-06-14 14:23:09.419+00	2025-06-14 14:23:09.419+00
71	dashboard	create_dashboard	create dashboard	2025-06-14 14:23:09.423+00	2025-06-14 14:23:09.423+00
72	dashboard	view_dashboard	view dashboard	2025-06-14 14:23:09.426+00	2025-06-14 14:23:09.426+00
73	dashboard	update_dashboard	update dashboard	2025-06-14 14:23:09.43+00	2025-06-14 14:23:09.43+00
74	dashboard	delete_dashboard	delete dashboard	2025-06-14 14:23:09.434+00	2025-06-14 14:23:09.434+00
75	dashboard	allocate_dashboard	allocate dashboard	2025-06-14 14:23:09.438+00	2025-06-14 14:23:09.438+00
76	dashboard	excel_import_dashboard	excel_import dashboard	2025-06-14 14:23:09.441+00	2025-06-14 14:23:09.441+00
77	dashboard	manage_dashboard	manage dashboard	2025-06-14 14:23:09.445+00	2025-06-14 14:23:09.445+00
78	region	create_region	create region	2025-06-14 14:23:09.448+00	2025-06-14 14:23:09.448+00
79	region	view_region	view region	2025-06-14 14:23:09.452+00	2025-06-14 14:23:09.452+00
80	region	update_region	update region	2025-06-14 14:23:09.456+00	2025-06-14 14:23:09.456+00
81	region	delete_region	delete region	2025-06-14 14:23:09.46+00	2025-06-14 14:23:09.46+00
82	region	allocate_region	allocate region	2025-06-14 14:23:09.463+00	2025-06-14 14:23:09.463+00
83	region	excel_import_region	excel_import region	2025-06-14 14:23:09.467+00	2025-06-14 14:23:09.467+00
84	region	manage_region	manage region	2025-06-14 14:23:09.471+00	2025-06-14 14:23:09.471+00
85	notification	create_notification	create notification	2025-06-14 14:23:09.474+00	2025-06-14 14:23:09.474+00
86	notification	view_notification	view notification	2025-06-14 14:23:09.478+00	2025-06-14 14:23:09.478+00
87	notification	update_notification	update notification	2025-06-14 14:23:09.482+00	2025-06-14 14:23:09.482+00
88	notification	delete_notification	delete notification	2025-06-14 14:23:09.486+00	2025-06-14 14:23:09.486+00
89	notification	allocate_notification	allocate notification	2025-06-14 14:23:09.49+00	2025-06-14 14:23:09.49+00
90	notification	excel_import_notification	excel_import notification	2025-06-14 14:23:09.494+00	2025-06-14 14:23:09.494+00
91	notification	manage_notification	manage notification	2025-06-14 14:23:09.498+00	2025-06-14 14:23:09.498+00
92	reports	create_reports	create reports	2025-06-14 14:23:09.503+00	2025-06-14 14:23:09.503+00
93	reports	view_reports	view reports	2025-06-14 14:23:09.507+00	2025-06-14 14:23:09.507+00
94	reports	update_reports	update reports	2025-06-14 14:23:09.51+00	2025-06-14 14:23:09.51+00
95	reports	delete_reports	delete reports	2025-06-14 14:23:09.514+00	2025-06-14 14:23:09.514+00
96	reports	allocate_reports	allocate reports	2025-06-14 14:23:09.517+00	2025-06-14 14:23:09.517+00
97	reports	excel_import_reports	excel_import reports	2025-06-14 14:23:09.521+00	2025-06-14 14:23:09.521+00
98	reports	manage_reports	manage reports	2025-06-14 14:23:09.525+00	2025-06-14 14:23:09.525+00
\.


--
-- Data for Name: privacies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.privacies (id, privacy, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, status, "catId", description, stock, image, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, lastname, firstname, email, role, phone, isactive, school, member_type, start_date, end_date, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regions (id, name, "createdAt", "updatedAt") FROM stdin;
1	шинэ	2025-06-15 09:06:04.011+00	2025-06-15 09:06:04.011+00
3	ирсэн бараа	2025-06-18 17:33:23.367+00	2025-06-18 17:33:23.367+00
4	ирсэн бараа	2025-07-22 10:46:19.594+00	2025-07-22 10:46:19.594+00
5	Ухарсан бараа	2025-08-20 12:55:56.817+00	2025-08-20 12:55:56.817+00
\.


--
-- Data for Name: requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.requests (id, ware_id, merchant_id, stock, status, good_id, name, type, "createdAt", "updatedAt") FROM stdin;
32	1	15	25	2	8	\N	2	2025-07-04 10:07:57.671+00	2025-07-06 10:07:45.171+00
6	1	15	10	3	\N	ewqeq	1	2025-06-23 14:14:30.562+00	2025-06-23 14:15:10.744+00
7	1	17	12	2	\N	Sequence - Цагаан 	1	2025-07-02 02:49:27.981+00	2025-07-02 03:22:54.646+00
8	1	17	3	2	\N	Sequence kids - Амьтны зурагтай	1	2025-07-02 02:49:56.69+00	2025-07-02 03:22:55.359+00
9	1	17	5	2	\N	Sequence jumbo - Том цэнхэр	1	2025-07-02 02:50:20.622+00	2025-07-02 03:22:56.029+00
10	1	17	3	2	\N	Catan - 25 edition / Бүр том /	1	2025-07-02 02:50:56.912+00	2025-07-02 03:22:56.564+00
11	1	17	3	2	\N	Catan - Trade build / Дундынх улаан /	1	2025-07-02 02:51:46.119+00	2025-07-02 03:22:57.077+00
12	1	17	3	2	\N	Catan - Extention / Жижиг улаан /	1	2025-07-02 02:52:09.549+00	2025-07-02 03:22:57.563+00
13	1	17	1	2	\N	Catan - Seafers / Дундынх цэнхэр /	1	2025-07-02 02:57:44.009+00	2025-07-02 03:22:58.052+00
14	1	17	1	2	\N	Catan - Seafers Extention / Жижиг цэнхэр /	1	2025-07-02 02:58:19.763+00	2025-07-02 03:22:58.698+00
15	1	17	3	2	\N	Exploding kittens - orginal edition / Улаан / 	1	2025-07-02 03:00:43.139+00	2025-07-02 03:22:59.15+00
24	1	17	3	2	\N	Secret hitler - / Улбар шар, урт гонзгой /	1	2025-07-02 03:08:36.575+00	2025-07-02 04:28:15.874+00
23	1	17	5	2	\N	Уурагтай загас 	1	2025-07-02 03:08:02.418+00	2025-07-02 04:28:16.713+00
22	1	17	5	2	\N	Twister - / Дөрвөлжин жижиг хайрцагтай /	1	2025-07-02 03:07:36.813+00	2025-07-02 04:28:17.204+00
21	1	17	3	2	\N	Halli Galli - / Жимсний зурагтай, хонхтой /	1	2025-07-02 03:07:01.799+00	2025-07-02 04:28:17.66+00
20	1	17	5	2	\N	Monopoly classic 	1	2025-07-02 03:06:24.594+00	2025-07-02 04:28:18.044+00
19	1	17	3	2	\N	Uno - / Жижиг улаан карт /	1	2025-07-02 03:04:42.03+00	2025-07-02 04:28:18.434+00
18	1	17	3	2	\N	Splendor - / хар саарал, шар хүрээтэй /	1	2025-07-02 03:04:24.367+00	2025-07-02 04:28:18.789+00
16	1	17	3	2	\N	Exploding kittens - orginal edition / Хар / 	1	2025-07-02 03:02:49.976+00	2025-07-02 04:28:19.673+00
17	1	17	3	2	\N	Spot it - / Улаан бөөрөнхий жижиг савтай / 	1	2025-07-02 03:03:24.885+00	2025-07-02 04:28:20.057+00
31	1	17	3	2	\N	Саятан - / Шаргал том нарийн хайрцагтай / 	1	2025-07-02 03:12:56.498+00	2025-07-02 04:28:22.77+00
30	1	17	3	2	\N	Exploding kittens - Party pack / Ягаандуу / 	1	2025-07-02 03:12:28.955+00	2025-07-02 04:28:23.778+00
29	1	17	3	2	\N	Idunk - / Уух уу? Яах уу? - жижиг хар карт /	1	2025-07-02 03:11:37.125+00	2025-07-02 04:28:24.129+00
28	1	17	3	2	\N	Idunk - / Уух уу? Яах уу? - жижиг цэнхэр карт /	1	2025-07-02 03:11:25.852+00	2025-07-02 04:28:24.561+00
27	1	17	3	2	\N	Ticket to ride - / Вагоны зурагтай / 	1	2025-07-02 03:10:34.24+00	2025-07-02 04:28:24.945+00
26	1	17	3	2	\N	Rummikub 6 хүнийх - / Хавтгай тщхайрцагтай /	1	2025-07-02 03:10:10.285+00	2025-07-02 04:28:25.294+00
25	1	17	5	2	\N	Rummikub 4 хүнийх - / Улаан ууттай /	1	2025-07-02 03:09:35.214+00	2025-07-02 04:28:25.714+00
55	1	24	99	2	39	\N	2	2025-07-22 05:36:12.447+00	2025-07-22 05:36:27.054+00
33	1	20	1	3	\N	bayaka	1	2025-07-11 11:48:50.125+00	2025-07-11 13:48:52.049+00
34	1	20	1	3	\N	bat	1	2025-07-11 11:58:13.849+00	2025-07-11 13:49:05.177+00
35	1	20	2	3	\N	tetete	1	2025-07-11 11:58:51.246+00	2025-07-11 13:49:06.743+00
36	1	20	11	3	\N	\N	1	2025-07-11 12:16:03.149+00	2025-07-11 13:49:07.672+00
47	1	20	22	2	\N	qq	1	2025-07-11 13:34:31.839+00	2025-07-11 13:50:51.128+00
38	1	17	3	2	\N	Saboteur	1	2025-07-11 12:37:40.966+00	2025-07-11 14:10:40.326+00
39	1	17	5	2	13	\N	2	2025-07-11 12:38:04.816+00	2025-07-11 14:10:40.929+00
40	1	17	24	2	9	\N	2	2025-07-11 12:38:17.21+00	2025-07-11 14:10:41.533+00
41	1	17	5	2	11	\N	2	2025-07-11 12:38:32.486+00	2025-07-11 14:10:45.481+00
42	1	17	4	2	12	\N	2	2025-07-11 12:38:49.095+00	2025-07-11 14:10:46.169+00
43	1	17	3	2	23	\N	2	2025-07-11 12:39:02.026+00	2025-07-11 14:10:46.889+00
44	1	17	5	2	18	\N	2	2025-07-11 12:39:12.065+00	2025-07-11 14:10:47.648+00
45	1	17	2	2	33	\N	2	2025-07-11 12:39:23.596+00	2025-07-11 14:10:48.127+00
46	1	20	1	2	\N	testete	1	2025-07-11 13:34:16.204+00	2025-07-11 14:10:48.685+00
56	1	24	20	2	39	\N	3	2025-07-22 05:37:11.552+00	2025-07-22 05:37:24.565+00
50	1	20	321	2	\N	qwer	1	2025-07-11 13:47:23.449+00	2025-07-11 14:10:49.809+00
52	1	15	3	2	8	\N	2	2025-07-21 04:04:41.91+00	2025-07-21 15:36:18.592+00
53	1	15	6	2	7	\N	2	2025-07-21 04:04:58.942+00	2025-07-21 15:36:19.508+00
54	1	24	1	2	\N	Keyboard	1	2025-07-22 05:34:34.642+00	2025-07-22 05:35:45.786+00
57	1	15	10	2	8	\N	2	2025-07-22 06:34:34.875+00	2025-07-22 06:46:45.565+00
58	1	27	10	2	\N	Mongolz flag	1	2025-07-25 07:35:58.671+00	2025-07-25 07:39:04.612+00
59	1	15	20	2	8	\N	2	2025-08-07 08:38:16.761+00	2025-08-09 06:04:09.109+00
60	1	15	5	2	\N	Vocabulary in use	1	2025-08-17 04:23:19.504+00	2025-08-17 05:21:44.122+00
61	1	15	15	2	\N	Grammar in use	1	2025-08-17 04:24:10.658+00	2025-08-17 05:21:45.266+00
62	1	15	10	2	\N	Cambridge 4-19	1	2025-08-17 04:24:40.976+00	2025-08-17 05:21:46.418+00
74	1	35	5	2	\N	Гагнуурын маск	1	2025-08-19 12:57:40.495+00	2025-08-19 13:01:01.688+00
73	1	35	5	2	\N	Бетоны буу	1	2025-08-19 12:57:26.679+00	2025-08-19 13:01:02.727+00
72	1	35	10	2	\N	Гэрэл	1	2025-08-19 12:57:17.662+00	2025-08-19 13:01:03.747+00
71	1	35	20	2	\N	Шигдсэн хумсны тос	1	2025-08-19 12:57:06.923+00	2025-08-19 13:01:04.539+00
70	1	35	10	2	\N	Машины шил цэвэрлэгч	1	2025-08-19 12:56:39.743+00	2025-08-19 13:01:07.717+00
63	1	35	3	2	\N	Машины голын дэр /шар/	1	2025-08-19 12:54:44.681+00	2025-08-19 13:01:12.658+00
64	1	35	5	2	\N	Машины голын дэр /хар/	1	2025-08-19 12:55:00.011+00	2025-08-19 13:01:13.313+00
65	1	35	5	2	\N	Поршин шахагч	1	2025-08-19 12:55:13.464+00	2025-08-19 13:01:15.756+00
66	1	35	5	2	\N	5 хос цүнх /ягаан/	1	2025-08-19 12:55:36.967+00	2025-08-19 13:01:16.117+00
68	1	35	2	2	\N	5 хос цүнх /цэнхэр/	1	2025-08-19 12:56:02.356+00	2025-08-19 13:01:18.355+00
67	1	35	5	2	\N	5 хос цүнх /үзмэн ягаан/	1	2025-08-19 12:55:49.841+00	2025-08-19 13:01:19.298+00
69	1	35	3	2	\N	Өлгүүртэй гутлын тавиур /хар/	1	2025-08-19 12:56:14.779+00	2025-08-19 13:01:21.977+00
75	1	35	5	2	\N	3 хос цүнх	1	2025-08-20 02:41:27.859+00	2025-08-20 02:43:38.037+00
76	1	35	5	2	\N	3 хос цүнх /саарал/	1	2025-08-20 02:41:44.972+00	2025-08-20 02:43:38.584+00
77	1	35	2	2	\N	Жижиг хар цүнх /эмэгтэй/	1	2025-08-21 03:38:51.078+00	2025-08-21 03:47:36.705+00
81	1	35	5	2	53	\N	2	2025-08-21 04:42:48.086+00	2025-08-21 04:54:29.925+00
80	1	35	20	2	48	\N	2	2025-08-21 04:42:35.672+00	2025-08-21 04:54:32.795+00
78	1	35	30	2	59	\N	2	2025-08-21 04:42:10.99+00	2025-08-21 04:54:37.194+00
79	1	35	10	2	58	\N	2	2025-08-21 04:42:22.125+00	2025-08-21 04:54:47.232+00
92	1	35	10	2	45	\N	2	2025-08-21 04:46:51.218+00	2025-08-21 04:54:12.312+00
91	1	35	9	2	51	\N	2	2025-08-21 04:46:39.679+00	2025-08-21 04:54:14.051+00
90	1	35	40	2	47	\N	2	2025-08-21 04:46:24.251+00	2025-08-21 04:54:14.768+00
87	1	35	1	2	\N	Өлгүүртэй гутлын тавиур /цагаан/	1	2025-08-21 04:44:50.65+00	2025-08-21 04:54:18.349+00
88	1	35	4	2	44	\N	2	2025-08-21 04:45:38.767+00	2025-08-21 04:54:20.196+00
86	1	35	2	2	55	\N	2	2025-08-21 04:44:16.044+00	2025-08-21 04:54:21.783+00
85	1	35	5	2	49	\N	2	2025-08-21 04:43:58.114+00	2025-08-21 04:54:22.55+00
89	1	35	8	2	46	\N	2	2025-08-21 04:45:55.947+00	2025-08-21 04:54:23.574+00
83	1	35	20	2	54	\N	2	2025-08-21 04:43:16.337+00	2025-08-21 04:54:26.24+00
84	1	35	15	2	50	\N	2	2025-08-21 04:43:41.397+00	2025-08-21 04:54:27.388+00
82	1	35	20	2	52	\N	2	2025-08-21 04:43:03.925+00	2025-08-21 04:54:29.105+00
93	1	35	25	2	\N	Лазертай метр	1	2025-08-23 03:03:54.061+00	2025-08-23 03:28:22.063+00
94	1	35	2	2	\N	Даавуун шүүгээ /шар/	1	2025-08-24 03:25:15.208+00	2025-08-24 03:50:30.404+00
95	1	35	2	2	\N	Даавуун шүүгээ /алаг/	1	2025-08-24 03:25:29.651+00	2025-08-24 03:50:31.454+00
96	1	35	2	2	\N	Даавуун шүүгээ /бор/	1	2025-08-24 03:25:42.368+00	2025-08-24 03:50:32.682+00
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permissions (role_id, permission_id) FROM stdin;
2	1
2	2
2	3
2	4
2	7
2	8
2	9
2	15
2	23
2	24
2	28
2	76
2	13
2	6
2	20
2	27
2	34
1	1
1	2
1	3
1	4
1	5
1	6
1	7
1	8
1	9
1	10
1	11
1	12
1	13
1	14
1	15
1	16
1	17
1	18
1	19
1	20
1	21
1	22
1	23
1	24
1	25
1	26
1	27
1	28
1	29
1	30
1	31
1	32
1	33
1	93
1	94
1	95
1	96
1	97
1	98
1	92
1	91
1	90
1	89
1	88
1	87
1	86
1	85
1	84
1	83
1	82
1	80
1	81
1	79
1	78
1	77
1	76
1	75
1	74
1	73
1	72
1	71
1	70
1	69
1	68
1	67
1	66
1	65
1	64
1	63
1	62
1	61
1	60
1	59
1	58
1	57
1	56
1	55
1	54
1	53
1	52
1	51
1	50
1	49
1	48
1	47
1	46
1	45
1	44
1	43
1	42
1	41
1	40
1	39
1	38
1	37
1	36
1	35
1	34
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, "createdAt", "updatedAt") FROM stdin;
1	admin	2025-06-14 13:49:09.147+00	2025-06-14 13:49:09.147+00
2	customer	2025-06-14 13:49:17.03+00	2025-06-14 13:49:17.03+00
3	driver	2025-06-14 13:49:21.721+00	2025-06-14 13:49:21.721+00
\.


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.statuses (id, status, color, "createdAt", "updatedAt") FROM stdin;
1	шинэ	yellow	2025-06-15 09:06:48.885+00	2025-06-15 09:06:48.885+00
2	жолоочид	blue	2025-06-15 09:06:54.301+00	2025-06-15 09:06:54.301+00
3	хүргэлтэнд	green	2025-06-15 09:06:59.354+00	2025-06-15 09:06:59.354+00
4	буцаасан	orange	2025-06-15 09:07:02.937+00	2025-06-15 09:07:02.937+00
5	цуцалсан	red	2025-06-15 09:07:06.969+00	2025-06-15 09:07:06.969+00
6	ирээгүй бараа	\N	2025-06-18 09:40:59.471+00	2025-06-18 09:40:59.471+00
7	ухарсан	\N	2025-08-20 13:49:30.732+00	2025-08-20 13:49:30.732+00
8	утсаа аваагүй	\N	2025-08-20 13:49:37.403+00	2025-08-20 13:49:37.403+00
\.


--
-- Data for Name: summaries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.summaries (id, merchant_id, number_delivery, total, driver, account, comment, driver_id, "createdAt", "updatedAt") FROM stdin;
1	\N	1	6500.00	5000.00	1500.00	0	6	2025-06-18 07:43:10.772+00	2025-06-18 07:43:10.772+00
2	\N	2	2.00	10000.00	-9998.00	0	7	2025-06-26 13:04:38.631+00	2025-06-26 13:04:38.631+00
3	\N	1	126000.00	5000.00	121000.00	0	9	2025-06-26 13:05:26.577+00	2025-06-26 13:05:26.577+00
4	\N	1	76000.00	5000.00	71000.00	0	4	2025-06-26 13:05:42.137+00	2025-06-26 13:05:42.137+00
5	\N	10	142503.00	50000.00	92503.00	0	6	2025-08-18 18:43:50.079+00	2025-08-18 18:43:50.079+00
6	\N	10	122504.00	50000.00	72504.00	0	6	2025-08-18 18:44:52.269+00	2025-08-18 18:44:52.269+00
7	\N	1	35.00	5000.00	-4965.00	0	4	2025-08-18 18:48:28.631+00	2025-08-18 18:48:28.631+00
8	\N	26	703402.00	130000.00	573402.00	0	6	2025-08-20 15:41:14.635+00	2025-08-20 15:41:14.635+00
9	\N	12	211602.00	60000.00	151602.00	0	12	2025-08-20 15:42:43.059+00	2025-08-20 15:42:43.059+00
10	\N	21	372914.00	105000.00	267914.00	0	29	2025-08-20 15:43:31.28+00	2025-08-20 15:43:31.28+00
11	\N	7	301000.00	35000.00	266000.00	0	12	2025-08-21 15:13:05.666+00	2025-08-21 15:13:05.666+00
12	\N	24	731300.00	120000.00	611300.00	0	9	2025-08-22 04:10:47.892+00	2025-08-22 04:10:47.892+00
13	\N	13	440500.00	65000.00	375500.00	0	9	2025-08-23 03:27:20.816+00	2025-08-23 03:27:20.816+00
14	\N	12	205904.00	60000.00	145904.00	0	22	2025-08-23 07:38:12.955+00	2025-08-23 07:38:12.955+00
15	\N	3	106900.00	15000.00	91900.00	0	22	2025-08-23 07:38:17.933+00	2025-08-23 07:38:17.933+00
16	\N	10	105901.00	50000.00	55901.00	0	44	2025-08-25 04:30:28.931+00	2025-08-25 04:30:28.931+00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password, role_id, phone, address, "firstName", "lastName", status, "registerationNumber", email, "createdAt", "updatedAt", name, account_number) FROM stdin;
1	bayaka	$2b$10$wamlpSs7zQhn0/3DBQDR7e.fk65v0hLUVK5Fx3Blfk3ZaRIg3mSK6	1	88064537	\N	\N	\N	2	\N	bayka.lkh@gmail.com	2025-06-14 13:52:09.882+00	2025-06-14 13:52:09.882+00	\N	\N
2	hibox	$2b$10$lDuYbPuH/YfDbFJmeQ/qoe0hm0L.HRFBbMH4hvalpKLGn7XftkcNy	2	88064537	Mongolia	\N	\N	2	\N	bayka0328@yahoo.com	2025-06-15 08:56:16.708+00	2025-06-15 08:56:16.708+00	hibox	\N
3	zoljargal	$2b$10$PVyEDeU9b/beZ/pYcyC2beVrtG2SkC4zcQB/fztZPk7zBncQUOA0S	2	94152403	s	\N	\N	2	\N	hadesinthehaus@gmail.com	2025-06-15 14:41:54.822+00	2025-06-15 14:41:54.822+00	\N	\N
4	temuulen	$2b$10$dASPswYcuweWDhW1jgxJR.xFxGZphckQkoRuYxnv4aqUQwJv1xJiW	3	91566335	mongolia	\N	\N	2	\N	temuul0103@gmail.com	2025-06-16 03:28:12.729+00	2025-06-16 03:28:12.729+00	\N	\N
5	zoljargal1	$2b$10$udZzCF5/SyRIyuqqOeloC.TW9.keiLSPDHoAeidwr3Ega3n1VLBdi	1	94152403	mongolia	\N	\N	2	\N	hadesinthehaus1@gmail.com	2025-06-16 11:13:28.764+00	2025-06-16 11:13:28.764+00	\N	\N
6	misheel	$2b$10$JqjPvaSJWZ6yOIse1y.mbujTqtoJTqxCfEhHfcwkJnfZCmHoZ/gbC	3	88295569	mongolia	\N	\N	2	\N	123@gmail.com	2025-06-17 05:36:12.69+00	2025-06-17 05:36:12.69+00	\N	\N
7	egy	$2b$10$kd7I.0OgK7yr/WUh5n8x.Of9C3E/zWreMFrWHfaVc12kDH.eOEZGy	3	85241463	mongolia	\N	\N	2	\N	yubgrich@gmail.com	2025-06-17 05:52:05.051+00	2025-06-17 05:52:05.051+00	\N	\N
8	test	$2b$10$opdtKnRyHAamT4voreKwTOTFbvdi9NifS0Lan79I/6bon20kGiOye	2	99999999	mongolia	\N	\N	2	\N	test1@gmail.com	2025-06-17 06:45:43.673+00	2025-06-17 06:45:43.673+00	\N	\N
9	ganaa	$2b$10$bcdYtgsUVfc0/.cQaiiwxecmffsyOCUye3hHbcibfis8vC8r61zJW	3	94086861	mongolia	\N	\N	2	\N	a@gmail.com	2025-06-17 09:32:25.782+00	2025-06-17 09:32:25.782+00	\N	\N
10	Ideree	$2b$10$zvbI5jaVwbqolR7L2l0AN.oPmvsG.jmLLWIK9/MH72aAknt4n69gS	1	86116902	\N	\N	\N	2	\N	idereeggs@gmail.com	2025-06-18 08:57:43.206+00	2025-06-18 08:57:43.206+00	\N	\N
11	temuujinbold	$2b$10$kfBT6toG3GOkOSkzuIG.nOnCMD3IL9yp3dykszpW6Hs.aJ0skpDgq	1	85850992	mongolia	\N	\N	2	\N	temka.basan0220@gmail.com	2025-06-18 09:01:12.253+00	2025-06-18 09:01:12.253+00	\N	\N
12	surmaa	$2b$10$5LqtwL4PkB1.bSESy4KVgeDGVv/aLvRjw0eYpUJ9sDd2Y3Y9WqB5u	3	89071217	Mongolia	\N	\N	2	\N	surmaa@gmail.com	2025-06-19 08:36:34.829+00	2025-06-19 08:36:34.829+00	\N	\N
13	bayan	$2b$10$TtOqfjuAUpe3whNW/wV6yegfc8sxlYTWglrTIJx7oYjI3ng5TGAlO	3	880064537	Mongolia	\N	\N	2	\N	bayan@gmail.com	2025-06-20 03:14:28.779+00	2025-06-20 03:14:28.779+00	\N	\N
15	ieltsbook.mn	$2b$10$bzrZoEZgEmoctlLxskwDSuT4nsEKmw.If50JTLYmo/Va1vrRt/mS2	2	80706073	mongolia	\N	\N	2	\N	tsoodolanudari@gmail.com	2025-06-23 12:30:17.463+00	2025-06-23 12:30:17.463+00	\N	\N
16	anujin	$2b$10$/Ou0MC0Sh2xvCm5oV4/1COIY8FLjAR0GXg4/rMx4Py88xAMebHzZK	2	94990844	БЗД, 14 хороолол, Түмэн наст хотхон, 36а байр, 87 тоот	\N	\N	2	\N	anujin@gmail.com	2025-06-29 03:54:58.14+00	2025-06-29 03:54:58.14+00	\N	\N
17	Ger toys	$2b$10$e/PjG4qhbO4fKutwKkgEl.S6H2sZw1MV3H2Ts7DDmkV1A590qlrFO	2	89393886	bumbugur urd 56/2 bair 4	\N	\N	2	\N	khongorzuloyunsuren@gmail.com	2025-07-02 02:31:58.792+00	2025-07-02 02:31:58.792+00	\N	\N
18	80153321	$2b$10$aJx0hByIwIjjsIZZ4MVZlONoGv.sMjiwMcDONbLE37Pg2Iy2WRmoW	3	80153321	mongolia	\N	\N	2	\N	hadesinthehaus@gmail.com	2025-07-06 10:01:47.116+00	2025-07-06 10:01:47.116+00	\N	\N
19	uchral	$2b$10$cwA1pMoeKyF9lrTwElnfrOTWYcgXzQX2vaX.TRiqhP0EjhSavQNru	3	99999999	mongolia	\N	\N	2	\N	hadesinthehaus@gmail.com	2025-07-08 09:23:25.531+00	2025-07-08 09:23:25.531+00	\N	\N
20	test2	$2b$10$nEn55/1NqLGtfAMkcw5/leNHmhiAeSc81KtlSazfBjgpWCzhagpnK	2	88064537	Mongolia	\N	\N	2	\N	test@gmail.com	2025-07-10 11:45:12.869+00	2025-07-10 11:45:12.869+00	\N	\N
21	munhuu	$2b$10$r42hSnZdInUixYadiTkELuSQK/M45IQ3yGiB.ZpflFy1u2YgZoNK6	3	8888888	mongolia	\N	\N	2	\N	hadesinthehaus@gmail.com	2025-07-12 06:29:39.237+00	2025-07-12 06:29:39.237+00	\N	\N
22	Zahiral	$2b$10$Yvw6vlA3wClmW5ye7EQCsOPs6dw5atDhHVt0IDS8Mt3TjPrMuhB9K	3	85850992	mongolia	\N	\N	2	\N	hadesinthehaus@gmail.com	2025-07-16 04:32:59.67+00	2025-07-16 04:32:59.67+00	\N	\N
23	Temuujinbold	$2b$10$l3kFuEF8nYsgbhW1LB7HYuUgZfYlIez..WRUhQhP1eTy7w.jYchv6	1	111111	mongolia	\N	\N	2	\N	hadesinthehaus@gmail.com	2025-07-22 05:31:14.372+00	2025-07-22 05:31:14.372+00	\N	\N
24	Panda	$2b$10$2G0FNhgffuOb5QuVVkOFzed4/MY9UVM/ZjwnaO6v89L59kPca6QeS	2	85850992	bayngo2	\N	\N	2	\N	temka.basan0220@gmail.com	2025-07-22 05:32:37.888+00	2025-07-22 05:32:37.888+00	\N	\N
25	bbbbb	$2b$10$umXaTMN.2Iyv1mCnAuzor.lxhgGRRMZ2JXSWEkl28fL6bHoWoc9mq	2	88064537	ss	\N	\N	2	\N	bayka0328@yahoo.com	2025-07-25 04:04:40.155+00	2025-07-25 04:04:40.155+00	\N	\N
26	energy  bar	$2b$10$34wUq0FVh6.VRdqdpNKEn.CgHrLnx3VXqe3mJGP6om2yLKlV73lpC	2	99714421	test123	\N	\N	2	\N	test123@gmail.cm	2025-07-25 07:26:18.215+00	2025-07-25 07:26:18.215+00	\N	\N
27	energy bar	$2b$10$Wa8jP6DU3IbhhkfP5uS4aeiSGeb6UilOIqZwebi62yq.CdphWv47q	2	99714421	test123	\N	\N	2	\N	test123@gmail.cm	2025-07-25 07:30:14.322+00	2025-07-25 07:30:14.322+00	\N	\N
28	GG online shop	$2b$10$uaV2dwO9lEZ/SRK6MFa9Eu2jzst4acnB.kgKv0KwxnxJtLi2fX4C.	2	88028598	bgd2 	\N	\N	2	\N	ha@gmail.com	2025-08-04 05:00:00.66+00	2025-08-04 05:00:00.66+00	\N	\N
30	testdelguur	$2b$10$sD1Aai4.E.iam16cMn00M.QDD9ycmChdW7zugj3L5v3Yx06fVEtbm	2	88998899	Mongolia	\N	\N	2	\N	user@gmail.com	2025-08-14 14:20:52.833+00	2025-08-14 14:20:52.833+00	\N	\N
31	beauty bridge	$2b$10$IMW6sWNS/r1Dp1kmOyI.MOl7GeNjOZN6sjuaIFwUV4xYYBZj4dug6	2	80114560	Maxmall 1 dawhart 165 toot Beauty Bridge	\N	\N	2	\N	a@gmail.com	2025-08-16 11:36:21.384+00	2025-08-16 11:36:21.384+00	\N	\N
33	heregtseet baraa	$2b$10$6I1MF0yhNSrNPU1ZhS9XRutb0oM6Z2D30Lx52Ssxy4rxkP536Oeom	2	88260247	mongolia	\N	\N	2	\N	test123@gmail.com	2025-08-18 07:29:10.653+00	2025-08-19 01:04:01.818+00	\N	
32	belen baraa hamgiin hymdaar	$2b$10$JhBFAvZtgHd7MqtGHWcY5.ZClhu4V7qldxNsgH2J97S3enV83awoK	2	89890331	mongolia	\N	\N	2	\N	test123@gmail.com	2025-08-18 07:21:53.301+00	2025-08-19 01:54:35.461+00	\N	
35	user123	$2b$10$V41B.53g4VcalnZlvQPfs.LpLepPDam2v/rzZBbaVQq6aJxLgLsOe	2	88166030	BZD 25 horoo Nogoon tugul hothon 77 bair b1	\N	\N	2	\N	123@gmail.com	2025-08-19 10:21:34.723+00	2025-08-19 10:21:34.723+00	\N	\N
36	96557749	$2b$10$BZgDoa8Lt9hdwMTHWK3H7OXuz8F1/XW/ZUMQeKJbsESvw.pmCKscm	3	96557749	a	\N	\N	2	\N	a@gmail.com	2025-08-20 06:01:16.019+00	2025-08-20 06:01:16.019+00	\N	\N
41	miki online shop	$2b$10$/pnxx5Y.xOh/kAIdVR3koO7ML9nw4BZihUmSG8LOwv4FkG2LKPE7u	2	99129640	99129640 бзд 1р хороо автай сайн хотхон	\N	\N	2	\N	h@gmail.com	2025-08-21 16:11:58.396+00	2025-08-21 16:11:58.396+00	\N	\N
34	Ozy online shop	$2b$10$/ZiZgWB6BTcM2Zq/vUx7EOvtv9nb3LnYA9N6r5D24ORi35V3ZVyZ2	2	80156550	3,4-р хороолол, Элбэг дэлгүүрийн чанх урд Номун таун доороо Yulong ресторан, GS25тай 16 давхар бор цэнхэртэй байр	\N	\N	2	\N	Ozyzyoji@gmail.com	2025-08-18 08:26:51.153+00	2025-08-20 11:56:15.422+00	\N	
37	nymaa	$2b$10$WlIZzlmw.uljSwGO6.Iq5u93NuNE8HY4SQRx5C2lfz8lwFOwJivEC	3	a	a	\N	\N	2	\N	a	2025-08-20 12:44:55.605+00	2025-08-20 12:44:55.605+00	\N	\N
38	altanchimeg	$2b$10$sZAAu07eGA1rFOjguu85Tu7LkRbJ.YeN7Ay.HEUkGEnNTbgkgWnTe	3	a	a	\N	\N	2	\N	a	2025-08-20 12:45:08.665+00	2025-08-20 12:45:08.665+00	\N	\N
39	javhlan	$2b$10$d7t9ukT6E2wk3hwztHs.deK8XBteLQZsmTz5an44aHIVVIwC8A23S	3	a	a	\N	\N	2	\N	a	2025-08-20 12:45:21.72+00	2025-08-20 12:45:21.72+00	\N	\N
29	temuulen1	$2b$10$/.uGjy9g3Ow6vJOBJTWsK.UWp5t/nkeep0fzDpqyn4NP7Qup0aL4i	3	88888888	mongolia	\N	\N	2	\N	2@gmail.com	2025-08-14 04:22:59.629+00	2025-08-20 13:34:53.677+00	\N	5175172336
40	99984723	$2b$10$z9evKurmzvL.jG0fFjn84u1ye8MwKYKQY8aVSDYlRJpk7Ku4T/gWC	3	99984723	a	\N	\N	2	\N	a@gmail.com	2025-08-21 05:33:26.486+00	2025-08-21 05:33:26.486+00	\N	\N
42	altansukh	$2b$10$hgfGRAbATO2bK1IH5X9jlOka9u0.lfbz4YiZUbN8HtQnrOT1zcxI.	2	91769989	@gmail.com	\N	\N	2	\N	altansukh@gmail.com	2025-08-22 06:56:49.267+00	2025-08-22 06:56:49.267+00	\N	\N
43	altansukh	$2b$10$YYYpVqHTZNZfxO0nS.n9meLEu7eogAqUfhk/6zGAURMMcnaMzkQuK	3	91769989	,mongolia	\N	\N	2	\N	altansukh@gmail.com\t	2025-08-22 06:58:18.433+00	2025-08-22 06:58:18.433+00	\N	\N
44	tuvsanaa	$2b$10$URiEfVy6NAlci2AYs0nB2uu/yelozxufq4RrYT5ZNMYBjDakOmeqS	3	89868822	mongolia	\N	\N	2	\N	@gmail.com	2025-08-23 02:57:06.808+00	2025-08-23 02:57:06.808+00	\N	\N
45	smart AI	$2b$10$541botDOr1/m97FgkiyRAOkXBZt8CDPj1mioRwvVn90YtUpjy6tdy	2	99118852	ХУД 3 хороо life tower 	\N	\N	2	\N	altanashagdar@gmail.com	2025-08-24 06:38:20.821+00	2025-08-24 06:38:20.821+00	\N	\N
\.


--
-- Data for Name: wares; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wares (id, name, "createdAt", "updatedAt") FROM stdin;
1	Stork агуулах	2025-06-17 07:47:39.569+00	2025-06-17 07:47:39.569+00
\.


--
-- Data for Name: words; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.words (id, ware_id, merchant_id, stock, name, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Name: Logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Logs_id_seq"', 1, false);


--
-- Name: ProductImages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductImages_id_seq"', 1, false);


--
-- Name: ages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ages_id_seq', 1, false);


--
-- Name: banners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.banners_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- Name: deliveries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deliveries_id_seq', 6872, true);


--
-- Name: delivery_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.delivery_items_id_seq', 423, true);


--
-- Name: doctors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doctors_id_seq', 1, false);


--
-- Name: goods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goods_id_seq', 65, true);


--
-- Name: infos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.infos_id_seq', 1, false);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 22, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 98, true);


--
-- Name: privacies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.privacies_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 1, false);


--
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profiles_id_seq', 1, false);


--
-- Name: regions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regions_id_seq', 6, true);


--
-- Name: requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.requests_id_seq', 96, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- Name: statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.statuses_id_seq', 8, true);


--
-- Name: summaries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.summaries_id_seq', 16, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 45, true);


--
-- Name: wares_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wares_id_seq', 2, true);


--
-- Name: words_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.words_id_seq', 1, false);


--
-- Name: Logs Logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Logs"
    ADD CONSTRAINT "Logs_pkey" PRIMARY KEY (id);


--
-- Name: ProductImages ProductImages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductImages"
    ADD CONSTRAINT "ProductImages_pkey" PRIMARY KEY (id);


--
-- Name: ages ages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ages
    ADD CONSTRAINT ages_pkey PRIMARY KEY (id);


--
-- Name: banners banners_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banners
    ADD CONSTRAINT banners_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: deliveries deliveries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT deliveries_pkey PRIMARY KEY (id);


--
-- Name: delivery_items delivery_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_items
    ADD CONSTRAINT delivery_items_pkey PRIMARY KEY (id);


--
-- Name: doctors doctors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT doctors_pkey PRIMARY KEY (id);


--
-- Name: goods goods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods
    ADD CONSTRAINT goods_pkey PRIMARY KEY (id);


--
-- Name: infos infos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infos
    ADD CONSTRAINT infos_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: privacies privacies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privacies
    ADD CONSTRAINT privacies_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: regions regions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);


--
-- Name: requests requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (role_id, permission_id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: statuses statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);


--
-- Name: summaries summaries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.summaries
    ADD CONSTRAINT summaries_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wares wares_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wares
    ADD CONSTRAINT wares_pkey PRIMARY KEY (id);


--
-- Name: words words_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_pkey PRIMARY KEY (id);


--
-- Name: deliveries deliveries_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT deliveries_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: deliveries deliveries_merchant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT deliveries_merchant_id_fkey FOREIGN KEY (merchant_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deliveries deliveries_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT deliveries_status_fkey FOREIGN KEY (status) REFERENCES public.statuses(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_items delivery_items_delivery_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_items
    ADD CONSTRAINT delivery_items_delivery_id_fkey FOREIGN KEY (delivery_id) REFERENCES public.deliveries(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_items delivery_items_good_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_items
    ADD CONSTRAINT delivery_items_good_id_fkey FOREIGN KEY (good_id) REFERENCES public.goods(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: goods goods_merchant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods
    ADD CONSTRAINT goods_merchant_id_fkey FOREIGN KEY (merchant_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: goods goods_ware_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods
    ADD CONSTRAINT goods_ware_id_fkey FOREIGN KEY (ware_id) REFERENCES public.wares(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders orders_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders orders_merchant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_merchant_id_fkey FOREIGN KEY (merchant_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: requests requests_good_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_good_id_fkey FOREIGN KEY (good_id) REFERENCES public.goods(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: requests requests_merchant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_merchant_id_fkey FOREIGN KEY (merchant_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: requests requests_ware_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_ware_id_fkey FOREIGN KEY (ware_id) REFERENCES public.wares(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: role_permissions role_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: role_permissions role_permissions_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: summaries summaries_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.summaries
    ADD CONSTRAINT summaries_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: summaries summaries_merchant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.summaries
    ADD CONSTRAINT summaries_merchant_id_fkey FOREIGN KEY (merchant_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

