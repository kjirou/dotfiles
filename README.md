dotfiles
========


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
cd /path/to/any-workspace
git clone git@github.com:kjirou/dotfiles.git
cd ./dotfiles
cp .vimrc ~
# directory と backupdir のディレクティブ用
mkdir ~/tmp
```

### screen

```bash
cp /path/to/dotfiles/.screenrc ~/
```
