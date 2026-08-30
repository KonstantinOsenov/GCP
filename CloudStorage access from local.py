#%pip install --upgrade google-cloud-storage

import json
import os
from google.cloud import storage
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = r"C:\.../<service_account_name>.json"
# our bucket in GCP
bucket_name = '<bucket_name>'

# instantiate a client
storage_client = storage.Client()
# get bucket
bucket = storage_client.get_bucket(bucket_name)

prefix = 'MO'
prefix = 'MO/20260325/master'
#delimiter = '/'

# get all blobs
blobs = bucket.list_blobs(prefix=prefix)#, delimiter=delimiter)

print('Blobs:')
for blob in blobs:
    print(blob.name)

if delimiter:
    print('Prefixes:')
    for prefix in blobs.prefixes:
        print(prefix)


blob = bucket.get_blob('<file_path_in_the_bucket>')
downloaded_blob = blob.download_as_string()
print(downloaded_blob)

import json
data = json.loads(downloaded_blob)
print("attrName -", json.loads(data["data1"]["data2"])["attrName"])
print("----")
print(data)


######## did not test`?
storage_client = storage.Client()

bucket = storage_client.bucket(bucket_name)

# Construct a client side representation of a blob.
# Note `Bucket.blob` differs from `Bucket.get_blob` as it doesn't retrieve
# any content from Google Cloud Storage. As we don't need additional data,
# using `Bucket.blob` is preferred here.
blob = bucket.blob(blob_name)
contents = blob.download_as_bytes()

print(
    "Downloaded storage object {} from bucket {} as the following bytes object: {}.".format(
        blob_name, bucket_name, contents.decode("utf-8")
    )
)
 
