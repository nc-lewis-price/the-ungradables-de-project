import boto3
from botocore.exceptions import ClientError
from moto import mock_aws
import pytest
import os
from src.ingestion_lambda.get_credentials import get_credentials

@pytest.fixture(scope="function")
def aws_credentials():
    """Mocked AWS Credentials for moto."""
    os.environ["AWS_ACCESS_KEY_ID"] = "testing"
    os.environ["AWS_SECRET_ACCESS_KEY"] = "testing"
    os.environ["AWS_SECURITY_TOKEN"] = "testing"
    os.environ["AWS_SESSION_TOKEN"] = "testing"
    os.environ["AWS_DEFAULT_REGION"] = "eu-west-2"


@pytest.fixture(scope="function")
def secrets_client(aws_credentials):
    with mock_aws():
        yield boto3.client("secretsmanager")


@mock_aws
def test_get_credentials_gets_secret_when_exists(secrets_client):
    test_secret = '{"username": "test", "password": "password", "engine": "postgres", "host": "localhost", "port": "5432", "dbname": "db"}'
    
    secrets_client.create_secret(Name="test-secret", SecretString=test_secret)
    res = get_credentials("test-secret")

    assert isinstance(res, dict)
    assert res["username"] == "test"
    assert res["password"] == "password"
    assert res["engine"] == "postgres"
    assert res["host"] == "localhost"
    assert res["port"] == "5432"
    assert res["dbname"] == "db"
    

@mock_aws
def test_get_credentials_raises_a_botocore_err_when_secret_not_found():
    with pytest.raises(ClientError):
        get_credentials("test-secret")