% =========================================================================
% Institution : FEUP - Faculdade de Engenharia de Universidade do Porto
% Class       : Realidade Virtual e Aumentada
% Name        : homograph.m
% Author      : Carlos Frias & Nuno Marques
% Version     : 0.01
% Description : Trabalho 2 - Realidade Aumentada aplicada a uma biblioteca
% =========================================================================

function [image,tform, input_points, base_points] = homograph(source, base)
	% a carregar as imagens
    im1 = imread(source);
    im2 = imread(base);
	%[x,y] = ginput(4);
    %input_points = [x(1) y(1); x(2) y(2); x(3) y(3); x(4) y(4)];
	% a abrir interface para a seleção de pontos de controlo - por agora
    %base_points = [0 0; ...];
    [input_points, base_points] = cpselect(im1,im2, 'Wait', true);
    
    tform = cp2tform(input_points, base_points, 'projective');
    
    image1 = imtransform(im1, tform);
    image = imcrop(image1);
    
    %homog = transf.tdata.T;
    %homog_inv = transf.tdata.Tinv;
end

