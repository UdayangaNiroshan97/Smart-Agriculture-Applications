import itertools
import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf
from keras.applications.densenet import DenseNet201
from tensorflow.keras.optimizers import Adam
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.python.keras import Model
from tensorflow.python.keras.layers import Dense, Dropout, GlobalAveragePooling2D

train_path = r'D:\project\aswenna_project\dataset\train'
validation_path = r'D:\project\aswenna_project\dataset\val'
test_path = r'D:\project\aswenna_project\dataset\test'
classess = []

for i in range(48):
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



baseModel = DenseNet201(weights='imagenet', include_top=False, input_shape=(224, 224, 3))
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

# a softmax layer for 48 classes
num_classes = 48
out = Dense(num_classes, activation='softmax', name='output_layer')(x)

pest_disease_resnet_model = Model(inputs=baseModel.input, outputs=out)
pest_disease_resnet_model.summary()



pest_disease_resnet_model.compile(optimizer=Adam(learning_rate=0.0001), loss='categorical_crossentropy',
                                  metrics=['accuracy'])
hist = pest_disease_resnet_model.fit(x=train_batches, steps_per_epoch=len(train_batches),
                                     validation_data=valid_batches,validation_steps=len(valid_batches),
                                     epochs=30, verbose=1)
pest_disease_resnet_model.save(r'D:\project\aswenna_project\model\pest_model.h5')

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