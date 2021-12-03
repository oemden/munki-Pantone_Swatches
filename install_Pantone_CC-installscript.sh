#!/bin/sh
##
# oem at oemden dot com - Munki preflight Check script
#
# Writes Names conditions : Illustrator presence for Illustrator plugin install
# as now CC apps are installed by users... 
# we need to check the presence of the Apps for plugins to get installed or not.
## - - - - - - - - - - - - - - - - - - - - - - -
#
clear
version="1.4" # no more v3 ajout multiple files & Ajout CC 2021
#

####### PREREQ ####### 
## Prefix all paths with $TARGET

if [ "$3" == "/" ]; then
    TARGET=""
else
    TARGET="$3"
fi

## Check Sudo
if [ `id -u` != 0 ]
then
	echo "You must run this script as root."
	exit 1
fi

### MUNKISTUFF
DEFAULTS="${TARGET}"/usr/bin/defaults
MUNKI_DIR=$("${DEFAULTS}" read "${TARGET}"/Library/Preferences/ManagedInstalls ManagedInstallDir)
COND_DOMAIN="${MUNKI_DIR}/ConditionalItems"

### PKGSTUFF
TEMP_FOLDER="${TARGET}/tmp/PANTONE/"

### APPSTUFF
#CC_VERSIONS=( "2020")
#ADOBE_APPS=( "Adobe Illustrator" )
CC_VERSIONS=( "2017" "2018" "2019" "2020" "2021" "2022" )
ADOBE_APPS=( "Adobe InDesign" "Adobe Illustrator" "Adobe Photoshop" )
PANTONE_FILES=( "PANTONE Solid Uncoated-V4" "PANTONE Solid Coated-V4" "PANTONE Metallics Solid Coated" "PANTONE CMYK Uncoated" "PANTONE CMYK Coated" )

####### SCRIPT START ######

## Check by App
for ADOBE_APP in "${ADOBE_APPS[@]}" ; do #01

 ## Check by Version
 for CC_VERSION in "${CC_VERSIONS[@]}" ; do #02
	echo 
	echo "	====  ====  ====  ====  ====  ====  ====  ====  ====  ===="
 	echo " 	====  PANTONE-V4 plugin presence Check for ${ADOBE_APP} Starting ===="
	echo "	====  ====  ====  ====  ====  ====  ====  ====  ====  ===="
	echo
	#determiner la swatch
	if [[ "${ADOBE_APP}" =~ "Adobe Illustrator" ]] ; then

     ## Define AI paths with the new modifications of CC 2020 Version
	 if [[ "${CC_VERSION}" -le 2019 ]] ; then
  	  APP_CC_DIRNAME="Adobe Illustrator CC"
     elif [[ "${CC_VERSION}" -ge 2020 ]] ; then
      APP_CC_DIRNAME="Adobe Illustrator"
	 fi

    echo "	[Adobe App is Adobe Illustrator version ${CC_VERSION}]"
	# Illustrator wants .acb file
	ADOBEAPP_CC_COLOR_PATH="${TARGET}/Applications/${APP_CC_DIRNAME} ${CC_VERSION}/Presets.localized/fr_FR/Nuancier/Catalogues de couleurs/"
	ADOBE_CC_APP="${TARGET}/Applications/${APP_CC_DIRNAME} ${CC_VERSION}/Adobe Illustrator.app"
	PANTONE_FILES_EXT=".acb"

	elif [[ "${ADOBE_APP}" =~ "Adobe Photoshop" ]] ; then

     ## Define AI paths with the new modifications of CC 2020 Version
	 if [[ "${CC_VERSION}" -le 2019 ]] ; then
  	  APP_CC_DIRNAME="Adobe Photoshop CC ${CC_VERSION}"
     elif [[ "${CC_VERSION}" -ge 2020 ]] ; then
      APP_CC_DIRNAME="Adobe Photoshop ${CC_VERSION}"
	 fi

    echo "	[Adobe App is Adobe Photoshop version ${CC_VERSION}]"
	# Photoshop wants .aco file
	ADOBEAPP_CC_COLOR_PATH="${TARGET}/Applications/${APP_CC_DIRNAME}/Presets/Color Swatches/"
	ADOBE_CC_APP="${TARGET}/Applications/${APP_CC_DIRNAME}/${APP_CC_DIRNAME}.app"
	PANTONE_FILES_EXT=".aco"

	elif [[ "${ADOBE_APP}" =~ "Adobe InDesign" ]] ; then

     ## Define AI paths with the new modifications of CC 2020 Version
	 if [[ "${CC_VERSION}" -le 2019 ]] ; then
  	  APP_CC_DIRNAME="Adobe InDesign CC ${CC_VERSION}"
     elif [[ "${CC_VERSION}" -ge 2020 ]] ; then
      APP_CC_DIRNAME="Adobe InDesign ${CC_VERSION}"
	 fi

    echo "	[Adobe App is Adobe InDesign version ${CC_VERSION}]"
	# InDesign wants .acb file
	ADOBEAPP_CC_COLOR_PATH="${TARGET}/Applications/${APP_CC_DIRNAME}/Presets/Swatch Libraries/"
	ADOBE_CC_APP="${TARGET}/Applications/${APP_CC_DIRNAME}/${APP_CC_DIRNAME}.app"
	PANTONE_FILES_EXT=".acb"

   fi
   echo

   for PANTONE_FILE in "${PANTONE_FILES[@]}" ; do #03
    PANTONE_SWATCH="${PANTONE_FILE}${PANTONE_FILES_EXT}"
    PANTONE_SWATCH_PATH="${ADOBEAPP_CC_COLOR_PATH}${PANTONE_SWATCH}"
    echo "	PANTONE_SWATCH: ${PANTONE_SWATCH}"
    echo "	PANTONE_SWATCH_PATH: ${PANTONE_SWATCH_PATH}"
    echo "	ADOBE_CC_APP: ${ADOBE_CC_APP}"
    echo 

	if [[ -e "${ADOBE_CC_APP}" ]] ; then
		  ## MUNKIPREFLIGHT CHECK 
		 if [[ -e "${PANTONE_SWATCH_PATH}" ]] ; then
		   echo " - - - - - - - - - - - "
		   echo "  == ${PANTONE_SWATCH} is installed for ${ADOBE_APPS} version ${CC_VERSION}"
		   echo " - - - - - - - - - - - "
		 else
		   echo " - - - - - - - - - - - "
		   echo "  == Missing ${PANTONE_SWATCH}; need to install plugin now for ${ADOBE_APP}"
		   echo " - - - - - - - - - - - "

		   # InstallPantoneSwatches=1
		   ## install profile now.
		   SOURCE_FOLDER="${TEMP_FOLDER}"
		   SOURCE_FILE="${PANTONE_FILE}${PANTONE_FILES_EXT}"
		   DEST_FOLDER="${ADOBEAPP_CC_COLOR_PATH}"
		   DEST_FILE="${DEST_FOLDER}${SOURCE_FILE}"
	    	## Copy the swatch
	   		cp -a "${SOURCE_FOLDER}${SOURCE_FILE}" "${DEST_FILE}"
 		 fi
	else 
		  echo " ${APP_CC_DIRNAME} is not here" 
	fi

  done #03
 done #02
done #01

exit 0

####### SCRIPT STOP #####


# v 1.3 Apps check OK!

