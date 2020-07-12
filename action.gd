extends Node2D

var current_action = ""
var rng = RandomNumberGenerator.new()
const ACTION_SIZE = 70

func _ready():
	randomize_action()
	
func randomize_action():
	rng.randomize()
	var my_random_number = rng.randi_range(0, 3)
	
	match my_random_number:
		0:
			$background/runAway.visible = true
			$background/citizens.visible = false
			$background/soldiers.visible = false
			$background/believers.visible = false
		1:
			$background/runAway.visible = false
			$background/citizens.visible = true
			$background/soldiers.visible = false
			$background/believers.visible = false
		2:
			$background/runAway.visible = false
			$background/citizens.visible = false
			$background/soldiers.visible = true
			$background/believers.visible = false
		3:
			$background/runAway.visible = false
			$background/citizens.visible = false
			$background/soldiers.visible = false
			$background/believers.visible = true

func _process(delta):
	$background.rect_position.y = $background.rect_position.y - ACTION_SIZE*3*delta
