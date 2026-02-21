extends Node2D

var spawn_queue = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add()
	add()
	add()
	add()
	add()
	add()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not spawn_queue.is_empty():
		var enemy = spawn_queue.pop_front()
		var path_follow_node = PathFollow2D.new()
		path_follow_node.add_child(enemy)
		var animation_player_copy = $AnimationPlayer.duplicate()
		path_follow_node.add_child(animation_player_copy)
		$Path2D.add_child(path_follow_node)
		animation_player_copy.play("Walk")

func add():
	var test = Label.new()
	test.text = "Enemy"
	spawn_queue.append(test)
