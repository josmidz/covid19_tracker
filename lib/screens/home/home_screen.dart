import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19_tracker/anim/anim_helper.dart';
import 'package:covid19_tracker/blocs/app_event.dart';
import 'package:covid19_tracker/blocs/covid/covid_bloc.dart';
import 'package:covid19_tracker/blocs/user/user_bloc.dart';
import 'package:covid19_tracker/screens/about/about_screen.dart';
import 'package:covid19_tracker/screens/conseils/conseil_screen.dart';
import 'package:covid19_tracker/screens/home/covid_card_view_model.dart';
import 'package:covid19_tracker/screens/home/painter_clippers/painter_clippers.dart';
import 'package:covid19_tracker/screens/home/widget/anim_cicular_chart.dart';
import 'package:covid19_tracker/screens/home/widget/anim_linear_chart.dart';
import 'package:covid19_tracker/screens/login/login_register_screen.dart';
import 'package:covid19_tracker/screens/user/user_screen.dart';
import 'package:covid19_tracker/utils/capitalize_text.dart';
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:covid19_tracker/utils/ct_list_colors.dart';
import 'package:covid19_tracker/widget/fail_screen.dart';
import 'package:covid19_tracker/widget/loading_widget.dart';
import 'package:covid19_tracker/widget/no_datafound_screen.dart';
import 'package:covid19_tracker/widget/no_network_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<dynamic> _listStat = [
    {
      "title":"Nouveaux cas",
      "valeur": 89438,
    },
    {
      "title":"Décès",
      "valeur": 8938,
    },
    {
      "title":"Guéri(s)",
      "valeur": 5438,
    },
  ];

  List<dynamic> _listCovidInfo = <Map<String,dynamic>>[
    {
      "title":"Nouveau cas",
      "gen_value":84242,
      "info":[
        {
          "country":"USA",
          "flag":"assets/images/usa.png",
          "stats":[
            {
              "title":"Nouveaux cas",
              "valeur": 89438,
            },
            {
              "title":"Décès",
              "valeur": 8938,
            },
            {
              "title":"Guéri(s)",
              "valeur": 5438,
            },
          ],
          "expert":{
            "name":"josmidz delatour",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.",
            "photo":"assets/images/user_pic.png"
          }
        },
        {
          "country":"AFRIQUE DU SUD",
          "flag":"assets/images/sudaf.png",
          "stats":[
            {
              "title":"Nouveaux cas",
              "valeur": 9438,
            },
            {
              "title":"Décès",
              "valeur": 3938,
            },
            {
              "title":"Guéri(s)",
              "valeur": 438,
            },
          ],
          "expert":{
            "name":"alba conord",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.",
            "photo":"assets/images/user_pic.png"
          }
        },
        {
          "country":"CANADA",
          "flag":"assets/images/canada.png",
          "stats":[
            {
              "title":"Nouveaux cas",
              "valeur": 738,
            },
            {
              "title":"Décès",
              "valeur": 38,
            },
            {
              "title":"Guéri(s)",
              "valeur": 138,
            },
          ],
          "expert":{
            "name":"smith perez",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.",
            "photo":"assets/images/user_pic.png"
          }
        },
      ]
    },
    {
      "title":"Décès",
      "gen_value":424242,
      "info":[
        {
          "country":"AFRIQUE DU SUD",
          "flag":"assets/images/sudaf.png",
          "stats":[
            {
              "title":"Nouveaux cas",
              "valeur": 6438,
            },
            {
              "title":"Décès",
              "valeur": 238,
            },
            {
              "title":"Guéri(s)",
              "valeur":95,
            },
          ],
          "expert":{
            "name":"josmidz delatour",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.",
            "photo":"assets/images/user_pic.png"
          }
        },
        {
          "country":"USA",
          "flag":"assets/images/usa.png",
          "stats":[
            {
              "title":"Nouveaux cas",
              "valeur": 9438,
            },
            {
              "title":"Décès",
              "valeur": 538,
            },
            {
              "title":"Guéri(s)",
              "valeur":105,
            },
          ],
          "expert":{
            "name":"josmidz delatour",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.",
            "photo":"assets/images/user_pic.png"
          }
        },
        {
          "country":"CANADA",
          "flag":"assets/images/canada.png",
          "stats":[
            {
              "title":"Nouveaux cas",
              "valeur": 1438,
            },
            {
              "title":"Décès",
              "valeur": 338,
            },
            {
              "title":"Guéri(s)",
              "valeur":105,
            },
          ],
          "expert":{
            "name":"smith perez",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.",
            "photo":"assets/images/user_pic.png"
          }
        },
      ]
    },
    {
      "title":"Guéri(s)",
      "gen_value":14242,
      "info":[
        {
          "country":"CANADA",
          "flag":"assets/images/canada.png",
          "stats":[
            {
              "title":"Nouveaux cas",
              "valeur": 8418,
            },
            {
              "title":"Décès",
              "valeur": 308,
            },
            {
              "title":"Guéri(s)",
              "valeur": 100,
            },
          ],
          "expert":{
            "name":"smith perez",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.",
            "photo":"assets/images/user_pic.png"
          }
        },
        {
          "country":"AFRIQUE DU SUD",
          "flag":"assets/images/sudaf.png",
          "stats":[
            {
              "title":"Nouveaux cas",
              "valeur": 2438,
            },
            {
              "title":"Décès",
              "valeur": 108,
            },
            {
              "title":"Guéri(s)",
              "valeur": 70,
            },
          ],
          "expert":{
            "name":"alba conord",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.",
            "photo":"assets/images/user_pic.png"
          },
        },
        {
          "country":"USA",
          "flag":"assets/images/usa.png",
          "expert":{
            "name":"josmidz delatour",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.",
            "photo":"assets/images/user_pic.png"
          },
          "stats":[
            {
              "title":"Nouveaux cas",
              "valeur": 2438,
            },
            {
              "title":"Décès",
              "valeur": 78,
            },
            {
              "title":"Guéri(s)",
              "valeur": 80,
            },
          ],
        }
      ]
    }
  ];
  int _currentIndex =0;
  _assignIndexFx({int i}){
    setState(() {
      _currentIndex = i;
    });
  }

  // GifController _controller;

  @override
  void initState() {
    // _controller = GifController(vsync: this);
    // _controller.addStatusListener((status) {
    //   if(status == AnimationStatus.completed) {
    //     _controller.stop();
    //   }
    //  });
    // _controller.repeat(min:0,max:24,period:Duration(milliseconds:800));
    userBloc.loadUserInfo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refreshFx() async{
    await Future.delayed(Duration(milliseconds: 300),);
    //call the fx
  }


  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshFx,
      child: Scaffold(
        backgroundColor: ctColor1,
        body:StreamBuilder(
          initialData: CovidBlocDataModel(appEvent:NoState(),listCovidInfo: <CovidInfoDataModel>[]),
          stream: covidBloc.covidStream,
          builder: (BuildContext context, AsyncSnapshot<CovidBlocDataModel> snapshot) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: HeaderClipper(),
                        child: Stack(
                          children: [
                            Container(
                              height: 270.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [ctColor2,ctColor5],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                                image: DecorationImage(
                                  image: AssetImage("assets/images/medical.png"),//medical
                                  fit: BoxFit.contain
                                )
                              ),
                            ),
                            Positioned(
                              right: 20.0,
                              top: 110.0,
                              child: Container(
                                width: 0.5 * MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Text(
                                      "COVID-19 TRACKER",
                                      style: TextStyle(
                                        color: ctColor1,
                                        fontSize: 21
                                      ),
                                    ),
                                    SizedBox(height: 10.0,),
                                    Text(
                                      "Toutes les informations en temps réel dont vous avez besoin",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ctColor1,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 0.6 * MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            if(snapshot.data.appEvent is NoState || snapshot.data.appEvent is LoadingState)
                              Expanded(child: LoadingWidget())
                            else if(snapshot.data.appEvent is NoNetworkState)
                              Expanded(child: NoNetworkScreen(refresh: (){covidBloc.fetchCovidInfo();},))
                            else if(snapshot.data.appEvent is LoadedState)
                              if(snapshot.data.listCovidInfo.length ==0)
                                Expanded(child: NoDataFoundScreen(refresh: (){covidBloc.fetchCovidInfo();},))
                              else 
                                Expanded(child:Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [ 
                                        ]..addAll(snapshot.data.listCovidInfo.map((e) => CupertinoButton(
                                            onPressed: (){
                                              _assignIndexFx(i:snapshot.data.listCovidInfo.indexOf(e));
                                            },
                                            padding: EdgeInsets.zero,
                                            child: AnimatedContainer(
                                              duration: Duration(milliseconds: 300),
                                              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                              margin: EdgeInsets.symmetric(horizontal: 10.0,),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15.0),
                                                color: _currentIndex == snapshot.data.listCovidInfo.indexOf(e) ? ctColor2:ctColor1,
                                              ),
                                              child: Text(
                                                "${capitalizeText(e.category)}",
                                                style: TextStyle(
                                                  color: _currentIndex == snapshot.data.listCovidInfo.indexOf(e) ? ctColor1:ctColor2,
                                                  fontWeight: _currentIndex == snapshot.data.listCovidInfo.indexOf(e) ? FontWeight.w700:FontWeight.normal
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                      ),
                                    ), 
                                    Container(
                                      height: 200,
                                      width: double.infinity,
                                      child: ListView.builder(
                                        itemCount: snapshot.data.listCovidInfo[_currentIndex].info.length,
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.all(6.0),
                                        itemBuilder: (_,index){
                                          return CovidCardViewModel(
                                            categoryId: snapshot.data.listCovidInfo[_currentIndex].idCategory,
                                            childInfoDataModel: snapshot.data.listCovidInfo[_currentIndex].info[index],
                                            onClick: (CovidChildInfoDataModel info){
                                              // _showBottomSheet(context:context)
                                            },
                                          );
                                        }
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                                          child: Text(
                                            "STATISTIQUE GENERALE",
                                            style: TextStyle(
                                              color: ctColor2,
                                              fontSize: 14.0,
                                              // fontWeight: FontWeight.w800
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 150.0,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children:[]..addAll(_listCovidInfo.map((e) => Container(
                                                padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor: ctListColors[_listCovidInfo.indexOf(e)],
                                                    ),
                                                    SizedBox(width: 5.0,),
                                                    Text(
                                                      "${e['title']}",
                                                      style: TextStyle(
                                                        color: ctListColors[_listCovidInfo.indexOf(e)],
                                                        // fontSize: 14.0,
                                                        // fontWeight: FontWeight.w800
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )).toList()),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              height: 100.0,
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ctColor1,
                                                border: Border.all(
                                                  color: ctColor2,
                                                  width: 2
                                                )
                                              ),
                                              child: Stack(
                                                children: [
                                                  CustomPaint(
                                                    foregroundPainter: PieChartClipper(listStats: _listCovidInfo),
                                                    child: Container(),
                                                  ),
                                                  Center(
                                                    child: Container(
                                                        height: 70.0,
                                                        width: 70.0,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: ctColor1
                                                        ),
                                                      ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "COVID-19",
                                                      style: TextStyle(
                                                        color: ctColor8,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                  ],
                                ))
                            else
                              Expanded(child: FailScreen(refresh: (){covidBloc.fetchCovidInfo();},))
                          ],
                        ),
                      ),
                      

                      GestureDetector(
                        onTap:(){
                          _openConseil(context: context);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          padding: EdgeInsets.symmetric(vertical: 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: ctColor2.withOpacity(0.2)
                          ),
                          child: Row(
                            children: [
                              Hero(
                                tag: "movn",
                                child: Container(
                                  height: 60.0,
                                  width: 60.0,
                                  margin: EdgeInsets.only(left: 8.0),
                                  decoration: BoxDecoration(
                                    // gradient: LinearGradient(
                                    //   colors: [ctColor2,ctColor5],
                                    //   begin: Alignment.bottomCenter, assets/images/bulb.gif
                                    //   end: Alignment.topCenter,assets/images/document.gif
                                    // ),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/04.png"),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                  // child: ClipRRect(
                                  //   borderRadius: BorderRadius.circular(30.0),
                                  //   child: GifImage(
                                  //     controller: _controller,
                                  //     fit: BoxFit.cover,
                                  //     image: AssetImage('assets/images/document.gif')
                                  //   ),
                                  // ),
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Conseils et Symptômes du COVID-19",
                                      style: TextStyle(
                                        color: ctColor3,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w800
                                      ),
                                    ),
                                    SizedBox(height: 5.0,),
                                    Text(
                                      "Lisez et bénéficiez des conseils de nos experts afin de prevenir contre le virus",
                                      style: TextStyle(
                                        // color: ctColor8,
                                      ),
                                    ),
                                    SizedBox(height: 10.0,),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: ctColor2.withOpacity(0.7),
                                    radius: 3,
                                  ),
                                  SizedBox(height: 8.0,),
                                  CircleAvatar(
                                    backgroundColor: ctColor2,
                                    radius: 3,
                                  ),
                                  SizedBox(height: 8.0,),
                                  CircleAvatar(
                                    backgroundColor:  ctColor2.withOpacity(0.7),
                                    radius: 3,
                                  ),
                                ],
                              ),
                              SizedBox(width: 5.0,),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          // gradient: LinearGradient(
                          //   colors: [ctColor2,ctColor5],
                          //   begin: Alignment.bottomCenter,
                          //   end: Alignment.topCenter,
                          // ),
                          image: DecorationImage(
                            image: AssetImage("assets/images/world.png"),
                            fit: BoxFit.contain
                          )
                        ),
                      )

                    ],
                  ),
                ),
                Positioned(
                  top: 180,
                  right: 0,
                  child: FloatingActionButton(
                    heroTag: 'con',
                    backgroundColor: ctColor6,
                    onPressed: (){
                      _openLogin(context:context);
                    },
                    mini: true,
                    child: Icon(LineAwesomeIcons.user),
                  ),
                ),
                Positioned(
                  top: 230,
                  right: 0,
                  child: FloatingActionButton(
                    backgroundColor: ctColor2,
                    heroTag: 'ab',
                    onPressed: (){
                      _openAbout(context: context);
                    },
                    mini: true,
                    child: Icon(FontAwesomeIcons.info),
                    // child: Icon(FontAwesomeIcons.dashcube),
                  ),
                ),
              ],
            );

          }

        ),
      ),
    );
  }

  _openConseil({BuildContext context})=>
    Navigator.of(context).push(
      PageRouteBuilder(pageBuilder: (_,__,___)=>ConseilScreen(),
        transitionDuration: Duration(milliseconds: 300),
        transitionsBuilder: (ctx,anim,anims,child){
          return FadeTransition(opacity: anim,child: child,);
        }
      )
      // CupertinoPageRoute(
      //   builder: (_)=> ConseilScreen(),
      //   fullscreenDialog: true
      // )
    );
  _openLogin({BuildContext context}){
    if(userBloc.userBlocDataModel.usertoken == null){
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (_) => LoginRegisterScreen(
            onLoginSuccess:(){
              Future.delayed(Duration(milliseconds: 300),(){
                Navigator.of(context).push(
                CupertinoPageRoute(builder: (context)=> UserScreen()));
              });
            }
          ),
          fullscreenDialog: true
        )
      );
    } else {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (_) => UserScreen(),
          fullscreenDialog: true
        )
      );
    }
  } 

  _openAbout({BuildContext context})=>  Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_)=> AboutScreen(),
        fullscreenDialog: true
      )
    );
  void _showBottomSheet({BuildContext context,dynamic ownInfo,dynamic allInfo,dynamic selectedIndex}){
    showModalBottomSheet(context: context, builder: (_){
      return Container(
        height: 0.8 * MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color(0xff737373),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
          ),
          child: Container(
            height: 0.8 * MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: ctColor10
            ),
            child: Column(
              children: [
                SizedBox(height: 10.0,),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 80.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(4)
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SlipupAnimation(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20.0,),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 100.0,
                                  width: double.infinity,
                                  margin: EdgeInsets.only(left: 5.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("${ownInfo['flag']}"),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${ownInfo['country']}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ctColor2,
                                          fontSize: 25.0
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  LineAwesomeIcons.bar_chart_1,
                                  color: ctColor2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Stats. ${ownInfo['country']}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ctColor2,
                                    fontSize: 20.0
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for(var i=0; i < ownInfo['stats'].length;i++)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 10.0,),
                                            CircleAvatar(
                                              radius: 10,
                                              backgroundColor: ctListColors[ownInfo['stats'].indexOf(ownInfo['stats'][i])],
                                            ),
                                            SizedBox(width: 5.0,),
                                            Text(
                                              "${ownInfo['stats'][i]['title']}",
                                              style: TextStyle(
                                                color: ctListColors[ownInfo['stats'].indexOf(ownInfo['stats'][i])],
                                                // fontSize: 14.0,
                                                // fontWeight: FontWeight.w800
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    for(var i=0; i < ownInfo['stats'].length;i++)
                                      AnimCircularChart(index: i,listStats: ownInfo['stats'],)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  LineAwesomeIcons.alternate_arrows_horizontal,
                                  color: ctColor2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Comparateur : ",
                                     style: TextStyle(
                                      color: ctColor2,
                                      fontSize: 20.0
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "${allInfo[selectedIndex]['title']}",
                                        style: TextStyle(
                                          color: ctColor6,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold
                                        ), 
                                      )
                                    ]
                                  )
                                ), 
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                // flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for(var i=0; i < allInfo[selectedIndex]['info'].length;i++)
                                      AnimLinearChart(loopIndex: i,selectedIndex:selectedIndex,listStats: allInfo[selectedIndex]['info'],)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  LineAwesomeIcons.user_1,
                                  color: ctColor2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Expert.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ctColor2,
                                    fontSize: 20.0
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                            child:ListTile(
                                  leading: CircleAvatar(
                                    radius: 25.0,
                                    backgroundImage: AssetImage("${ownInfo['expert']['photo']}"),
                                  ),
                                  title: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${ownInfo['expert']['name']}".toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: ctColor8,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${ownInfo['expert']['description']}",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                          ), 
                          SizedBox(height: 40.0,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final path = Path();
    path.lineTo(0, height * 0.85);
    path.quadraticBezierTo(width/2, height, width, height * 0.85);
    // path.lineTo(width, height);
    path.lineTo(width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}


class PieChartClipper extends CustomPainter {
  List<dynamic> listStats;
  PieChartClipper({this.listStats = const[]});
  @override
  void paint(Canvas canvas, Size size) {
    Offset center  = Offset(size.width/2,size.height/2);
    double rayon = min(size.width/2, size.height/2);
    var paint = Paint()
      ..strokeWidth=40
      ..style = PaintingStyle.stroke;
    var total=0;
    listStats.forEach((element) {
      total += element['gen_value'];
     });
    var startRadian = -pi/2;
    for(var i=0;i < listStats.length;i++){
      var _element = listStats[i];
      var _sweepRadian =(_element['gen_value']/total)*2*pi;
      paint.color = ctListColors[i];
      canvas.drawArc(
        Rect.fromCircle(center:center,radius:rayon),
         startRadian, _sweepRadian, false, paint);
      startRadian += _sweepRadian;
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
  
}