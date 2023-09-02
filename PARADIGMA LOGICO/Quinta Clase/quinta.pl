/*Prolog permite definir predicados recursivos, que deben tener
un caso base o corte de la recursividad
al menos un caso recursivo, donde el predicado esté definido en términos de sí mismo.
*/


progenitorDe(homero, bart).
progenitorDe(homero, maggie).
progenitorDe(homero, lisa).
progenitorDe(marge, bart).
progenitorDe(marge, maggie).
progenitorDe(marge, lisa).

progenitorDe(abraham, homero).
progenitorDe(abraham, herbert).
progenitorDe(mona, homero).

progenitorDe(clancy, marge).
progenitorDe(clancy, patty).
progenitorDe(clancy, selma).

progenitorDe(jeryl, mona).

progenitorDe(jacqueline, marge).
progenitorDe(jacqueline, patty).
progenitorDe(jacqueline, selma).

progenitorDe(selma, ling).

% ancestro?

ancestro(Heredero,Ancestro):- progenitorDe(Ancestro,Heredero).  % los ancestros son mis progenitores directos
ancestro(Heredero,Ancestro):-progenitorDe(Progenitor,Heredero), ancestro(Progenitor,Ancestro). % o son los ancestros de mis progenitores directos

%ancestro(Heredero,Abuelo):- progenitorDe(Progenitor,Heredero), progenitorDe(Abuelo,Progenitor) es insostenible

% DISTANCIAS
distancia(buenosAires, puertoMadryn, 1300).
distancia(puertoMadryn, puertoDeseado, 732).
distancia(puertoDeseado, rioGallegos, 736).
distancia(puertoDeseado, calafate, 979).
distancia(rioGallegos, calafate, 304).
distancia(calafate, chalten, 213).
distancia(buenosAires, tigre, 25.9).
distancia(tigre, puertoDeseado, 2040).
distancia(buenosAires, tokio, 9999).

camino(Origen,Destino,Distancia):-distancia(Origen,Destino,Distancia).  %camino directo: camino()
camino(Origen,Destino,Distancia):-   %camino por intermediario
        distancia(Origen,Intermedio,DistanciaIntermedia),
        camino(Intermedio,Destino,DistanciaHastaDestino), 
        Distancia is DistanciaIntermedia + DistanciaHastaDestino.


/*camino(Origen,Destino,Distancia):-
        distancia(Origen,Intermedio,DistanciaIntermedia),
        distancia(Intermedio,Destino,DistanciaHastaDestino) %no que sea un camino directo, si no que haya un camino
*/

distanciaMinima(Origen,Destino,DistanciaMinima):-
            camino(Origen,Destino,DistanciaMinima),  %genero un camino
            forall( 
                    camino(Origen,Destino,Distancia), % que tiene que ser mas corto que todos los demas
                    DistanciaMinima =< Distancia
                   ).
/*distanciaMinima(Origen,Destino,DistanciaMinima):-
            camino(Origen,Destino,DistanciaMinima),
            forall( 
                    camino(Origen,Destino,Distancia), Distancia \=DistanciaMinima    no es lo mejor ya que puede haber 2 caminos con la misma distancia
                    DistanciaMinima < Distancia
                   ).*/


%(((((((((((((((((((((((((((((())))))))))))))))))))))))))))))
%PM en listas : Patron C-COLA , y Patron LIsta Vacia

heade(X, [X|_]).
heade(X, [_|X]).

%Cuando tiene forma de lista vacia
vacia([]).

head([X|_],X).
tail([_|X],X).

longitud([],0).
longitud([_|Cola],Longitud):- longitud(Cola,LongitudCola), Longitud is 1 + LongitudCola.

