import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:com_basoft_customer_ba/Screen/Menu/menu_screen.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final String screenName = "PAYMENT";

  List<Map<String, dynamic>> listService = [
    {"id": '0',"name" : 'VISA',"numberCard" : "**** **** **** 1234","image" : "assets/image/image_visa.png",},
    {"id": '1',"name" : 'Paypal',"numberCard" : "1234 5678 9123 4569", "image": "assets/image/image_paypal.png"},
    {"id": '2',"name" : 'Master Card',"numberCard" : "1234 5678 9123 4569","image": "assets/image/image_mastercard.png"},
  ];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment method',style: TextStyle(color: blackColor),),
        backgroundColor: whiteColor,
        elevation: 2.0,
        iconTheme: IconThemeData(color: blackColor),

      ),
      drawer: MenuScreens(activeScreenName: screenName),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: (){
              },
              child: Container(
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x88999999),
                        offset: Offset(0, 5),
                        blurRadius: 5.0,
                      ),
                    ]),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Icon(FontAwesomeIcons.wallet,color: blackColor,),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text("Add a card",style: textBoldBlack,)
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.arrow_forward_ios,color: blackColor,),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30.0,bottom: 10.0),
              child: Text('CREDIT CARDS',style: textStyle,),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listService.length,
                itemBuilder: (BuildContext context, index){
                  return creditCard(listService[index]['image'],listService[index]['numberCard'],listService[index]['name']);
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget creditCard(String image, String numberCard, String nameCard){
    return Container(
      padding: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 10.0,right: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
//          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color(0x88999999),
              offset: Offset(0, 5),
              blurRadius: 5.0,
            ),
          ]),
      child: Row(
        children: <Widget>[
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              color: greyColor2,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Image.asset(image,height: 45.0,)
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(numberCard,style: textBoldBlack,),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
                Text(nameCard,style: textGrey,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
