# Docker Systemd (WIP)

[![Build Status](https://travis-ci.org/gsdevme/docker-systemd-cookbook.svg?branch=master)](https://travis-ci.org/gsdevme/docker-systemd-cookbook)

Proof of concept for using chef to write systemd service files that boot docker images.

The main objective is to help replace native installed binaries in a transitional way.

An example of running Redis 4.0 on port 8888

```
      docker-systemd:
        containers:
          redis:
            image: redis
            tag: '4'
            options:
              publish: "8888:6379"
```

## Support

- CentOS 7.x

### Chef Support

- Chef 13.x
