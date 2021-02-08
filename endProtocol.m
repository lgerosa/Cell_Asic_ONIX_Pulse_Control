function [cOut,sReg] = endProtocol(cOut,sReg)
%ENDSCRIPT to append at the end of a Protocol file

cOut=[cOut sprintf('%% END PROTOCOL: shutting off all valves and reseting regulators \n')];
cOut=[cOut sprintf('end\n')];

end

