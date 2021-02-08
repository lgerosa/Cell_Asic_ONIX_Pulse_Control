function [simMicFluidicRun, sTimeLine] = figureSimulation(sReg,sTimeLine,plateLayout)
%FIGURESIMULATION simulates by ODEs the concentration profile in each channel
%given a time profile (from sReg) and information on the content of each
%well in the PlateLayout structure


simMicFluidicRun=[];

%% define constants
chVol=0.9; %chamber volume (in uL)

%modify the timeline so there are no overlapping time points (small shift)
for i=1:length(sTimeLine)
    sTimeLine(i).time(1:2:end)=sTimeLine(i).time(1:2:end)+0.0000000001;
    sTimeLine(i).time(1)=0;
    %extract time range to simulate
    minTime=min(sTimeLine(i).time);
    maxTime=max(sTimeLine(i).time);
end    

%% perform simulation using fluid flow program (TimeLine) and the Initial State of the plate (plateLayout)

%for each chamber and each solution, set up a ODE equation that calculates its time-varying concentration
figure;
set(gcf,'Color','White');
for i=1:length(plateLayout)
    Solutes={};
    %list solutes that are being added to the chamber through wells
    for j=1:length(plateLayout(i).Wells)
        for k=1:length(plateLayout(i).Wells(j).Solute)
         Solutes{end+1}=plateLayout(i).Wells(j).Solute(k).Name;
        end
    end    
    %list solutes that are already in the chambers
    for j=1:length(plateLayout(i).initConc)
      Solutes{end+1}=plateLayout(i).initConc(j).Name;  
    end       
    Solutes=unique(Solutes);
    %remove empty 
    Solutes(find(strcmp(Solutes,'')))=[];

    %for each solute make its time-dependent simulation
    for j=1:length(Solutes)
        %extract initial concentration (y0)
        y0=0;
        for k=1:length(plateLayout(i).initConc)
            if (strcmp(plateLayout(i).initConc(k).Name,Solutes{j})==1)
                y0=plateLayout(i).initConc(k).Conc;
            end    
        end    
        %create a vector with concentration at which the solute is present in the well 
        WellConc=[];
        for k=1:length(plateLayout(i).Wells)
            WellConc(k)=0;
            for z=1:length(plateLayout(i).Wells(k).Solute)
                if (strcmp(plateLayout(i).Wells(k).Solute(z).Name,Solutes{j})==1)
                    WellConc(k)=plateLayout(i).Wells(k).Solute(z).Conc;
                end    
            end
        end          
        %run simulation of the solute
        [timeSim SoluteConcSim] = ode45(@(t,y) SoluteODE(t,y,sTimeLine,WellConc,chVol),[minTime maxTime],y0); 
        subplot(4,1,i);
        plot(timeSim./60,SoluteConcSim,'LineWidth',2);
        simMicFluidicRun(i).Solute{j}=Solutes{j};
        simMicFluidicRun(i).time{j,:}=timeSim./60;
        simMicFluidicRun(i).ConcSim{j,:}=SoluteConcSim;
        hold on;
    end 
    %if there was no solute put a zero straing line
    if (isempty(Solutes))
        subplot(4,1,i);
        plot([minTime maxTime]./60,[0 0],'LineWidth',2);
        hold on;
        Solutes='None';
    end    
    xlabel('Time (hrs)');
    ylabel('Conc (uM)');
    title(sprintf('Chamber %s',plateLayout(i).Chamber));
    legend(Solutes);
end    

end


function dydt = SoluteODE(t,y,sTimeLine,WellConc,chVol)

%calculate the inflow as the sum of all contributing wells with the solute
fin=0;
for i=1:length(WellConc)
    %update the total influx of the solute UNITS: umol/(L * min) = (umol/L .* (umol/h) ./ .(min/h) / . uL) 
    fin=fin+ WellConc(i) .* psi2uLh((interp1(sTimeLine(i).time,sTimeLine(i).frate,t))) ./60 ./chVol;
end    
%calculate the outflow rate as the flow of valve 7 and 8 UNITS: umol/(L * min) = (umol/L .* (umol/h) ./ .(min/h) / . uL) 
fout=psi2uLh(interp1(sTimeLine(7).time,sTimeLine(7).frate,t)) ./60 ./chVol;
dydt = fin - y * fout; % evaluate the chamber time changes
end


