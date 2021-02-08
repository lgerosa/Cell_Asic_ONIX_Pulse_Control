function [cOut,sReg] = singleFlow(cOut,sReg,Valve,frate,time)
%SINGLEFLOW turns "on" a single valve for a certain time
%Inputs:
%- Valve - Index of valve to be turned on (example 2 for "V2")
%- Frate - flow rate to be set in psi, frate is the total flow distribuited in half to the two symmetric channels
%- Time - sets the time it should stay open in minutes

%output comand for a symmetic switch
cOut=[cOut sprintf('%% Switch on V%d to %3.1f psi for %3.1f mins\n',Valve,frate,time)];
cOut=setflow(cOut,sReg,frate);
cOut=openVn(cOut,sReg,Valve);
cOut=waitn(cOut,sReg,time);
cOut=closeVn(cOut,sReg,Valve);
cOut=newline(cOut,sReg);

%update structure registry
sReg(end+1).Valves=Valve;
sReg(end).frate=frate;
sReg(end).time=time;


end

