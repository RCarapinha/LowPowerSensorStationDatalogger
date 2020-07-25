function varargout = V1(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @V1_OpeningFcn, ...
    'gui_OutputFcn',  @V1_OutputFcn, ...
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

function V1_OpeningFcn(hObject, ~, handles, varargin)
global Minimo;
global Maximo;
global hax;
global y;
global M;
global T1;
global T2;
global Dia1;
global Dia2;
global Dia3;
global Dia4;
global Dia5;
global Dia6;
global Dia7;
global Dia8;
global Dia9;
global Dia10;
global Temp1;
global Temp2;
global Lines;

handles.output = hObject;
guidata(hObject, handles);
M = dlmread('DATALOG.TXT');
Dia1 = M(M(:,3)==1,:);
Dia2  = M(M(:,3)==2,:);
Dia3  = M(M(:,3)==3,:);
Dia4  = M(M(:,3)==4,:);
Dia5  = M(M(:,3)==5,:);
Dia6  = M(M(:,3)==6,:);
Dia7  = M(M(:,3)==7,:);
Dia8  = M(M(:,3)==8,:);
Dia9  = M(M(:,3)==9,:);
Dia10  = M(M(:,3)==10,:);

hold on
Temp1 = M(:,7);
Temp2 = M(:,8);
T1 = plot(1:length(M),M(:,7));
T2 = plot(1:length(M),M(:,8));

hax = handles.axes1;
grid on
Minimo = min(Temp1);
if min(Temp2) < Minimo
    Minimo = min(Temp2);
end

Maximo = max(Temp1);
if max(Temp2) >= Maximo
    Maximo = max(Temp2);
end

y = length(M);
ylim([Minimo-2 Maximo+2])
xlim([0 y])
set(T1,'Visible','on')
set(T2,'Visible','on')

title('Temperature History');
ylabel('Temp (ºC)');
xlabel('Time');
set(handles.checkbox1,'value',1);
set(handles.checkbox2,'value',1);
for k = 1:length(M)
    Lines(k) = line([k k],get(handles.axes1,'YLim'),'Color',[0 0 0],'LineWidth',1);
    set(Lines(k),'Visible','off');
end
set(handles.slider1,'Min',1);
set(handles.slider1,'Max',length(M));
set(handles.slider1,'Value',1);
set(handles.slider1, 'SliderStep', [1/length(M) , 10/length(M) ]);
legend('T1','T2');
% --- Outputs from this function are returned to the command line.
function varargout = V1_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(~, ~, ~)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, ~, ~)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, ~, ~)
global T1;
if get(hObject,'Value') == 0
    set(T1,'Visible','off');
else
    set(T1,'Visible','on');
end

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, ~, ~)
global T2;
if get(hObject,'Value') == 0
    set(T2,'Visible','off');
else
    set(T2,'Visible','on');
end

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(~, ~, ~)
global Temp1;
global Temp2;
global Minimo;
global Maximo;

Minimo = min(Temp1);
if min(Temp2) <= Minimo
    Minimo = min(Temp2);
end

Maximo = max(Temp1);
if max(Temp2) >= Maximo
    Maximo = max(Temp2);
end

