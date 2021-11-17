# SELECT QUERIES
SELECT * FROM affiliations
SELECT * FROM customers
SELECT * FROM customer_order
SELECT * FROM drinks
SELECT * FROM drink_order
SELECT * FROM orders

# QUERY TO SEARCH
SELECT * FROM Customers
WHERE customer__name LIKE '%:customer_name_input%'


# INSERT QUERIES
INSERT INTO `Customers` (`customer_name`, `planet`, `species`, `bounty`, `affiliation`, `orders`) VALUES
(:customer_name_input, :planet_input, :species_input, :bounty_input, :affiliation_input, :orders_input);

INSERT INTO `Orders` (`balance`) VALUES
(:balance_input);

INSERT INTO `Drinks` (`drink_id`, `name`, `size`, `credits`) VALUES
(:drink_id_input, :name_input, :size_input, :credits);

INSERT INTO `Affiliations` (`id`, `galactic_id`, `affiliation`) VALUES
(:id, :galactic_id_input, :affiliation_input);


# UPDATE QUERIES
UPDATE Customers
SET
`customer_name` = :customer_name_input,
`galactic_id` = :galactic_id_input,
`planet` = :planet_input,
`species` = :species_input,
`bounty` = :bounty_input,
`affiliation` = :affiliation_input,
`orders` = :orders_input
WHERE `galactic_id` = :galactic_id_input

UPDATE Orders
SET
`balance` = :galactic_id_input
WHERE order_id = :order_id_input;

UPDATE Drinks
SET
`name` = :name_input,
`size` = :size_input,
`credits` = :credits_input
WHERE drink_id = :drink_id_input;

UPDATE Affiliations
SET
`galactic_id` = :galactic_id_input,
`affiliation` = :affiliation_input
WHERE id = :id_input;


# DELETE QUERIES
DELETE FROM Customers
WHERE galactic_id = :galactic_id_input;

DELETE FROM Orders
WHERE order_id = :order_id_inputs;

DELETE FROM Drinks
WHERE drink_id = :drink_id;

DELETE FROM Affiliations
WHERE id = id_input;
