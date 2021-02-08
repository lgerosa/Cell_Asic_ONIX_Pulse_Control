function [cOut,sReg] = symFastPulse(cOut,sReg,VSym1,frate1,time1,frbust1,timebust1,VSym2,frate2,time2,frbust2,timebust2)
%SYMPULSE creates a fast switching pulse of 2 channels followed by other 2 channels
%the fast switch is achieved by having a short faster burst at the onset of each flow

%perform first symmetric fast burst flow
[cOut,sReg] = symFlow(cOut,sReg,VSym1,frbust1,timebust1);
%perform first symmetric flow
[cOut,sReg] = symFlow(cOut,sReg,VSym1,frate1,time1);
%perform second symmetric fast burst flow
[cOut,sReg] = symFlow(cOut,sReg,VSym2,frbust2,timebust2);
%perform second symmetric flow
[cOut,sReg] = symFlow(cOut,sReg,VSym2,frate2,time2);

end

