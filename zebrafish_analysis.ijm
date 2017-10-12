//This code analyzes the zebrafish images
//output_directory, min_threshold, max_threshold

//ensure Zeiss CZI format is Windowless and Enabled in Bio-Formats Plugin: 
//Plugins > Bio-Formats > Bio-Formats Plugins Configuration, then pick the format from the list (i.e. Zeiss CZI) and make sure the “Windowless” option is checked
//and that "Enabled" is checked.

function analyze_embryo(input_directory, output_directory) {



file_list = getFileList(input_directory);

for(i = 0; i < file_list.length; i++){

	if (endsWith(file_list[i], ".czi")){



open(input_directory + "/" + file_list[i]);


name = getTitle; 
dotIndex = indexOf(name, "."); 
title = substring(name, 0, dotIndex); 


setThreshold(33000, 65535); //Change 33000 to your desired minimum threshold

run("Make Binary");
run("Analyze Particles...", "  show=Outlines display exclude clear add in_situ");

saveAs("Results", output_directory + "/" + title + ".csv"); //Analyze particle results

roiManager("Save", output_directory + "/" + title + "_RoiSet.zip"); //Roiset
selectWindow(name);
saveAs("Tiff", output_directory + "/" + title);



while (nImages>0) { // this while loop closes the open windows
          selectImage(nImages); 
          close(); 
      } 	

	}
	
}



}


analyze_embryo("/Users/davidtyrpak/Desktop/V96/10042017", "/Users/davidtyrpak/Desktop/V96/10042017/Analysis")
