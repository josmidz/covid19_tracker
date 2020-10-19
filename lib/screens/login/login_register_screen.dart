import 'package:covid19_tracker/screens/login/login_screen.dart';
import 'package:covid19_tracker/screens/login/password_int_screen.dart';
import 'package:covid19_tracker/screens/register/register_home.dart';
import 'package:covid19_tracker/screens/register/success_screen.dart';
import 'package:covid19_tracker/screens/user/user_screen.dart';
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:covid19_tracker/utils/ct_shadow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

enum ENavigation{
  login,
  initpassword,
  register,
  successscreen,
}

class LoginRegisterScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  LoginRegisterScreen({this.onLoginSuccess});
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {

  _hideKeyboard({BuildContext context}){
    FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
  }
  int _currentIndex = 0;
  PageController _pageController = PageController();
  ENavigation _eNavigation = ENavigation.login;


  void _navigationFx({ENavigation eNavigation,}){
    _eNavigation = eNavigation;
    switch (_eNavigation) {
      case ENavigation.login:
        _currentIndex = ENavigation.login.index;
        setState(() {});
        _pageController.animateToPage(
          _currentIndex, 
          duration: Duration(milliseconds: 100), 
          curve: Curves.easeOut);
        break;
      case ENavigation.register:
        _currentIndex = ENavigation.register.index;
        print(_currentIndex);
        setState(() {});
        _pageController.animateToPage(
          _currentIndex, 
          duration: Duration(milliseconds: 100), 
          curve: Curves.easeOut);
        break;
      case ENavigation.initpassword:
        _currentIndex = ENavigation.initpassword.index;
        setState(() {});
        _pageController.animateToPage(
          _currentIndex, 
          duration: Duration(milliseconds: 100), 
          curve: Curves.easeOut);
        break;
      case ENavigation.successscreen:
        _currentIndex = ENavigation.successscreen.index;
        setState(() {});
        _pageController.animateToPage(
          _currentIndex, 
          duration: Duration(milliseconds: 100), 
          curve: Curves.easeOut);
        break;
      default:
        _currentIndex =  ENavigation.login.index;
        setState(() {});
        _pageController.animateToPage(
          _currentIndex, 
          duration: Duration(milliseconds: 100), 
          curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>_hideKeyboard(context: context),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ctColor2,
          leading: CupertinoButton(
            onPressed:()=> Navigator.of(context).pop(),
            padding: EdgeInsets.zero,
            child: Icon(LineAwesomeIcons.arrow_left,color: ctColor1,),
          ),
          centerTitle: false,
          title: Text(
            "COVID-19 TRACKER",
            style: TextStyle(
              color: ctColor1,
              // fontSize: 21
            ),
          ),
        ),
        backgroundColor: ctColor10,
        body: Container(
          padding: EdgeInsets.only(left: 8.0),
          child: Stack(
            children: [
              Positioned(
                top: -40,
                right: -40,
                child: Container(
                  height: 300,
                  width: 0.7 * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/covid.gif'),
                      fit: BoxFit.cover
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 10.0,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bienvenue !",
                      style: TextStyle(
                        color: ctColor2,
                        fontSize: 21
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 0.4 * MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Text(
                         _currentIndex ==0
                         ? "Connectez-vous afin de debloquer d'autres fonctionnalités"
                         : "Vous n'avez pas encore un compte ? Créez-en un afin de debloquer d'autres fonctionnalités",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: ctColor11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 0.25 * MediaQuery.of(context).size.height,
                  left: 0.08 * MediaQuery.of(context).size.width),
                height: 0.5 * MediaQuery.of(context).size.height,
                width: 0.8 * MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: ctColor1,
                  boxShadow: customShadow
                ),
                child: Column(
                   children: [
                      Expanded(
                        child: PageView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          controller: _pageController,
                          onPageChanged: (i){
                            _currentIndex = i;
                            setState(() {});
                          },
                          itemBuilder: (_,i){
                            return Container(child:
                            i==0?LoginScreen(
                              onLoginSuccess:widget.onLoginSuccess,
                              openRegister: (){
                                _hideKeyboard(context: context);
                                _navigationFx(eNavigation:ENavigation.register);
                              },
                            )
                            : i==1 
                            ? PasswordInitScreen(
                              voidCallback: (){
                                _hideKeyboard(context: context);
                                _navigationFx(eNavigation:ENavigation.initpassword);
                              },
                            )
                            : i== 2
                            ?RegisterHome(
                              openLogin: (){
                                _hideKeyboard(context: context);
                                _navigationFx(eNavigation:ENavigation.login);
                              },
                            )
                            : SuccessScreen(
                                callbackAction: (){
                                  _hideKeyboard(context: context);
                                  _navigationFx(eNavigation:ENavigation.login);
                                },
                              )     
                            );
                          }
                        ),
                      )
                   ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}