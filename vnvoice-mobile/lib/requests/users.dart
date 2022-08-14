import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vnvoicemobile/models/response.dart';
import 'package:vnvoicemobile/requests/urls.dart';

Future<UserInfoResponse> createAccount(String email, String username, String psw) async{
  final response = await http.post(
    Uri.parse(VnVoiceUri.createAccount),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'username': username,
      'password': psw
    }),
  );

  if (response.statusCode == 200) {
    return UserInfoResponse.fromJson(jsonDecode(response.body));
  } else {
    return const UserInfoResponse(message: "Cannot create new user", userId: "", role: "");
  }
}