% Author:
% Date: 9/12/2019
ultimo([], []).
ultimo([X | []], X):- !.
ultimo([_ | Xs], R):-
          ultimo(Xs, R).

generar_lista(0, _, []):-!.
generar_lista(T, V, R):-
                 Aux is T-1,
                 generar_lista(Aux, V, Temp),
                 R = [V | Temp].

sumar_elementos([], 0):-!.
sumar_elementos([X | Xs], R):-
                   sumar_elementos(Xs, Temp),
                   R is X + Temp.
                   
intercalar([], [], []):-!.
intercalar([X | Xs], [Y | Ys], R):-
              intercalar(Xs, Ys, Temp),
              R = [X|[Y | Temp]].

invertir([], []):-!.
invertir([X | Xs], R):-
            invertir(Xs, Temp),
            R= [Temp | X].
            
enesimo_elem([X | _], P, V):-
                   P =:= 1,
                   V is X.
enesimo_elem([_ | Xs], P, V):-
                P > 1,
                enesimo_elem(Xs, P-1, V).
                
lista_cuadrados([], []):-!.
lista_cuadrados([X | Xs], L):-
                   Aux is X *X,
                   lista_cuadrados(Xs, Temp),
                   L= [Aux | Temp].
                   
suma_cuadrados([], 0):-!.
suma_cuadrados([X | Xs], R):-
                  Aux is X*X,
                  suma_cuadrados(Xs, Temp),
                  R is Aux + Temp.

pares([], []):-!.
pares([X | Xs], L):-
         not(X mod 2 =:= 0),
         pares(Xs, L).
         
pares([X | Xs], L):-
         X mod 2 =:= 0,
         pares(Xs, Temp),
         L= [X | Temp].

miembro([], []):- !.
miembro([X | _], R):-
           R =  X,
           !.
miembro([_ | Xs], R):-
           miembro(Xs, R).

longitud([], 0).
longitud([_ | Xs], R):-
             longitud(Xs, Temp),
             R is Temp +  1.
             
factorial(0, 1):-
             read(X),
             write(X).
factorial(N, R):-
             Aux is N-1,
             factorial(Aux, Temp),
             R is N * Temp.


