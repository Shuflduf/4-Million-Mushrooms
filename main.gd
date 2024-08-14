extends Control

@onready var http: HTTPRequest = $HTTPRequest

const URL = "https://api.hypixel.net/v2/skyblock/bazaar"

const HEADERS = ["application: json"]

func _ready() -> void:
	http.request(URL, HEADERS, HTTPClient.METHOD_GET)


func _on_http_request_request_completed(_r, _r_code, _h, body: PackedByteArray) -> void:
	FileAccess.open("data.json", FileAccess.WRITE).store_buffer(body)
	var price = JSON.parse_string(body.get_string_from_utf8())
	print(price["products"]["BROWN_MUSHROOM"])
