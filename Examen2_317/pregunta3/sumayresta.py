import cv2
import numpy as np
from google.colab.patches import cv2_imshow


# Función para redimensionar imágenes al mismo tamaño
def resize_images(img1, img2):
    # Obtener dimensiones de la primera imagen
    height1, width1 = img1.shape[:2]
    # Redimensionar la segunda imagen al tamaño de la primera
    img2_resized = cv2.resize(img2, (width1, height1))
    return img1, img2_resized

# Cargar las imágenes
# Asegúrate de que las imágenes estén en el directorio de trabajo o proporciona la ruta completa
img1 = cv2.imread('/content/drive/My Drive/imagenes/descarga.jpg')
img2 = cv2.imread('/content/drive/My Drive/imagenes/descarga2.jpg')

# Redimensionar las imágenes al mismo tamaño
img1, img2 = resize_images(img1, img2)

# Suma ponderada de las imágenes
alpha = 0.5
beta = 0.5
gamma = 0
weighted_sum = cv2.addWeighted(img1, alpha, img2, beta, gamma)

# Resta de las imágenes
image_subtract = cv2.subtract(img1, img2)

# Mostrar las imágenes resultantes
cv2_imshow(weighted_sum)
cv2_imshow(image_subtract)

# Opcional: guardar las imágenes resultantes
cv2.imwrite('suma_ponderada.jpg', weighted_sum)
cv2.imwrite('resta.jpg', image_subtract)
