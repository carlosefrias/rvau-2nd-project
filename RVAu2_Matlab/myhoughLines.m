% =========================================================================
% Institution : FEUP - Faculdade de Engenharia de Universidade do Porto
% Class       : Realidade Virtual e Aumentada
% Name        : myhoughLines.m
% Author      : Carlos Frias & Nuno Marques
% Version     : 0.01
% Description : Trabalho 2 - Realidade Aumentada aplicada a uma biblioteca
% =========================================================================

%executar com
%Image = imread('Imagens/livros.png');
%Template = imread('Imagens/livro4.png');
%myhoughLines(Image, Template);

% fun��o que determina as linhas de Hough a partir da imagem
% e retorna as linhas horizontais e verticais
function myhoughLines(Image, Template) 
    % definir o n�mero de picos de Hough
    picsNumber = 40;
    % define n� m�ximo de pixeis a preencher no caso de falha na linha 
    fillGapValue = 10;
    % definir o comprimento m�nimo do segmento de reta
    minLenght = 4;        
    % admitir uma toler�ncia de 2� na dete��o de retas verticais e horizontais
    toleranceDegrees = 9;

    % a converter para uma escala de cinzentos
    ImageGray = rgb2gray(Image);

    % a aumentar o contraste da imagem
    ImageGray = imadjust(ImageGray);

    % a determinar as arestas
    ImageBW = edge(ImageGray, 'canny');
    
    %imshow(ImageBW);
    
    % a calcular a transformada de Hough
    [HoughTransfMatrix,Theta,Rho] = hough(ImageBW);
    % a mostrar as sinusoides da transformada de Hough
    imshow(HoughTransfMatrix,[],'XData',Theta,'YData',Rho,...
    'InitialMagnification','fit');
    % define a legenda do gr�fico
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;

    % a carregar a matriz de picos de Hough
    Peaks  = houghpeaks(HoughTransfMatrix, picsNumber, 'threshold', ceil(0.3 * max(HoughTransfMatrix(:))));
    x = Theta(Peaks(:, 2)); y = Rho(Peaks(:, 1));
    plot(x, y, 's', 'color', 'white');
    
    % a encontrar todos as linhas
    lines = houghlines(ImageBW, Theta, Rho, Peaks, 'FillGap', fillGapValue, 'MinLength', minLenght);
    
    % a selecionar apenas as linhas verticais
    lines = selectVerticalLines(lines, toleranceDegrees);
    
    % a desenhar as linhas verticais sobre a imagem
    drawHoughLines( lines, Image );
        
    % construir os retangulos, desenha-los e guarda-los na estrutura rect
    %rect = constructRectangles(lines);
    % a ordenar as linhas verticais por ordem crescente de abcissa
    linhasVerticais = orderingVerticalLines(lines);
        

    linhas = cell2mat(linhasVerticais);
    %efetuar um primeiro refinamento
    linhasVerticais = refinamento1(linhas);
    
    
    linhas = cell2mat(linhasVerticais);
    drawLines( linhas, Image );
    
    %TODO: Refinamento 2:
    % eliminar linhas cujo comprimento � demasiado curto
    linhasVerticais = refinamento2(linhas, 80);
    
    linhas = cell2mat(linhasVerticais);
    drawLines( linhas, Image );
    
    % vari�vel para guardar os retangulos
    rect = rectangleDetect(linhas, Image);
%     
%     %A testar a procura do livro e dete��o do n� do retangulo onde ele est�
%     %contido
    rect = cell2mat(rect);
%     %TODO - resolver o problema de widthShelf e widthBook
   [point1, ~, point3, ~, found] = findBook2(Image, Template);

    if found
        % a obter as coordenadas do centro da lombada do livro em pose
        % frontal
        x1 = point1(1);
        y1 = point1(2);
        x3 = point3(1);
        y3 = point3(2);
        x = (x1 + x3)/2;
        y = (y1 + y3)/2;
        % a arredondar as coordenadas para inteiros
        x = round(x);
        y = round(y);
        for i = 1: length(rect) 
            % verificar se o ponto (x,y) est� dentro deste retangulo
            if x >= rect(i,1) && x <= rect(i,1) + rect(i,3) && y >= rect(i,2) && y <= rect(i,2) + rect(i,4)
                %encontrou o retangulo
                %bookfound = true;
                %a clarear a imagem e apresentar a zona do livro
                selection(Image, [rect(i,1) rect(i,2); rect(i,1) rect(i,2) + rect(i,4);rect(i,1) + rect(i,3)  rect(i,2) + rect(i,4);rect(i,1) + rect(i,3) rect(i,2)]);
                break;
            end
        end
        %selection(imgColor, [x1 y1; x2 y2;x3 y3;x4 y4]);
    else
            disp('N�o encontrei o livro');
    end
end