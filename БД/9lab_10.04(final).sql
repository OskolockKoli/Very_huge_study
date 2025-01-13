--CREATE DATABASE db_1;

CREATE TABLE floor(
  floor_id SERIAL NOT NULL PRIMARY KEY,
  floor_number int
);

CREATE TABLE flat(
  flat_id SERIAL NOT NULL PRIMARY KEY,
  number_of_rooms int check(number_of_rooms > 0),
  area numeric check(area > 0),
  living_space numeric check(living_space > 0),
  floor_id int,
  foreign key (floor_id) references floor(floor_id) on delete cascade on update cascade
);

CREATE TABLE c_p (
  primary key (flat_id),  
  foreign key (floor_id) references floor(floor_id) on delete cascade on update cascade,
  is_c_p boolean
) INHERITS (flat);

CREATE TYPE initials AS (
  surname varchar(55),
  name varchar(55),
  patronym varchar(55)
);

CREATE TABLE owner(
  owner_id SERIAL NOT NULL PRIMARY KEY,
  owner_init initials
);

CREATE TABLE owner_flat(
  owner_flat_id SERIAL NOT NULL PRIMARY KEY,
  owner_id int,
  flat_id int,
  foreign key (owner_id) references owner(owner_id) on delete restrict on update restrict
);

CREATE OR REPLACE FUNCTION check_flat_exists_on_create() 
  RETURNS TRIGGER AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM flat WHERE flat_id = NEW.flat_id) THEN
    RAISE EXCEPTION 'flat with id % does not exist', NEW.flat_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER owner_flat_check_flat_exists_on_create
BEFORE INSERT ON owner_flat
FOR EACH ROW
EXECUTE FUNCTION check_flat_exists_on_create();

CREATE OR REPLACE FUNCTION check_flat_exists_on_update() 
  RETURNS TRIGGER AS $$
BEGIN
  IF EXISTS (SELECT 1 FROM owner_flat WHERE flat_id = OLD.flat_id) THEN
    RAISE EXCEPTION 'flat with id % сannot be updated because of owner_flat', OLD.flat_id;
  END IF;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER owner_flat_check_flat_exists_on_update
BEFORE UPDATE ON owner_flat
FOR EACH ROW
EXECUTE FUNCTION check_flat_exists_on_update();

CREATE OR REPLACE FUNCTION check_flat_exists_on_delete() 
  RETURNS TRIGGER AS $$
BEGIN
  IF EXISTS (SELECT 1 FROM owner_flat WHERE flat_id = OLD.flat_id) THEN
    RAISE EXCEPTION 'flat with id % сannot be deleted because of owner_flat', OLD.flat_id;
  END IF;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER owner_flat_check_flat_exists_on_delete
BEFORE DELETE ON owner_flat
FOR EACH ROW
EXECUTE FUNCTION check_flat_exists_on_delete();

CREATE TABLE meter_type(
  meter_type_id SERIAL NOT NULL PRIMARY KEY,
  meter_name varchar(55)
);

CREATE TABLE meter(
  meter_id SERIAL NOT NULL PRIMARY KEY,
  flat_id int,
  meter_type_id int,
  foreign key (meter_type_id) references meter_type(meter_type_id) on delete restrict on update restrict
);

CREATE OR REPLACE FUNCTION check_flat_exists_on_create() 
  RETURNS TRIGGER AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM flat WHERE flat_id = NEW.flat_id) THEN
    RAISE EXCEPTION 'flat with id % does not exist', NEW.flat_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER meter_check_flat_exists_on_create
BEFORE INSERT ON meter
FOR EACH ROW
EXECUTE FUNCTION check_flat_exists_on_create();

CREATE OR REPLACE FUNCTION check_flat_exists_on_update() 
  RETURNS TRIGGER AS $$
BEGIN
  IF EXISTS (SELECT 1 FROM meter WHERE flat_id = OLD.flat_id) THEN
    RAISE EXCEPTION 'flat with id % сannot be updated because of meter', OLD.flat_id;
  END IF;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER meter_check_flat_exists_on_update
BEFORE UPDATE ON flat
FOR EACH ROW
EXECUTE FUNCTION check_flat_exists_on_update();

CREATE OR REPLACE FUNCTION check_flat_exists_on_delete() 
  RETURNS TRIGGER AS $$
BEGIN
  IF EXISTS (SELECT 1 FROM meter WHERE flat_id = OLD.flat_id) THEN
    RAISE EXCEPTION 'flat with id % сannot be deleted because of meter', OLD.flat_id;
  END IF;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER meter_check_flat_exists_on_delete
BEFORE DELETE ON flat
FOR EACH ROW
EXECUTE FUNCTION check_flat_exists_on_delete();

CREATE TABLE meter_data(
  meter_data_id SERIAL NOT NULL PRIMARY KEY,
  value int,
  m_date date,
  meter_id int,
  foreign key (meter_id) references meter(meter_id) on delete cascade on update cascade
);
