extends Node

var keyboard_mode := true

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


func toggle_mode():
	keyboard_mode = !keyboard_mode
	print("Keyboard Mode:", keyboard_mode)


func _input(event):
	if not keyboard_mode:
		return
	
	if not (event is InputEventKey and event.pressed):
		return
	
	match event.keycode:
		KEY_1: trigger_tower("code1")
		KEY_2: trigger_tower("code2")
		KEY_3: trigger_tower("code3")
		KEY_4: trigger_tower("code4")
		KEY_5: trigger_tower("code5")
		KEY_F10: toggle_mode()


func trigger_tower(code_name: String):
	var barcode_script = get_tree().get_first_node_in_group("BarcodeManager")
	if barcode_script:
		var code_data = barcode_script.codes[code_name]
		barcode_script.spawn_effect(code_data["file"])
		barcode_script.remove_effect(code_data["file"])
