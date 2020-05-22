function varargout = guimoddemod(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guimoddemod_OpeningFcn, ...
                   'gui_OutputFcn',  @guimoddemod_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function guimoddemod_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = guimoddemod_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function pushbutton1_Callback(hObject, eventdata, handles)
fs=80000;
f=audiorecorder(fs,8,1);
record(f,10);
pause(10);
b=getaudiodata(f);
if ~isempty(handles.metricdata.folderloc)
    audiowrite(handles.metricdata.folderloc,b,fs);
else
    folde='C:\Users\Desktop\newfile2.wav';
    audiowrite(folde,b,fs);
end

fc=10000;
Ac=0.5;
t=linspace(1,10,length(b));
wc=2*pi*fc*t;
ec=Ac*cos(wc);

if get(get(handles.uibuttongroup1,'SelectedObject'),'Tag')=='amplitude'
    M=modulate(b,fc,fs,'am');
    MD=demod(M,fc,fs,'am');
    MDX=MD*100;
    md=audioplayer(MDX,fs);
elseif get(get(handles.uibuttongroup1,'SelectedObject'),'Tag')=='frequency'
    M=modulate(b,fc,fs,'fm');
    MD=demod(M,fc,fs,'fm');
    MDX=MD*100;
    md=audioplayer(MDX,fs);
end
figure
subplot(2,1,1);
plot(t',b);
xlabel('Time(in s)-->');
ylabel('Amplitude(in dB)-->');
title('Recorded Audio');

subplot(2,1,2);
plot(t,ec);
xlabel('Time(in s)-->');
ylabel('Amplitude(in dB)-->');
title('Carrier Signal');

figure
subplot(2,1,1);
plot(t,M);
xlabel('Time(in s)-->');
ylabel('Amplitude(in dB)-->');
title('Modulated Signal');

subplot(2,1,2);
plot(t,MD);
xlabel('Time(in s)-->');
ylabel('Amplitude(in dB)-->');
title('Demodulated Signal');

pause(5);
play(md);
clc;


function radiobutton1_Callback(hObject, eventdata, handles)


function radiobutton2_Callback(hObject, eventdata, handles)


function edit1_Callback(hObject, eventdata, handles)
folderloc=get(hObject,'String');
handles.metricdata.folderloc=folderloc;


function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function radiobutton1_DeleteFcn(hObject, eventdata, handles)


function pushbutton2_Callback(hObject, eventdata, handles)
folder=uigetdir;
filenm='\newfile.wav';
folderloc=strcat(folder,filenm);
set(handles.edit1,'String',folderloc);
disp(folderloc);
handles.metricdata.folderloc=folderloc;
guidata(hObject,handles);



function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)


function uibuttongroup1_CreateFcn(hObject, eventdata, handles)
