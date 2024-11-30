extends Node

var next_scene = null


@onready var current_scene = $CurrentScene
@onready var music_player = $MusicPlayer
@onready var load_screen = $CanvasLayer/LoadScreen
@onready var ui = $CanvasLayer/User_Interface

func _ready():
	load_screen.color = Color(0,0,0,0)
	music_player.stream = load(Constants.TITLE_THEME)
	music_player.play()
	ui.hide()
	
	current_scene.get_child(0).transition.connect(transition_scene)
	get_node("CanvasLayer/User_Interface").player_died.connect(player_death)

func change_music(song: String):
	if music_player.stream.resource_path == song:
		pass
	else:
		music_player.stream = load(song)
		music_player.play()

func transition_scene(new_scene: String):
	if current_scene.get_child(0):
		current_scene.get_child(0).queue_free()
	current_scene.add_child(load(new_scene).instantiate())
	ui.show()

func transition_to_status_page():
	ui.hide()
	if current_scene.get_child(0):
		current_scene.get_child(0).queue_free()
	current_scene.add_child(load(Constants.STATUS_PAGE).instantiate())

func game_completed():
	
	transition_to_status_page()

func player_hit():
	ui.remove_health_token()

func player_death():
	ScoreService.player_died = true
	transition_to_status_page()

func _on_music_player_finished():
	music_player.play()

func update_score():
	ui.edit_score("Score: " + str(ScoreService.level_score))

func change_song(song: String):
	music_player.stream = load(song)
	music_player.play()
