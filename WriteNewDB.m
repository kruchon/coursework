function [ ] = WriteNewDB( startTime, maxDeltaT, sq_i, sq_j, peaksPerSec, newRate, deltaH )

hashTable = zeros(70000*(startTime+maxDeltaT),100);
names = GetFilesWithExtensions('./', {'mp3'})

for songId=1:length(names)
    disp(strcat('writing song ', names{songId}));
    [fileData,sampleRate] = audioread(names{songId});%,[1,1000000]);
    [a,b]=rat(newRate/sampleRate,0.0001)
    fileData = resample(fileData,a,b);
    meanChannels = mean(fileData,2);   
    disp('building spectogram');
    [s,f,t,p] = spectrogram(meanChannels,16,15,16,newRate);
    figure;
    title(names{songId});
     fkhz = f./(1000*a/b);
     pdb = 10*log10(p.*1);
    surf(t,fkhz,pdb,'edgecolor','none');
    axis tight;
    xlabel('Time(seconds)');
    ylabel('Frequences(kHz)');
    disp('finding peaks');
    [ peaksT, peaksFkhz, peaksPdb ] = findPeaks(t,fkhz,pdb, sq_i, sq_j, peaksPerSec);
    hold on;
    disp('building peaks');
    scatter3(peaksT,peaksFkhz,peaksPdb);    
    view(0,90);    
    disp('building pairs');
    peaksPairs = createPairs(peaksT, peaksFkhz, startTime, startTime+maxDeltaT, deltaH);
    for i=1:size(peaksPairs,1)
        xLine = linspace(peaksPairs(i,4)+peaksPairs(i,3),peaksPairs(i,3));
        yLine = linspace(peaksPairs(i,2),peaksPairs(i,1));
        line(xLine,yLine);
    end
    disp('adding to hash table');
    hashTable = add2Table(hashTable, peaksPairs, songId, startTime );
end
songsNum = songId;
clear dataBase.dat
clear songsNum.dat
save('dataBase.dat','hashTable','-ascii');
save('songsNum.dat','songsNum','-ascii');
end

