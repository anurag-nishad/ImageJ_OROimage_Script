dir1 = getDirectory("Choose Source Directory ");
dir2 = getDirectory("Choose Destination Directory ");
list = getFileList(dir1);
setBatchMode(true);
for (i=0; i<list.length; i++)
{
	filename = dir1 + list[i];
	if (endsWith(filename, "tif"))
	{
		open(filename);
		selectImage(list[i]);
		run("8-bit");
		setAutoThreshold("Default");
		//run("Threshold...");
		//setThreshold(0, 177);
		setOption("BlackBackground", false);
		run("Convert to Mask");
		run("Watershed");
		run("Set Scale...", "distance=0.7 known=1 unit=um");
		run("Set Measurements...", "area shape redirect=None decimal=3");
		run("Analyze Particles...", "size=0-1000 circularity=0.70-1.00 show=Overlay display exclude clear");
		selectWindow("Results");
		saveAs("Results", dir2+File.nameWithoutExtension+".csv");
	}
}
run("Close");