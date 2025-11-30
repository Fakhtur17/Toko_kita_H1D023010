import 'dart:convert';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/produk.dart';

class ProdukBloc {
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listProduk = jsonObj['data'];
    return listProduk.map((item) => Produk.fromJson(item)).toList();
  }

  static Future<bool> addProduk({Produk? produk}) async {
    String apiUrl = ApiUrl.createProduk;
    var body = {
      "kode_produk": produk!.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString(),
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);

    // ✔ konversi status 1 / "1" / true → bool
    bool status =
        (jsonObj['status'] == true ||
        jsonObj['status'] == 1 ||
        jsonObj['status'] == "1");

    return status;
  }

  static Future<bool> updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(int.parse(produk.id!));
    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString(),
    };

    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);

    bool status =
        (jsonObj['status'] == true ||
        jsonObj['status'] == 1 ||
        jsonObj['status'] == "1");

    return status;
  }

  static Future<bool> deleteProduk({int? id}) async {
    String apiUrl = ApiUrl.deleteProduk(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);

    bool status =
        (jsonObj['status'] == true ||
        jsonObj['status'] == 1 ||
        jsonObj['status'] == "1");

    return status;
  }
}
