function varargout = Gracia(varargin)
% GRACIA MATLAB code for Gracia.fig
%      GRACIA, by itself, creates a new GRACIA or raises the existing
%      singleton*.
%
%      H = GRACIA returns the handle to a new GRACIA or the handle to
%      the existing singleton*.
%
%      GRACIA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRACIA.M with the given input arguments.
%
%      GRACIA('Property','Value',...) creates a new GRACIA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gracia_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gracia_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gracia

% Last Modified by GUIDE v2.5 12-Aug-2014 12:39:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gracia_OpeningFcn, ...
                   'gui_OutputFcn',  @Gracia_OutputFcn, ...
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


% --- Executes just before Gracia is made visible.
function Gracia_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gracia (see VARARGIN)

% Choose default command line output for Gracia
handles.output = hObject;
%A = imread('C:\Users\Javi\Documents\MATLAB\Rufa.jpg');
%imshow(A);
%clear A;
Name = horzcat(num2str(100*get(handles.slider1,'value')),'%');
set(handles.text8,'string',Name);
clear Name;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gracia wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gracia_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
global S;
Escala = get(handles.slider1,'Value');
set(handles.text8,'string',horzcat(num2str(Escala*100),'%'));
if Escala == 1
    set(handles.text9,'String','¡ Esto no modifica nada !');
elseif Escala == 0
    set(handles.text9,'String','¡ Esto borra la imagen !');
else set(handles.text9,'String','');
end
if S == 0
    %
else
    set(handles.text7,'String',num2str(S*Escala*10^(-6)));
end




% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global InitialFolder CapitalFormat SmallFormat;

if isempty(InitialFolder)==1 || isempty(CapitalFormat)==1
    set(handles.text9,'String','Select valid format or folder');
else
    
    Data = dir(InitialFolder);
    NewFolder = horzcat('Escala_',num2str(get(handles.slider1,'Value')));
    mkdir(InitialFolder,NewFolder);
    Escala = get(handles.slider1,'Value');
    h=waitbar(0,'Wait a moment...');
    for i = 3:length(Data)
        waitbar(i/length(Data),h,'Wait a moment');
        [~,name,ext] = fileparts(Data(i).name);
        if strcmp(ext,CapitalFormat) || strcmp(ext,SmallFormat) ;
            ActualImage = imread(Data(i).name);
            EscaleImage = imresize(ActualImage,Escala);
            NewName = horzcat(name,'_',num2str(Escala),SmallFormat);
            cd(NewFolder);
            imwrite(EscaleImage,NewName,SmallFormat(2:end));
            cd(InitialFolder);
        else
            cd(InitialFolder);
            continue;       
        end
    end
    close(h);
end

% --- Executes on button press in text1.
function text1_Callback(hObject, eventdata, handles)
global InitialFolder S
InitialFolder = uigetdir('C','Select folder');
set(handles.text13,'String',InitialFolder);
Data = dir(InitialFolder);
cd(InitialFolder);
S = 0;
N = 0;
for i = 3:length(Data)
    S = Data(i).bytes+S;
end
set(handles.text5,'String',num2str(S*10^(-6)));
set(handles.text4,'String',num2str(length(Data)-2));
Escala = get(handles.slider1,'Value');
set(handles.text7,'String',num2str(S*Escala*10^(-6)));


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
global CapitalFormat SmallFormat
Option=get(hObject,'Value');
switch Option
    case 1
        set(handles.text9,'String','Select a valid format');
    case 2
        set(handles.text9,'String','');
        CapitalFormat = '.JPG';
        SmallFormat = '.jpg';
    case 3
        set(handles.text9,'String','');
        CapitalFormat = '.PNG';
        SmallFormat = '.png';
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
close(Gracia);
