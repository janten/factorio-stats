# factorio-stats
Collects game statistics from a factorio server for collection via Prometheus exposition format. This tool uses factorio's RCON interface, which must be activated by running factorio with `--rcon-port 27015 --rcon-password secretRCONPassword`. Also works with headless servers. For single-player use, set a local RCON socket and password as described [here](https://forums.factorio.com/viewtopic.php?p=517980#p517980).

Stats are available for scraping at port 8000.

## Running with Docker
```
docker run \
    -e FACTORIO_ADDRESS=your-server.com \
    -e FACTORIO_PORT=27015 \
    -e FACTORIO_PASSWORD=secretRCONPassword \
    -p 8000:8000 \
    ghcr.io/janten/factorio-stats
```
