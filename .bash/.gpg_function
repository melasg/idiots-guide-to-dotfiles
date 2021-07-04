endot()
{
  cd ~/etc
  tar czf encrypted.tar.gz etc/.local/share/misc
  gpg -er melodymelika@protonmail.ch encrypted.tar.gz
  rm encrypted.tar.gz
}



dedot()
{
  cd ~/etc
  gpg -do encrypted.tar.gz encrypted.tar.gz.gpg
  tar xvf encrypted.tar.gz
  rm encrypted.tar.gz
}
