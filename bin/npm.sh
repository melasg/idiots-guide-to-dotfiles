set -u

sudo -v

excluded_paths=(".DS_Store" "README.md" "LICENSE" ".ghci")

for path in $(ls -a); do
    # only files
    if [ -f "$path" ]; then
      # ignore excluded
      if [[ ! " ${excluded_paths[@]} " =~ " ${path} " ]]; then
        echo "> create symlink:\t~/$path\t-> $(pwd)/$path"
        ln -s -f $(pwd)/$path ~/$path
      fi
    fi
done

echo "> install npm global packages:"
npx npm-merge-driver install --global