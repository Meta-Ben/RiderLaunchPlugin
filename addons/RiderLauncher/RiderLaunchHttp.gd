class_name RiderLaunchHttp extends Node

var http_request: HTTPRequest


func _ready() -> void:
	self.http_request = HTTPRequest.new()
	add_child(self.http_request)
	self.http_request.request_completed.connect(_on_request_completed)
	
func _exit_tree() -> void:
	if http_request:
		http_request.queue_free()
	
func request_execution(base_url: String, port : int, type: String, config_to_run : String):
	var url: String = "http://" + base_url + ":" + str(port) + "/" + type + "?config=" + config_to_run.replace(" ", "%20")
	var err: int    = self.http_request.request(url)
	if err != OK:
		push_error("Erreur lors de la requête d'éxécution rider: %s" % err)
		
func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var response_text = body.get_string_from_utf8()
		print("Successfully launch your game from Rider :", response_text)
	else:
		print("Request Error Code:", response_code)
		