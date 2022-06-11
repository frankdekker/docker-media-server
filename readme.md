# Media server docker

## Getting started

1) Copy `.env.example` to `.env` and fill in usernames and passwords
2) run `docker-compose up`

### Services

| port   | service      |
|--------|--------------|
| 80     | dashboard    |
| 81     | pi.hole      |
| 32400  | plex         |
| 9091   | transmission |

Run in background
```shell
docker-compose up --detach
```

## Maintenance

```shell
docker container prune
docker images
```
