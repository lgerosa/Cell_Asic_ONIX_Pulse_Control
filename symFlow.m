function [cOut,sReg] = symFlow(cOut,sReg,Valves,frate,time)
%symFlow turns "on" two valves for  a certaub time in parallel
%Inputs:
%- Valves(1) Valves(2) - index of valves to be turned on/off together (example 2 for "V2" and 5 for "V5")
%- Frate - flow rate to be set in psi, frate is the total flow distribuited in half to the two symmetric channels
%- Time - sets the time it should stay open in minutes

%output comand for a symmetic switch
cOut=[cOut sprintf('%% Symmetic switch of V%d,V%d to %3.1f psi for %3.1f mins\n',Valves(1),Valves(2),frate,time)];
cOut=setflow(cOut,sReg,frate/2);
cOut=openVn(cOut,sReg,Valves(1));
cOut=openVn(cOut,sReg,Valves(2));
cOut=waitn(cOut,sReg,time);
cOut=closeVn(cOut,sReg,Valves(1));
cOut=closeVn(cOut,sReg,Valves(2));
cOut=newline(cOut,sReg);

%update structure registry
sReg(end+1).Valves=Valves;
sReg(end).frate=frate/2;
sReg(end).time=time;

end

