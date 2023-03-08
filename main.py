# import cv2
# import pytesseract
# # pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR'

# #import the image and save the bit code into a variable
# image = cv2.imread('beam load diagram sample.jpeg')


# #preprocess the data
# gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
# thresh = cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)[1]

# #Text region detetction
# contours = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
# contours = contours[0] if len(contours) == 2 else contours[1]

# #Extract the Text Regions: With the text regions detected, you can now extract each region as a separate image. 
# # This can be done by drawing a bounding box around each contour and cropping the image to the bounding box:

# for c in contours:
#     x, y, w, h = cv2.boundingRect(c)
#     text_region = image[y:y+h, x:x+w]
#     cv2.imshow("Text Region", text_region)
#     cv2.waitKey(0)

    


# text = pytesseract.image_to_string(text_region)
# print(text)

import cv2
import numpy as np
import pytesseract

# Load the image
image = cv2.imread("IMG_20230226_143345.jpg") #IMG-20230212-WA0076.jpeg

# Convert the image to the HSV color space
hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)

# Define the range of blue color in HSV space
lower_blue = np.array([100,50,50])
upper_blue = np.array([140,255,255])

# Create a binary image with only blue pixels
mask = cv2.inRange(hsv, lower_blue, upper_blue)

# Apply thresholding to the binary image to create a binary image
thresh = cv2.threshold(mask, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)[1]

# Perform morphological operations to remove noise and fill the boxes
kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (3,3))
thresh = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel, iterations=2)

# Find contours in the binary image
contours = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
contours = contours[0] if len(contours) == 2 else contours[1]

# Iterate through each contour
for i, c in enumerate(contours):
    # Approximate the contour as a polygon
    polygon = cv2.approxPolyDP(c, 0.05 * cv2.arcLength(c, True), True)
    
    # Check if the polygon has 4 sides (indicating a rectangle)
    if len(polygon) == 4:
        x, y, w, h = cv2.boundingRect(polygon)
        
        # Check if the contour has a minimum width and height to be considered a box
        if w > 100 and h > 100:
            text_region = image[y:y+h, x:x+w]
            
            # Save the boxed text as a separate image
            cv2.imwrite("text_{}.png".format(i), text_region)

            # Neglect the blue border of the box by cropping the text region
            text_region = text_region[5:-5, 5:-5]
            
            # # Use tesseract OCR to extract the text from the image
            # text = pytesseract.image_to_string(text_region, lang='eng')
            
            # # Save the extracted text as a string
            # with open("text_{}.txt".format(i), "w") as f:
            #     f.write(text)
