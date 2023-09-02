gusta(juan,maria).
gusta(pedro,ana).
gusta(pedro,nora).

%Julián gusta de las morochas y de las chicas con onda -> Julián gusta de una chica si es morocha o si tiene onda.

gusta(julian,Chica):- chica(Chica),morocha(Chica).
gusta(julian,Chica):- chica(Chica),tieneOnda(Chica).

%Mario gusta de las morochas con onda y de Luisa 
gusta(mario,Chica):- chica(Chica), morocha(Chica), tieneOnda(Chica).
gusta(mario, Luisa).

%Todos los que gustan de nora gustan de zulema

gusta(Persona,zulema):-gusta(Persona,nora).

%Todos los que gustan de Ana y de Luisa, gustan de Laura. 
gusta(Persona,laura):-gusta(Persona,ana) , gusta(Persona,luisa).

%Todos los que gustan de Ana o de Luisa, gustan de Laura

gusta(Alguien, laura):- gusta(Alguien, ana).
gusta(Alguien, laura):- gusta(Alguien,luisa).


/*
Dada la siguiente base de conocimientos:
progenitor(homero, bart).
progenitor(homero, lisa).
progenitor(homero, maggie).
progenitor(abe, homero).
progenitor(abe, jose).
progenitor(jose, pepe).
progenitor(mona, homero).
progenitor(jacqueline, marge).
progenitor(marge, bart).
progenitor(marge, lisa).
progenitor(marge, maggie).


Resolver los predicados hermano, tío, primo y abuelo. 

*/

progenitor(homero, bart).
progenitor(homero, lisa).
progenitor(homero, maggie).
progenitor(abe, homero).
progenitor(abe, jose).
progenitor(jose, pepe).
progenitor(mona, homero).
progenitor(jacqueline, marge).
progenitor(marge, bart).
progenitor(marge, lisa).
progenitor(marge, maggie).


hermanos(Hermano1,Hermano2):- progenitor(Padre,Hermano1) , progenitor(Padre,Hermano2), Hermano1 \= Hermano2.

tio(Tio,Sobrino):- hermanos(Tio,Padre), progenitor(Padre,Sobrino).
tio(Sobrino,Tio):- progenitor(Padre,Sobrino), hermanos(Tio,Padre).

primos(Primo1,Primo2):- progenitor(Padre1,Primo1), progenitor(Padre2,Primo2), hermanos(Padre1,Padre2).

abuelo(Abuelo,Nieto):-  progenitor(Abuelo,Padre), progenitor(Padre,Nieto).



siguiente(N, Siguiente):- Siguiente is N + 1.

valor(4, 1).
valor(Incognita, Incognita).
headCustom([Cabeza | _], Cabeza).



%(((((((((((((((((((((((())))))))))))))))))))))))

practica(ana, natacion([pecho, crawl], 1200, 10)).
practica(luis, natacion([perrito], 200, 0)).
practica(vicky, natacion([crawl, mariposa, pecho, espalda], 800, 0)).

practica(deby, futbol(2, 15, 5)).
practica(mati, futbol(1, 11, 7)).

practica(zaffa, rugby(pilar, 0)).

%Quienes son nadadores

esNadador(Deportista):- practica(Deportista,natacion(_,_,_)).

nadadores(Quien):-practica(Quien, Deporte), nadador(Deporte).
nadador(natacion(_, _, _)).


%Cuantas medallas tiene alguien


medallas(Persona,Numero):-
    practica(Persona,Deporte),  %Predicado generador, cuando entran sin ligar practica/2 es un hecho y liga Persona-Deporte (genera todas las personas que practican)
    numeroMedallas(Deporte,Numero). %Deporte entra ligado

numeroMedallas(natacion(_,_,Numero),Numero).
numeroMedallas(futbol(Numero,_,_),Numero).
numeroMedallas(rugby(_,Numero),Numero).


