function [ lines ] = selectVerticalLines( lines, toleranceDegrees)
%selectVerticalLines Fun��o seleciona apenas as linhas vertivais de uma lista
%de linhas
    % a eliminar as linhas n�o verticais
    k = 1;
    while k <= length(lines)
        % flag's para assinalar se uma reta � verical/horizontal ou obliqua
        horizontal = 0;
        vertical = 0;
        
        if(abs(abs(lines(k).theta) - 90) < toleranceDegrees) 
           % horizontal = 1;
        elseif(abs(lines(k).theta) < toleranceDegrees)
            vertical = 1;
        end;
        if(horizontal == 0 && vertical == 0) 
            lines(k) = []; % remove a linha que n�o � horizontal nem vertical
            k = k - 1;
        end
        k = k + 1;
    end
end

