extends Node
@export var code1 : String = "889392021394"
var code2: String = "992-00014-SIF"

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
#effect,explosion,actual effect
signal areaBodyEntered

func _ready() -> void:
	print(codes["code1"])

func _physics_process(delta):
	$roundnum.text = str(GlobalData.roundnum)

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
		if code["code"] == barcode:
			spawn_effect(code["file"])
			remove_effect(code["file"])
			break
	
	$Label.text = "Scanned Code: %s" %barcode
	await get_tree().create_timer(.01).timeout
	# Do whatever you want with the barcode here
	
func spawn_effect(effect):
	var color_rect = effect.get_node("ColorRect")
	var original_color = color_rect.color
	color_rect.color = "Black"
	await get_tree().create_timer(.2).timeout #await animation end insteadd
	color_rect.color = original_color
	
func remove_effect(tower):
	tower.remove_children()
		


func _on_end_area_area_entered(area: Area2D) -> void:
	GlobalData.child_count -= 1
