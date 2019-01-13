% =========================================================================
% Institution : FEUP - Faculdade de Engenharia de Universidade do Porto
% Class       : Realidade Virtual e Aumentada
% Name        : trab_2_RVAU.m
% Author      : Carlos Frias & Nuno Marques
% Version     : 0.01
% Description : Trabalho 2 - Realidade Aumentada aplicada a uma biblioteca
% =========================================================================

% carregar lista das imagens
MLivros = loaddbfiles('DBimage/dbbooks.txt');
MEstantes = loaddbfiles('DBimage/dbbookcase.txt');

% url's das imagens default
pathImg = 'DBimage/estante03.jpg';
pathTemplateImg = 'DBimage/livro06.jpg';
heightShelf = 41.1;
widthShelf = 60.4;
widthBook = 7.5;

% escolher o livro a procurar
MLivrosSize = size(MLivros);
for i = 1:MLivrosSize(1)
	disp(sprintf('Livro %d - %s.',i,MLivros{i,1}));
end
reply = input(sprintf('\nEscolha o numero do LIVRO (1..%d): ', MLivrosSize(1)));
if ~isempty(reply) && reply > 0 && reply < MLivrosSize(1)+1
	pathTemplateImg = MLivros{reply,2};
	widthBook = str2double(MLivros{reply,3});
end

% escolhe em qual estante procurar
MEstantesSize = size(MEstantes);
for i = 1:MEstantesSize(1)
	disp(sprintf('Estante %d - %s.',i, MEstantes{i,1}));
end
reply = input(sprintf('\nEscolha o numero da ESTANTE (1..%d): ', MEstantesSize(1)));
if ~isempty(reply) && reply > 0 && reply < MEstantesSize(1)+1
	pathImg = MEstantes{reply,2};
	widthShelf = str2double(MEstantes{reply,3});
	heightShelf = str2double(MEstantes{reply,4});
	threshold = str2double(MEstantes{reply,5});
end

% a carregar a imagem e template!
imgColor = imread(pathImg);
imageTemplate = imread(pathTemplateImg);

% a converter para uma escala de cinzentos.
img = rgb2gray(imgColor);

% a aumentar o contraste na imagem
img = imadjust(img);

% escolha metodo de selecao do livro
disp('1 - Normxcorr2');
disp('2 - HoughLines');
disp('3 - BackProction');
reply = input(sprintf('\nEscolha metodo de Procura (1..3): '));
if ~isempty(reply) && reply == 1

	% escolha metodo de selecao de pontos
	disp('1 - Auto');
	disp('2 - Manual');
	reply = input(sprintf('\nEscolha modo de selecao dos PONTOS (1..2): '));
	if ~isempty(reply) && reply == 1
		input_points = cornerdetection(imgColor, threshold);
		[image, tform] = homograph_auto(pathImg, widthShelf, heightShelf, input_points);
	else
		% a obter a homografia (Neste momento a escolha dos pontos é manual).
		[image, tform] = homograph_manual(pathImg, widthShelf, heightShelf);
	end
	
	% a guardar a imagem após realizada a homografia apos crop da prateleira.
	imwrite(image,'Imagens/homografia_prateleira.jpg','jpg');

	[point1, point2, point3, point4, found] = findBook(image, imageTemplate, widthShelf, widthBook);

	if found
		% a obter as coordenadas dos cantos do livro detetado na imagem original
		[x1, y1] = tforminv(tform, point1(1), point1(2));
		[x2, y2] = tforminv(tform, point2(1), point2(2));
		[x3, y3] = tforminv(tform, point3(1), point3(2));
		[x4, y4] = tforminv(tform, point4(1), point4(2));
		% a arredondar as coordenadas para inteiros
		x1 = round(x1); x2 = round(x2); x3 = round(x3); x4 = round(x4);
		y1 = round(y1); y2 = round(y2); y3 = round(y3); y4 = round(y4);

		selection(imgColor, [x1 y1; x2 y2;x3 y3;x4 y4]);
	end
end
if ~isempty(reply) && reply == 3

	% escolha metodo de selecao de pontos
	disp('1 - Auto');
	disp('2 - Manual');
	reply = input(sprintf('\nEscolha modo de selecao dos PONTOS (1..2): '));
	if ~isempty(reply) && reply == 1
		input_points = cornerdetection(imgColor, threshold);
		[image, tform] = homograph_auto(pathImg, widthShelf, heightShelf, input_points);
	else
		% a obter a homografia (Neste momento a escolha dos pontos é manual).
		[image, tform] = homograph_manual(pathImg, widthShelf, heightShelf);
	end

	% a guardar a imagem após realizada a homografia apos crop da prateleira.
	imwrite(image,'Imagens/homografia_prateleira.jpg','jpg');

	figure, imshow(backprojection(image, imageTemplate))
end 

