extends Node

var game = {

	"colors" : {
		"buttons" : "000000",
		"background" : "9f9494",
		"borders" : "ffffff",
	},
	
	"modes" : {
		"blend" : false,
		
		"circular" : {
			"circular_state" : false,
			"circular_radius" : 0
			
		}

	}
	
}

var path = "user://save.txt" # FILE PATH
func save_data():
	var save_file = File.new() # CREATE FILE
	save_file.open(path, File.WRITE) # OPEN IT IN THE PATH AND WRITE IN IT
	var data = {
		"game" : game # TO STORE VAR
	}
	save_file.store_var(data) # STORE
	save_file.close() # CLOSE

# LOAD SYSTEM
func load_data():
	var save_file = File.new() # GO TO THE FILE AGAIN
	if !save_file.file_exists(path): # IF IT DOES NOT EXIST
		return # WE RETURN SO THAT IT WILL BE CREATED
	save_file.open(path, File.READ) # OEN IT IN THE PATH AND READ IT
	var data = save_file.get_var() # CREATE A VAR TO GET THE VAR STORED IN THE FILE
	game = data["game"] # MODIFY THE DATA IN THE DICT
	save_file.close() # CLOSE
