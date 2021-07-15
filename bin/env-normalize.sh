#!/usr/bin/env bash
#!/usr/bin/env bash
declare -A collection;
envFile=${1:-.env}
envTempFile=var/cache/temp.env;
envOrdenedFile=var/cache/ordened.env;
test -d var/cache || mkdir -p var/cache;


isComment='^[[:space:]]*#'
isBlank='^[[:space:]]*$'

echo '' > $envTempFile;
echo '' > $envOrdenedFile;

while IFS='=' read -r key temp || [ -n "$key" ]; do
    [[ $key =~ $isComment ]] && continue
    [[ $key =~ $isBlank ]] && continue
    collection[$key]=$temp;
done < $envFile


for K in "${!collection[@]}"; do 
    grep "^$K=" $envFile | grep -v "^#" | tail -n 1 >> $envTempFile;
done

# Ordena alfabeticamente
sort $envTempFile | uniq -u > $envOrdenedFile;

source $envOrdenedFile;

function_is_literal_string() {
    local list=$1

    LiteralInitStringSkip='{';
    for item in $LiteralInitStringSkip; do
        if [[ ${list:0:1} == "$item" ]]; then
            return 0;
        fi
    done    

    if [ "$list" == "*" ]; then
        return 0;
    fi

    LiteralInnerStringSkip='@ &';
    for item in $LiteralInnerStringSkip; do
        if [[ $list =~ "$item" ]]; then
            return 0;
        fi
    done    

    #not
    return 1;
}

printf "##### > COMPILED ENV #####\n" > $envFile;
while IFS='=' read -r key temp || [ -n "$key" ]; do

    [ -z "$key" ] && continue; #ignora key vazia

    if  `function_is_literal_string "$temp"` ; then
        # echo ">> Literal $key";
        stringValue=$temp;
    else
        # echo ">> Eval $key";
        eval printf -v stringValue "%s" "${temp/(/\(/}";
    fi;
    echo "$key=$stringValue" >> $envFile;
done < $envOrdenedFile


echo "TRAEFIK_VIRTUAL_HOST_REGEX=~(${SERVER_DEFAULT_HOST//\./\\\.}|[a-zA-Z\-]+\.[a-zA-Z]+\.place)$" >> $envFile;


printf "##### < COMPILED at %s #####\n" "$(date '+%Y-%m-%d_%Hh%m')" >> $envFile;

## Garante traefik config
test -f config/traefik.toml || cp -v config/traefik-example.toml config/traefik.toml && echo ".";