#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Guillermo Herrera
"""

"""
Este comando es para poder utilizar todas las funciones que se encuentran en el archivo  mis_funciones_tarea_2.py
Este archivo Tarea_2.py y mis_funciones_tarea_2.py deben estar en la misma carpeta
"""

"""
En esta sección se hacen ejemplos de la funcion suma_Gauss(n)
Pedes ver que la función regresa un valor
"""
import mis_funciones_tarea_2 as mf
print("\nEjemplos de la funcion suma_Gauss(n)")
# primer ejemplo
# se asigna un valor a n
n = 5
# se ejecuta la función con dicho valor
a = mf.suma_Gauss(n)
# se imprime el valor regresado, debe ser 15 pues 1+2+3+4+5=15
print(a)
# segundo ejemplo
# en este caso se imprime directamente el valor regresado por la función evaluada en 10
# debe ser 55 pues 1+2+3+4+5+6+7+8+9+10=55
print(mf.suma_Gauss(10))


"""
En esta sección se hacen ejemplos de la funcion primer_elemento_ultimo_elemento(lista)
Pedes ver que la función regresa ambos valores
"""
print("\nEjemplos de la funcion primer_elemento_ultimo_elemento(lista)")
# primer ejemplo
# se crea una lista
lista = [1, 2, 3, 4, 5, 6]
# se ejecuta la función en dicha lista
a, b = mf.primer_elemento_ultimo_elemento(lista)
# se imprimen los valores regresados por la función
print(a, b)
# segundo ejemplo
lista = ["esta", "es", "una", "lista"]
a, b = mf.primer_elemento_ultimo_elemento(lista)
print(a, b)
# tercer ejemplo
# en este caso se asigna a la variable x ambos valores que regresa la función
lista = [1, 2, 3, 4, 5, 6]
x = mf.primer_elemento_ultimo_elemento(lista)
print(x)


"""
A partir de aquí deben crear y hacer ejemplos del uso de las funciones
todas las funciones y ejemplos deben estar comentados
"""

"""
En esta sección se hacen ejemplos de la funcion lista_k_multiplos_de_n(n,k)
"""
print("\nEjemplos de la funcion lista_k_multiplos_de_n(n,k)")
# primer ejemplo
n = 1
k = 5
lista = mf.lista_k_multiplos_de_n(n, k)
print(lista)
# segundo ejemplo
n = 5
lista = mf.lista_k_multiplos_de_n(n, n*n)
print(lista)
# tercer ejemplo
lista = [1, 2, 3, 4, 5, 6]
a, b = mf.primer_elemento_ultimo_elemento(lista)
lista = mf.lista_k_multiplos_de_n(a, b)
print(lista)

"""
En esta sección se hacen ejemplos de la funcion Promedio(lista)
"""
print("\nEjemplos de la funcion Promedio(lista)")
# primer ejemplo
lista = [1, 2, 3, 4, 5, 6]
promedio = mf.Promedio(lista)
print(promedio)
# segundo ejemplo
lista = [1, 2, 3, 4, 5, 6, 20]
promedio = mf.Promedio(mf.primer_elemento_ultimo_elemento(lista))
print(promedio)
# tercer ejemplo
promedio = mf.Promedio(mf.lista_k_multiplos_de_n(2, 20))
print(promedio)


"""
En esta sección se hacen ejemplos de la funcion Maximo(lista)
"""
print("\nEjemplos de la funcion Maximo(lista)")

# primer ejemplo
lista = [1, 2, 3, 4, 5, 6, 20]
maximo = mf.Maximo(lista)
print(maximo)

# segundo ejemplo
lista = [1, 2, 20, 20, 20, 6, 20]
maximo = mf.Maximo(lista)
print(maximo)
# tercer ejemplo
lista = mf.lista_k_multiplos_de_n(2, 20)
maximo = mf.Maximo(lista)
print(maximo)
"""
En esta sección se hacen ejemplos de la funcion Fib(n)
"""
print("\nEjemplos de la funcion Fib(n)")

# primer ejemplo
print(mf.Fib(6))
# segundo ejemplo
lista = [1, 2, 20, 20, 20, 6, 20]
print(mf.Fib(max(lista)))
# tercer ejemplo

print(mf.Fib(int(mf.Promedio(mf.lista_k_multiplos_de_n(2, 20)))))
