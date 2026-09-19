create or replace table test.gcp_costs as
select --* 
    creation_time
  , user_email
  , job_id
  , job_type
  , state
  , statement_type
  , total_bytes_billed
  , round(total_bytes_billed * 0.00000000093132, 6) as Gibibyte_GB
  , round(total_bytes_billed * 0.00000000000090949, 6) as Tebibyte_TB
  -- Belgium (europe-west1):
  -- 0 tebibyte to 1 tebibyte -- Free per 1 month / account -- will need to apply later
  -- 1 tebibyte and above     -- $7.50 / 1 tebibyte, per 1 month / account -- ~6.54 EUR
  -- check the latest here - https://cloud.google.com/bigquery/pricing
  , round(total_bytes_billed * 0.00000000000090949 * 6.54, 6) as estimated_costs_eur
from `cybercrime-gcp-e785`.`region-europe-west1`.INFORMATION_SCHEMA.JOBS
where 1=1
  and creation_time >= "2026-09-01"
  and creation_time <  "2026-09-19"
  and project_id = "<project_id>"
