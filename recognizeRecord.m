function [] = recognizeRecord ( startTime, maxDeltaT, sq_i, sq_j, peaksPerSec, newRate, deltaH )

names = GetFilesWithExtensions('./', {'wma'})

[fileData,sampleRate] = audioread(names{1});
disp('reading finished');

[a,b]=rat(newRate/sampleRate,0.0001)
fileData = resample(fileData,a,b);

meanChannels = mean(fileData,2);
disp('filedata was resampled');

[s,f,t,p] = spectrogram(meanChannels,16,15,16,newRate);
figure;
fkhz = f./(1000*a/b);
pdb = 10*log10(p.*1);
surf(t,fkhz,pdb,'edgecolor','none');
axis tight;
xlabel('Time(seconds)');
ylabel('Frequences(kHz)');
disp('spectogram was builded');

[ peaksT, peaksFkhz, peaksPdb ] = findPeaks(t,fkhz,pdb, sq_i, sq_j, peaksPerSec );
hold on;
scatter3(peaksT,peaksFkhz,peaksPdb);
disp('points were builded');
view(0,90);
peaksPairs = createPairs(peaksT, peaksFkhz, startTime, startTime+maxDeltaT, deltaH );
for i=1:size(peaksPairs,1)
    xLine = linspace(peaksPairs(i,4)+peaksPairs(i,3),peaksPairs(i,3));
    yLine = linspace(peaksPairs(i,2),peaksPairs(i,1));
    line(xLine,yLine);
end
disp('pairs were builded');

hashTable = load('dataBase.dat');
songsNum = load('songsNum.dat');
compWithTable(peaksPairs,hashTable,songsNum,startTime)

end
