extends Node2D

onready var player = get_node("/root/main/player")

var sound = true
var music = true

func _ready():
	sound = StoredData.sound
	music = StoredData.music
	_sound()
	_music()

func _change_item(num, image):
	$slots.get_child(num).get_child(1).texture = load(image)

func _erase_item(num):
	$slots.get_child(num).get_child(1).texture = null
	_equip(-1)

func _equip(num):
	if player.ia == num:
		_equip(-1)
	else:
		player.ia = num
		for slot in $slots.get_children():
			slot.get_child(0).self_modulate = Color(0.607843, 0.847059, 0.835294, 0.784314)
		if num >= 0:
			$slots.get_child(num).get_child(0).self_modulate = Color(0.341176, 0.709804, 0.329412, 0.784314)

func _on_slot_1_pressed():
	if player.inventory[0] != null:
		_equip(0)
func _on_slot_2_pressed():
	if player.inventory[1] != null:
		_equip(1)
func _on_slot_3_pressed():
	if player.inventory[2] != null:
		_equip(2)
func _on_slot_4_pressed():
	if player.inventory[3] != null:
		_equip(3)
func _on_slot_5_pressed():
	if player.inventory[4] != null:
		_equip(4)
func _on_slot6_pressed():
	if player.inventory[5] != null:
		_equip(5)
func _on_slot7_pressed():
	if player.inventory[6] != null:
		_equip(6)
func _on_slot8_pressed():
	if player.inventory[7] != null:
		_equip(7)

func _on_sound_pressed():
	sound = !sound
	StoredData.sound = sound
	_sound()

func _sound():
	if sound:
		$sound/icon.texture = load("res://assets/icons/audioOn.png")
		AudioServer.set_bus_mute(1,0)
	else:
		$sound/icon.texture = load("res://assets/icons/audioOff.png")
		AudioServer.set_bus_mute(1,1)
		
func _on_music_pressed():
	music = !music
	StoredData.music = music
	_music()

func _music():
	if music:
		$music/icon.texture = load("res://assets/icons/musicOn.png")
		AudioServer.set_bus_mute(2,0)
	else:
		$music/icon.texture = load("res://assets/icons/musicOff.png")
		AudioServer.set_bus_mute(2,1)

func _on_reload_pressed():
	player._reload()
