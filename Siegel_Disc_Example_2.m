function varargout = Siegel_Disc_Example_2(varargin)
% SIEGEL_DISC_EXAMPLE_2 M-file for Siegel_Disc_Example_2.fig
%      SIEGEL_DISC_EXAMPLE_2, by itself, creates a new SIEGEL_DISC_EXAMPLE_2 or raises the existing
%      singleton*.
%
%      H = SIEGEL_DISC_EXAMPLE_2 returns the handle to a new SIEGEL_DISC_EXAMPLE_2 or the handle to
%      the existing singleton*.
%
%      SIEGEL_DISC_EXAMPLE_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIEGEL_DISC_EXAMPLE_2.M with the given input arguments.
%
%      SIEGEL_DISC_EXAMPLE_2('Property','Value',...) creates a new SIEGEL_DISC_EXAMPLE_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Siegel_Disc_Example_2_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Siegel_Disc_Example_2_OpeningFcn via varargin.
%
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Siegel_Disc_Example_2_OpeningFcn, ...
                   'gui_OutputFcn',  @Siegel_Disc_Example_2_OutputFcn, ...
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
% End initialization code - DO NOT EDIT

function Siegel_Disc_Example_2_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.plot = '.k';
handles.show = 0;
handles.pixel = 500;
handles.t = 0.7418;
handles.a1 = 1;
handles.a2 = .5;
handles.n = 2;
handles.xmin = -3;
handles.xmax = 3;
handles.ymin = -3;
handles.ymax = 3;
handles.iter = 40;
handles.traj = 5000;

handles = update_R_petal_1_Callback(hObject, eventdata, handles);

guidata(hObject, handles);

function varargout = Siegel_Disc_Example_2_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit2_Callback(hObject, eventdata, handles)
handles.t = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit4_Callback(hObject, eventdata, handles)
handles.a2 = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit6_Callback(hObject, eventdata, handles)
handles.xmin = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_Callback(hObject, eventdata, handles)
handles.ymin = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit10_Callback(hObject, eventdata, handles)
handles.xmax = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit10_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit14_Callback(hObject, eventdata, handles)
handles.ymax = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit14_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function handles = update_R_petal_1_Callback(hObject, eventdata, handles)
Nx = handles.pixel;
Ny = Nx;

handles.u = exp(2*pi*i*handles.t);
handles.b = 1 - ((handles.a1+i*handles.a2)+1)*(handles.u/handles.n);
handles.c = (handles.a1+i*handles.a2) +((handles.a1+i*handles.a2)+1)*(handles.u/handles.n);
handles.Ax = linspace(handles.xmin,handles.xmax,Nx);
handles.Ay = linspace(handles.ymin,handles.ymax,Ny);
handles.Z = repmat(handles.Ax,Ny,1) + repmat(handles.Ay',1,Nx)*i;
handles.a = handles.a1+i*handles.a2;
hold off
if handles.show
    colormap(jet(256));
    for j = 1:handles.iter
        image(handles.Ax,handles.Ay,abs(handles.Z)*64);axis square;title(j-1);set(gca,'YDir','Normal');xlabel('real');ylabel('imaginary');pause(.1)
        handles.Z = (handles.c*handles.Z.^handles.n + handles.b) ./ (handles.a*handles.Z.^handles.n +1);
    end;
else
    h = waitbar(0,'Iterating...');
    for j = 1:handles.iter
        waitbar(j/handles.iter)
        handles.Z = (handles.c*handles.Z.^handles.n + handles.b) ./ (handles.a*handles.Z.^handles.n +1);
    end;
    close(h)
end

handles.cp = 0;
handles.Z = abs(handles.Z);
image(handles.Ax,handles.Ay,handles.Z*64);colormap(jet(256));axis square
set(gca,'YDir','Normal');xlabel('real');ylabel('imaginary');title(j)
guidata(hObject, handles);

function trace_Callback(hObject, eventdata, handles)
zh = zeros(1,handles.traj);
hold off
image(handles.Ax,handles.Ay,handles.Z*64);colormap(jet(256));axis square
set(gca,'YDir','Normal');xlabel('real');ylabel('imaginary')

hold on
b=1;
while b==1
    [x,y,b]= ginput(1);
    if b==1
        z = complex(x,y);
        for n = 1:handles.traj
            zh(n)=z;
            z = (handles.c*z.^handles.n + handles.b) ./ (handles.a*z.^handles.n +1);
        end
        plot(zh,handles.plot);shg
    end
end


function edit15_Callback(hObject, eventdata, handles)
handles.iter = ceil(str2double(get(hObject,'String')));
guidata(hObject, handles);

function edit15_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu1_Callback(hObject, eventdata, handles)
val = get(hObject,'Value');
str = get(hObject,'String');
switch str{val}
    case 'dots'
        handles.plot = '.k';
        handles.traj = handles.traj;
    case 'dots&lines'
        handles.plot = '.-k';
        handles.traj = handles.iter;
end
guidata(hObject, handles);

function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit16_Callback(hObject, eventdata, handles)
handles.a1 = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit16_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit17_Callback(hObject, eventdata, handles)
handles.n = floor(str2double(get(hObject,'String')));
guidata(hObject, handles);

function edit17_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu2_Callback(hObject, eventdata, handles)
val = get(hObject,'Value');
str = get(hObject,'String');
switch str{val}
    case 'final iteration'
        handles.show = 0;
    case 'slide show'
        handles.show = 1;
end
guidata(hObject, handles);

function popupmenu2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function critical_Callback(hObject, eventdata, handles)
hold on
zh = zeros(length(handles.cp),2*handles.traj);
zz = handles.cp;
for n = 1:2*handles.traj
    zh(:,n) = zz;
    zz = (handles.c*zz.^handles.n + handles.b) ./ (handles.a*zz.^handles.n +1);
end
plot(zh,'.r');shg


function edit18_Callback(hObject, eventdata, handles)
handles.pixel = floor(str2double(get(hObject,'String')));
guidata(hObject, handles);

function edit18_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function contour_Callback(hObject, eventdata, handles)
colormap([0 0 0])
zz = handles.cp;
for n = 1:handles.iter
    zz = (handles.c*zz.^handles.n + handles.b) ./ (handles.a*zz.^handles.n +1);
end

hold off
contour(handles.Ax,handles.Ay,handles.Z,abs(zz(isfinite(zz))));set(gca,'YDir','Normal');axis square;xlabel('real');ylabel('imaginary');shg
hold on
b=1;
while b==1
    [x,y,b]=ginput(1);
    if b==1
        z = complex(x,y);
        for n = 1:handles.iter
            z = (handles.c*z.^handles.n + handles.b) ./ (handles.a*z.^handles.n +1);
        end
        contour(handles.Ax,handles.Ay,handles.Z,abs(z(isfinite(z))));set(gca,'YDir','Normal');axis square;xlabel('real');ylabel('imaginary');shg
    end
end

