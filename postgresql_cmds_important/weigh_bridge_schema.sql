CREATE TABLE test_weigh_bridge (
    no TEXT,
    name TEXT,
    place TEXT,
    mobile TEXT,
     latitude FLOAT,
    longitude FLOAT,
    capacity TEXT,
    length TEXT,
    pin  TEXT);
	
	
	
	
ALTER TABLE test_weigh_bridge
ADD COLUMN location GEOMETRY(Point, 4326); 


UPDATE test_weigh_bridge
SET location = ST_SetSRID(
                  ST_MakePoint(
                      longitude::DOUBLE PRECISION,
                      latitude::DOUBLE PRECISION
                  ),
                  4326
              );