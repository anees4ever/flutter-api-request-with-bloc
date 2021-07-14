import 'dart:convert';
import 'package:flutter_api_request/bloc/model/comment.dart';
import 'package:flutter_api_request/bloc/repo/res.dart';
import 'package:http/http.dart' as http;

class MRepo {
  Future<List<Comment>> getComments() async {
    var url = Uri.https(domain, comments);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<Comment> result = [];
      var jsonResponse = jsonDecode(response.body);

      for (var item in jsonResponse) {
        result.add(Comment.fromJson(item));
      }

      return result;
    } else {
      return [];
    }
  }
}
