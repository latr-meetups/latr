## CREATE DATABASE
# Prasanna Sritharan, June 2022
#
# Create a clean database of C3D files from the FORCe database.


library(tidyverse)


# root folder
rootfolder <- "C:\\Users\\Prasanna\\Documents\\data\\FORCe\\inputDatabase"

# find all the C3D files in the root folder, including subdirectories
fileslist <- list.files(rootfolder, pattern=".c3d", recursive=TRUE, full.names=TRUE)


# just get the file names, discard the path to the filename
filenames <- fileslist %>% basename()

# root folder for the new database, create if it doesn't exist
rootfolder <- "C:\\Users\\Owner\\Documents\\data\\FORCe\\outputDatabase"
if (!dir.exists(rootfolder)) {
  dir.create(rootfolder)
}


# iterate through each file and build the new database tree
for (n in 1:length(fileslist)) {
  
  # split the file name into tokens based on the delimiter
  filetoks <- filenames[n] %>% str_split(pattern="\\.c3d") %>% sapply("[[", 1) %>% str_split(pattern="_") 
  
  # get the subject and trial, convert to upper case for consistency
  subj = toupper(filetoks[[1]][1])
  trial = toupper(filetoks[[1]][2])
  
  # create the subject folder if it doesn't exist
  subjfolder = file.path(rootfolder, subj)
  if (!dir.exists(subjfolder)) {
    dir.create(subjfolder)
  }
  
  # create the trial folder if it doesn't exist
  trialfolder = file.path(subjfolder, trial)
  if (!dir.exists(trialfolder)) {
    dir.create(trialfolder)
  } 
  
  # copy the C3D file from the raw database to the new database
  newfilepath = file.path(trialfolder, toupper(filenames[n]))
  file.copy(fileslist[n], newfilepath)
  
}
  
