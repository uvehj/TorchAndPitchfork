extends Node2D

const MARGIN_SIDES = 15
const MARGIN_TOPDOWN = 15
const ACTION_TRIGGER_SIZE = 70
const GENERATOR_HEIGHT = 720
const GENERATOR_WIDTH = 100
const MARKER_SIZE = 20

var pointed_action = ""

signal action_selected

const ACTION_RES = preload("res://action.tscn")

func _ready():
	$Spawner.position.y = GENERATOR_HEIGHT
	var number_of_actions = $Spawner.position.y/ACTION_TRIGGER_SIZE
	var temp_y = $Spawner.position.y
	print($Spawner.position.x)
	for i in number_of_actions:
		var action_instanced = ACTION_RES.instance()
		action_instanced.position.x = $Spawner.position.x
		action_instanced.position.y = temp_y
		action_instanced.respawn_position_y =$Spawner.position.y
		self.add_child(action_instanced)
		action_instanced.connect("pointed_action", self, "_assign_action")
		temp_y = temp_y + ACTION_TRIGGER_SIZE

func _assign_action(action):
	pointed_action = action
	
func _input(event):
	#Only shoot when there are bullets left
	#if event is InputEventMouseButton and event.pressed and pointed_action != "" :
	emit_signal("action_selected")
