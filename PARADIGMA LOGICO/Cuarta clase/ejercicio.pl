% Agregar un par de jugadores de basket, que se conoce en qué ligas jugó y su edad
% un jugador de basket se considera que es una buena práctica si jugó en al menos dos ligas 
% o si jugó en la nba (y si también es buena si juega en la euroliga?)
% o si tiene más de 40 años
    % Agregar a manu que juega al basket, jugó en argentina, euroliga, nba 
    % la edad actual que tiene (45)

practica(manu,basket([argentina,euroliga,nba],40)).  %El modelo no siempre tiene sentido en la realidad, en este caso nos sirve que la edad este en la practica, ya que es un criterio para saber si es BuenaPractica
practica(juan,natacion(0,0,40)).  
practica(juan,natacion(1,1,40)).  

% Agregar a mario que juega al basket, jugo solo en argentina, tiene 33 años
practica(mario, basket([argentina], 33)).

buenDeportista(Deportista):-
                            practica(Deportista,Practica),
                            buenaPractica(Practica).

%Si tiene forma de functor basket ... PM
buenaPractica(basket(Ligas,_)):-    
                                length(Ligas, Cantidad),
                                Cantidad >= 2.
                            
buenaPractica(basket(Ligas,_)):-    
                                member(nba, Ligas).

buenaPractica(basket(_,Edad)):-    
                               Edad>40.
                              
%Quienes son nadadores?

nadador(Deportista):-
                    practica(Deportista,natacion(_,_,_)).  

%Cuantos nadadores hay? --> nadador(Quien) liga a todos los nadadores, no es lo que pide
%Necesito agrupar a los nadadores en una lista y ahi hacer un length

cuantosNadadores(Cantidad):-
                            findall(Nadador,%elemento a agrupar en la lista
                                    nadador(Nadador), %consulta generadora de nadadores ligando Nadador. Son los nombres que hacen cierto natacion(_,_,_)
                                    Nadadores %lista resultante, de que?
                                    ),
                            length(Nadadores, Cantidad).
            

/* Jugando al TEG*/

ocupa(argentina, magenta, 5).
ocupa(chile, negro, 3).
ocupa(brasil, amarillo, 8).
ocupa(uruguay, magenta, 5).
ocupa(alaska, amarillo, 7).
ocupa(yukon, amarillo, 1).
ocupa(canada, amarillo, 10).
ocupa(oregon, amarillo, 5).
ocupa(kamtchatka, negro, 5).
ocupa(china, amarillo, 2).
ocupa(siberia, amarillo, 5).
ocupa(japon, amarillo, 7).
ocupa(australia, negro, 8).
ocupa(sumatra, negro, 3).
ocupa(java, negro, 4).
ocupa(borneo, negro, 1).

%Cuantos paises ocupa un jugador? (cantidad --> hacer length). Si la lista no esta armada findall 

ocupados(Jugador,Cantidad) :-
                            ocupa(_,Jugador,_), %genero los jugadores porque no eran inversibles ocupados(Jugador,Cantidad) jugador. ocupa es inversible para jugador
                            findall(
                                Pais,
                                ocupa(Pais,Jugador,_), %Si da FALSE, retorna una lista vacia NO un false
                                Paises
                                ),
                                length(Paises,Cantidad).

%ocupados(Jugador,Cantidad) --> Cantidad = 16.  Cuando jugador esta ligado te dice bien cuales son los paises, pero cuando no esta ligado es como que Jugador = _
%Entonces ocupa(Pais,_,_) liga a todos los paises. Todo lo que no sea el primer argumento que NO este ligado es _.
%Problema de inversibilidad, cuando Jugador esta ligado funciona, pero como incognita no
%Findeall tambien trae problemas de inversivilidad 
%Pais debe estar sin ligar (SIEMPRE SI LIGAR)

%  findall(Pais, ocupa(Pais,martin,_), Paises) --> Paises = []
%  findall(Pais, ocupa(Pais,martin,_), [chile]) --> false, ya que deberia ser la lista vacia 

%  findall(1, ocupa(Pais,magenta,_), Paises) --> Paises = [1,1].  Por cada vez que hay un pais, agrega un 1 en la lista de paises, por eso tiene que ser Pais el primer arguemnto

%Cuales son los paises que ocupa un color?

cualesOcupa(Color,Paises):- ocupa(Paises, Color,_). %no hace falta listas ni findall (solo para contar CUANTOS o sumar). Como las consultas existenciales devuelven varios valores

% ¿Cuántos países están cargados? Un país está cargado cuando tiene más de 7 fichas.

%caracteristica del pais
cargado(Pais):-
                ocupa(Pais,_,Fichas),
                Fichas > 7.

paisesCargados(Numero):-
                        findall(
                            Pais,
                            cargado(Pais),
                            Paises
                            ),
                        length(Paises,Numero).


%Que jugadores ocupan paises con mas de 5 fichas

jugadoreFicheros(Jugador):-     
                            ocupa(_,Jugador, Fichas),   
                            Fichas >5.
%findall tiene sentido en logico  --> Para contar y para sumar

%Cuantas fichas tiene cada jugador (armar la lista para SUMAR)

jugador(Jugador) :- ocupa(_,Jugador,_).
fichasTotales(Jugador, Resultado):-
                        jugador(Jugador),
                        findall(
                            Ficha,
                            ocupa(_,Jugador,Ficha),
                            Fichas
                            ),
                        sumlist(Fichas, Resultado).

%Esta armado un jugador cuando tiene 2 paises o mas con al menos 5 fichas


masDeDos(Paises):-
                  length(Paises,Numero),
                  Numero >= 2.
armado(Jugador):-
                jugador(Jugador),
                findall(
                    Pais,
                    (ocupa(Pais,Jugador,Fichas), Fichas>= 5),
                    Paises
                    ),
                    masDeDos(Paises).
                       
%Resolucion con consultas existenciales (al menos 2 o 3, mas es mejor la otra forma)
estaArmado2(Jugador):-
                    ocupaConMuchasFichas(Pais, Jugador),
                    ocupaConMuchasFichas(OtroPais, Jugador),
                    Pais \= OtroPais.
                    
ocupaConMuchasFichas(Pais, Jugador):-
                                   ocupa(Pais, Jugador, Fichas),
                                   Fichas >= 6.