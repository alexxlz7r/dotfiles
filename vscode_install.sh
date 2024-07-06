#!/bin/bash

wget https://code.visualstudio.com/sha/download\?build\=stable\&os\=linux-x64 -N -O code-stable.tar.gz
currentDir=$(pwd)
vscode_dir=~/Projects/vscode
bin_dir=~/bin

mkdir -p $vscode_dir

# MS Code Stable
msCodeInst=(code-eff code-python code-rust code-stable)

for codeInst in "${msCodeInst[@]}"; do
	vscode_inst_dir=$vscode_dir/$codeInst
	mkdir -p $vscode_inst_dir
	find $vscode_inst_dir -mindepth 1 ! -regex "^./${vscode_inst_dir}/data\(/.*\)?" -delete
	echo "Extract code into ${vscode_inst_dir}"
	tar -zxf code-stable.tar.gz -C $vscode_inst_dir --strip-components=1
	mkdir -p $vscode_inst_dir/data
	echo "Create desktop file for $codeInst"
	if [[ -e ~/.local/share/applications/${codeInst}.desktop ]]; then
		rm ~/.local/share/applications/${codeInst}.desktop
	fi
	{
		echo "[Desktop Entry]"
		echo "Name=${codeInst}"
		echo 'Comment=Code Editing. Redefined.'
		echo 'GenericName=Text Editor'
		# echo "Exec=${currentDir}/${codeInst}/code %F"
		echo "Exec=${vscode_inst_dir}/code %F"
		echo 'Icon=com.visualstudio.code'
		echo 'Type=Application'
		echo 'StartupNotify=false'
		echo 'StartupWMClass=Code'
		echo 'Categories=Utility;TextEditor;Development;IDE;'
		echo 'MimeType=text/plain;inode/directory;'
		echo 'Actions=new-empty-window;'
		echo 'Keywords=vscode;'
		echo ''
		echo 'X-Desktop-File-Install-Version=0.23'
		echo ''
		echo '[Desktop Action new-empty-window]'
		echo 'Name=New Empty Window'
		# echo "Exec=${currentDir}/${codeInst}/code --new-window %F"
		echo "Exec=${vscode_inst_dir}/code --new-window %F"
		echo 'Icon=com.visualstudio.code'
	} >~/.local/share/applications/${codeInst}.desktop

	ln -s -f ${vscode_inst_dir}/bin/code $bin_dir/${codeInst}

done

rm code-stable.tar.gz
