function [ cOut,sReg ] = waitn(cOut,sReg,n)
%WAITN prints the wait command with the corresponding time in minutes

cOut= [cOut sprintf('wait %5.6f\n',n)];

end

