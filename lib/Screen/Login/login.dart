import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/Components/ink_well_custom.dart';
import 'package:com_basoft_customer_ba/app_router.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:com_basoft_customer_ba/Components/validations.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool autovalidate = false;
  Validations validations = Validations();

  submit(){
    final FormState? form = formKey.currentState;
    if (!form!.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form?.save();
      //code
      Navigator.of(context).pushReplacementNamed(AppRoute.phoneVerificationScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: InkWellCustom(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(children: <Widget>[
                    Container(
                      height: 250.0,
                      width: double.infinity,
                      color: Color(0xFFFDD148),
                    ),
                    Positioned(
                      bottom: 450.0,
                      right: 100.0,
                      child: Container(
                        height: 400.0,
                        width: 400.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.0),
                          color: Color(0xFFFEE16D),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 500.0,
                      left: 150.0,
                      child: Container(
                          height: 300.0,
                          width: 300.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150.0),
                              color: Color(0xFFFEE16D).withOpacity(0.5))),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(32.0, 150.0, 32.0, 0.0),
                        child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  //padding: EdgeInsets.only(top: 100.0),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(7.0),
                                      elevation: 5.0,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width - 20.0,
                                        height: MediaQuery.of(context).size.height *0.4,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20.0)),
                                        child: Form(
                                            key: formKey,
                                            child: Container(
                                              padding: EdgeInsets.all(32.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text('Login', style: heading35Black,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      TextFormField(
                                                          keyboardType: TextInputType.phone,
                                                          // validator: validations?.validateMobile,
                                                          decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              prefixIcon: Icon(Icons.phone,
                                                                  color: Color(getColorHexFromStr('#FEDF62')), size: 20.0),
                                                              contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                                                              hintText: 'Phone',
                                                              hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Quicksand')
                                                          )
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 50.0,
                                                    // minWidth: MediaQuery.of(context).size.width,
                                                    child: TextButton(
                                                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                                      // elevation: 0.0,
                                                      // color: primaryColor,
                                                      style: TextButton.styleFrom(
                                                        primary: Colors.blue,
                                                      ),
                                                      child: Text('NEXT', style: headingWhite,),
                                                      onPressed: (){
                                                        submit();
                                                        },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                        ),
                                      ),
                                    )
                                ),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Create account? ",style: textGrey,),
                                        InkWell(
                                          onTap: () => Navigator.of(context).pushNamed(AppRoute.signUpScreen),
                                          child: Text("Sign Up",style: textStyleActive,),
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            )
                        )
                    ),
                  ]
                  )
                ]
            ),
          )
      ),
    );
  }
}
