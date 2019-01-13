function [newlines] = refinamento2(lines, minlength)
%refinamento2 Função que recebe como argumento uma lista de linhas
%detetadas numa imagem e elimina aquelas linhas demasiado pequenas

    newlines = {};
    for i = 1: length(lines) 
        line = lines(i,:);
        comp = abs(line(4)-line(3));
        if(comp >= minlength)
            newlines = cat(1, newlines, line);
        end
    end

end

