import cv2
import numpy as np
import os

# Load the image
img = cv2.imread('IMG_20230305_123147.jpg')

# Convert the image to grayscale
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# Apply thresholding to binarize the image
ret, thresh = cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)

# Find contours of the characters
contours, hierarchy = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

# Sort contours from left to right
contours = sorted(contours, key=lambda cnt: cv2.boundingRect(cnt)[0])

# Set a counter for naming the saved images
i = 0

# Loop through the contours and save each character as a separate image
for cnt in contours:
    x, y, w, h = cv2.boundingRect(cnt)
    roi = img[y:y+h, x:x+w]
    filename = str(i).zfill(2) + '.png'
    # Check file size before saving
    if cv2.imencode('.png', roi)[1].size >= 5000:
        cv2.imwrite(filename, roi)
    i += 1