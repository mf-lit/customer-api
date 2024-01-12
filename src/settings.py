from os import environ

customer_response = environ.get("CUSTOMER_RESPONSE")
assert (
    customer_response is not None
), "Environment variable CUSTOMER_RESPONSE is unset or not defined."
