function fuzzgrep -d "fuzzy search and selection, then open in vim"
   # from https://news.ycombinator.com/item?id=38473516
   # see also https://github.com/junegunn/fzf/blob/master/ADVANCED.md
   set result (rg --ignore-case --color=always --line-number --no-heading $argv |
     fzf --ansi \
         --color 'hl:-1:underline,hl+:-1:underline:reverse' \
         --delimiter ':' \
         --preview "bat --color=always {1} --theme='Solarized (light)' --highlight-line {2}" \
         --preview-window 'up,60%,border-bottom,+{2}+3/3,~3')
   set file (echo $result | cut -d: -f1)
   set linenumber (echo $result | cut -d: -f2)
   if test -n "$file"
       $EDITOR +"$linenumber" "$file"
   end
end