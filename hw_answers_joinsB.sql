SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM payment;
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM staff;
SELECT * FROM film;
SELECT * FROM rental;
SELECT * FROM inventory;

-- Question #1
SELECT first_name, last_name, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

--OR

SELECT first_name, last_name, district
FROM address
INNER JOIN customer
ON address.address_id = customer.address_id
WHERE district = 'Texas';

-- Question #2
SELECT first_name, last_name, amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

-- Question #3
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);

-- Question #4
SELECT first_name, last_name, country.country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

-- Question #5
SELECT staff.staff_id, first_name, last_name, COUNT(amount) AS total_sales
FROM staff
FULL JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY total_sales DESC
LIMIT 1;

-- Question #6
SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating;

-- Question #7
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
	GROUP BY customer_id
	HAVING COUNT(amount) = 1
);

-- Question #8 - How many free rentals did our stores give away?
SELECT COUNT(amount)
FROM payment
WHERE amount = 0
GROUP BY amount;