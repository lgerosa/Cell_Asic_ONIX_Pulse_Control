function [cOut,sReg] = headerProtocol(cOut,sReg,title)
%HEADER Summary of this function goes here
%   Detailed explanation goes here

cOut=[cOut sprintf('%% M04S Microfluidic plate\n')];
cOut=[cOut sprintf('%% Script generated using MATLAB by Luca Gerosa (Sorger Lab, HMS)\n')];
cOut=[cOut sprintf('%% Protocol title: ''%s''\n',title)];
cOut=[cOut sprintf('%% Generated on date: %s\n',datestr(date()))];
cOut=newline(cOut,sReg);
cOut=[cOut sprintf('%% START PROTOCOL\n')];
cOut=newline(cOut,sReg);
%comOut=[comOut setttemp(37)];
%comOut=[comOut newline()];

end

