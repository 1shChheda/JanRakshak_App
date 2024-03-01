import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/addUserModel.dart';

class API {
  Future<addUserModel?> addUser(
      String name, String phone, String em1, String em2) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://emergency-dispatch-system.onrender.com/user/add-user'));
    request.body = json.encode({
      "name": name,
      "phoneNo": phone,
      "emergencyContacts": [em1, em2]
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode <= 300) {
      final responseBody = await response.stream.transform(utf8.decoder).join();
      final responseData = jsonDecode(responseBody);
      return addUserModel.fromJson(responseData);
    } else {
      print(response.reasonPhrase);
      return addUserModel();
    }
  }
  sendwidget(String transcribe) async{
    var headers = {
  'Content-Type': 'application/json'
};
var request = http.Request('POST', Uri.parse('https://emergency-dispatch-system.onrender.com/user/send-widgets'));
request.body = json.encode({
  "transcribed_text":transcribe
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
      final responseBody = await response.stream.transform(utf8.decoder).join();
      final responseData = jsonDecode(responseBody);
      return addUserModel.fromJson(responseData);
}
else {
  print(response.reasonPhrase);
}

  }
}
