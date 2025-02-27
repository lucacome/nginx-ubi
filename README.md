# UBI based Docker image for NGINX

<p align="left">
<a href="https://scorecard.dev/viewer/?uri=github.com/lucacome/nginx-ubi"><img alt="OpenSSFScorecard" src="https://api.securityscorecards.dev/projects/github.com/lucacome/nginx-ubi/badge"></a>
<a href="https://hub.docker.com/r/nginxcontrib/nginx-ubi"><img alt="Docker Pulls" src="https://img.shields.io/docker/pulls/nginxcontrib/nginx-ubi?style=flat-square"></a>
<a href="https://hub.docker.com/r/nginxcontrib/nginx-ubi/tags?page=1&ordering=last_updated"><img alt="Docker Image Size (tag)" src="https://img.shields.io/docker/image-size/nginxcontrib/nginx-ubi/latest?style=flat-square">
<img alt="Docker Image Version (latest semver)" src="https://img.shields.io/docker/v/nginxcontrib/nginx-ubi?sort=semver&style=flat-square&label=docker%20tag"></a>
<a href="https://github.com/lucacome/nginx-ubi/actions/workflows/docker.yml"><img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/lucacome/nginx-ubi/docker.yml?logo=github&style=flat-square"></a>
<a href="https://github.com/lucacome/nginx-ubi"><img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/lucacome/nginx-ubi?label=github%20stars&logo=github&style=flat-square"></a>
<img alt="GitHub" src="https://img.shields.io/github/license/lucacome/nginx-ubi?style=flat-square">
</p>

This repository contains the Dockerfiles for building a Red Hat Universal Base image with NGINX, for multiple architectures.

Currently supported linux architectures: `amd64`, `arm64`, `ppc64le`, `s390x`.

Base image: `redhat/ubi9-minimal`.

NGINX modules installed: `nginx-module-xslt`, `nginx-module-image-filter` and `nginx-module-njs`.
