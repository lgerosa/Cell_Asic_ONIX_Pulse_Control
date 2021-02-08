function [ uLh ] = psi2uLh( psi )
%PSI2ULH converts psi to micro Liters per hour according to data
%extrapolated from the millipore M04S-03 Microlfuidic Plates

%extrapolated from documentation
mespsi=[0 1 4 8.5];
mesuLh=[0 10 40 150];

%calibration using linear interpolation
uLh=interp1(mespsi,mesuLh,psi);


end

