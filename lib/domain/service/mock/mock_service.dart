import 'dart:convert';
import 'dart:io';
import 'package:bkapp/core/extensions/error_exception.dart';
import 'package:bkapp/domain/models/user_model.dart';
import 'package:http/http.dart' as http;

class MockService {
  Future<List<User>?> fetchUsers() async {
    String baseUrl = "https://63581a57c27556d289375077.mockapi.io/api/v1/users";
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == HttpStatus.ok && response.body.isNotEmpty) {
        var body = json.decode(response.body) as List;   
        var userList = body.map((e) => User.fromJson(e)).toList();
        return userList;
      }
    }  on FetchErrorException catch(error) {
      throw FetchErrorException(errorMessage: error.errorMessage);
    }
    return null;
  }
  
}
