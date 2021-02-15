class LoginModel {
  var error;
  String message;
  bool isSuccess;

  LoginModel({this.error, this.message, this.isSuccess});

  LoginModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    isSuccess = json['isSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['isSuccess'] = this.isSuccess;
    return data;
  }
}
