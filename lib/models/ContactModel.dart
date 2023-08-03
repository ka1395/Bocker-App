class ContactModel {
  String? message;
  ContactModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
  }
}
