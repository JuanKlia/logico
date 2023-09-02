%% solucion.pl
%% alumno: GRUPO 7

%-------------------------------------------------------------------------------------
% BASE DE CONOCIMIENTOS
%-------------------------------------------------------------------------------------

%carrera(nombre de la carrera, lista de tramos que la componen)
carrera(villaCalibre, [tramo(ciudad),tramo(carretera),tramo(laguna)]).
carrera(adelaida, [tramo(montania),tramo(bosque),tramo(trampolin),tramo(montania)]).

%obstáculo(caracteristica del terreno, obstáculos que se presentan)
obstaculo(montania, barro).
obstaculo(montania, ripio).
obstaculo(laguna, agua).
obstaculo(laguna, animalSalvaje).
obstaculo(bosque, pasto).
obstaculo(trampolin, aire).
%(carreteras y ciudades no tienen obstáculos).

obstaculo(carretera, _).
obstaculo(ciudad, _).

%capacidadRequerida(obstaculo,capacidad para superarlo)
capacidadRequerida(barro, todoTerreno).
capacidadRequerida(ripio, estabilidad).
capacidadRequerida(agua, waterResistant).
capacidadRequerida(animalSalvaje, _). %cualquier capacidad puede con un animal salvaje
capacidadRequerida(pasto, todoTerreno).
capacidadRequerida(aire, volar).

%Autos con características especiales que se representan como functores y pueden ser:
%1)transformacion(resultado de la transformación, habilidades)
%2)capacidad(capacidad)
feature(superFerrari, arma(ametralladora)).
feature(superFerrari, arma(canion)).
feature(superFerrari, transformacion(barco, [waterResistant])).
feature(superFerrari, capacidad(velocidad)).
feature(elRocomovil, capacidad(velocidad)).
feature(elRocomovil, capacidad(estabilidad)).
feature(elStukaRakuda, capacidad(volar)).
feature(elStukaRakuda, capacidad(velocidad)).
feature(elStukaRakuda, arma(ametralladora)).
feature(superConvertible, transformacion(barco, [waterResistant])).
feature(superConvertible, transformacion(bicicleta, [estabilidad])).
feature(superConvertible, transformacion(dirigible, [volar, supervelocidad])).
feature(superConvertible, transformacion(tanque, [estabilidad])).
feature(compactPussycat, capacidad(velocidad)).
feature(compactPussycat, arma(cosmeticos)).

%Cada auto tiene competidores que viajan en el:
%equipo(Auto,Miembros) siendo el primero de los miembros el conductor
equipo(superFerrari, [pierNodoyuna, patan]).
equipo(elRocomovil, [piedroMacana, rocoMacana]).
equipo(elStukaRakuda, [baronHansFritz]).
equipo(superConvertible, [profesorLocobitch]).
equipo(compactPussycat, [penelopeGlamour]).
equipo(alambiqueVeloz, [lucasElGranjero, elOsoMiedoso]).

% A su vez, los competidores tienen un nivel de aptitud, dependiendo de su personalidad:
%personalidad(Alguien, Personalidad).
personalidad(pierNodoyuna, malhechor).
personalidad(patan, malhechor).
personalidad(penelopeGlamour, damiselaEnApuros).
personalidad(penelopeGlamour, servicial).
personalidad(piedroMacana, propensoAccidentes).
personalidad(baronHansFritz, malhechor).

%nivelAptitud(personalidad, nivel).
nivelAptitud(malhechor, 35).
nivelAptitud(servicial, 20).
nivelAptitud(propensoAccidentes, 10).
nivelAptitud(damiselaEnApuros, 10).
nivelAptitud(nadaParaDestacar, 5).

%-------------------------------------------------------------------------------------
% 1A: esAutoPeligroso\1 si tiene más de dos armas o patan viaja en él.
%-------------------------------------------------------------------------------------
auto(Auto):- feature(Auto,_).


esAutoPeligroso(Auto):-
    tieneMasDeDosArmas(Auto).
esAutoPeligroso(Auto):-
    patanViajaEnAuto(Auto).

tieneMasDeDosArmas(Auto):-
    auto(Auto),
    findall(
        arma, %?
        feature(Auto, arma(_)),
        Armas),
    length(Armas, CantidadArmas),
    CantidadArmas > 2.

patanViajaEnAuto(Auto) :-
    equipo(Auto, Miembros),
    member(patan, Miembros).

%-------------------------------------------------------------------------------------
% 1B: vaConPropulsion\1 un auto va con propulsión si alguno de sus capacidades es la velocidad.
%-------------------------------------------------------------------------------------

vaConPropulsion(Auto) :-
    feature(Auto, capacidad(velocidad)).

%-------------------------------------------------------------------------------------
% 1C: esSeguroEstarCerca\1 cuando un auto no tiene armas siempre es seguro estar cerca.
%-------------------------------------------------------------------------------------

esSeguroEstarCerca(Auto) :-
    auto(Auto),
    not(tieneArmas(Auto)).

tieneArmas(Auto) :-
    feature(Auto, arma(_)).

%-------------------------------------------------------------------------------------
% 2: un auto puede sortear un obstáculo si tiene como
% feature la capacidad requerida por el obstáculo para ser superado.
% Cualquier feature sirve para superar a un animal salvaje.
%-------------------------------------------------------------------------------------

