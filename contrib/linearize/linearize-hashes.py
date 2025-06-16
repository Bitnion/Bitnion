#!/usr/bin/env python3
#
# linearize-hashes.py — Bitnion Block Hash Collector
#
# This script connects to a running Bitnion node via RPC and retrieves
# all block hashes in the correct blockchain order, starting from genesis.
# It writes them to stdout or a file, to be used by linearize-data.py.
#
# Adapted from Bitcoin Core tools
# License: MIT
# ----------------------------------------------------------------------

import http.client
import json
import os
import sys
import base64
import configparser

def read_config(filename):
    config = {}
    parser = configparser.ConfigParser()
    parser.read(filename)
    for section in parser.sections():
        for key, val in parser.items(section):
            config[key] = val
    return config

def rpc_request(rpc_user, rpc_password, host, port, method, params=[]):
    conn = http.client.HTTPConnection(host, port)
    credentials = f"{rpc_user}:{rpc_password}"
    headers = {
        "Authorization": "Basic " + base64.b64encode(credentials.encode()).decode(),
        "Content-type": "application/json"
    }
    body = json.dumps({"method": method, "params": params, "id": 0})
    conn.request("POST", "/", body, headers)
    response = conn.getresponse()
    if response.status != 200:
        raise ConnectionError(f"RPC error: {response.status} {response.reason}")
    reply = json.loads(response.read())
    if reply.get("error") is not None:
        raise ValueError(f"RPC call error: {reply['error']}")
    return reply["result"]

def get_block_hashes(rpc_user, rpc_password, host, port, max_height=0):
    height = 0
    hashes = []
    while True:
        try:
            block_hash = rpc_request(rpc_user, rpc_password, host, port, "getblockhash", [height])
            hashes.append(block_hash)
            if max_height and height >= max_height:
                break
            height += 1
        except Exception as e:
            break
    return hashes

def main():
    if len(sys.argv) < 2:
        print("Usage: linearize-hashes.py <config-file>")
        sys.exit(1)

    config_path = sys.argv[1]
    cfg = read_config(config_path)

    rpc_user = cfg.get("rpcuser", "bitnionrpc")
    rpc_password = cfg.get("rpcpassword", "")
    host = cfg.get("host", "127.0.0.1")
    port = int(cfg.get("port", 9332))
    max_height = int(cfg.get("max_height", 0))

    try:
        hashes = get_block_hashes(rpc_user, rpc_password, host, port, max_height)
        for h in hashes:
            print(h)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == '__main__':
    main()
