import numpy as np
from scipy.sparse import random, csr_matrix
from multiprocessing import Pool

# Crear matrices dispersas de ejemplo
rows, cols = 1000, 1000
density = 0.01

A = random(rows, cols, density=density, format='csr')
B = random(cols, rows, density=density, format='csr')

def multiply_row_by_matrix(row_idx, A, B):
    row = A.getrow(row_idx)
    result_row = row.dot(B).toarray()
    return row_idx, result_row

def parallel_matrix_multiplication(A, B):
    rows = A.shape[0]
    result = np.zeros((rows, B.shape[1]))

    with Pool() as pool:
        results = pool.starmap(multiply_row_by_matrix, [(i, A, B) for i in range(rows)])

    for row_idx, result_row in results:
        result[row_idx, :] = result_row

    return csr_matrix(result)

result = parallel_matrix_multiplication(A, B)

print(result)