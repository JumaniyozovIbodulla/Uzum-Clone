DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'type_enum') THEN
    CREATE TYPE type_enum AS ENUM ('self_pickup', 'delivery');
  END IF;
END$$;

DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'status_enum') THEN
    CREATE TYPE status_enum AS ENUM ('swaiting_for_payment', 'collecting', 'delivery', 'waiting_on_branch', 'finished', 'cancelled');
  END IF;
END$$;

DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_enum') THEN
    CREATE TYPE payment_enum AS ENUM ('uzum','cash','terminal');
  END IF;
END$$;

CREATE TABLE IF NOT EXISTS orders(
    id uuid PRIMARY KEY,
    external_id varchar,
    type type_enum,
    customer_phone varchar(20),
    customer_name varchar(20),
    customer_id uuid REFERENCES customers (id),
    payment_type payment_enum,
    status status_enum,
    to_address varchar,
    to_location polygon,
    discount_amount float,
    amount float,
    delivery_price float,
    paid boolean default false,
    created_at timestamp DEFAULT NOW(),
    updated_at timestamp,
    deleted_at timestamp,
    UNIQUE(customer_phone)
);


CREATE TABLE IF NOT EXISTS order_products(
    id uuid PRIMARY KEY,
    product_id uuid REFERENCES product (id),
    count integer,
    discount_price float,
    price float,
    order_id uuid REFERENCES orders (id),
    created_at timestamp DEFAULT NOW(),
    updated_at timestamp,
    deleted_at timestamp
);


CREATE TABLE IF NOT EXISTS order_status_notes(
    id uuid PRIMARY KEY,
    order_id uuid REFERENCES orders (id),
    status status_enum,
    user_id uuid,
    reason varchar(100),
    created_at timestamp default NOW()
);