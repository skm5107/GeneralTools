function [ rgbint ] = rgb2int(rgb)
% Siri Maley (smaley) Adapted from Chad A. Greene, April 2014, rgb2hex 
%% Check inputs: 
assert(nargin==1,'This function requires an RGB input.') 
assert(isnumeric(rgb)==1,'Function input must be numeric.') 
sizergb = size(rgb); 
assert(sizergb(2)==3,'rgb value must have three components in the form [r g b].')
assert(max(rgb(:))<=255& min(rgb(:))>=0,'rgb values must be on a scale of 0 to 1 or 0 to 255')
%% If no value in RGB exceeds unity, scale from 0 to 255: 
if max(rgb(:))<=1
    rgb = round(rgb*255); 
else
    rgb = round(rgb); 
end
%% Convert (Thanks to Stephen Cobeldick for this clever, efficient solution):
rgbint(:,2:7) = reshape(sprintf('%02X',rgb.'),6,[]).'; 
% hex(:,1) = '#';

%% Convert to RGB Int
% rgbint = base2dec(hex,16);
end