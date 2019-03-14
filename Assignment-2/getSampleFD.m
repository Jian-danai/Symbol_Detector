function [F]=getSampleFD(GrayImg, sizeofFD)
GrayImg=rgb2gray(GrayImg);%Turn the gray image into balck/white image
bwimg=imbinarize(GrayImg, 'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);%binarize the gray image
sizex=size(bwimg);%sizex is the size of bwImg
for i=1:sizex(1)%exchange the black and white to find boundary
    for j=1:sizex(2)
        if bwimg(i,j)==1
            bwimg(i,j)=0;
        elseif bwimg(i,j)==0
            bwimg(i,j)=1;
        end
    end
end
Bd=findBoundary(bwimg,8,'cw');%find the boundaries
BdPoint=Bd{1};%the only one boundary detected->the template
fx=BdPoint(:,1);%find the x and y
fy=BdPoint(:,2);
ii=sqrt(-1);
U = fx + fy*ii;%Turn the 2D coordinates of edge into 1D imaginary number
[F1]=extractFD(U);%Extracts the Fourier Descriptor of a contour
%Normalize the Fourier Descriptor, which is invariant to translation,rotation and scaling of the original contour
[F2]=normaliseFD(F1);
F=resizeFD(F2, sizeofFD);%Resize the Fourier Descriptor into assigned length
end