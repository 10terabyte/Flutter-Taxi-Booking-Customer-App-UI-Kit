import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';

class SelectAddress extends StatefulWidget {
  final String? fromAddress,toAddress;
  final VoidCallback? onTap;
  SelectAddress({
    this.fromAddress,
    this.toAddress,
    this.onTap
  });

  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  String? selectedAddress;
  List<Map<String, dynamic>> listAddress = [
    {"id": 1, "title": "San Antonio"},
    {"id": 2, "title": "Los Angeles"},
    {"id": 3,"title": "Mt San Antonio"},
    {"id": 4,"title": "Simi Valley"},
  ];

  Widget getOption() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: listAddress.length,
      itemBuilder: (BuildContext context,int index){
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: ChoiceChip(
            key: ValueKey<String>(listAddress[index]['id'].toString()),
            labelStyle: TextStyle(
                color: whiteColor
            ),
            backgroundColor: whiteColor,
            selectedColor: primaryColor,
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            selected: selectedAddress == listAddress[index]['id'].toString(),
            label: Text(listAddress[index]['title'],
              style: TextStyle(
                color: selectedAddress == listAddress[index]['id'].toString() ? whiteColor : blackColor
              ),
            ),
            onSelected: (bool check) {
              widget?.onTap!();
//              setState(() {
//                selectedAddress = check ? listAddress[index]["id"].toString() : '';
//              });
            })
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.my_location),
                      Container(
                        height: 40,
                        width: 1.0,
                        color: Colors.grey,
                      ),
                      Icon(Icons.location_on,color: redColor,)
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("PICKUP",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey
                                ),
                              ),
                              Text(
                                widget.fromAddress ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: textStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5,bottom: 5),
                        child: Divider(color: Colors.grey,)
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("DROP-OFF",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey
                                ),
                              ),
                              Text(
                                widget.toAddress ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: textStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowGlow();
                    return false;
                  },
                  child: getOption()
                )
              )
            )
          ],
        ),
      ),
    );
  }
}
