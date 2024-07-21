CREATE TYPE public.order_entity_type_enum AS ENUM
    ('BUY', 'SELL');

CREATE TYPE public.order_entity_status_enum AS ENUM
    ('OPEN', 'PROCESSING', 'COMPLETED', 'CLOSED', 'CANCELED');

CREATE TABLE IF NOT EXISTS public.order_entity
(
    id  SERIAL PRIMARY KEY ,
    "accountId" character varying COLLATE pg_catalog."default" NOT NULL,
    "userId" character varying COLLATE pg_catalog."default" NOT NULL,
    "quoteId" character varying COLLATE pg_catalog."default" NOT NULL,
    "holdingId" character varying COLLATE pg_catalog."default",
    type order_entity_type_enum NOT NULL,
    quantity integer NOT NULL,
    price real NOT NULL,
    "orderFee" real NOT NULL,
    status order_entity_status_enum NOT NULL DEFAULT 'OPEN'::order_entity_status_enum,
    "openDate" timestamp without time zone NOT NULL DEFAULT now(),
    "completionDate" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT now(),
    "updatedAt" timestamp without time zone NOT NULL DEFAULT now()
);