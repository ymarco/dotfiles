#!/bin/bash

echo 'installing packages...'
sudo add-apt-repository ppa:lyx-devel/release &&
    sudo apt-get update &&
    sudo apt-get install lyx texlive-lang-other culmus-latex || echo 'couldnt install stuff...' && exist
echo -e '\n\n\nSCRIPT:\nfinished installing packages...'

mkdir -p ~/.lyx/bind

echo 'creating hebrew bind file...'

echo -e \
'\\bind_file cua.bind

\\bind "F12" "language hebrew"' > ~/.lyx/bind/cua_he.bind


echo 'configuring lyx...'
echo -e \
'### THIS SECTION WAS ADDED BY UBUNTU-HEBREW-LYX CONFIGURE SCRIPT
### IT SETS THE KEYMAP AND BIND FILE FOR HEBREW

\\bind_file "cua_he"

\\kbmap true
\\kbmap_primary "null"
\\kbmap_secondary "hebrew"

\\visual_cursor true

### END OF CONFIGURE SCRIPT
' >> ~/.lyx/preferences


echo -e "\ndone. to restore your hebrew document settings, open an old document and apply 'document > settings > save as document default'"
