extends Sprite2D

@onready var game_manager = get_parent().get_parent().get_parent()


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		game_manager.player_hit()
