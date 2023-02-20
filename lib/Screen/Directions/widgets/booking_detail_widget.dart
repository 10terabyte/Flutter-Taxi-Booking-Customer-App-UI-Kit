import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BookingDetailWidget extends StatelessWidget {
  final VoidCallback bookingSubmit;
  final PanelController panelController;
  final String distance;
  final String duration;
  final VoidCallback onTapOptionMenu;
  final VoidCallback onTapPromoMenu;

  BookingDetailWidget({
    required this.bookingSubmit,
    required this.panelController,
    required this.distance,
    required this.duration,
    required this.onTapOptionMenu,
    required this.onTapPromoMenu
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.0,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Suggest service',
                  style: TextStyle(
                      fontSize: 18,
                      color: blackColor,
                      fontWeight: FontWeight.bold
                  ),
                ),
                InkWell(
                  onTap: (){
                    panelController?.open();
                  },
                  child: Row(
                    children: <Widget>[
                      Text('View all',
                        style: TextStyle(
                            fontSize: 18,
                            color: primaryColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 5.0,),
                      Icon(Icons.expand_less,
                        color: greyColor,
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              panelController?.open();
            },
            child: Container(
              height: 70.0,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: primaryColor.withOpacity(0.5),
                      width: 1.0
                  ),
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Image.asset('assets/image/icon_taxi/1.png',
                                    height: 50,
                                  ),
                                  Text("Standard",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0Xff3E4958)
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(distance != null ? distance : "0 km",style: textGrey,),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('\$20.45',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0Xff3E4958),
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 5),
                            Material(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              ),
                              color: Color(0xFFD5DDE0),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 5.0),
                                child: Text(duration != null ? duration : "0 mins",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  )
                ],
              ),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 1.0,
            color: greyColor2,
          ),

          Container(
            color: whiteColor,
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                      onTap: onTapOptionMenu, // ()  =>showDialog(context: context, child: dialogOption()),
                      child: Column(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.cogs,color: blackColor,),
                          Text("Options",style: textStyle,),
                        ],
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                  width: 1.0,
                  height: 30.0,
                  color: Colors.grey.withOpacity(0.4),
                ),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                      onTap: onTapPromoMenu, // () => showDialog(context: context, child: dialogPromoCode()),
                      child: Column(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.gifts,color: blackColor,),
                          Text("Promo",style: textStyle,),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0,bottom: 20.0),
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width - 50.0,
              height: 50.0,
              child: TextButton(
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                // elevation: 0.0,
                // color: primaryColor,
                child: Text('Book Now',style: headingWhite,
                ),
                onPressed: bookingSubmit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
