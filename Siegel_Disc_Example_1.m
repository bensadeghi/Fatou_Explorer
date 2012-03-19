function varargout = Siegel_Disc_Example_1(varargin)
% SIEGEL_DISC_EXAMPLE_1 M-file for Siegel_Disc_Example_1.fig
%      SIEGEL_DISC_EXAMPLE_1, by itself, creates a new SIEGEL_DISC_EXAMPLE_1 or raises the existing
%      singleton*.
%
%      H = SIEGEL_DISC_EXAMPLE_1 returns the handle to a new SIEGEL_DISC_EXAMPLE_1 or the handle to
%      the existing singleton*.
%
%      SIEGEL_DISC_EXAMPLE_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIEGEL_DISC_EXAMPLE_1.M with the given input arguments.
%
%      SIEGEL_DISC_EXAMPLE_1('Property','Value',...) creates a new SIEGEL_DISC_EXAMPLE_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Siegel_Disc_Example_1_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Siegel_Disc_Example_1_OpeningFcn via varargin.
%
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Siegel_Disc_Example_1_OpeningFcn, ...
                   'gui_OutputFcn',  @Siegel_Disc_Example_1_OutputFcn, ...
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


function Siegel_Disc_Example_1_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.plot = '.r';
handles.pixel = 500;
handles.show = 0;
handles.n = 2;
handles.m = 4;
handles.h1 = .1107;
handles.a1 = .5;
handles.a2 = .5;
handles.b1 = 0.15;
handles.b2 = 0.16;
handles.xmin = -1.5;
handles.xmax = 1.5;
handles.ymin = -1.5;
handles.ymax = 1.5;
handles.iter = 40;
handles.traj = 5000;

handles = update_R_petal_1_Callback(hObject, eventdata, handles);

guidata(hObject, handles);

function varargout = Siegel_Disc_Example_1_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit2_Callback(hObject, eventdata, handles)
handles.n = floor(str2double(get(hObject,'String')));
guidata(hObject, handles);

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
handles.m = floor(str2double(get(hObject,'String')));
guidata(hObject, handles);

function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit4_Callback(hObject, eventdata, handles)
handles.b2 = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit5_Callback(hObject, eventdata, handles)
handles.a2 = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit5_CreateFcn(hObject, eventdata, handles)
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
handles.a = handles.a1+i*handles.a2;
handles.b = handles.b1+handles.b2*i;
handles.epq = exp(2*i*pi*handles.h1);

h = waitbar(0,'Iterating...');
for j = 1:handles.iter
    waitbar(j/handles.iter)
    handles.Z = handles.a*handles.Z.^handles.n + handles.b*handles.Z.^handles.m + handles.epq*handles.Z;
end;
close(h)

p = zeros(1,max([handles.n handles.m]));
p(1) = handles.epq;
if handles.n == handles.m
    p(handles.n) = handles.a*handles.n + handles.b*handles.m;
else
    p(handles.n) = handles.a*handles.n;
    p(handles.m) = handles.b*handles.m;
end
handles.cp = unique(roots(fliplr(p)));

hold off
handles.Z = abs(handles.Z);
handles.Z(~isfinite(handles.Z)) = Inf;
image(handles.Ax,handles.Ay,handles.Z*256/2);colormap(jet2(256));axis square
set(gca,'YDir','Normal');xlabel('real');ylabel('imaginary')
guidata(hObject, handles);

function trace_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
zh = zeros(1,handles.traj);
hold off
image(handles.Ax,handles.Ay,handles.Z*256/2);colormap(jet2(256));axis square
xlabel('real');ylabel('imaginary');set(gca,'YDir','Normal');shg

hold on
b=1;
while b == 1
    [x,y,b]= ginput(1);
    if b==1
        z = complex(x,y);
        for n = 1:handles.traj
            zh(n)=z;
            z = handles.a*z^handles.n + handles.b*z^handles.m + handles.epq*z;
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
        handles.plot = '.r';
    case 'dots&lines'
        handles.plot = '.-r';
end
guidata(hObject, handles);

function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit16_Callback(hObject, eventdata, handles)
handles.b1 = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit16_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit17_Callback(hObject, eventdata, handles)
handles.a1 = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit17_CreateFcn(hObject, eventdata, handles)
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
J(end,:)=0;


function edit19_Callback(hObject, eventdata, handles)
handles.h1 = str2double(get(hObject,'String'));
guidata(hObject, handles);

function edit19_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function critical_Callback(hObject, eventdata, handles)

hold on
zh = zeros(length(handles.cp),2*handles.traj);
zz = handles.cp;
for n = 1:2*handles.traj
    zh(:,n) = zz;
    zz = handles.a*zz.^handles.n + handles.b*zz.^handles.m + handles.epq*zz;
end
plot(zh(find(abs(zh(:,end))<50),:),'.g');shg



function edit20_Callback(hObject, eventdata, handles)
handles.pixel = floor(str2double(get(hObject,'String')));
guidata(hObject, handles);

function edit20_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton6_Callback(hObject, eventdata, handles)
colormap([0 0 0])
zz = handles.cp;
for n = 1:handles.iter
    zz = handles.a*zz.^handles.n + handles.b*zz.^handles.m + handles.epq*zz;
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
            z = handles.a*z.^handles.n + handles.b*z.^handles.m + handles.epq*z;
        end
        contour(handles.Ax,handles.Ay,handles.Z,abs(z(isfinite(z))));set(gca,'YDir','Normal');axis square;xlabel('real');ylabel('imaginary');shg
    end
end

