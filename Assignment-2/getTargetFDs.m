function getTargetFDs(GrayImg, Sample1, sizeofFD,rows,columns)
[SampleFD]=getSampleFD(Sample1, sizeofFD);%Get Fourier descriptor from sample images
%Turn the gray image into balck/white image
GrayImg=rgb2gray(GrayImg);%rgb->gray
bwimg=imbinarize(GrayImg, 'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);%binarize the gray image
sizex=size(bwimg);%sizex is the size of bwimg
for i=1:sizex(1)%exchange the black and white to find boundary
    for j=1:sizex(2)
        if bwimg(i,j)==1
            bwimg(i,j)=0;
        elseif bwimg(i,j)==0
            bwimg(i,j)=1;
        end
    end
end
Bd=findBoundary(bwimg,8,'cw');%find the boundary
img1=zeros(rows,columns);%the same size as the original image
df=zeros(28,1);
for n=1:28 %there are 28 marks in the original image
    BdPoint=Bd{n};%the n-th boundary detected of the 28 boudaries.
    fx=BdPoint(:,1);%the x and y
    fy=BdPoint(:,2);
    noPts=length(fx);%the number of points of a boundary
    ii = sqrt(-1);%the imaginary i
    U=fx+fy*ii;%Turn the 2D coordinates of edge into 1D imaginary number
    if noPts>sizeofFD 
        [F1]=extractFD(U);%Extracts the Fourier descriptor
        [F2]=normaliseFD(F1);%Normialize the Fourier descriptor
        F=resizeFD(F2,sizeofFD);%Resize the Fourier descriptot
        diff1=compareFD(F,SampleFD);%Caculate the differences
        df(n)=diff1;
        for m=1:noPts
            img1(fx(m),fy(m),1)=255;%mark in red
        end
    end
    if df(n)<0.031   %according to diff1 of the 28 boundaries,the four '7' are the smallest.
        for k=1:noPts
            img1(fx(k),fy(k),3)=255;%mark a different color
        end
    end
end
imshow(img1);%show the result
end