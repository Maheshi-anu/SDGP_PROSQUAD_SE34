from typing import List, Union, Annotated
from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.encoders import jsonable_encoder
from pydantic import BaseModel
from image_process import separate_boxes_and_save_it, take_box_one_by_one_and_save_characters_separately_and_save_it_in_a_text_file
import cv2

app = FastAPI()

# Define a Pydantic model for the main image response
class MainImageResponse(BaseModel):
    image_file_1: str
    image_file_2: str

# End point which receives main image and returns the set of strings for verification purposes 
@app.post("/api/main/image/")
async def process_img(file: UploadFile):
    image_data = await file.read()
    is_write_success = cv2.imwrite('MainImage.png', image_data)
    
    if not is_write_success:
        raise HTTPException(status_code=500, detail="Failed to write image to disk")

    return take_box_one_by_one_and_save_characters_separately_and_save_it_in_a_text_file(separate_boxes_and_save_it("./MainImage.png"))

# Receiving the verified input as a list and returning the answer as two image files 
@app.post("/api/verified/data/", response_model=MainImageResponse)
async def calculate(verified_data: List[str]):
    if len(verified_data) != 2:
        raise HTTPException(status_code=400, detail="Expecting a list of two strings")

    # Perform some calculations on the verified data
    result1 = verified_data[0].upper()
    result2 = verified_data[1].lower()

    # Generate the two image files
    is_success_1 = cv2.imwrite("Result1.png", result1)
    is_success_2 = cv2.imwrite("Result2.png", result2)

    if not (is_success_1 and is_success_2):
        raise HTTPException(status_code=500, detail="Failed to generate image files")

    # Return the image file paths in the response
    return MainImageResponse(image_file_1="Result1.png", image_file_2="Result2.png")

# Add exception handlers to handle various errors that may occur
@app.exception_handler(HTTPException)
async def http_exception_handler(request, exc):
    return JSONResponse(status_code=exc.status_code, content={"message": exc.detail})

@app.exception_handler(Exception)
async def generic_exception_handler(request, exc):
    return JSONResponse(status_code=500, content={"message": "Internal server error"})

# Add documentation to the API using Swagger UI
@app.get("/")
async def read_root():
    return {"Hello": "World"}

app = FastAPI()

# Define a Pydantic model for the main image response
class MainImageResponse(BaseModel):
    image_file_1: str
    image_file_2: str

# End point which receives main image and returns the set of strings for verification purposes 
@app.post("/api/main/image/")
async def process_img(file: UploadFile):
    image_data = await file.read()
    is_write_success = cv2.imwrite('MainImage.png', image_data)
    
    if not is_write_success:
        raise HTTPException(status_code=500, detail="Failed to write image to disk")

    return take_box_one_by_one_and_save_characters_separately_and_save_it_in_a_text_file(separate_boxes_and_save_it("./MainImage.png"))

# Receiving the verified input as a list and returning the answer as two image files 
@app.post("/api/verified/data/", response_model=MainImageResponse)
async def calculate(verified_data: List[str]):
    if len(verified_data) != 2:
        raise HTTPException(status_code=400, detail="Expecting a list of two strings")

    # Perform some calculations on the verified data
    result1 = verified_data[0].upper()
    result2 = verified_data[1].lower()

    # Generate the two image files
    is_success_1 = cv2.imwrite("Result1.png", result1)
    is_success_2 = cv2.imwrite("Result2.png", result2)

    if not (is_success_1 and is_success_2):
        raise HTTPException(status_code=500, detail="Failed to generate image files")

    # Return the image file paths in the response
    return MainImageResponse(image_file_1="Result1.png", image_file_2="Result2.png")

# Add exception handlers to handle various errors that may occur
@app.exception_handler(HTTPException)
async def http_exception_handler(request, exc):
    return JSONResponse(status_code=exc.status_code, content={"message": exc.detail})

@app.exception_handler(Exception)
async def generic_exception_handler(request, exc):
    return JSONResponse(status_code=500, content={"message": "Internal server error"})

# Add documentation to the API using Swagger UI
@app.get("/")
async def read_root():
    return {"Hello": "World"}

