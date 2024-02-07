import 'package:dartz/dartz.dart';
import 'package:flutter_pos/constants/variables.dart';
import 'package:flutter_pos/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/login'),
        body: {'email': email, 'password': password}
        );
        if (response.statusCode == 200) {
          return right(AuthResponseModel.fromJson(response.body));
        }else{
          return left(response.body);
        }
  }
}
