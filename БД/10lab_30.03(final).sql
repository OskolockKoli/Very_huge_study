INSERT INTO floor (floor_number) VALUES
(1), (2), (3), (4), (5);

INSERT INTO flat (number_of_rooms, area, living_space, floor_id) VALUES
(3, 80.5, 60.2, 1), (2, 65.2, 45.7, 1), (1, 40.1, 30.8, 2),
(4, 95.3, 70.1, 4), (3, 75.8, 55.4, 5);

INSERT INTO c_p (number_of_rooms, area, living_space, floor_id, is_c_p) VALUES
(3, 80.6, 60.3, 1, true);

INSERT INTO owner (owner_init) VALUES
(ROW('Иванов', 'Иван', 'Иванович')), (ROW('Петрова', 'Мария', 'Сергеевна')),
(ROW('Смирнов', 'Алексей', 'Владимирович'));

INSERT INTO owner_flat (owner_id, flat_id) VALUES
(1, 1), (2, 2), (1, 3), (1, 4), (3, 5);

INSERT INTO meter_type (meter_name) VALUES
('Газ'), ('Вода');

INSERT INTO meter (flat_id, meter_type_id) VALUES
(1, 1), (1, 2), (2, 2), (3, 1);

INSERT INTO meter_data (value, m_date, meter_id) VALUES
(1500, '2023-04-01', 1), (2200, '2023-04-01', 2), (1800, '2023-04-01', 3),
(1200, '2023-04-01', 4);

--

SELECT c.*
FROM c_p c
WHERE c.is_c_p = true;

SELECT f.flat_id, f.number_of_rooms, f.area, f.living_space
FROM only flat f
WHERE f.living_space > 50
ORDER BY f.living_space;

SELECT f.flat_id, f.number_of_rooms, f.area, f.living_space
FROM flat f
WHERE f.living_space > 50
ORDER BY f.living_space;

CREATE FUNCTION calc_dead_area(flat_area numeric, living_area numeric)
RETURNS numeric
AS $$
BEGIN
    RETURN flat_area - living_area;
END;
$$ LANGUAGE plpgsql;

CREATE OPERATOR @@ (
    LEFTARG = numeric,
    RIGHTARG = numeric,
    PROCEDURE = calc_dead_area
);

SELECT flat_id, number_of_rooms, area, living_space, area @@ living_space AS dead_area
FROM flat;

CREATE FUNCTION initials_agg_state(agg_state initials[], rec initials)
--initials - используются для накопления промежуточных результатов на каждом шаге агрегации
--(здесь используются для накопления инициалов)
   RETURNS initials[]
   AS $$
   BEGIN
      IF rec.surname IS NOT NULL AND rec.name IS NOT NULL AND rec.patronym IS NOT NULL THEN
         RETURN agg_state || rec;
      ELSE
         RETURN agg_state;
      END IF;
   END;
$$ LANGUAGE plpgsql;

CREATE AGGREGATE initials_agg(initials)
(
   sfunc = initials_agg_state,
   stype = initials[],
--initcond - начальное значение данных состояния, с которым начинает работу агрегатная функция 
--(в данном случае начальное состояние будет пустым массивом)
   initcond = '{}'
);

SELECT initials_agg(owner_init) AS owner_initials
FROM owner;
