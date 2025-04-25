--Pre-requisite
-- 1) table schema is created
-- 2) table "toll_plaza" is created with valid rows, including latitude and longitude information
-- 3) Run B and C

--A] To enable Geospatial data install the below extension after "Application Stackbuilder" is installed
-- https://www.bostongis.com/PrinterFriendly.aspx?content_name=postgis_tut01
CREATE EXTENSION IF NOT EXISTS postgis;

-- B] Add new column location of geometry data type
-- SRID: 4326 (WGS 84 – standard for GPS coordinates)
ALTER TABLE toll_plaza
ADD COLUMN location GEOMETRY(Point, 4326); 

-- C] Insert values into the location columns
UPDATE toll_plaza
SET location = ST_SetSRID(
                  ST_MakePoint(
                      longitude::DOUBLE PRECISION,
                      latitude::DOUBLE PRECISION
                  ),
                  4326
              );


-- Testing table 
select * from toll_plaza limit 5;
select state,toll_plaza_name, latitude,longitude,location from toll_plaza limit 5
