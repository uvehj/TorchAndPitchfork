extends Node2D


const title_res = preload("res://title.tscn")
const level_1_res = preload("res://level1.tscn")

var title_instanced
var level_1_instanced

# Called when the node enters the scene tree for the first time.
func _ready():
	title_instanced = title_res.instance()
	title_instanced.name = "Title"
	self.add_child(title_instanced)
	$Title.connect("start_play", self, "_from_menu_to_level_1")

func _from_menu_to_level_1():
	self.remove_child($Title)
	level_1_instanced = level_1_res.instance()	
	level_1_instanced.name = "Level1"
	self.add_child(level_1_instanced)
	$Level1.connect("go_home", self, "_back_to_menu")

func _back_to_menu():
	self.remove_child($Level1)
	title_instanced = title_res.instance()
	title_instanced.name = "Title"
	self.add_child(title_instanced)
	$Title.connect("start_play", self, "_from_menu_to_level_1")

func action_changed(action):
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

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		action_changed("church")
	if Input.is_action_pressed("ui_left"):
		action_changed("monarch")
	if Input.is_action_pressed("ui_down"):
		action_changed("retreat")
