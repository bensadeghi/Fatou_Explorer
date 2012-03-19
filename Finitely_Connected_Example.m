function varargout = Finitely_Connected_Example(varargin)
% FINITELY_CONNECTED_EXAMPLE M-file for Finitely_Connected_Example.fig
%      FINITELY_CONNECTED_EXAMPLE, by itself, creates a new FINITELY_CONNECTED_EXAMPLE or raises the existing
%      singleton*.
%
%      H = FINITELY_CONNECTED_EXAMPLE returns the handle to a new FINITELY_CONNECTED_EXAMPLE or the handle to
%      the existing singleton*.
%
%      FINITELY_CONNECTED_EXAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINITELY_CONNECTED_EXAMPLE.M with the given input arguments.
%
%      FINITELY_CONNECTED_EXAMPLE('Property','Value',...) creates a new FINITELY_CONNECTED_EXAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Finitely_Connected_Example_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Finitely_Connected_Example_OpeningFcn via varargin.
%
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Finitely_Connected_Example_OpeningFcn, ...
                   'gui_OutputFcn',  @Finitely_Connected_Example_OutputFcn, ...
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

function Finitely_Connected_Example_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.plot = '.-b';
handles.show = 0;
handles.pixel = 500;
handles.t1 = 0.022;
handles.t2 = -0.1;
handles.a1 = 4;
handles.a2 = -1;
handles.xmin = -3;
handles.xmax = 3;
handles.ymin = -3;
handles.ymax = 3;
handles.iter = 30;
handles.traj = 5000;

handles = update_R_petal_1_Callback(hObject, eventdata, handles);

guidata(hObject, handles);

function varargout = Finitely_Connected_Example_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit2_Callback(hObject, eventdata, handles)
handles.t1 = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit2_CreateFcn(hObject, eventdata, handles)
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
handles.t = handles.t1 + i*handles.t2;
handles.Ax = linspace(handles.xmin,handles.xmax,Nx);
handles.Ay = linspace(handles.ymin,handles.ymax,Ny);
handles.Z = repmat(handles.Ax,Ny,1) + repmat(handles.Ay',1,Nx)*i;
handles.im = handles.Z;
hold off
if handles.show
    colormap(gray(256));
    for j = 1:handles.iter
        image(handles.Ax,handles.Ay,abs(handles.im)*256);axis square;xlabel('real');ylabel('imaginary');title(j-1);set(gca,'YDir','Normal');pause(.1);shg
        handles.im = handles.Z;
        handles.im((find(~isfinite(handles.im))))=Inf;
        handles.Z = (handles.Z.^2 .* (1+handles.t^12*handles.Z.^3)) ./ ((1-handles.t^4*handles.Z).*(1-handles.t*handles.Z).^3);
    end;
else
    h = waitbar(0,'Iterating...');
    for j = 1:handles.iter
        waitbar(j/handles.iter)
        handles.Z = (handles.Z.^2 .* (1+handles.t^12*handles.Z.^3)) ./ ((1-handles.t^4*handles.Z).*(1-handles.t*handles.Z).^3);
    end;
    close(h)
end

handles.im = handles.Z;
handles.im((find(~isfinite(handles.im))))=Inf;

image(handles.Ax,handles.Ay,abs(handles.im)*256);colormap(gray(256));axis square
set(gca,'YDir','Normal');xlabel('real');ylabel('imaginary');title(j);shg
guidata(hObject, handles);

function trace_Callback(hObject, eventdata, handles)
zh = zeros(1,handles.traj);
hold off
image(handles.Ax,handles.Ay,abs(handles.im)*256);colormap(gray(256));axis square
set(gca,'YDir','Normal');xlabel('real');ylabel('imaginary')

hold on
b=1;
while b==1
    [x,y,b]= ginput(1);
    if b==1
        z = complex(x,y);
        for n = 1:handles.traj
            zh(n)=z;
            z = (z.^2 .* (1+handles.t^12*z.^3)) ./ ((1-handles.t^4*z).*(1-handles.t*z).^3);
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
        handles.plot = '.b';
    case 'dots&lines'
        handles.plot = '.-b';
end
guidata(hObject, handles);

function popupmenu1_CreateFcn(hObject, eventdata, handles)
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

function edit18_Callback(hObject, eventdata, handles)
handles.t2 = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit18_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit19_Callback(hObject, eventdata, handles)
handles.pixel = floor(str2double(get(hObject,'String')));
guidata(hObject, handles);

function edit19_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

