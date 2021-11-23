extends Node2D

const SPEED = 120
const ACCELERATION = 0.4
var velocity = Vector2()
var scal = 2

var act_obj = null
var ia = -1
var inventory = [null,null,null,null,null,null,null,null]

var strong = false
var dig_sites = 2

onready var UI = get_node("/root/main/UI/UI")
onready var hints = get_node("/root/main/UI/hints")

func _animate(anim):
	if $AnimationPlayer.current_animation != anim:
		$AnimationPlayer.play(anim)

func _process(_delta):
	if Input.is_action_pressed("ui_up"):
		velocity.y = lerp(velocity.y, -SPEED, ACCELERATION)
	elif Input.is_action_pressed("ui_down"):
		velocity.y = lerp(velocity.y, SPEED, ACCELERATION)
	else:
		velocity.y = lerp(velocity.y, 0, ACCELERATION)
	if Input.is_action_pressed("ui_left"):
		$body/Sprite.scale.x = -scal
		velocity.x = lerp(velocity.x, -SPEED, ACCELERATION)
	elif Input.is_action_pressed("ui_right"):
		$body/Sprite.scale.x = scal
		velocity.x = lerp(velocity.x, SPEED, ACCELERATION)
	else:
		velocity.x = lerp(velocity.x, 0, ACCELERATION)
	velocity = $body.move_and_slide(velocity, Vector2(0,-1))
#Animations
	if abs(velocity.x) > 70 or abs(velocity.y) > 70:
		_animate("run")
	else:
		_animate("idle")
#METAL
	if inventory[ia] == "detector":
		hints._write(str(dig_sites) + " more dig sites detected")
		var dig2 = get_node("/root/main/digs/dig2")
		var cave_dig = get_node("/root/main/digs/cave_dig")
		var dig_pos = dig2.global_position
		var cave_dig_pos = cave_dig.global_position
		if ($body.global_position - dig_pos).length() < 85 and not dig2.activated:
			dig2._activate()
			dig_sites -= 1
		if ($body.global_position - cave_dig_pos).length() < 85 and not cave_dig.activated:
			cave_dig._activate()
			dig_sites -= 1

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if act_obj != null and act_obj.takeable:
			act_obj._act()
	if event.is_action_pressed("r"):
		AudioServer.set_bus_mute(0,1)
		$CanvasLayer/cover.visible = true
		$CanvasLayer/Timer.start()

func _on_Timer_timeout():
	get_tree().reload_current_scene()

func _death():
	hints._write("oof...")
	set_process(false)
	_animate("death")

func _on_Area2D_body_entered(body):
	if body.is_in_group("item"):
		if body.get_parent().takeable:
			act_obj = body.get_parent()

func _on_Area2D_body_exited(body):
	if body.get_parent() == act_obj:
		act_obj = null

func _pickup(itema, image):
	var n = 0
	while n < 8:
		if inventory[n] == null:
			inventory[n] = itema
			UI._change_item(n, image)
			UI._equip(n)
			break
		n += 1

func _erase():
	inventory[ia] = null
	UI._erase_item(ia)
