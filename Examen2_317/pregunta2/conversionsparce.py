# Importar las bibliotecas necesarias
import numpy as np
import plotly.express as px
from PIL import Image
from google.colab import drive

# Montar Google Drive
drive.mount('/content/drive')

# Definir la ruta a la imagen
image_path = '/content/drive/My Drive/imagenes/jirafa.jpg'
image_path2 = '/content/drive/My Drive/imagenes/HombrePalo.jpg'
# Abrir la imagen
imagen = Image.open(image_path)
imagen2 = Image.open(image_path2)
# Convertir la imagen a escala de grises si no lo está
imagen_gr = imagen.convert('L')
imagen_gr2 = imagen2.convert('L')
# Convertir la imagen a una matriz de valores de píxeles
imagen_mat = np.array(list(imagen_gr.getdata(band=0)), float)
imagen_mat2 = np.array(list(imagen_gr2.getdata(band=0)), float)

print(imagen_mat,imagen_mat2)

# Ajustar la forma de la matriz para que coincida con la resolución de la imagen
imagen_mat.shape = (imagen_gr.size[1], imagen_gr.size[0])
imagen_mat2.shape = (imagen_gr2.size[1], imagen_gr2.size[0])

print(imagen_mat,imagen_mat2)

# Verificar la forma de la matriz
print(imagen_mat.shape,imagen_mat2.shape)

# Mostrar la imagen usando plotly.express
#fig = px.imshow(imagen_mat, color_continuous_scale='gray')
fig = px.imshow(imagen_mat2, color_continuous_scale='gray')
fig.show()
