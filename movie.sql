


use mavenmovies;

-- select * from rental;
-- select * from inventory;

select  first_name, last_name,email  from customer ;
/*
    FILEPATH: /C:/Users/91909/Desktop/my work/mysql/movie.sql
    
    This SQL query selects distinct values of the first_name, last_name, and email columns from the customer table.
*/
select DISTINCT first_name, last_name, email from customer;
/*
    Retrieves the distinct rental durations from the film table.

    Returns:
    - rental_duration: The distinct rental durations from the film table.

    Example Usage:
    select DISTINCT rental_duration from film;
*/
select DISTINCT rental_duration from film;

-- This query selects the customer ID, rental ID, amount, and payment date from the payment table.
-- It retrieves records where the payment date is between '2005-02-07' and '2006-02-15'.

SELECT customer_id, rental_id, amount, payment_date
FROM payment
WHERE payment_date BETWEEN '2005-02-07' AND '2006-02-15';

-- This query selects the customer_id, rental_id, amount, and payment_date from the payment table
-- for customers with a customer_id less than or equal to 100.

SELECT customer_id, rental_id, amount, payment_date
FROM payment
WHERE customer_id <= 100;


-- This query selects the customer_id, rental_id, amount, and payment_date from the payment table.
-- It retrieves rows where the amount is equal to 0.99 and the payment_date is greater than '2006-01-01'.

SELECT customer_id, rental_id, amount, payment_date
FROM payment
WHERE amount = 0.99 AND payment_date > '2006-01-01';


-- Retrieves payment information for customers with IDs less than or equal to 100,
-- payment amounts greater than 5, and payment dates after January 1, 2006.
SELECT customer_id, rental_id, amount, payment_date
FROM payment
WHERE customer_id <= 100
    AND amount > 5
    AND payment_date > '2006-01-01';

/*
    Retrieves payment details for customers with specific IDs.
    
    Parameters:
        - customer_id: The ID of the customer.
    
    Returns:
        - customer_id: The ID of the customer.
        - rental_id: The ID of the rental.
        - amount: The payment amount.
        - payment_date: The date of the payment.
*/
select customer_id, rental_id, amount, payment_date 
from payment 
where customer_id = 5 or customer_id = 11 or customer_id = 29;

select customer_id, rental_id, amount, payment_date
from payment
where customer_id in (5, 11, 29);


/*
    FILEPATH: /C:/Users/91909/Desktop/my work/mysql/movie.sql
    
    This SQL query selects the title and description from the 'film' table where the description contains the word 'dentist'. The '%' symbol is a wildcard character that matches any sequence of characters.

*/
SELECT title, description FROM film WHERE description LIKE "%dentist%";

/**
 * This SQL script is used to perform operations related to movies.
 * It contains various queries for creating, updating, and retrieving movie data.
 * The script is designed to be executed on a MySQL database.
 *

 */
/**
 * Retrieves the title and special features of films that have "behind the scenes" as one of their special features.
 *
 * @return A result set containing the title and special features of the matching films.
 */
SELECT title, special_features FROM film WHERE special_features LIKE "%behind the scenes%";



/**
 * The GROUP BY clause is used in SQL to group rows based on one or more columns.
 * It is typically used in conjunction with aggregate functions like COUNT, SUM, AVG, etc.
 * The GROUP BY clause divides the result set into groups based on the specified columns,
 * and then applies the aggregate function to each group separately.
 *
 * Usage:
 * SELECT column1, aggregate_function(column2)
 * FROM table_name
 * GROUP BY column1;
 *
 * Example:
 * Suppose we have a table called 'orders' with columns 'customer_id' and 'order_total'.
 * To calculate the total order amount for each customer, we can use the GROUP BY clause as follows:
 *
 * SELECT customer_id, SUM(order_total) AS total_amount
 * FROM orders
 * GROUP BY customer_id;
 *
 * This will give us the total order amount for each customer in the 'orders' table.
 */


/**
 * Retrieves the count of film IDs grouped by rating from the film table.
 *
 * @return The count of film IDs grouped by rating.
 */
 
-- USE database_name; -- Replace 'database_name' with the actual name of the database you want to use.
--  * @return A result set containing the rating and the count of film IDs.
--  */
 select rating, COUNT(film_id) 
    from film   
    group by rating;

