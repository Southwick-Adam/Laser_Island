extends Node2D

export (PackedScene) var WE

func _ready():
	if StoredData.method != null:
		$UI/start.queue_free()
		_start()
	if StoredData.method == "key":
		_key()
		
func _key():
	$knob.queue_free()
	for node in get_tree().get_nodes_in_group("touch"):
		node.queue_free()
	var node = WE.instance()
	call_deferred("add_child", node)

func _start():
	$world._start()
	$player._start()
