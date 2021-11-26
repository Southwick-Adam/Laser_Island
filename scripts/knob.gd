extends Node2D

var move = false
var angle = 0
var pad_size = 85

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $TouchScreenButton.is_pressed():
			var knob_pos_dif = global_position - event.position
			if knob_pos_dif.length() <= 250:
				angle = atan2(knob_pos_dif.y,knob_pos_dif.x)
				if knob_pos_dif.length() <= pad_size:
					$knob.global_position = event.position
				else:
					$knob.position = Vector2(-cos(angle),-sin(angle)) * pad_size
				if knob_pos_dif.length() > 30:#NULL ZONE
					move = true
				else:
					move = false
		else:
			$knob.position = Vector2(0,0)
			move = false
