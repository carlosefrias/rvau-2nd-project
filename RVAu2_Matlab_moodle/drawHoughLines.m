function drawHoughLines( lines, Image )
%drawHoughLines Função que desenha na imagem as linhas de Hough que foram
%denolvidas num structarray pela função houghlines

    figure, imshow(Image), hold on
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:, 1), xy(:, 2), 'LineWidth', 2, 'Color', 'green');

        % a desenhar os pontos extremos dos segmentos de reta
        plot(xy(1, 1), xy(1, 2), 'x', 'LineWidth', 2, 'Color', 'yellow');
        plot(xy(2, 1), xy(2, 2), 'x', 'LineWidth', 2, 'Color', 'red');
    end

end

