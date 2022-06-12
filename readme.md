# Media server docker

## Getting started

1) Copy `.env.example` to `.env` and fill in usernames and passwords
2) run `docker-compose build`
3) run `docker-compose up --detach`
4) verify with `docker ps`

### Services

| port   | service      |
|--------|--------------|
| 80     | dashboard    |
| 81     | pi.hole      |
| 32400  | plex         |
| 9091   | transmission |

## Maintenance

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
