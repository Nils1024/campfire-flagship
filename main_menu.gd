extends Node2D
var barcode_buffer: String = ""
var animation_debounce

func _ready() -> void:
	animation_debounce = false

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
	if animation_debounce:
		return
	match barcode:
		"StartGame": 
			Keyboard.keyboard_mode = false
			play_animation()
			#await get_tree().create_timer(3).timeout


func _on_button_pressed():
	Keyboard.keyboard_mode = true
	#await get_tree().create_timer(3).timeout
	play_animation()
	
func play_animation():
	animation_debounce = true
	$BG.visible = false
	if $Button:
		$Button.visible = false
		$Button.disabled = true
	if $Node2D/AnimationPlayer:
		$Node2D/AnimationPlayer.play("Start")
		await $Node2D/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://test.tscn")