/**
 * Retrieves the count of films for each rating in the film table.
 *
 * @return A result set containing the rating, the count of films with that rating,
 *         and the count of films with that rating (aliased as films_with_this_rating).
 */
SELECT rating, COUNT(film_id), COUNT(film_id) as films_with_this_rating
FROM film
GROUP BY rating;

/**
 * Retrieves the count of films for each rental duration in the film table.
 *
 * @return A result set containing the rental duration, the count of films with that duration,
 *         and the count of films with that duration (aliased as films_with_this_duration).
 */

select rental_duration, count(film_id) as films_with_this_duration
from film
group by rental_duration;




-- This query retrieves the rating, rental duration, and the count of films for each combination of rating and rental duration from the film table.

SELECT rating, rental_duration, COUNT(film_id) AS count_of_films
FROM film
GROUP BY rating, rental_duration;



/**
 * Retrieves statistics about films based on their ratings.
 *
 * @param rating The rating of the films.
 * @return A result set containing the count of films, shortest film length, longest film length, average film length, and total film length for each rating.
 */
select rating,count(film_id) as count_of_films,
min(LENGTH) as shortest_film,
max(LENGTH) as longest_film,
avg(LENGTH) as average_film_length,
sum(LENGTH) as total_film_length
from film
group by rating;


/*
    This SQL query retrieves various statistics related to the rental rates of films, grouped by their replacement cost.
    It calculates the count of films, minimum rental rate, maximum rental rate, average rental rate, and total rental rate for each replacement cost category.
    The query is performed on the 'film' table.
*/
SELECT replacement_cost, COUNT(film_id) AS count_of_films,
min(rental_rate) AS min_rental_rate,
max(rental_rate) AS max_rental_rate,
avg(rental_rate) AS avg_rental_rate,
sum(rental_rate) AS total_rental_rate
FROM film
GROUP BY replacement_cost;




/*
 * This query demonstrates the usage of the HAVING clause in SQL.
 * The HAVING clause is used to filter the results of a GROUP BY query based on a condition.
 * It is similar to the WHERE clause, but operates on the grouped results rather than individual rows.
 *
 * Syntax:
 * SELECT column1, column2, ...
 * FROM table
 * GROUP BY column1, column2, ...
 * HAVING condition;
 *
 * Example:
 * Consider a table called 'orders' with columns 'customer_id' and 'total_amount'.
 * We want to find the total amount of orders for each customer, but only include customers
 * who have placed orders with a total amount greater than 1000.
 *
 * SELECT customer_id, SUM(total_amount) AS total_orders
 * FROM orders
 * GROUP BY customer_id
 * HAVING SUM(total_amount) > 1000;
 *
 * This query will return the customer_id and total_orders for customers who have placed
 * orders with a total amount greater than 1000.
 */


/*
    This SQL query retrieves the customer IDs and the total number of rentals for each customer from the 'rental' table.
    It groups the results by customer ID and filters the results to only include customers who have rented at least 30 times.
    The query is executed on the 'rental' table in the 'movie' database.
*/
SELECT
    customer_id,
    COUNT(*) AS total_rentals
FROM rental
GROUP BY customer_id
HAVING count(*) >= 30;



/*
    This query selects the customer ID and the total number of rentals for each customer from the 'rental' table.
    It groups the results by customer ID and filters the results to only include customers who have rented less than 15 times.
*/

SELECT customer_id, COUNT(*) AS total_rentals
FROM rental
GROUP BY customer_id 
HAVING COUNT(*) < 15;

/*
    Retrieves the customer IDs and the total number of rentals for each customer from the 'rental' table.
    It groups the results by customer ID and filters the results to only include customers who have rented more than 20 times.
*/
SELECT
    customer_id,
    COUNT(*) AS total_rentals
FROM rental
GROUP BY customer_id
HAVING COUNT(*) > 20;

/*
    Retrieves the customer IDs and the total number of rentals for each customer from the 'rental' table.
    It groups the results by customer ID and filters the results to only include customers who have rented exactly 10 times.
*/
SELECT
    customer_id,
    COUNT(*) AS total_rentals
FROM rental
GROUP BY customer_id
HAVING COUNT(*) = 10;

