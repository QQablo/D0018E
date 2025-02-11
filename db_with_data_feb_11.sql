PGDMP  $                    }            d0018e    17.2 (Debian 17.2-1.pgdg120+1)    17.1 }    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16384    d0018e    DATABASE     q   CREATE DATABASE d0018e WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE d0018e;
                     student    false            �            1259    17492 
   cart_items    TABLE     �   CREATE TABLE public.cart_items (
    cart_item_id smallint NOT NULL,
    cart_id uuid NOT NULL,
    product_id smallint NOT NULL,
    product_name character varying(255),
    quantity smallint NOT NULL,
    sub_total money NOT NULL
);
    DROP TABLE public.cart_items;
       public         heap r       student    false            �            1259    17490    cart_items_cart_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cart_items_cart_item_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.cart_items_cart_item_id_seq;
       public               student    false    246            �           0    0    cart_items_cart_item_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.cart_items_cart_item_id_seq OWNED BY public.cart_items.cart_item_id;
          public               student    false    244            �            1259    17491    cart_items_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cart_items_product_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.cart_items_product_id_seq;
       public               student    false    246            �           0    0    cart_items_product_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.cart_items_product_id_seq OWNED BY public.cart_items.product_id;
          public               student    false    245            �            1259    17395    carts    TABLE     �   CREATE TABLE public.carts (
    cart_id uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_id smallint NOT NULL,
    last_updated date DEFAULT CURRENT_DATE NOT NULL
);
    DROP TABLE public.carts;
       public         heap r       student    false            �            1259    17394    carts_customer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.carts_customer_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.carts_customer_id_seq;
       public               student    false    218            �           0    0    carts_customer_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.carts_customer_id_seq OWNED BY public.carts.customer_id;
          public               student    false    217            �            1259    17404 
   categories    TABLE     p   CREATE TABLE public.categories (
    category_id smallint NOT NULL,
    name character varying(255) NOT NULL
);
    DROP TABLE public.categories;
       public         heap r       student    false            �            1259    17403    categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_category_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.categories_category_id_seq;
       public               student    false    220            �           0    0    categories_category_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;
          public               student    false    219            �            1259    17413    order_items    TABLE     �   CREATE TABLE public.order_items (
    order_item_id smallint NOT NULL,
    order_id smallint NOT NULL,
    product_id smallint NOT NULL,
    quantity smallint NOT NULL,
    sub_total money NOT NULL,
    product_name character varying(255)
);
    DROP TABLE public.order_items;
       public         heap r       student    false            �            1259    17411    order_items_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_items_order_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.order_items_order_id_seq;
       public               student    false    224            �           0    0    order_items_order_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.order_items_order_id_seq OWNED BY public.order_items.order_id;
          public               student    false    222            �            1259    17410    order_items_order_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_items_order_item_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.order_items_order_item_id_seq;
       public               student    false    224            �           0    0    order_items_order_item_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.order_items_order_item_id_seq OWNED BY public.order_items.order_item_id;
          public               student    false    221            �            1259    17412    order_items_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_items_product_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.order_items_product_id_seq;
       public               student    false    224            �           0    0    order_items_product_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.order_items_product_id_seq OWNED BY public.order_items.product_id;
          public               student    false    223            �            1259    17423    orders    TABLE     ^  CREATE TABLE public.orders (
    order_id smallint NOT NULL,
    first_name character varying(40),
    last_name character varying(40),
    email character varying(40) NOT NULL,
    customer_id smallint NOT NULL,
    price money NOT NULL,
    date date,
    item_count smallint,
    shipping_address text NOT NULL,
    phone character varying(30)
);
    DROP TABLE public.orders;
       public         heap r       student    false            �            1259    17422    orders_customer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_customer_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.orders_customer_id_seq;
       public               student    false    227            �           0    0    orders_customer_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.orders_customer_id_seq OWNED BY public.orders.customer_id;
          public               student    false    226            �            1259    17421    orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_order_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.orders_order_id_seq;
       public               student    false    227            �           0    0    orders_order_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;
          public               student    false    225            �            1259    17434    product_categories    TABLE     p   CREATE TABLE public.product_categories (
    product_id smallint NOT NULL,
    category_id smallint NOT NULL
);
 &   DROP TABLE public.product_categories;
       public         heap r       student    false            �            1259    17433 "   product_categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_categories_category_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.product_categories_category_id_seq;
       public               student    false    230            �           0    0 "   product_categories_category_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.product_categories_category_id_seq OWNED BY public.product_categories.category_id;
          public               student    false    229            �            1259    17432 !   product_categories_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_categories_product_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.product_categories_product_id_seq;
       public               student    false    230            �           0    0 !   product_categories_product_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.product_categories_product_id_seq OWNED BY public.product_categories.product_id;
          public               student    false    228            �            1259    17443    product_sizes    TABLE     g   CREATE TABLE public.product_sizes (
    product_id smallint NOT NULL,
    size_id smallint NOT NULL
);
 !   DROP TABLE public.product_sizes;
       public         heap r       student    false            �            1259    17441    product_sizes_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_sizes_product_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.product_sizes_product_id_seq;
       public               student    false    233            �           0    0    product_sizes_product_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.product_sizes_product_id_seq OWNED BY public.product_sizes.product_id;
          public               student    false    231            �            1259    17442    product_sizes_size_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_sizes_size_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.product_sizes_size_id_seq;
       public               student    false    233            �           0    0    product_sizes_size_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.product_sizes_size_id_seq OWNED BY public.product_sizes.size_id;
          public               student    false    232            �            1259    17451    products    TABLE     �   CREATE TABLE public.products (
    product_id smallint NOT NULL,
    name character varying(255) NOT NULL,
    price money NOT NULL,
    description character varying(255),
    image text
);
    DROP TABLE public.products;
       public         heap r       student    false            �            1259    17450    products_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_product_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.products_product_id_seq;
       public               student    false    235            �           0    0    products_product_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;
          public               student    false    234            �            1259    17462    reviews    TABLE     �   CREATE TABLE public.reviews (
    review_id smallint NOT NULL,
    customer_id smallint NOT NULL,
    product_id smallint NOT NULL,
    stars smallint NOT NULL,
    title character varying(255),
    text character varying(255)
);
    DROP TABLE public.reviews;
       public         heap r       student    false            �            1259    17460    reviews_customer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviews_customer_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.reviews_customer_id_seq;
       public               student    false    239            �           0    0    reviews_customer_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.reviews_customer_id_seq OWNED BY public.reviews.customer_id;
          public               student    false    237            �            1259    17461    reviews_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviews_product_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.reviews_product_id_seq;
       public               student    false    239            �           0    0    reviews_product_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.reviews_product_id_seq OWNED BY public.reviews.product_id;
          public               student    false    238            �            1259    17459    reviews_review_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviews_review_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.reviews_review_id_seq;
       public               student    false    239            �           0    0    reviews_review_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.reviews_review_id_seq OWNED BY public.reviews.review_id;
          public               student    false    236            �            1259    17473    sizes    TABLE     Y   CREATE TABLE public.sizes (
    size_id smallint NOT NULL,
    size smallint NOT NULL
);
    DROP TABLE public.sizes;
       public         heap r       student    false            �            1259    17472    sizes_size_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sizes_size_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.sizes_size_id_seq;
       public               student    false    241            �           0    0    sizes_size_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.sizes_size_id_seq OWNED BY public.sizes.size_id;
          public               student    false    240            �            1259    17480    users    TABLE     ?  CREATE TABLE public.users (
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
       public         heap r       student    false            �            1259    17479    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public               student    false    243            �           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public               student    false    242            �           2604    17495    cart_items cart_item_id    DEFAULT     �   ALTER TABLE ONLY public.cart_items ALTER COLUMN cart_item_id SET DEFAULT nextval('public.cart_items_cart_item_id_seq'::regclass);
 F   ALTER TABLE public.cart_items ALTER COLUMN cart_item_id DROP DEFAULT;
       public               student    false    244    246    246            �           2604    17496    cart_items product_id    DEFAULT     ~   ALTER TABLE ONLY public.cart_items ALTER COLUMN product_id SET DEFAULT nextval('public.cart_items_product_id_seq'::regclass);
 D   ALTER TABLE public.cart_items ALTER COLUMN product_id DROP DEFAULT;
       public               student    false    246    245    246            �           2604    17399    carts customer_id    DEFAULT     v   ALTER TABLE ONLY public.carts ALTER COLUMN customer_id SET DEFAULT nextval('public.carts_customer_id_seq'::regclass);
 @   ALTER TABLE public.carts ALTER COLUMN customer_id DROP DEFAULT;
       public               student    false    217    218    218            �           2604    17407    categories category_id    DEFAULT     �   ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);
 E   ALTER TABLE public.categories ALTER COLUMN category_id DROP DEFAULT;
       public               student    false    219    220    220            �           2604    17416    order_items order_item_id    DEFAULT     �   ALTER TABLE ONLY public.order_items ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_items_order_item_id_seq'::regclass);
 H   ALTER TABLE public.order_items ALTER COLUMN order_item_id DROP DEFAULT;
       public               student    false    221    224    224            �           2604    17417    order_items order_id    DEFAULT     |   ALTER TABLE ONLY public.order_items ALTER COLUMN order_id SET DEFAULT nextval('public.order_items_order_id_seq'::regclass);
 C   ALTER TABLE public.order_items ALTER COLUMN order_id DROP DEFAULT;
       public               student    false    222    224    224            �           2604    17418    order_items product_id    DEFAULT     �   ALTER TABLE ONLY public.order_items ALTER COLUMN product_id SET DEFAULT nextval('public.order_items_product_id_seq'::regclass);
 E   ALTER TABLE public.order_items ALTER COLUMN product_id DROP DEFAULT;
       public               student    false    224    223    224            �           2604    17426    orders order_id    DEFAULT     r   ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);
 >   ALTER TABLE public.orders ALTER COLUMN order_id DROP DEFAULT;
       public               student    false    225    227    227            �           2604    17427    orders customer_id    DEFAULT     x   ALTER TABLE ONLY public.orders ALTER COLUMN customer_id SET DEFAULT nextval('public.orders_customer_id_seq'::regclass);
 A   ALTER TABLE public.orders ALTER COLUMN customer_id DROP DEFAULT;
       public               student    false    227    226    227            �           2604    17437    product_categories product_id    DEFAULT     �   ALTER TABLE ONLY public.product_categories ALTER COLUMN product_id SET DEFAULT nextval('public.product_categories_product_id_seq'::regclass);
 L   ALTER TABLE public.product_categories ALTER COLUMN product_id DROP DEFAULT;
       public               student    false    230    228    230            �           2604    17438    product_categories category_id    DEFAULT     �   ALTER TABLE ONLY public.product_categories ALTER COLUMN category_id SET DEFAULT nextval('public.product_categories_category_id_seq'::regclass);
 M   ALTER TABLE public.product_categories ALTER COLUMN category_id DROP DEFAULT;
       public               student    false    229    230    230            �           2604    17446    product_sizes product_id    DEFAULT     �   ALTER TABLE ONLY public.product_sizes ALTER COLUMN product_id SET DEFAULT nextval('public.product_sizes_product_id_seq'::regclass);
 G   ALTER TABLE public.product_sizes ALTER COLUMN product_id DROP DEFAULT;
       public               student    false    231    233    233            �           2604    17447    product_sizes size_id    DEFAULT     ~   ALTER TABLE ONLY public.product_sizes ALTER COLUMN size_id SET DEFAULT nextval('public.product_sizes_size_id_seq'::regclass);
 D   ALTER TABLE public.product_sizes ALTER COLUMN size_id DROP DEFAULT;
       public               student    false    232    233    233            �           2604    17454    products product_id    DEFAULT     z   ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);
 B   ALTER TABLE public.products ALTER COLUMN product_id DROP DEFAULT;
       public               student    false    234    235    235            �           2604    17465    reviews review_id    DEFAULT     v   ALTER TABLE ONLY public.reviews ALTER COLUMN review_id SET DEFAULT nextval('public.reviews_review_id_seq'::regclass);
 @   ALTER TABLE public.reviews ALTER COLUMN review_id DROP DEFAULT;
       public               student    false    236    239    239            �           2604    17466    reviews customer_id    DEFAULT     z   ALTER TABLE ONLY public.reviews ALTER COLUMN customer_id SET DEFAULT nextval('public.reviews_customer_id_seq'::regclass);
 B   ALTER TABLE public.reviews ALTER COLUMN customer_id DROP DEFAULT;
       public               student    false    239    237    239            �           2604    17467    reviews product_id    DEFAULT     x   ALTER TABLE ONLY public.reviews ALTER COLUMN product_id SET DEFAULT nextval('public.reviews_product_id_seq'::regclass);
 A   ALTER TABLE public.reviews ALTER COLUMN product_id DROP DEFAULT;
       public               student    false    238    239    239            �           2604    17476    sizes size_id    DEFAULT     n   ALTER TABLE ONLY public.sizes ALTER COLUMN size_id SET DEFAULT nextval('public.sizes_size_id_seq'::regclass);
 <   ALTER TABLE public.sizes ALTER COLUMN size_id DROP DEFAULT;
       public               student    false    241    240    241            �           2604    17483    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public               student    false    242    243    243            �          0    17492 
   cart_items 
   TABLE DATA           j   COPY public.cart_items (cart_item_id, cart_id, product_id, product_name, quantity, sub_total) FROM stdin;
    public               student    false    246   �       �          0    17395    carts 
   TABLE DATA           C   COPY public.carts (cart_id, customer_id, last_updated) FROM stdin;
    public               student    false    218   #�       �          0    17404 
   categories 
   TABLE DATA           7   COPY public.categories (category_id, name) FROM stdin;
    public               student    false    220   @�       �          0    17413    order_items 
   TABLE DATA           m   COPY public.order_items (order_item_id, order_id, product_id, quantity, sub_total, product_name) FROM stdin;
    public               student    false    224   ��       �          0    17423    orders 
   TABLE DATA           �   COPY public.orders (order_id, first_name, last_name, email, customer_id, price, date, item_count, shipping_address, phone) FROM stdin;
    public               student    false    227   ��       �          0    17434    product_categories 
   TABLE DATA           E   COPY public.product_categories (product_id, category_id) FROM stdin;
    public               student    false    230   ��       �          0    17443    product_sizes 
   TABLE DATA           <   COPY public.product_sizes (product_id, size_id) FROM stdin;
    public               student    false    233   ��       �          0    17451    products 
   TABLE DATA           O   COPY public.products (product_id, name, price, description, image) FROM stdin;
    public               student    false    235   ��       �          0    17462    reviews 
   TABLE DATA           Y   COPY public.reviews (review_id, customer_id, product_id, stars, title, text) FROM stdin;
    public               student    false    239   <�       �          0    17473    sizes 
   TABLE DATA           .   COPY public.sizes (size_id, size) FROM stdin;
    public               student    false    241   Y�       �          0    17480    users 
   TABLE DATA           j   COPY public.users (user_id, first_name, last_name, email, address, phone, passwrd, user_role) FROM stdin;
    public               student    false    243   ��       �           0    0    cart_items_cart_item_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.cart_items_cart_item_id_seq', 1, false);
          public               student    false    244            �           0    0    cart_items_product_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.cart_items_product_id_seq', 1, false);
          public               student    false    245            �           0    0    carts_customer_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.carts_customer_id_seq', 1, false);
          public               student    false    217            �           0    0    categories_category_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.categories_category_id_seq', 4, true);
          public               student    false    219            �           0    0    order_items_order_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.order_items_order_id_seq', 1, false);
          public               student    false    222            �           0    0    order_items_order_item_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.order_items_order_item_id_seq', 1, false);
          public               student    false    221            �           0    0    order_items_product_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.order_items_product_id_seq', 1, false);
          public               student    false    223            �           0    0    orders_customer_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.orders_customer_id_seq', 1, false);
          public               student    false    226            �           0    0    orders_order_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);
          public               student    false    225            �           0    0 "   product_categories_category_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.product_categories_category_id_seq', 1, false);
          public               student    false    229            �           0    0 !   product_categories_product_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.product_categories_product_id_seq', 1, false);
          public               student    false    228            �           0    0    product_sizes_product_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.product_sizes_product_id_seq', 1, false);
          public               student    false    231            �           0    0    product_sizes_size_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.product_sizes_size_id_seq', 1, false);
          public               student    false    232            �           0    0    products_product_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.products_product_id_seq', 12, true);
          public               student    false    234            �           0    0    reviews_customer_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.reviews_customer_id_seq', 1, false);
          public               student    false    237            �           0    0    reviews_product_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.reviews_product_id_seq', 1, false);
          public               student    false    238            �           0    0    reviews_review_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.reviews_review_id_seq', 1, false);
          public               student    false    236            �           0    0    sizes_size_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.sizes_size_id_seq', 8, true);
          public               student    false    240            �           0    0    users_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_user_id_seq', 6, true);
          public               student    false    242            �           2606    17498    cart_items cart_items_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (cart_item_id);
 D   ALTER TABLE ONLY public.cart_items DROP CONSTRAINT cart_items_pkey;
       public                 student    false    246            �           2606    17402    carts carts_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (cart_id);
 :   ALTER TABLE ONLY public.carts DROP CONSTRAINT carts_pkey;
       public                 student    false    218            �           2606    17409    categories categories_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public                 student    false    220            �           2606    17420    order_items order_items_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id);
 F   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_pkey;
       public                 student    false    224            �           2606    17431    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public                 student    false    227            �           2606    17440 *   product_categories product_categories_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (product_id, category_id);
 T   ALTER TABLE ONLY public.product_categories DROP CONSTRAINT product_categories_pkey;
       public                 student    false    230    230            �           2606    17449     product_sizes product_sizes_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.product_sizes
    ADD CONSTRAINT product_sizes_pkey PRIMARY KEY (size_id, product_id);
 J   ALTER TABLE ONLY public.product_sizes DROP CONSTRAINT product_sizes_pkey;
       public                 student    false    233    233            �           2606    17458    products products_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public                 student    false    235            �           2606    17471    reviews reviews_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);
 >   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_pkey;
       public                 student    false    239            �           2606    17478    sizes sizes_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.sizes
    ADD CONSTRAINT sizes_pkey PRIMARY KEY (size_id);
 :   ALTER TABLE ONLY public.sizes DROP CONSTRAINT sizes_pkey;
       public                 student    false    241            �           2606    17489    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public                 student    false    243            �           2606    17487    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 student    false    243            �           2606    17544 "   cart_items cart_items_cart_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.carts(cart_id) NOT VALID;
 L   ALTER TABLE ONLY public.cart_items DROP CONSTRAINT cart_items_cart_id_fkey;
       public               student    false    3290    246    218            �           2606    17549 %   cart_items cart_items_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) NOT VALID;
 O   ALTER TABLE ONLY public.cart_items DROP CONSTRAINT cart_items_product_id_fkey;
       public               student    false    235    246    3302            �           2606    17514 (   product_categories category_id_reference    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT category_id_reference FOREIGN KEY (category_id) REFERENCES public.categories(category_id) NOT VALID;
 R   ALTER TABLE ONLY public.product_categories DROP CONSTRAINT category_id_reference;
       public               student    false    220    230    3292            �           2606    17534    reviews customer_id_reference    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT customer_id_reference FOREIGN KEY (customer_id) REFERENCES public.users(user_id) NOT VALID;
 G   ALTER TABLE ONLY public.reviews DROP CONSTRAINT customer_id_reference;
       public               student    false    3310    239    243            �           2606    17499 %   order_items order_items_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) NOT VALID;
 O   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_order_id_fkey;
       public               student    false    227    224    3296            �           2606    17504 '   order_items order_items_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) NOT VALID;
 Q   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_product_id_fkey;
       public               student    false    235    224    3302            �           2606    17509    orders orders_customer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.users(user_id) NOT VALID;
 H   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_customer_id_fkey;
       public               student    false    243    3310    227            �           2606    17519 '   product_categories product_id_reference    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_id_reference FOREIGN KEY (product_id) REFERENCES public.products(product_id) NOT VALID;
 Q   ALTER TABLE ONLY public.product_categories DROP CONSTRAINT product_id_reference;
       public               student    false    235    3302    230            �           2606    17539    reviews product_id_reference    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT product_id_reference FOREIGN KEY (product_id) REFERENCES public.products(product_id) NOT VALID;
 F   ALTER TABLE ONLY public.reviews DROP CONSTRAINT product_id_reference;
       public               student    false    3302    235    239            �           2606    17524 *   product_sizes product_size_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_sizes
    ADD CONSTRAINT product_size_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) NOT VALID;
 T   ALTER TABLE ONLY public.product_sizes DROP CONSTRAINT product_size_product_id_fkey;
       public               student    false    233    3302    235            �           2606    17529 '   product_sizes product_size_size_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_sizes
    ADD CONSTRAINT product_size_size_id_fkey FOREIGN KEY (size_id) REFERENCES public.sizes(size_id) NOT VALID;
 Q   ALTER TABLE ONLY public.product_sizes DROP CONSTRAINT product_size_size_id_fkey;
       public               student    false    3306    233    241            �      x������ � �      �      x������ � �      �   5   x�3��KM�N-*�2���OL��9]�R���3�S��L8���K��b���� h��      �      x������ � �      �      x������ � �      �   0   x�Ĺ  ����I�va�90�$�ai��i�m��Q�~�n#� ��      �   �   x�й0��*�#>"�^�>(@���>���,X�Ê5���;��;x��x���x�'�x�'~����?��^x�^x��x�7�x�7>���>���~�_�����/n[��
