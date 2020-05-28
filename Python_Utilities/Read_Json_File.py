
import json

from _io import open
from coverage.python import os



def read_Json(filepath):
    print(os.getcwd())
    fileJson= open(filepath,'r') 
    Content=fileJson.read()
    json_content=json.loads(Content)
    return  json_content
