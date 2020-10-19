import 'package:covid19_tracker/screens/register/auth_screen.dart';
import 'package:covid19_tracker/screens/register/register_screen.dart';
import 'package:covid19_tracker/screens/register/success_screen.dart';
import 'package:flutter/material.dart';

class RegisterHome extends StatefulWidget {
  final Function openLogin;
  RegisterHome({this.openLogin});
  @override
  _RegisterHomeState createState() => _RegisterHomeState();
}

class _RegisterHomeState extends State<RegisterHome> {
  PageController _pageController = PageController();

  var _listPage = [];

  void _toggleNext(int page){
    _pageController.animateToPage(page, duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  void initState() {
    _listPage = [
    RegisterScreen(openLogin: widget.openLogin,toggleNext: _toggleNext,),
    AuthScreen(openLogin: widget.openLogin,toggleNext: _toggleNext,),
    SuccessScreen(callbackAction: widget.openLogin,),
  ];
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: _listPage.length,
              controller: _pageController,
              onPageChanged: (i){
              },
              itemBuilder: (_,i){
                return SingleChildScrollView(
                  child: _listPage[i]);
              }
            ),
          )
        ],
      ),
    );
  }
}