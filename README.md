# Image-Analysis-Pipeline-for-Tunable-assembly-of-protein-microdomains-in-living-vertebrate-embryos-
This repository contains FIJI and Python scripts used to analyze GFP-ELP assembly inside of zebrafish embryos. The code was used
in the publication "Tunable assembly of protein-microdomains in living vertebrate embryos"
https://onlinelibrary.wiley.com/doi/abs/10.1002/adbi.201800112

Pipeline 1: FIJI Macro and Python code for Particles Sizes in 4 ~ 5 hpf zebrafish embryos (Figure 4 b,d). 

Code: zebrafish_analysis.ijm, Column_Add.py (Python 3)

In the first step of Pipeline 1, use zebrafish_analysis.ijm and specify your input folder (where your images are located) 
and your output folder (where you want the results to be located.) 
Our images were 1024 by 1024 grayscale .czi files (zeiss format). 
However, the macro can also handle other image formats (see line 19 to change to input image format).

For each input image, zebrafish_analysis.ijm will generate four output files: 
1) An RoiSet.zip file containing the ROIs from the input image, 
2) A .csv file containing the analyze particle results for the input image (“InputImageName.csv”)
3) A .tif file showing where the ROIs/particles are located in the input image (although you can also open 
the RoiSet.zip file and apply it to the input image to see where the code believes the particles are located), 
4) A NND.csv file which contains nearest neighbor distances for each particle in the RoiSet (“InputImageName_NND_.csv"). 

The NND code was written by Yuxiong Mao and can be found here: 
https://icme.hpc.msstate.edu/mediawiki/index.php/Nearest_Neighbor_Distances_Calculation_with_ImageJ

In the second step of Pipeline 1, use Column_Add.py to append the 
nearest neighbor distances column from InputImageName_NND_.csv to InputImageName.csv. 
The resulting .csv file will have the name “Mergedresults_InputImageName.csv”

Pipeline 2: FIJI Macro for GFP-ELP particle numbers in 24hpf and 48hpf zebrafish embryos (Figure 4 c,e). 

Code: process.ijm

To use this code you will have to draw ROIs around the embryo, excluding the autofluorescent yolk and underbelly of the embryo (see the example images I added: 24hpf.png, 48hpf.png). The .roi files need to be in the same folder as your input images. Our images were 1344 by 1024 grayscale tiff images.

This code will produce three files for each input image:
1) A .csv file containing the analyze particle results for the input image (“InputImageName.csv”)
2) A .tif file showing where the ROIs/particles are located in the input image (although you can also open 
the RoiSet.zip file and apply it to the input image to see where the code believes the particles are located)
3) An RoiSet.zip file containing the ROIs from the input image ("InputImageNameROIset.zip")







