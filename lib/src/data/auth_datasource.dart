import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthDatasource {
  final Dio _dio = Dio();

  final String baseUrl = "http://94.74.86.174:8080/api/";

  Future<Either<String, String>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      var result = await _dio.post("${baseUrl}register", data: {
        "username": username,
        "email": email,
        "password": password,
      });
      return right(result.data["message"].toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> login({
    required String username,
    required String password,
  }) async {
    try {
      var result = await _dio.post("${baseUrl}login", data: {
        "username": username,
        "password": password,
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result.data["data"]["token"]);
      return right(result.data["message"].toString());
    } catch (e) {
      return left(e.toString());
    }
  }
}
