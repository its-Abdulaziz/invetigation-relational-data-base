/*

Query for question 1 set 1

*/
SELECT category_name,
       count(counter) rental_count
FROM
  (SELECT f.title film_title,
          c.name category_name,
          r.rental_id counter
   FROM film_category ca
   JOIN category c ON ca.category_id = c.category_id
   JOIN film f ON ca.film_id = f.film_id
   JOIN inventory i ON f.film_id = i.film_id
   JOIN rental r ON r.inventory_id = i.inventory_id) t1
WHERE category_name = 'Animation'
  OR category_name = 'Classics'
  OR category_name = 'Comedy'
  OR category_name = 'Family'
  OR category_name = 'Music'
  OR category_name = 'Children'
GROUP BY 1
ORDER BY 1;

---------------------------------------------------
 /*

Query for question 2 set 1

*/
SELECT DISTINCT namee,
                rental_duration,
                NTILE(4) over(
                              ORDER BY rental_duration) AS standard_duration
FROM
  (SELECT c.name AS namee,
          SUM(f.rental_duration)AS rental_duration
   FROM film f
   JOIN film_category fc ON f.film_id = fc.film_id
   JOIN category c ON fc.category_id = c.category_id
   WHERE c.name IN ('Animation',
                    'Classics',
                    'Comedy',
                    'Family',
                    'Music',
                    'Children')
   GROUP BY 1) t1
ORDER BY 3;
---------------------------------------------------
 /*

Query for question 3 set 1

*/
SELECT namee,
       t1.standard_duration,
       count(*)
FROM
  (SELECT c.name namee,
          NTILE(4) over(
                        ORDER BY f.rental_duration) AS standard_duration
   FROM film f
   JOIN film_category fc ON f.film_id = fc.film_id
   JOIN category c ON fc.category_id = c.category_id
   WHERE c.name IN ('Animation',
                   'Classics',
                   'Comedy',
                   'Family',
                   'Music',
                   'Children')) t1
GROUP BY 1,
         2
ORDER BY 1,
         2; 
---------------------------------------------------
 /*

Query for question 1 set 2

*/
SELECT DATE_part('month', r.rental_date) AS rental_month,
       DATE_part('year', r.rental_date) rental_year,
       st.store_id,
       count(*) AS count_rentals
FROM rental r
JOIN staff s ON r.staff_id = s.staff_id
JOIN store st ON s.store_id = st.store_id
GROUP BY 1,
         2,
         3
ORDER BY 4 DESC;

---------------------------------------------------
