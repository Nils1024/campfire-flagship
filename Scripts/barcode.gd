extends Node
@export var code1 : String = "889392021394"
var code2: String = "992-00014-SIF"
var codes_on_reload = []

@onready var codes = {
	"code1":{
		"code": "889392021394",
		"file": $"test-folder/Tower"
	},
	"code2":{
		"code": "198926005800",
		"file": $"test-folder/Tower2"
	},
	"code3":{
		"code": "992-00014-SIF",
		"file": $"test-folder/Tower3"
	},
	"code4":{
		"code": "024100122615",
		"file": $"test-folder/Tower4"
	},
	"code5":{
		"code": "049000050141",
		"file": $"test-folder/Tower5"
	}
}

var barcode_buffer: String = ""


func _ready() -> void:
	$HealthBar.value = GlobalData.health
	$HealthBar.max_value = GlobalData.health

func _physics_process(_delta):
	$roundnum.text = "Round Number: " + str(GlobalData.roundnum)
	$CurrentPoints.text = "Current Points: " + str(GlobalData.points)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var keycode = event.keycode
		if keycode == KEY_ENTER or keycode == KEY_KP_ENTER:
			if barcode_buffer != "":
				on_barcode_scanned(barcode_buffer)
				barcode_buffer = ""
		else:
			# Append the character to the buffer
			var ch = char(event.unicode)
			if event.unicode > 0:
				barcode_buffer += ch

func on_barcode_scanned(barcode: String) -> void:
	for code in codes.values():
		if code["code"] == barcode and not codes_on_reload.has(barcode):
			codes_on_reload.append(barcode)
			spawn_effect(code["file"])
			remove_effect(code["file"])
			await get_tree().create_timer(Shop.reloadtime).timeout
			codes_on_reload.erase(barcode)
			break
	
	await get_tree().create_timer(.01).timeout
	# Do whatever you want with the barcode here
	
func spawn_effect(tower):
	var sprite = tower.get_node("Sprite2D")
	
	var spin_time = 0.3
	var spin_speed = 1500.0 # degrees per second
	
	var elapsed = 0.0
	
	while elapsed < spin_time:
		var delta = get_process_delta_time()
		sprite.rotation_degrees += spin_speed * delta
		elapsed += delta
		await get_tree().process_frame
	
	sprite.rotation_degrees = 0
	
func remove_effect(tower):
	
	
	tower.remove_children()
		

#end of screen
func _on_end_area_area_entered(_area: Area2D) -> void:
	GlobalData.child_count -= 1
	@warning_ignore("narrowing_conversion")
	GlobalData.health -= 1.0
	$HealthBar.value = GlobalData.health
	$HealthBar/HealthLabel.text = "Health = " + str(GlobalData.health)
	if GlobalData.health <= 0.0:
		get_tree().change_scene_to_file("res://game_over.tscn")
		
