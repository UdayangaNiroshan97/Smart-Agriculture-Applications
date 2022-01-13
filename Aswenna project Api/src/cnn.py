import itertools
import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf
from keras.applications.resnet50 import ResNet50
from keras.applications.densenet import DenseNet201
from keras.applications.xception import Xception
from keras.applications.vgg16 import VGG16
from keras.applications.inception_resnet_v2 import InceptionResNetV2
from tensorflow.keras.optimizers import Adam
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.python.keras import Model
from tensorflow.python.keras.layers import Dense, Dropout, GlobalAveragePooling2D
from tensorflow.python.keras.models import Sequential

train_path = r'D:\project\aswenna_project\dataset\train'
validation_path = r'D:\project\aswenna_project\dataset\val'
test_path = r'D:\project\aswenna_project\dataset\test'
classess = []

for i in range(3):
    classess.append(str(i))


train_batches = ImageDataGenerator(preprocessing_function=tf.keras.applications.densenet.preprocess_input) \
    .flow_from_directory(directory=train_path, target_size=(224, 224), classes=classess, batch_size=10)

valid_batches = ImageDataGenerator(preprocessing_function=tf.keras.applications.densenet.preprocess_input) \
    .flow_from_directory(directory=validation_path, target_size=(224, 224), classes=classess, batch_size=10)

test_batches = ImageDataGenerator(preprocessing_function=tf.keras.applications.densenet.preprocess_input) \
    .flow_from_directory(directory=test_path, target_size=(224, 224), classes=classess, batch_size=10, shuffle=False)

imgs, labels = next(train_batches)


def plotImages(images_arr):
    fig, axes = plt.subplots(1, 10, figsize=(20, 20))
    axes = axes.flatten()
    for img, ax in zip(images_arr, axes):
        ax.imshow(img)
        ax.axis('off')
    plt.tight_layout()
    plt.show()


plotImages(imgs)
print(labels)


def plot_confusion_matrix(cm, classes, normalize=False, title='Confusion matrix', cmap=plt.cm.Blues):
    plt.imshow(cm, interpolation='nearest', cmap=cmap)
    plt.title(title)
    plt.colorbar()
    tick_marks = np.arange(len(classes))
    plt.xticks(tick_marks, classes, rotation=45)
    plt.yticks(tick_marks, classes)

    if normalize:
        cm = cm.astype('float') / cm.sum(axis=1)[:, np.newaxis]
        print('normlize Confusion matrix')
    else:
        print('Confusion matrix without normalization')

    print(cm)

    thresh = cm.max() / 2.

    for i, j in itertools.product(range(cm.shape[0]), range(cm.shape[1])):
        plt.text(j, i, cm[i, j], horizontalalignment="center", color="white" if cm[i, j] > thresh else "black")

    plt.tight_layout()
    plt.ylabel('True label')
    plt.xlabel('Predicted label')


'''rom tensorflow.keras.applications import EfficientNetB7
modelef = EfficientNetB7(weights='imagenet',include_top=False)
modelef.summary()

from tensorflow.keras import models
from tensorflow.keras import layers

dropout_rate = 0.2
model = models.Sequential()
model.add(modelef)
model.add(layers.GlobalMaxPooling2D(name="gap"))
# model.add(layers.Flatten(name="flatten"))
if dropout_rate > 0:
    model.add(layers.Dropout(dropout_rate, name="dropout_out"))
# model.add(layers.Dense(256, activation='relu', name="fc1"))
model.add(layers.Dense(10, activation="softmax", name="fc_out"))'''

baseModel = Xception(weights='imagenet',include_top=False, input_shape=(224,224,3))
baseModel.summary()

last_layer = baseModel.output

for layer in baseModel.layers:
    layer.trainable = False

# add a global spatial average pooling layer
x = GlobalAveragePooling2D()(last_layer)

# add fully-connected & dropout layers
x = Dense(512, activation='relu',name='fc-1')(x)
x = Dropout(0.5)(x)
x = Dense(256, activation='relu',name='fc-2')(x)
x = Dropout(0.5)(x)

