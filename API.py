from typing import Union, Annotated
from fastapi import FastAPI, File, UploadFile
from fastapi.encoders import jsonable_encoder
from pydantic import BaseModel
from image_process import seperateBoxesAndSaveIt, takeBoxOneByOneAndSaveCharactersSeperatelyAndSaveItInATextFile
import cv2

app = FastAPI()
#End point which recieves main image and return the set of strings for the veryfication purposes
@app.post("/api/main_image/")
async def processImg (file:UploadFile) :
    print(await file.read())
    isWriteSuccess = cv2.imwrite('MainImage.png',file.read(),)
    print("image written to disk")

    if(isWriteSuccess == False)  :
        ## send error erorr  
        return
    
    return takeBoxOneByOneAndSaveCharactersSeperatelyAndSaveItInATextFile(seperateBoxesAndSaveIt("./MainImage.png"))

#Recieving the verified input as an list and return the answer as two image files

@app.post("/api/verified_data/")
async def calculation (file:) :
    return "Working...!"

def calculation(self):
        my_instance = MyClass()
        my_instance.calculation()
        
        class MyClass:
    def calculation(self, x, y):
        # Your code here
        result = x + y
        return result





app = FastAPI()
#End point which receives main image and return the set of strings for the verification purposes 
@app.post("/api/main/image/")
async def processImg (file:UploadFile):
      print(await file.read(),)
      isWriteSuccess = cv2.imwrite('MainImage.png',file.read(),)
      print("image written to disk")

      if (isWriteSuccess == False) :
            ### Send error error
            return
      return takeBoxOneByOneAndSaveCharactersSeperatelyAndSaveItInATextFile(seperateBoxesAndSaveIt("./MainImage.png"))

#Receiving the verified input as an list and return the answer as two image files 

@app.post("/api/verified_data/")
async def calculation (file)
      return "Working...!"

def calculations(self):
      def 
      
            
