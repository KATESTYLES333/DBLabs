DROP TABLE IF EXISTS MyTypes;
DROP TYPE IF EXISTS FirInt;
DROP TYPE IF EXISTS SecString;
DROP TYPE IF EXISTS CurrentYear;

CREATE TYPE FirInt FROM INT NULL;
CREATE TYPE SecString FROM VARCHAR(50) NULL;
CREATE TYPE CurrentYear FROM DATETIME NULL;

CREATE TABLE MyTypes (firstint FirInt, secstring SecString, currentyear CurrentYear)

INSERT INTO MyTypes (firstint, secstring, currentyear) values (5, 'A', '11/12/2020')
INSERT INTO MyTypes (firstint, secstring, currentyear) values (-2, 'B', '17/02/1987')