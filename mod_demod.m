fs=80000;
disp('Welcome Sir. Please press 1 and then press enter to start recording audio. Length of audio should be 10 seconds');
inp=0;
while inp~=1
    inp=input('Waiting... ');
end
f=audiorecorder(fs,8,1);
disp('Please speak');
record(f,10);
pause(10);
disp('10 secs up!!');
b=getaudiodata(f);
disp('Select a folder where you want to save the audio file.');
folde=uigetdir;
filnm=input('Enter a name to save your audio with:  ','s');
filen=strcat(filnm,'.wav');
filenm=strcat(folde,'\',filen);
disp(filenm);
audiowrite(filenm,b,fs);
t=linspace(1,10,length(b));
Ac=1;
fc=input('Enter desired carrier frequency: '); 
wc=2*pi*fc*t;
ec=Ac*cos(wc);
k=menu('Choose: Amplitude Modulation or Frequency Modulation','Amplitude modulation','Frequency Modulation');
switch k
    case 1
        M=modulate(b,fc,fs,'am');
        MD=demod(M,fc,fs,'am');
        MDX=MD*100;
        md=audioplayer(MDX,fs);
    case 2
        M=modulate(b,fc,fs,'fm');
        MD=demod(M,fc,fs,'fm');
        MDX=MD*100;
        md=audioplayer(MDX,fs);
    case 0
        disp('Wrong choice');
end
disp('Plotting...');
figure
subplot(2,1,1);
plot(t',b);
xlabel('Time-->');
ylabel('Amplitude(dB)-->');
title('Audio input');
subplot(2,1,2);
plot(t,ec);
xlabel('Time-->');
ylabel('Amplitude(dB)-->');
title('Carrier Signal');
figure
subplot(2,1,1);
plot(t,M);
xlabel('Time-->');
ylabel('Amplitude(dB)-->');
title('Modulated Audio');
subplot(2,1,2);
plot(t,MD);
xlabel('Time-->');
ylabel('Amplitude(dB)-->');
title('Demodulated Audio');
pause(5);
disp('Playing Demodulated Audio...');
play(md);