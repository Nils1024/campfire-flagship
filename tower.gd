extends Node2D

@onready var children = get_meta("children")
# Called when the node enters the scene tree for the first time.

func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Enemy" and not children.has(body):
		children.append(body)

func _on_area_body_exited(body: Node2D) -> void:
	if body.name == "Enemy" and not children.has(body):
		children.erase(body)
