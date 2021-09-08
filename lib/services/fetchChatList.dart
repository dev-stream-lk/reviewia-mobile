import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/structures/chatListStruct.dart';
import 'package:reviewia/services/userState.dart';

Future <dynamic> fetchCatList() async {
  String email = await UserState().getUserName();
  String token = await UserState().getToken();
  String url = KBaseUrl + "api/user/group/all?email="+email;
  final response = await http.get(
      Uri.parse(url),
    headers: <String, String>{
      'Authorization' : token
    },
  );
  if (response.statusCode == 200) {
    late var chatlist;
    var decodedUserData = jsonDecode(response.body);
    chatlist = decodedUserData.map((e) => ChatListStruct.fromJson(e)).toList();
    print(chatlist.toString());
    return chatlist;
  } else {
    throw Exception("API Error");
  }
}
