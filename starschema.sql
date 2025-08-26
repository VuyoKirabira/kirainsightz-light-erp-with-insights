-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.dim_inventory_type (
  inventory_type_id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  inventory_type text NOT NULL,
  unique_linker uuid,
  CONSTRAINT dim_inventory_type_pkey PRIMARY KEY (inventory_type_id)
);
CREATE TABLE public.dim_submit_date (
  submit_date_id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  submit_date text NOT NULL,
  submission_time timestamp with time zone DEFAULT now(),
  unique_linker uuid,
  CONSTRAINT dim_submit_date_pkey PRIMARY KEY (submit_date_id)
);
CREATE TABLE public.fact_inventory (
  inventory_submit_id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  inventory_type_id bigint,
  submit_date_id bigint,
  quantity bigint,
  transaction_type text,
  submission_time timestamp with time zone DEFAULT now(),
  unique_linker uuid,
  CONSTRAINT fact_inventory_pkey PRIMARY KEY (inventory_submit_id),
  CONSTRAINT fact_inventory_submit_date_id_fkey FOREIGN KEY (submit_date_id) REFERENCES public.dim_submit_date(submit_date_id),
  CONSTRAINT fact_inventory_inventory_type_id_fkey FOREIGN KEY (inventory_type_id) REFERENCES public.dim_inventory_type(inventory_type_id)
);
