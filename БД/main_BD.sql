USE BD1;
#SET SQL_SAFE_UPDATES = 0;

#6

SELECT O.* 
FROM owner AS O 
LEFT JOIN owner_flat AS O_F ON O.owner_id = O_F.owner_id
LEFT JOIN flat AS F ON F.flat_id = O_F.flat_id WHERE living_space = (SELECT MIN(ALL living_space) FROM flat);

SELECT FLO.*
FROM floor AS FLO 
LEFT JOIN flat AS FLA ON FLO.floor_id = FLA.floor_id
LEFT JOIN meter AS M ON FLA.flat_id = M.flat_id
GROUP BY FLO.floor_id, FLO.floor_number, FLA.flat_id, FLA.number_of_rooms, FLA.area, FLA.living_space, FLA.floor_id, M.meter_id, M.flat_id, M.meter_type_id
HAVING SUM(M.meter_id) > 1;

Select floor.* 
from floor 
join flat on floor.floor_id = flat.floor_id
where not exists
(select * from meter
where not exists
(Select * from floor as FLO
join flat as FLA on FLO.floor_id = FLA.floor_id
where FLO.floor_id = floor.floor_id and FLA.flat_id = meter.flat_id));

SELECT O.*
FROM owner AS O
JOIN owner_flat AS O_F ON O.owner_id = O_F.owner_id
JOIN flat AS F ON F.flat_id = O_F.flat_id 
WHERE F.number_of_rooms = 1 AND O_F.flat_id NOT IN
(SELECT O_F.flat_id
FROM owner_flat 
JOIN flat ON F.flat_id = O_F.flat_id 
WHERE F.number_of_rooms = 2);
/*
SELECT O.*
FROM owner AS O
JOIN owner_flat AS O_F ON O.owner_id = O_F.owner_id
JOIN flat AS F ON F.flat_id = O_F.flat_id 
WHERE F.number_of_rooms = 1 EXCEPT
SELECT O.*
FROM owner AS O
JOIN owner_flat AS O_F ON O.owner_id = O_F.owner_id
JOIN flat AS F ON F.flat_id = O_F.flat_id 
WHERE F.number_of_rooms = 2;
*/
SELECT O.*
FROM owner AS O
JOIN owner_flat AS O_F ON O.owner_id = O_F.owner_id
JOIN flat AS F ON F.flat_id = O_F.flat_id 
LEFT JOIN
(SELECT O.*
FROM owner AS O
JOIN owner_flat AS O_F ON O.owner_id = O_F.owner_id
JOIN flat AS F ON F.flat_id = O_F.flat_id 
WHERE F.number_of_rooms = 2
)q ON F.flat_id = O_F.flat_id 
WHERE F.number_of_rooms = 1;
