import pymongo
import sys
from mongo_connect import auth

db = auth()
first_collection = db["first_collection"]
first_collection.drop()
my_object = {"name":"siddiqua","status":"active","dept":"RII"}

x =first_collection.insert_one(my_object)

print(x.inserted_id)
