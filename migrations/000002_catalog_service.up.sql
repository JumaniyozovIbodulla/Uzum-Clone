CREATE TABLE IF NOT EXISTS category (
    id uuid PRIMARY KEY,
    slug varchar(20) UNIQUE,
    name_uz varchar(20) DEFAULT '',
    name_ru varchar(20) DEFAULT '',
    name_en varchar(20) DEFAULT '',
    active boolean DEFAULT true,
    order_no integer DEFAULT 0,
    parent_id uuid REFERENCES category (id),
    created_at timestamp DEFAULT NOW(),
    updated_at timestamp,
    deleted_at timestamp
);

CREATE TABLE IF NOT EXISTS product (
    id uuid PRIMARY KEY,
    slug varchar(20) UNIQUE,
    name_uz varchar(20) DEFAULT '',
    name_ru varchar(20) DEFAULT '',
    name_en varchar(20) DEFAULT '',
    description_uz varchar(500) DEFAULT '',
    description_ru varchar(500) DEFAULT '',
    description_en varchar(500) DEFAULT '',
    active boolean DEFAULT true,
    order_no integer DEFAULT 0,
    in_price float,
    out_price float,
    left_count integer,
    discount_percent float DEFAULT 0,
    image varchar(200)[],
    created_at timestamp DEFAULT NOW(),
    updated_at timestamp,
    deleted_at timestamp
);

CREATE TABLE IF NOT EXISTS product_categories(
    id uuid PRIMARY KEY,
    product_id uuid REFERENCES product (id) NOT NULL,
    category_id uuid REFERENCES category (id) NOT NULL,
    UNIQUE (product_id,category_id)
);

CREATE TABLE IF NOT EXISTS product_reviews(
    id uuid PRIMARY KEY,
    customer_id uuid REFERENCES customers (id),
    product_id uuid REFERENCES product (id),
    text varchar(500),
    rating float,
    order_id uuid, 
    created_at timestamp default now()
);