import 'package:flutter/material.dart';
import 'package:hose_jockey/dark_theme_provider.dart';
import 'package:hose_jockey/bloc/theme.dart';
//import 'package:provider/provider.dart';

class SwitchListItem extends StatefulWidget{

  SwitchListItem({
    this.iconData,
    this.title,
    this.provider,
    this.func,
  });

  final IconData? iconData;
  final String? title;
  final DarkThemeProvider? provider;
  final Function? func;

  late bool switchState;

  @override
  SwitchListItemState createState() => SwitchListItemState();
}

class SwitchListItemState extends State<SwitchListItem>{
  Widget build(BuildContext context){
    return SwitchListTile(
      title: Row(
        children: [
          Icon(widget.iconData),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(widget.title!),
          ),
        ],
      ),
      value: widget.switchState,
      onChanged: (changedVal) {
        setState((){
          widget.switchState = changedVal;
          widget.provider!.darkTheme = changedVal;
        });
      },
    );

  }
}