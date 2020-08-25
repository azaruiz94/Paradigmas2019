% Author: Azarias Ruiz
% Date: 13/11/2019

% 1. Definir el predicado maxlist(List,Max) tal que Max es el mayor número de la lista List.
% maxlist([1,4,8,0,2], Max).
% Max = 8 ;
maxlist([X | []], X):-!.
maxlist( [X | Xs], Max):-
            maxlist(Xs, R1),
            X > R1,
            Max is X,
            !.
maxlist( [X | Xs], Max):-
            maxlist(Xs, R1),
            R1 > X,
            Max is R1,
            !.
            
% 2. Suma los elementos respectivos de dos listas, generando otra con los resultados. Ambas
% listas deben tener el mismo tamaño.
% sumaListas([1,7,4],[9,3,6],L).
% L=[10,10,10]
sumaListas([], [], []).
sumaListas([X | Xs], [Y | Ys], L):-
            Temp is X+Y,
            sumaListas(Xs, Ys, Aux),
            L= [Temp | Aux].
            
% 3. Inserción ordenada de un elemento en una lista ordenada
% insertar(3,[1,4,5,7],L).
% L=[1,3,4,5,7]
insertar(_, [], []):-!.
insertar(N, [X | Xs], L):-
            N < X,
            L= [N | [X | Xs]].
            
insertar(N, [X | Xs], L):-
            N > X,
            insertar(N, Xs, Aux),
            L= [X | Aux].

% 4. Defina en Prolog un predicado split que permite dividir una lista en dos partes, donde se especifica el
% largo de la primera parte.
% split([a,b,c,d,e,f,g,h,i,k], 3, L1, L2).
% L1 = [a,b,c]
% L2 = [d,e,f,g,h,i,k]
split([], _, [], []).
split([X |Xs], N, L1, L2):-
         N =:= 1,
         split(Xs, N-1, L1, L2),
         L1= [X | []],
         !.
         
split([X |Xs], N, L1, L2):-
         N > 0,
         split(Xs, N-1, Aux1, L2),
         L1= [X | Aux1],
         !.
         
split([X |Xs], N, _, L2):-
         N =:= 0,
         L2= [X | Xs].
         
% 5. Borra todas las ocurrencias de un elemento.
% borra([1, 2, 1, 3, 1], 1, Y).
% Y=[2,3]
borra([], _, []).
borra([X | Xs], N, Y):-
         X =\= N,
         borra(Xs, N, R1),
         Y = [X | R1].
borra([X | Xs], N, Y):-
         X =:= N,
         borra(Xs, N, Y).

% 6. Considerando que las listas son de un solo nivel y contienen solo números, resuelva
% ProductoPunto(L1,L2, N). (L1 y L2 son listas de números y tienen la misma cantidad de elementos).
% El producto punto de [a, b, c] y [d,e,f] es a*d+b*e+c*f
% productoPunto([1,2,3,4], [2,4,6,8], N).
% N = 60
productoPunto([], [], 0).
productoPunto([X | Xs], [Y | Ys], N):-
                 M is X*Y,
                 productoPunto(Xs, Ys, R),
                 N is M + R.
                 
% 7. Defina la regla multiplicar-lista que multiplica los elementos de 2 lista y retorna los resultados en forma de listas.
% multiplicar-lista([2,3,4],[2,5],R).
% R = [4, 15]
% multiplicar-lista([2,3],[2,5,4],R).
% R = [4, 15]
multiplicar-lista([_ | _], [], []).
multiplicar-lista([], [_ | _], []).
multiplicar-lista([X | Xs], [Y | Ys], R):-
                     M is X * Y,
                     multiplicar-lista(Xs, Ys, Res),
                     R = [M | Res].

% 8. Escribir una regla en Prolog llamada sublista(L, I, F, R) que dado una lista L y dos números I y F,
% verifica que R sea la sublista desde I-esimo elemento de L hasta F (inclusive). Ejemplo:
% sublista([a,b,c,d,e,f,g], 2, 5, [c,d,e,f]).
% yes
sublista([_ | _], _, _, []).

sublista([_ | Xs], I, F, [Y | Ys]):-
            I > 0,
            sublista(Xs, I-1, F, [Y | Ys]).
            
sublista([X | Xs], I, F, [Y | Ys]):-
            I =:= 0,
            X = Y,
            sublista(Xs, I, F, Ys ).
            
% 9. Escribir una regla que devuelve el enesimo elemento
% enesimoElem([1,4,3,2,5],2,X).
% X=4
enesimoElem([X | _], I, E):-
               I =:= 1,
               E is X.
enesimoElem([_ | Xs], I, E):-
               I > 1,
               enesimoElem(Xs, I-1, E).

% 10. Escribir una regla que elimina el elemento X de la lista en el 1º nivel
% eliminaX([1,2,3,4,5],3,L).
% L=[1,2,4,5]
% eliminaX([1,2,[3,4],5,3],3,L).
% L=[1,2,[3,4],5]
eliminaX([], _, []).
eliminaX([X | Xs], N, L):-
           is_list(X),
           eliminaX(Xs, N, Aux),
           L= [X | Aux],
           !.
            
eliminaX([X | Xs], N, L):-
           X =:= N ,
           eliminaX(Xs, N, L).
           
eliminaX([X | Xs], N, L):-
           X =\= N ,
           eliminaX(Xs, N, Aux),
           L= [X | Aux].
           
% 11. Escribir una regla que arme una lista con todos los elementos menores que X
% xMenores(3,[2,3,1,7,0],L).
% L=[2,1,0]
xMenores(_, [], []).
xMenores(N, [X | Xs], L):-
            X < N,
            xMenores(N, Xs, Aux),
            L= [X | Aux].
            
xMenores(N, [X | Xs], L):-
            X >= N,
            xMenores(N, Xs, L).
            
% 12. Determina si una lista es estrictamente creciente
% crece([1,2,3]).
% Yes
% crece([2,2,3]).
% No
crece([]).
crece([_ | []]).
crece([X | Xs]):-
         creceAux(Xs, Sig),
         X < Sig,
         crece(Xs).
         
creceAux([X | _], S):-
            S is X.

         