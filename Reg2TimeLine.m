function [ sTimeLine ] = Reg2TimeLine(sReg)
%INITIREGISTRY converts registry structure to timeline
%the 6 input wells are numbered from 1 to 6
%the 2 output wells are numbered jointly as 7

%initialize sTimeLine structure
inpWells=1:6;
outWells=7;    
allWells=[inpWells outWells];
for i=[inpWells outWells]
    sTimeLine(i).time=[];
    sTimeLine(i).frate=[];
    sTimeLine(i).valveName='';
end

%read registry and update flow rates
ctime=0;
for i=1:length(sReg)
    %load registry entry
    Valves=sReg(i).Valves;
    frate=sReg(i).frate;
    time=sReg(i).time;
    totcfrate=0;
    %update the flowing rate hannels
    for j=1:length(inpWells)
        %set the current frate to the current rate if it is a used or an output well
        if ~isempty(intersect(Valves,inpWells(j)))
             cfrate=frate;    
        else
             cfrate=0;
        end     
        sTimeLine(inpWells(j)).frate(end+1)=cfrate;
        sTimeLine(inpWells(j)).frate(end+1)=cfrate;
        sTimeLine(inpWells(j)).time(end+1)=ctime;
        sTimeLine(inpWells(j)).time(end+1)=ctime+time;  
        sTimeLine(inpWells(j)).valveName=sprintf('V%d',inpWells(j));
        %update total rate for output well
        totcfrate=totcfrate+cfrate;
    end    
    %update output channel
    sTimeLine(outWells).frate(end+1)=totcfrate;
    sTimeLine(outWells).frate(end+1)=totcfrate;
    sTimeLine(outWells).time(end+1)=ctime;
    sTimeLine(outWells).time(end+1)=ctime+time;
    sTimeLine(outWells).valveName='V7+V8';
    %update time counter
    ctime=ctime+time;  
end    


end

