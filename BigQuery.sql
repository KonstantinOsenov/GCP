-- Create a scheduled query
--create or replace table DatasetName.TableName1 as
insert DatasetName.TableName
SELECT --*
  attr1, attr2, 
  count(attr3) as metric1
FROM `ProjectName.DatasetName.TableName2` 
WHERE 1=1
  --and TIMESTAMP_TRUNC(Timestamp, DAY) >= TIMESTAMP("2026-07-01")
  and date(timestamp) >= CURRENT_DATE()-1 
  and date(timestamp) < CURRENT_DATE()
group by
  attr1, attr2
