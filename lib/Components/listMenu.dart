import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';

class ListsMenu extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;

  ListsMenu({this.title,this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).scaffoldBackgroundColor,
            border: const Border(
              top: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
              bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
            ),
          ),
          height: 44.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0,),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 7,
                    child: Text(
                      title ?? '',
                      style: textStyle,
                    )
                ),
                const Expanded(
                    flex: 1,
                    child: Icon(
                      CupertinoIcons.forward,
                      color: CupertinoColors.lightBackgroundGray,
                      size: 28.0,)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
