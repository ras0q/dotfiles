function gf_open -d 'Repository search and open in editor'
  gf && echo "Opening" (basename (pwd)) "in $EDITOR" && $EDITOR .
end
