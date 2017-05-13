function [ percent ] = compWithTable( peaksPairs, hashTable, songsNum, startTime )
numCollisions = zeros(songsNum,1);
for i=1:length(peaksPairs)
    try
    index = createHash(peaksPairs(i,4),peaksPairs(i,1),peaksPairs(i,2),startTime);
    elementNum = 1;
    while(hashTable(index,elementNum*2-1)~=0)
        if (peaksPairs(i,4)==hashTable(index,elementNum*2-1))
            numCollisions(hashTable(index,elementNum*2)) = numCollisions(hashTable(index,elementNum*2)) + 1;
            break;
        end
        elementNum = elementNum + 1;
    end
    catch
        index,elementNum
    end
end
numCollisions;
percent = numCollisions / size(peaksPairs,1);
end

