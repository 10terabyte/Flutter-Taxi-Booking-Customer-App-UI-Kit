import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';

class NotificationDetail extends StatefulWidget {

  final String id;

  NotificationDetail({required this.id});

  @override
  _NotificationDetailState createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.id);
  }

  dialogInfo(){
    AlertDialog(
      title: Text("Information"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      content: Text('Delete successful'),
      actions: <Widget>[
        TextButton(
          child: Text('Ok'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Notification Detail',style: TextStyle(color: blackColor),),
          backgroundColor: whiteColor,
          elevation: 2.0,
          iconTheme: IconThemeData(color: blackColor),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.restore_from_trash,color: blackColor,),
                onPressed: (){showDialog(context: context, builder: dialogInfo());}
            )
          ]
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 220.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill, image: AssetImage('assets/image/news.jpg')
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "CDC",
                        style: textBoldBlack,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Icon(
                          Icons.access_time,
                          size: 20.0,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                          child: Text(
                            "1h ago",
                            style: textBoldBlack,
                          )),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                              border: Border(
                                bottom: const BorderSide(
                                    width: 1.0,
                                    color: secondary),
                              )),
                          child: Text(
                            "ENVIRONMENT",
                            style: textStyleActive,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Text("Flutter is Google's mobile app SDK for crafting high-quality native interfaces on iOS and Android in record time",style: heading18Black,),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Text(
                    "Flutter is Google's mobile app SDK for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source."
                        "We want to enable designers to deliver their full creative vision without being forced to water it down due to limitations of the underlying framework. Flutter's layered architecture gives you control over every pixel on the screen, and its powerful compositing capabilities let you overlay and animate graphics, video, text and controls without limitation. Flutter includes a full set of widgets that deliver pixel-perfect experiences on both iOS and Android.",
                    style: textStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
