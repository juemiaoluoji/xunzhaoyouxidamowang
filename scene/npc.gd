extends CharacterBody2D

class_name NPC

@export var job: String = ""
@export var job_desc: String = ""
@export var texture: Texture2D

@onready var model_request = $ModelRequest as ModelRequest
@onready var check_request = $CheckRequest as ModelRequest

var intro_str_base = ""
func _ready():
    var system = "你身处的故事背景shi:" + GlobalInfo.BACKFGROUND_INFO + \
        "，你的角色是{job}， 你负责{job_desc}。".format({"job": job, "job_desc": job_desc})
    model_request.system = system
    intro_str_base = "我是一名{job}，我负责{job_desc}".format({"job": job, "job_desc": job_desc})
    $Sprite2D.texture = texture


func intro():
    var intro_str = "你好，" + intro_str_base
    get_parent().set_npc_text(self, intro_str)

func dialogue(text: String):
    # var answer = "回答:" + text
    var check_message = "将给出一段故事背景，并给出对话对象的介绍以及我对他说的一句话，请你判断我要说的话是否符合故事背景，\n" + \
    "符合请回答“是”，不符合请回答“不是”，你只需要回答“是”或者“不是”。\n" + \
    "故事背景：{str}\n".format({"str": GlobalInfo.BACKFGROUND_INFO}) + \
    "对话的对象：{job}， 负责{job_desc}\n".format({"job": job, "job_desc": job_desc}) + \
    "对话：{str}".format({"str":text})
    var answer = await check_request.call_model(check_message)
    if answer.begins_with("不是"):
        get_parent().set_npc_text(self, "我不知道你在说是什么，" + intro_str_base)
        return
    answer = await model_request.call_model(text)
    get_parent().set_npc_text(self, answer)
    return
