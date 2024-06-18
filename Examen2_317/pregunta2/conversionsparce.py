import numpy as np
import scipy.sparse as sp
import cv2
from google.colab import drive

drive.mount('/content/drive')

image_path1 = '/content/drive/My Drive/imagenes/jirafa.jpg'
image_path2 = '/content/drive/My Drive/imagenes/HombrePalo.jpg'

img1 = cv2.imread(image_path1)
img2 = cv2.imread(image_path2)

img1_gray = cv2.cvtColor(img1, cv2.COLOR_BGR2GRAY)
img2_gray = cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)

m_sparce1 = sp.coo_matrix(img1_gray)
m_sparce2 = sp.coo_matrix(img2_gray)

print("Primera imagen (jirafa):")
print(m_sparce1)
print("Segunda imagen (HombrePalo):")
print(m_sparce2)
