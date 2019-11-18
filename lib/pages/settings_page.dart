import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_explorer/generated/i18n.dart';
import 'package:flutter_file_explorer/providers/theme_provider.dart';
import 'package:flutter_file_explorer/resources/app_const.dart';
import 'package:flutter_file_explorer/utils/sp_util.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static const navigationName = "/settings";
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static final Border _currentThemeBorder = Border.all(width: 2.0, color: Color(0x66000000));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.settings),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.palette),
              title: Text(S.current.themeMode,),
              subtitle: SpUtil.isDarkMode() ? Text(S.current.darkMode) : Text(S.current.lightMode),
              trailing: Switch(
                activeColor: Theme.of(context).accentColor,
                value: SpUtil.isDarkMode(),
                onChanged: (bool value){
                  Provider.of<ThemeProvider>(context).setThemeIsDarkMode(value);
                },
              ),
            ),
            //深色主题时，不允许设置主题色
//            if(ThemeData.dark().primaryColor != Theme.of(context).primaryColor) _chooseThemeColor(),
            if(MediaQuery.of(context).platformBrightness != Brightness.dark && !SpUtil.isDarkMode()) _chooseThemeColor(),
            _chooseAccentColor(),
          ],
        ),
      ),
    );
  }

  ExpansionTile _chooseThemeColor() {
    final List<Widget> themeChildren = [];
    for(int i=0; i<AppConst.themeColors.length; i++) {
      themeChildren.add(InkWell(
        onTap: () {
          setState(() {
            Provider.of<ThemeProvider>(context).setThemeColorIndex(i);
          });
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppConst.themeColors[i],
            border: Provider.of<ThemeProvider>(context).themeColorIndex == i ? _currentThemeBorder : null,
          ),
        ),
      ));
    }
    return ExpansionTile(
      leading: Icon(Icons.palette),
      title: Text(S.current.themeColor, style: TextStyle(color: Theme.of(context).primaryColor),),
      children: <Widget>[
        Wrap(
          children: themeChildren,),
      ],
    );
  }
  ExpansionTile _chooseAccentColor() {
    final List<Widget> themeChildren = [];
    for(int i=0; i<AppConst.accentColors.length; i++) {
      themeChildren.add(InkWell(
        onTap: () {
          setState(() {
            Provider.of<ThemeProvider>(context).setAccentColorIndex(i);
          });
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppConst.accentColors[i],
            border: Provider.of<ThemeProvider>(context).accentColorIndex == i ? _currentThemeBorder : null,
          ),
        ),
      ));
    }
    return ExpansionTile(
      leading: Icon(Icons.palette),
      title: Text(S.current.accentColor, style: TextStyle(color: Theme.of(context).accentColor),),
      children: <Widget>[
        Wrap(
          children: themeChildren,),
      ],
    );
  }
}