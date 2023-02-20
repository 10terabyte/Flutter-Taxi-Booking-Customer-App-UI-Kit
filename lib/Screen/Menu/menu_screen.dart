import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/Screen/MyProfile/profile.dart';
import 'package:com_basoft_customer_ba/app_router.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuItems {
  String name;
  IconData icon;
  MenuItems({required this.icon, required this.name});
}

class MenuScreens extends StatelessWidget {
  final String activeScreenName;

  MenuScreens({required this.activeScreenName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: EdgeInsets.all(0.0),
            accountName: Text("John",style: headingWhite,),
            accountEmail: Text("100 point - Gold member"),
            currentAccountPicture: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              backgroundImage: CachedNetworkImageProvider(
                "https://source.unsplash.com/300x300/?portrait",
              )
            ),
            onDetailsPressed: (){
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute<Null>(
                  builder: (BuildContext context) {
                    return ProfileScreen();
                  },
                  fullscreenDialog: true
                )
              );
            },
          ),
          MediaQuery.removePadding(
            context: context,
            // DrawerHeader consumes top MediaQuery padding.
            removeTop: true,
            child: Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowGlow();
                    return false;
                  },
                child: ListView(
                  //padding: const EdgeInsets.only(top: 8.0),
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        // The initial contents of the drawer.
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).pushNamedAndRemoveUntil(AppRoute.homeScreen, (Route<dynamic> route) => false);},
                              child: Container(
                                height: 60.0,
                                color: this.activeScreenName.compareTo("HOME") == 0 ? greyColor2 : whiteColor,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Icon(FontAwesomeIcons.home,color: blackColor,),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text('Home',style: headingBlack,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).pushNamedAndRemoveUntil(AppRoute.homeScreen2, (Route<dynamic> route) => false);},
                              child: Container(
                                height: 60.0,
                                color: this.activeScreenName.compareTo("HOME2") == 0 ? greyColor2 : whiteColor,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Icon(FontAwesomeIcons.home,color: blackColor,),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text('Home 2',style: headingBlack,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).pushNamed(AppRoute.paymentMethodScreen);
                              },
                              child: Container(
                                height: 60.0,
                                color: this.activeScreenName.compareTo("PAYMENT") == 0 ? greyColor2 : whiteColor,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Icon(FontAwesomeIcons.wallet,color: blackColor,),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text('Payment',style: headingBlack,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).pushNamed(AppRoute.historyScreen);
                              },
                              child: Container(
                                height: 60.0,
                                color: this.activeScreenName.compareTo("HISTORY") == 0 ? greyColor2 : whiteColor,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Icon(FontAwesomeIcons.history,color: blackColor,),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text('History',style: headingBlack,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).pushNamed(AppRoute.notificationScreen);
                              },
                              child: Container(
                                height: 60.0,
                                color: this.activeScreenName.compareTo("NOTIFICATIONS") == 0 ? greyColor2 : whiteColor,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Icon(FontAwesomeIcons.bell,color: blackColor,),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text('Notifications',style: headingBlack,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).pushNamed(AppRoute.termsConditionsScreen);
                              },
                              child: Container(
                                height: 60.0,
                                color: this.activeScreenName.compareTo("TERMS") == 0 ? greyColor2 : whiteColor,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Icon(FontAwesomeIcons.cogs,color: blackColor,),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text('Terms & Conditions',style: headingBlack,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).pushReplacementNamed(AppRoute.loginScreen);
                              },
                              child: Container(
                                height: 60.0,
                                color: whiteColor,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Icon(FontAwesomeIcons.signOutAlt,color: blackColor,),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text('Logout',style: headingBlack,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // The drawer's "details" view.
                      ],
                    ),
                  ],
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
