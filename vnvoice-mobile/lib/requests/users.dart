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
    return const UserInfoResponse(
        message: "Đăng ký tài khoản thất bại",
        userId: "",
        role: "",
        username: "",
    );
  }
}

Future<UserInfoResponse> signInUser(String email, String password) async {
  final response = await http.post(
    Uri.parse(VnVoiceUri.signIn),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password
      })
  );

  if (response.statusCode == 200) {
    return UserInfoResponse.fromJson(jsonDecode(response.body));
  } else {
    return const UserInfoResponse(
      message: "Đăng nhập không thành công",
      userId: "",
      role: "",
      username: "",
    );
  }
}