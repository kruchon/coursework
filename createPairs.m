function [ peaksPairs ] = createPairs( peaksT, peaksFkhz, deltaL, deltaW, deltaH )
    peaksPairs = [];
    for i=1:length(peaksT)
        for j=1:length(peaksT)
            if ((j>i) && (peaksFkhz(i)-deltaH) < peaksFkhz(j) && peaksFkhz(j) <= (peaksFkhz(i)+deltaH) && (peaksT(i)+deltaL) < peaksT(j) && peaksT(j) <= (peaksT(i) + deltaW))
                newPair = [ peaksFkhz(i),peaksFkhz(j),peaksT(i),peaksT(j)-peaksT(i) ];
                peaksPairs = [ peaksPairs; newPair ];
            end
        end
    end
end