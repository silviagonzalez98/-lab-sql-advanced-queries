USE sakila;
-- 1. List each pair of actors that have worked together.
with X as(
	select a.first_name, a.last_name, a.actor_id, fa.film_id
	from actor a
	join film_actor fa
	on a.actor_id = fa.actor_id
)
select X.first_name, X.last_name, Z.first_name, Z.last_name
from X
join X as Z
on X.first_name <> Z.first_name
and X.film_id = Z.film_id;

-- 2. For each film, list actor that has acted in more films.

select actor_id, film_id
from film_actor;

select actor_id, count(actor_id)
from film_actor
group by actor_id;

select *
from(
select f.film_id, f.actor_id, c.appearances, rank() over(partition by f.film_id order by c.appearances desc) as ranking
from film_actor f
join (select actor_id, count(actor_id) as appearances
from film_actor
group by actor_id) c
on f.actor_id = c.actor_id) sub1
where sub1.ranking=1;