import cv2
import numpy as np
from google.colab.patches import cv2_imshow


def resize_images(img1, img2):
    height1, width1 = img1.shape[:2]
    img2_resized = cv2.resize(img2, (width1, height1))
    return img1, img2_resized

img1 = cv2.imread('/content/drive/My Drive/imagenes/descarga.jpg')
img2 = cv2.imread('/content/drive/My Drive/imagenes/descarga2.jpg')

img1, img2 = resize_images(img1, img2)

alpha = 0.5
beta = 0.5
gamma = 0
weighted_sum = cv2.addWeighted(img1, alpha, img2, beta, gamma)

image_subtract = cv2.subtract(img1, img2)

cv2_imshow(weighted_sum)
cv2_imshow(image_subtract)

cv2.imwrite('suma_ponderada.jpg', weighted_sum)
cv2.imwrite('resta.jpg', image_subtract)
