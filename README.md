# factorio-stats
Collects game statistics from a factorio server and exports them to an InfluxDB database. This tool uses factorio's RCON interface, which must be activated by running factorio with `--rcon-port 27015 --rcon-password secretRCONPassword`. Also works with headless servers.

The default collection interval is ten seconds and can be configured using the `COLLECTION_INTERVAL` environment variable.

Visualization can be done with Grafana. [Sample dashboard](https://snapshot.raintank.io/dashboard/snapshot/1Gw1V6c9quaZDQcIQ945p9cu9rLUoShe).

## Running with Docker
```
docker run \
	-e FACTORIO_ADDRESS=your-server.com \
	-e FACTORIO_PORT=27015 \
	-e FACTORIO_PASSWORD=secretRCONPassword \
	-e INFLUX_ADDRESS=your-database-server.com \
	-e INFLUX_PORT=8086 \
	-e INFLUX_DATABASE=factorio \
	-e INFLUX_USERNAME=my_user \
	-e INFLUX_PASSWORD=secretPassw0rd \
	-e COLLECTION_INTERVAL=30s \
	janten/factorio-stats
```
