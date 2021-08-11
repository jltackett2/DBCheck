--createdb -U postgres vacations
--psql -U postgres vacations
--\dt - show list with all tables
--\d destinations - columens of table
--\dt+ destinations
--SELECT * from destinations;
--SELECT * from airlines;

CREATE TABLE destinations (id SERIAL, name VARCHAR, average_temp INTEGER, cost_of_flight INTEGER, has_beach BOOLEAN, has_mountains BOOLEAN);
       
INSERT INTO destinations (name, average_temp, cost_of_flight, has_beach, has_mountains) VALUES ('Thailand', 82, 765, true, true);
INSERT INTO destinations (name, average_temp, cost_of_flight, has_beach, has_mountains) VALUES ('Minnesota', 41, 235, false, false);
INSERT INTO destinations (name, average_temp, cost_of_flight, has_beach, has_mountains) VALUES ('New Zealand', 66, 433, true, true);     
INSERT INTO destinations (name, average_temp, cost_of_flight, has_beach, has_mountains) VALUES ('England', 45, 290, false, false);
INSERT INTO destinations (name, average_temp, cost_of_flight, has_beach, has_mountains) VALUES ('Tristan da Cunha', 59, 1304, true, true);      
       
CREATE TABLE airlines (id SERIAL, name VARCHAR);
 
INSERT INTO airlines (name) VALUES ('Sprint');
INSERT INTO airlines (name) VALUES ('Lufthansa');
INSERT INTO airlines (name) VALUES ('Delta');
INSERT INTO airlines (name) VALUES ('Southwest');



    -- name: 'Spirit',
    -- destinations_flown_to: ['New Zealand', 'Scotland']

    -- name: 'Lufthansa',
    -- destinations_flown_to: ['Tristan da Cunha', 'Scotland', 'Thailand']

    -- name: 'Delta',
    -- destinations_flown_to: ['Thailand', 'Minnesota', 'England', 'Scotland']

    -- name: 'Southwest'
    -- destinations_flown_to: ['New Zealeand', 'Tristan de Cunha', 'Minnesota']
