#!/bin/bash

# MY_REPO='/ryanoasis/nerd-fonts'

# GIT_API='https://api.github.com/repos'
# GIT_URI='/contents'
# GIT_PATH='/patched-fonts'

# FONTS=(Inconsolata AnonymousPro Arimo )

# CURL_OPTS=(
#     -X
#     GET
# )

# for font in "${FONTS[@]}"; do
#     echo ${font}
    
#     # curl "${CURL_OPTS[@]}" "${GIT_API}${MY_REPO}${GIT_URI}${GIT_PATH}/${font}" 
    
#     FONT_DIRS=($(curl "${CURL_OPTS[@]}" "${GIT_API}${MY_REPO}${GIT_URI}${GIT_PATH}/${font}" | jq -r '.[] | select(.type == "dir") | .name'))
    
#     for dir in "${FONT_DIRS[@]}"; do
#         echo "dir = ${dir}"
#         FONT_FILES=($(curl "${CURL_OPTS[@]}" "${GIT_API}${MY_REPO}${GIT_URI}${GIT_PATH}/${font}/${dir}" \
#                 | jq -r '.[] | select(.type == "file") | select(.name|endswith(".ttf")) | .download_url'
#         ))
#         dir_path="~/.fonts/${font}/${dir}"
#         mkdir -p $dir_path
#         for file in "${FONT_FILES[@]}"; do
#             echo "Download ${file}"
#             wget -nc -P ${dir_path} ${file}
#         done
#     done
    
#     FONT_FILES=($(curl "${CURL_OPTS[@]}" "${GIT_API}${MY_REPO}${GIT_URI}${GIT_PATH}/${font}" \
#             | jq -r '.[] | select(.type == "file") | select(.name|endswith(".ttf")) | .download_url'
#     ))
    
#     mkdir -p ~/.fonts/${font}
    
#     for file in "${FONT_FILES[@]}"; do
#         echo "Download ${file}"
#         wget -nc -P ~/.fonts/${font} ${file}
#     done
#    0O
# done


FONTS_RELEASE_DIR="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/"
FONTS=(Inconsolata InconsolataGo AnonymousPro Arimo JetBrainsMono FiraCode FiraMono Meslo)

mkdir -p ~/.local/share/fonts/

for font in "${FONTS[@]}"; do
    file_name="${font}.zip"
    wget "${FONTS_RELEASE_DIR}${file_name}"  -O "/tmp/${file_name}"
    unzip -o "/tmp/${file_name}" -d ~/.local/share/fonts/${font}
    rm "/tmp/${file_name}"
done

fc-cache