# a softmax layer for 4 classes
num_classes = 3
out = Dense(num_classes, activation='softmax',name='output_layer')(x)

pest_disease_resnet_model = Model(inputs=baseModel.input, outputs=out)
pest_disease_resnet_model.summary()


#for layer in baseModel.layers:
#    layer.trainable = False'''

'''vgg16_model = tf.keras.applications.vgg16.VGG16()
vgg16_model.summary()

model = Sequential()
for layer in vgg16_model.layers[:-1]:
    model.add(layer)

model.summary()
for layer in model.layers:
    layer.trainable =False

model.add(Dense(units=10,activation='softmax'))
model.summary()'''

'''baseModel = DenseNet201(weights='imagenet', include_top=False, input_shape=(224, 224, 3))
baseModel.summary()

for layer in baseModel.layers:
    layer.trainable = False

last_layer = baseModel.output

# add a global spatial average pooling layer
x = GlobalAveragePooling2D()(last_layer)

# add fully-connected & dropout layers
x = Dense(512, activation='relu', name='fc-1')(x)
x = Dropout(0.5)(x)
x = Dense(256, activation='relu', name='fc-2')(x)
x = Dropout(0.5)(x)

# a softmax layer for 40 classes
num_classes = 48
out = Dense(num_classes, activation='softmax', name='output_layer')(x)

pest_disease_resnet_model = Model(inputs=baseModel.input, outputs=out)
pest_disease_resnet_model.summary()'''

'''baseModel = Xception(weights='imagenet',include_top=False,input_shape=(150,150,3))
baseModel.summary()

#for layer in baseModel.layers:
#    layer.trainable =False

last_layer = baseModel.output

# add a global spatial average pooling layer
x = GlobalAveragePooling2D()(last_layer)

# add fully-connected & dropout layers
x = Dense(512, activation='relu',name='fc-1')(x)
x = Dropout(0.5)(x)
x = Dense(256, activation='relu',name='fc-2')(x)
x = Dropout(0.5)(x)

# a softmax layer for 4 classes
num_classes = 10
out = Dense(num_classes, activation='softmax',name='output_layer')(x)

pest_disease_resnet_model = Model(inputs=baseModel.input, outputs=out)
pest_disease_resnet_model.summary()'''

'''baseModel = InceptionResNetV2(weights='imagenet',include_top=False,input_shape=(150,150,3))
baseModel.summary()

for layer in baseModel.layers:
    layer.trainable =False

last_layer = baseModel.output

# add a global spatial average pooling layer
x = GlobalAveragePooling2D()(last_layer)

# add fully-connected & dropout layers
x = Dense(512, activation='relu',name='fc-1')(x)
x = Dropout(0.5)(x)
x = Dense(256, activation='relu',name='fc-2')(x)
x = Dropout(0.5)(x)

# a softmax layer for 4 classes
num_classes = 10
out = Dense(num_classes, activation='softmax',name='output_layer')(x)

pest_disease_resnet_model = Model(inputs=baseModel.input, outputs=out)
pest_disease_resnet_model.summary()'''

pest_disease_resnet_model.compile(optimizer=Adam(learning_rate=0.0001), loss='categorical_crossentropy',
                                  metrics=['accuracy'])
hist = pest_disease_resnet_model.fit(x=train_batches, steps_per_epoch=len(train_batches),
                                     validation_data=valid_batches,validation_steps=len(valid_batches),
                                     epochs=30, verbose=1)
pest_disease_resnet_model.save(r'D:\project\aswenna_project\model\rrrrrrr_model.h5')

plt.plot(hist.history['accuracy'])
plt.plot(hist.history['val_accuracy'])
plt.title('model accuracy')
plt.ylabel('accuracy')
plt.xlabel('epoch')
plt.legend(['train', 'val'], loc='upper left')
plt.show()

plt.plot(hist.history['loss'])
plt.plot(hist.history['val_loss'])
plt.title('model loss')
plt.ylabel('loss')
plt.xlabel('epoch')
plt.legend(['train', 'val'], loc='upper left')
plt.show()