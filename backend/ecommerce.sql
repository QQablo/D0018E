PGDMP  8    (                 }            D0018ECOMMERCE    17.2    17.1     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16392    D0018ECOMMERCE    DATABASE     �   CREATE DATABASE "D0018ECOMMERCE" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Swedish_Sweden.1252';
     DROP DATABASE "D0018ECOMMERCE";
                     Rohan    false            �            1259    16394    customer    TABLE     #  CREATE TABLE public.customer (
    customer_id smallint NOT NULL,
    last_name character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    email character varying(255) NOT NULL,
    address text,
    phone character varying(20),
    password character varying(60)
);
    DROP TABLE public.customer;
       public         heap r       postgres    false            �            1259    16393    customers_customerid_seq    SEQUENCE     �   CREATE SEQUENCE public.customers_customerid_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.customers_customerid_seq;
       public               postgres    false    218            �           0    0    customers_customerid_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.customers_customerid_seq OWNED BY public.customer.customer_id;
          public               postgres    false    217            �            1259    16415    orders    TABLE     !  CREATE TABLE public.orders (
    order_id smallint NOT NULL,
    customer_id smallint,
    price money NOT NULL,
    email character varying(255) NOT NULL,
    date date DEFAULT CURRENT_DATE NOT NULL,
    phone character varying(20),
    shipping_address text,
    items_count smallint
);
    DROP TABLE public.orders;
       public         heap r       postgres    false            �            1259    16414    orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_order_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.orders_order_id_seq;
       public               postgres    false    220            �           0    0    orders_order_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;
          public               postgres    false    219            &           2604    16397    customer customer_id    DEFAULT     |   ALTER TABLE ONLY public.customer ALTER COLUMN customer_id SET DEFAULT nextval('public.customers_customerid_seq'::regclass);
 C   ALTER TABLE public.customer ALTER COLUMN customer_id DROP DEFAULT;
       public               postgres    false    217    218    218            '           2604    16418    orders order_id    DEFAULT     r   ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);
 >   ALTER TABLE public.orders ALTER COLUMN order_id DROP DEFAULT;
       public               postgres    false    219    220    220            �          0    16394    customer 
   TABLE DATA           g   COPY public.customer (customer_id, last_name, first_name, email, address, phone, password) FROM stdin;
    public               postgres    false    218   X       �          0    16415    orders 
   TABLE DATA           q   COPY public.orders (order_id, customer_id, price, email, date, phone, shipping_address, items_count) FROM stdin;
    public               postgres    false    220   u       �           0    0    customers_customerid_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.customers_customerid_seq', 1, false);
          public               postgres    false    217            �           0    0    orders_order_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);
          public               postgres    false    219            *           2606    16403    customer customers_email_key 
   CONSTRAINT     X   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customers_email_key UNIQUE (email);
 F   ALTER TABLE ONLY public.customer DROP CONSTRAINT customers_email_key;
       public                 postgres    false    218            ,           2606    16401    customer customers_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);
 A   ALTER TABLE ONLY public.customer DROP CONSTRAINT customers_pkey;
       public                 postgres    false    218            .           2606    16423    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public                 postgres    false    220            /           2606    16424    orders orders_customer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);
 H   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_customer_id_fkey;
       public               postgres    false    220    218    4652            �      x������ � �      �      x������ � �     