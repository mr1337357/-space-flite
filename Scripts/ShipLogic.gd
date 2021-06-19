extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func do_rotation(rotation):
    var rot = Vector3.ZERO
    rot += global_transform.basis.x * rotation.x
    rot += global_transform.basis.y * rotation.y
    rot += global_transform.basis.z * rotation.z
    angular_velocity = rot

func do_thrust(thrust):
    var mov = Vector3.ZERO
    mov += global_transform.basis.x * thrust.x
    mov += global_transform.basis.y * thrust.y
    mov += global_transform.basis.z * thrust.z
    apply_impulse(Vector3.ZERO,mov)
    
func do_brake():
    linear_velocity = linear_velocity / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
