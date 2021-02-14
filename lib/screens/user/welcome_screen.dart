
import 'package:covid19_tracker/blocs/app_event.dart';
import 'package:covid19_tracker/blocs/user/user_bloc.dart';
import 'package:covid19_tracker/painters/dash_line_painter.dart';
import 'package:covid19_tracker/utils/capitalize_text.dart';
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:covid19_tracker/utils/dash_line.dart';
import 'package:covid19_tracker/widget/fail_screen.dart';
import 'package:covid19_tracker/widget/loading_widget.dart';
import 'package:covid19_tracker/widget/no_datafound_screen.dart';
import 'package:covid19_tracker/widget/no_network_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        initialData: UserCovidBlocDataModel(appUserCovidEvent: NoState(),listUserCovidInfo: <UserCovidDataModel>[]),
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
                      if(asyncSnapshot.data.listUserCovidInfo.length ==0)
                        Expanded(child: NoDataFoundScreen(refresh: (){userBloc.loadUserInfo();},))
                      else 
                       Expanded(
                         child: SingleChildScrollView(
                           child: Column(
                            children: [
                              SizedBox(height: 30.0,),
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (ctx,index){
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${capitalizeText('${asyncSnapshot.data.listUserCovidInfo[index].categoryname}')}",
                                          style: TextStyle(
                                            color: ctColor2
                                          ),
                                        ),
                                      ),
                                      Text(
                                        NumberFormat().format(asyncSnapshot.data.listUserCovidInfo[index].covidinfo),
                                        // "${capitalizeText('${asyncSnapshot.data.listUserCovidInfo[index].covidinfo}')}",
                                        style: TextStyle(
                                          color: ctColor6,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 22.0
                                        ),
                                      ),
                                      SizedBox(height: 20.0,),
                                      
                                    ],
                                  );
                                }, 
                                separatorBuilder: (_,i){
                                  return DashLines(color: ctColor2,);
                                }, 
                                itemCount: asyncSnapshot.data.listUserCovidInfo.length
                              )
                            ],
                      ),
                         ),
                       )
                    else if (asyncSnapshot.data.appUserCovidEvent is FailWithMessageState)
                      Expanded( child: FailScreen(message: (asyncSnapshot.data.appUserCovidEvent as FailWithMessageState).message , refresh: (){userBloc.loadUserCovid();},))
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