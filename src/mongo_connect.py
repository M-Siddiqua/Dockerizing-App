import pymongo
import os


def auth():
	"""AUTH
	Uses a specific pair of user name and password to connect to a
	Mongo database. The URI method uses a format like:
	mongodb://{username}:{password}@{address}:{port}/?authSource={db}
	The authSource parameter is used to authenticate the user that is
	signing in. If the user has been defined specifically for the 
	database that will be used then provide the database's name as
	the value to this parameter. If the user has been defined in
	Mongo globally then use the 'admin' database as authSource.
	"""
	password=os.environ.get('MONGO_PASSWORD')
	if password==None:
		print("Error: setup password in system envrionment")
		return 0
	
	user    = os.environ.get('MONGO_USERNAME')
	db_name = os.environ.get('MONGO_DB')
	uri     = ( "mongodb://"
			  + user + ":" + password
			  + "@localhost:27017/"
			  + "?authSource=" + db_name )

	client = pymongo.MongoClient( uri )

	db = client[db_name]
	return db
