extends Control


@onready var level_score = $MarginContainer/VBoxContainer/VBoxContainer/LevelScore
@onready var completion_bonus = $MarginContainer/VBoxContainer/VBoxContainer/CompletionBonus
@onready var total_score = $MarginContainer/VBoxContainer/VBoxContainer/TotalScore
@onready var title = $MarginContainer/VBoxContainer/Title
@onready var button = $MarginContainer/VBoxContainer/ContinueButton

@onready var level_1_score = $MarginContainer/VBoxContainer/VBoxContainer/Level1Score
@onready var level_2_score = $MarginContainer/VBoxContainer/VBoxContainer/Level2Score
@onready var level_3_score = $MarginContainer/VBoxContainer/VBoxContainer/Level3Score
@onready var level_4_score = $MarginContainer/VBoxContainer/VBoxContainer/Level4Score
@onready var level_5_score = $MarginContainer/VBoxContainer/VBoxContainer/Level5Score
@onready var level_6_score = $MarginContainer/VBoxContainer/VBoxContainer/Level6Score
@onready var level_7_score = $MarginContainer/VBoxContainer/VBoxContainer/Level7Score
@onready var level_8_score = $MarginContainer/VBoxContainer/VBoxContainer/Level8Score
@onready var level_9_score = $MarginContainer/VBoxContainer/VBoxContainer/Level9Score
@onready var level_10_score = $MarginContainer/VBoxContainer/VBoxContainer/Level10Score

@onready var game_manager = get_parent().get_parent().get_parent().get_node("GameManager")

# Called when the node enters the scene tree for the first time.
func _ready():
	if ScoreService.player_died:
		display_player_death()
	elif ScoreService.game_completed:
		complete_game()
	else:
		title.text = "Level " + str(ScoreService.level) + " Completed!"
		level_score.text = "Level Score: " + str(ScoreService.get_level_score())
		total_score.text = "Total Score: " + str(ScoreService.get_total_score())
		ScoreService.next_level()
	

func display_player_death():
	completion_bonus.hide()
	button.text = "Exit"
	title.text = "Maybe Next Time"
	level_score.text = "Level Score: " + str(ScoreService.get_level_score())
	total_score.text = "Final Score: " + str(ScoreService.get_total_score())

#Show final results then end the game.
func complete_game():
	title.text = "Run Completed!!!"
	level_score.hide()
	completion_bonus.hide()
	button.text = "Main Menu"
	
	level_1_score.text = "Level 1: " + ScoreService.scores_dictionary[1]
	level_2_score.text = "Level 2: " + ScoreService.scores_dictionary[2]
	level_3_score.text = "Level 3: " + ScoreService.scores_dictionary[3]
	level_4_score.text = "Level 4: " + ScoreService.scores_dictionary[4]
	level_5_score.text = "Level 5: " + ScoreService.scores_dictionary[5]
	level_6_score.text = "Level 6: " + ScoreService.scores_dictionary[6]
	level_7_score.text = "Level 7: " + ScoreService.scores_dictionary[7]
	level_8_score.text = "Level 8: " + ScoreService.scores_dictionary[8]
	level_9_score.text = "Level 9: " + ScoreService.scores_dictionary[9]
	level_10_score.text = "Level 10: " + ScoreService.scores_dictionary[10]
	
	level_1_score.show()
	level_2_score.show() 
	level_3_score.show()
	level_4_score.show()
	level_5_score.show()
	level_6_score.show()
	level_7_score.show()
	level_8_score.show()
	level_9_score.show()
	level_10_score.show()
	

func _on_continue_button_pressed():
	if ScoreService.player_died || ScoreService.game_completed:
		game_manager.transition_scene(Constants.MAIN_MENU)
		game_manager.ui.hide()
	else:
		game_manager.transition_scene(Constants.TEST_LEVEL)
