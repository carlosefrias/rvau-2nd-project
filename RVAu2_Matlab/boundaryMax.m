%
% função usada para a obtenção de contornos
%

function index = boundaryMax(B)

	% Procura do contornos maior
	Maximo = 0;
	for i = 1:length(B)
		if length(B{i}) > Maximo
			Maximo = length(B{i});
			index = i;
		end
	end
end