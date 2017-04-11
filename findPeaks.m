function [ peaksT, peaksFkhz, peaksP ] = findPeaks( t, fkhz, p, sq_i_max, sq_j_max, peaksPerSec )
    peaks = ones(size(p,1),size(p,2));
    shifted_p = [];
    for sq_i=-sq_i_max:sq_i_max
        for sq_j=-sq_j_max:sq_j_max
            if (~(sq_i==0 && sq_j==0))
                shifted_p = circshift(p,[sq_i,sq_j]);
                peaks = peaks & ((p - shifted_p) > 0);
                %          p(5:8,1005:1008)
                %         shifted_p(5:8,1005:1008)
                %          sq_i
                %          sq_j
                %          peaks(5:8,1005:1008)
            end
        end
    end
    [row,col] = find(peaks);
    startTime = 0;
    startIndex = 1;
    filteredRow = [];
    filteredCol = [];
    peaksAmount = 0;
    for i=1:length(row)
        if ((t(col(i))-startTime)>1)
            elements = [];
            for j=startIndex:i
                elements = [elements;[p(row(j),col(j)),row(j),col(j)]];
            end
            if (size(elements,2)~=0)
                if (peaksPerSec < i-startIndex)
                    sortedElements = -sortrows(-elements,1);
                    filteredRow = [filteredRow; sortedElements(1:peaksPerSec,2)];
                    filteredCol = [filteredCol; sortedElements(1:peaksPerSec,3)];
                else
                    filteredRow = [filteredRow; elements(:,2)];
                    filteredCol = [filteredCol; elements(:,3)];
                end
            end
            startTime = startTime+1;
            startIndex = i+1;
        end
    end
    %Adding remaining elements
    elements = [];
    for j=startIndex:length(row)
        elements = [elements;[p(row(j),col(j)),row(j),col(j)]];
    end
    if (size(elements,2)~=0)
        if (peaksPerSec < length(row)-startIndex)
            sortedElements = -sortrows(-elements,1);
            filteredRow = [filteredRow; sortedElements(1:peaksPerSec,2)];
            filteredCol = [filteredCol; sortedElements(1:peaksPerSec,3)];
        else
            filteredRow = [filteredRow; elements(:,2)];
            filteredCol = [filteredCol; elements(:,3)];
        end
    end
    peaksT = zeros(length(filteredRow),1);
    peaksFkhz = zeros(length(filteredRow),1);
    peaksP = zeros(length(filteredRow),1);
    for i=1:length(filteredRow)
        peaksT(i) = t(filteredCol(i));
        peaksFkhz(i) = fkhz(filteredRow(i));
        peaksP(i) = p(filteredRow(i),filteredCol(i));
    end    
end



