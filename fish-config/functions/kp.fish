function kp --wraps='keepassxc-cli clip --kdb=/Users/avirshup/.kp.kdbx' --wraps='keepassxc-cli clip /Users/avirshup/.kp.kdbx' --description 'alias kp=keepassxc-cli clip /Users/avirshup/.kp.kdbx'
  keepassxc-cli clip /Users/avirshup/.kp.kdbx $argv; 
end
