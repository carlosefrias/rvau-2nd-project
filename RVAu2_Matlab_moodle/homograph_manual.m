% =========================================================================
% Institution : FEUP - Faculdade de Engenharia de Universidade do Porto
% Class       : Realidade Virtual e Aumentada
% Name        : homograph.m
% Author      : Carlos Frias & Nuno Marques
% Version     : 0.01
% Description : Trabalho 2 - Realidade Aumentada aplicada a uma biblioteca
% =========================================================================

function [image, tform] = homograph_manual(source, shelfwidth, shelfHeigth)
% homograph_manual Fun��o que realiza a homografia de uma imagem da estante
% para a sua posi��o frontal selecionando manualmente quatro pontos de controlo
    
    im1 = imread(source);
	figure, imshow(im1)
	[x,y] = ginput(4);
    input_points = [x(1) y(1); x(2) y(2); x(3) y(3); x(4) y(4)];
    
	[im1Heigth, im1Width] = size(im1);
	auxh = im1Heigth / shelfHeigth;
	auxw = im1Width / shelfwidth;
	
	if auxh > auxw
		fatorEscala = auxw;
	else
		fatorEscala = auxh;
	end
	disp(fatorEscala);
	
	
	%trans_prj = cp2tform(input_points, base_points, 'projective');
	%parteleira_cortada = imtransform(parteleira,trans_prj,'Xdata',[1 500],'YData',[1 500],'XYscale',1);
	
	% a abrir interface para a sele��o de pontos de controlo - por agora
    base_points = [0 0; fatorEscala * shelfwidth 0; fatorEscala * shelfwidth fatorEscala * shelfHeigth; 0 fatorEscala * shelfHeigth];
    tform = cp2tform(input_points, base_points, 'projective');
    
    image = imtransform(im1, tform);
	
	imwrite(image,'Imagens/homografia.jpg','jpg');
% I2 = imcrop(I, rect) 
% crops the image I. rect is a four-element position vector[xmin ymin width height] 
% that specifies the size and position of the crop rectangle.
    
      image = imcrop(image);
%     disp([round(x(1)) round(x(2)) round(abs(x(2)-x(1))) round(abs(y(4)-y(1)))]);
%     image = imcrop(image,[round(x(1)) round(x(2)) round(abs(x(2)-x(1))) round(abs(y(4)-y(1)))]);
end

