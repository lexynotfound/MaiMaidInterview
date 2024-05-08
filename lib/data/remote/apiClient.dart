import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart'; // Import dartz for Either, Right, and Left

import '../../constant/variables.dart';
import '../../data/models/response/users_response_model.dart';

class ApiClient {
  final http.Client httpClient;

  ApiClient(
      this.httpClient); // Accept httpClient in constructor for better testing and flexibility

  Future<Either<String, Users>> getKhs() async {
    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    try {
      final response = await httpClient.get(
        Uri.parse('${Variables.baseUrl}/users'),
        headers: header,
      );

      if (response.statusCode == 200) {
        // Correctly decode JSON before passing to fromJson
        final users = Users.fromJson(json.decode(response.body));
        return Right(users); // Use Right to return success
      } else {
        return Left(
            'Server error: ${response.statusCode}'); // Use Left to return error
      }
    } catch (e) {
      return Left(
          'Exception: ${e.toString()}'); // Handle exceptions by returning a Left
    }
  }
}
