# PostgreSQL 9.3 materialized view concurrently refresh

CREATE TABLE visitors_copy AS (select * from visitors);

BEGIN;
  ALTER MATERIALIZED VIEW visitors RENAME TO visitors_refreshing;  
  ALTER TABLE visitors_copy RENAME TO visitors;
COMMIT;

REFRESH MATERIALIZED VIEW visitors_refreshing;

BEGIN;
  DROP TABLE visitors;
  ALTER MATERIALIZED VIEW visitors_refreshing RENAME TO visitors; 
COMMIT;
