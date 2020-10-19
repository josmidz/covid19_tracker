import 'package:covid19_tracker/blocs/user/user_bloc.dart';
import 'package:covid19_tracker/screens/user/edit_screen.dart';
import 'package:covid19_tracker/screens/user/profil_screen.dart';
import 'package:covid19_tracker/screens/user/welcome_screen.dart';
import 'package:covid19_tracker/utils/busy_dialogs.dart';
import 'package:covid19_tracker/utils/capitalize_text.dart';
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:covid19_tracker/utils/ct_shadow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with TickerProviderStateMixin {
  TabController _tabController;
  _hideKeyboard({BuildContext context}){
    FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
  }
  int _currentIndex = 0;
  PageController _pageController = PageController();
  BuildContext _ctx;
  final _keyLoader = GlobalKey<State>();

  final _listPage = [
    WelcomeScreen(),
    EditScreen(),
    ProfilScreen(),
  ];
  @override
  void initState() {
    _tabController = TabController(length: 3,vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _ctx = context;
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
            "C.TRACKER DASHBOARD",
            style: TextStyle(
              color: ctColor1,
              // fontSize: 21
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                LineAwesomeIcons.power_off
              ), 
              onPressed: (){
                BusyDialog.showLoadingDialog(context: context,key: _keyLoader,title: 'Déconnexion');
                Future.delayed(Duration(milliseconds: 300),(){
                  _logOut();
                });
              }
            )
          ],
        ),
        backgroundColor: ctColor10,
        body: Container(
            // padding: EdgeInsets.only(left: 8.0),
            child: Stack(
              children: [
                // Positioned(
                //   top: -35,
                //   right: -40,
                //   child: Container(
                //     height: 300,
                //     width: 0.7* MediaQuery.of(context).size.width,
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: AssetImage('assets/images/usa.png'),
                //         fit: BoxFit.cover
                //       ),
                //     ),
                //   ),
                // ),
                Positioned(
                  top: -30,
                  right: -70,
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: userBloc.userBlocDataModel.countryflagBytes == null
                        ? AssetImage('assets/images/empty_image.png')
                        : MemoryImage(userBloc.userBlocDataModel.countryflagBytes),
                        fit: BoxFit.cover
                      ),
                      shape: BoxShape.circle
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userBloc.userBlocDataModel.countryname == null
                        ? "---"
                        : capitalizeText(userBloc.userBlocDataModel.countryname),
                          style: TextStyle(
                            color: ctColor2,
                            fontSize: 21
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 0.4 * MediaQuery.of(context).size.width,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text(
                           _currentIndex ==0
                           ? "Accueil"
                           :_currentIndex ==1
                           ? "Encodage"
                           : "Profil",
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
                    top: 0.20 * MediaQuery.of(context).size.height,
                    left: 0.08 * MediaQuery.of(context).size.width),
                  height: 0.5 * MediaQuery.of(context).size.height,
                  width: 0.8 * MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: ctColor1,
                    boxShadow: customShadow
                  ),
                  child: Column(
                     children: [
                        Expanded(
                          child: PageView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: _listPage.length,
                            controller: _pageController,
                            onPageChanged: (i){
                              _currentIndex = i;
                              setState(() {});
                              _tabController.animateTo(i);
                            },
                            itemBuilder: (_,i){
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: _listPage[i]);
                            }
                          ),
                        )
                     ],
                  ),
                ),
              ],
            ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: ctColor2
          ),
          child: Material(
            type: MaterialType.transparency,
            child: TabBar(
              controller: _tabController,
              indicatorColor: ctColor10,
              onTap: (v){
                _pageController.animateToPage(
                v, 
                duration: Duration(milliseconds: 400), 
                curve: Curves.easeIn);
              },
              tabs: [
                Tab(
                  text: "Accueil",
                  icon: Icon(LineAwesomeIcons.home),
                ),
                Tab(
                  text: "Encodage",
                  icon: Icon(LineAwesomeIcons.edit_1),
                ),
                Tab(
                  text: "User",
                  icon: Icon(LineAwesomeIcons.user_circle_1),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }

  void _logOut() async {
    await userBloc.userLogOut();
    Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
    Navigator.of(_ctx).pop();
  }
}