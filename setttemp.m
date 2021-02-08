function [cOut,sReg] = setttemp(cOut,sReg, n)
%SETTTEMP sets the temperature as n

cOut=[cOut sprintf('settemp %5.6f\n',n)];

end

