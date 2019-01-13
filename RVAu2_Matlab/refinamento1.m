function [ linhasVerticais ] = refinamento1( linhas )
%refinamento1: recebe a lista de linhas verticais e une as que t�m a mesma
%abcissa, ou abcissa muito pr�xima

    % a definir o fator de proximidade
    proxFactor = 2;
    xActual = 0;
    linhasVerticais = {};
    % percorrer as linhas por ordem crescente de abcissa
    for i = 1: length(linhas);
        linha = linhas(i,:);
        xAnterior = xActual;
        xActual = linha(1);
        abcissaProx = abs(xActual - xAnterior) < proxFactor ;
        % se as abcissas estiverem muito pr�ximas, ent�o unir com linha anterior
        if abcissaProx 
            ymin = linha(3);
            ymax = linha(4);
            % percorrer a linha e as seguintes
            for j = i - 1: length(linhas)
                linha2 = linhas(j,:);
                abcissaProx = abs(xActual - linha2(1)) < proxFactor;
                % se tiver uma abcissa pr�xima
                if abcissaProx
                    % ent�o unir
                    ymin = min(ymin, linha2(3));
                    ymax = max(ymax, linha2(4));
                elseif (~abcissaProx || j == length(linhas))
                    i = j; %#ok<FXSET>
                    % sen�o, guardar a linha atual
                    line = [xActual xActual ymin ymax];
                    linhasVerticais = cat(1, linhasVerticais, line);
                    % sair do ciclo
                    break;
                end
            end
        % se as abcissas n�o estiverem muito pr�ximas
        else
            line = [linha(1) linha(2) linha(3) linha(4)];
            % ent�o guardamos a linha
            linhasVerticais = cat(1, linhasVerticais, line);
        end
    end
end

