function  M = loaddbfiles(filePath)
%loaddbfiles função que serve para carregar para uma matriz os nomes dos
%livros/estantes a sua localização e as suas dimensões reais
% a abrir o ficheiro de texto
    fid = fopen(filePath);
    % le o ficheiro todo
    S = textscan(fid,'%s','Delimiter','\n');
    maxsize = size(S{1}(:,:));
    % dividir por linhas e efetuar o split e guardar os valores numa matriz
    M = {};
    for i = 1:maxsize(1)
        line = regexp (cell2mat(S{1}(i,1)), ';', 'split');
        M = cat(1,M,line);
    end
    % a fechar o ficheiro
    fclose(fid);
end