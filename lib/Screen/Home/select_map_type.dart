import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/Model/map_type_model.dart';

class SelectMapTypeView extends StatelessWidget {
  final MapTypeModel _item;
  SelectMapTypeView(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 70.0,
            width: 70.0,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 3.0,
                  color: _item.isSelected
                      ? Colors.blueAccent
                      : Colors.white),
              borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
              image: DecorationImage(
                image: AssetImage(
                    _item.image
                ),
                fit: BoxFit.cover
              )
            ),
          ),
          Container(
            child: Text(_item.text),
          )
        ],
      ),
    );
  }
}

