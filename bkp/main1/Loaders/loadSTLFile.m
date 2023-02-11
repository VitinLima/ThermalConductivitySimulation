close all;
clear all;
clc;

FID = fopen("mesh.stl");

name = fgets(FID, 80);

if strncmp(name, "solid ", 6)
	disp("File in ASCII format.");
	loadSTLASCIIFile;
else
	disp("File in Binary format.");
	loadSTLBinaryFile;
end

fclose(FID);

plot3(P(:,1),P(:,2),P(:,3), 'marker', '*', 'linestyle', 'none');