function varargout = grahicalInterface(varargin)
% GRAHICALINTERFACE MATLAB code for grahicalInterface.fig
%      GRAHICALINTERFACE, by itself, creates a new GRAHICALINTERFACE or raises the existing
%      singleton*.
%
%      H = GRAHICALINTERFACE returns the handle to a new GRAHICALINTERFACE or the handle to
%      the existing singleton*.
%
%      GRAHICALINTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAHICALINTERFACE.M with the given input arguments.
%
%      GRAHICALINTERFACE('Property','Value',...) creates a new GRAHICALINTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before grahicalInterface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to grahicalInterface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help grahicalInterface

% Last Modified by GUIDE v2.5 09-Dec-2012 13:46:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @grahicalInterface_OpeningFcn, ...
                   'gui_OutputFcn',  @grahicalInterface_OutputFcn, ...
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


% --- Executes just before grahicalInterface is made visible.
function grahicalInterface_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to grahicalInterface (see VARARGIN)

% Choose default command line output for grahicalInterface
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
img = imread('DBimage/livro01.jpg');
axes(handles.bookImageDisplay); %#ok<MAXES>
imshow(img);
img = imread('DBimage/estante02.jpg');
axes(handles.shelfImageDisplay); %#ok<MAXES>
imshow(img);
% a carregar dados do ficheiro da base de dados
MatrizLivros = loaddbfiles('DBimage/dbbooks.txt');
sizes = size(MatrizLivros);
% a carregar apenas os nomes dos livros
Nomes = {};
Diretorios = {};
Lombadas = {};
for i = 1: sizes(1)
    Nomes = cat(1,Nomes,MatrizLivros(i,1));
    Diretorios = cat(1,Diretorios,MatrizLivros(i,2));
    Lombadas = cat(1,Lombadas,MatrizLivros(i,3));
end
% a preencher os items do popupmenu dos livros a procurar
set(handles.popupLivroProcurar,'String', Nomes);
MatrizEstantes = loaddbfiles('DBimage/dbbookcase.txt');
NomesEstantes = {};
DitetoriosEstantes ={};
Widths={};
Heights={};
sizesM = size(MatrizEstantes);
for i = 1:sizesM(1);
    NomesEstantes = cat(1, NomesEstantes, MatrizEstantes(i,1));
    DitetoriosEstantes = cat(1, DitetoriosEstantes, MatrizEstantes(i,2));
    Widths = cat(1, Widths, MatrizEstantes(i,3));
    Heights = cat(1, Heights, MatrizEstantes(i,4));
end
set(handles.popupEstante,'String', NomesEstantes);

string_list{1} = 'Normxcorr2';
string_list{2} = 'HoughLines';
string_list{3} = 'BackProjection';

set(handles.popupMetodoProcura,'String', string_list);



% UIWAIT makes grahicalInterface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = grahicalInterface_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupLivroProcurar.
function popupLivroProcurar_Callback(hObject, ~, handles)
% hObject    handle to popupLivroProcurar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupLivroProcurar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupLivroProcurar
val = get(hObject,'Value');

% a carregar dados do ficheiro da base de dados
MatrizLivros = loaddbfiles('DBimage/dbbooks.txt');
sizes = size(MatrizLivros);
% a carregar apenas os nomes dos livros
Nomes = {};
Diretorios = {};
Lombadas = {};
for i = 1: sizes(1)
    Nomes = cat(1,Nomes,MatrizLivros(i,1));
    Diretorios = cat(1,Diretorios,MatrizLivros(i,2));
    Lombadas = cat(1,Lombadas,MatrizLivros(i,3));
end
img = imread(Diretorios{val});
axes(handles.bookImageDisplay);
imshow(img);


% --- Executes during object creation, after setting all properties.
function popupLivroProcurar_CreateFcn(hObject, ~, ~)
% hObject    handle to popupLivroProcurar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in popupMetodoProcura.
function popupMetodoProcura_Callback(~, ~, ~)
% hObject    handle to popupMetodoProcura (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupMetodoProcura contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupMetodoProcura



% --- Executes during object creation, after setting all properties.
function popupMetodoProcura_CreateFcn(hObject, ~, ~)
% hObject    handle to popupMetodoProcura (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in botaoProcurar.
function botaoProcurar_Callback(~, ~, handles)
% hObject    handle to botaoProcurar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
M = loaddbfiles('DBimage/dbbooks.txt');
M2 = loaddbfiles('DBimage/dbbookcase.txt');
indextemplate = get(handles.popupLivroProcurar,'Value');
templatePath = M{indextemplate,2};
template = imread(templatePath);
%figure, imshow(template);
indexshelf = get(handles.popupEstante,'Value');
shelfPath = M2{indexshelf,2};
shelf = imread(shelfPath);
% a obter a homografia (Neste momento a escolha dos pontos é manual).
[image, tform] = homograph_manual(shelfPath, str2double(M2{indexshelf,3}), str2double(M2{indexshelf, 4}));
figure, imshow(image);

[point1, point2, point3, point4, Found] = findBook(image, template, str2double(M2{indexshelf,3}), str2double(M{indextemplate,3}));

if Found
    % a obter as coordenadas dos cantos do livro detetado na imagem original
    [x1, y1] = tforminv(tform, point1(1), point1(2));
    [x2, y2] = tforminv(tform, point2(1), point2(2));
    [x3, y3] = tforminv(tform, point3(1), point3(2));
    [x4, y4] = tforminv(tform, point4(1), point4(2));
    % a arredondar as coordenadas para inteiros
    x1 = round(x1); x2 = round(x2); x3 = round(x3); x4 = round(x4);
    y1 = round(y1); y2 = round(y2); y3 = round(y3); y4 = round(y4);

    detectedImage = selection(shelf, [x1 y1; x2 y2;x3 y3;x4 y4]);
    axes(handles.shelfImageDisplay); %#ok<MAXES>
    imshow(detectedImage);
else
    disp('Não encontrou o livro');
end
    



% --- Executes on selection change in popupEstante.
function popupEstante_Callback(hObject, ~, handles)
% hObject    handle to popupEstante (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupEstante contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupEstante
val = get(hObject,'Value');
% a carregar dados do ficheiro da base de dados
Matriz = loaddbfiles('DBimage/dbbookcase.txt');
sizes = size(Matriz);
% a carregar os nomes e diretórios das estantes
Nomes = {};
Diretorios = {};
for i = 1: sizes(1)
    Nomes = cat(1,Nomes,Matriz(i,1));
    Diretorios = cat(1,Diretorios,Matriz(i,2));
end
img = imread(Diretorios{val});
axes(handles.shelfImageDisplay); %#ok<MAXES>
imshow(img);

% --- Executes during object creation, after setting all properties.
function popupEstante_CreateFcn(hObject, ~, ~)
% hObject    handle to popupEstante (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function bookImageDisplay_CreateFcn(~, ~, ~)

% hObject    handle to bookImageDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate bookImageDisplay
