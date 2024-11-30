extends Control

signal transition(scene)

func _on_play_pressed():
	get_parent().get_parent().transition_scene(Constants.TEST_LEVEL)


func _on_settings_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
