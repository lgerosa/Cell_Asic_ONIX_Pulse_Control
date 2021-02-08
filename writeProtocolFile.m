function [] = writeProtocolFile( funcname )
%WRITEPROTOCOLFILE runs the protocol function and creates a text file with
%the corresponding name

cOut=eval(funcname);
fID=fopen([funcname '.txt'],'w');
fprintf(fID,'%s',cOut);
fclose(fID);

%plot run time and wells volumes


%plot file creation
fprintf(1,'Created protocol file: %s\n',[funcname '.txt']);
end

