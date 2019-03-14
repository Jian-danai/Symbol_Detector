function [G]=normaliseFD(F)
T=F;
T(1)=0;%Translation Invariance
si=abs(T(2));
T=T ./ si;%Scale Invariance
T=abs(T);%Rotation and changes in starting point
G=T;%Output the result
end