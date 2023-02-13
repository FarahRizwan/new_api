import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:new_api/PostModel.dart';
import 'package:http/http.dart' as http;

class PostApi extends StatefulWidget {
  const PostApi({super.key});

  @override
  State<PostApi> createState() => _PostApiState();
}

class _PostApiState extends State<PostApi> {
  List<PostModel> postList = [];
  Future<List<PostModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPostApi(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
                itemCount: postList.length,
                itemBuilder: ((context, index) {
                  return Container(
                      height: 270,
                      width: 200,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: ListTile(
                        iconColor: Colors.purple,
                        textColor: Colors.black,
                        isThreeLine: false,
                        leading: CircleAvatar(
                            backgroundColor: Colors.pink,
                            child: Text(postList[index].userId.toString())),
                        subtitle: Text(postList[index].body.toString()),
                        trailing: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Text(postList[index].id.toString())),
                        title: Text(postList[index].title.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ));
                }));
          }
        }),
      ),
    );
  }
}
