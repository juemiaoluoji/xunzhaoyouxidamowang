extends Camera2D

var target_postion = Vector2.ZERO
func _ready():
    make_current()

func _process(delta):
    var player_nodes = get_tree().get_nodes_in_group("player")
    if player_nodes.size() > 0 :
        var player = player_nodes[0] as CharacterBody2D
        target_postion = player.global_position
    global_position = global_position.lerp(target_postion, 1.0 - exp(-delta * 20))
