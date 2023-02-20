import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';

class ItemNotification extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;

  const ItemNotification(
      { Key? key,
        required this.icon,
        required this.title,
        required this.subTitle
      })
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50.0,
        color: whiteColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10.0,right: 10.0),
                  child: CircleAvatar(
                    backgroundColor: primaryColor,
                    child: Icon(icon,color: whiteColor,),
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: Container(
                      height: 65.0,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(title,style: textBoldBlack,overflow: TextOverflow.ellipsis,),
                          Container(
                              child: Text(subTitle,style: textStyle,overflow: TextOverflow.ellipsis,)
                          )
                        ],
                      ),
                    )
                ),
                SizedBox(width: 10.0,)
              ],
            ),
           // Divider(),
          ],
        )
    );
  }
}
