import 'package:flutter/material.dart';
import 'package:flutter_api_request/bloc/model/comment.dart';
import 'package:provider/provider.dart';
import 'bloc/bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MBloc>(create: (_) => MBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MBloc bloc = Provider.of<MBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Container(
        width: double.maxFinite,
        child: _commentData(bloc),
      ),
    );
  }

  _commentData(MBloc bloc) {
    return FutureBuilder(
      future: bloc.getComments(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if ((snapshot.data as Progress) == Progress.success) {
            return _commentList(bloc.comments);
          } else {
            return Text('Failed');
          }
        } else if (snapshot.hasError) {
          return Text('Error');
        } else {
          return Text('Loading...');
        }
      },
    );
  }

  _commentList(List<Comment> comments) {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (BuildContext context, int position) {
        return _commentItem(comments[position]);
      },
    );
  }

  _commentItem(Comment comment) {
    return Container(
      width: double.maxFinite,
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                comment.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              Text(
                comment.email,
                style: TextStyle(
                    color: Colors.grey[600], fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              Text(
                comment.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 10),
              Divider(
                height: 0,
                thickness: 1,
                color: Colors.grey[300],
              )
            ],
          ),
        ),
        onTap: () => _itemTapFunction(comment),
      ),
    );
  }

  _itemTapFunction(Comment comment) {
    print('${comment.id} ${comment.email}');
  }
}
