class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;

  Login({this.code, this.status, this.token, this.userID, this.userEmail});

  factory Login.fromJson(Map<String, dynamic> obj) {
    bool statusBool =
        (obj['status'] == true || obj['status'] == 1 || obj['status'] == "1");

    return Login(
      code: obj['code'],
      status: statusBool,
      token: obj['data']['token'].toString(),
      userID: int.tryParse(obj['data']['user']['id'].toString()) ?? 0,
      userEmail: obj['data']['user']['email'].toString(),
    );
  }
}
