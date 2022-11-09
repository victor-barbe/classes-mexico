#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Guillermo Herrera
"""


# este archivo no es necesario ejecutar, solo debe incluir las funciones


"""
Esta función toma como entrada un número natural y regresa la suma desde 1 hasta n
"""


def suma_Gauss(n):
    valor = (n*(n+1))/2
    return valor


"""
Esta función toma como entrada una lista y regresa el primer elemento de la lista y el último elemento de ella. 
"""


def primer_elemento_ultimo_elemento(lista):
    primer_elemento = lista[0]
    ultimo_elemento = lista[len(lista)-1]
    return primer_elemento, ultimo_elemento


"""
Esta función toma como parámetro el múltiplo n y la dimensión de la lista k.
Crea una lista (dinámica) y la llena con un bucle de 0 a k. 
Gracias a la función "append" asocia a lista[i] cada múltiplo de n menor que k.
Return lista
"""


def lista_k_multiplos_de_n(n, k):
    lista = []
    for i in range(k):
        lista.append(n*(i+1))
    return lista


"""
Esta función devuelve la media de los valores de la lista pasada como parámetro. 
La función es sencilla: suma de los valores contenidos en la lista dividida por su tamaño. 
Se devuelve el Promedio. 
"""


def Promedio(list):
    promedio = sum(list)/len(list)
    return promedio


"""
Ejercicio 
"""

"""
Esta función toma una lista como parámetro. 
La función max encuentra el valor máximo de esta lista. A continuación, recorremos la lista hasta encontrar este valor máximo. 
Tomamos el índice y dejamos de escanear la lista: hemos encontrado la primera aparición del valor máximo en la lista. 
A continuación, devolvemos los dos valores. 
"""


def Maximo(list):
    maximo = max(list)
    for i in list:
        if(i == maximo):
            posićion = list.index(i)
            break

    return maximo, posićion


"""
Ejercicio
"""

"""
Esta función devuelve la lista de los primeros n elementos de la secuencia de Fibonacci. 
Los dos primeros elementos de la secuencia son siempre 1.
Los siguientes elementos se calculan en función de sus predecesores: n depende de la suma de (n-1) y (n-2)
Añadimos cada valor a la lista y devolvemos la lista
"""


def Fib(n):
    fib = []

    for i in range(n):
        if(i == 0):
            fib.append(1)
        elif(i == 1):
            fib.append(1)
        else:
            fib.append(fib[i-1] + fib[i-2])

    return fib


"""
Ejercicio
"""
