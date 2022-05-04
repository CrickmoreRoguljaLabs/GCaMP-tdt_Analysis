dir1 = getDirectory("Choose Source Directory ");
dir2 = getDirectory("Choose Destination Directory ");
list = getFileList(dir1);
setBatchMode(true);
  for (i=0; i<list.length; i++) {
     showProgress(i+1, list.length);
     open(dir1+list[i]);
     run("Z Project...", "projection=[Max Intensity]");
     run("Split Channels");
	 saveAs("Tiff", dir2+list[i]+"_red");
     close();
     saveAs("Tiff", dir2+list[i]+"_green");
     close();
  }