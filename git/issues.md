
# Git Issues and Fixes



## Your push would publish a private email address 

First, undo your commit 
```
git reset --soft HEAD~1
```

Second, reconfigure the git to use the public email address as follows: 
```
git config --global user.email "1896424+heathyates@users.noreply.github.com"
```