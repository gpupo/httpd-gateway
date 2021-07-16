#!/usr/bin/env bash

source .env;

symlinks_default_cert_to_dot_place() {
    local file_prefix=${1};
    local source_file=/etc/nginx/certs/${SERVER_DEFAULT_HOST}.${file_prefix};
    local target_file=/etc/nginx/certs/.place.${file_prefix};
    printf "Symlink %s => %s\n" "${source_file}" "${target_file}";
    docker-compose exec nginx-proxy bash -c "test -L ${target_file} && ln -sn ${source_file} ${target_file} || echo .";
}

symlinks_default_cert_to_dot_place "crt";
symlinks_default_cert_to_dot_place "key";
symlinks_default_cert_to_dot_place "dhparam.pem";
symlinks_default_cert_to_dot_place "chain.pem";
