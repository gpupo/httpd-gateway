#!/usr/bin/env bash
source "$(dirname "$0")/common/bootstrap.sh"

function inspect_docker_containers_network() {
    _print_container_network_info() {
        local container_id
        local container_ports
        local container_ip
        local container_name
        container_id="${1}"
    
        container_ports=( $(docker port "$container_id" | grep -o "0.0.0.0:.*" | cut -f2 -d:) )
        container_name="$(docker inspect --format "{{ .Name }}" "$container_id" | sed 's/\///')"
        container_ip="$(docker inspect --format "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} " "$container_id")"
        printf "%-40s %-13s %-20s\n" "$container_name" "$container_id" "$container_ip"
    }


    printf "%-40s %-13s %-20s\n" 'Container Name' 'Container Id' 'Container IP'
    local container_id
    docker ps -a --format "{{.ID}}" | while read -r container_id ; do
        _print_container_network_info  "$container_id"
    done

}

inspect_docker_containers_network;