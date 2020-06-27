from flask import Flask, request, jsonify
from urllib.parse import urlparse
from requests.exceptions import HTTPError

import requests
import config
import logging

logging.basicConfig(level=logging.ERROR)


ADMIN_ROLE="admin"
ROLE_KEY="carwash-role"

app = Flask(__name__)


def verify_token():
    response = requests.get(config.USER_INFO_URL, headers=request.headers)
    if not response.ok:
        return response.text, response.status_code
    response_result = response.json()
    if ROLE_KEY not in response_result or ADMIN_ROLE not in response_result[ROLE_KEY]:
        return "Forbidden", 403
    return response.text, response.status_code


@app.route('/auth_request', methods=["GET", "POST", "DELETE", "PUT"])
def auth_request():
    message, code = verify_token()
    return jsonify(message), code


@app.errorhandler(Exception)
def handle_error(e):
    code = 500
    message=str(e)
    logging.exception(message)
    if isinstance(e, HTTPError):
        code = e.code
    return jsonify(error=message), code


if __name__ == '__main__':
    app.run(host=config.HTTP_HOST, port=config.HTTP_PORT)
