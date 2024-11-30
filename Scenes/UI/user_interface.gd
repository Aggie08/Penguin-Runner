extends Control


@onready var token_one = $MarginContainer/HBoxContainer/HBoxContainer/HealthToken
@onready var token_two = $MarginContainer/HBoxContainer/HBoxContainer/HealthToken2

@onready var score = $MarginContainer/HBoxContainer/Score
@onready var timer = $Timer

signal player_died
 

func edit_score(text: String):
	score.text = text

func remove_health_token():
	if !token_one.is_visible() && token_two.is_visible() && timer.is_stopped():
		token_two.hide()
	elif token_one.is_visible() && timer.is_stopped():
		token_one.hide()
	
	#TODO: Add signal once finished with handling of player death
	if !token_one.is_visible() && !token_two.is_visible() && timer.is_stopped():
#		player_died.emit()
		print("player dead")
	
	timer.start(3)

func _on_home_pressed():
	get_parent().get_parent().transition_scene(Constants.MAIN_MENU)
	hide()
