from flask import Flask, abort
import os


# def load_env_var(var_name):
#     var_value = os.getenv(var_name)
#     assert (
#         var_value is not None
#     ), f"Environment variable {var_name} is unset or not defined."
#     return var_value


def create_app():
    app = Flask(__name__)
    return app


app = create_app()


@app.route("/")
def index():
    response = os.environ.get("CUSTOMER_RESPONSE")
    if response is None:
        abort(501, "Response not defined")
    return response


# customer_response = load_env_var("CUSTOMER_RESPONSE")
# app = Flask(__name__)
# app.config["customer_response"] = customer_response


if __name__ == "__main__":
    # customer_response = load_env_var("CUSTOMER_RESPONSE")
    # app.config["customer_response"] = customer_response
    app.run()
