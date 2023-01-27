function myps \
    -d "Attempts to show only processes that I've launched myself"
  ps x | grep -v /usr/libexec | grep -v '\.app' | grep -v '/Library'; 
end
