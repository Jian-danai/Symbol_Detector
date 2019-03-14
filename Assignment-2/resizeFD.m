% F: The Fourier descriptor of a contour
% G: The a resized Fourier descriptor with n elements
% Processes F to obtain G, which has been shortened to contain only n elements (assume F has more than n elements).
function [G]=resizeFD(F, n)
G=F;
len=length(F);
if (len>n)
    T1=fftshift(F);
    p=round((len-n)./2);
    T2=T1(p+1:p+n);
    G=ifftshift(T2);
end
end