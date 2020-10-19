import 'package:covid19_tracker/blocs/app_event.dart';
import 'package:covid19_tracker/blocs/country/country_bloc.dart';
import 'package:covid19_tracker/painters/dash_line_painter.dart';
import 'package:covid19_tracker/utils/capitalize_text.dart';
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:covid19_tracker/widget/fail_screen.dart';
import 'package:covid19_tracker/widget/loading_widget.dart';
import 'package:covid19_tracker/widget/no_datafound_screen.dart';
import 'package:covid19_tracker/widget/no_network_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CountryScreen extends StatefulWidget {
  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {

  TrackingScrollController _trackingScrollController;
  bool _inScreen = false;
  AppEvent _appScrollEvent = NoState();
  _scrollListener(){
    double d = _trackingScrollController.offset;
    if(d >= 1300){
      _appScrollEvent = ShowScrollUppButtonState();
      if(_inScreen)
        setState(() {});
    } else {
      _appScrollEvent = NoState();
      if(_inScreen)
        setState(() {});
    }
  }

  @override
  void initState() {
    countryBloc.fetchCountries();
    _trackingScrollController = TrackingScrollController();
    _trackingScrollController.addListener(_scrollListener);
    setState(() {
      _inScreen = true;
    });
    super.initState();
  }

  @override
  void dispose() {
    _inScreen = false;
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Pays",
          style: TextStyle(
            color: ctColor1,
            // fontSize: 21
          ),
        ), 
      ),
      backgroundColor: ctColor10,
      body: StreamBuilder<CountryBlocData>(
        initialData: CountryBlocData(appEvent: NoState(),listCountries: []),
        stream:  countryBloc.countryStream,
        builder: (BuildContext context, AsyncSnapshot<CountryBlocData> asyncSnapshot){
          return Container(
            child: Stack(
              children: [
                Column(
                  children: [
                    if(asyncSnapshot.data.appEvent is NoState || asyncSnapshot.data.appEvent is LoadingState)
                      Expanded(child: LoadingWidget())
                    else if(asyncSnapshot.data.appEvent is NoNetworkState)
                      Expanded(child: NoNetworkScreen(refresh: (){countryBloc.fetchCountries();},))
                    else if(asyncSnapshot.data.appEvent is LoadedState)
                      if(asyncSnapshot.data.listCountries.length ==0)
                        Expanded(child: NoDataFoundScreen(refresh: (){countryBloc.fetchCountries();},))
                      else 
                        Expanded(child:Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                controller: _trackingScrollController,
                                itemBuilder: (BuildContext context,int index){
                                  return ListTile(
                                    onTap: (){
                                      _selectCountry(context: context,country:CountryDataModel(
                                        countryname: asyncSnapshot.data.listCountries[index].countryname,
                                        countryid: asyncSnapshot.data.listCountries[index].countryid,
                                        countrycode: asyncSnapshot.data.listCountries[index].countrycode,
                                        countryflag: asyncSnapshot.data.listCountries[index].countryflag,
                                        countrynat: asyncSnapshot.data.listCountries[index].countrynat,
                                      ));
                                    },
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(asyncSnapshot.data.listCountries[index].countryflag),
                                      backgroundColor: Colors.grey[300],
                                      radius: 15.0,
                                      onBackgroundImageError: (_,stacktrace){
                                        return Container(
                                          child: Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                            size: 22.0,
                                          ),
                                        );
                                      },
                                    ),
                                    title: Text(
                                      capitalizeText(asyncSnapshot.data.listCountries[index].countryname),
                                      style: TextStyle(
                                        color: ctColor2,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Nationalité : ${asyncSnapshot.data.listCountries[index].countrynat}",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    trailing: Icon(
                                      LineAwesomeIcons.arrow_right,
                                      color: Colors.grey[400],
                                      size: 22.0,
                                    ),
                                  );
                                },
                                 separatorBuilder: (_,i){
                                   return SizedBox(
                                     child: CustomPaint(foregroundPainter: DashLinePainter(),),
                                   );
                                 }, 
                                 itemCount: asyncSnapshot.data.listCountries.length
                              ),
                            )
                          ],
                        ))
                    else
                      Expanded(child: FailScreen(refresh: (){countryBloc.fetchCountries();},))
                  ],
                ),
                if(_appScrollEvent is ShowScrollUppButtonState)
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: FloatingActionButton(
                      onPressed: (){
                        _trackingScrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.linear);
                      },
                      mini: true,
                      backgroundColor: ctColor2,
                      child: Icon(LineAwesomeIcons.arrow_up,color: ctColor10),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  _selectCountry({BuildContext context, CountryDataModel country}) => Navigator.of(context).pop(country);
}