extends Node2D


# Declare member variables here. Examples:
var rebels_list = []
var neutral_list = []
var church_list = []
var monarch_list = []
var enemy_list = []

signal go_home


# Called when the node enters the scene tree for the first time.
func _ready():
	var children_list = self.get_children()
	for child in children_list:
		if "Node2D" in child.name:
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



func _on_home_pressed():
	emit_signal("go_home")
