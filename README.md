dotfiles
========
test

## Installation
### zsh

```bash
chsh -s /bin/zsh
cd ~
curl -o .zshrc https://raw.githubusercontent.com/kjirou/dotfiles/master/.zshrc
# .zsh_history should also be copied from somewhere depending on the situation
exit
```

### git

```bash
cd ~
curl -o .gitconfig https://raw.githubusercontent.com/kjirou/dotfiles/master/.gitconfig
```

### vim

```bash
git clone git@github.com:kjirou/dotfiles.git /path/to/dotfiles
cd ~
cp /path/to/dotfiles/.vimrc ./
# In the case of Mac OS X, it is necessary to specify an absolute path
ln -s /path/to/dotfiles/.vim .vim
```

### screen

```bash
cp /path/to/dotfiles/.screenrc ~/
```
