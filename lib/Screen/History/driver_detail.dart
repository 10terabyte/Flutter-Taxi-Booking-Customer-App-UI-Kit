import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';

class DriverDetailScreen extends StatefulWidget {
  @override
  _DriverDetailScreenState createState() => _DriverDetailScreenState();
}

class _DriverDetailScreenState extends State<DriverDetailScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Driver Detail",
          style: TextStyle(color: blackColor),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              color: whiteColor,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(70.0),
                    child:  SizedBox(
                      height: 70,
                      width: 70,
                      child: Hero(
                        tag: "avatar_profile",
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            backgroundImage: CachedNetworkImageProvider(
                              "https://source.unsplash.com/300x300/?portrait",
                            )
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text("Steve Bowen",style: textBoldBlack,),
                        ),
                        Text("08 Jan 2019 15:34",style: textStyle,),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  itemInfo1(icon: Icons.star, value: "4.5"),
                  itemInfo1(icon: Icons.favorite, value: "126"),
                  itemInfo1(icon: Icons.calendar_today, value: "1 years"),

                ],
              ),
            ),
            info2(),
          ],
        ),
      ),
    );
  }

  Widget itemInfo1({required IconData icon, required String value}){
    final screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(left: 5.0, right: 5.0),
      width: (screenSize.width-70)/3,
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(
          color: greyColor2,
          width: 1.0
        ),
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: greyColor2
            ),
            child: Icon(icon, color: whiteColor,),
          ),
          SizedBox(height: 2.0,),
          Text(value ?? '',
            style: TextStyle(
              color: blackColor,
              fontSize: 15
            ),
          ),
        ],
      ),
    );
  }

  Widget info2(){
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 40),
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          border: Border.all(
              color: greyColor2,
              width: 1.0
          ),
          borderRadius: BorderRadius.circular(15.0)
      ),
      child: Column(
        children: <Widget>[
          TextField(
            style: TextStyle(color: blackColor, fontSize: 15),
            decoration: InputDecoration(
              enabled: false,
              fillColor: whiteColor,
              labelStyle: TextStyle(color: greyColor),
              hintStyle: TextStyle(color: Colors.white),
              counterStyle: textStyle,
              labelText: "Member since",
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))
            ),
            controller:
            TextEditingController.fromValue(
              TextEditingValue(
                text: "16.06.2018",
              ),
            ),
          ),
          TextField(
            style: TextStyle(color: blackColor, fontSize: 15),
            decoration: InputDecoration(
              enabled: false,
              fillColor: whiteColor,
              labelStyle: TextStyle(color: greyColor),
              hintStyle: TextStyle(color: Colors.white),
              counterStyle: textStyle,
              labelText: "Car Type",
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))
            ),
            controller:
            TextEditingController.fromValue(
              TextEditingValue(
                text: "Van",
              ),
            ),
          ),
          TextField(
            style: TextStyle(color: blackColor, fontSize: 15),
            decoration: InputDecoration(
              enabled: false,
              fillColor: whiteColor,
              labelStyle: TextStyle(color: greyColor),
              hintStyle: TextStyle(color: Colors.white),
              counterStyle: textStyle,
              labelText: "Plae Number",
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))
            ),
            controller:
            TextEditingController.fromValue(
              TextEditingValue(
                text: "HS785K",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