/* Buen deportista
Quiero saber si alguien es buen deportista
en el caso de la natación, si recorren más de 1.000 metros diarios o nadan más de 3 estilos
en el caso del fútbol, si la diferencia de goles menos las expulsiones suman más de 5
en el caso del rugby, si son wings o pilares */

buenDeportista(Alguien):- 
    practica(Alguien,Deporte), 
    buenDeporte(Deporte).

buenDeporte(rugby(wings,_)).
buenDeporte(rugby(pilar,_)).
buenDeporte(natacion(_,Mts,_)):- Mts>1200.
buenDeporte(natacion(Estilos,_,_)):- 
    length(Estilos, Cantidad), 
    Cantidad>3.

buenDeporte(futbol(_,Goles,Exp)):- 
    Resultado is Goles-Exp, 
    Resultado>5.

%individuos polimórficos: rugbiers, futbolistas y nadadores se pueden trabajar en conjunto 
   
practica(gise, polo(8)).
    
buenDeporte(polo(Handicap)):-Handicap > 6.
    
%buenDeportista  no va a verse impactado: la definición original sigue valiendo
    


%(((((((((((((((((((((((())))))))))))))))))))))))

materia(algoritmos, 1).
materia(analisisI, 1).
materia(pdp, 2).
materia(proba, 2).
materia(sintaxis, 2).

nota(nicolas, pdp, 10).
nota(nicolas, proba, 7).
nota(nicolas, sintaxis, 8).
nota(malena, pdp, 6).
nota(malena, proba, 2).
nota(raul, pdp, 9).

%Un alumno termino un anio si aprobo todas las materias de ese año

termino(Alumno, Anio):-
        alumno(Alumno),
        anio(Anio),
        forall(materia(Materia, Anio), 
               aprobo(Alumno,Materia)).

aprobo(Alumno,Materia):- nota(Alumno,Materia,Nota), Nota>=6.
anio(Anio):-materia(_,Anio).
alumno(Alumno):-nota(Alumno,_,_).



%(((((((((((((((((((((((())))))))))))))))))))))))

%En este caso debemos resolver si un auto le viene perfecto a una persona, donde le viene perfecto = tiene todas las características que la persona quiere.

vieneCon(p206, abs).
vieneCon(p206, levantavidrios).
vieneCon(p206, direccionAsistida).
vieneCon(kadisco, abs).
vieneCon(kadisco, mp3).
vieneCon(kadisco, tacometro).


quiere(carlos, abs).
quiere(carlos, mp3).
quiere(roque, abs).
quiere(roque, direccionAsistida).




vaPerfecto(Auto,Persona):- 
          auto(Auto),
          persona(Persona),
          forall(    
                  quiere(Persona,Caracteristica),
                  vieneCon(Auto,Caracteristica)
                             
              ).
auto(Auto):-vieneCon(Auto,_).
persona(Persona):-quiere(Persona,_).


%(((((((((((((((((((((((())))))))))))))))))))))))

%Inclusion

incluido(A,B):- 
        forall(
                member(Elemento, A),
                 member(Elemento,B)).
        

disjunto(A,B):- 
        forall(
                member(Elemento,A), 
                not(member(Elemento,B))
        ).


%(((((((((((((((((((((((())))))))))))))))))))))))
%Un alumno estudioso es aquel que estudia para todas las materias...
materia(am1).
materia(sysop).
materia(pdp).

alumno(clara).
alumno(matias).
alumno(valeria).
alumno(adelmar).

estudio(clara, am1).
estudio(clara, sysop).
estudio(clara, pdp).
estudio(matias, pdp).
estudio(matias, am1).
estudio(valeria, pdp).

estudioso(Alumno):- 
        alumno(Alumno),
        forall( materia(Materia), estudio(Alumno,Materia)).
        

dificil(Alumno):-
        alumno(Alumno),
        forall(materia(Materia), not(estudio(Alumno,_))
        ).


%(((((((((((((((((((((((())))))))))))))))))))))))

padre(homero,bart).
padre(homero,maggie). 
padre(homero,lisa). 
padre(juan, fede). 
padre(nico, julieta).

