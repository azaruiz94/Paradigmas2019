hombre(juan).
hombre(mario).
hombre(luis).
hombre(carlos).
hombre(miguel).
hombre(jorge).
hombre(mario).
hombre(ruben).

mujer(ana).
mujer(maria).
mujer(julia).
mujer(lucia).
mujer(laura).
mujer(perla).
mujer(carmen).

% hijo_de(hijo, hombre, mujer)
hijo_de(juan, jorge, perla). % juan es tio de lucas
hijo_de(luis, jorge, perla). % luis es tio de jose y sandra
hijo_de(jose, juan, ana). % jose es hermano de sandra
hijo_de(sandra, juan, laura). % sandra es hermana de jose
hijo_de(lucas, luis, julia). % lucas es primo de sandra y juan

hijo_de(ruben, mario, maria).
hijo_de(carmen, carlos, lucia). % ruben y carmen pueden casarse

% papa(hombre)
papa(P):-
        hombre(P),
        hijo_de(_, P, _).

% mama(mujer)
mama(M):-
        mujer(M),
        hijo_de(_, _, M).

hermanos(H):-
        hijo_de(H,P,_),
        hijo_de(O, P,_),
        H \= O.

hermanos(X, Y):-
        hijo_de(X,P,_),
        hijo_de(Y,P,_),
        X \= Y.

primos(H):-
  hermanos(X, Y),
  hijo_de(H, X, _),
  hijo_de(O, Y, _).

primos(X,Y):-
  hermanos(J,K),
  hijo_de(X,J,_),
  hijo_de(Y,K,_).

%tios(sobrino)
tios(T):-
    hermanos(T,Y),
  hijo_de(H,Y,_).

% tio(tio, sobrino)
tio(T,S):-
  hermanos(T,Y),
  hijo_de(S,Y,_).

% cunhado(cunhado)
cunhado(C):-
  hermanos(C,X),
  estan_casados(X,Y).

% cunhado(cunhado, mujer)
cunhado(C,M):-
  hermanos(C,X),
  estan_casados(X,M).

% estan_casados(hombre, mujer)
estan_casados(H,M):-
  hombre(H),
  mujer(M),
  hijo_de(X,H,M).

% pueden_casarse(hombre, mujer)
pueden_casarse(H,M):-
  hombre(H),
  mujer(M),
  not(hermanos(H,M)),
  not(primos(H,M)),
  not(tio(H,M)),
  not(estan_casados(H,M)).

% papa(juan)
% mama(maria)
% hermanos(jose)
% hermanos(X)
% % hermanos(juan, luis)
% hermanos(jose, sandra)
% hermanos(jose, X)
% primos(jose)
% primos(jose, X)
% tios(juan)
% tios(X)
% tio(juan, lucas)
% tio(luis, sandra)
% tio(luis, X)
% tio(X, Y)
% cunhado(luis)
% cunhado(X)
% cunhado(juan, julia)
% cunhado(juan, X)
% cunhado(X, Y)
% estan_casados(luis, julia)
% estan_casados(X, Y)
% pueden_casarse(ruben, carmen)
