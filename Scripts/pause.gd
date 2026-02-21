extends Node

var enemies_found = []

var barcode_buffer: String = ""

enum barcodeState {
	PASUE,
	PLAY
}

var current_state = barcodeState.PLAY
var pending_gamestate: String = ""

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var keycode = event.keycode
		if keycode == KEY_ENTER or keycode == KEY_KP_ENTER:
			if barcode_buffer != "":
				on_barcode_scanned(barcode_buffer)
				barcode_buffer = ""
		else:
			var ch = char(event.unicode)
			if event.unicode > 0:
				barcode_buffer += ch

func on_barcode_scanned(barcode: String) -> void:
	match barcode:
		"06827465": 
			pause_game()
			
		"TowerFive": 
			play_game()


func pause_game():
	current_state = barcodeState.PASUE
	get_tree().paused = true
	print("PAUSE")


func play_game():
	current_state = barcodeState.PLAY
	get_tree().paused = false
	print("PLAY")
