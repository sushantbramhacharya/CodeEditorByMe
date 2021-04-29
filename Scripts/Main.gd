extends Control


var APP_NAME = "Senbu Code Editor"
var file_path = "untitled"
var current_file = file_path


func _ready():
	update_window_title()
	$File.get_popup().connect("id_pressed", self, "_on_fileitem_pressed")
	$Help.get_popup().connect("id_pressed", self, "_on_helpitem_pressed")
	$MAIN.color_syntax()
	

func update_window_title():
	OS.set_window_title(APP_NAME + " - " + current_file)

func new_file():
	current_file = "untitled"
	update_window_title()
	$MAIN.text = ""
	


func _on_fileitem_pressed(id):
	var item_name = $File.get_popup().get_item_id(id)
	match item_name:
		0:new_file()
		1:$openFile.popup()
		2:save_file()
		3:$SAVEAS.popup()



func _on_helpitem_pressed(id):
	var item_name = $Help.get_popup().get_item_id(id)
	var _some_int:int 
	match item_name:
		0:$About.popup()

func _on_OpenFileButton_pressed():
	$openFile.popup()


func _on_SaveAsFileButton_pressed():
	$SAVEAS.popup()


func _on_openFileDialog_file_selected(path: String):
	var f = File.new()
	f.open(path, 1)
	$MAIN.text = f.get_as_text()
	current_file = path.get_file()
	update_window_title()
	f.close()
	


func _on_saveAsFileDialog_file_selected(path: String):
	file_path = path
	save_file()
	
func save_file():
	var path = file_path
	if path == "untitled":
		$SAVEAS.popup()
	else:
		var f = File.new()
		f.open(path, 2)
		f.store_string($MAIN.text)
		file_path = path
		update_window_title()
		f.close()
