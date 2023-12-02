@tool
extends Node

class_name ModelRequest

@export var one_shot: bool = true

var system: String = ""

var http_request: HTTPRequest


func _ready():
    http_request = HTTPRequest.new()
    http_request.set_name("http_request")
    add_child(http_request)

var message = []
func call_model(data: String):
    var token_url = ModelInfo.TOKEN_URL_BASE + \
        "&client_id={API_KEY}&client_secret={SECRET_KEY}".format({"API_KEY": ModelInfo.API_KEY, "SECRET_KEY":  ModelInfo.SECRET_KEY})
    http_request.request(token_url, [], HTTPClient.METHOD_POST)
    var res_array = await http_request.request_completed
    var body = res_array[3]

    var json_paser = JSON.new()
    json_paser.parse(body.get_string_from_utf8())
    var response = json_paser.get_data()
    var access_token = response["access_token"]
    var model_url = ModelInfo.MODEL_URL_BASE + access_token
    message.append({
        "role": "user",
        "content": data
    })
    var params = {
        "messages": message,
        "system": system
    }
    http_request.request(model_url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, JSON.stringify(params))
    res_array = await http_request.request_completed
    body = res_array[3]

    json_paser.parse(body.get_string_from_utf8())
    response = json_paser.get_data()
    var result = response["result"]
    if one_shot:
        message = []
    else:
        message.append({
            "role": "assistant",
            "content": result
        })
    return result
