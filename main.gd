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
