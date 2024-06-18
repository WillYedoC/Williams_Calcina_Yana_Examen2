import numpy as np
import scipy.sparse as sp

n_rows, n_cols = 1000, 1000  # tamaño de las matrices

density = 0.01

# Matriz A
A = sp.random(n_rows, n_cols, density=density, format='csr')

# Matriz B
B = sp.random(n_cols, n_rows, density=density, format='csr')

# Multiplicación de matrices dispersas
C = A.dot(B)

# Mostrar el tipo de matriz resultante y algunas estadísticas
print(f'Tipo de la matriz resultante: {type(C)}')
print(f'Forma de la matriz resultante: {C.shape}')
print(f'Número de elementos no cero en la matriz resultante: {C.nnz}')
