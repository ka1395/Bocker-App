class RegisterModel {
  var message;
  bool? error;
  RegisterModel.fromJson(Map<String, dynamic> json) {
    error = json["error"];
    if (error == null)
      message = json["message"];
    else {
      message = RegisterMessageModel.fromjson(json["message"]);
    }
  }
}

class RegisterMessageModel {
  String? field;
  String? reason;
  RegisterMessageModel.fromjson(var json) {
    print(json.runtimeType);
    if (json.runtimeType == List) {
      field = json[0]["field"];
      reason = json[0]["reason"];
    } else {
      field = json["field"];
      reason = json["reason"];
    }
  }
}
