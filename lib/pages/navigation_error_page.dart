import 'package:flutter/material.dart';

class NavigationErrorPage extends StatefulWidget {
  static const navigationName = "/navigation_error";
  final String route;
  NavigationErrorPage({Key key, this.route}): super(key: key);

  @override
  _NavigationErrorPageState createState() => _NavigationErrorPageState();
}

class _NavigationErrorPageState extends State<NavigationErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('路由错误页面'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[500],Colors.green[400],Colors.green[300],],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Text('错误路由：${this.widget.route}'),
        ),
      ),
    );
  }
}