ylim([Minimo-2 Maximo+2])
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(~, ~, handles)
global Maximo;
global Minimo;
global hax;
global y;
global M;
global Temp1;
global Temp2;
global T1;
global T2;
global Dia1;
global Dia2;
global Dia3;
global Dia4;
global Dia5;
global Dia6;
global Dia7;
global Dia8;
global Dia9;
global Dia10;


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
popup_index = get(handles.popupmenu1,'Value');
switch popup_index
    case 1
        T1 = plot(1:length(M),M(:,7));
        T2 = plot(1:length(M),M(:,8));
        Temp1 = M(:,7);
        Temp2 = M(:,8);
        hax = handles.axes1;
        title('Temperature History');
        legend('T1','T2');
        ylabel('Temp (ºC)');
        xlabel('Time');
        y = length(M);
        Minimo = min(Temp1);
        if min(Temp2) <= Minimo
            Minimo = min(Temp2);
        end
        
        Maximo = max(Temp1);
        if max(Temp2) >= Maximo
            Maximo = max(Temp2);
        end
        
        ylim([Minimo-2 Maximo+2])
        xlim([0 y])
        set(handles.checkbox1,'value',1);
        set(handles.checkbox2,'value',1);
        set(handles.checkbox3,'value',1);
        set(handles.checkbox4,'value',1);
        set(handles.checkbox5,'value',1);
        set(handles.checkbox8,'value',1);
    case 2
        if(isempty(Dia1))
            msgbox('Sem Dados')
        else
            cla;
            T1 = plot(1:length(Dia1),Dia1(:,7));
            T2 = plot(1:length(Dia1),Dia1(:,8));
            
            Temp1 = Dia1(:,7);
            Temp2 = Dia1(:,8);
            
            Minimo = min(Temp1);
            if min(Temp2) <= Minimo
                Minimo = min(Temp2);
            end
            
            Maximo = max(Temp1);
            if max(Temp2) >= Maximo
                Maximo = max(Temp2);
            end
            
            hax = handles.axes1;
            
            title('Temperature History');
            ylabel('Temp (ºC)');
            xlabel('Time');
            y = length(Dia1);
            ylim([Minimo-2 Maximo+2])
            xlim([0 y])
            set(handles.checkbox1,'value',1);
            set(handles.checkbox2,'value',1);
            set(handles.checkbox3,'value',1);
            set(handles.checkbox4,'value',1);
            set(handles.checkbox5,'value',1);
            set(handles.checkbox8,'value',1);
        end
    case 3
        if(isempty(Dia2))
            msgbox('Sem Dados')
        else
            cla;
            T1 = plot(1:length(Dia2),Dia2(:,7));
            T2 = plot(1:length(Dia2),Dia2(:,8));
            Temp1 = Dia2(:,7);
            Temp2 = Dia2(:,8);
            Minimo = min(Temp1);
            if min(Temp2) <= Minimo
                Minimo = min(Temp2);
            end
            
            Maximo = max(Temp1);
            if max(Temp2) >= Maximo
                Maximo = max(Temp2);
            end
            
            hax = handles.axes1;
            title('Temperature History');
            ylabel('Temp (ºC)');
            xlabel('Time');
            y = length(Dia2);
            ylim([Minimo-2 Maximo+2])
            xlim([0 y])
            set(handles.checkbox1,'value',1);
            set(handles.checkbox2,'value',1);
            set(handles.checkbox3,'value',1);
            set(handles.checkbox4,'value',1);
            set(handles.checkbox5,'value',1);
            set(handles.checkbox8,'value',1);
            legend('T1','T2');
        end
        
    case 4
        if(isempty(Dia3))
            msgbox('Sem Dados')
        else
            cla;
            T1 = plot(1:length(Dia3),Dia3(:,7));
            T2 = plot(1:length(Dia3),Dia3(:,8));
            
            Temp1 = Dia3(:,7);
            Temp2 = Dia3(:,8);
            
            Minimo = min(Temp1);
            if min(Temp2) <= Minimo
                Minimo = min(Temp2);
            end
            
            Maximo = max(Temp1);
            if max(Temp2) >= Maximo
                Maximo = max(Temp2);
            end
            
            hax = handles.axes1;
            title('Temperature History');
            legend('T1','T2');
            ylabel('Temp (ºC)');
            xlabel('Time');
            y = length(Dia3);
            ylim([Minimo-2 Maximo+2])
            xlim([0 y])
            set(handles.checkbox1,'value',1);
            set(handles.checkbox2,'value',1);
            set(handles.checkbox3,'value',1);
            set(handles.checkbox4,'value',1);
            set(handles.checkbox5,'value',1);
            set(handles.checkbox8,'value',1);
        end
    case 5
        if(isempty(Dia4))
            msgbox('Sem Dados')
        else
            cla;
            T1 = plot(1:length(Dia4),Dia4(:,7));
            T2 = plot(1:length(Dia4),Dia4(:,8));
            
            Temp1 = Dia4(:,7);
            Temp2 = Dia4(:,8);
            
            Minimo = min(Temp1);
            if min(Temp2) <= Minimo
                Minimo = min(Temp2);
            end
            
            Maximo = max(Temp1);
            if max(Temp2) >= Maximo
                Maximo = max(Temp2);
            end
            
            hax = handles.axes1;
            title('Temperature History');
            legend('T1','T2');
            ylabel('Temp (ºC)');
            xlabel('Time');
            y = length(Dia4);
            ylim([Minimo-2 Maximo+2])
            xlim([0 y])
            set(handles.checkbox1,'value',1);
            set(handles.checkbox2,'value',1);
            set(handles.checkbox3,'value',1);
            set(handles.checkbox4,'value',1);
            set(handles.checkbox5,'value',1);
            set(handles.checkbox8,'value',1);
        end
    case 6
        if(isempty(Dia5))
            msgbox('Sem Dados')
        else
            cla;
            T1 = plot(1:length(Dia5),Dia5(:,7));
            T2 = plot(1:length(Dia5),Dia5(:,8));
            
            Temp1 = Dia5(:,7);
            Temp2 = Dia5(:,8);
            
            Minimo = min(Temp1);
            if min(Temp2) <= Minimo
                Minimo = min(Temp2);
            end
            
            Maximo = max(Temp1);
            if max(Temp2) >= Maximo
                Maximo = max(Temp2);
            end
            
            hax = handles.axes1;
            title('Temperature History');
            legend('T1','T2');
            ylabel('Temp (ºC)');
            xlabel('Time');
            y = length(Dia5);
            ylim([Minimo-2 Maximo+2])
            xlim([0 y])
            set(handles.checkbox1,'value',1);
            set(handles.checkbox2,'value',1);
            set(handles.checkbox3,'value',1);
            set(handles.checkbox4,'value',1);
            set(handles.checkbox5,'value',1);
            set(handles.checkbox8,'value',1);
        end
    case 7
        if(isempty(Dia6))
            msgbox('Sem Dados')
        else
            cla;
            T1 = plot(1:length(Dia6),Dia6(:,7));
            T2 = plot(1:length(Dia6),Dia6(:,8));
            
            Temp1 = Dia6(:,7);
            Temp2 = Dia6(:,8);
            
            Minimo = min(Temp1);
            if min(Temp2) <= Minimo
                Minimo = min(Temp2);
            end
            
            Maximo = max(Temp1);
            if max(Temp2) >= Maximo
                Maximo = max(Temp2);
            end
            
            hax = handles.axes1;
            title('Temperature History');
            legend('T1','T2');
            ylabel('Temp (ºC)');
            xlabel('Time');
            y = length(Dia6);
            ylim([Minimo-2 Maximo+2])
            xlim([0 y])
            set(handles.checkbox1,'value',1);
            set(handles.checkbox2,'value',1);
            set(handles.checkbox3,'value',1);
            set(handles.checkbox4,'value',1);
            set(handles.checkbox5,'value',1);
            set(handles.checkbox8,'value',1);
        end
    case 8
        if(isempty(Dia7))
            msgbox('Sem Dados')
        else
            cla;
            T1 = plot(1:length(Dia7),Dia7(:,7));
            T2 = plot(1:length(Dia7),Dia7(:,8));
            
            Temp1 = Dia7(:,7);
            Temp2 = Dia7(:,8);
            
            Minimo = min(Temp1);
            if min(Temp2) <= Minimo
                Minimo = min(Temp2);
            end
            
            Maximo = max(Temp1);
            if max(Temp2) >= Maximo
                Maximo = max(Temp2);
            end
            
            hax = handles.axes1;
            
            title('Temperature History');
            legend('T1','T2');
            ylabel('Temp (ºC)');
            xlabel('Time');
            y = length(Dia7);
            ylim([Minimo-2 Maximo+2])
            xlim([0 y])
            set(handles.checkbox1,'value',1);
            set(handles.checkbox2,'value',1);
            set(handles.checkbox3,'value',1);
            set(handles.checkbox4,'value',1);
            set(handles.checkbox5,'value',1);
            set(handles.checkbox8,'value',1);
        end
    case 9
        if(isempty(Dia8))
            msgbox('Sem Dados')
        else
            cla;
            T1 = plot(1:length(Dia8),Dia8(:,7));
            T2 = plot(1:length(Dia8),Dia8(:,8));
            
            Temp1 = Dia8(:,7);
            Temp2 = Dia8(:,8);
            
            Minimo = min(Temp1);
            if min(Temp2) <= Minimo
                Minimo = min(Temp2);
            end
            
            Maximo = max(Temp1);
            if max(Temp2) >= Maximo
                Maximo = max(Temp2);
            end
            
            hax = handles.axes1;
            
            title('Temperature History');
            legend('T1','T2');
            ylabel('Temp (ºC)');
            xlabel('Time');
            y = length(Dia8);
            ylim([Minimo-2 Maximo+2])
            xlim([0 y])
            set(handles.checkbox1,'value',1);
            set(handles.checkbox2,'value',1);
            set(handles.checkbox3,'value',1);
            set(handles.checkbox4,'value',1);
            set(handles.checkbox5,'value',1);
            set(handles.checkbox8,'value',1);
        end
    case 10
        if(isempty(Dia9))
            msgbox('Sem Dados')
        else
            cla;
            T1 = plot(1:length(Dia9),Dia9(:,7));
            T2 = plot(1:length(Dia9),Dia9(:,8));
            
            Temp1 = Dia9(:,7);
            Temp2 = Dia9(:,8);
            
            Minimo = min(Temp1);
            if min(Temp2) <= Minimo
                Minimo = min(Temp2);
            end
            
            Maximo = max(Temp1);
            if max(Temp2) >= Maximo
                Maximo = max(Temp2);
            end
            
            hax = handles.axes1;
            
            title('Temperature History');
            legend('T1','T2');
            ylabel('Temp (ºC)');
            xlabel('Time');
            y = length(Dia9);
            set(handles.checkbox1,'value',1);
            set(handles.checkbox2,'value',1);
            set(handles.checkbox3,'value',1);
            set(handles.checkbox4,'value',1);
            set(handles.checkbox5,'value',1);
            set(handles.checkbox8,'value',1);
        end
    case 11
        if(isempty(Dia10))
            msgbox('Sem Dados')
        else
            cla;
            T1 = plot(1:length(Dia10),Dia10(:,7));
            T2 = plot(1:length(Dia10),Dia10(:,8));
            
            Temp1 = Dia10(:,7);
            Temp2 = Dia10(:,8);
            
            Minimo = min(Temp1);
            if min(Temp2) <= Minimo
                Minimo = min(Temp2);
            end
            
            Maximo = max(Temp1);
            if max(Temp2) >= Maximo
                Maximo = max(Temp2);
            end
            
            hax = handles.axes1;
            
            title('Temperature History');
            legend('T1','T2');
            ylabel('Temp (ºC)');
            xlabel('Time');
            y = length(Dia10);
            set(handles.checkbox1,'value',1);
            set(handles.checkbox2,'value',1);
            set(handles.checkbox3,'value',1);
            set(handles.checkbox4,'value',1);
            set(handles.checkbox5,'value',1);
            set(handles.checkbox8,'value',1);
        end
    otherwise
        disp('Erro');
end

% --- Executes on slider movement.
function slider1_Callback(hObject, ~, handles)
global Lines;
global M;
global C;
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
C = int32(get(hObject,'Value'));
for k = 1:length(M)
    set(Lines(1,k),'Visible','off');
end
set(Lines(1,C),'Visible','on');

Mes = sprintf('%.0f', M(C,2));
set(handles.st_mes,'String',Mes);

Dia = sprintf('%.0f', M(C,3));
set(handles.st_dia,'String',Dia);

Hora = sprintf('%.0f', M(C,4));
set(handles.st_hora,'String',Hora);

Min = sprintf('%.0f', M(C,5));
set(handles.st_min,'String',Min);

VT1 = sprintf('%.2f', M(C,7));
set(handles.st_t1,'String',VT1);

VT2 = sprintf('%.2f', M(C,8));
set(handles.st_t2,'String',VT2);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, ~, ~)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
