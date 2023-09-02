%-------------------------------------------------------------------------------------
% BASE DE CONOCIMIENTOS
%-------------------------------------------------------------------------------------


carrera(villaCalibre, [tramo(ciudad),tramo(carretera),tramo(laguna)]).
carrera(adelaida, [tramo(montania),tramo(bosque),tramo(trampolin),tramo(montania)]).


obstaculo(montania, barro).
obstaculo(montania, ripio).
obstaculo(laguna, agua).
obstaculo(laguna, animalSalvaje).
obstaculo(bosque, pasto).
obstaculo(trampolin, aire).


capacidadRequerida(barro, todoTerreno).
capacidadRequerida(ripio, estabilidad).
capacidadRequerida(agua, waterResistant).
capacidadRequerida(animalSalvaje, _). 
capacidadRequerida(pasto, todoTerreno).
capacidadRequerida(aire, volar).



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



equipo(superFerrari, [pierNodoyuna, patan]).
equipo(elRocomovil, [piedroMacana, rocoMacana]).
equipo(elStukaRakuda, [baronHansFritz]).
equipo(superConvertible, [profesorLocobitch]).
equipo(compactPussycat, [penelopeGlamour]).
equipo(alambiqueVeloz, [lucasElGranjero, elOsoMiedoso]).



personalidad(pierNodoyuna, malhechor).
personalidad(patan, malhechor).
personalidad(penelopeGlamour, damiselaEnApuros).
personalidad(penelopeGlamour, servicial).
personalidad(piedroMacana, propensoAccidentes).
personalidad(baronHansFritz, malhechor).


nivelAptitud(malhechor, 35).
nivelAptitud(servicial, 20).
nivelAptitud(propensoAccidentes, 10).
nivelAptitud(damiselaEnApuros, 10).
nivelAptitud(nadaParaDestacar, 5).



/******************************************************************************************************************************/
                                                    /*EJERCICIO 1*/
/******************************************************************************************************************************/

/*Generadores auxiliares*/

auto(Auto):- feature(Auto,_).
competidor(Competidor):- personalidad(Competidor,_).
carrera(Carrera):-carrera(Carrera,_).
/*                      */

masDeDos(Armas):-  
              length(Armas, NumeroArmas),
              NumeroArmas >2.

esArma(arma(_)).  

esAutoPeligroso(Auto):-
                     auto(Auto),
                     findall(
                     Caracteristica,
                     (feature(Auto,Caracteristica), esArma(Caracteristica) ),  %ligara los functores arma(_)
                     Armas
                      ),
                      masDeDos(Armas).
                    
 
esAutoPeligroso(Auto):-
                       equipo(Auto,Integrantes),
                       estaPatan(Integrantes).

estaPatan(Integrantes):- 
                       member(patan, Integrantes).
                       


vaConPropulsion(Auto):-
                      feature(Auto,capacidad(velocidad)).



esSeguroEstarCerca(Auto) :-
                          equipo(Auto,_),
                          not(tieneArmas(Auto)).
                        
tieneArmas(Auto) :-
                 feature(Auto, arma(_)).




/******************************************************************************************************************************/
                                                    /*EJERCICIO 2*/
/******************************************************************************************************************************/

puedeSortearObstaculo(Auto,Obstaculo):-
                                     feature(Auto,Caracteristica), 
                                     capacidadRequerida(Obstaculo,Requisito),
                                     cumple(Caracteristica,Requisito).

puedeSortearObstaculo(_, animalSalvaje).

cumple(capacidad(estabilidad),estabilidad).
cumple(transformacion(bicicleta,[estabilidad]) ,estabilidad).
cumple(transformacion(tanque, [estabilidad]) ,estabilidad).
cumple(transformacion(barco, [waterResistant]),waterResistant).
cumple(capacidad(volar),volar).
cumple(transformacion(dirigible, [volar, supervelocidad]),volar).






/******************************************************************************************************************************/
                                                    /*EJERCICIO 3*/
/******************************************************************************************************************************/

sonIguales(Tramo,Tramo).

autoConclusiva(Carrera):-
                        carrera(Carrera, ListaTramos),
                        nth0(0, ListaTramos, PrimerTramo),
                        last(ListaTramos,UltimoTramo),
                        sonIguales(PrimerTramo,UltimoTramo).

autoConclusiva2(Carrera):-
                        carrera(Carrera, ListaTramos),
                        nth0(0, ListaTramos, PrimerTramo),
                        last(ListaTramos,PrimerTramo).
                    
                        

/******************************************************************************************************************************/
                                                    /*EJERCICIO 4*/
/******************************************************************************************************************************/


puedeTransitar(Carrera,Auto):-
                            carrera(Carrera, ListaTramos),
                            auto(Auto),
                            forall(
                                    (
                                     member(tramo(Terreno), ListaTramos), 
                                     not(sinObstaculo(Terreno))
                                     ),
                                    (
                                     (obstaculo(Terreno, Obstaculo),
                                     puedeSortearObstaculo(Auto, Obstaculo))
                                    )
                                    ).             

sinObstaculo(ciudad).
sinObstaculo(carretera).


/******************************************************************************************************************************/
                                                    /*EJERCICIO 5*/
/******************************************************************************************************************************/

esImpochible(Carrera):-
                      carrera(Carrera),
                      forall(
                              auto(Auto),
                               not(puedeTransitar(Carrera,Auto)) 
                                ).

/******************************************************************************************************************************/
                                                    /*EJERCICIO 6*/
/******************************************************************************************************************************/


nivelDeAptitudDelCompetidor(Competidor, Total) :-
                                                competidor(Competidor),
                                                findall(
                                                Nivel,
                                                (personalidad(Competidor, Personalidad), nivelAptitud(Personalidad, Nivel)),
                                                Niveles
                                                ),
                                                sumlist(Niveles, Total).




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



nivelDeAptitudParaCompetir(Vehiculo, Total):-
                                           equipo(Vehiculo, Competidores),
                                           nivelDeAptitudDelVehiculo(Vehiculo, NivelVehiculo),
                                           nivelDeAptitudDeLosCompetidores(Competidores,TotalCompetidores),
                                           Total is NivelVehiculo + TotalCompetidores.


nivelDeAptitudDeLosCompetidores(Competidores,TotalCompetidores):-

                                                               findall(
                                                               NivelCompetidor,
                                                              (member(Competidor, Competidores),nivelDeAptitudDelCompetidor(Competidor, NivelCompetidor)),
                                                               NivelesCompetidores
                                                               ),
                                                               sumlist(NivelesCompetidores, TotalCompetidores).


/******************************************************************************************************************************/
                                                    /*EJERCICIO 7*/
/******************************************************************************************************************************/

vehiculoLlegaPrimero(Vehiculo) :-
    nivelDeAptitudParaCompetir(Vehiculo, Nivel),
    Vehiculo \= elRocomovil,
    forall(
        (nivelDeAptitudParaCompetir(OtroVehiculo, OtroNivel), OtroVehiculo \= elRocomovil),
        Nivel >= OtroNivel
    ).