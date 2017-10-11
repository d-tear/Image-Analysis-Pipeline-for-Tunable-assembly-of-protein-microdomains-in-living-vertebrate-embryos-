//This code analyzes the zebrafish images
//output_directory, min_threshold, max_threshold

function analyze_embryo(input_directory) {

file_list = getFileList(input_directory);
print(file_list.length);

for(i = 0; i < file_list.length; i++){


open(input_directory + "/" + file_list[i]);

	
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
