import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/app_router.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'icon_action_widget.dart';

class ArrivingDetail extends StatelessWidget {
  final VoidCallback onTapCall;
  final VoidCallback onTapChat;
  final VoidCallback onTapCancel;

  ArrivingDetail({
    required this.onTapCall,
    required this.onTapChat,
    required this.onTapCancel
});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.0,
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      child: Column(
        children: <Widget>[
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Material(
                      elevation: 10.0,
                      color: Colors.white,
                      shape: CircleBorder(),
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: SizedBox(
                          height: 70,
                          width: 70,
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
                    SizedBox(height: 5),
                    Text("Patrick",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Color(0xFFD5DDE0),
                        ),
                        padding: EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 5.0),
                        child: Text('MP09QA1222',
                          style: TextStyle(
                            fontSize: 18,
                            color: blackColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Text("Volkswagen Jetta",style: textGrey,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('4.3',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey
                            ),
                          ),
                          Icon(Icons.star,
                            color: primaryColor,
                            size: 15,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconAction(
                  icon: Icons.call,
                  onTap: onTapCall,
                ),
                IconAction(
                  icon: MdiIcons.chatOutline,
                  onTap: onTapChat,
                ),
                IconAction(
                  icon: Icons.clear,
                  onTap: onTapCancel,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(AppRoute.reviewTripScreen);
            },
            child: Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(5.0),
              child: Text("Skip"),
            ),
          )
        ],
      ),
    );
  }
}
