import 'dart:convert';

import 'user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users = [];
  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  fetchdata() async {
    var responce = await http.get("https://api.github.com/users");
    var convertdata = json.decode(responce.body);

    List<User> usercopy = [];
    for (var i = 0; i < 10; i++) {
      User singleuser = User.fromData(convertdata[i]);
      usercopy.add(singleuser);
    }

    setState(() {
      users = usercopy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fetch data'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                for (var user in users)
                  ListTile(
                    leading: Text(user.avatar),
                    title: Text(user.login),
                    trailing: Text(user.id),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
