class Registrasi {
  int? code;
  bool? status;
  String? data;

  Registrasi({this.code, this.status, this.data});

  factory Registrasi.fromJson(Map<String, dynamic> obj) {
    bool statusBool =
        (obj['status'] == true || obj['status'] == 1 || obj['status'] == "1");

    return Registrasi(code: obj['code'], status: statusBool, data: obj['data']);
  }
}
