function wsl2_fix_time
  if ! string match -q "*microsoft*" (uname -r)
    return
  end

  pwsh -c wsl -u root ntpdate ntp.nict.jp
end
