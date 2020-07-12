extends Node2D

const MARGIN_SIDES = 15
const MARGIN_TOPDOWN = 15
const ACTION_TRIGER_SIZE = 70
const GENERATOR_HEIGHT = 720
const GENERATOR_WIDTH = 100
const MARKER_SIZE = 20

const ACTION_RES = preload("res://action.tscn")

var number_of_visible_actions = (GENERATOR_HEIGHT-(MARGIN_TOPDOWN*2))/float(ACTION_TRIGER_SIZE)
var visible_action_list = []

func _ready():
	if number_of_visible_actions - int(number_of_visible_actions) > 0:
		number_of_visible_actions = number_of_visible_actions + 1
		
	$TextureRect.position.x = GENERATOR_WIDTH - MARKER_SIZE
	$TextureRect.position.y = GENERATOR_HEIGHT/2 - MARKER_SIZE/2
			
	for actions in number_of_visible_actions:
		var temp_pos_x = GENERATOR_WIDTH/2 - ACTION_TRIGER_SIZE/2
		var temp_pos_y = GENERATOR_HEIGHT - MARGIN_TOPDOWN - ACTION_TRIGER_SIZE/2
		var instance = ACTION_RES.instance()
		instance.position.y = temp_pos_y - actions*ACTION_TRIGER_SIZE
		instance.position.x = temp_pos_x
		visible_action_list.append(instance)
		self.add_child(instance)
		
	

#func setAction():
	#emit signal


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(visible_action_list.back().position.y < 0):
		print("hola")
		print(visible_action_list.back().position.y)
		visible_action_list.back().position.y = visible_action_list[0].position.y + ACTION_TRIGER_SIZE
		print(visible_action_list.back().position.y)
		visible_action_list.back().randomize_action()
		var temp = visible_action_list.pop_back()
		visible_action_list.push_front(temp)
