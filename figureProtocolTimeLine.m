function [] = figureProtocolTimeLine(sReg,sTimeLine)
%FIGUREPROTOCOLTIMELINE generates a figure that shows the time line 
%progression of channel flow for a microfluidic run. 

%define wells structure
inpWells=1:6;
outWells=7;    
allWells=[inpWells outWells];
%select wells to plot
usedWell=inpWells(2:5);

%plot a figure with the profile for each input well 
figure;
for i=1:length(usedWell)
    subplot(length(usedWell)+1,1,i);
    time=sTimeLine(usedWell(i)).time./60;
    frate=sTimeLine(usedWell(i)).frate;
    uLh=psi2uLh(frate);
    plot(time,uLh,'LineWidth',2);
    xlabel('Time (hrs)');
    ylabel('Flow (uL/h)');
    ylim([0 max(uLh)+(max(uLh)* 0.1)+0.00001]);
    title(sTimeLine(usedWell(i)).valveName);
end
%plot the cumulative flow inside output wells
subplot(length(usedWell)+1,1,length(usedWell)+1);
time=sTimeLine(outWells).time./60;
frate=sTimeLine(outWells).frate;
uLh=psi2uLh(frate);
%calculate cumulative filling of output well
timeDense=time(1):((time(end)-time(1))/10000):time(end);
%use a trick to do interpolation
timeTrk=time;
timeTrk(1:2:end)=timeTrk(1:2:end)+0.0000001;
timeTrk(1)=0;
uLhDense=interp1(timeTrk,uLh,timeDense);
totInflowuL=cumsum(uLhDense) .* ((time(end)-time(1))./10000);
plot(timeDense,totInflowuL,'LineWidth',2);
%plot a red line at 900 uL, the maximum level for well 7 and 8
hold on;
plot([timeDense(1) timeDense(end)],[900 900],'r--','LineWidth',2);
xlabel('Time (hrs)');
ylabel('Content (uL)');
title(sTimeLine(outWells).valveName);
set(gcf,'Color','White');
end

