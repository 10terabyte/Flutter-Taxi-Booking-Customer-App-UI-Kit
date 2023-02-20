import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SelectServiceWidget extends StatefulWidget {
  String serviceSelected;
  final PanelController panelController;
  SelectServiceWidget({required this.serviceSelected, required this.panelController});

  @override
  _SelectServiceWidgetState createState() => _SelectServiceWidgetState();
}

class _SelectServiceWidgetState extends State<SelectServiceWidget> {
  List<Map<String, dynamic>> listService = [
    {"id": '0',"name" : 'Standard',"price" : "\$6 - \$7","time" : "3 min", "image": "assets/image/icon_taxi/1.png"},
    {"id": '1',"name" : 'Fash Taxi',"price" : "\$8 - \$10","time" : "2 min", "image": "assets/image/icon_taxi/2.png"},
    {"id": '2',"name" : 'Moto',"price" : "\$3 - \$5","time" : "5 min", "image": "assets/image/icon_taxi/3.png"},
    {"id": '3',"name" : 'Van',"price" : "\$9 - \$11","time" : "5 min", "image": "assets/image/icon_taxi/4.png"},
    {"id": '4',"name" : 'Taxi Vip',"price" : "\$20","time" : "7-10 min", "image": "assets/image/icon_taxi/5.png"},
    {"id": '5',"name" : 'Taxi Vip 7',"price" : "\$25","time" : "7-10 min", "image": "assets/image/icon_taxi/6.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                    color: Color(0xFFD5DDE0),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
              ),
            ],
          ),
          //SizedBox(height: 18.0,),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listService.length,
              itemBuilder: (BuildContext context, int index){
                return serviceObject(
                  image: listService[index]['image'],
                  name: listService[index]['name'],
                  price: listService[index]['price'],
                  time: listService[index]['time'],
                  isSelect: widget?.serviceSelected == listService[index]['id'],
                  onTap: (){
                    setState(() {
                      widget?.serviceSelected = listService[index]['id'];
                      widget?.panelController?.close();
                    });
                  }
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget serviceObject({required String image, required String name, required String price, required String time, required bool isSelect, required VoidCallback onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            color: isSelect == true ? appTheme?.primaryColor?.withOpacity(0.4) : whiteColor,
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(image,
                        height: 60,
                      ),
                      Text(name ?? '',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0Xff3E4958)
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(price ?? '\$0',
                          style: TextStyle(
                              fontSize: 26,
                              color: Color(0Xff3E4958),
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 10),
                        Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                          color: Color(0xFFD5DDE0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 5.0),
                            child: Text(time ?? "0 min",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(height: 0,color: greyColor,)
        ],
      ),
    );
  }
}
