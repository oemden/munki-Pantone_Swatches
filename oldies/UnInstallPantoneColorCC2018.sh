#!/bin/bash

#PANTONE COLOR Install in CC 2018
# V0.3.1 - CC 2018 Uninstall Script
# Needs to have swatches from PANTONE App and check for CC App too

################## CC2018 Apps ################## 
INDESIGN_CC2018_APP_PATH="/Applications/Adobe InDesign CC 2018.app"
# Illustrator wants .acb file
ILLUSTRATOR_CC2018_APP_PATH="/Applications/Adobe Illustrator CC 2018.app"
# Photoshop wants .aco file
PHOTOSHOP_CC2018_APP_PATH="/Applications/Adobe Photoshop CC 2018.app"
################## Swatches path
# InDesign wants .acb file
INDESIGN_CC2018_COLOR_PATH="/Applications/Adobe InDesign CC 2018/Presets/Swatch Libraries/"
# Illustrator wants .acb file
ILLUSTRATOR_CC2018_COLOR_PATH="/Applications/Adobe Illustrator CC 2018/Presets.localized/fr_FR/Nuancier/Catalogues de couleurs/"
# Photoshop wants .aco file
PHOTOSHOP_CC2018_COLOR_PATH="/Applications/Adobe Photoshop CC 2018/Presets/Color Swatches/"
#TEMP_FOLDER="/tmp/PANTONE-V3/"

function check_path {
	echo
	#$1 is APPPATH
	#$2 is extension
	if [[ -d "${1}" ]] ; then
		echo "${1} OK"; 
		#open_Folder "$1" ##DEV ONLY
		#check_CC2018 "${2}"
		if [[ -z "${2}" ]] ; then
			echo "${2} OK" ; 
			#open_Folder "$1" ##DEV ONLY
			remove_Swatches "${1}" 
		else
		echo "${2} KO"
	fi
	else
		echo "${1} KO"
	fi
}

function open_Folder  {
	open "${1}"
}

function remove_Swatches {
	echo
	#$1 is the APP
	#$2 is the extension aka aco or acb
	rm -Rf "${1}"/*-V3.${2} 
}

function Check_Paths_CC2018 {
	check_path "${INDESIGN_CC2018_COLOR_PATH}" "${INDESIGN_CC2018_APP_PATH}"
	check_path "${ILLUSTRATOR_CC2018_COLOR_PATH}" "${ILLUSTRATOR_CC2018_APP_PATH}"
	check_path "${PHOTOSHOP_CC2018_COLOR_PATH}" "${PHOTOSHOP_CC2018_APP_PATH}"
}

function CleanUp {
#	rm -Rf /private/tmp/PANTONE
	rm -Rf "${TEMP_FOLDER}"
}

Check_Paths_CC2018
sleep 1
CleanUp

exit 0