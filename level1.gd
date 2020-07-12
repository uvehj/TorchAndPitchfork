extends Node2D


# Declare member variables here. Examples:
var rebels_list = []
var neutral_list = []
var church_list = []
var monarch_list = []
var enemy_list = []

signal go_home
signal defeat
signal victory
signal assign_actions

# Called when the node enters the scene tree for the first time.
func _ready():
	var children_list = self.get_children()
	for child in children_list:
		if "Mob" in child.name:
			if child.faction == "neutral":
				neutral_list.append(child)
			if child.faction == "church":
				church_list.append(child)
				enemy_list.append(child)
			if child.faction == "monarch":
				monarch_list.append(child)
				enemy_list.append(child)
			if child.faction == "rebels":
				rebels_list.append(child)

func _process(delta):
	self.check_victory()



func _on_home_pressed():
	emit_signal("go_home")
	
func set_swarms(value):
	var children_list = self.get_children()
	for child in children_list:
		if "Mob" in child.name:
			child.set_swarm(value)
func check_victory():
	var enemies_alive = false
	for enemy in enemy_list:
		if enemy.size > 0:
			enemies_alive = true
	if enemies_alive:
		var rebels_alive = false
		for rebel in rebels_list:
			if rebel.size > 0:
				rebels_alive = true
		if !rebels_alive:
			victory_screen("defeat")
	else:
		victory_screen("victory")

func victory_screen(result):
	$ResultScreen.set_screen(result)
	$ResultScreen.visible = true


func _on_action_gen_action_selected():
	emit_signal("assign_actions")
