function  drawLines(lines, Image)
% drawLines desenhas as linhas recebidas na imagem

    figure, imshow(Image), hold on

    maxsize = size(lines);
    for k = 1:maxsize(1)
        line = lines(k,:);
        point1 = [line(1) line(3)];
        point2 = [line(2) line(4)];
        
        plot([point1(1),point2(1)],[point1(2),point2(2)],'Color','green','LineWidth',2)
    end
end

