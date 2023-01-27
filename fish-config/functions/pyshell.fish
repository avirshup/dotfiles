function pyshell \
    --wraps='pyenv shell' \
    --description 'alias pyshell=pyenv shell'
  pyenv shell $argv; 
end
