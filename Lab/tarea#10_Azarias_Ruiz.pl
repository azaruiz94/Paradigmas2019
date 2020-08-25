% Author: Azarias Ruiz
% Date: 12/11/2019

% Escribir la regla ultimo(Lista, R).
% ultimo([1,2,3,4,5], R).
ultimo([], []):-!.
ultimo([], R):-!.
ultimo([X|[]], R):-
               R is X,
               !.
ultimo([X|Xs], R):-
               ultimo(Xs, R).
               
% Escribir la regla generar_lista(tamano,Valor,Resultado)
% generar_lista(5, a, [a,a,a,a,a])
generar_lista(0, V, []):- !.
generar_lista(T, V, R):-
                 X1 is T-1,
                 generar_lista(X1, V, Temp),
                 R = [V | Temp].

% Suma los elementos de una lista
% suma([1,2,3,4,5], R).
suma([], 0):-!.
suma([X|Xs], R):-
               suma(Xs, R1),
               R is R1+X.
               
% Intercalar los elementos de 2 listas
% intercalar([1,2,3], [4,5,6], R).
intercalar([], L2, L2):-!.
intercalar(L1, [], L1):-!.
intercalar([X1|Y1], [X2|Y2], R):-
                    intercalar(Y1, Y2, R1),
                    R = [X1, X2 | R1].

lessThan(_, [], []).
lessTan(N, [X | Xs], L):-
           X >= N,
           lessThan(N, Xs, L).
lessThan(N, [X | Xs], L):-
            X < N,
            lessThan(N, Xs, Aux),
            L= [X | Aux].
