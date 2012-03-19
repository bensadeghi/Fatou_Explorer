function varargout = Fatou_Explorer(varargin)
% FATOU_EXPLORER M-file for Fatou_Explorer.fig
%      FATOU_EXPLORER, by itself, creates a new FATOU_EXPLORER or raises the existing
%      singleton*.
%
%      H = FATOU_EXPLORER returns the handle to a new FATOU_EXPLORER or the handle to
%      the existing singleton*.
%
%      FATOU_EXPLORER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FATOU_EXPLORER.M with the given input arguments.
%
%      FATOU_EXPLORER('Property','Value',...) creates a new FATOU_EXPLORER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Fatou_Explorer_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Fatou_Explorer_OpeningFcn via varargin.
%
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fatou_Explorer_OpeningFcn, ...
                   'gui_OutputFcn',  @Fatou_Explorer_OutputFcn, ...
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

function Fatou_Explorer_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
Nx = 600;
Ax = linspace(0,.5,Nx);
Ay = linspace(0,.5,Nx);
Z = repmat(Ax,Nx,1) + repmat(Ay',1,Nx)*i;
c = 4-i;
cc = 4+i;
h = exp(2*pi*i*0.1876);
for j = 1:40
    Z = h*(Z.^2).*(Z - c)./ (1-Z*cc);
end

Z = abs(Z);
Z(find(Z==0))=2/256;
image(Z*256);colormap((1-gray(256))*.75);axis off;shg

guidata(hObject, handles);

function varargout = Fatou_Explorer_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function para_1_Callback(hObject, eventdata, handles)
Parabolic_Example_1;

function para_2_Callback(hObject, eventdata, handles)
Parabolic_Example_2;

function siegel1_Callback(hObject, eventdata, handles)
Siegel_Disc_Example_1;

function siegel2_Callback(hObject, eventdata, handles)
Siegel_Disc_Example_2;

function attracting_Callback(hObject, eventdata, handles)
Attracting_Example;

function super_Callback(hObject, eventdata, handles)
Super_Attracting_Example;

function Untitled_4_Callback(hObject, eventdata, handles)
function Untitled_5_Callback(hObject, eventdata, handles)
function herman_Callback(hObject, eventdata, handles)
Herman_Ring_Example;

function Untitled_1_Callback(hObject, eventdata, handles)
function finite_Callback(hObject, eventdata, handles)
Finitely_Connected_Example;

function Untitled_6_Callback(hObject, eventdata, handles)
function Untitled_7_Callback(hObject, eventdata, handles)
function dynamics_Callback(hObject, eventdata, handles)
Dynamics;

function examples_Callback(hObject, eventdata, handles)
Examples;
