#!/usr/bin/env /bin/bash

# neovim config version
NEOVIM_TAG=0.1.0

SUB_NAME=$(basename $(pwd))

# Container name is hash neovim-<sub_name>-hash,
# where hash is computed from ...
CONTAINER_NAME="neovim-${SUB_NAME}-$$"

echo Launching neovim in container: ${CONTAINER_NAME//.}

_vim () {
    docker run -it --rm \
      --name ${CONTAINER_NAME//.} \
      -w /edit \
      -v `pwd`:/edit \
      awray3/neovim:$NEOVIM_TAG \
      nvim "$@"
}

_vim "$@"
