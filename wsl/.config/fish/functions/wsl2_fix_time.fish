function wsl2_fix_time
  pwsh -c wsl -u root ntpdate ntp.nict.jp
end
