%   input: input_points-polygon points, I-image
%   output: I_new-new image

%   Usage example:
%	input_points = [46.0000 30.0000; 47.0000 180.0000; 74.0000 179.0000; 73.0000 30.0000];
%   I = imread('Imagens/livros.jpg');
%   selection(I, input_points);

%function I_new = selection
function I_new = selection(I, input_points)
%Função selection que salienta um pequeno quadrilátero no interior da
%imagem sabendo as coordendas dos seus vértices, clareia essa região,
%desenha os lados do quadrilátero, escreve a palavra DETECTED na imagem e
%deve-a

 	I_aux = imadjust(I, [0 0.8], [0.3 1]);
	c = input_points(:,1);
	r = input_points(:,2);
    I_mask = roipoly(I, c, r);
    I_new = I;
	
	xmin = min(input_points(:,1));
	ymin = min(input_points(:,2));
 	xmax = max(input_points(:,1));
	ymax = max(input_points(:,2));

	maxsize = size(I);
    for x = ymin:ymax
        for y = xmin:xmax
            for z = 1:maxsize(3)
                if I_mask(x,y) == 1
                    I_new(x,y,z)=I_aux(x,y,z);
                end
            end
        end
    end
    
	htxtins = vision.TextInserter('DETECTED');
	htxtins.Color = [0, 255, 0]; % [red, green, blue]
	htxtins.FontSize = 75;
	htxtins.Location = [ymin - htxtins.FontSize xmin - htxtins.FontSize]; % [x y]
	I_new = step(htxtins, I_new);

	input_points_aux = cat(1, input_points(2:4,:), input_points(1,:));
	lines = cat(2, input_points(:,1), input_points_aux(:,1), input_points(:,2), input_points_aux(:,2));	
	drawLines(lines,I_new);
	
	f = getframe(gca);
	I_new = frame2im(f);
	imwrite(I_new,'Imagens/bookdetected.jpg','jpg');
	
end
