function [ verticalLines ] = orderingVerticalLines( lines )
%selectVerticalLines Função ordena por ordem crescente de abcissa a lista
%de linhas verticais

    % copiar a lista de linhas verticais para outra lista
    lines1 = lines;
    % variável que guarda a lista de linhas verticais ordenada por ordem crescente de abcissa
	verticalLines = {};
    minimo = bitmax;
    indice = 1;
    % enquanto a lista não está vazia
    while ~isempty(lines1)
        % procurar o valor de x mínimo e guardar o seu índice
        for k = 1: length(lines1)
            line = [lines1(k).point1; lines(k).point2];
            xMIN = line(1,1);
            if xMIN <= minimo
                minimo = xMIN;
                indice = k;
            end
        end
        minimo = bitmax;
        % a adquirir os pontos da linha com abcissa mínima
        line = [lines1(indice).point1; lines1(indice).point2];
        x = min([line(1,1) line(2,1)]);
        yMIN = min([line(1,2) line(2,2)]);
        yMAX = max([line(1,2) line(2,2)]);
        % a guardar as coordenadas x e y mínimo e máximo
        linha = [x x yMIN yMAX];
        verticalLines = cat(1,verticalLines, linha);
        % a eliminar a linha da lista de linhas
        lines1(indice) = [];
    end

end

