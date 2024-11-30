extends Node

@onready var total_score: int = 0
@onready var level_score: int = 0
@onready var level: int = 1
@onready var player_died = false
@onready var game_completed = false


@onready var scores_dictionary = {
	"1": 0,
	"2": 0,
	"3": 0,
	"4": 0,
	"5": 0,
	"6": 0,
	"7": 0,
	"8": 0,
	"9": 0,
	"10": 0,
}

func next_level():
	if level < 10:
		level += 1
		print("Moving to level " + str(level))
		level_score = 0
		get_parent().get_node("GameManager").update_score()
	else:
		game_completed= true
		get_parent().get_node("GameManager").game_completed()

func add_token_points(double: bool = false):
	if double:
		level_score += Constants.TOKEN_POINTS * 2
	else:
		level_score += Constants.TOKEN_POINTS
	get_parent().get_node("GameManager").update_score()

func add_level_completion_points(double: bool = false):
	if double:
		scores_dictionary[str(level)] = level_score + Constants.COMPLETION_POINTS * 2
	else:
		scores_dictionary[str(level)] = level_score + Constants.COMPLETION_POINTS

func subtract_death_points():
	if level_score >= Constants.DEATH_POINTS:
		level_score -= Constants.DEATH_POINTS
	elif level_score <= Constants.DEATH_POINTS and level_score >= 0:
		level_score = 0

func get_level_score():
	return level_score

func get_total_score():
	var score = 0
	for i in scores_dictionary.keys():
		score += scores_dictionary[i]
	return score

func clear_scores():
	level_score = 0
	total_score = 0
	scores_dictionary = {
		"1": 0,
		"2": 0,
		"3": 0,
		"4": 0,
		"5": 0,
		"6": 0,
		"7": 0,
		"8": 0,
		"9": 0,
		"10": 0,
	}
