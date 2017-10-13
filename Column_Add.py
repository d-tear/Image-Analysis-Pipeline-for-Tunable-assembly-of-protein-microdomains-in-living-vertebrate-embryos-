# -*- coding: utf-8 -*-
"""
Created on Thu Oct 12 19:43:52 2017

@author: davidtyrpak

This code adds the Nearest neighbor Densities column from the one imagej results csv file to 
its corresponding analyze particle results csv file
"""
import pandas as pd

import os
import glob

path = "/Users/davidtyrpak/Desktop/SI/10042017/Analysis" ##This is the location where your NND results file and analyze particle files are located
extension = "csv"
os.chdir(path)
result = [i for i in glob.glob('*.{}'.format(extension))] ##find all the csv file in the directory

for file in result:
    if os.path.isfile(os.path.join(path,file)) and '_NND' in file: ##find all the csv files with _NND in their file name
        
        df_NND = pd.read_csv(file) ##convert NND csv file to pandas df
        
        nrows = df_NND.shape[0] ##find the number of rows in the dataframe
        
        
        NND_values = df_NND.iloc[0:nrows, 1].values ##extract the NND column

        NND_file = file.split("_NND") ##find the corresponding analyze particle csv file name (i.e. the filename before _NND)
        
        analyze_csv = "".join(NND_file) ##this is the analyze particle csv file name
        
        df_analyze = pd.read_csv(analyze_csv) ##convert to pandas df
        
        df_analyze["NND (um)"] = NND_values ##Create new column named "NND (um)" and add NND column values to it
        
        df_analyze.to_csv("MergedResults_" + analyze_csv)  ## save the analyze particles df with the new NND column as a csv file
        
        
        
        




