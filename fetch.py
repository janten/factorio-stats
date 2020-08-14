import os
import time
import json
import pytimeparse
import factorio_rcon
from influxdb import InfluxDBClient

collection_interval = pytimeparse.parse(os.environ.get("COLLECTION_INTERVAL", "10s"))

factorio_address = os.environ["FACTORIO_ADDRESS"]
factorio_port = int(os.environ.get("FACTORIO_PORT", "27015"))
factorio_password = os.environ["FACTORIO_PASSWORD"]

influx_address = os.environ["INFLUX_ADDRESS"]
influx_port = int(os.environ.get("INFLUX_PORT", "8086"))
influx_username = os.environ.get("INFLUX_USERNAME", None)
influx_password = os.environ.get("INFLUX_PASSWORD", None)
influx_database = os.environ["INFLUX_DATABASE"]

with open("gather-stats.lua", "r") as f:
    stats_code = f.read()
    rcon_command = "/silent-command " + stats_code

rcon_client = factorio_rcon.RCONClient(factorio_address, factorio_port, factorio_password)
influx_client = InfluxDBClient(influx_address, influx_port, influx_username, influx_password, influx_database)

while True:
    raw_response = rcon_client.send_command(rcon_command)
    response = json.loads(raw_response)
    influx_client.write_points(response)
    time.sleep(collection_interval)
