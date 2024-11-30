extends Node


## Determines how far the marker should move up, left, right, down
@export var movement_size: int = 32
# the number of blocks that you want to be generated
@export var max_block_number: int = 50
@export var max_position_limit: int = 400
@export var min_position_limit: int = 448

@onready var _marker = $Marker
@onready var _player_spawn = $Player_Spawn

@onready var block = preload("res://Scenes/LevelAssets/floor_block.tscn")
@onready var half_block = preload("res://Scenes/LevelAssets/floor_half_block.tscn")
@onready var support_block = preload("res://Scenes/LevelAssets/floor_support.tscn")
@onready var fish_token = preload("res://Scenes/LevelAssets/fish_token.tscn")
@onready var ice_spike = preload("res://Scenes/LevelAssets/ice_spike.tscn")
@onready var player = preload("res://Scenes/Characters/player.tscn")
@onready var goal_area = preload("res://Scenes/LevelAssets/goal_area.tscn")
@onready var default_obstacle_marker_position = _marker.position + Vector2(movement_size * 5, 0)
@onready var player_spawn_point = _player_spawn.position
@onready var current_block_count = 0

@onready var game_manager = get_parent().get_parent()

var current_player

var end_point: Vector2

func _ready():
	generate_floor()
	spawn_player()
	play_song()

func play_song():
	game_manager.change_song(Constants.SONG_ONE)

func spawn_player():
	var instance = player.instantiate()
	instance.position = player_spawn_point
	add_child(instance)
	current_player = instance

#Create the floor 
func generate_floor():
	#Create the bottom floor
	while current_block_count < max_block_number:
		create_block(_marker.position)
		
		_marker.position.x += movement_size
		current_block_count += 1
	#Reset the marker
	reset()
	
	#Create obstacle blocks
	_marker.position.y -= movement_size
#	print("marker: " + str(_marker.position))

	while _marker.position < end_point:
		var decider = round(randf_range(0, 10))
		
		if decider >= 0 and decider <= 2:
			create_half_block(_marker.position)
			_marker.position.x += movement_size
		elif decider == 3:
			create_block_platform(_marker.position)
			_marker.position.x += movement_size * 3
		elif decider >= 4 and decider <= 5:
			create_block(_marker.position)
			_marker.position.x += movement_size
		elif decider == 6:
			create_spike(_marker.position)
			_marker.position.x += movement_size
		elif decider == 8:
			#Spawn enemy
			_marker.position.x += movement_size
		else:
			_marker.position.x += movement_size
	
	spawn_goal_area(_marker.position)

#Generate a block at the given location
func create_block(location: Vector2):
	var instance = block.instantiate()
	instance.position = location
	
	var decider = round(randf_range(0, 7))
	if decider == 2:
		spawn_token(location)
	
	add_child(instance)

func create_half_block(location: Vector2):
	var instance = half_block.instantiate()
	instance.position = location
	add_child(instance)

func create_spike(location: Vector2):
	var instance = ice_spike.instantiate()
	instance.position = location
	add_child(instance)

#Generate a blocks in the form of stairs
func create_block_stairs(location: Vector2):
	var instance = block.instantiate()
	instance.position = location
	add_child(instance)

func create_block_platform(location: Vector2):
	var instance = block.instantiate()
	var instance2 = block.instantiate()
	var instance3 = block.instantiate()
	var step_instance1 = half_block.instantiate()
	var step_instance2 = half_block.instantiate()
	
	var platform_start = location - Vector2(0,movement_size * 2)
	var location2 = platform_start + Vector2(movement_size, 0)
	var location3 = location2 + Vector2(movement_size, 0)
	var step_location1 = location - Vector2(0,movement_size * .5)
	var step_location2 = location - Vector2(0,movement_size * 1.5)
	
	instance.position = platform_start
	instance2.position = location2
	instance3.position = location3
	step_instance1.position = step_location1
	step_instance2.position = step_location2
	
	add_child(instance)
	add_child(instance2)
	add_child(instance3)
	add_child(step_instance1)
	add_child(step_instance2)

func create_support_block(location: Vector2):
	var instance = support_block.instantiate()
	instance.position = location
	add_child(instance)

func spawn_token(location: Vector2):
	var instance = fish_token.instantiate()
	instance.position = location - Vector2(0, movement_size)
	add_child(instance)

func spawn_goal_area(location: Vector2):
	var instance = goal_area.instantiate()
	instance.position= location
	add_child(instance)

func reset():
	end_point = _marker.position - Vector2(movement_size * 5,0)
	_marker.position = default_obstacle_marker_position
