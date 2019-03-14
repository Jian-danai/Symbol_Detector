function [diff]=compareFD(F, G)%calculate the difference between F anf G
diff=-1;
if (length(F) == length(G))
    diff=sum((abs(F-G)) .^ 2);
end
end