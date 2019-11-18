import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_explorer/generated/i18n.dart';
import 'package:flutter_file_explorer/pages/settings_page.dart';

class ActionsHelper {
  static List<Widget> homeActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: (){
        },
      ),
      PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return <PopupMenuItem<String>>[
            PopupMenuItem<String>(
              value: "settings",
              child: Row(
                children: <Widget>[
                  Icon(Icons.settings),
                  Container(width: 24,),
                  Text(S.current.settings),
                ],
              ),
            ),
          ];
        },
        onSelected: (String action) {
          switch (action) {
            case "settings":
              Navigator.pushNamed(context, SettingsPage.navigationName);
          }
        },
      ),
    ];
  }
}