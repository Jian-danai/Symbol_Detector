function [F]=extractFD(U)
c=sum(U) ./ length(U);%Shift to Center
T=U-c;
aT=angle(T);%Sort by angle
[~, aTI]=sort(aT);
for i=1:length(aTI)
    sT(i)=U(aTI(i));
end
if mod(length(aTI),2)==0  %Fit the case, which Length of U is not sufficient
    sT=[sT sT(1)];
end
F=fft(sT);%Output the result
end