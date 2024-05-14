import boto3
import json

def get_credentials(secret_name):
    client = boto3.client("secretsmanager")
    secret_string = client.get_secret_value(SecretId=secret_name)["SecretString"]
    return json.loads(secret_string)