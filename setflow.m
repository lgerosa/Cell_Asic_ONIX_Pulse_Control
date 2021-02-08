function [cOut,sReg] = setflow(cOut,sReg,n)
%SETFLOW sets the flow n to both X and Y in psi

cOut=[cOut sprintf('setflow X %5.6f\n',n)];
cOut=[cOut sprintf('setflow Y %5.6f\n',n)];

end

