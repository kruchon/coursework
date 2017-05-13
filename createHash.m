function [ value ] = createHash( deltaT, fi, fj, startTime)
    value = round(deltaT*65536+fi*256 +fj+1);
end

