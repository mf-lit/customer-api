import os
import pytest


def test_response(client):
    expected = "some response"
    os.environ["CUSTOMER_RESPONSE"] = expected
    res = client.get("/")
    assert res.status_code == 200
    assert expected == res.get_data(as_text=True)


def test_no_response(client):
    del os.environ["CUSTOMER_RESPONSE"]
    res = client.get("/")
    assert res.status_code == 501
