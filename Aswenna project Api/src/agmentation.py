import os
from keras.preprocessing.image import ImageDataGenerator, load_img, img_to_array

datagen = ImageDataGenerator(
        rotation_range=40,
        zoom_range=0.2,
        horizontal_flip=True,
        brightness_range=(0.5, 1.5),
        shear_range=0.2,)

for k in range(10):
    path = "D:/test/" + str(k)+"/"
    images= os.listdir(path)
    i = 0
    print(k)
    for w in range(len(images)):
        imge_path = path + images[w]
        try:
            img = load_img(imge_path)
            # Converting the input sample image to an array
            x = img_to_array(img)
            # Reshaping the input image
            x = x.reshape((1,) + x.shape)

            # Generating and saving 5 augmented samples
            # using the above defined parameters.
            i = 0
            for batch in datagen.flow(x, batch_size=1,
                                      save_to_dir=path,
                                      save_prefix='image', save_format='jpg'):
                i += 1
                if i > 5:
                    break
        except:
            continue


'''datagen = ImageDataGenerator(
        rotation_range=40,
        zoom_range=0.2,
        horizontal_flip=True,
        brightness_range=(0.5, 1.5),
        shear_range=0.2,)

classess = ['BA','HA','MP','SE','SL','TP','TU','ZC']

for k in classess:
        path = "D:/project/dataset/tomato/dataset_agmentaion/test/" + k+"/"
        images= os.listdir(path)
        i = 0
        print(k)
        for w in range(len(images)):
            imge_path = path + images[w]
            img = load_img(imge_path)
            # Converting the input sample image to an array
            x = img_to_array(img)
            # Reshaping the input image
            x = x.reshape((1,) + x.shape)

            # Generating and saving 5 augmented samples
            # using the above defined parameters.
            i = 0
            for batch in datagen.flow(x, batch_size=1,
                                      save_to_dir=path,
                                      save_prefix='image', save_format='jpg'):
                i += 1
                if i > 5:
                    break'''






