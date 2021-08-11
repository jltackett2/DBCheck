-- 1. All of the vacation destinations.
SELECT name from destination;

 id |       name       | average_temp | cost_of_flight | has_beach | has_mountains 
----+------------------+--------------+----------------+-----------+---------------
  1 | Thailand         |           82 |            765 | t         | t
  2 | Minnesota        |           41 |            235 | f         | f
  3 | New Zealand      |           66 |            433 | t         | t
  4 | England          |           45 |            290 | f         | f
  5 | Tristan da Cunha |           59 |           1304 | t         | t
(5 rows)

-- 2. All destinations where you can swim at the beach.
SELECT * FROM destinations WHERE has_beach = true;

 id |       name       | average_temp | cost_of_flight | has_beach | has_mountains 
----+------------------+--------------+----------------+-----------+---------------
  1 | Thailand         |           82 |            765 | t         | t
  3 | New Zealand      |           66 |            433 | t         | t
  5 | Tristan da Cunha |           59 |           1304 | t         | t
(3 rows)

-- 3. All destinations where the average temperature is over 60 degrees.
SELECT * from destinations WHERE average_temp > 60; 

id |    name     | average_temp | cost_of_flight | has_beach | has_mountains 
----+-------------+--------------+----------------+-----------+---------------
  1 | Thailand    |           82 |            765 | t         | t
  3 | New Zealand |           66 |            433 | t         | t
(2 rows)

-- 4. All destinations where you can swim at the beach AND go to the mountains.
SELECT * FROM destinations WHERE has_beach = true AND has_mountains = true;

 id |       name       | average_temp | cost_of_flight | has_beach | has_mountains 
----+------------------+--------------+----------------+-----------+---------------
  1 | Thailand         |           82 |            765 | t         | t
  3 | New Zealand      |           66 |            433 | t         | t
  5 | Tristan da Cunha |           59 |           1304 | t         | t

-- 5. All destinations where flights cost less than $500 and you can hike in the mountains.
SELECT * FROM destinations WHERE has_mountains = true AND cost_of_flight < 500;

 id |    name     | average_temp | cost_of_flight | has_beach | has_mountains 
----+-------------+--------------+----------------+-----------+---------------
  3 | New Zealand |           66 |            433 | t         | t
(1 row)

-- 6. Add an entry for The Bahamas, where the average temperature is 78, it has beaches but no mountains, and the flights cost $345.
INSERT INTO destinations (name, average_temp, cost_of_flight, has_beach, has_mountains) VALUES ('Bahamas', 78, 345, true, false);

 id |       name       | average_temp | cost_of_flight | has_beach | has_mountains 
----+------------------+--------------+----------------+-----------+---------------
  1 | Thailand         |           82 |            765 | t         | t
  2 | Minnesota        |           41 |            235 | f         | f
  3 | New Zealand      |           66 |            433 | t         | t
  4 | England          |           45 |            290 | f         | f
  5 | Tristan da Cunha |           59 |           1304 | t         | t
  6 | Bahamas          |           78 |            345 | t         | f
(6 rows)

-- 7. Turns out, the cost of flights to New Zealand has increased! Update New Zealand's entry for flight cost to $1000.
UPDATE destinations SET cost_of_flight = 1000 WHERE name = 'New Zealand'; 

 id |       name       | average_temp | cost_of_flight | has_beach | has_mountains 
----+------------------+--------------+----------------+-----------+---------------
  1 | Thailand         |           82 |            765 | t         | t
  2 | Minnesota        |           41 |            235 | f         | f
  4 | England          |           45 |            290 | f         | f
  5 | Tristan da Cunha |           59 |           1304 | t         | t
  6 | Bahamas          |           78 |            345 | t         | f
  3 | New Zealand      |           66 |           1000 | t         | t
(6 rows)

--8. Turns out, Minnesota isn't a vacation destination. Please delete it from the database.
DELETE FROM destinations WHERE name = 'Minnesota';

 id |       name       | average_temp | cost_of_flight | has_beach | has_mountains 
----+------------------+--------------+----------------+-----------+---------------
  1 | Thailand         |           82 |            765 | t         | t
  4 | England          |           45 |            290 | f         | f
  5 | Tristan da Cunha |           59 |           1304 | t         | t
  6 | Bahamas          |           78 |            345 | t         | f
  3 | New Zealand      |           66 |           1000 | t         | t

--9. When the data set was written, the author mistakently wrote "England" \
--when they actually meant "Scotland". Please update that entry in the database.

UPDATE destinations SET name = 'Scotland' WHERE name ='England';

