import pytest
from src.customer_api import app as flask_app


@pytest.fixture
def app():
    yield flask_app


@pytest.fixture
def client(app):
    app.config["TESTING"] = True
    client = app.test_client()
    yield client
