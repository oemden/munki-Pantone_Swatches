#!/bin/bash

#PANTONE COLOR Install in CS6
# V0.2
# Needs to have swatches from PANTONE App (from laptop PR2i)

# InDesign wants .acb file
INDESIGN_COLOR_PATH="/Applications/Adobe InDesign CS6/Presets/Swatch Libraries/"
# Illustrator wants .acb file
ILLUSTRATOR_COLOR_PATH="/Applications/Adobe Illustrator CS6/Presets.localized/fr_FR/Nuancier/Catalogues de couleurs/"
# Photoshop wants .aco file
PHOTOSHOP_COLOR_PATH="/Applications/Adobe Photoshop CS6/Presets/Color Swatches/"
TEMP_FOLDER="/tmp/PANTONE/"


function check_path {
	echo
	#$1 is APPPATH
	#$2 is extension
	if [[ -d "$1" ]] ; then
		echo "$1 OK" && echo " .$2" ; 
		#open_Folder "$1" ##DEV ONLY
		copy_Swatches "$1" "$2"
	else
		echo "$1 KO"
	fi
}

function open_Folder  {
	open "$1"
}

function copy_Swatches {
	echo
	#$1 is the APP
	#$2 is the extension aka aco or acb
	cp -a "$TEMP_FOLDER"/*.$2 "$1"
}

function Check_Paths {
	check_path "$INDESIGN_COLOR_PATH" "acb"
	check_path "$ILLUSTRATOR_COLOR_PATH" "acb"
	check_path "$PHOTOSHOP_COLOR_PATH" "aco"
}

function CleanUp {
	rm -Rf /private/tmp/PANTONE
}

Check_Paths
sleep 1
CleanUp



exit 0