%Cuantos hijos tiene homero --> padre(homero,Hijos) X
%Queremos algo como :  cantidadHijos(Padre,Cantidad)

cantidadDeHijos(Padre, Cantidad) :- 
        padre(Padre,_), %para que sea inversible Padre debe generarse antes, para que llegue ligada al findall
	findall(Hijo, padre(Padre, Hijo), Hijos),
        length(Hijos,Cantidad).


%Como genero en base a los que son padre, los que no lo sean daran false --> cantidadHijos(bart,Cantidad).  por la CONJUNCION
%Si no lo genero da cero, ya que en la consulta del findall no genera ningun conjunto

cantidadDeHijos(Padre, Cantidad) :- 
        persona(Padre), 
	findall(Hijo, padre(Padre, Hijo), Hijos),
        length(Hijos,Cantidad).

persona(Padre):-padre(Padre,_).
persona(Hijo):-padre(_,Hijo).

        


%si queremos hacer un predicado que me diga cuántos hijos varones tiene una persona, los X que me interesan son los que cumplen la consulta

hijosVarones(Padre,Cantidad):-
                persona(Padre),
                findall(
                        Hijo,
                        (padre(Padre,Hijo),varon(Hijo)),
                        Varones
                        
                        ),
                length(Varones, Cantidad).
                

varon(bart).
varon(fede).



%Interseccion de conjuntos

interseccion(A,B,Resultado):-findall(Elemento, (member(Elemento,A), member(Elemento,B)), Resultado).



%Contamos con una base de conocimientos con la siguiente información en un jardín de infantes:

jugoCon(tobias, pelota, 15).
jugoCon(tobias, bloques, 20).
jugoCon(tobias, rasti, 15).
jugoCon(tobias, dakis, 5).
jugoCon(tobias, casita, 10).
jugoCon(cata, muniecas, 30).
jugoCon(cata, rasti, 20).
jugoCon(luna, muniecas, 10).

/*Queremos saber
cuántos minutos jugó un nene según la base de conocimientos
cuántos juegos distintos jugó (no hay duplicados en la base)
*/

minutosJugados(Nene,Cantidad):- 
                jugoCon(Nene,_,_), %Nene se debe ligar antes para que sea inversible y no sume todos los minutos de todos los nenes 
                findall( 
                        Minuto, 
                        jugoCon(Nene,_,Minuto), 
                        Minutos), 
                sum_list(Minutos, Cantidad).

juegosDistintos(Nene,Cantidad):-
                jugoCon(Nene,_,_),
                findall(
                         Juego,
                         jugoCon(Nene,Juego,_),
                         Juegos

                        ),
                length(Juegos,Cantidad).


%(((((((((((((((((((((((())))))))))))))))))))))))

tiene(juan, foto([juan, hugo, pedro, lorena, laura], 1988)).
tiene(juan, foto([juan], 1977)).
tiene(juan, libro(saramago, "Ensayo sobre la ceguera")).
tiene(juan, bebida(whisky)).
tiene(valeria, libro(borges, "Ficciones")).
tiene(lucas, bebida(cusenier)).
tiene(pedro, foto([juan, hugo, pedro, lorena, laura], 1988)).
tiene(pedro, foto([pedro], 2010)).
tiene(pedro, libro(octavioPaz, "Salamandra")).
 
premioNobel(octavioPaz).
premioNobel(saramago).

/*Determinamos que alguien es coleccionista si todos los elementos que tiene son valiosos:
un libro de un premio Nobel es valioso
una foto con más de 3 integrantes es valiosa
una foto anterior a 1990 es valiosa
el whisky es valioso
*/

coleccionista(Alguien):-
                tiene(Alguien,_),
                forall(
                        tiene(Alguien,Elemento),
                        valioso(Elemento)
                        ).

valioso(libro(Autor,_)):-premioNobel(Autor).
valioso(foto(Integrantes,_)):-length(Integrantes, Numero), Numero > 3.
valioso(foto(_,Anio)):-Anio < 1990.
valioso(bebida(whisky)).

