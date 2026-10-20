---- Keep only digits in a string + split the value

-- v1
select REGEXP_REPLACE(cart_id_input, r'[^\d]', '') as cart_id_input_clean from UNNEST(["6080083452PLMASTER"])  as cart_id_input

-- v2
DECLARE cart_id_list_raw            ARRAY<STRING> DEFAULT ["6080083452PLMASTER"];
DECLARE cart_id_list                ARRAY<STRING> DEFAULT ARRAY(
    select REGEXP_REPLACE(cart_id_input, r'[^\d]', '') as cart_id_input_clean from UNNEST(cart_id_list_raw)  as cart_id_input
);
select cart_id_list_raw;
select cart_id_list;

-- v3
DECLARE cart_id_list_raw           STRING DEFAULT """
6080083452PLMASTER
1080083452PLMASTER
333080083452PLMASTER
""";
DECLARE cart_id_list                ARRAY<STRING> DEFAULT ARRAY(
    SELECT TRIM(REGEXP_REPLACE(cart_id_input, r'[^\d]', '')) as cart_id_input_clean from UNNEST(SPLIT(cart_id_list_raw, "\n")) as cart_id_input
    WHERE TRIM(REGEXP_REPLACE(cart_id_input, r'[^\d]', '')) != ""
);
select cart_id_list_raw;
select cart_id_list;

------------------------------------------------------------------------
  
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
