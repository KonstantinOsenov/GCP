--- get all column names from bigquery table

SELECT column_name
FROM <PROJECT_NAME>.<DATASET_NAME>.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = '<TABLE_NAME>'

-- get all table names from bigquery dataset

SELECT distinct CONCAT(table_catalog, table_schema, table_name) as table_name
FROM <PROJECT_NAME>.<DATASET_NAME>.INFORMATION_SCHEMA.TABLES

-- job info bigquery
SELECT *
  -- job_id, 
  -- search_statistics.index_usage_mode, 
  -- unused_reason.code, 
  -- unused_reason.message
FROM `<PROJECT_NAME>`.`region-europe-west1`.INFORMATION_SCHEMA.JOBS,
UNNEST(search_statistics.index_unused_reasons) AS unused_reason
WHERE 1=1
  and creation_time >= "2026-10-09"
  --and project_id = "cybercrime-gcp-e785"
  and job_id = '<job_id>';



  SELECT 
  table_name, 
  index_name, 
  index_status, 
  coverage_percentage 
  , total_storage_bytes
  , total_storage_bytes / 1024 / 1024 / 1024 as total_storage_GB
FROM 
  `<PROJECT_NAME>.<DATASET_NAME>.INFORMATION_SCHEMA.SEARCH_INDEXES`;
