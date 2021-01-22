# docker-athens

A Docker image for running Athens, a Golang modules proxy, on ARM64v8
hardware. See the [project page](https://github.com/gomods/athens) for
details and features.


## Build

```
make build
```


## Configure

See the upstream documentation [here](https://docs.gomods.io/configuration/).

Note that Athens will look to `./athens.toml` (i.e. current working directory)
or to a file named on a command line argument (`-config_file FILE`) for
configuration.


## Deploy

Athens can be deployed using a `docker-compose.yml` file like:

```
version: '3.7'
services:
  athens:
    container_name: athens
    image: dricottone/athens:latest
    volumes:
      - /path/to/go/modules/cache:/var/lib/athens
    ports:
      - 3000:3000
    environment:
      - ATHENS_DISK_STORAGE_ROOT=/var/lib/athens
      - ATHENS_STORAGE_TYPE=disk
```


## Licensing

The Dockerfile is licensed under BSD 3-Clause. There are many more pieces of
software involved in the actual build and deploy processes, all under separate
and disparate licenses.


