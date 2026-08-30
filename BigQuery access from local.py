#%pip install bigquery

from google.cloud import bigquery
from google.oauth2 import service_account

credentials = service_account.Credentials.from_service_account_file(
r'C:\Users\...\Service account\<service_account_name>.json')

project_id = '<project_name>'
client = bigquery.Client(credentials= credentials,project=project_id)

query_job = client.query("""
   SELECT * FROM `<project_name>.test.test_table` LIMIT 1000
   """)
results = query_job.result() # Wait for the job to complete.

for row in results:
    print(row)
