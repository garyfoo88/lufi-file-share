FROM ubuntu:latest

ARG LUFI_BUILD_VERSION=1.42

RUN apt-get update \
&& apt-get -yq install build-essential libssl-dev libio-socket-ssl-perl liblwp-protocol-https-perl libpq-dev wget unzip \
&& apt-get clean && cpan Carton \
&& wget https://github.com/garyfoo88/lufi-file-share/archive/${LUFI_BUILD_VERSION}.zip && unzip ${LUFI_BUILD_VERSION}.zip \
&& rm ${LUFI_BUILD_VERSION}.zip && mv lufi-file-share-${LUFI_BUILD_VERSION} lufi

COPY lufi.conf /lufi/lufi.conf

WORKDIR /lufi

RUN carton install --deployment --without=test --without=sqlite --without=mysql

CMD ["carton", "exec", "hypnotoad", "-f", "/lufi/script/lufi"]

COPY default.html.ep /lufi/themes/default/templates/layouts/default.html.ep

