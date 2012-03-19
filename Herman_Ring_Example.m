function varargout = Herman_Ring_Example(varargin)
% HERMAN_RING_EXAMPLE M-file for Herman_Ring_Example.fig
%      HERMAN_RING_EXAMPLE, by itself, creates a new HERMAN_RING_EXAMPLE or raises the existing
%      singleton*.
%
%      H = HERMAN_RING_EXAMPLE returns the handle to a new HERMAN_RING_EXAMPLE or the handle to
%      the existing singleton*.
%
%      HERMAN_RING_EXAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HERMAN_RING_EXAMPLE.M with the given input arguments.
%
%      HERMAN_RING_EXAMPLE('Property','Value',...) creates a new HERMAN_RING_EXAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Herman_Ring_Example_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Herman_Ring_Example_OpeningFcn via varargin.
%
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Herman_Ring_Example_OpeningFcn, ...
                   'gui_OutputFcn',  @Herman_Ring_Example_OutputFcn, ...
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


function Herman_Ring_Example_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.plot = '.c';
handles.pixel = 500;
handles.t = 0.1876;
handles.c1 = 4;
handles.c2 = -1;
handles.xmin = -3;
handles.xmax = 3;
handles.ymin = -3;
handles.ymax = 3;
handles.iter = 40;
handles.traj = 5000;

handles = update_R_petal_1_Callback(hObject, eventdata, handles);

guidata(hObject, handles);

function varargout = Herman_Ring_Example_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function edit2_Callback(hObject, eventdata, handles)
handles.t = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit4_Callback(hObject, eventdata, handles)
handles.c2 = str2double(get(hObject,'String'));
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

handles.Ax = linspace(handles.xmin,handles.xmax,Nx);
handles.Ay = linspace(handles.ymin,handles.ymax,Ny);
handles.Z = repmat(handles.Ax,Ny,1) + repmat(handles.Ay',1,Nx)*i;
handles.c = handles.c1+i*handles.c2;
handles.cc = conj(handles.c);
handles.h = exp(2*pi*i*handles.t);

h = waitbar(0,'Iterating...');
for j = 1:handles.iter
    waitbar(j/handles.iter)
    handles.Z = handles.h*(handles.Z.^2).*(handles.Z - handles.c)./ (1-handles.Z*handles.cc);
end
close(h)

p = zeros(1,4);
p(4) = -2*handles.h*handles.cc;
p(3) = handles.h*(handles.cc*handles.c + 3);
p(2) = -2*handles.c*handles.h;
p = p(isfinite(p));
handles.cp = unique(roots(fliplr(p)));

handles.Z = abs(handles.Z);
handles.im = abs(handles.Z);
handles.im(find(handles.im==0)) = 2/256;
handles.Z((find(~isfinite(handles.Z))))=Inf;

hold off
image(handles.Ax,handles.Ay,handles.im*256);colormap(jet2(256));axis square
set(gca,'YDir','Normal');xlabel('real');ylabel('imaginary')
guidata(hObject, handles);

function trace_Callback(hObject, eventdata, handles)
zh = zeros(1,handles.traj);
hold off
image(handles.Ax,handles.Ay,handles.im*256);colormap(jet2(256));axis square
set(gca,'YDir','Normal');xlabel('real');ylabel('imaginary')

hold on
b=1;
while b==1
    [x,y,b]= ginput(1);
    if b==1
        z = complex(x,y);
        for n = 1:handles.traj
            zh(n)=z;
            z = handles.h*(z.^2).*(z - handles.c)./ (1-z*handles.cc);
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
        handles.plot = '.c';
        handles.traj = 5000;
    case 'dots&lines'
        handles.plot = '.-c';
        handles.traj = handles.iter;
end
guidata(hObject, handles);

function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit16_Callback(hObject, eventdata, handles)
handles.c1 = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit16_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function J = jet2(m)
if nargin < 1
   m = size(get(gcf,'colormap'),1);
end
n = ceil(m/4);
u = [(1:1:n)/n ones(1,n-1) (n:-1:1)/n]';
g = ceil(n/2) - (mod(m,4)==1) + (1:length(u))';
r = g + n;
b = g - n;
g(g>m) = [];
r(r>m) = [];
b(b<1) = [];
J = zeros(m,3);
J(r,1) = u(1:length(r));
J(g,2) = u(1:length(g));
J(b,3) = u(end-length(b)+1:end);
J(1,:)=0;


function critical_Callback(hObject, eventdata, handles)
hold on
zh = zeros(length(handles.cp),2*handles.traj);
zz = handles.cp;
for n = 1:2*handles.traj
    zh(:,n) = zz;
    zz = handles.h*(zz.^2).*(zz - handles.c)./ (1-zz*handles.cc);
end
plot(zh(find(abs(zh(:,end))<50),:),'.g');shg


function edit17_Callback(hObject, eventdata, handles)
handles.pixel = floor(str2double(get(hObject,'String')));
guidata(hObject, handles);

function edit17_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function contour_Callback(hObject, eventdata, handles)
colormap([0 0 0])
zz = handles.cp;
for n = 1:handles.iter
    zz = handles.h*(zz.^2).*(zz - handles.c)./ (1-zz*handles.cc);
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
            z = handles.h*(z.^2).*(z - handles.c)./ (1-z*handles.cc);
        end
        contour(handles.Ax,handles.Ay,handles.Z,abs(z(isfinite(z))));set(gca,'YDir','Normal');axis square;xlabel('real');ylabel('imaginary');shg
    end
end

