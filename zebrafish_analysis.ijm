//This code analyzes the zebrafish images
//output_directory, min_threshold, max_threshold

function analyze_embryo(input_directory) {

file_list = getFileList(input_directory);

for(i = 0; i < file_list.length; i++){


open(input_directory + "/" + file_list[i]);


name = getTitle; 
dotIndex = indexOf(name, "."); 
title = substring(name, 0, dotIndex); 


setThreshold(33000, 65535); //Change 33000 to your desired minimum threshold

run("Make Binary");
run("Analyze Particles...", "  show=Outlines display exclude clear add in_situ");

saveAs("Results", input_directory + "/" + title + ".csv");

roiManager("Save", input_directory + "/" + title + "RoiSet.zip");

	
}

}
//for(i = 0; i < list.length; i++)
//action

//for(i = 0; i < file_list.length; i++){
//selectImage(i+1);
//name  = geTitle;
//print(name)
//}


//}
analyze_embryo("/Users/davidtyrpak/Desktop/V96/10042017")
