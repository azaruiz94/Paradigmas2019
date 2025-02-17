%Ejercicio1
sintoma_de(fiebre, gripe).
sintoma_de(tos, gripe).
sintoma_de(cansancio, anemia).

tiene_sintoma(henry, tos).
tiene_sintoma(erika, cansancio).

elimina(vitaminas, cansancio).
elimina(aspirinas, fiebre).
elimina(jarabe, tos).

alivia(X,Y):-
             elimina(X,A),
             sintoma_de(A,Y).

% a) Obtener un listado de los posibles remedios que alivian un sintoma.
% alivia(X, gripe).
% alivia(X, anemia).
% b) Defina las reglas para poder determinar las enfermedades de las personas
tiene(P, S, E):-
             tiene_sintoma(P, S),
             sintoma_de(S, E).
% c) Escriba una regla recetar_a(X,Y), que emite recetas.
recetar_a(P, R):-
             tiene_sintoma(P, S),
             elimina(R, S).
             
% Ejercicio2
libro(harrypotter, fantasia).
libro(machete, accion).
libro(wason, drama).

autor(jkrowling, harrypotter).
autor(reynolds, machete).
autor(cooper, wason).

alumno(juan).
alumno(roberto).
alumno(carlos).

presto_libro(juan, harrypotter).
presto_libro(roberto, machete).

devuelto_libro(harrypotter).

disponible(L):-
               not(presto_libro(_, L)).

disponible(L):-
               presto_libro(_, L),
               devuelto_libro(L).

disponible_genero(G):-
               libro(L, G),
               disponible(L).
               
% Ejercicio4
es_programador(juan).
es_programador(roberto).
es_programador(carlos).
es_programador(marcos).

estudia_universidad(roberto, uni).
estudia_universidad(carlos, unae).
estudia_universidad(marcos, utic).

programa_en(juan, java).
programa_en(roberto, c).
programa_en(carlos, pascal).
programa_en(marcos, java).

senior_en(juan, java).

puede_contratar(P, L):-
                    es_programador(P),
                    programa_en(P, L),
                    senior_en(P, L).
                       
puede_contratar(P, L):-
                    es_programador(P),
                    programa_en(P, L),
                    estudia_universidad(P, _).
                    
% a) obtener los programadores en java.
% programa_en(X, java).
% b) los programadores senior en java.
% senior_en(X, java).
% c) los estudiantes que programan en java.
estudiante_programador(E, L):-
                    es_programador(E),
                    estudia_universidad(E, _),
                    programa_en(E, L),
                    not(senior_en(E, L)).
% estudiante_programador(X, java).
% d) los que se puede_contratar(java)
% puede_contratar(X, java).