m%�j�i��V�����J�����j���i
j*jJjjj�j�j�j�������e3�      �   l  x�}�Ks�0��)���vB;���y4�I�4�N/P�#߾�L���p ��������TCD����4�!Yp�5K������@Z��3PЦ�LP���5�Ř������*�j���(��oe8�Sc>8!kV"\0�R%���m"��Q�f�TH����I�)�C3�L�f��av��کזV��;��dy�����wy?s7����3gd��"�
��^��Sa�#5�k�4k��m�d]0mXB���KY�;?�v�h�zgB.o7O0��{�Aa�l�����e
W�(��J��5R�I�&�zZ�{eJn.�[xf���?T[�?N�g�U������P|��ձ���b���XZ�v,�H�K��-bs|k`�PkЅD�V�����;}�=6�=۲
�{��}���*&��=��n���I�Om�Ie��rq0w�F t��CN�mj��Z�{�f c���3i�t3ᯞ	��MJ�wn4�e;���0w[�"m 񁽳�f���Exa1�~�U�m���r)�ъ*�BCp6=>Դ��IT5Ki�
R6�1�
�U����kx.�l<u�	q)Ũ�� �CT����s��j%e�y�HkR�.T���=�YMZ���ӕ�~���?�:�7      �      x������ � �      �   .   x��A  �wNCi
��u��f)/)O,%/��ٴ\�|�N#      �   �  x���͎�@ �s�{�*�/�FXFX3�f@���Ft��({����V�k��&��J�R�R)��	�Oo-��!i���s� ��e���ןer��HzB��/��R��q�}O�䉢�`�GC��Sk-�.)V�%ħ��1'�������ژ�e߻`����҉�����&A��(N �	��V<��yſ�������m���	�ˮ�-]1,�VE{������Y� �$)� 3J��E|b�W��lΨ��L�~�02�r��K�\�$nPg����U؉)�AI���A��\ )38R���}�XK�AFD����s�l���ⷑ�yY
>�.=n�bd��{�u	�0B�W����0*��?NW�G<�y�-d��f˭?��S��O���ԡ�(�83w��rAwT�/�og�w�q��f���TUv�O�.|�+�k��>;ڗX����_��ru�F��8^D#5�|T܅G7�����!���     