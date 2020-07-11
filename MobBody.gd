extends Area2D


var size = 10
var faction
var color = Color(0.0,0.0,0.0)
var collisionShape = CollisionShape.new()
var shape_owner

# Called when the node enters the scene tree for the first time.
func _ready():
	shape_owner= create_shape_owner(self)
	var shape = CircleShape2D.new()
	shape.radius= size
	shape_owner_add_shape(shape_owner, shape)
func _draw():
	draw_circle(Vector2(0,0),size,color)
	
func set_size(radius):
	size=radius
	remove_shape_owner(shape_owner)
	if size > 0:
		shape_owner= create_shape_owner(self)
		var shape = CircleShape2D.new()
		shape.radius= size
		shape_owner_add_shape(shape_owner, shape)

func _process(delta):
	update()

func get_mob_size():
	return size
