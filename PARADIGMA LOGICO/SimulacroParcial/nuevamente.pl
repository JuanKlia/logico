/*
Conocemos a todos los usuarios de la plataforma, de ellos conocemos su nickname, la cantidad de suscriptores y los contenidos que subió, hay tres tipos de contenido:
Videos, de ellos sabemos el título, la duración (en segundos) y la cantidad de views (en miles) y likes (estos valores se mantienen constantes ya que la base es de consulta).
Shorts, de ellos sabemos la duración (en segundos), la cantidad de likes y qué filtros tiene.
Streams, no hay información relevante de este tipo.

*/

%usuario(Nombre, Suscriptores).

/*
markitocuchillos tiene 45.000 suscriptores y subió:
Video: “Gatito toca el piano” que tiene una duración de 45 segundos, lo vieron 50 mil y tiene 1.000 likes.
Video: “Gatito toca el piano 2” que tiene una duración de 65 segundos, lo vieron 2 mil y tiene 2 likes.
*/

usuario(markitocuchillos, 45000).
usuario(sebaElDolar, 5000).
usuario(tiqtoqera, 40000).
usuario(user0918, 1).

%subio(Usuario, Contenido).

subio(markitocuchillos, video("Gatito toca el piano", 45, 50, 1000)).
subio(markitocuchillos, video("Gatito toca el piano 2", 65, 2, 2)).
subio(sebaElDolar, video("300 ¿es el dólar o Esparta?", 60000, 2000, 1040500)).
subio(sebaElDolar, stream).
subio(tiqtoqera, short(15, 800000, [goldenHauer, cirugiaEstetica])).
subio(tiqtoqera, short(20, 0, [])).
subio(tiqtoqera, stream).


myTuber(Usuario):- subio(Usuario,_).

milenial(Usuario):-subio(Usuario,Video), videoMilenial(Video).
 
videoMilenial(video(_,_,1000,_)).
videoMilenial(video(_,_,_,1000)).


usuario(Usuario):-usuario(Usuario,_).

noVideo(Usuario):- 
    usuario(Usuario),
    not(subio(Usuario,video(_,_,_,_))).

engagement(MyTuber,Total):-
        myTuber(MyTuber),
        findall( EngagementContenido,
                  (subio(MyTuber,Contenido),engagementContenido(Contenido,EngagementContenido)),
                  Engagements),
        sum_list(Engagements,Total).
        
engagementContenido(video(_,Views,_,Likes),Total):-Total is Views + Likes.
engagementContenido(short(_,Likes,_),Likes).
engagementContenido(stream,2000).

%Polimorfismo


puntaje(MyTuber,Puntaje):-
    myTuber(MyTuber),
    findall(PuntoObjetivoCumplido,
            (subio(MyTuber,Contenido),objetivo(MyTuber,Contenido,PuntoObjetivoCumplido)),
            Puntos),
    sum_list(Puntos,Puntaje).

objetivo(_,short(_,_,[_|_]),2).
objetivo(_,Contenido,1):-engagementContenido(Contenido,EngagementContenido), EngagementContenido > 10000.
objetivo(_,video(_,Duracion,_,_),2):-Duracion>6000.
objetivo(MyTuber,_,1):- 
        findall(
                  ContenidoSubido,
                  (subio(MyTuber,ContenidoSubido)),
                  Contenidos
               ),
        length(Contenidos, Cantidad),
        Cantidad>=2.
objetivo(MyTuber,_,10):-engagement(MyTuber,Engagement), Engagement > 1000000.
        

    