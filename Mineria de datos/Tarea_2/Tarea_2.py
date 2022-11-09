#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Guillermo Herrera
"""

"""
Este comando es para poder utilizar todas las funciones que se encuentran en el archivo  mis_funciones_tarea_2.py
Este archivo Tarea_2.py y mis_funciones_tarea_2.py deben estar en la misma carpeta
"""
import mis_funciones_tarea_2 as mf

"""
En esta sección se hacen ejemplos de la funcion suma_Gauss(n)
Pedes ver que la función regresa un valor
"""
print("\nEjemplos de la funcion suma_Gauss(n)")
#primer ejemplo
#se asigna un valor a n
n=5
#se ejecuta la función con dicho valor
a=mf.suma_Gauss(n)
#se imprime el valor regresado, debe ser 15 pues 1+2+3+4+5=15
print(a)
#segundo ejemplo
#en este caso se imprime directamente el valor regresado por la función evaluada en 10
#debe ser 55 pues 1+2+3+4+5+6+7+8+9+10=55
print(mf.suma_Gauss(10))


"""
En esta sección se hacen ejemplos de la funcion primer_elemento_ultimo_elemento(lista)
Pedes ver que la función regresa ambos valores
"""
print("\nEjemplos de la funcion primer_elemento_ultimo_elemento(lista)")
#primer ejemplo
#se crea una lista
lista=[1,2,3,4,5,6]
#se ejecuta la función en dicha lista
a,b=mf.primer_elemento_ultimo_elemento(lista)
#se imprimen los valores regresados por la función
print(a,b)
#segundo ejemplo
lista=["esta", "es", "una", "lista"]
a,b=mf.primer_elemento_ultimo_elemento(lista)
print(a,b)
#tercer ejemplo
#en este caso se asigna a la variable x ambos valores que regresa la función
lista=[1,2,3,4,5,6]
x=mf.primer_elemento_ultimo_elemento(lista)
print(x)


"""
A partir de aquí deben crear y hacer ejemplos del uso de las funciones
todas las funciones y ejemplos deben estar comentados
"""

"""
En esta sección se hacen ejemplos de la funcion lista_k_multiplos_de_n(n,k)
"""
print("\nEjemplos de la funcion lista_k_multiplos_de_n(n,k)")
#primer ejemplo

#segundo ejemplo

#tercer ejemplo




"""
En esta sección se hacen ejemplos de la funcion Promedio(lista)
"""
print("\nEjemplos de la funcion Promedio(lista)")
#primer ejemplo

#segundo ejemplo

#tercer ejemplo






"""
En esta sección se hacen ejemplos de la funcion Maximo(lista)
"""
print("\nEjemplos de la funcion Maximo(lista)")

#primer ejemplo

#segundo ejemplo

#tercer ejemplo






"""
En esta sección se hacen ejemplos de la funcion Fib(n)
"""
print("\nEjemplos de la funcion Fib(n)")

#primer ejemplo

#segundo ejemplo

#tercer ejemplo






















