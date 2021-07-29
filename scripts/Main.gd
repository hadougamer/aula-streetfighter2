extends Node2D

var timer
var sequence = []
var moves = {
	"hadouken"  : ["down", "front", "punch"],
	"shoryuken" : ["front", "down", "front", "punch"],
}

func _ready():
	# Loads the stage
	Global.loadStage(self, "ryu")
	
	# Loads the player one
	Global.loadPlayer1( self, "ryu", Vector2(192,343))

	# Sequence timer (user for specials)
	self._config_timer()

func _process(delta):
	pass

func _config_timer():
	timer = Timer.new()
	add_child(timer)
	
	timer.wait_time = 0.3 # Wait time in seconds
	timer.one_shot = true # Run timer just one time
	
	timer.connect("timeout", self, "on_timeout")

func on_timeout():
	# verify special sequence
	self._check_sequence( sequence )
	
	# Clean the sequence
	sequence = []

func _add_input_to_sequence( action ):
	sequence.push_back( action )

func _play_action( action ):
	$Ryu.set_special( action )

func _check_sequence( sequence ):
	for move_name in moves.keys():
		if sequence == moves[move_name]:
			_play_action( move_name )

func _input(event):
	# Prevent wrong events
	if not event is InputEventKey:
		return
	if not event.is_pressed():
		return

	if event.is_action_pressed("ui_down"):
		_add_input_to_sequence("down")
	elif event.is_action_pressed("ui_right"):
		_add_input_to_sequence("front")
	elif event.is_action_pressed("ui_punch"):
		_add_input_to_sequence("punch")

	timer.start()
