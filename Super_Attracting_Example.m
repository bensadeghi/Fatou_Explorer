function varargout = Super_Attracting_Example(varargin)
% SUPER_ATTRACTING_EXAMPLE M-file for Super_Attracting_Example.fig
%      SUPER_ATTRACTING_EXAMPLE, by itself, creates a new SUPER_ATTRACTING_EXAMPLE or raises the existing
%      singleton*.
%
%      H = SUPER_ATTRACTING_EXAMPLE returns the handle to a new SUPER_ATTRACTING_EXAMPLE or the handle to
%      the existing singleton*.
%
%      SUPER_ATTRACTING_EXAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUPER_ATTRACTING_EXAMPLE.M with the given input arguments.
%
%      SUPER_ATTRACTING_EXAMPLE('Property','Value',...) creates a new SUPER_ATTRACTING_EXAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Super_Attracting_Example_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Super_Attracting_Example_OpeningFcn via varargin.
%
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Super_Attracting_Example_OpeningFcn, ...
                   'gui_OutputFcn',  @Super_Attracting_Example_OutputFcn, ...
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


function Super_Attracting_Example_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.plot = '.-b';
handles.pixel = 500;
handles.n = 2;
handles.a1 = 0.13;
handles.a2 = -0.2;
handles.xmin = -3;
handles.xmax = 3;
handles.ymin = -3;
handles.ymax = 3;
handles.iter = 30;
handles.traj = 5000;
handles = update_R_petal_1_Callback(hObject, eventdata, handles);

guidata(hObject, handles);

function varargout = Super_Attracting_Example_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit2_Callback(hObject, eventdata, handles)
handles.n = floor(str2double(get(hObject,'String')));
guidata(hObject, handles);

function edit2_CreateFcn(hObject, eventdata, handles)
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

h = waitbar(0,'Iterating...');
for j = 1:handles.iter
    waitbar(j/handles.iter)
    handles.Z = handles.Z.^handles.n .* (1 - handles.a*handles.Z) ./ (handles.Z - handles.a);
end
close(h)

p = zeros(1,handles.n+3);
p(handles.n+1) = -handles.a*handles.n;
p(handles.n+2) = handles.a^2*(handles.n + 1)+handles.n -1;
p(handles.n+3) = -handles.a*handles.n;
handles.cp = unique(roots(fliplr(p)));

handles.Z = abs(handles.Z);
handles.Z((find(~isfinite(handles.Z))))=Inf;
handles.im = handles.Z.^(1/handles.n^handles.iter);
hold off
image(handles.Ax,handles.Ay,handles.Z*256*3/4);colormap(1-gray(256));axis square
set(gca,'YDir','Normal');xlabel('real');ylabel('imaginary');
guidata(hObject, handles);

function trace_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
zh = zeros(1,handles.traj);
hold off
image(handles.Ax,handles.Ay,handles.Z*256*3/4);colormap(1-gray(256));axis square
set(gca,'YDir','Normal');xlabel('real');ylabel('imaginary')

hold on
b=1;
while b == 1
    [x,y,b]= ginput(1);
    z = complex(x,y);
    if b==1
        for n = 1:handles.traj
            zh(n)=z;
            z = z.^handles.n .* (1 - handles.a*z) ./ (z - handles.a);
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
J(1,:)=0;


function contour_phi_Callback(hObject, eventdata, handles)
colormap([0 0 0])
zz = handles.cp;
for n = 1:handles.iter
    zz = zz.^handles.n .* (1 - handles.a*zz) ./ (zz - handles.a);
end
zz = abs(zz(isfinite(zz))).^(1/handles.n^handles.iter);
hold off
contour(handles.Ax,handles.Ay,handles.im,zz);set(gca,'YDir','Normal');xlabel('real');ylabel('imaginary');axis square;shg
hold on
b=1;
while b==1
    [x,y,b]=ginput(1);
    if b==1
        z = complex(x,y);
        for n = 1:handles.iter
            z = z.^handles.n .* (1 - handles.a*z) ./ (z - handles.a);
        end
        z = abs(z(isfinite(z))).^(1/handles.n^handles.iter);
        contour(handles.Ax,handles.Ay,handles.im,z);set(gca,'YDir','Normal');xlabel('real');ylabel('imaginary');axis square;shg
    end
end



function edit18_Callback(hObject, eventdata, handles)
handles.pixel = floor(str2double(get(hObject,'String')));
guidata(hObject, handles);

function edit18_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

