source "$PWD/.env";
ENDPOINT=${1:-'localhost'}
HG_VAR_DIRECTORY="$PWD/var"
STAGE_DIRECTORY="$HOME/stage"
STAGE_CONFIG="$STAGE_DIRECTORY/config"

if [ ! -f $STAGE_CONFIG ]; then
    mkdir -p $STAGE_DIRECTORY;
    touch $STAGE_CONFIG;
fi
