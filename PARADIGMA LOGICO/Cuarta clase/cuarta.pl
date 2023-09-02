%Unificacion aritmetica

buenaPractica(futbol(_,Goles,Expulsiones)):- Goles - Expulsiones >= 5.
buenaPractica(futbol(_,Goles,Expulsiones)):- 
        Diferencia is Goles - Expulsiones,
        Diferencia  >= 5.

esCinco(5).

sumar(X,Y,X+Y).

%Si pregunto esCinco(7-2) da false, pero si hago [futbol(_,3,2)] que es 7-2 >= 5 da true.

% 7-2 NO es cinco, es una EXPRESION, por eso nofunciona. Sin embargo cuando se evalua con un <> resuelve y si es cinco.

%sumar(1,2,3) es FALSE porque 1+2 no es 3.  sumar(3,5, Resultado) --> Resultado = 3+5.

/* Unificacion aritmetica --> en esta variable se liga el RESULTADO de la operacion aritmetica*/
sumarBien(X,Y,Resultado):- Resultado is X+Y.

%sumarBien(1,2,3) es TRUE ahora, ya que resuelve y no es la expresion

% X y Y (lo de la derecha del is) debe estar ligado, Prolog no sabe despejar 

esIgual(X,Y) :- 
    Resta is X-Y,
    esCero(Resta).

esCero(0).