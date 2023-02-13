import 'dart:convert';

import 'package:flutter/material.dart';
import 'CommentApi.dart';
import 'package:http/http.dart' as http;

import 'CommentApiModel.dart';

class CommentApis extends StatefulWidget {
  const CommentApis({super.key});

  @override
  State<CommentApis> createState() => _CommentApisState();
}

class _CommentApisState extends State<CommentApis> {
  List<CommentApi> commentList = [];

  Future<List<CommentApi>> commentApi() async {
    var response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));
    var data = jsonDecode(response.body.toString());
    print(response.body);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        commentList.add(CommentApi.fromJson(i));
      }
    } else {
      return commentList;
    }

    return commentList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Comment Api",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: commentApi(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: commentList.length,
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(commentList[index].id.toString())),
                      SizedBox(
                        height: 20,
                      ),
                      Center(child: Text(commentList[index].title.toString())),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(commentList[index].userId.toString())),
                    ],
                  );
                }),
              );
            }
          },
        ));
  }
}
