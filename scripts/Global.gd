extends Node

var camera = null
var player1 = null 
var players = {
	"ryu" 	: preload("res://scenes/chars/Ryu.tscn"),
}

var stages = {
	"ryu" 	: preload("res://scenes/stages/RyuStage.tscn"),
	"guile" : preload("res://scenes/stages/GuileStage.tscn"),
}

func _ready():
	print("Global settings")

func loadPlayer1( context, character, pos):
	player1 = players[character].instance()
	player1.position = pos
	context.add_child( player1 )

func loadStage( context, character):
	var stage = stages[character].instance()
	
	camera = stage.get_node("Camera")
	camera.current = true

	context.add_child( stage )
	stage.get_node("Theme").play()

func _process(delta):
	if player1 and camera:
		print(camera.position.x)
		camera.position = player1.position
		
	
