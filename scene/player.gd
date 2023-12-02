extends CharacterBody2D
class_name Player

const MAX_SPEED = 150
const ACCELERATION_SMOOTHING = 25

var cur_npc: NPC = null

func _ready():
    $Area2D.body_entered.connect(on_body_entered)
    $Area2D.body_exited.connect(on_body_exit)
    $TextEdit.visible = false


func get_move_vector():
    var x_move = Input.get_action_strength("move_right") -  Input.get_action_strength("move_left")
    var y_move = Input.get_action_strength("move_down") -  Input.get_action_strength("move_up")
    return Vector2(x_move, y_move)

func handle_input():
    if Input.is_action_just_pressed("ui_accept") and cur_npc != null:
        if $TextEdit.visible:
            var text = $TextEdit.text
            $TextEdit.text = ""
            cur_npc.dialogue(text)
            $TextEdit.visible = false
            $TextEdit.release_focus()
        else:
            $TextEdit.visible = true
            $TextEdit.grab_focus()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    handle_input()
    var move_vec = get_move_vector()
    var direction = move_vec.normalized()
    var target_velocity = direction * MAX_SPEED
    velocity = velocity.lerp(target_velocity,  1.0 - exp(-delta * ACCELERATION_SMOOTHING))
    move_and_slide()

func on_body_entered(other: Node2D):
    var npc = other as NPC
    if not npc || cur_npc != null:
        return

    cur_npc = npc
    cur_npc.intro()

func on_body_exit(other: Node2D):
    var npc = other as NPC
    if npc != null and npc == cur_npc:
        get_parent().exit_npc_text()
        cur_npc = null



