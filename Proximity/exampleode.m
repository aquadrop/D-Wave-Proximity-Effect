function dy = exampleode(t,y)
% function to be integrated
dy = zeros(2,1);
dy(1) = y(1) + y(2);
dy(2) = y(1); % Alternatively
% A = [1 1; 1 0];
% dy = A*y