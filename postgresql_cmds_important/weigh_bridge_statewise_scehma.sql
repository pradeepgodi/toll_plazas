
CREATE TABLE weigh_bridge_statewise (
    name TEXT,
    phone TEXT,
    city TEXT,
    state TEXT,
    pincode TEXT,
    business_status TEXT,
    latitude FLOAT,
    longitude FLOAT,
    formatted_address TEXT,
    place_id TEXT,
    rating TEXT,
    user_ratings_total TEXT
);



ALTER TABLE weigh_bridge_statewise
ADD COLUMN location GEOMETRY(Point, 4326); 
ADD COLUMN capacity TEXT;
ADD COLUMN length TEXT;



UPDATE weigh_bridge_statewise
SET location = ST_SetSRID(
                  ST_MakePoint(
                      longitude::DOUBLE PRECISION,
                      latitude::DOUBLE PRECISION
                  ),
                  4326
              );


SELECT count(*) from weigh_bridge_statewise;

SELECT state,count(*) from weigh_bridge_statewise
group by 1
ORDER by 2 DESC;



-- sample sql query to get the data from weigh_bridge_statewise table
SELECT 
    name,
	phone,
	city,
	formatted_address,
    latitude,
    longitude,
    ST_DistanceSphere(
        ST_MakePoint(longitude, latitude),  -- weigh bridge location from table
        ST_MakePoint(77.594566, 12.971599)  -- current location ( bangalore)
    ) AS distance_meters,
    CASE
        WHEN ST_DistanceSphere(ST_MakePoint(longitude, latitude), ST_MakePoint(77.594566, 12.971599)) <= 10000 THEN 'Within 10 km'
        WHEN ST_DistanceSphere(ST_MakePoint(longitude, latitude), ST_MakePoint(77.594566, 12.971599)) <= 20000 THEN 'Within 20 km'
        WHEN ST_DistanceSphere(ST_MakePoint(longitude, latitude), ST_MakePoint(77.594566, 12.971599)) <= 30000 THEN 'Within 30 km'
        WHEN ST_DistanceSphere(ST_MakePoint(longitude, latitude), ST_MakePoint(77.594566, 12.971599)) <= 40000 THEN 'Within 40 km'
        WHEN ST_DistanceSphere(ST_MakePoint(longitude, latitude), ST_MakePoint(77.594566, 12.971599)) <= 50000 THEN 'Within 50 km'
        ELSE NULL
    END AS distance_bucket
FROM weigh_bridge_statewise
WHERE ST_DistanceSphere(ST_MakePoint(longitude, latitude), ST_MakePoint(77.594566, 12.971599)) <= 50000
ORDER BY distance_meters;