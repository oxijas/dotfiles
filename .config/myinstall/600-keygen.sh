#!/bin/sh

ssh-keygen -t rsa -b 4096 -C "oxijas@gmail.com"
eval "$(ssh-agent -s)"

#werkt alleen in X
#xclip -sel clip < ~/.ssh/id_rsa.pub

