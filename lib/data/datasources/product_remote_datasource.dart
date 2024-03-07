import 'package:dartz/dartz.dart';
import 'package:flutter_pos/constants/variables.dart';
import 'package:flutter_pos/data/datasources/auth_local_datasource.dart';
import 'package:flutter_pos/data/models/request/product_request_model.dart';
import 'package:flutter_pos/data/models/response/add_product_response_model.dart';
import 'package:flutter_pos/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProduct() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
        Uri.parse('${Variables.baseUrl}/api/products'),
        headers: {'Authorization': 'Bearer ${authData.token}'});

    if (response.statusCode == 200) {
      return right(ProductResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, AddProductResponseModel>> addProduct(
      ProductRequestModel productRequestModel) async {
    final authData = await AuthLocalDatasource().getAuthData();
    // final response = await http.get(Uri.parse('${Variables.baseUrl}/api/products'),
    // headers: {
    //   'Authorization' : 'Bearer ${authData.token}',
    //   'Accept': 'application/json'
    // }
    // );

    // if (response.statusCode == 200) {
    //   return right(ProductResponseModel.fromJson(response.body));
    // } else {
    //   return left(response.body);
    // }

    Map<String, String> headers = {
      // 'Accept': 'application/json',
      'Authorization': 'Bearer ${authData.token}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Variables.baseUrl}/api/products'));
    request.fields.addAll(productRequestModel.toMap());
    request.files.add(await http.MultipartFile.fromPath(
        'image', productRequestModel.image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final int statusCode = response.statusCode;
    final String body = await response.stream.bytesToString();

    if (statusCode == 200) {
      return right(AddProductResponseModel.fromJson(body));
    } else {
      return left(body);
    }
  }
}
