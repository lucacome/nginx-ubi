# UBI based Docker image for NGINX

This repository contains the Dockerfiles for building an UBI based image with NGINX for multiple architectures.

Currently supported linux architectures: `amd64`, `arm64`, `ppc64le`, `s390x`.

Base image: `redhat/ubi8-minimal`.

NGINX modules installed: `nginx-module-xslt`, `nginx-module-image-filter` and `nginx-module-njs` (except for s390x).
