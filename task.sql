-- 1. List all customers who live in Texas (use JOINs)
SELECT customer.customer_id, customer.first_name, customer.last_name, address.address
FROM customer
JOIN address ON customer.address_id = address.address;


-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT
    customer.customer_id,
   CONCAT(customer.first_name,' ',
    customer.last_name) AS full_name,
    payment.amount
FROM
    customer
JOIN
    payment ON customer.customer_id = payment.customer_id
WHERE
    payment.amount > 6.99;


-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    customer_id IN (
        SELECT
            customer_id
        FROM
            payment
        WHERE
            amount > 175
    );


-- 4. List all customers that live in Nepal (use the city table)
SELECT
    customer.customer_id,
    customer.first_name,
    customer.last_name
FROM
    customer
JOIN
    address ON customer.address_id = address.address
JOIN
    city ON address.city_id = city.city_id
WHERE
    city.city = 'Nepal';


-- 5. Which staff member had the most transactions?

SELECT
    staff.staff_id,
    staff.first_name,
    staff.last_name,
    COUNT(payment.payment_id) AS transaction_count
FROM
    staff
JOIN
    payment ON staff.staff_id = payment.staff_id
GROUP BY
    staff.staff_id, staff.first_name, staff.last_name
ORDER BY
    transaction_count DESC
LIMIT 1;


-- 6. How many movies of each rating are there?
SELECT
    rating,
    COUNT(*) AS movie_count
FROM
    film
GROUP BY
    rating;


-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)
SELECT
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    payment.amount
FROM
    customer
JOIN
    payment ON customer.customer_id = payment.customer_id
WHERE
    payment.amount > 6.99
    AND customer.customer_id IN (
        SELECT
            customer_id
        FROM
            payment
        GROUP BY
            customer_id
        HAVING
            COUNT(payment_id) = 1
    );


-- 8. How many free rentals did our stores give away?
SELECT COUNT(*) AS free_rentals_count
FROM rental
LEFT JOIN payment ON rental.rental_id = payment.rental_id
WHERE payment.amount IS NULL OR payment.amount = 0;
