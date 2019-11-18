import 'package:flutter/material.dart';
import 'package:flutter_file_explorer/generated/i18n.dart';
import 'package:flutter_file_explorer/providers/theme_provider.dart';
import 'package:flutter_file_explorer/widgets/actions_helper.dart';
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
        title: Text(S.current.appTitle),
        actions: ActionsHelper.homeActions(context),
      ),
      body: Container(
        child: InkWell(
          onTap: () {
//            Provider.of<ThemeProvider>(context).updateTheme(!Provider.of<ThemeProvider>(context).isDark);
          },
          child: Text(
            'Home page',
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: (){
        },
      ),
      PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return <PopupMenuItem<String>>[
            PopupMenuItem<String>(child: Text(S.current.settings), value: "settings",),
          ];
        },
        onSelected: (String action) {
          switch (action) {
            case "settings":

          }
        }
      ),
    ];
  }
}