//This code was used to analyze fluorescent puncta numbers at 24hpf and 48hpf embryos (Figure 4 d,e)
//To analyze the embryos, I drew ROIs around the embryos which excluded the autofluorescent yolk sack.
//In the apply_roi function, "input_directory" contains the tif images and roi files for each embryo.
//"output_directory" is where you want the resulting csv files, ROIset.zip files, and thesholded images to be generated. 

//Change the below line of code to your input and output folders
apply_roi("/Users/davidtyrpak/Dropbox/Zebrafish_Manuscript/Data/Figure4_E/GFP-V96/48hr", "/Users/davidtyrpak/Dropbox/Zebrafish_Manuscript/Data/Figure4_E/GFP-V96/48hr/analysis");


function apply_roi(input_directory, output_directory) {

file_list = getFileList(input_directory);

roi_array = newArray(); //the array that stores the ROI file names
image_array = newArray(); //the array stat stores the cropped image names

for(i = 0; i < file_list.length; i++){
	

	if (endsWith(file_list[i], ".roi")){ //find the roi files
		roi_array = Array.concat(roi_array, file_list[i]);
	}

	if (endsWith(file_list[i], ".tif")) { //find the tiff images
		image_array = Array.concat(image_array, file_list[i]);
	}
}



//test that roi_array and image_array are the same length
if (roi_array.length != image_array.length){

	Array.print(roi_array);
	Array.print(image_array);
	
	exit("roi_array and image_array are differing lengths! Check your input folder.")
}

//Open up each roi and apply it to its corresponding image
for(i = 0; i < roi_array.length; i++){
open(input_directory + "/" + image_array[i]);
name = getTitle; 
dotIndex = lastIndexOf(name, "."); 
title = substring(name, 0, dotIndex); 


open(input_directory + "/" + roi_array[i]);
waitForUser( "Pause", "If ROIs are correct, press OK. If not press kill");
run("Subtract Background...", "rolling=5");
setThreshold(1000, 65535);
run("Convert to Mask");

//anlyze particles
open(input_directory + "/" + roi_array[i]);
run("Analyze Particles...", "  show=Outlines display exclude clear add in_situ");

if ( nResults > 0){
selectWindow("Results"); 
saveAs("Results", output_directory + "/" + title + ".csv");//Analyze particle results
run("Close"); 
roiManager("Save", output_directory + "/" + title + "RoiSet.zip"); //Roiset
selectWindow(name);
saveAs("Tiff", output_directory + "/" + title);
	
}

else{ //If your thresholded image is blank, your analyze particles results table will be empty and you will not generate an ROI set.
	//So just select the thresholded blank image and save it. That is what this else block is doing.

selectWindow(name);
saveAs("Tiff", output_directory + "/" + title);
}

while (nImages>0) { // this while loop closes the open windows
          selectImage(nImages); 
          close(); 
      } 	





}
// This below code closes the final ROI Manager window. Note that the Console window will still stay open. I havent found a way to close it within the program yet. 
//But it is not an error.
selectWindow("ROI Manager"); 
run("Close"); 


}

