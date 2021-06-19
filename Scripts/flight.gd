extends Spatial

var angle = Vector3.ZERO
var rot = Vector3.ZERO
var thrust = Vector3.ZERO

var debug_timer = 10

func _ready():
    var VR = ARVRServer.find_interface("OpenVR")
    if VR and VR.initialize():
        get_viewport().arvr = true
        get_viewport().hdr = false

        OS.vsync_enabled = false
        Engine.target_fps = 90
        # Also, the physics FPS in the project settings is also 90 FPS. This makes the physics
        # run at the same frame rate as the display, which makes things look smoother in VR!
    else:
        print('failed to load vr')
    Input.add_joy_mapping('030000004f0400000ab1000000000000,T.16000M,a:b0,b:b1,back:b12,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b11,leftshoulder:b4,lefttrigger:b9,leftx:a0,lefty:a1,rightx:a2,righty:a3,rightshoulder:a6,righttrigger:b7,start:b10,x:b2,y:b3,platform:Windows',true)

func _process(delta):
    rot.z -=  Input.get_joy_axis(0,0)
    rot.y -=  Input.get_joy_axis(0,2)
    rot.x +=  Input.get_joy_axis(0,1)
    
    rot *= 0.9
    thrust = Vector3.ZERO
    if Input.is_key_pressed(KEY_W):
        rot.x-=.2
    if Input.is_key_pressed(KEY_S):
        rot.x+=.2
    if Input.is_key_pressed(KEY_A):
        rot.y+=.2
    if Input.is_key_pressed(KEY_D):
        rot.y-=.2
    if Input.is_key_pressed(KEY_Q):
        rot.z+=.2
    if Input.is_key_pressed(KEY_E):
        rot.z-=.2
    
    if Input.is_key_pressed(KEY_DOWN):
        thrust.z = .05
    if Input.is_key_pressed(KEY_UP):
        thrust.z = -.05
    
    $PlayerShip.do_rotation(rot)
    $PlayerShip.do_thrust(thrust)
    
    
    #ship.transform.basis = ship.transform.basis.rotated(Vector3(0,1,0),sin(rot.z)*rot.y*delta)
    #ship.transform.basis = ship.transform.basis.rotated(Vector3(1,0,0),rot.x*delta)
    debug_timer -= 1
    if debug_timer == 0:
        debug_timer = 10
        #print($PlayerShip.angular_velocity)
