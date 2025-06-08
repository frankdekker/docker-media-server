# Media server docker

## Getting started

1) Copy `.env.example` to `.env` and fill in usernames and passwords
2) run `docker-compose build`
3) run `docker-compose up --detach`
4) verify with `docker ps`

### Services

| port  | service          | description                          |
|-------|------------------|--------------------------------------|
| 80    | dashboard        | quicklinks to all applications       | 
| 81    | pi.hole          | block adds via dns in your network   |
| 9091  | transmission     | torrent client                       | 
| 9117  | Jackett          | torrent feeder for sonarr and radarr |
| 8191  | Flaresolverr     | cloud flare site protection solver   |
| 7878  | Radarr           | movie scheduler                      |
| 8989  | Sonarr           | series scheduler                     | 
| 8096  | Jellyfin         | media server                         |
| 8443  | Swag (jellyfin)  | reverse proxy for public https       |

# Configuration

## Setup Transmission in Sonarr and Radarr

- Go to settings > Download client > Click the big plus > Scroll down to Transmission
- Give it a name, and save

## Configure indexers

- Open jackett > add indexer > Follow instructions in jackett to add to sonarr 

# Maintenance

Clean up non-running containers
```shell
docker container prune
```

Follow logs
```shell
docker-compose logs --tail=2 --follow
```

List images
```shell
docker images
```
