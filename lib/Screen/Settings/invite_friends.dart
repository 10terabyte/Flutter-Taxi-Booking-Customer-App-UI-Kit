import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';

class InviteFriends extends StatefulWidget {
  @override
  _InviteFriendsState createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: whiteColor,
        title: Text('Invite Friends',style: TextStyle(color: blackColor),),
//        leading: IconButton(
//          icon: Icon(Icons.arrow_back_ios,color: blackColor,),
//          onPressed: () => Navigator.of(context).pushReplacement(
//              MaterialPageRoute(builder: (context) => LoginScreen2())),
//        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(screenSize.width*0.13, 0.0, screenSize.width*0.13, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(100.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      color: primaryColor,
                        height: 180.0,
                        width: 180.0,
                        child: Icon(Icons.supervisor_account,color: blackColor,size: 100.0,)
                    )
                ),
              ),
            ),
            Container(
              child: Text("Invite Friend",style: headingBlack,),
            ),
            Container(
              child: Text("Earn up to \$150 a day",style: heading18Black,),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0,top: 20.0),
              child: Text("When your friend sign up with your referral code, you can receive up to \$150 a day.",style: textStyle,),
            ),
            Container(
              width: double.infinity,
              height: 45.0,
              decoration: BoxDecoration(
                color: greyColor2,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text("09867656",style: heading18Black,),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0),),
            ButtonTheme(
              height: 50.0,
              minWidth: MediaQuery.of(context).size.width,
              child: TextButton(
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                // elevation: 0.0,
                // color: primaryColor,
                // icon: Text(''),
                child: Text('INVITE', style: headingBlack,),
                onPressed: (){
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
