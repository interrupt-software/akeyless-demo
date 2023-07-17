from __future__ import print_function
import time
import akeyless
from akeyless.rest import ApiException
from pprint import pprint
import os
import sys

access_id = None
access_key = None

try:
  access_id  = os.environ["AKEYLESS_ACCESS_ID"] 
  access_key = os.environ["AKEYLESS_ACCESS_KEY"]
except:
   print("Cannot find environment credentials.")

configuration = akeyless.Configuration(
        host = "https://api.akeyless.io"
)

api_client = akeyless.ApiClient(configuration)
api = akeyless.V2Api(api_client)

body = None
res = None

try:
  body = akeyless.Auth(access_id=access_id, access_key=access_key)
  res = api.auth(body)
except:
  print("Exception when calling authentication.")

token = None

# if auth was successful, there should be a token
if res is not None:
  token = res.token

api_response = None
# Enter a context with an instance of the API client
with akeyless.ApiClient() as api_client:
    # Create an instance of the API class
    api_instance = akeyless.V2Api(api_client)
    body = akeyless.GetDynamicSecretValue(name='/trendy-tabby/trendy-tabby-dynamic-db-credentials', token=token) # GetDynamicSecretValue | 

    try:
        api_response = api_instance.get_dynamic_secret_value(body)
    except ApiException as e:
        print("Exception when calling V2Api->get_dynamic_secret_value: %s\n" % e)

# Return Dynamic DB Secret
def dynamic_db_creds(params=api_response):
    db_creds = {}
    for param in params:
        db_creds[param] = params[param]

    return db_creds
