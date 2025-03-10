PGDMP      5    
            }            d0018e    17.4 (Debian 17.4-1.pgdg120+2)    17.1 }    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16384    d0018e    DATABASE     q   CREATE DATABASE d0018e WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE d0018e;
                     student    false            �           1247    16550    status    TYPE     d   CREATE TYPE public.status AS ENUM (
    'Placed',
    'Shipped',
    'Delivered',
    'Canceled'
);
    DROP TYPE public.status;
       public               student    false            �            1259    16387 
   cart_items    TABLE       CREATE TABLE public.cart_items (
    cart_item_id smallint NOT NULL,
    cart_id uuid NOT NULL,
    product_id smallint NOT NULL,
    product_name character varying(255),
    quantity smallint NOT NULL,
    sub_total numeric(10,2) NOT NULL,
    size smallint
);
    DROP TABLE public.cart_items;
       public         heap r       student    false            �            1259    16390    cart_items_cart_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cart_items_cart_item_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.cart_items_cart_item_id_seq;
       public               student    false    217            �           0    0    cart_items_cart_item_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.cart_items_cart_item_id_seq OWNED BY public.cart_items.cart_item_id;
          public               student    false    218            �            1259    16391    cart_items_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cart_items_product_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.cart_items_product_id_seq;
       public               student    false    217            �           0    0    cart_items_product_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.cart_items_product_id_seq OWNED BY public.cart_items.product_id;
          public               student    false    219            �            1259    16392    carts    TABLE     �   CREATE TABLE public.carts (
    cart_id uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_id smallint,
    last_updated date DEFAULT CURRENT_DATE NOT NULL
);
    DROP TABLE public.carts;
       public         heap r       student    false            �            1259    16397    carts_customer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.carts_customer_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.carts_customer_id_seq;
       public               student    false    220            �           0    0    carts_customer_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.carts_customer_id_seq OWNED BY public.carts.customer_id;
          public               student    false    221            �            1259    16398 
   categories    TABLE     p   CREATE TABLE public.categories (
    category_id smallint NOT NULL,
    name character varying(255) NOT NULL
);
    DROP TABLE public.categories;
       public         heap r       student    false            �            1259    16401    categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_category_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.categories_category_id_seq;
       public               student    false    222            �           0    0    categories_category_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;
          public               student    false    223            �            1259    16402    order_items    TABLE     =  CREATE TABLE public.order_items (
    order_item_id smallint NOT NULL,
    order_id smallint NOT NULL,
    product_id smallint NOT NULL,
    quantity smallint NOT NULL,
    sub_total numeric(10,2) NOT NULL,
    product_name character varying(255),
    size smallint,
    has_comment boolean DEFAULT false NOT NULL
);
    DROP TABLE public.order_items;
       public         heap r       student    false            �            1259    16405    order_items_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_items_order_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.order_items_order_id_seq;
       public               student    false    224            �           0    0    order_items_order_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.order_items_order_id_seq OWNED BY public.order_items.order_id;
          public               student    false    225            �            1259    16406    order_items_order_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_items_order_item_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.order_items_order_item_id_seq;
       public               student    false    224            �           0    0    order_items_order_item_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.order_items_order_item_id_seq OWNED BY public.order_items.order_item_id;
          public               student    false    226            �            1259    16407    order_items_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_items_product_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.order_items_product_id_seq;
       public               student    false    224            �           0    0    order_items_product_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.order_items_product_id_seq OWNED BY public.order_items.product_id;
          public               student    false    227            �            1259    16408    orders    TABLE     �  CREATE TABLE public.orders (
    order_id smallint NOT NULL,
    first_name character varying(40),
    last_name character varying(40),
    email character varying(40) NOT NULL,
    customer_id smallint NOT NULL,
    price numeric(10,2) NOT NULL,
    date date DEFAULT CURRENT_DATE,
    item_count smallint,
    shipping_address text NOT NULL,
    phone character varying(30),
    current_status public.status DEFAULT 'Placed'::public.status
);
    DROP TABLE public.orders;
       public         heap r       student    false    905    905            �            1259    16414    orders_customer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_customer_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.orders_customer_id_seq;
       public               student    false    228            �           0    0    orders_customer_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.orders_customer_id_seq OWNED BY public.orders.customer_id;
          public               student    false    229            �            1259    16415    orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_order_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.orders_order_id_seq;
       public               student    false    228            �           0    0    orders_order_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;
          public               student    false    230            �            1259    16416    product_categories    TABLE     p   CREATE TABLE public.product_categories (
    product_id smallint NOT NULL,
    category_id smallint NOT NULL
);
 &   DROP TABLE public.product_categories;
       public         heap r       student    false            �            1259    16419 "   product_categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_categories_category_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.product_categories_category_id_seq;
       public               student    false    231            �           0    0 "   product_categories_category_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.product_categories_category_id_seq OWNED BY public.product_categories.category_id;
          public               student    false    232            �            1259    16420 !   product_categories_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_categories_product_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.product_categories_product_id_seq;
       public               student    false    231            �           0    0 !   product_categories_product_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.product_categories_product_id_seq OWNED BY public.product_categories.product_id;
          public               student    false    233            �            1259    16421    product_sizes    TABLE     �   CREATE TABLE public.product_sizes (
    product_id smallint NOT NULL,
    size_id smallint NOT NULL,
    stock smallint DEFAULT 0,
    CONSTRAINT product_sizes_stock_check CHECK ((stock >= 0)),
    CONSTRAINT stock_non_negative CHECK ((stock >= 0))
);
 !   DROP TABLE public.product_sizes;
       public         heap r       student    false            �            1259    16424    product_sizes_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_sizes_product_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.product_sizes_product_id_seq;
       public               student    false    234            �           0    0    product_sizes_product_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.product_sizes_product_id_seq OWNED BY public.product_sizes.product_id;
          public               student    false    235            �            1259    16425    product_sizes_size_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_sizes_size_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.product_sizes_size_id_seq;
       public               student    false    234            �           0    0    product_sizes_size_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.product_sizes_size_id_seq OWNED BY public.product_sizes.size_id;
          public               student    false    236            �            1259    16426    products    TABLE     �   CREATE TABLE public.products (
    product_id smallint NOT NULL,
    name character varying(255) NOT NULL,
    price numeric(10,2) NOT NULL,
    description character varying(255),
    image text
);
    DROP TABLE public.products;
       public         heap r       student    false            �            1259    16431    products_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_product_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.products_product_id_seq;
       public               student    false    237            �           0    0    products_product_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;
          public               student    false    238            �            1259    16432    reviews    TABLE     �   CREATE TABLE public.reviews (
    review_id smallint NOT NULL,
    customer_id smallint NOT NULL,
    product_id smallint NOT NULL,
    stars smallint NOT NULL,
    title character varying(255),
    text character varying(255)
);
    DROP TABLE public.reviews;
       public         heap r       student    false            �            1259    16437    reviews_customer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviews_customer_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.reviews_customer_id_seq;
       public               student    false    239            �           0    0    reviews_customer_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.reviews_customer_id_seq OWNED BY public.reviews.customer_id;
          public               student    false    240            �            1259    16438    reviews_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviews_product_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.reviews_product_id_seq;
       public               student    false    239            �           0    0    reviews_product_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.reviews_product_id_seq OWNED BY public.reviews.product_id;
          public               student    false    241            �            1259    16439    reviews_review_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviews_review_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.reviews_review_id_seq;
       public               student    false    239            �           0    0    reviews_review_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.reviews_review_id_seq OWNED BY public.reviews.review_id;
          public               student    false    242            �            1259    16440    sizes    TABLE     Y   CREATE TABLE public.sizes (
    size_id smallint NOT NULL,
    size smallint NOT NULL
);
    DROP TABLE public.sizes;
       public         heap r       student    false            �            1259    16443    sizes_size_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sizes_size_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.sizes_size_id_seq;
       public               student    false    243            �           0    0    sizes_size_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.sizes_size_id_seq OWNED BY public.sizes.size_id;
          public               student    false    244            �            1259    16444    users    TABLE     ?  CREATE TABLE public.users (
    user_id smallint NOT NULL,
    first_name character varying(30),
    last_name character varying(30),
    email character varying(40) NOT NULL,
    address text,
    phone character varying(30),
    passwrd character varying(60) NOT NULL,
    user_role character varying(10) NOT NULL
);
    DROP TABLE public.users;
       public         heap r       student    false            �            1259    16449    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public               student    false    245            �           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public               student    false    246            �           2604    16450    cart_items cart_item_id    DEFAULT     �   ALTER TABLE ONLY public.cart_items ALTER COLUMN cart_item_id SET DEFAULT nextval('public.cart_items_cart_item_id_seq'::regclass);
 F   ALTER TABLE public.cart_items ALTER COLUMN cart_item_id DROP DEFAULT;
       public               student    false    218    217            �           2604    16451    cart_items product_id    DEFAULT     ~   ALTER TABLE ONLY public.cart_items ALTER COLUMN product_id SET DEFAULT nextval('public.cart_items_product_id_seq'::regclass);
 D   ALTER TABLE public.cart_items ALTER COLUMN product_id DROP DEFAULT;
       public               student    false    219    217            �           2604    16452    categories category_id    DEFAULT     �   ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);
 E   ALTER TABLE public.categories ALTER COLUMN category_id DROP DEFAULT;
       public               student    false    223    222            �           2604    16453    order_items order_item_id    DEFAULT     �   ALTER TABLE ONLY public.order_items ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_items_order_item_id_seq'::regclass);
 H   ALTER TABLE public.order_items ALTER COLUMN order_item_id DROP DEFAULT;
       public               student    false    226    224            �           2604    16454    order_items order_id    DEFAULT     |   ALTER TABLE ONLY public.order_items ALTER COLUMN order_id SET DEFAULT nextval('public.order_items_order_id_seq'::regclass);
 C   ALTER TABLE public.order_items ALTER COLUMN order_id DROP DEFAULT;
       public               student    false    225    224            �           2604    16455    order_items product_id    DEFAULT     �   ALTER TABLE ONLY public.order_items ALTER COLUMN product_id SET DEFAULT nextval('public.order_items_product_id_seq'::regclass);
 E   ALTER TABLE public.order_items ALTER COLUMN product_id DROP DEFAULT;
       public               student    false    227    224            �           2604    16456    orders order_id    DEFAULT     r   ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);
 >   ALTER TABLE public.orders ALTER COLUMN order_id DROP DEFAULT;
       public               student    false    230    228            �           2604    16457    orders customer_id    DEFAULT     x   ALTER TABLE ONLY public.orders ALTER COLUMN customer_id SET DEFAULT nextval('public.orders_customer_id_seq'::regclass);
 A   ALTER TABLE public.orders ALTER COLUMN customer_id DROP DEFAULT;
       public               student    false    229    228            �           2604    16458    product_categories product_id    DEFAULT     �   ALTER TABLE ONLY public.product_categories ALTER COLUMN product_id SET DEFAULT nextval('public.product_categories_product_id_seq'::regclass);
 L   ALTER TABLE public.product_categories ALTER COLUMN product_id DROP DEFAULT;
       public               student    false    233    231            �           2604    16459    product_categories category_id    DEFAULT     �   ALTER TABLE ONLY public.product_categories ALTER COLUMN category_id SET DEFAULT nextval('public.product_categories_category_id_seq'::regclass);
 M   ALTER TABLE public.product_categories ALTER COLUMN category_id DROP DEFAULT;
       public               student    false    232    231            �           2604    16460    product_sizes product_id    DEFAULT     �   ALTER TABLE ONLY public.product_sizes ALTER COLUMN product_id SET DEFAULT nextval('public.product_sizes_product_id_seq'::regclass);
 G   ALTER TABLE public.product_sizes ALTER COLUMN product_id DROP DEFAULT;
       public               student    false    235    234            �           2604    16461    product_sizes size_id    DEFAULT     ~   ALTER TABLE ONLY public.product_sizes ALTER COLUMN size_id SET DEFAULT nextval('public.product_sizes_size_id_seq'::regclass);
 D   ALTER TABLE public.product_sizes ALTER COLUMN size_id DROP DEFAULT;
       public               student    false    236    234            �           2604    16462    products product_id    DEFAULT     z   ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);
 B   ALTER TABLE public.products ALTER COLUMN product_id DROP DEFAULT;
       public               student    false    238    237            �           2604    16463    reviews review_id    DEFAULT     v   ALTER TABLE ONLY public.reviews ALTER COLUMN review_id SET DEFAULT nextval('public.reviews_review_id_seq'::regclass);
 @   ALTER TABLE public.reviews ALTER COLUMN review_id DROP DEFAULT;
       public               student    false    242    239            �           2604    16464    reviews customer_id    DEFAULT     z   ALTER TABLE ONLY public.reviews ALTER COLUMN customer_id SET DEFAULT nextval('public.reviews_customer_id_seq'::regclass);
 B   ALTER TABLE public.reviews ALTER COLUMN customer_id DROP DEFAULT;
       public               student    false    240    239            �           2604    16465    reviews product_id    DEFAULT     x   ALTER TABLE ONLY public.reviews ALTER COLUMN product_id SET DEFAULT nextval('public.reviews_product_id_seq'::regclass);
 A   ALTER TABLE public.reviews ALTER COLUMN product_id DROP DEFAULT;
       public               student    false    241    239            �           2604    16466    sizes size_id    DEFAULT     n   ALTER TABLE ONLY public.sizes ALTER COLUMN size_id SET DEFAULT nextval('public.sizes_size_id_seq'::regclass);
 <   ALTER TABLE public.sizes ALTER COLUMN size_id DROP DEFAULT;
       public               student    false    244    243            �           2604    16467    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public               student    false    246    245            �          0    16387 
   cart_items 
   TABLE DATA           p   COPY public.cart_items (cart_item_id, cart_id, product_id, product_name, quantity, sub_total, size) FROM stdin;
    public               student    false    217   ��       �          0    16392    carts 
   TABLE DATA           C   COPY public.carts (cart_id, customer_id, last_updated) FROM stdin;
    public               student    false    220   :�       �          0    16398 
   categories 
   TABLE DATA           7   COPY public.categories (category_id, name) FROM stdin;
    public               student    false    222   ��       �          0    16402    order_items 
   TABLE DATA           �   COPY public.order_items (order_item_id, order_id, product_id, quantity, sub_total, product_name, size, has_comment) FROM stdin;
    public               student    false    224   �       �          0    16408    orders 
   TABLE DATA           �   COPY public.orders (order_id, first_name, last_name, email, customer_id, price, date, item_count, shipping_address, phone, current_status) FROM stdin;
    public               student    false    228   '�       �          0    16416    product_categories 
   TABLE DATA           E   COPY public.product_categories (product_id, category_id) FROM stdin;
    public               student    false    231   ՞       �          0    16421    product_sizes 
   TABLE DATA           C   COPY public.product_sizes (product_id, size_id, stock) FROM stdin;
    public               student    false    234   �       �          0    16426    products 
   TABLE DATA           O   COPY public.products (product_id, name, price, description, image) FROM stdin;
    public               student    false    237   ��       �          0    16432    reviews 
   TABLE DATA           Y   COPY public.reviews (review_id, customer_id, product_id, stars, title, text) FROM stdin;
    public               student    false    239   ��       �          0    16440    sizes 
   TABLE DATA           .   COPY public.sizes (size_id, size) FROM stdin;
    public               student    false    243   s�       �          0    16444    users 
   TABLE DATA           j   COPY public.users (user_id, first_name, last_name, email, address, phone, passwrd, user_role) FROM stdin;
    public               student    false    245   ��       �           0    0    cart_items_cart_item_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.cart_items_cart_item_id_seq', 211, true);
          public               student    false    218            �           0    0    cart_items_product_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.cart_items_product_id_seq', 1, false);
          public               student    false    219            �           0    0    carts_customer_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.carts_customer_id_seq', 1, false);
          public               student    false    221            �           0    0    categories_category_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.categories_category_id_seq', 4, true);
          public               student    false    223            �           0    0    order_items_order_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.order_items_order_id_seq', 1, false);
          public               student    false    225            �           0    0    order_items_order_item_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.order_items_order_item_id_seq', 33, true);
          public               student    false    226            �           0    0    order_items_product_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.order_items_product_id_seq', 1, false);
          public               student    false    227            �           0    0    orders_customer_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.orders_customer_id_seq', 1, false);
          public               student    false    229            �           0    0    orders_order_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.orders_order_id_seq', 27, true);
          public               student    false    230            �           0    0 "   product_categories_category_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.product_categories_category_id_seq', 1, false);
          public               student    false    232            �           0    0 !   product_categories_product_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.product_categories_product_id_seq', 1, false);
          public               student    false    233            �           0    0    product_sizes_product_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.product_sizes_product_id_seq', 1, false);
          public               student    false    235            �           0    0    product_sizes_size_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.product_sizes_size_id_seq', 1, false);
          public               student    false    236            �           0    0    products_product_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.products_product_id_seq', 22, true);
          public               student    false    238            �           0    0    reviews_customer_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.reviews_customer_id_seq', 1, false);
          public               student    false    240            �           0    0    reviews_product_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.reviews_product_id_seq', 1, false);
          public               student    false    241            �           0    0    reviews_review_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.reviews_review_id_seq', 10, true);
          public               student    false    242            �           0    0    sizes_size_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.sizes_size_id_seq', 8, true);
          public               student    false    244            �           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 10, true);
          public               student    false    246            �           2606    16469    cart_items cart_items_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (cart_item_id);
 D   ALTER TABLE ONLY public.cart_items DROP CONSTRAINT cart_items_pkey;
       public                 student    false    217            �           2606    16471    carts carts_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (cart_id);
 :   ALTER TABLE ONLY public.carts DROP CONSTRAINT carts_pkey;
       public                 student    false    220            �           2606    16473    categories categories_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public                 student    false    222            �           2606    16475    order_items order_items_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id);
 F   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_pkey;
       public                 student    false    224            �           2606    16477    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public                 student    false    228            �           2606    16479 *   product_categories product_categories_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (product_id, category_id);
 T   ALTER TABLE ONLY public.product_categories DROP CONSTRAINT product_categories_pkey;
       public                 student    false    231    231            �           2606    16481     product_sizes product_sizes_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.product_sizes
    ADD CONSTRAINT product_sizes_pkey PRIMARY KEY (size_id, product_id);
 J   ALTER TABLE ONLY public.product_sizes DROP CONSTRAINT product_sizes_pkey;
       public                 student    false    234    234            �           2606    16483    products products_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public                 student    false    237            �           2606    16485    reviews reviews_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);
 >   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_pkey;
       public                 student    false    239            �           2606    16487    sizes sizes_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.sizes
    ADD CONSTRAINT sizes_pkey PRIMARY KEY (size_id);
 :   ALTER TABLE ONLY public.sizes DROP CONSTRAINT sizes_pkey;
       public                 student    false    243            �           2606    16489    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public                 student    false    245            �           2606    16491    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 student    false    245            �           2606    16492 "   cart_items cart_items_cart_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.carts(cart_id) NOT VALID;
 L   ALTER TABLE ONLY public.cart_items DROP CONSTRAINT cart_items_cart_id_fkey;
       public               student    false    217    220    3300            �           2606    16497 %   cart_items cart_items_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) NOT VALID;
 O   ALTER TABLE ONLY public.cart_items DROP CONSTRAINT cart_items_product_id_fkey;
       public               student    false    217    3312    237            �           2606    16502 (   product_categories category_id_reference    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT category_id_reference FOREIGN KEY (category_id) REFERENCES public.categories(category_id) NOT VALID;
 R   ALTER TABLE ONLY public.product_categories DROP CONSTRAINT category_id_reference;
       public               student    false    222    3302    231                       2606    16507    reviews customer_id_reference    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT customer_id_reference FOREIGN KEY (customer_id) REFERENCES public.users(user_id) NOT VALID;
 G   ALTER TABLE ONLY public.reviews DROP CONSTRAINT customer_id_reference;
       public               student    false    239    3320    245            �           2606    16512 %   order_items order_items_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) NOT VALID;
 O   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_order_id_fkey;
       public               student    false    224    228    3306            �           2606    16517 '   order_items order_items_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) NOT VALID;
 Q   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_product_id_fkey;
       public               student    false    3312    237    224            �           2606    16522    orders orders_customer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.users(user_id) NOT VALID;
 H   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_customer_id_fkey;
       public               student    false    228    245    3320            �           2606    16527 '   product_categories product_id_reference    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_id_reference FOREIGN KEY (product_id) REFERENCES public.products(product_id) NOT VALID;
 Q   ALTER TABLE ONLY public.product_categories DROP CONSTRAINT product_id_reference;
       public               student    false    237    231    3312                       2606    16532    reviews product_id_reference    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT product_id_reference FOREIGN KEY (product_id) REFERENCES public.products(product_id) NOT VALID;
 F   ALTER TABLE ONLY public.reviews DROP CONSTRAINT product_id_reference;
       public               student    false    3312    237    239                        2606    16537 *   product_sizes product_size_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_sizes
    ADD CONSTRAINT product_size_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) NOT VALID;
 T   ALTER TABLE ONLY public.product_sizes DROP CONSTRAINT product_size_product_id_fkey;
       public               student    false    234    237    3312                       2606    16542 '   product_sizes product_size_size_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_sizes
    ADD CONSTRAINT product_size_size_id_fkey FOREIGN KEY (size_id) REFERENCES public.sizes(size_id) NOT VALID;
 Q   ALTER TABLE ONLY public.product_sizes DROP CONSTRAINT product_size_size_id_fkey;
       public               student    false    3316    243    234            �   x  x��TˊK]gE�@����{QAPG�n�)�c���=��B�(�ἢ���F����M�& (:k+u�ԌC
��_l{��Ў۫o�a�&�Q	�w�5L�ĳ"�E�V�9`t�ջ��f vz�ě���<H���k��};�����%�G	U��"�����3ٽ�N���U�d*�+G$�&Ȋ�vEы��!�/#��6V�L)�־ ��g<��MA�7�	~����"6�2��J`�a�`c��Ia�r�PZ��Q⼔zԠ��ގ��������ڙH��:��Rb���'`xv��B�+��ⲫD�<zD���Բ�3�`.�{d�)��1�<uC^p
�bb]�H󬧃&�	�bim���ۀ���`�ӆ����9S|��jXY2Qr+cE`��,���!�P�ug%`v*�'��i��h����C�>��ئdE�v�8P����6���'߁�aE�菎l��d_m�\�����ɀ-`o$�
*�撊�կ�%>/����mw{;\I�,Po��s;��O<�ѓw+�IZ����f%?����0��N3NA���H~������R��B�Ќ�e��s��u�z�@d�)h˿��+���t���~ Y�:      �   v  x�e��m(1Eי^�0�xd��_B�U�y�솣{�8�`���dg����i�5f�����AH
H@�ul�}�����6��s��/��!
=	�8A$RF�i���F6	�^�銭%�cT:u�w�~!�l*ͫ�. 8r�k�#}���S�RApԮX�U�7C�6�q$� |���١p����;��X���Oc�̉H�xu�����PK�/��*92FHmh��#�+�Y7��л1�y�솊mw�c`��m�c�B�#�]Dڏ^�3�@N	�L�-�B�M�^)���,�G���G 4�=���-'s�bj�1���t��|!���|u,A,R�e��{�=��Ki5%��j5^$�QC8Re������<��˸�      �   5   x�3��KM�N-*�2���OL��9]�R���3�S��L8���K��b���� h��      �     x�u��N�0�ϓ��y�?�����@�P��P�H)	��n[�H�����vf�&Fb4!��a���4t�c6��"�� �	����<��n2����Y�d��+�W,(�@$wJu�����<�l��Օ��g%�BN[1l��6�_r:b+vA9�S��"G�a�ݙ�~8���LJy�d�:���7Oݴ�2�ў8��%����bLʱDwy�Mno�&'�8�����b��oEt�U��&��_�Tk���r�WE	lTA�fi���꭮���x�      �   �  x����N�0���)���q��7X!X-�8�e/��.Ŏl^�/���pDӤ�� �(�H�g���|�C�+�>��1�OBl+�1��6��:S��\0�^�%\{wG!8��+�s��J�(rY����j�9�;�~C���w��L�cVLT0�
��s8.�Tk;���^We�;{T��S󲵫�2�ع�S-?H���@~!�we�1�_+S��s�0��+@��򱫿8$���N��'c�B�����e��#U�t����ks�q���ۗ��%�/.��t� E�5*�Q�m֏䓬��<s]]9bU ����� �"i��vn�u�t����Ʀ(��4K,�Þ%p�}m��M>O��g��'�$L�-Կ�y,�C[��|	?��<�6֚[:rC�փ_ �'��k#�ı��'��fo�=<�      �   4   x�ȹ  ���\������9�DC���Ċ������yĺE�9>      �   �   x�=���0D��P�
����_ǲ�_ANF۰a�y\�bN�3�Y�~��M����d���y�s��q���� �c�'���]c��tWUAUPTU�}�|����'>�+\�
W����-|����7��o��/��/��-���;\
S�B!^�{�t���=&��w�%��3�i��
�P
�j-��R�T�����q?��i�      �   �  x�}�Ms�0��{�����| I`�N��Zۊeɕ����H�d2N/���#r�8���J(�ţ8&KA��)�ZU��HK԰� 
ƶ��*�PK`hx.G���6ߎ���Wy�G������Zţ���1Y��k�T:E����]�J:�X�h�H�?�x2mL��D�f���ǚ����n<6��]#i�Bsw</�}~`���2�Wn�v�YL�rB����D2= s*-��pS�f���x7<U�X�R��J���O�[,�?������#,TK�q���Mf���)�kn��C@���db�u=�o=2#Wg�<qQ)I"�	�4T|\�����������Ԭƾ�)�X.7�B��F�qE��
��|K�&ߦ�4�P��
?Y5}9瓇�[s?��P�ߓS}��h��[=lw�j����v�4�f^rYpWh#B�4dt�����Uw?.��K��_a���T�z%����n������*l�N�d-�>�w���aw�/<A�o��+\+"�*���(D'�q��sQ�B��}kG7y��+�F����,�u��c�JP���Y�ik��ٻѵV*\�j,S�!����:2��9��'"�%���xL�a��V>�����Y8�ߣ�`���H      �   �   x�-��NC1���)N��tU(WH U�]��%$��R�����ۓ�l�����;3����5��J͡{]�����?�ߕ�&��K��X*9��g�l�ijs%��!�\Ǻ�	��S#����.�<�y�a qo2b(IfN���]�����&�[���|�n�W%�������	G�����5=�if�|�.RՋ��᰾�]���}c��Ä^      �   .   x��A  �wNCi
��u��f)/)O,%/��ٴ\�|�N#      �     x���˒�8 �u|
�mDn®���Ђx��	.A!��?�r��b���0�3Ug*�񧒯��h�c��q�j�vhjR��j��3,xfc��3C�O�����i�ʿ�yL0 &1$��c�Q�����c�Xq�S��u�[?�a=B�R�Ռ��J��ܡo��K����܄�� ��<��K��� �?���ى���v{V��ڧ�/TQ[�_Ļ�QTD[S=΂%L�
x5��`���2�O�e}�tJI��Bp�)��3!pCK�|�o�M�i��%	v\\wv�s`�#�y���
�,�����<
��Q�ԋ�'�:�5�w�.�m l>,�����	��-��Ͻ�y	�2�>�'��?J�g{�z嚂z�&�֛`�.��#T�ا�R�	'���if�=Qy�����E�w6��+�u���L����������RdU>�P`�)�E�Ʋv�i�ʥ�Q��l��:�,:�K6�?y��J���0L`�@� �c8�e�'����F�v�E�9!���>Pmy"KY��[K�f��Ĥ���fiO����į@��j%)�$A�i��+�4/p��-��ں��E���&��fC�4�3�{�zLMIŶS�Ol[����{OK@��q�,O o0�r���Uh�������'��-{�2�1�F�|%7�г���kZ���ړ��Z(�`�B8A��}+��g�"��r�R�Bz�aMf�nU��*n�p�Be��31IӘ���0Rn�%��_�~P���o�䇠     