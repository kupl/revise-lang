FROM sambyeol/ocaml-devcontainer

USER root
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
        musl-dev \
        musl-tools \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/list/*

USER sambyeol
RUN CC=musl-gcc CXX=musl-g++ opam switch reinstall --yes
