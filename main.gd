extends Node2D


const title_res = preload("res://title.tscn")
const level_1_res = preload("res://level1.tscn")

var title_instanced
var level_1_instanced
var swarms = true

# Called when the node enters the scene tree for the first time.
func _ready():
	title_instanced = title_res.instance()
	title_instanced.name = "Title"
	self.add_child(title_instanced)
	$Title.connect("start_play", self, "_from_menu_to_level_1")
	$Title.connect("howto", self, "_howto_visible")
	$Title.connect("change_swarms", self, "_set_swarms")

func _from_menu_to_level_1():
	self.remove_child($Title)
	level_1_instanced = level_1_res.instance()	
	level_1_instanced.name = "Level1"
	self.add_child(level_1_instanced)
	$Level1.set_swarms(swarms)
	$Level1.connect("go_home", self, "_back_to_menu")
	$Level1.connect("assign_actions", self, "_action_changed")

func _back_to_menu():
	self.remove_child($Level1)
	title_instanced = title_res.instance()
	title_instanced.name = "Title"
	self.add_child(title_instanced)
	$Title.connect("start_play", self, "_from_menu_to_level_1")
	$Title.connect("howto", self, "_howto_visible")
	$Title.connect("change_swarms", self, "_set_swarms")

func _howto_visible():
	$howto.visible = true
	
func _input(event):
	if (event is InputEventKey or  event is InputEventMouseButton )and event.pressed:
		$howto.visible = false
func _action_changed():
	var action = $Level1/action_gen.pointed_action
	var objectives = []
	var direction = "move"
	if action == "church":
		objectives = $Level1.church_list
	if action == "neutral":
		objectives = $Level1.neutral_list
	if action == "monarch":
		objectives = $Level1.monarch_list
	if action == "retreat":
		objectives = $Level1.enemy_list
		direction = "flee"
	for rebel in $Level1.rebels_list:
		rebel.action = direction
		rebel.objective_mob = rebel
		for objective in objectives:
			if objective.size > 0:
				if rebel.objective_mob.global_position == rebel.global_position:
					rebel.objective_mob = objective
				else:
					if rebel.global_position.distance_to(rebel.objective_mob.global_position) > rebel.global_position.distance_to(objective.global_position):
						rebel.objective_mob = objective

func _set_swarms():
	swarms = !$Title/CheckButtonRec/CheckButton.pressed
