import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/Components/ink_well_custom.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:com_basoft_customer_ba/Screen/Menu/menu_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:com_basoft_customer_ba/Components/listMenu.dart';
import 'invite_friends.dart';
import 'package:com_basoft_customer_ba/Screen/MyProfile/edit_profile.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final String screenName = "SETTINGS";


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: whiteColor,
        title: Text('Settings',style: TextStyle(color: blackColor),),
      ),
      drawer: MenuScreens(activeScreenName: screenName),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: SingleChildScrollView(
          child: InkWellCustom(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Container(
                color: greyColor2,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                            return EditProfile();
                          },
                        ));
                      },
                      child: Container(
                        color: whiteColor,
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(top: 10.0,bottom: 20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(50.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Container(
                                      height: 80.0,
                                      width: 80.0,
                                      child: Image.asset('assets/image/taxi-driver.png',fit: BoxFit.cover, height: 100.0,width: 100.0,)
                                  )
                              ),
                            ),
                            Container(
                              width: screenSize.width * 0.7 ,
                              padding: EdgeInsets.only(left: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text("Steve Bowen",style: textBoldBlack,),
                                      ),
                                      Container(
                                          child: Text("\$25.0",style: heading18Black,)
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    ListsMenu(
                      title: "100 Point * Member",
                      onPress: (){

                      },
                    ),
                    ListsMenu(
                      title: "Reviews",
                      onPress: (){

                      },
                    ),
                    ListsMenu(
                      title: "Invite Friends",
                      onPress: (){
                        Navigator.of(context).push(MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return InviteFriends();
                            },
                            fullscreenDialog: true));
                      },
                    ),
                    ListsMenu(
                      title: "Notification",
                      onPress: (){

                      },
                    ),
                    ListsMenu(
                      title: "Terms & Privacy Policy",
                      onPress: (){

                      },
                    ),
                    ListsMenu(
                      title: "Contact us",
                      onPress: (){

                      },
                    ),
                  ],
                )
            ),
          ),
        ),
      )
    );
  }
}
