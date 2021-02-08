function [cOut,sReg] = symPulse(cOut,sReg,VSym1,frate1,time1,VSym2,frate2,time2)
%SYMPULSE creates a pulse using the symmetric switch of 2 channels followed
%by other 2 channels

%perform first symmetric flow
[cOut,sReg] = symFlow(cOut,sReg,VSym1,frate1,time1);
%perform second symmetric flow
[cOut,sReg] = symFlow(cOut,sReg,VSym2,frate2,time2);

end

