extends Node2D



func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		ScoreService.add_level_completion_points()
		get_parent().get_parent().get_parent().transition_to_status_page()