/*
    Retrieves the customer IDs and the total number of rentals for each customer from the 'rental' table.
    It groups the results by customer ID and filters the results to only include customers who have rented between 5 and 15 times.
*/
SELECT
    customer_id,
    COUNT(*) AS total_rentals
FROM rental
GROUP BY customer_id
HAVING COUNT(*) BETWEEN 5 AND 15;

/*
    Retrieves the customer IDs and the total number of rentals for each customer from the 'rental' table.
    It groups the results by customer ID and filters the results to only include customers who have rented more than 10 times and less than 30 times.
*/
SELECT
    customer_id,
    COUNT(*) AS total_rentals
FROM rental
GROUP BY customer_id
HAVING COUNT(*) > 10 AND COUNT(*) < 30;






/*
    The ORDER BY clause is used in SQL to sort the result set of a query in ascending or descending order based on one or more columns. It is commonly used to organize the data in a meaningful way and make it easier to analyze or present.

    Syntax:
    SELECT column1, column2, ...
    FROM table_name
    ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ...

    - column1, column2, ...: The columns to be selected from the table.
    - table_name: The name of the table from which the data is retrieved.
    - ASC: Optional keyword to sort the result set in ascending order (default).
    - DESC: Optional keyword to sort the result set in descending order.

    Examples:
    1. Sort employees by their last name in ascending order:
        SELECT * FROM employees
        ORDER BY last_name ASC;

    2. Sort products by their price in descending order:
        SELECT * FROM products
        ORDER BY price DESC;

    3. Sort students by their age in ascending order, and then by their name in descending order:
        SELECT * FROM students
        ORDER BY age ASC, name DESC;

    4. Sort orders by their order date in descending order:
        SELECT * FROM orders
        ORDER BY order_date DESC;

    5. Sort books by their publication year in ascending order, and then by their title in ascending order:
        SELECT * FROM books
        ORDER BY publication_year ASC, title ASC;
*/
/*
This code demonstrates the usage of the ORDER BY clause in SQL queries. The ORDER BY clause is used to sort the result set based on one or more columns in ascending or descending order.

Why use ORDER BY:
- To sort the result set in a specific order.
- To organize the data in a meaningful way for better analysis and presentation.
- To retrieve the top or bottom records based on certain criteria.

When to use ORDER BY:
- When you want to sort the result set based on one or more columns.
- When you want to retrieve the records in a specific order.
- When you want to retrieve the top or bottom records based on certain criteria.

Examples of using ORDER BY:

1. Sorting by a single column in ascending order:
    SELECT * FROM table_name ORDER BY column_name ASC;

2. Sorting by a single column in descending order:
    SELECT * FROM table_name ORDER BY column_name DESC;

3. Sorting by multiple columns in ascending order:
    SELECT * FROM table_name ORDER BY column1 ASC, column2 ASC;

4. Sorting by multiple columns with different sort orders:
    SELECT * FROM table_name ORDER BY column1 ASC, column2 DESC;

5. Retrieving the top N records based on a column:
    SELECT * FROM table_name ORDER BY column_name DESC LIMIT N;
*/


/*
    Retrieves customer ID, rental ID, amount, and payment date from the payment table.
    The result is ordered in descending order based on the amount.
*/

SELECT customer_id, rental_id, amount, payment_date
FROM payment
ORDER BY amount DESC;

/*
    Retrieves customer ID, rental ID, amount, and payment date from the payment table.
    The result is ordered in ascending order based on the amount.
*/

SELECT customer_id, rental_id, amount, payment_date
FROM payment
ORDER BY amount ASC;

/*
    Retrieves customer ID, rental ID, amount, and payment date from the payment table.
    The result is ordered in descending order based on the payment date.
*/

SELECT customer_id, rental_id, amount, payment_date
FROM payment
ORDER BY payment_date DESC;

/*
    Retrieves customer ID, rental ID, amount, and payment date from the payment table.
    The result is ordered in ascending order based on the payment date.
*/

SELECT customer_id, rental_id, amount, payment_date
FROM payment
ORDER BY payment_date ASC;

/*
    Retrieves customer ID, rental ID, amount, and payment date from the payment table.
    The result is ordered in descending order based on the rental ID.
*/

