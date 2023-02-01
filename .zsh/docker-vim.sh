#!/usr/bin/env /bin/bash

# neovim config version
NEOVIM_TAG=0.2.0

if [[ "$(pwd)" == "$HOME" ]]; then
    echo "not opening in home directory."
    exit 1
fi

SUB_NAME=$(basename $(pwd))

# Container name is hash neovim-<sub_name>-hash,
# where hash is computed from ...
CONTAINER_NAME="neovim-${SUB_NAME}-$$"

echo Launching neovim in container: ${CONTAINER_NAME//.}

function _vim () {
    local tag=$NEOVIM_TAG
    while [[ $# -gt 0 ]]; do
      case $1 in
        --tag)
          tag=$2
          shift 2
          ;;
        *)
          break
          ;;
      esac
    done

    docker run -it --rm \
      --name ${CONTAINER_NAME//.} \
      -w /edit \
      -v `pwd`:/edit \
      awray3/neovim:$tag \
      nvim "$@"
}

_vim "$@"
