function public-pip-install --wraps='pip install -i https://pypi.org' --description 'alias public-pip-install pip install -i https://pypi.org'
  pip install -i https://pypi.org $argv
        
end
