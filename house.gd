extends Node2D

signal entered_room
signal exited_room

func _ready():
	%PreviewCanvas.visible = false
	turn_off_lights()
	%Outside.visible = true
	%room_area.visible = true


func show_room():
	var tween = create_tween()
	turn_on_lights()
	tween.tween_property(%Outside, "modulate", Color("#ffffff00"), 0.5)
	entered_room.emit()

func hide_room():
	var tween = create_tween()
	turn_off_lights()
	tween.tween_property(%Outside, "modulate", Color("#ffffff"), 0.5)
	exited_room.emit()

func turn_off_lights():
	for light in %Lights.get_children():
		if light is Light2D:
			var tween = create_tween()
			tween.tween_property(light, "color", Color(light.color, 0), 2)
			tween.finished.connect(func(): light.enabled = false)

func turn_on_lights():
	for light in %Lights.get_children():
		if light is Light2D:
			var tween = create_tween()
			light.enabled = true
			light.color = Color(light.color, 0)
			tween.tween_property(light, "color", Color(light.color, 1), 2)

func _on_room_area_area_entered(_area):
	show_room()

func _on_room_area_area_exited(_area):
	hide_room()

func _on_room_area_body_entered(_body):
	show_room()

func _on_room_area_body_exited(_body):
	hide_room()
