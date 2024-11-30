extends Sprite2D

@onready var animPlayer = $AnimationPlayer

@export var points = 1

signal token_retrieved

var player

func _ready():
	animPlayer.play("Idle")


func _on_area_2d_body_entered(body):
	#Add a point to the level score
	if body is CharacterBody2D:
		ScoreService.add_token_points()
	self.queue_free()
