function varargout = naca_airfoil(varargin)
% NACA_AIRFOIL MATLAB code for naca_airfoil.fig
%      NACA_AIRFOIL, by itself, creates a new NACA_AIRFOIL or raises the existing
%      singleton*.
%
%      H = NACA_AIRFOIL returns the handle to a new NACA_AIRFOIL or the handle to
%      the existing singleton*.
%
%      NACA_AIRFOIL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NACA_AIRFOIL.M with the given input arguments.
%
%      NACA_AIRFOIL('Property','Value',...) creates a new NACA_AIRFOIL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before naca_airfoil_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to naca_airfoil_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help naca_airfoil

% Last Modified by GUIDE v2.5 29-Jun-2017 20:36:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @naca_airfoil_OpeningFcn, ...
                   'gui_OutputFcn',  @naca_airfoil_OutputFcn, ...
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


% --- Executes just before naca_airfoil is made visible.
function naca_airfoil_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to naca_airfoil (see VARARGIN)

% Add standard toolbar
set(hObject,'toolbar','figure');

% Choose default command line output for naca_airfoil
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes naca_airfoil wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = naca_airfoil_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%INITIALIZATION
typeNACA=get(handles.nacatype_edit,'String');
n=get(handles.gridpoint_edit,'String');
axes(handles.airfoilplot);
title('Airfoil Plot');
xlabel('[x/c]\rightarrow');
ylabel('[y/c]\uparrow');

function nacatype_edit_Callback(hObject, eventdata, handles)
% hObject    handle to nacatype_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
typeNACA=get(handles.nacatype_edit,'String');
[~,digits]=size(typeNACA);
if(digits==4)
    set(handles.plotstatus,'String','Ready to plot','ForegroundColor','black');
    set(handles.plotbutton,'Enable','on');
else
    set(handles.plotstatus,'String','Enter 4-digit Airfoil','ForegroundColor','red');
    set(handles.plotbutton,'Enable','off');
end
% Hints: get(hObject,'String') returns contents of nacatype_edit as text
%        str2double(get(hObject,'String')) returns contents of nacatype_edit as a double


% --- Executes during object creation, after setting all properties.
function nacatype_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nacatype_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gridpoint_edit_Callback(hObject, eventdata, handles)
% hObject    handle to gridpoint_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=str2num(get(handles.gridpoint_edit,'String'));
if(n<3)
    set(handles.plotstatus,'String','Enter more grid points','ForegroundColor','red');
    set(handles.plotbutton,'Enable','off');
else
    set(handles.plotstatus,'String','Ready to plot','ForegroundColor','black');
    set(handles.plotbutton,'Enable','on');
end
% Hints: get(hObject,'String') returns contents of gridpoint_edit as text
%        str2double(get(hObject,'String')) returns contents of gridpoint_edit as a double


% --- Executes during object creation, after setting all properties.
function gridpoint_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gridpoint_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plotbutton.
function plotbutton_Callback(hObject, eventdata, handles)
% hObject    handle to plotbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.airfoilplot,'reset');
typeNACA=get(handles.nacatype_edit,'String');

% Pop-up Menus
camber=get(handles.cambermenu,'Value');
plottype=get(handles.plottypemenu,'Value');
trailedge=get(handles.trailingedgemenu,'Value');

n=str2num(get(handles.gridpoint_edit,'String'));
c=1;
m=str2num(typeNACA(1:1));
p=str2num(typeNACA(2:2));
t=str2num(typeNACA(3:4));
t=t/100;
m=m/100;
p=p/10;
x=linspace(0,c,n);
a0 = 0.2969;
a1 = -0.1260;
a2 = -0.3516;
a3 = 0.2843;

if(trailedge==1)
    a4=-0.1036;
else
    a4=-0.1015; 
end

y_c=ones(n,1);
dy_c=ones(n,1);
theta=ones(n,1);
for i=1:1:n
    if(x(i)>=0 && x(i)<p)
        y_c(i)=(m/p^2)*((2*p*x(i))-x(i)^2);
        dy_c(i)=((2*m)/(p^2))*(p-x(i));
    else
        y_c(i)=(m/(1-p)^2)*(1-(2*p)+(2*p*x(i))-x(i)^2);
        dy_c(i)=((2*m)/(1-p)^2)*(p-x(i));
    end
    theta(i)=atan(dy_c(i));
end
y_t = 5*t.*((a0.*sqrt(x)) + (a1.*x) + (a2.*x.^2) + (a3.*x.^3) + (a4.*x.^4));
x_u=x(:)-y_t(:).*sin(theta);
x_l=x(:)+y_t(:).*sin(theta);
y_u=y_c(:)+y_t(:).*cos(theta);
y_l=y_c(:)-y_t(:).*cos(theta);
axes(handles.airfoilplot);
hold on;
grid on;
axis 'equal';
title('Airfoil Plot');
xlabel('[x/c]\rightarrow');
ylabel('[y/c]\rightarrow');
if(plottype==1)
    plot(x_l,y_l,'r-');
    plot(x_u,y_u,'r-');
    if(camber==1)
        plot(x,y_c,'b-');
    end
elseif(plottype==2)
    plot(x_l,y_l,'r.');
    plot(x_u,y_u,'r.');
    if(camber==1)
        plot(x,y_c,'b.');
    end
elseif(plottype==3)
    plot(x_l,y_l,'rx');
    plot(x_u,y_u,'rx');
    if(camber==1)
        plot(x,y_c,'bx');
    end
else
    plot(x_l,y_l,'ro');
    plot(x_u,y_u,'ro');
    if(camber==1)
        plot(x,y_c,'bo');
    end
end


% --- Executes on selection change in cambermenu.
function cambermenu_Callback(hObject, eventdata, handles)
% hObject    handle to cambermenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cambermenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cambermenu


% --- Executes during object creation, after setting all properties.
function cambermenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cambermenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in trailingedgemenu.
function trailingedgemenu_Callback(hObject, eventdata, handles)
% hObject    handle to trailingedgemenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns trailingedgemenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from trailingedgemenu


% --- Executes during object creation, after setting all properties.
function trailingedgemenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trailingedgemenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in plottypemenu.
function plottypemenu_Callback(hObject, eventdata, handles)
% hObject    handle to plottypemenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns plottypemenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plottypemenu


% --- Executes during object creation, after setting all properties.
function plottypemenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plottypemenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
