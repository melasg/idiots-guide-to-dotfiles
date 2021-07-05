what you think i'm stupid enough to put my private ssh keys online LOL 

# GPG tutorial
# Create a symlink for private file
```bash
cd ~/cfg/etc/.android
ln -sf ../.local/share/misc/adbkey adbkey
stow etc
```
# Tell git to ignore sensitive file(s)
```bash
echo "etc/.local/share/misc/" >> ~/cfg/.gitignore
```

# Now it won’t track the sensitive files in `~/cfg/.local/share/misc`.
Compress the sensitive file(s) with tar
```bash
cd ~/cfg
tar czf encrypted.tar.gz etc/.local/share/misc
```
# Encrypt the tar archive and delete the un-encrypted archive
```bash
gpg -er abdullah@abdullah.today encrypted.tar.gz
rm encrypted.tar.gz
```
# Replace abdullah@abdullah.today with your email ID you used while creating gpg key.
Add encrypted archive to git
```bash
cd ~/cfg
git add encrypted.tar.gz.gpg
```
# scratch 
```bash
ssh-keygen -t rsa -C 'melodymelika@protonmail.ch'
```
[ follow prompts ]
```bash
pbcopy < ~/.ssh/id_rsa.pub
pbcopy < ~/.ssh/id_rsa.pub
ssh my_username@myhost.host
```
[ type password ]
```bash
cd ~/.ssh
vim authorized_keys
```
[ paste your key at the end of the file]
  [ save file and quit ]