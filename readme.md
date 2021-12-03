## Installs Pantone_Swatches for Adobe CC Apps.

This will install Adobe Swatches for Adobe Illustrator, inDesign and Photoshop

### Pantone_Swatches_CC.pkgproj

I use **Packages.app**.

but you can create your package with your favorite tools with: 

- Payload containing swatches. 
- script as postinstall script.

Import in Munki with the below install check script.
if you want to.

#### • install_Pantone_CC-installscript.sh 

poWill install swatches for each and every Adobe apps.

Expect swatches to be in `/private/tmp/PANTONE`

> Note: 
> 
> You must first install swatches on a master workstation first to get the .aco and .acb swatches files.

* PANTONE Solid Uncoated-V4.aco
* PANTONE Metallics Solid Coated.aco
* PANTONE Solid Coated-V4.acb
* PANTONE Solid Coated-V4.aco
* PANTONE Solid Uncoated-V4.acb
* PANTONE CMYK Uncoated.aco
* PANTONE Metallics Solid Coated.acb
* PANTONE CMYK Uncoated.acb
* PANTONE CMYK Coated.aco
* PANTONE CMYK Coated.acb
* etc...




#### • install_PantoneColorCC_munkiPreflightcheck.sh

Munki "install check script". 

If a new version of Adobe Illustrator, 
inDesign or Photoshop is installed, munki will run the install again.