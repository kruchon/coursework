function [ value ] = createHash( deltaT, fi, fj, minDeltaT)
    value = round((deltaT-minDeltaT)*65536+fi*256 +fj+1);
end

