# syntax=docker/dockerfile:1
FROM frolvlad/alpine-python3

ARG VERSION

LABEL component="aws-ip-manager"
LABEL description="Init or sidecar container for multus AWS IP management"
LABEL version=${VERSION}
LABEL maintainer="Bart Van Bos <bartvanbos@gmail.com>"
LABEL source-repo="https://github.com/boeboe/eks-automated-ipmgmt-multus-pods"

WORKDIR /app
COPY code/requirements.txt requirements.txt
COPY code/script.sh script.sh
COPY code/assign-ip-new-ip6-parallel.py assign-ip-new-ip6-parallel.py
RUN apk update && apk add --no-cache iproute2 \
    && pip3 install  -r requirements.txt
RUN chmod 755 /app/script.sh
