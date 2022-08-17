import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vnvoicemobile/requests/urls.dart';

Future<http.Response> getCitizenId(String imgFile) async {
  final response = await http.get(Uri.parse("${VnVoiceUri.getCitizenId}?file=$imgFile"));

  return response;
}

Future<http.Response> compareFaces(String citizenId) async {
  final response = await http.get(Uri.parse("${VnVoiceUri.authCitizenId}?id=$citizenId"));

  return response;
}