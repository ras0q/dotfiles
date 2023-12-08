function wsl2_fix_time
  if ! string match -q "*microsoft*" (uname -r)
    return
  end

  sudo ntpdate ntp.nict.jp
end
