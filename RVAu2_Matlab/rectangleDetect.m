function [rect] = rectangleDetect(linhas, Image)
%rectangleDetect Esta fun��o recolhe os retangulos contendo os livros a
%partir das linhas verticais detetadas
    % vari�vel para guardar os retangulos
    rect = {};
    figure, imshow(Image), hold on
    for k = 1:length(linhas) - 1 
        deltaX = abs(linhas(k, 1) - linhas(k + 1, 1));
        deltaY = abs(min(linhas(k, 3),linhas(k + 1, 3)) - max(linhas(k, 4), linhas(k + 1, 4)));
        larguraMinima = 10;
        alturaMinima = 20;
        if deltaX > larguraMinima && deltaY > alturaMinima
            % a guardar as coordenadas do 1� vertices do retangulo, o seu
            % comprimento e largura
            rect = cat(1, rect, [linhas(k, 1), min(linhas(k, 3),linhas(k + 1, 3)), deltaX, deltaY]);
            % a desenhar o ret�ngulo
            rectangle('Position', [linhas(k, 1), min(linhas(k, 3),linhas(k + 1, 3)), deltaX, deltaY]);
        end
    end

end

