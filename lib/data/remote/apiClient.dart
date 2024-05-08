import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import '../../constant/variables.dart';
import '../../data/models/response/users_response_model.dart';

class ApiClient {
  final http.Client httpClient;

  ApiClient(this.httpClient);

  Future<Either<String, Users>> fetchUsers(
      {int page = 1, int perPage = 10}) async {
    final String url =
        '${Variables.baseUrl}/users?page=$page&per_page=$perPage'; // Tambahkan parameter per_page di sini
    print('Requesting: $url');
    try {
      final response = await httpClient.get(Uri.parse(url), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final users = Users.fromJson(json.decode(response.body));
        return Right(users);
      } else {
        return Left(
            'Failed to fetch users: HTTP ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception caught: ${e.toString()}');
      return Left('Exception: ${e.toString()}');
    }
  }
}