puedeSortearObstaculo(Auto,Obstaculo):-
    auto(Auto),
    feature(Auto,Capacidad),
    tieneCapacidadRequerida(Capacidad,Obstaculo).

tieneCapacidadRequerida(capacidad(Capacidad),Obstaculo):-
    capacidadRequerida(Obstaculo,Capacidad).


tieneCapacidadRequerida(transformacion(_,ListaCapacidades),Obstaculo):-
    capacidadRequerida(Obstaculo,Capacidad),
    member(Capacidad,ListaCapacidades).



%-------------------------------------------------------------------------------------
% 3. autoConclusiva\1 una carrera es autoconclusiva si el último tramo y el primer tramo
% que la componen son el mismo terreno. Este predicado debe ser inversible.
%-------------------------------------------------------------------------------------

autoConclusiva(Carrera) :-
    carrera(Carrera, Tramos),
    nth0(0, Tramos, PrimerTramo),
    last(Tramos, UltimoTramo),
    terrenoDelTramo(PrimerTramo, Terreno),
    terrenoDelTramo(UltimoTramo, Terreno).
terrenoDelTramo(tramo(Terreno), Terreno).


%-------------------------------------------------------------------------------------
% 4. puedeTransitar\2 que relaciona a una carrera y un automóvil si ese automóvil puede
% sortear todos los obstáculos que aparecen en cada uno de los tramos de la carrera.
% Este predicado tiene que ser totalmente inversible.
%-------------------------------------------------------------------------------------

puedeTransitar(Carrera, Auto) :-
    carrera(Carrera, Tramos),
    auto(Auto),
    forall(        
        member(tramo(Terreno), Tramos), 
        (obstaculo(Terreno, Obstaculo),
         puedeSortearObstaculo(Auto, Obstaculo))
    ).

%-------------------------------------------------------------------------------------
% 5. esImpochible\1 se dice que una carrera es imposible si no hay ningún automóvil
% que sea capaz de transitarla. Debe ser inversible.
%-------------------------------------------------------------------------------------
carrera(Carrera):-carrera(Carrera,_).

esImpochible(Carrera):-
    carrera(Carrera),
    forall(
            auto(Auto),
             not(puedeTransitar(Carrera,Auto)) 
              ).

%-------------------------------------------------------------------------------------
% 6a. nivelDeAptitudDelCompetidor\2: esta dado por las personalidades del
%   competidor. Como un competidor puede tener más de una personalidad, su
%   nivel de aptitud es la suma del nivel de aptitud de todas sus personalidades.
%-------------------------------------------------------------------------------------
competidor(Competidor):- personalidad(Competidor,_).

nivelDeAptitudDelCompetidor(Competidor, Total) :-
    competidor(Competidor),
    findall(
        Nivel,
        (personalidad(Competidor, Personalidad), nivelAptitud(Personalidad, Nivel)),
        Niveles
        ),
    sumlist(Niveles, Total).

%-------------------------------------------------------------------------------------
% 6b. nivelDeAptitudDelVehiculo\2: es la suma de los puntos que le dan cada feature:
%-------------------------------------------------------------------------------------

nivelDeAptitudDelVehiculo(Vehiculo, Total) :-
    auto(Vehiculo),
    findall(
      Punto,
     (feature(Vehiculo, Caracteristica), puntosCaracteristica(Caracteristica, Punto)),
     Puntos
     ),
     sumlist(Puntos, Total).

puntosCaracteristica(arma(_), 5).
puntosCaracteristica(transformacion(_, _), 10).
puntosCaracteristica(Caracteristica, Punto):- 
                                          Caracteristica \= arma(_),
                                          Caracteristica \= transformacion(_,_), 
                                          Punto is 15.

%-------------------------------------------------------------------------------------
% 6c. nivelDeAptitudParaCompetir\2 relaciona a un vehículo con su nivel de
% aptitud para una competencia. Esto es la sumatoria del nivel de aptitud de
% todos los competidores que viajan en el vehículo más el nivel de aptitud del
% vehículo.
%-------------------------------------------------------------------------------------

nivelDeAptitudParaCompetir(Vehiculo, Total):-
    equipo(Vehiculo, Competidores),
    nivelDeAptitudDelVehiculo(Vehiculo, NivelVehiculo),
    nivelDeAptitudDeLosCompetidores(Competidores,TotalCompetidores),
    Total is NivelVehiculo + TotalCompetidores.

nivelDeAptitudDeLosCompetidores(Competidores,TotalCompetidores):-
    findall(
        NivelCompetidor,
        (member(Competidor, Competidores), once(nivelDeAptitudDelCompetidor(Competidor, NivelCompetidor))),
        NivelesCompetidores
    ),
    sumlist(NivelesCompetidores, TotalCompetidores).

%-------------------------------------------------------------------------------------
% 7. Saber qué vehículo llega primero. Es el vehículo con el mayor nivel de aptitud y que
% además no es elRocomovil.
%-------------------------------------------------------------------------------------

vehiculoLlegaPrimero(Vehiculo) :-
    nivelDeAptitudParaCompetir(Vehiculo, Nivel),
    Vehiculo \= elRocomovil,
    forall(
        (nivelDeAptitudParaCompetir(OtroVehiculo, OtroNivel), OtroVehiculo \= elRocomovil),
        Nivel >= OtroNivel
    ).