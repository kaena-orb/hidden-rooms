extends Node2D


func _on_house_entered_room(color :  Color = Color("#555555")):
	$CharacterBody2D.enable_interior_lights()
	#var tween = create_tween()
	#tween.tween_property(%CanvasModulate, "color", color, 0.5)
	pass
	#tween.tween_property($DirectionalLight2D, "energy", 0.7, 0.5)
	#$DirectionalLight2D.enabled = true


func _on_house_exited_room():
	$CharacterBody2D.disable_interior_lights()
	#var tween = create_tween()
	#tween.tween_property(%CanvasModulate, "color", Color("#ffffff"), 0.5)
	pass
	#var tween = create_tween()
	#tween.tween_property($DirectionalLight2D, "energy", 0.0, 0.5)
	#tween.finished.connect(func(): $DirectionalLight2D.enabled = false)
