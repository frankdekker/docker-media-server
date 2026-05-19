# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A Docker Compose media server stack running on a home server. All services are defined in `docker-compose.yml` and configured via a `.env` file (copy `.env.example` to `.env`).

## Common commands

```bash
# First-time setup
cp .env.example .env   # then fill in credentials

# Build the custom transmission image
docker-compose build

# Start all services in the background
docker-compose up --detach

# Verify running containers
docker ps

# Follow logs
docker-compose logs --tail=2 --follow

# Remove stopped containers
docker container prune
```

## Architecture

The stack has two distinct network zones:

**VPN-routed group** — `jackett`, `flaresolverr`, `radarr`, and `sonarr` all use `network_mode: "service:transmission-openvpn"`. This means their ports (9117, 8191, 7878, 8989) are exposed through the `transmission-openvpn` container, and all their outbound traffic goes through the VPN. These services `depends_on` transmission being healthy before starting.

**Non-VPN services** — `lighttpd-dashboard` (port 80), `pihole` (port 81, 53), `jellyfin` (port 8096), and `swag` (port 8443) run on the default bridge network.

### Custom transmission image

`docker/transmission/Dockerfile` extends `haugene/transmission-openvpn` to add a `remove-torrent.sh` script that auto-removes torrents at 100% download. The VPN provider defaults to Surfshark (`nl-ams.prod.surfshark.com_tcp`).

### Jellyfin + SWAG (reverse proxy)

`swag` provides HTTPS access to Jellyfin at `jellyfin-fra.nkdekker.nl` via Let's Encrypt DNS validation through the Cloudflare API. The nginx config lives in `swag/jellyfin.subdomain.conf` and is bind-mounted into the swag container. Access is restricted to Dutch ISP IP ranges (KPN, Ziggo, Odido, DELTA) plus the LAN subnet `192.168.1.0/24`.

### Required environment variables (`.env`)

| Variable | Description |
|---|---|
| `PIHOLE_PASSWORD` | Pi-hole web UI password |
| `OPENVPN_USERNAME` | VPN credentials |
| `OPENVPN_PASSWORD` | VPN credentials |
| `OPENVPN_PROVIDER` | VPN provider (default: `SURFSHARK`) |
| `OPENVPN_CONFIG` | VPN config name |
| `MEDIA_HOME` | Host path for all persistent data (downloads, config, etc.) |

### Service port map

| Port | Service |
|---|---|
| 80 | Dashboard (lighttpd) |
| 81 | Pi-hole admin |
| 53 | Pi-hole DNS |
| 9091 | Transmission |
| 9117 | Jackett |
| 8191 | Flaresolverr |
| 7878 | Radarr |
| 8989 | Sonarr |
| 8096 | Jellyfin |
| 8443 | SWAG (Jellyfin HTTPS) |
