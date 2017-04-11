function [ resultHashTable ] = add2Table( hashTable, peaksPairs, songId, minDeltaT )
    numCollisions = 0;
    
    for i=1:length(peaksPairs)
        try
        index = createHash(peaksPairs(i,4),peaksPairs(i,1),peaksPairs(i,2), minDeltaT);
        elementNum = 1;
        while(hashTable(index,elementNum*2-1)~=0)
            elementNum = elementNum + 1;
        end
        if elementNum > 1
            numCollisions = numCollisions + 1;
        end
        hashTable(index,2*elementNum-1) = peaksPairs(i,4);
        hashTable(index,2*elementNum) = songId;
        catch
            elementNum, index
        end
    end
    numCollisions/size(peaksPairs,1)
    numCollisions
    resultHashTable = hashTable;
end

