function [] = printProtocolRegistry( sReg, sTimeLine, sPlateLayout )
%PRINTPROTOCOLREGISTRY calculates i) run time ii) amount of liquid used in
%for each well for a microfluidics run and print it to screen

%define wells structure
inpWells=1:6;
outWells=7;    
allWells=[inpWells outWells];
%generate a sTimeLine structure
totTime=sTimeLine(outWells(1)).time(end);
%plot total time
fprintf(1,'Running time %2.2f hrs.\n',(totTime)/60);
fprintf(1,'Flow volumes: | ');
%sum up the flow sustained by each well
for i=1:length(allWells)
    totfrate(allWells(i))=sum(diff(sTimeLine(allWells(i)).time)./60 .* sTimeLine(allWells(i)).frate(1:end-1));
    totflow(allWells(i))=sum(diff(sTimeLine(allWells(i)).time)./60 .* psi2uLh(sTimeLine(allWells(i)).frate(1:end-1)));
    %plot the total flow in exit from the well
    fprintf(1,'V%d = %1.0f uL | ',allWells(i),totflow(allWells(i)));
end    
%if plate layout is available, calculate the amount of different solutions needed to run the experiment
if (~isempty(sPlateLayout))
    %print the required volumes for each solution
    fprintf(1,'\nVolumes required:\n');
    %find how many solutes there are in the platelayout
    Solutes={};
    %for each chamber
    for i=1:length(sPlateLayout)
        %for each well
        for j=1:length(sPlateLayout(i).Wells)
            %for each well load the solute string given in input
            Solutes{end+1}=sPlateLayout(i).Wells(j).SolutesTxt;
       end    
    end    
    Solutes=unique(Solutes);
    %initialize the solutes requirement vector
    SolutesVol=zeros(1,length(Solutes));
    %for each Solute, sum up the flow rate required over the whole run
    for k=1:length(Solutes)
        %for each chamber
        for i=1:length(sPlateLayout)
            %for each well
            for j=1:length(sPlateLayout(i).Wells)
                %if in the well, sum up the flow rate for that well to the solutes requirement
                if (strcmp(sPlateLayout(i).Wells(j).SolutesTxt,Solutes{k}))
                    SolutesVol(k)=SolutesVol(k)+totflow(j);
                end    
            end    
        end  
        %print out the total volume required
        if isempty(Solutes{k})
           Solutes{k}='Media+DMSO';
        end    
        fprintf(1,'[%s] = %1.0f uL\n',Solutes{k},SolutesVol(k));    
    end  
    %fprintf(1,'Total = %1.0f uL\n',sum(SolutesVol));    
end    



end

