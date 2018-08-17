DROP TABLE tickets;
DROP TABLE films;
DROP TABLE customers;

CREATE TABLE films
(
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  price INT8 NOT NULL
);

CREATE TABLE customers
(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  funds INT8 NOT NULL
);

CREATE TABLE tickets
(
  id SERIAL8 PRIMARY KEY,
  customer_id INT8 REFERENCES customers(id),
  film_id INT8 REFERENCES films(id),
  fee INT8
);
