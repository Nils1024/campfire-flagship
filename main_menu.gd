extends Node2D
var barcode_buffer: String = ""


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
		"StartGame": 
			Keyboard.keyboard_mode = false
			$BG.visible = false
			$Button.visible = false
			$Button.disabled = true
			$Node2D/AnimationPlayer.play("Start")
			await $Node2D/AnimationPlayer.animation_finished
			#await get_tree().create_timer(3).timeout
			get_tree().change_scene_to_file("res://test.tscn")


func _on_button_pressed():
	Keyboard.keyboard_mode = true
	$BG.visible = false
	$Button.visible = false
	$Button.disabled = true
	$Node2D/AnimationPlayer.play("Start")
	await $Node2D/AnimationPlayer.animation_finished
	#await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://test.tscn")
