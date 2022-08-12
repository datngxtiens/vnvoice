import 'package:http/http.dart' as http;
import 'package:vnvoicemobile/requests/urls.dart';

Future<http.Response> getAllPost() {
  return http.get(Uri.parse(VnVoiceUri.getPostDetail));
}
