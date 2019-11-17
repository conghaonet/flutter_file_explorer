
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_explorer/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const navigationName = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: Container(
        child: InkWell(
          onTap: () {
            Provider.of<ThemeProvider>(context).updateTheme(!Provider.of<ThemeProvider>(context).isDark);
          },
          child: Text(
            'Home page',
          ),
        ),
      ),
    );
  }
}