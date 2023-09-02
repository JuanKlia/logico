/*Conocemos a todos los usuarios de la plataforma, de ellos conocemos su nickname, la cantidad de suscriptores y los contenidos que subió, hay tres tipos de contenido:
Videos: el título, la duración (en segundos) y la cantidad de views (en miles) y likes (estos valores se mantienen constantes ya que la base es de consulta).
Shorts, de ellos sabemos la duración (en segundos), la cantidad de likes y qué filtros tiene.
Streams, no hay información relevante de este tipo.
*/

usuario(markitocuchillos , 45000,[ video("Gatito toca el piano", 45, 50, 1000), video("Gatito toca el piano 2", 65, 2, 2) ]).
usuario(sebaElDolar  , 5000,[ video("300 ¿es el dólar o Esparta", 60000, 2000, 1040500), stream]).
usuario(tiqtoqera,40000,[  short(15,800000, [goldenHauer, cirugiaEstetica]) , short(20,0,[]) , stream ]).
usuario(user99018,1,[]).

%(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((())))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
%Saber cuáles usuarios son mytubers. Se considera mytuber a un usuario que subió al menos un contenido (de cualquier tipo).*/
contenidoVacio([]).
contenido(Usuario,Contenido):-usuario(Usuario,_, Contenido).

myTuber(Usuario):- 
    contenido(Usuario,Contenido), 
    not(contenidoVacio(Contenido)).

/*myTuber(Usuario):- 
        contenido(Usuario,Contenido), 
        length(Contenido, NumeroContenido),
        NumeroContenido> 0.
        */

%(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((())))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
%Se desea saber quién es un milenial. Se cumple cuando el mytuber subió un video que tiene exactamente 1.000 likes o 1 millón de views (1.000 miles)

milenial(Usuario):- contenido(Usuario,Contenido), member(video(_,_,_,1000), Contenido).
milenial(Usuario):- contenido(Usuario,Contenido), member(video(_,1000,_,_), Contenido).

%(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((())))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
%También queremos saber si un usuario nunca subió un video. Modelar como crea conveniente.

sinVideos(Usuario):- contenido(Usuario,Contenido), not(member(video(_,_,_,_), Contenido)).


%(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((())))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
/*

Nos piden poder calcular el nivel de engagement que tiene un mytuber. Esto es la sumatoria del engagement del total de sus contenidos:
Videos: es la cantidad de likes que tiene más 1 cada 1.000 views ej: para el primer video de markitocuchillos es 1050 (1000 likes + 50 por views).
Shorts: es la cantidad de likes que tiene.
Streams: se considera siempre 2000.

*/

engagement(MyTuber, TotalEngagement):- 
        contenido(MyTuber,Contenidos),
        findall(
                  NivelEngagement,
                  (member(Contenido,Contenidos), nivel(Contenido,NivelEngagement)),
                  Niveles

               ),
        sum_list(Niveles, TotalEngagement).
        
nivel(video(_,_,Views,Likes), NivelEngagement):-  NivelEngagement is Likes + Views.  %Las views ya estan en miles, no hace falta el operador //
nivel(short(_,Likes,_), Likes).
nivel(stream, 2000).



%(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((())))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

/*
En MyTube eligen los mytubers mejor puntuados. Por cada objetivo cumplido se da una cantidad de puntos.

2 puntos por cada short con filtro (¡están de moda!).
1 punto por cada contenido con más de 10.000 puntos de engagement. 
2 puntos por cada video largo, es decir, una duración de más de 6.000 segundos.

1 punto si subió al menos 2 contenidos.

Finalmente, 10 puntos, si el total de engagement es mayor a un millón.

Modelar un predicado que relacione a un mytuber con su puntaje.
*/

%usuario(markitocuchillos , 45000,[ video("Gatito toca el piano", 45, 50, 1000), video("Gatito toca el piano 2", 65, 2, 2) ]).



puntaje(MyTuber,Puntaje):-
     contenido(MyTuber,Contenidos),
     puntosPorContenido(Contenidos, PuntosPorContenido),
     puntoPorCantidadContenido(Contenidos, PuntosPorCantidadContenido),
     puntoPorTotalEngagement(MyTuber, PuntoPorTotalEngagement),
     Puntaje is PuntosPorContenido + PuntosPorCantidadContenido + PuntoPorTotalEngagement.


puntosPorContenido(Contenidos,PuntosPorContenido):-
        
          findall(
           
              Punto,
              (member(Contenido, Contenidos), puntajeDelContenido(Contenido,Punto)),
              Puntos

           ),
           sum_list(Puntos, PuntosPorContenido).
           

puntoPorTotalEngagement(MyTuber,10):- 
        engagement(MyTuber,TotalEngagement), 
        TotalEngagement > 1000000.

puntoPorTotalEngagement(MyTuber,0):- 
        engagement(MyTuber,TotalEngagement), 
        TotalEngagement =< 1000000.




puntoPorCantidadContenido(Contenidos,1):-  
        length(Contenidos, Cantidad), 
        Cantidad > 1.

puntoPorCantidadContenido(Contenidos,0):-  
                length(Contenidos, Cantidad), 
                Cantidad =<1.

puntajeDelContenido(short(_,_,[_|_]), 2).
puntajeDelContenido(short(_,_,[]), 0).

puntajeDelContenido(Contenido,1):- 
                nivel(Contenido, EngagementContenido), 
                EngagementContenido > 10000.   

puntajeDelContenido(Contenido,0):- 
                nivel(Contenido, EngagementContenido), 
                EngagementContenido =< 10000.   
        
puntajeDelContenido(video(_,Duracion,_,_), 2):-  
            Duracion > 6000.
puntajeDelContenido(video(_,Duracion,_,_), 0):-  
            Duracion =< 6000.





%(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((())))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
/*Al cerrar el año, eligen al mejor según el puntaje para ser la cara de la empresa para el año siguiente. 
En caso de empate, no se elige a nadie, no da ser injustos.*/
                

mejorMyTuber(MyTuber1):-
        contenido(MyTuber1,_),
        puntaje(MyTuber1, Puntaje1),
        forall(
                (contenido(MyTuber2,_) , MyTuber2 \= MyTuber1),
                 
                 (puntaje(MyTuber2,Puntaje2) , Puntaje1> Puntaje2)
                
                ).



%(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((())))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
/*

Nos piden determinar qué manager representa a qué mytuber. 
Un manager representa a un mytuber cuando lo administra directamente o cuando administra a otro manager que lo representa.

*/

administra(martin, sebaElDolar).                                    
administra(martin, markitocuchillos).                              
administra(iniaki,martin).
administra(iniaki,gaston).
administra(gaston,tiqtoqera).
administra(fernando, iniaki).





representa(Manager,MyTuber):-
       
        administra(Manager,MyTuber).

representa(Manager,MyTuber):-
       
        administra(Intermediario,MyTuber),
        representa(Manager,Intermediario).


