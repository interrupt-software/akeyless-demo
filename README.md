# akeyless-demo

## Authenticate using a static role
```bash
akeyless auth
Access Id: p-abcdefghi9jk
Access Key: 
```
The process returns a bearer token. 
```bash
Authentication succeeded.
Token: t-12345a67bc8901defa23b45cd6e78f9a
```

## Retrieve a static secret
```bash
akeyless get-secret-value \
--name /trendy-tabby/trendy-tabby-secret-recipe
```
We expect the following on the screen
```bash
Fresh Whole Chicken
Cod-liver Oil
Coconut Oil
Turmeric
Vitamin E Supplement
Inulin
```

## Login using AWS IAM identity

```bash
akeyless auth \
--access-id p-lmhos123gg45 \
--access-type aws_iam
```
The process returns a bearer token. 
```bash
Authentication succeeded.
Token: t-12345a67bc8901defa23b45cd6e78f9a
```

## Retrieve Dynamic DB Secrets

```bash
akeyless get-dynamic-secret-value \
--name /trendy-tabby/trendy-tabby-dynamic-db-credentials 
```
The process returns dynamic DB credentials from the target DB. 
```bash
{
  "id": "tmp_trendy-tabbytr_gcastill0_1bIOa",
  "password": "YX4Z=Fx04=jG/V%x",
  "ttl_in_minutes": "60",
  "user": "tmp_trendy-tabbytr_gcastill0_1bIOa"
}
```
## API Instrumentation
Reference the [utility module](containers/backend/akeyless_client.py) to describe a basic example of instrumentation. 

The module requires the following environment variables:

- AKEYLESS_ACCESS_ID
- AKEYLESS_ACCESS_KEY
- AKEYLESS_HOST

### Explain code segment
```python
# Enter a context with an instance of the API client
with akeyless.ApiClient() as api_client:
    # Create an instance of the API class
    api_instance = akeyless.V2Api(api_client)
    body = akeyless.GetDynamicSecretValue(name='/trendy-tabby/trendy-tabby-dynamic-db-credentials', token=token) # GetDynamicSecretValue | 

    try:
        api_response = api_instance.get_dynamic_secret_value(body)
    except ApiException as e:
        print("Exception when calling V2Api->get_dynamic_secret_value: %s\n" % e)
```

### Present the environment variables:
```bash
export AKEYLESS_ACCESS_ID="p-zyxhgfmlk0zu"
export AKEYLESS_ACCESS_KEY="qwertypoiu+zyxw1234+zxcvbmnbv+12ASDFGLKJH3="

# The Akeyless host defaults to "https://api.akeyless.io"
# Change to Akeyless Gateway FQDN or private IP
export AKEYLESS_HOST="https://akeylessgw.domain.co"
```
### Run the utility
The module `dbconfig.py` relies on `akeyless_client.py` to obtain credentials.

```bash
python3 containers/backend/dbconfig.py
```

The module returns a message similar to the following:

```json
{
  "host": "127.0.0.1",
  "user": "tmp_trendy-tabbytr_p-zyxhgfmlk0zu_Wtfo0",
  "password": "YX4Z=Fx04=jG/V%x",
  "dbname": "postgres"
}
```
