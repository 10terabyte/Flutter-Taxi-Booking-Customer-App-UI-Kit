import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/Components/animation_list_view.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:com_basoft_customer_ba/Screen/Menu/menu_screen.dart';
import 'detail_screen.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final String screenName = "HISTORY";

  navigateToDetail(String id) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryDetail(id: id,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuScreens(activeScreenName: screenName),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 100.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("History",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )
                ),
                background: Container(
                  color: whiteColor,
                ),
              ),
            ),
          ];
        },
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowGlow();
            return false;
          },
          child: ListView.separated(
              itemCount: 5,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              separatorBuilder:(_,int i){
                return Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                return AnimationListView(
                    index: index,
                    child: GestureDetector(
                        onTap: () {
                          print('$index');
                          navigateToDetail(index.toString());
                        },
                        child: rideHistory()
                    )
                );
              }
          ),
        ),
      ),
    );
  }

  Widget rideHistory(){
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: whiteColor,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: whiteColor
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("8 June 2019, 18:39",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text("Cancelled".toUpperCase(),
                  style: TextStyle(
                    color: redColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0
                  ),
                )
              ],
            ),

            Divider(),
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("10:24",
                            style: TextStyle(
                              color: Color(0xFF97ADB6),
                              fontSize: 13.0
                            ),
                          ),

                          Text("10:50",
                            style: TextStyle(
                              color: Color(0xFF97ADB6),
                              fontSize: 13.0
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.my_location, color: blackColor,),
                        Container(
                          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          height: 25,
                          width: 1.0,
                          color: Colors.grey,
                        ),
                        Icon(Icons.location_on, color: blackColor,)
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('1, Thrale Street, London, SE19HW, UK',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text('Ealing Broadway Shopping Centre, London, W55JY, UKK',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
