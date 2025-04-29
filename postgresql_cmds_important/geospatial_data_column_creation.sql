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



SELECT * from bunksbuddyproducts limit 10;

-- Nearest location to the given co-ordinates
SELECT city, price, latitude, longitude, 
ST_Distance(location, ST_SetSRID(ST_GeomFromText('POINT(76.7097 28.370)'), 4326)) AS distance
FROM bunksbuddyproducts
ORDER BY distance
LIMIT 1;

-- Nearest location within given distance in meters to the given co-ordinates
SELECT *
FROM bunksbuddyproducts
WHERE ST_DWithin(location, ST_Point(76.7097, 28.370)::GEOGRAPHY, 2000);


-- Nearest toll plaza from the given lat long location

SELECT *
FROM toll_plaza
WHERE ST_DWithin(
    location,
    ST_SetSRID(ST_MakePoint(75.72,14.556), 4326)::geography,1200);



-- Get toll plazas
SELECT toll_plaza_id,toll_plaza_name,state,nh_no,latitude,longitude,address_partial_match,tollable_length,
car_jeep_van_single_journey,car_jeep_van_return_journey,car_jeep_van_monthly_pass,car_jeep_van_commercial_vehicle_reg_in_district,
lcv_single_journey,lcv_return_journey,lcv_monthly_pass,lcv_commercial_vehicle_reg_in_district,
bus_truck_single_journey,bus_truck_return_journey,bus_truck_monthly_pass,bus_truck_commercial_vehicle_reg_in_district,
upto_3_axle_vehicle_single_journey,upto_3_axle_vehicle_return_journey,upto_3_axle_vehicle_monthly_pass,upto_3_axle_vehicle_commercial_vehicle_rreg_in_district,
_4_to_6_axle_single_journey,_4_to_6_axle_return_journey,_4_to_6_axle_monthly_pass,_4_to_6_axle_commercial_vehicle_reg_in_district,hcm_eme_single_journey,
hcm_eme_return_journey,hcm_eme_monthly_pass,hcm_eme_commercial_vehicle_reg_in_district,
_7_or_more_axle_single_journey,_7_or_more_axle_return_journey,_7_or_more_axle_monthly_pass,_7_or_more_axle_commercial_reg_in_district
FROM toll_plaza 
LIMIT 15
