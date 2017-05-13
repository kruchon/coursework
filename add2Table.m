function [ resultHashTable ] = add2Table( hashTable, peaksPairs, songId, startTime )
    numCollisions = 0;
    
    for i=1:length(peaksPairs)
        try
        index = createHash(peaksPairs(i,4),peaksPairs(i,1),peaksPairs(i,2), startTime);
        elementNum = 1;
        songIdWas = false;
        while(hashTable(index,elementNum*2-1)~=0)
            if(hashTable(index,elementNum*2-1)==songId)
                songIdWas = true;
            end
            elementNum = elementNum + 1;
        end
        if (elementNum > 1 && ~songIdWas)
            numCollisions = numCollisions + 1;
        end
        hashTable(index,2*elementNum-1) = peaksPairs(i,4);
        hashTable(index,2*elementNum) = songId;
        catch
            elementNum, index
        end
    end
    numCollisions
    size(peaksPairs,1)
    resultHashTable = hashTable;
end