id |       name       | average_temp | cost_of_flight | has_beach | has_mountains 
----+------------------+--------------+----------------+-----------+---------------
  1 | Thailand         |           82 |            765 | t         | t
  5 | Tristan da Cunha |           59 |           1304 | t         | t
  6 | Bahamas          |           78 |            345 | t         | f
  3 | New Zealand      |           66 |           1000 | t         | t
  4 | Scotland         |           45 |            290 | f         | f
(5 rows)


--10. Create a join table that joins the airlines and the destinations tables by correlating which airlines fly to which destinations.
CREATE TABLE airline_destinations (airline_id INTEGER, destination_id INTEGER);
ALTER TABLE airline_destinations ADD COLUMN ad_id serial

 airline_id | destination_id | ad_id 
------------+----------------+-------
(0 rows)


ALTER TABLE airline ADD PRIMARY KEY (id); 
ALTER TABLE destination ADD PRIMARY KEY (id); 
-- doesn't really help^
ALTER TABLE "airline_destinations" ADD CONSTRAINT "fk_airline_destinations_airline_id" FOREIGN KEY("airline_id") REFERENCES "airlines" ("id");
ALTER TABLE "airline_destinations" ADD CONSTRAINT "fk_airline_destinations_destination_id" FOREIGN KEY("destination_id") REFERENCES "destinations" ("id");
-- doesn't really help^
 airline_id | destination_id | ad_id 
-- empty table^

-- mannual inserts
INSERT INTO airline_destinations (airline_id, destination_id) VALUES (1, 3);
INSERT INTO airline_destinations (airline_id, destination_id) VALUES (1, 4);
INSERT INTO airline_destinations (airline_id, destination_id) VALUES (2, 5);
INSERT INTO airline_destinations (airline_id, destination_id) VALUES (2, 4);
INSERT INTO airline_destinations (airline_id, destination_id) VALUES (2, 1);
INSERT INTO airline_destinations (airline_id, destination_id) VALUES (3, 1);
INSERT INTO airline_destinations (airline_id, destination_id) VALUES (3, 4);
INSERT INTO airline_destinations (airline_id, destination_id) VALUES (4, 3);
INSERT INTO airline_destinations (airline_id, destination_id) VALUES (4, 5);

--11. All airlines that fly to New Zealand.
SELECT * FROM airlines WHERE id IN (SELECT airline_id FROM airline_destinations WHERE destination_id IN (SELECT id FROM destinations WHERE name = 'New Zealand')); 

 id |   name    
----+-----------
  4 | Southwest
  1 | Sprint
(2 rows)

--12. All airlines that do NOT fly to Scotland.
SELECT * FROM airlines WHERE id IN (SELECT airline_id FROM airline_destinations WHERE destination_id IN (SELECT id FROM destinations WHERE name != 'Scotland'));
 
 id |   name    
----+-----------
  3 | Delta
  4 | Southwest
  2 | Lufthansa
  1 | Sprint

--13. All of the data for all vacation destinations.
-- SELECT * FROM airlines WHERE id IN (SELECT airline_id FROM airline_destinations WHERE destination_id IN (SELECT id FROM destinations));

SELECT * FROM (destinations INNER JOIN airline_destinations ON destinations.id = airline_destinations.destination_id INNER JOIN airlines ON airlines.id = airline_destinations.airline_id);

 id |       name       | average_temp | cost_of_flight | has_beach | has_mountains | airline_id | destination_id | ad_id | id |   name    
----+------------------+--------------+----------------+-----------+---------------+------------+----------------+-------+----+-----------
  3 | New Zealand      |           66 |           1000 | t         | t             |          1 |              3 |     1 |  1 | Sprint
  4 | Scotland         |           45 |            290 | f         | f             |          1 |              4 |     2 |  1 | Sprint
  5 | Tristan da Cunha |           59 |           1304 | t         | t             |          2 |              5 |     3 |  2 | Lufthansa
  4 | Scotland         |           45 |            290 | f         | f             |          2 |              4 |     4 |  2 | Lufthansa
  1 | Thailand         |           82 |            765 | t         | t             |          2 |              1 |     5 |  2 | Lufthansa
  1 | Thailand         |           82 |            765 | t         | t             |          3 |              1 |     6 |  3 | Delta
  4 | Scotland         |           45 |            290 | f         | f             |          3 |              4 |     7 |  3 | Delta
  3 | New Zealand      |           66 |           1000 | t         | t             |          4 |              3 |     8 |  4 | Southwest
  5 | Tristan da Cunha |           59 |           1304 | t         | t             |          4 |              5 |     9 |  4 | Southwest
(9 rows)