SELECT customer_id, rental_id, amount, payment_date
FROM payment
ORDER BY rental_id DESC;

/*
    Retrieves customer ID, rental ID, amount, and payment date from the payment table.
    The result is ordered in descending order based on the amount.
*/

SELECT customer_id, rental_id, amount, payment_date
FROM payment
ORDER BY amount DESC;

/*
    This query selects the title, length, and rental rate of films from the 'film' table.
    The films are ordered in descending order based on their length.
*/

SELECT title, LENGTH, rental_rate
FROM film
ORDER BY length DESC;


/* 
In MySQL, the `CASE` statement is a control flow statement that allows you to perform conditional operations based on one or more conditions. It is similar to the `if...else` statement in other programming languages.

The primary reasons for using the `CASE` statement are:

1. **Data Transformation**: The `CASE` statement is commonly used to transform data based on specific conditions. It allows you to map one set of values to another set of values.

2. **Conditional Filtering**: You can use the `CASE` statement in combination with the `WHERE` clause to filter data based on complex conditions.

3. **Readability**: For complex conditional logic, using a `CASE` statement can make your SQL queries more readable and easier to maintain compared to nested `IF` statements.

The `CASE` statement has two syntaxes:

1. **Simple CASE Syntax**:

```sql
CASE value
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE result_else
END
```

In the simple `CASE` syntax, the `value` is compared with each `condition` in the order they are written. When a match is found, the corresponding `result` is returned. If no match is found, the `ELSE` result (if provided) is returned.

2. **Searched CASE Syntax**:

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE result_else
END
```

In the searched `CASE` syntax, each `condition` is evaluated in the order they are written, and the first condition that evaluates to `true` determines the `result` to be returned. If no condition is met, the `ELSE` result (if provided) is returned.

Here are some examples to illustrate the usage of the `CASE` statement:

**Example 1: Data Transformation**

```sql
SELECT
    product_name,
    CASE product_category
        WHEN 'Electronics' THEN 'Tech'
        WHEN 'Clothing' THEN 'Fashion'
        ELSE 'Other'
    END AS category_group
FROM products;
```

This query transforms the `product_category` values into a new set of values ('Tech', 'Fashion', 'Other') based on the conditions specified in the `CASE` statement.

**Example 2: Conditional Filtering**

```sql
SELECT
    order_id,
    order_status,
    CASE
        WHEN order_status = 'Shipped' THEN shipped_date
        WHEN order_status = 'Delivered' THEN delivered_date
        ELSE NULL
    END AS status_date
FROM orders
WHERE
    CASE
        WHEN order_status = 'Shipped' OR order_status = 'Delivered' THEN TRUE
        ELSE FALSE
    END;
```

In this example, the `CASE` statement is used in both the `SELECT` and `WHERE` clauses. The `SELECT` clause retrieves the `order_id`, `order_status`, and a calculated `status_date` based on the `order_status`. The `WHERE` clause filters the records where the `order_status` is either 'Shipped' or 'Delivered'.

The `CASE` statement is a powerful tool in MySQL that allows you to perform conditional operations and data transformations within your SQL queries. It can greatly simplify complex conditional logic and improve the readability of your code.
 */


/*
    This SQL query selects distinct film lengths from the 'film' table and categorizes them into three categories: 'Short', 'Medium', and 'Long'. The categorization is based on the length of the film in minutes.

    Parameters:
        - None

    Returns:
        - A result set with two columns: 'length' and 'film_length_category'
            - 'length': The distinct film lengths in minutes
            - 'film_length_category': The category of the film length ('Short', 'Medium', or 'Long')

    Example usage:
        SELECT DISTINCT
            length,
            CASE
                WHEN length < 60 THEN 'Short'
                WHEN length >= 60 AND length < 120 THEN 'Medium'
                ELSE 'Long'
            END AS film_length_category
        FROM film;
*/
        SELECT DISTINCT
            length,
            CASE
                WHEN length < 60 THEN 'Short'
                WHEN length >= 60 AND length < 120 THEN 'Medium'
                ELSE 'Long'
            END AS film_length_category
        FROM film;


