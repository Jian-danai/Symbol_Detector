%main function
template = imread('template.bmp');%read the template and image
Img = imread('2018.bmp');
size_Img=size(Img);%calculate the size of the original image
rows=size_Img(1);
columns=size_Img(2);
sizeofFD = 32;%choose the number of points used to be compared.%8-12%
getTargetFDs(Img, template, sizeofFD,rows,columns);