import os
os.chdir('C:\\Users\\Hesaru\\Desktop\\SDGP\\Image processing\\')

import os
import cv2
import numpy as np
from sklearn.model_selection import train_test_split
from keras.utils import to_categorical
from keras.models import Sequential
from keras.layers import Conv2D, MaxPooling2D, Flatten, Dense

X = []
y = []
labels = os.listdir('train_2')
for i, label in enumerate(labels):
    for filename in os.listdir(f'train_2/{label}'):
        img = cv2.imread(f'train_2/{label}/{filename}', cv2.IMREAD_GRAYSCALE)
        img = cv2.resize(img, (28, 28))
        X.append(img)
        y.append(i)
X = np.array(X)
y = np.array(y)

X = X.reshape(X.shape[0], 28, 28, 1)
print(X.shape)
y = to_categorical(y)
X_train, X_val, y_train, y_val = train_test_split(X, y, test_size=0.1, random_state=42)

model = Sequential()
model.add(Conv2D(32, kernel_size=(3, 3), activation='relu', input_shape=(28, 28, 1)))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Conv2D(64, kernel_size=(3, 3), activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Flatten())
model.add(Dense(128, activation='relu'))
model.add(Dense(len(labels), activation='softmax'))
model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

#model.save("model_new.h5")
img = cv2.imread(f'00.png', cv2.IMREAD_GRAYSCALE)
print(img)

img = cv2.resize(img, (28, 28))
img = img.reshape(1, 28, 28, 1)
pred = model.predict(img)
letter_idx = np.argmax(pred)
letter = labels[letter_idx]

print(letter)