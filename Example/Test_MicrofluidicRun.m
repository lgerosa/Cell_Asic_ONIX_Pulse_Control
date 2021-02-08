function [cOut,sReg,sTimeLine,sPlateLayout] = Test_MicrofluidicRun()

%% initialize text and register of protocol
cOut='';
sReg=[];

%% define the valves to use symmetrically
VSym1=[3 4]; %first two symmetric valves
VSym2=[2 5]; %second two symmetric valves
frate=1; %rate of normal operation
frbust=5; %rate of fast burst
tbust=1; %time of fast burst 

%% add header protocol
cOut=headerProtocol(cOut,sReg,'Example of a microfluidic run');

%% wait ten minutes before flow from V2-5 and V3-4, growth from media in V1
%cOut=comment(cOut,sReg,'Wait 10 mins before starting protocol'); 
%cOut=waitn(cOut,sReg,10); 
%cOut=newline(cOut,sReg); 

%% start with pulses sequence

%start with a flow from V2 and V5 of 30 mins
cOut=symFlow(cOut,sReg,VSym2,frate,30);

%set the pulse sequence times (first number is pulse time, second number relaxation time)
tSeq(1,:)=[5 15];
tSeq(end+1,:)=[10 30];
tSeq(end+1,:)=[20 60];
tSeq(end+1,:)=[30 90];
tSeq(end+1,:)=[40 120];
tSeq(end+1,:)=[50 150];
tSeq(end+1,:)=[60 180];
tSeq(end+1,:)=[120 240];

%cycle of pulses with normal switching
for i=1:size(tSeq,1)
 [cOut,sReg] = symPulse(cOut,sReg,VSym1,frate,tSeq(i,1),VSym2,frate,tSeq(i,2));
end

%cycle of pulses with fast switching
for i=1:size(tSeq,1)
 [cOut,sReg] = symFastPulse(cOut,sReg,VSym1,frate,tSeq(i,1),frbust,tbust,VSym2,frate,tSeq(i,2),frbust,tbust);
end

%few 25 mins pulses
symFastPulse(cOut,sReg,VSym1,frate,25,frbust,tbust,VSym2,frate,25,frbust,tbust);
symFastPulse(cOut,sReg,VSym1,frate,25,frbust,tbust,VSym2,frate,25,frbust,tbust);
symFastPulse(cOut,sReg,VSym1,frate,25,frbust,tbust,VSym2,frate,25,frbust,tbust);
symFastPulse(cOut,sReg,VSym1,frate,25,frbust,tbust,VSym2,frate,25,frbust,tbust);


%% close protocol
cOut=endProtocol(cOut,sReg);

%% print protocol details
sPlateLayout = loadPlateLayout('M40S_PlateLayout_Example.xlsx');
sTimeLine = Reg2TimeLine(sReg);
printProtocolRegistry(sReg,sTimeLine,sPlateLayout);
figureProtocolTimeLine(sReg,sTimeLine);
figureSimulation(sReg,sTimeLine,sPlateLayout);
end

