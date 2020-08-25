% Author: Azarias Ruiz
% Date: 20/11/2019
%0 1 1 2 3 5 8 13
fibonacci(N, R):-
         suma(0, 1, R1),      % R1=0+1=1
         suma(R1, 1, R2),     % R2=1+1=2
         suma(R2, R1, R3),    % R3=2+1=3
         suma(R3, R2, R1),    % R4=3+2=5
         suma(R1, R3, R2),    % R5=5+3=8
         suma(R2, R1, R3),    % R6=8+5=13
         suma(R3, R2, R1),    % R7=13+8=21
         R is R1.

suma(N1, N2, R):-
         R is N1 + N2.


