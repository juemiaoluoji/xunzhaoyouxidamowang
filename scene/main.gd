extends Node2D


@onready var npc_text = $NpcTextUI/TextLabel as RichTextLabel
@onready var player = get_tree().get_first_node_in_group("player") as Player


const TEXT_INCR = 5
var cur_text_len = 0
var cur_text = ""

func _ready():
    $TextTimer.timeout.connect(on_text_timer_timeout)
    exit_npc_text()



func set_npc_text(npc: NPC, text: String):
    if npc != player.cur_npc:
        return
    npc_text.visible = true
    cur_text_len = TEXT_INCR
    cur_text = text
    npc_text.text = cur_text.substr(0, cur_text_len)
    $TextTimer.wait_time = 0.5
    $TextTimer.start()

func on_text_timer_timeout():
    cur_text_len += TEXT_INCR
    npc_text.text = cur_text.substr(0, max(cur_text_len, len(cur_text)))
    if cur_text_len < len(cur_text):
        $TextTimer.wait_time= 0.5
        $TextTimer.start()

func exit_npc_text():
    npc_text.text = ""
    npc_text.visible = false
    $TextTimer.stop()
