import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/Components/animation_list_view.dart';
import 'package:com_basoft_customer_ba/Screen/Menu/menu_screen.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'detail.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'itemNotification.dart';

class NotificationScreens extends StatefulWidget {
  @override
  _NotificationScreensState createState() => _NotificationScreensState();
}

class _NotificationScreensState extends State<NotificationScreens> {
  final String screenName = "NOTIFICATIONS";
  List<Map<String, dynamic>> listNotification = <Map<String, dynamic>>[];

  navigateToDetail(String id) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NotificationDetail(
              id: id,
            )));
  }

  dialogInfo() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text("Confirm Delete"),
            content: Text("Are you sure delete all notification ?"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'CANCEL',
                    style: textGrey,
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      listNotification.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text('OK')),
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listNotification = [
      {
        "id": '0',
        "title": 'System',
        "subTitle": "Flutter works with exiting code, is used by",
        "icon": Icons.check_circle
      },
      {
        "id": '1',
        "title": 'Promition',
        "subTitle": "Invite friends - Get 3 coupons each!",
        "icon": MdiIcons.camcorder
      },
      {
        "id": '2',
        "title": 'Promition',
        "subTitle": "Invite friends - Get 3 coupons each!",
        "icon": MdiIcons.camcorder
      },
      {
        "id": '3',
        "title": 'System',
        "subTitle": "Booking #1223 has been cancelled!",
        "icon": MdiIcons.cancel
      },
      {
        "id": '3',
        "title": 'System',
        "subTitle": "Thank you! Your trancastion is!",
        "icon": Icons.check_circle
      },
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Notification',
            style: TextStyle(color: blackColor),
          ),
          backgroundColor: whiteColor,
          elevation: 0.0,
          iconTheme: IconThemeData(color: blackColor),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.restore_from_trash,
                  color: blackColor,
                ),
                onPressed: () {
                  dialogInfo();
                })
          ]),
      drawer: MenuScreens(activeScreenName: screenName),
      body: listNotification.length != 0
        ? NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowGlow();
              return false;
            },
            child: AnimationLimiter(
              child: ListView.builder(
                  itemCount: listNotification.length,
                  padding: EdgeInsets.only(top: 0),
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationListView(
                      index: index,
                      child: Slidable(
                          // actionPane: SlidableScrollActionPane(),
                          // actionExtentRatio: 0.25,
                          // secondaryActions: <Widget>[
                          //   IconSlideAction(
                          //     caption: 'Delete',
                          //     color: Colors.red,
                          //     icon: Icons.delete,
                          //     onTap: () {
                          //       setState(() {
                          //         listNotification.removeAt(index);
                          //       });
                          //     },
                          //   ),
                          // ],
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: greyColor2, width: 1))),
                              child: GestureDetector(
                                  onTap: () {
                                    print('$index');
                                    navigateToDetail(index.toString());
                                  },
                                  child: ItemNotification(
                                    title: listNotification[index]
                                    ['title'],
                                    subTitle: listNotification[index]
                                    ['subTitle'],
                                    icon: listNotification[index]['icon'],
                                  )))),
                    );
                  }),
            )
          )
          : Container(
              child: Center(
                child: Image.asset(
                  'assets/image/empty_state_trash_300.png',
                  width: 100.0,
                ),
              ),
            ),
    );
  }
}
