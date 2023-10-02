import os
import time
import json
import factorio_rcon
from http.server import BaseHTTPRequestHandler, HTTPServer

factorio_address = os.environ.get("FACTORIO_ADDRESS", "localhost")
factorio_port = int(os.environ.get("FACTORIO_PORT", "27015"))
factorio_password = os.environ.get("FACTORIO_PASSWORD", "secretRCONPassword")

with open("gather-stats.lua", "r") as f:
    stats_code = f.read()
    rcon_command = "/silent-command " + stats_code

class MyServer(BaseHTTPRequestHandler):  
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        rcon_client = factorio_rcon.RCONClient(factorio_address, factorio_port, factorio_password)
        raw_response = rcon_client.send_command(rcon_command)
        self.wfile.write(raw_response.encode("utf-8"))

webServer = HTTPServer(("localhost", 8000), MyServer)
try:
    webServer.serve_forever()
except KeyboardInterrupt:
    pass

webServer.server_close()
print("Server stopped.")
