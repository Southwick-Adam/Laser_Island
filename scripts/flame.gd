extends Node2D

var timer_count = 0

var tile
var permanent = false

func _ready():
	$Particles2D.emitting = true
	$burnTimer.start()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if rng.randf() > 0.85:
		permanent = true

func _on_burnTimer_timeout():
	if timer_count < 1:
		$Particles2D.lifetime = 1.2
	else:
		if not permanent:
			if timer_count == 1:
				$Particles2D.lifetime = 1
			elif timer_count == 2:
				$Particles2D.lifetime = 0.8
			elif timer_count == 3:
				$Particles2D.emitting = false
				$Area2D.monitoring = false
				get_parent()._grey_out(tile)
			elif timer_count == 5:
				queue_free()
	timer_count += 1
