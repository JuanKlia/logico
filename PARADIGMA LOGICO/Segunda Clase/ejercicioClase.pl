%Tenemos los siguientes alumnos nicolas, malena, raul, carlos, santiago.

alumno(nicolas).
alumno(malena).
alumno(raul).         /* 5 clausulas que son HECHOS de un mismo predicado alumno\1 */
alumno(carlos).
alumno(santiago).

/* - Queremos saber:
    - Si nicolas es alumno: ?- alumno(nicolas).
    - Si santiago es alumno: ?- alumno(santiago).
    - Quiénes son alumnos: ?- alumno(Alumno).
    - Si tenemos algún alumno: ?- alumno(_).
*/



% Tenemos las materias y sus anios - algoritmos, analisis1 (1ro) y pdep, sintaxis (2do)
materia(algoritmos, 1).
materia(analisis1, 1).
materia(pdep, 2).
materia(sintaxis, 2).
% La resolucion primero (algoritmos) no esta mal, pero solo me permite utilizar la materias ya que el año es el predicado en si
 /*- Queremos saber
   - Si algoritmos está en 2do: ?- materia(algoritmos, 2).
   - En qué año está algoritmos: ?- materia(algoritmos, Año).
   - Cuáles son las materias de 2do: ?- materia(Materia, 2).
- Materias de toda la carrera: ?- materia(Materia, Año).  materia (Materia, _) si no me interesa el año y solo quiero las materias
- Cuales son los anios/niveles de la facu ? - materia(_, Año).
*/


/*-Además de cada alumno conocemos la nota promedio de cada materia
- nicolas pdep 10
- nicolas proba 7
- nicolas sintaxis 8
- malena pdep 6
- raul pdep 9
*/
nota(nicolas, pdep, 10).
nota(nicolas, proba, 7).
nota(nicolas, sintaxis, 8).
nota(malena, pdep, 6).
nota(malena, laDesaprobada, 4).
nota(raul, pdep, 9).

/*
 -Las notas de nicolas : nota(nicolas, _ , Nota) si solo quiero las notas, nota(nicolas, Materia, Nota)

 -Si rindió algún examen nico, pero en realidad podría ser cualquier alumno (si tiene alguna nota): 
   nota(nicolas, _, _) (no interesa la materia ni la nota) pero te piden generalizar para todos los alumnos
   rindio (Alumno) :- nota(Alumno, _, _) (cuando el alumno tiene una nota)

 - Que materias aprobo malena? queremos hacer esta tarea con diferentes alumnos
   
   aprobo (Alumno, Materia):- 
            nota(Alumno, Materia, Nota),    
            Nota>6.

- Esta al principio de la carrera si aun NO RINDIO ningun examen
 estaAlPrincipio (Alumno) :- not (rindio(Alumno))  NO ES INVERSIBLE

 estaAlPrincio (Alumno) : -
        alumno (Alumno),    se soluciona restringiendo
        not(rindio(Alumno)). 


*/

rindio(Alumno) :- 
    nota(Alumno, _, _). %(cuando el alumno tiene una nota)

aprobo(Alumno, Materia):- 
        nota(Alumno, Materia, Nota),    
        Nota>6.
estaAlPrincipio(Alumno) :- 
    alumno(Alumno),
    not(rindio(Alumno)).


% Un alumno aprobo un año cuando aprobo TODAS las materias de ese año:  1. Materias de un año, 2. aprobo materia?

/*aproboAnio(Alumno,Anio) :-
        materia(Materia,Anio),
        aprobo(Alumno, Materia). %Son consultas EXISTENCIALES, con que apruebe una materia de ese año ya da true
        %Por default el motor es un ANY, un existe. 
*/  

anio(Anio):- materia(_, Anio). %generador expresivo, que valida que los anios que se generen tengan que ver con las materias

aproboAnio(Alumno, Anio):-
   alumno(Alumno),  %los generadores de la inversibilidad fuera del forall
   anio(Anio),
   forall(
      materia(Materia, Anio),
      aprobo(Alumno, Materia)
   ).
    