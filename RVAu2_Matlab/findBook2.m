function [Point1, Point2, Point3, Point4, Found] = findBook2(image, bookTemplate)
%findBook Esta função recebe como argumentos os caminhos da imagem e do
%template do livro a procurar e retorna as coordenadas dos quatro cantos do
%livro detetado na imagem homografia (posição frontal)
    % a converter para uma escala de cinzentos
    BwBookTemplate = rgb2gray(bookTemplate);
    % a converter para uma escala de cinzentos
    BwImage = rgb2gray(image);
    % a adequirir as dimensões do template e da imagem
    sizeTemplate = size(BwBookTemplate);
    sizeImage = size(BwImage);
    % a garantir que o tamanho do template é menor que o da imagem
    if(sizeImage(1) > sizeTemplate(1) && sizeImage(2) > sizeTemplate(2))
        % a obter a matriz de correlação entre as duas imagens
        crossCorrMatrix = normxcorr2(BwBookTemplate, BwImage);
        % a obter o ponto da imagem da prateleira que possui a correlação
        % máxima com o template do livro
        [lastY,lastX] = find(crossCorrMatrix == max(crossCorrMatrix(:)));        
        if crossCorrMatrix(lastY,lastX) < 0.4
            Found = false;
        else
            Found = true;
        end
        disp(crossCorrMatrix(lastY,lastX));
        % a obter o tamanho(número de linhas e colunas) do bookTemplate
        [numRowsTemplate, numColumsTemplate] = size(BwBookTemplate);
        %A determinar as coordenadas dos cantos livro na imagem em pose
        %frontal
        firstY = lastY - (numRowsTemplate - 1);
        firstX = lastX - (numColumsTemplate - 1);
        Point1 = [firstX firstY];
        Point2 = [firstX firstY + numRowsTemplate];
        Point3 = [firstX + numColumsTemplate  firstY + numRowsTemplate];
        Point4 = [firstX + numColumsTemplate firstY];
        % a mostrar a imagem com o livro detetado
        %figure, imshow(image);
        %selection(image, [Point1(1) Point1(2); Point2(1) Point2(2);Point3(1) Point3(2);Point4(1) Point4(2)]);
    else
        disp('O template é grande quando comparado com a imagem');
        Found = false;
    end
end