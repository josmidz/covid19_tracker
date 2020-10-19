
import 'package:covid19_tracker/blocs/app_event.dart';
import 'package:covid19_tracker/blocs/user/user_bloc.dart';
import 'package:covid19_tracker/painters/dash_line_painter.dart';
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:covid19_tracker/utils/dash_line.dart';
import 'package:covid19_tracker/widget/fail_screen.dart';
import 'package:covid19_tracker/widget/loading_widget.dart';
import 'package:covid19_tracker/widget/no_network_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  
  @override
  void initState() {
    userBloc.loadUserCovid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child:StreamBuilder<UserCovidBlocDataModel>(
        initialData: UserCovidBlocDataModel(appUserCovidEvent: NoState(),userCovidDataModel: UserCovidDataModel()),
        stream: userBloc.userCovidStream,
        builder: (BuildContext context, AsyncSnapshot<UserCovidBlocDataModel> asyncSnapshot){
          return Container(
            child: Stack(
              children: [
                Column(
                  children: [
                    if(asyncSnapshot.data.appUserCovidEvent is NoState || asyncSnapshot.data.appUserCovidEvent is LoadingState)
                      Expanded(child: LoadingWidget())
                    else if(asyncSnapshot.data.appUserCovidEvent is NoNetworkState)
                      Expanded(child: NoNetworkScreen(refresh: (){userBloc.loadUserCovid();},))
                    else if(asyncSnapshot.data.appUserCovidEvent is LoadedState)
                       Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Nouveau cas",
                              style: TextStyle(
                                color: ctColor2
                              ),
                            ),
                          ),
                          Text(
                            "${asyncSnapshot.data.userCovidDataModel.nouveaucas}",
                            style: TextStyle(
                              color: ctColor6,
                              fontWeight: FontWeight.w900,
                              fontSize: 22.0
                            ),
                          ),
                          SizedBox(height: 20.0,),
                          DashLines(color: ctColor2,),
                          SizedBox(height: 20.0,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Décès",
                              style: TextStyle(
                                color: ctColor2
                              ),
                            ),
                          ),
                          Text(
                            "${asyncSnapshot.data.userCovidDataModel.deces}",
                            style: TextStyle(
                              color: ctColor6,
                              fontWeight: FontWeight.w900,
                              fontSize: 22.0
                            ),
                          ),
                          SizedBox(height: 20.0,),
                          DashLines(color: ctColor2,),
                          SizedBox(height: 20.0,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Guéri(s)",
                              style: TextStyle(
                                color: ctColor2
                              ),
                            ),
                          ),
                          Text(
                            "${asyncSnapshot.data.userCovidDataModel.gueris}",
                            style: TextStyle(
                              color: ctColor6,
                              fontWeight: FontWeight.w900,
                              fontSize: 22.0
                            ),
                          ),
                          SizedBox(height: 20.0,),
                          DashLines(color: ctColor2,),
                          SizedBox(height: 10.0,),
                        ],
                      )
                    else
                      Expanded(child: FailScreen(refresh: (){userBloc.loadUserCovid();},))
                  ],
                ), 
              ],
            ),
          );
        },
      )
    );
  }

}