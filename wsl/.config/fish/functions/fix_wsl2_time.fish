function fix_wsl2_time
  pwsh -c wsl -u root ntpdate ntp.nict.jp
end
