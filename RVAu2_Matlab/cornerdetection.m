%
% Esta função detecta os contornos da estante e determina os cantos
%
% I = imread('dbimage/estante06.jpg');
% cornerdetection(I, 0.22);

function output_points = cornerdetection(I,threshold)
	
	% Binarização da imagem
	BW = im2bw(I, threshold);
	%figure, imshow(BW), hold on;
	imwrite(BW,'Imagens/bwshelf.jpg','jpg');
	
	% Detecção de contornos
	[B, L] = bwboundaries(~BW);
	B(boundaryMax(B)) = [];
	id = boundaryMax(B);
	contorno = B{id};

%	figure, imshow(BW), hold on,
%	plot(contorno(:, 2), contorno(:, 1), 'Marker', '.', 'Color', 'blue');
%	f = getframe(gca);
%	BW2 = frame2im(f);
%	imwrite(BW2,'Imagens/boundaryshelf.jpg','jpg');

	BWSize = size(BW);
	contSize = size(contorno);
%	I_boundary = zeros(BWSize);
	
%   for i = 1:contSize(1)
%       I_boundary(contorno(i, 1), contorno(i, 2)) = 1;
%   end
    
	d = 0;
	p1(1,1) = contorno(1,1);
	p1(2,1) = contorno(1,2);
	p3(1,1) = contorno(round(contSize(1)/2),1);
	p3(2,1) = contorno(round(contSize(1)/2),2);
	for i = 1:round(contSize(1)/2)
		p(1,1) = contorno(i,1);
		p(2,1) = contorno(i,2);
		d_aux = line_exp_point_dist_2d ( p1, p3, p );
		if d_aux > d
			p2 = p;
			i2 = i;
			d = d_aux;
		end
	end
	p1(1,1) = contorno(round(contSize(1)/2),1);
	p1(2,1) = contorno(round(contSize(1)/2),2);
	p3(1,1) = contorno(contSize(1),1);
	p3(2,1) = contorno(contSize(1),2);
	d = 0;
	for i = round(contSize(1)/2):contSize(1)
		p(1,1) = contorno(i,1);
		p(2,1) = contorno(i,2);
		d_aux = line_exp_point_dist_2d ( p1, p3, p );
		if d_aux > d
			p4 = p;
			i4 = i;
			d = d_aux;
		end
	end
	
	d = 0;
	for i = 1:contSize(1)
		if i < i2 || i > i4
			p(1,1) = contorno(i,1);
			p(2,1) = contorno(i,2);
			d_aux = line_exp_point_dist_2d ( p2, p4, p );
			if d_aux > d
				p1 = p;
				d = d_aux;
			end
		end
	end
	
	d = 0;
	for i = i2:i4
		p(1,1) = contorno(i,1);
		p(2,1) = contorno(i,2);
		d_aux = line_exp_point_dist_2d ( p2, p4, p );
		if d_aux > d
			p3 = p;
			d = d_aux;
		end
	end
	
	output_points = [p1(2,1) p1(1,1); p2(2,1) p2(1,1); p3(2,1) p3(1,1); p4(2,1) p4(1,1)];

    figure, imshow(BW), hold on,
	plot(output_points(:, 1), output_points(:, 2), 'Marker', '.', 'Color', 'red');
	f = getframe(gca);
	BW2 = frame2im(f);
	imwrite(BW2,'Imagens/cornershelf.jpg','jpg');

end