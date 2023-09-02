%2


puedeSortearObstaculo2(Auto,Obstaculo):-
    feature(Auto,Caracteristica), 
    capacidadRequerida(Obstaculo,Requisito),
    cumple(Caracteristica,Requisito).


cumple(capacidad(estabilidad),estabilidad).
cumple(transformacion(bicicleta,[estabilidad]) ,estabilidad).
cumple(transformacion(tanque,[estabilidad]) ,estabilidad).
cumple(transformacion(barco,[waterResistant]),waterResistant).
cumple(capacidad(volar),volar).
cumple(transformacion(dirigible, [volar, supervelocidad]),volar).
cumple(capacidad(velocidad),velocidad).

%3Juan

autoConclusiva2(Carrera):-
    carrera(Carrera, ListaTramos),
    nth0(0, ListaTramos, PrimerTramo),
    last(ListaTramos,UltimoTramo),
    sonIguales(PrimerTramo,UltimoTramo).
sonIguales(Tramo,Tramo).

%3Mauro
autoConclusiva3(Carrera):-
    carrera(Carrera, ListaTramos),
    nth0(0, ListaTramos, PrimerTramo),
    last(ListaTramos,PrimerTramo).

%4MAURO

puedeTransitar(Carrera,Auto):-
    auto(Auto),
    carrera(Carrera,ListaTramos),
        forall(
            member(tramo(Tramo),ListaTramos),
            puedeSortearTramo(Tramo,Auto)
            ).

puedeSortearTramo(Tramo,Auto):-
    obstaculo(Tramo,Obstaculo),
    puedeSortearObstaculo(Auto,Obstaculo).

puedeSortearTramo(ciudad,_).

puedeSortearTramo(carretera,_).

%4juan
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


