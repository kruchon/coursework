clc;
clear;
close all;
startTime = 1;
maxDeltaT = 0.1;
sq_i = 1;
sq_j = 100;
peaksPerSec = 5;
newRate = 8000;
deltaH = 10;
hashTable = zeros(100000,50);
songsNum = 4;
hashTable = WriteNewDB(songsNum,hashTable,startTime,maxDeltaT,sq_i,sq_j,peaksPerSec,newRate,deltaH);
recognizeRecord(songsNum,hashTable,startTime,maxDeltaT,sq_i,sq_j,peaksPerSec,newRate,deltaH);