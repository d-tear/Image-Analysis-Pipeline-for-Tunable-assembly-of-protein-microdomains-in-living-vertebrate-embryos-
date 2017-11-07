//This code analyzes the zebrafish images
//output_directory, min_threshold, max_threshold

//ensure Zeiss CZI format is Windowless and Enabled in Bio-Formats Plugin: 
//Plugins > Bio-Formats > Bio-Formats Plugins Configuration, then pick the format from the list (i.e. Zeiss CZI) and make sure the “Windowless” option is checked
//and that "Enabled" is checked.




function analyze_embryo(input_directory, output_directory) {



file_list = getFileList(input_directory);

for(i = 0; i < file_list.length; i++){

	if (endsWith(file_list[i], ".czi")){ //Change ".czi" to your images' file format (e.g. ".tif", ".png", etc)



open(input_directory + "/" + file_list[i]);


name = getTitle; 
dotIndex = indexOf(name, "."); 
title = substring(name, 0, dotIndex); 


setThreshold(33000, 65535); //Change 33000 to your desired minimum threshold

run("Make Binary");
run("Analyze Particles...", "  show=Outlines display exclude clear add in_situ");


if ( nResults > 0){
	
run("Nnd ");
selectWindow("Nearest Neighbor Distances");
saveAs("Results", output_directory + "/" + title + "_NND" + ".csv"); 
selectWindow(title + "_NND" + ".csv");
run("Close"); 

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


}

// This below code closes the final ROI Manager window. Note that the Console window will still stay open. I havent found a way to close it within the program yet. 
//But it is not an error.
selectWindow("ROI Manager"); 
run("Close"); 



}

//change the input and output file paths to your folders
analyze_embryo("/Users/davidtyrpak/Desktop/test", "/Users/davidtyrpak/Desktop/test/analysis")
