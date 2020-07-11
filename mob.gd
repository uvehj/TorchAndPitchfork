extends Node2D


export var faction = "neutral"
export var size = 10
var combat_speed = 5
var objective = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	$MobBody.set_size(size)
	$MobBody.faction=faction
	self.set_color()
	
func set_color():
	if faction == "rebels":
		$MobBody.color=Color(1.0,0.0,0.0)
	elif faction == "monarch":
		$MobBody.color=Color(0.0,0.0,1.0)
	elif faction == "church":
		$MobBody.color=Color(1.0,1.0,0.0)
	else:
		$MobBody.color=Color(0.0,0.0,0.0)

func _process(delta):
	var overlapping_area_list = $MobBody.get_overlapping_areas()
	for area in overlapping_area_list:
		if area.name == "MobBody":
			self.mob_clash(area, delta)
	self.act()

func mob_clash(clash_area, delta):
	var clash_faction = clash_area.faction
	if clash_faction == "church":
		if faction == "rebels":
			if clash_area.get_mob_size() > size:
				size = size - 1 * delta * combat_speed
			else:
				size = size + 1 * delta * combat_speed
	if clash_faction == "rebels":
		if faction == "neutral":
			size = size - 1 * delta * combat_speed
		elif faction == "church":
			if clash_area.get_mob_size() >= size:
				size = size - 1 * delta * combat_speed
			else:
				size = size + 1 * delta * combat_speed
		elif faction == "monarch":
			size = size - 1 * delta * combat_speed
	if clash_faction == "neutral":
		if faction == "church" or faction == "rebels":
			size = size + 1 * delta * combat_speed
	if clash_faction == "monarch":
		if faction == "rebels":
			size = size - 1 * delta * combat_speed
	$MobBody.set_size(size)

func act():
	if faction == "church":
		self.church_actions()
	if faction == "monarch":
		self.monarch_actions()
	if faction == "rebels":
		self.rebels_actions()
	if faction == "neutral":
		self.neutral_actions()

func church_actions():
	pass
func monarch_actions():
	pass
func rebels_actions():
	pass
func neutral_actions():
	pass
