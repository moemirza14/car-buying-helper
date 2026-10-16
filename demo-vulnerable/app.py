"""DEMO ONLY: intentionally vulnerable code for SAST scanner demos. Do not deploy."""
import hashlib
import os
import pickle
import sqlite3
import subprocess

import requests
import yaml
from flask import Flask, redirect, request

app = Flask(__name__)

# Hardcoded credentials (FAKE)
DB_PASSWORD = "Sup3rS3cret!Passw0rd"
app.secret_key = "hardcoded-flask-secret-key-123"
AWS_ACCESS_KEY_ID = "AKIAZ7Q2DEMOFAKE9XYZ"
AWS_SECRET_ACCESS_KEY = "x9Lk2Qm/V7dTn4Rb+Ys8HfUa3WcZp6JeGoIqD1vN"


@app.route("/search")
def search():
    q = request.args.get("q", "")
    conn = sqlite3.connect("cars.db")
    # SQL injection: user input concatenated into query
    rows = conn.execute("SELECT * FROM cars WHERE name = '%s'" % q).fetchall()
    return str(rows)


@app.route("/ping")
def ping():
    host = request.args.get("host", "")
    # Command injection: shell=True with user input
    return subprocess.check_output("ping -c 1 " + host, shell=True)


@app.route("/load", methods=["POST"])
def load():
    # Insecure deserialization
    return str(pickle.loads(request.data))


@app.route("/config", methods=["POST"])
def config():
    # Unsafe YAML load
    return str(yaml.load(request.data))


@app.route("/hash")
def hash_pw():
    # Weak hashing algorithm
    return hashlib.md5(request.args.get("pw", "").encode()).hexdigest()


@app.route("/file")
def read_file():
    # Path traversal: unsanitised filename
    return open(request.args.get("name", "")).read()


@app.route("/go")
def go():
    # Open redirect
    return redirect(request.args.get("url", "/"))


@app.route("/proxy")
def proxy():
    # SSRF + TLS verification disabled
    return requests.get(request.args.get("url", ""), verify=False).text


if __name__ == "__main__":
    # Debug mode on, bound to all interfaces
    app.run(host="0.0.0.0", debug=True)
