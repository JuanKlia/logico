%Como modelar?
%Martin e inia venden siempreViva742
%inia vende miCasita123

vende(inia, siempreViva742).

vende(martin, siempreViva742).

vende(inia, siempreViva742).
vende(inia,miCasita123).  %El predicado vende tiene multiples definiciones

/*
CONSULTAS EXISTENCIALES

es cierto que inia vende siempreViva742? --> vende(inia,siempreViva742)

cuales son las casas que vende inia? --> vende(inia, Casa)

quienes venden siempreViva742? --> vende (Vendedor, siempreViva742)

es cierto que inia vende alguna casa? --> vende (inia, _)

es cierto que siempreviva742 se vende? (si tiene algun vendedor)  --> vende ( _  , siempreViva742)
*/

% Preguntar si una casa es luminosa --> es una caracteristica
luminosa(siempreViva742).
luminosa(casaBlanca).

% Si una casa es grande, cuando tiene mas de 3 ambientes (nueva relacion)
ambientes(siempreViva742, 5).
ambientes(miCasita123, 1).
ambientes(casaBlanca,22).

grande(Casa):- 
    ambientes(Casa, Ambiente),
    Ambiente > 3.

 
% Un vendedor tranquilo es cuando tiene una casa en venta y es luminosa

tranquilo(Vendedor) :-
    vende(Vendedor,Casa),
    luminosa(Casa). 

% Una casa es copada cuando es luminosa o es grande

copada(Casa) :- luminosa(Casa).
copada(Casa) :- grande(Casa).
  