# MySQL backup Docker image

[![](https://badge.imagelayers.io/konjak/mysql-backup:latest.svg)](https://imagelayers.io/?images=konjak/mysql-backup:latest)

Production ready Docker container for MySQL backup.

## Features - why using this image instead of several others?

- Uses [alpine](https://registry.hub.docker.com/_/alpine/) base image
- This image is as small as possible
- Uses linked MySQL DB
- Waits for MySQL container to be ready
- Uses cronjob to call backup script
- Writes .sql.bz2 files to /backup for every database in the linked MySQL server

## Usage

```bash
sudo docker run \
  -v ./backup:/backup \
  -e MYSQL_HOST=db \
  -e MYSQL_ROOT_PASSWORD=password \
  konjak/mysql-backup
```

## Status

Production stable.
