extends Node2D

signal entered_room
signal exited_room

var light_tweens : Dictionary
var canvas_final_color : Color
var canvas_initial_color : Color = Color.WHITE

func _ready():
	canvas_final_color = %DummyCanvas.color
	%DummyCanvas.color = canvas_initial_color
	$Outside.visible = true
	%room_area.visible = true
	$DummyBackground.visible = false


func show_room():
	for tween in light_tweens:
		light_tweens[tween].stop()
		light_tweens[tween].kill()
	var tween = create_tween()
	tween.set_parallel(true)
	turn_on_lights(true)
	tween.tween_property(%DummyCanvas, "color", canvas_final_color, 0.5)
	tween.tween_property(%Outside, "modulate", Color("#ffffff00"), 0.5)
	light_tweens.set(tween.get_instance_id(), tween)
	entered_room.emit(%DummyCanvas.color)
	%DummyCanvas.visible = true

func hide_room():
	var tween_duration = 0.5
	for tween in light_tweens:
		light_tweens[tween].stop()
		light_tweens[tween].kill()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(%DummyCanvas, "color", canvas_initial_color, tween_duration)
	tween.tween_property(%Outside, "modulate", Color("#ffffff"), tween_duration)
	light_tweens.set(tween.get_instance_id(), tween)
	exited_room.emit()

	tween.finished.connect(func(): %DummyCanvas.visible = false)

func turn_off_lights(immediate : bool = false):
	var tween_duration := 2.0
	if immediate:
		tween_duration = 0

	for light in %Lights.get_children():
		if light is Light2D:
			var tween = create_tween()
			light_tweens.set(tween.get_instance_id(), tween)
			tween.tween_property(light, "color", Color(light.color, 0), tween_duration)
			tween.finished.connect(func(): light.enabled = false)

func turn_on_lights(immediate : bool = false):
	var tween_duration := 2.0
	if immediate:
		tween_duration = 0
	for light in %Lights.get_children():
		if light is Light2D:
			var tween = create_tween()
			light_tweens.set(tween.get_instance_id(), tween)
			light.enabled = true
			light.color = Color(light.color, 0)
			tween.tween_property(light, "color", Color(light.color, 1), tween_duration)

func _on_room_area_area_entered(_area):
	show_room()

func _on_room_area_area_exited(_area):
	hide_room()

func _on_room_area_body_entered(_body):
	show_room()

func _on_room_area_body_exited(_body):
	hide_room()
