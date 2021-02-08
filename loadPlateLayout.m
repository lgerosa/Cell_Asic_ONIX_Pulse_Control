function [ plateLayout ] = loadPlateLayout( PlateLayoutFile )
%LOADPLATELAYOUT loads a plate layout file

%load the platelayout file with content of wells 
[~,WellsContent,~] = xlsread(PlateLayoutFile,'PlateLayout','A1:G5');
%load the playout file with initial concentrations in chambers 
[~,ChamberInit,~] = xlsread(PlateLayoutFile,'PlateLayout','A7:B11');

%extract Valve Names
Wells=WellsContent(1,2:7);
%extract Chambers Names
ChamberInit(1,:)=[];
Chambers=ChamberInit(1:4,1);
ChambersTmp=WellsContent(2:5,1);
if (length(Chambers)~=length(union(Chambers,ChambersTmp)))
    fprintf('Error in the PlateLayout file template: Chambers'' names not matching\n');
end    


%% initialize the information on the plate initial state and wells' content
plateLayout=[];
%for each chamber, extract the solutes concentrations
for i=1:length(Chambers)
    plateLayout(i).Chamber=Chambers{i};
    %extract the solutes and concentrations for this chamber
    iCh=find(strcmp(WellsContent(1:end),Chambers{i}));
    WellsChStr=WellsContent(iCh,2:7);
    %for each well, extract the solute name and its concentration
    for j=1:length(WellsChStr)
        plateLayout(i).Wells(j).Name=Wells{j};
        %tokenize solutes
        plateLayout(i).Wells(j).SolutesTxt=WellsChStr{j};
        Solutes=strsplit(WellsChStr{j},'|');
        %store name and concentration of each solute
        for k=1:length(Solutes)
            %if there is no solute
            if (isempty(Solutes{k}))
                plateLayout(i).Wells(j).Solute(k).Name='';
                plateLayout(i).Wells(j).Solute(k).Conc=0;
            else   
            %else if there is a solute, separate the name from the
            %concentration ('=')
                tokensSol=strsplit(Solutes{k},'=');
                plateLayout(i).Wells(j).Solute(k).Name=tokensSol{1};
                plateLayout(i).Wells(j).Solute(k).Conc=str2num(tokensSol{2});
            end    
        end    
    end    
    %extract the initial concentration
    %tokenize solutes
    initConc=strsplit(ChamberInit{i,2},'|');
    for j=1:length(initConc)
            %if there is no initConc
            if (isempty(initConc{j}))
                plateLayout(i).initConc(j).Name='';
                plateLayout(i).initConc(j).Conc=0;
            else   
            %else if there is a initial conc, separate the name from the
            %concentration ('=')
                tokensConc=strsplit(initConc{j},'=');
                plateLayout(i).initConc(j).Name=tokensConc{1};
                plateLayout(i).initConc(j).Conc=str2num(tokensConc{2});
            end    
        end    
end    

end

