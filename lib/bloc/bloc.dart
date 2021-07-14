import 'package:flutter/material.dart';
import 'package:flutter_api_request/bloc/model/comment.dart';
import 'package:flutter_api_request/bloc/repo/repo.dart';

enum Progress { success, failed }

class MBloc with ChangeNotifier {
  final MRepo _repo = MRepo();
  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  Future<Progress> getComments() async {
    Progress result = Progress.failed;
    await _repo.getComments().then((value) {
      result = Progress.success;
      this._comments = value;
    });
    return result;
  }
}
