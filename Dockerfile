FROM nginx:1.23.0 as nginx

FROM redhat/ubi8:8.6 as rpm-build
ARG NGINX
ARG NJS
ENV NGINX_VERSION ${NGINX}
ENV NJS_VERSION ${NJS}


RUN rpm --import https://nginx.org/keys/nginx_signing.key \
    && printf "%s\n" "[nginx]" "name=nginx src repo" \
    "baseurl=https://nginx.org/packages/mainline/centos/8/SRPMS" \
    "gpgcheck=1" "enabled=1" "module_hotfixes=true" >> /etc/yum.repos.d/nginx.repo \
    && dnf install rpm-build gcc make dnf-plugins-core which -y \
    && dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

RUN nginxPackages=" \
    nginx-${NGINX_VERSION} \
    nginx-module-xslt-${NGINX_VERSION} \
    nginx-module-image-filter-${NGINX_VERSION} \
    nginx-module-njs-${NGINX_VERSION}+${NJS_VERSION} \
    " \
    && dnf config-manager --set-enabled ubi-8-codeready-builder \
    && dnf download --source ${nginxPackages} \
    && dnf builddep -y --srpm nginx*.rpm \
    && rpmbuild --rebuild --nodebuginfo nginx*.rpm \
    && mkdir -p /nginx/ \
    && cp /root/rpmbuild/RPMS/$(arch)/* /nginx/


FROM redhat/ubi8-minimal:8.6 as final
ARG NGINX
ARG NJS
ENV NGINX_VERSION ${NGINX}
ENV NJS_VERSION ${NJS}

RUN --mount=type=bind,from=rpm-build,source=/nginx,target=/tmp/ \
    rpm -qa --queryformat "%{NAME}\n" | sort > installed \
    && microdnf --nodocs --setopt=install_weak_deps=0 install -y shadow-utils diffutils dnf \
    && rpm -qa --queryformat "%{NAME}\n" | sort > new \
    && groupadd --system --gid 101 nginx \
    && useradd --system --gid nginx --no-create-home --home-dir /nonexistent --comment "nginx user" --shell /bin/false --uid 101 nginx \
    && dnf install -y /tmp/*.rpm \
    && dnf -q repoquery --resolve --requires --recursive --whatrequires nginx --queryformat "%{NAME}" > nginx \
    && dnf --setopt=protected_packages= remove -y $(comm -13 installed new | comm -13 nginx -) \
    && microdnf -y clean all \
    && rm installed new nginx
