/***************************************************************************************************************
Messi nacio el 24-06-1987

nacio(messi, 1987, 06, 24). 
nacio(cape, 2002, 05, 28).  nacio/4

Pero la mejor manera es tratar a la fecha como un todo:
*/

nacio(messi, fecha(1987,06,24)).
nacio(cape, fecha(2002,05,1996)).


/*
nacio messi?  nacio(messi,_).
cuando nacio cada persona? nacio(Persona, Fecha). da tdas las combinaciones de persona y functor fecha
que anio nacio messi?  nacio(messi, fecha(Anio,_,_)).
*/


/**************************************************************************************************************
Anto Roccuzzo, cliente número 99102, compró una TV de 80' pagando 200.000
Mateo Messi, cliente número 3, compró heladera con freezer y 2 puertas pagando 300.000
Fideo Di María, cliente 11, compró una TV de 40' a 80.000

 1) compro(anto, 99102, tv, 80, 200000).
compro(mateo, 3, heladera, freezer, 2, 300000).
compro(fideo, 11, tv, 40, 80000).

problemas de aridad por el polimorfismo de los productos: 
- no es el mismo predicado. Quiero saber los clientes --> compro(Cliente, _,_,_,_) solo ligan los de compra/5
- Tienen diferentes formas y por lo tanto no podemos tratarlas como iguales (Clientes)


2)
compro(anto, 99102, producto(tv, 80) , 200000).
compro(mateo, 3, preducto(heladera, freezer, 2) , 300000).
compro(fideo, 11, producto(tv, 40) , 80000).

ahora no hay problema de aridad ya que es compro/4 en todas
pero el functor producto es de distinta aridad

que clientes hicieron compras? -->  compro(Cliente,_,_,_).
que productos fueron comprados por mas de 100000? -->  compro (_,_, Producto, Precio) , Precio > 100000.  (se pueden hacer pregutas compuestas)
existe alguna tv de 80? producto(tv,80) no es un predicado, es un functor. SI se puede preguntar si alguien compro una tv de 80 --> compro (_, prodcuto(tv,80), _).

Y si el Kun Agüero cliente 9 compra una tv de 90' 4K a 1.000.000?
compro(kun, 9, producto(tv, 90, "4k") , 1000000).

alguien compro una tv de 90? --> compro (_, producto(tv,90), _) da FALSE porque producto de aridad 2 es distinto. compro (_, producto(tv,90,_), _).

3)
no me interesa producto y hago functor por cada uno: 
compro(fideo, 11, tv(40) , 80000).
pero ... compro(kun, 9, tv(90, "4k") , 1000000).
siguen siendo de distinta aridad tv.

SOLUCION: O TODAS LAS TVs TIENEN ARIDAD 2, O LA TV DEL KUN ES PARTICULAR Y TIENE OTRO NOMBRE DE FUNCTOR
compro(kun, 9, tv4K(90) , 1000000).
compro(fideo, 11, tv(40) , 80000).
Problema: alguien compro una tv de 90? hay que preguntar con tv y tv4k ya que son 2 functores distintos

4)
Se puede agrupar en un functor Cliente, ya que no varia.
Ademas el fideo compro un ventilador
compro(cliente(kun,9),tv4K(90) , 1000000 )
compro(cliente(fideo,11), ventilador, 50000)

Esto no rompe, el 2do parametro puede ser un functor y un individuo

que productos fueron comprados por mas de 100000? --> compro(_,Productos,Precio), Precio > 100000
Producto = ventilador y Producto = tv(40)  , para Prolog todos son productos

5) Repeticion de logica : por cada compra de una misma persona hay que poner cliente(nombre,numero) como primer agumento.
Entonces:
Creo el predicado cliente, y en compra uso el id o nombre

cliente(99102, "Anto")
compro(99102, tv(80), 200000)


que clientes hicieron compras ?  compro(IDCliente, _ , _) ,  cliente (IDCliente, Cliente). (Para saber quien es el ID)
*/
