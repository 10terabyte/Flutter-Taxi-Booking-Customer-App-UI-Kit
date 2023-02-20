import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/Blocs/place_bloc.dart';
import 'package:com_basoft_customer_ba/Screen/Directions/direction_screen.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';

class SearchAddressView extends StatefulWidget {
  final PlaceBloc? placeBloc;
  SearchAddressView({this.placeBloc});

  @override
  _SearchAddressViewState createState() => _SearchAddressViewState();
}

class _SearchAddressViewState extends State<SearchAddressView> {
  String? valueFrom,valueTo;
  bool checkAutoFocus = false,inputFrom = false,inputTo = false;
  FocusNode nodeFrom = FocusNode();
  FocusNode nodeTo = FocusNode();
  String? formLocation;
  String? toLocation;

  @override
  void initState() {
    super.initState();
    formLocation = widget?.placeBloc?.formLocation?.name;
  }

  navigator(){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DirectionScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      child: Column(
        children: <Widget>[
          buildForm(widget.placeBloc!),
          Container(
            height: 20,
            color: Color(0xfff5f5f5),
          ),
          widget?.placeBloc?.listPlace != null ?
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: widget.placeBloc!.listPlace!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget?.placeBloc?.listPlace?[index].name ?? ''),
                  subtitle: Text(widget?.placeBloc?.listPlace?[index].formattedAddress ?? ''),
                  onTap: () {
                    widget?.placeBloc?.selectLocation(widget.placeBloc!.listPlace![index]! )?.then((_){
                      toLocation = widget?.placeBloc?.locationSelect?.name;
                      FocusScope.of(context).requestFocus(nodeTo);
                      navigator();
                    });
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: greyColor.withOpacity(0.5),
              ),
            ),
          ): addressDefault(),
        ],
      ),
    );
  }

  Widget buildForm(PlaceBloc placeBloc){

    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Icon(Icons.my_location),
                Container(
                  height: 30,
                  width: 1.0,
                  color: Colors.grey,
                ),
                Icon(Icons.location_on, color: redColor,)
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TextField(
                      style: textStyle,
                      focusNode: nodeFrom,
                      decoration: InputDecoration(
                        fillColor: whiteColor,
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: greyColor),
                        hintText: "From",
                      ),
                      controller: TextEditingController.fromValue(
                        TextEditingValue(
                          text: formLocation ?? '',
                          selection: TextSelection.collapsed(
                            offset: formLocation?.length  ??  0),
                        ),
                      ),
                      onChanged: (String value) async {
                        formLocation = value;
                        await placeBloc?.search(value);
                      },
                      onTap: (){
                        setState(() {
                          inputFrom = true;
                          inputTo = false;
                        });
                      },
                    ),
                    Container(
                        child: Divider(color: Colors.grey,)
                    ),
                    TextField(
                      style: textStyle,
                      autofocus: true,
                      focusNode: nodeTo,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "To",
                        hintStyle: TextStyle(
                            color: greyColor,
                            fontSize: 14
                        ),
                        contentPadding: EdgeInsets.only(top: 15.0),
//                                  suffixIcon: _addressTo != null ? IconButton(
//                                    icon: Icon(CupertinoIcons.clear_thick_circled,
//                                      size: 20,
//                                      color: greyColor2,
//                                    ),
//                                    onPressed: (){
//                                    },
//                                  ):SizedBox.shrink()
                      ),
                      controller: TextEditingController.fromValue(
                        TextEditingValue(
                          text: toLocation ??'',
                          selection: TextSelection.collapsed(
                              offset: toLocation?.length ?? 0),
                        ),
                      ),
                      onChanged: (String value) async {
                        toLocation = value;
                        await placeBloc?.search(value);
                      },
                      onTap: (){
                        setState(() {
                          inputTo = true;
                          inputFrom = false;
                          // print(inputTo);
                        });
                      },
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget addressDefault(){
    return Container(
      color: Color(0xfff5f5f5),
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 20),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: (){
            },
            child: Material(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.home, color: greyColor,),
                    SizedBox(width: 10),
                    Text("Home",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: (){
            },
            child: Material(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.work, color: greyColor,),
                    SizedBox(width: 10),
                    Text("Company",
                      style: TextStyle(
                          color: blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
