function public-pip-install \
    --wraps='pip install -i https://pypi.org/simple' \
    --description 'alias public-pip-install pip install -i https://pypi.org/simple'

    pip install -i https://pypi.org/simple $argv
end
