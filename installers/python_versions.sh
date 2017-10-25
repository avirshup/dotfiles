#!/bin/bash

set -e

echocmd pyenv install miniconda-latest
echocmd pyenv shell miniconda-latest
echocmd conda install numpy numpy scipy matplotlib jupyter

echocmd pyenv install miniconda3-latest
echocmd pyenv shell miniconda3-latest
echocmd conda install numpy scipy matplotlib jupyter
