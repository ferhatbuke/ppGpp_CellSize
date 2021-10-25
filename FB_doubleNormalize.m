function [normalized]=FB_doubleNormalize(raw,before, after)
    %normalize the raw data such that before=2 and after=1 by doing
    %(before+x)/y=2 and (after+x)/y=1 solving this gives below.
    %corresponds to linear shifting (+x) and then scaling (/y).
    
    x= before - after*2;
    y= before - after;
    
    normalized = (raw+x)/y;

end