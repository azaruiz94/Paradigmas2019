% Author:
% Date: 9/12/2019

% Genealogia

hombre(juan).
hombre(carlos).
hombre(mateo).
hombre(roberto).
hombre(marcos).

mujer(maria).
mujer(juana).
mujer(laura).
mujer(felicia).
mujer(noelia).

hijo_de(maria, juan, jose).
hijo_de(maria, juan, ariel).
               hijo_de(carla, jose, arturo).
                              hijo_de(lily, jose, oscar).
               hijo_de(liz, ariel, marcos).
               hijo_de(graciela, ariel, noelia).
hijo_de(juana, carlos, david).
hijo_de(juana, carlos, marcelo).
hijo_de(laura, mateo, miguel).
hijo_de(felicia, roberto, antonio).

hijo_de(laura, mateo, monica).
hijo_de(felicia, roberto, bety).

% papa(papa, hijo)
papa(P, H):-
        hombre(P),
        hijo_de(_, P, H).

%mama(mama, hijo)
mama(M, H):-
        mujer(M),
        hijo_de(M, _, H).

hermanos(H):-
        hijo_de(_,P,H),
        hijo_de(_, P,O),
        H \= O.

hermanos(H):-
        hijo_de(M,_,H),
        hijo_de(M, _,O),
        H \= O.

hermanos(X, Y):-
        hijo_de(_,P, X),
        hijo_de(_,P,Y),
        X \= Y.

primos(X):-
           hijo_de(_, P, X),
           hijo_de(_, O, R),
           hermanos(P, O),
           R \= X.

primos(X, Y):-
          hijo_de(_, P, X),
          hijo_de(_, O, Y),
          hermanos(P, O),
          X \=Y.

tios(X):-
         hijo_de(_, P, X),
         hermanos(R),
         P = R.

tio(X, Y):-
        hijo_de(_, X, _),
        hijo_de(_, P, Y),
        hermanos(X, P),
        P \= X.

cunhado(X):-
            hijo_de(_, P, _),
            hijo_de(X, R, _),
            hermanos(P, R).

%cunhado(esposa, cunhado)
cunhado(X, Y):-
           cunhado(X),
           hijo_de(X, P, _),
           hijo_de(_, Y, _),
           hermanos(P, Y).

estan_casados(X, Y):-
                 hombre(Y),
                 mujer(X),
                 hijo_de(X, Y, _).

pueden_casarse(X, Y):-
                  hombre(Y),
                  mujer(X),
                  not(primos(X, Y)),
                  not(estan_casados(X, Y)),
                  not(hermanos(X, Y)),
                  not(tio(Y, X)).

abuelo(X):-
          hijo_de(_, P, X),
          hijo_de(_, A, P),
          A \= P.



