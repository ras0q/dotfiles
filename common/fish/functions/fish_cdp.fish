function fish_cdp --description 'Change directory to a path read from stdin'
  read --local DIR_PATH
  if test -n "$DIR_PATH"
    cd "$DIR_PATH"
  else
    return 1
  end
end