/**
 * This SQL query selects distinct movie titles from the 'film' table and categorizes them based on certain conditions.
 * The 'fit_for_recommendation' column is added to indicate the suitability of each movie for recommendation.
 * 
 * Conditions:
 * - If the rental duration is less than or equal to 4, the movie is categorized as 'Short'.
 * - If the rental rate is greater than 5, the movie is categorized as 'Expensive'.
 * - If the rating is either 'NC-17' or 'R', the movie is categorized as 'Adult'.
 * - If the length of the movie is not between 60 and 90 minutes, the movie is categorized as 'Too Short or Too Long'.
 * - If the movie description contains the word 'shark', the movie is categorized as 'Shark'.
 * - For all other movies, the category is set as 'Normal'.
 * 
 * @return A result set containing the distinct movie titles and their corresponding categories.
 */
SELECT DISTINCT title,
case
when rental_duration <= 4 then 'Short'
when rental_rate > 5 then 'Expensive'
WHEN rating  in ("NC-17","R") then 'Adult'
WHEN LENGTH not BETWEEN 60 AND 90 THEN "tooshort or to long"
when DESCRIPTION like "%shark%" then "shark"
ELSE "Normal"
END as fit_for_recommendation
from film;



/*
    This SQL query selects the first name, last name, and store status of customers from the 'customer' table.
    The 'CASE' statement is used to determine the store status based on the values of 'store_id' and 'active' columns.
    If 'store_id' is equal to 1 and 'active' is equal to 1, the store status is set to 'store 1 active'.
    If 'store_id' is equal to 1 and 'active' is equal to 0, the store status is set to 'store 1 inactive'.
    If 'store_id' is equal to 2 and 'active' is equal to 1, the store status is set to 'store 2 active'.
    If 'store_id' is equal to 2 and 'active' is equal to 0, the store status is set to 'store 2 inactive'.
    If none of the above conditions are met, the store status is set to 'oops, check logic'.
    The result of the query includes the first name, last name, and store status for each customer.
*/
SELECT
    first_name,
    last_name,
    CASE
        WHEN store_id = 1 AND active = 1 THEN 'store 1 active'
        WHEN store_id = 1 AND active = 0 THEN 'store 1 inactive'
        WHEN store_id = 2 AND active = 1 THEN 'store 2 active'
        WHEN store_id = 2 AND active = 0 THEN 'store 2 inactive'
        ELSE 'oops, check logic'
    END AS store_and_status
FROM customer;



/**
 * Retrieves the film inventory information from the 'inventory' table.
 * The query counts the number of copies of each film in two different stores (store 1 and store 2),
 * as well as the total number of copies across all stores.
 * The result is grouped by film_id and ordered by film_id.
 *
 * @return The film_id, store_1_copies, store_2_copies, and total_copies for each film in the inventory.
 */
SELECT
    film_id,
    COUNT(CASE WHEN store_id = 1 THEN inventory_id ELSE NULL END) AS store_1_copies,
    COUNT(CASE WHEN store_id = 2 THEN inventory_id ELSE NULL END) AS store_2_copies,
    COUNT(inventory_id) AS total_copies
FROM inventory
GROUP BY
    film_id
ORDER BY
    film_id;

    /*
        This SQL query retrieves the first name, last name, and store status of customers from the 'customer' table.
        The 'CASE' statement is used to determine the store status based on the 'store_id' and 'active' columns.
        If the 'store_id' is 1 and 'active' is 1, the store status is set to 'store 1 active'.
        If the 'store_id' is 1 and 'active' is 0, the store status is set to 'store 1 inactive'.
        If the 'store_id' is 2 and 'active' is 1, the store status is set to 'store 2 active'.
        If the 'store_id' is 2 and 'active' is 0, the store status is set to 'store 2 inactive'.
        If none of the above conditions are met, the store status is set to 'oops, check logic!'.
        The result set includes the first name, last name, and store status for each customer.
    */
    SELECT
        first_name,
        last_name,
        CASE
            WHEN store_id = 1 AND active = 1 THEN 'store 1 active'
            WHEN store_id = 1 AND active = 0 THEN 'store 1 inactive'
            WHEN store_id = 2 AND active = 1 THEN 'store 2 active'
            WHEN store_id = 2 AND active = 0 THEN 'store 2 inactive'
            ELSE 'oops, check logic!'
        END AS store_and_status
    FROM customer
