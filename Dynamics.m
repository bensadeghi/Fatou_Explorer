function varargout = Dynamics(varargin)
% DYNAMICS M-file for Dynamics.fig
%      DYNAMICS, by itself, creates a new DYNAMICS or raises the existing
%      singleton*.
%
%      H = DYNAMICS returns the handle to a new DYNAMICS or the handle to
%      the existing singleton*.
%
%      DYNAMICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DYNAMICS.M with the given input arguments.
%
%      DYNAMICS('Property','Value',...) creates a new DYNAMICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Dynamics_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Dynamics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Dynamics_OpeningFcn, ...
                   'gui_OutputFcn',  @Dynamics_OutputFcn, ...
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

function Dynamics_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);

function varargout = Dynamics_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

