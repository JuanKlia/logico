
% natacion: estilo preferido, metros nadados, medallas
practica(phelps, natacion(crawl, 5000, 35)).
practica(juan, natacion(pecho, 500, 0)).
% fútbol: medallas, goles marcados, veces que fue expulsado
practica(messi, futbol(30, 820, 4)).
practica(cape, futbol(0, 36, 0)).

% rugby: posición que ocupa, medallas
practica(pichot, rugby(mariscal, 1)).
practica(pablito, rugby(wing, 0)).
practica(falsoPhelps, rugby(nadador, 34)).

%******************************************************************************************************************
%******************************************************************************************************************
%quienes son nadadores --> practica(Deportista, natacion(_,_,_)).  pero mejor hacer regla

nadador(Nombre):- practica(Nombre, natacion(_,_,_)).
%Un deportista es nadador cuando practica natacion


%******************************************************************************************************************
%******************************************************************************************************************
%Medallas obtenidas de una persona

/*medallas(Persona, NumeroMedallas):- practica(Persona,natacion(_,_, NumeroMedallas)).
medallas(Persona, NumeroMedallas):- practica(Persona,futbol(NumeroMedallas,_, _)).
medallas(Persona, NumeroMedallas):- practica(Persona,rugby(_, NumeroMedallas)).  las medallas estan en distintas partes del functores, hay que resolver el problema dependiendo la actividad */

medallas(Persona, NumeroMedallas):- 
        practica(Persona, Deporte),  %Deporte quedaria ligado con el functor deporte(y sus campos) 
        medallasPorDeporte(Deporte, NumeroMedallas). %Como obtener las medallas para cada deporte

%El problema de obtener las medallas cambia dependiendo del functor deporte, distintas soluciones en BASE A LA FORMA DE UN ARGUMENTO ->PATTERN MATCHING

medallasPorDeporte(natacion(_,_,Medallas), Medallas). %si lo que llega como primer argumento no tiene esa forma, es FALSO. (hay una condicion implicita de patron "si ttiene este patron..")
%no es completamente inversible --> por Pattern maching (cuando hay disntos patrones hay un predicado aux como medallasPorDep que no puede ser tminversible por UNO de los argumentos (1ero))
% medallasPorDeporte(Deporte,Medallas) --> Deporte = natacion(_, _, Medallas).
%Medallas si es inversible, si le pasas el primer argumento, ya que se desarma

%PM con el nombre y aridad del functor
medallasPorDeporte(futbol(Medallas,_,_),Medallas).

medallasPorDeporte(rugby(Medallas,_),Medallas).

%******************************************************************************************************************
%******************************************************************************************************************
/*
Polimorfismo (hay polimorfismo cuando...):
- Entidades con diferentes formas --> Deportes puede ser rugby futbol y natacion, con formas diferentes (medallas por deporte)
- Hay un predicado que los USA igual y Desconoce las diferentes formas (medallas esta abstraido de las formas)
- Hay un predicado que reconoce las formas y resuleve en base a ellas (Usa pattern matching)

Una entidad con distintas formas que en un punto se tratan igual tv y tv4k
*/
%******************************************************************************************************************
%******************************************************************************************************************
%Quien tiene mas medallas que todos? "Para todos los deportistas que existen, yo tengo mas medallas que ellos?"

elMasGanador(Ganador):-
        practica(Ganador, _), %no era inversible elMasGanador(Ganador), por lo que ANTES del forall genero todos los posibles ganadores
        forall(
         ( practica(Persona,_),
           Persona \= Ganador) ,

            (medallas(Ganador,MedallasGanador),
             medallas(Persona, MedallasPersona),
             MedallasGanador > MedallasPersona
            )
        ).

%Cuando genera a las personas tambien genera a phels entonces tiene que ser >=
%Pero no contempla el caso de que 2 personas tengan igual medalla y sean ganadors (ambas darian true) --> al generar valido qe no sea la persona del parametro


elMasGanador(Ganador):-
    practica(Ganador, _),
    medallas(Ganador,MedallasGanador), %Medallas es completamente inversible y puede generar al ganador

    forall(
     ( practica(Persona,_),
       Persona \= Ganador) ,

        (medallas(Persona, MedallasPersona),
         MedallasGanador > MedallasPersona
        )
    ).
elMasGanador(Ganador):-
    medallas(Ganador,MedallasGanador), %Medallas es completamente inversible y puede generar al ganador. Ademas no hace falta generar las medallasGandor dentro del forall

    forall(
     ( practica(Persona,_),  %En vez de preguntar para todos las personas que practican un deporte, mejor preguntar para todas las medallas de las personas que tienen
       Persona \= Ganador) ,

        (medallas(Persona, MedallasPersona),
         MedallasGanador > MedallasPersona
        )
    ).


    elMasGanador(Ganador):-
        medallas(Ganador,MedallasGanador), %Medallas es completamente inversible y puede generar al ganador. Ademas no hace falta generar las medallasGandor dentro del forall
    
        forall(
         ( practica(Persona,_),  %medallas es completamente inversible, puede generar todas las personas posibles
           medallas(Persona, MedallasPersona),
           Persona \= Ganador) ,
    
            
        MedallasGanador > MedallasPersona
            
        ).

        elMasGanador(Ganador):-
            medallas(Ganador,MedallasGanador), %Medallas es completamente inversible y puede generar al ganador. Ademas no hace falta generar las medallasGandor dentro del forall
        
            forall(
             (
               medallas(Persona, MedallasPersona),
               Persona \= Ganador) ,
        
                
            MedallasGanador > MedallasPersona
                
            ).

   elOLosMasGanadores(Ganador):-
        medallas(Ganador,MedallasGanador),
        forall(
            medallas(_,MedallasPersona), %para todas las medallas que alguien tiene, sin importar que soy yo
            medallasGandor>= MedallasPersona
            ).
    
%******************************************************************************************************************
%******************************************************************************************************************

/* 
Buen deportista
Quiero saber si alguien es buen deportista
en el caso de la natación, si recorren más de 1.000 metros diarios o su estilo preferido es el crawl
en el caso del fútbol, si la diferencia de goles menos las expulsiones es más de 5
en el caso del rugby, si son wings o pilares
*/

buenDeportista(Deportista):-
    practica(Deportista,Deporte), %Practica un deporte
    buenDeporte(Deporte). %y ese es buen deporte

buenDeporte(natacion(_, Metros,_)):- Metros > 1000. % PM con Regla
buenDeporte(natacion(crawl, _,_)). %PM con Hecho

%buenDeporte(futbol(_, Goles, Expulsiones)):- Goles - Expulsiones > 5.
buenDeporte(futbol(_, Goles, Expulsiones)):- 
        Diferencia is Goles-Expulsiones, %Diferencia liga la cuenta, y despues se compara con eso (LIGADO ARITMETICO)
        Diferencia > 5.

buenDeporte(rugby(wing, _)).
buenDeporte(rugby(pilar, _)).


%******************************************************************************************************************
%******************************************************************************************************************
/* 
    y si agregamos el polo que solo sabemos el handicap del jugador, 
    y es bueno si tiene un handicap mayor a 6
    no tiene medallas
*/

practica(julieta, polo(8)). %hay que expandir a todos los predicados que usaban deporte

buenDeporte(polo(Handicap)) :- Handicap >6.
%Julieta no tiene medallas, por lo que nunca sera un "Ganador" y tampoco sera generada como Persoan que tiene medallas