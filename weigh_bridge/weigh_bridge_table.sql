SELECT * from weigh_bridge_statewise limit 5;

SELECT count(*) from weigh_bridge_statewise;

DELETE from weigh_bridge_statewise;

UPDATE weigh_bridge_statewise
SET location = ST_SetSRID(
                  ST_MakePoint(
                      longitude::DOUBLE PRECISION,
                      latitude::DOUBLE PRECISION
                  ),
                  4326
              );