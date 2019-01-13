
%   I = imread('Imagens/livros.png');
%   Template = imread('Imagens/livro1.png');
%   figure, imshow(backprojection(I, Template)), hold on;

function  Histogram = backprojection(I, Template)
    Template_hsv = rgb2hsv(Template);
    %Template_hsv = rgb2hsv(imadjust(Template, [0 0.8], [0.3 1]));
    MaxsizeTemplate = size(Template);
    HistogramTemplate = zeros(256,256);
	%HistogramTemplateH = zeros(256,1);

    I_hsv = rgb2hsv(I);
    MaxsizeI = size(I);
    Histogram = zeros(MaxsizeI(1),MaxsizeI(2));
    
	% Faz a contagem da cor e saturacao do template para uma matriz
    for x = 1:MaxsizeTemplate(1)
        for y = 1:MaxsizeTemplate(2)
            h = uint8(Template_hsv(x,y,1)*255) + 1;
            s = uint8(Template_hsv(x,y,2)*255) + 1;
            HistogramTemplate(h,s) = HistogramTemplate(h,s) + 1;
			%HistogramTemplateH(h,1) = HistogramTemplateH(h,1) + 1;
        end
    end
	
    minimo = min(reshape(HistogramTemplate, 1, []));
    maximo = max(reshape(HistogramTemplate, 1, []));
	range = maximo - minimo;

    %maximoH = max(reshape(HistogramTemplateH, 1, []));
	
    % normalizar o histogramTemplate [0 to 255]
    for h = 1:255
        for s = 1:255
			%HistogramTemplate(h,s) = HistogramTemplate(h,s) - minimo;
            HistogramTemplate(h,s) = HistogramTemplate(h,s) * 255 / range;
        end
        %HistogramTemplateH(h,1) = HistogramTemplateH(h,1)*255/maximoH;
    end
    
	% cria uma matriz de mach colors com niveis de cinzento
    for x = 1:MaxsizeI(1)
        for y = 1:MaxsizeI(2)
            h = uint8(I_hsv(x,y,1)*255) + 1;
            s = uint8(I_hsv(x,y,2)*255) + 1;
% 			if HistogramTemplate(h,s) > 128
				Histogram(x,y) = uint8(HistogramTemplate(h,s));
				%Histogram(x,y) = uint8(HistogramTemplateH(h,1));
%			else
% 				Histogram(x,y) = 0;
% 			end
        end
    end
	
	imwrite(Histogram,'Imagens/histogram.jpg','jpg');
	
	%figure, imshow(Histogram), hold on;

end