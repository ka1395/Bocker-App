class LoginModel {
  var message;
  String? token;
  bool? error;
  LoginModel.fromJson(Map<String, dynamic> json) {
    error = json["error"];
    token = json["token"];
    if (error == null)
      message = json["message"];
    else {
      message = LoginMessageModel.fromjson(json["message"]);
    }
  }
}

class LoginMessageModel {
  String? field;
  String? reason;
  LoginMessageModel.fromjson(var json) {
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
