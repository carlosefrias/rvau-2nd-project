% I = imread('dbimage/estante04.jpg');
% cornerdetection(I);


function output_points = cornerdetection(I)

	I_hsv = rgb2hsv(I);
	MaxsizeI = size(I);
	
%    for x = 1:MaxsizeI(1)
%        for y = 1:MaxsizeI(2)			
%            h = I_hsv(x,y,1);
%			if h > 0.2
%				I_hsv(x,y,1) = 1;
%			end
%        end
%    end

	I_gray = imadjust(rgb2gray(I));
	
	%figure, imshow(I_gray), hold on;

    for x = 1:MaxsizeI(1)
        for y = 1:MaxsizeI(2)			
			if I_gray(x,y) < 50
				I_gray(x,y) = 0;
 			else
				I_gray(x,y) = 255;
			end
       end
    end
	
	C = corner(im2bw(I_gray));
	
	output_points= C;
	figure, imshow(im2bw(I_gray)), hold on;
	
	imwrite(im2bw(I_gray),'Imagens/bwshelf.jpg','jpg');
	
	%figure, imshow(I), hold on;
	plot(C(:,1), C(:,2), 'r*');

end