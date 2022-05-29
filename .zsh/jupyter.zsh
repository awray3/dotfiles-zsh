# script for making new myst markdown files
# idea for improvement: if conda env is active,
# automatically use that kernel instead of asking.
new_markdown () {
    $CONDA_PYTHON_EXE $ZSH_DIR/new_markdown.py $@
}
alias nmd="new_markdown"

jt () {
    if command -v jupytext &>/dev/null
    then
        jupytext $@
    else
        echo "Jupytext not found."
    fi
}
alias js="jupytext --sync"

alias new_project="cookiecutter gh:awray3/new-project-cookiecutter"

# function/alias for installing the currently activated 
# venv as a jupyter kernel. Note that the environment variable
# CONDA_DEFAULT_ENV gives the name of the current conda env.
kernel_install () {
    ipython kernel install --user --name="$CONDA_DEFAULT_ENV"
}

jupyter_list_kernels () {

    if command -v jupyter &>/dev/null
    then
        jupyter kernelspec list
    else
        echo "Jupyter command not found."
        echo "Check that it is installed in your venv."
    fi
}
alias jkl="jupyter_list_kernels"