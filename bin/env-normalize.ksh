#!/usr/bin/env ksh
typeset -A collection;
envFile=${1:-.env}
envTarget=var/cache/.env;
test -d var/cache || mkdir -p var/cache;
while IFS='=' read -r key temp || [ -n "$key" ]; do
isComment='^[[:space:]]*#'
isBlank='^[[:space:]]*$'
[[ $key =~ $isComment ]] && continue
[[ $key =~ $isBlank ]] && continue
collection[$key]=$temp;
done < $envFile

printf "##### COMPILED ENV #####\n" > $envTarget;
for K in "${!collection[@]}"; do 
    grep "$K=" $envFile | grep -v "^#" | tail -n 1 >> $envTarget;
done

# Ordena alfabeticamente as variaveis e elimina variaveis vazias
sort $envTarget | uniq -u > $envFile;

## Garante traefik config
test -f config/traefik.toml || cp -v config/traefik-example.toml config/traefik.toml && echo ".";