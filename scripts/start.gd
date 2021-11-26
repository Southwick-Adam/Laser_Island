extends Node2D

onready var main = get_parent().get_parent()

func _on_key_pressed():
	StoredData.method = "key"
	main._key()
	main._start()
	queue_free()

func _on_touch_pressed():
	StoredData.method = "touch"
	main._start()
	queue_free()
