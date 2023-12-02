@tool
extends EditorPlugin

var base_path = "res://addons/qianfanmodelrequest/"
func _enter_tree():
    add_autoload_singleton("ModelInfoLoad", "res://addons/qianfanmodelrequest/model_info.gd")
    add_custom_type("ModelRequest", "Node",
        preload("res://addons/qianfanmodelrequest/model_request.gd"),
        preload("res://addons/qianfanmodelrequest/baiduyun.png"))



func _exit_tree():
    remove_autoload_singleton("ModelInfoLoad")
    remove_custom_type("ModelRequest")

