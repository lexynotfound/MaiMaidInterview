import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart'; // Import dartz for Either, Right, and Left
import '../../constant/variables.dart';
import '../../data/models/response/users_response_model.dart';

class ApiClient {
  final http.Client httpClient;

  ApiClient(this.httpClient);

  Future<Either<String, Users>> fetchUsers({int page = 1}) async {
    final String url = '${Variables.baseUrl}/users?page=$page';
    try {
      final response = await httpClient.get(Uri.parse(url), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final users = Users.fromJson(json.decode(response.body));
        return Right(users);
      } else {
        return Left(
            'Failed to fetch users: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      return Left('Exception: ${e.toString()}');
    }
  }
}
