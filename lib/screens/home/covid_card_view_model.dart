import 'package:covid19_tracker/blocs/covid/covid_bloc.dart';
import 'package:covid19_tracker/screens/home/painter_clippers/painter_clippers.dart';
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CovidCardViewModel extends StatelessWidget {
  final CovidChildInfoDataModel childInfoDataModel;
  final categoryId;
  final Function(CovidChildInfoDataModel) onClick;
  CovidCardViewModel({this.childInfoDataModel,this.categoryId,this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: (){
          onClick(childInfoDataModel);
        },
        child: Container(
          width: 145.0,
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color:  ctColor10,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(.3),
                blurRadius: 4.0
              )
            ]
            // gradient: LinearGradient(
            //   colors: [ctColor5,ctColor5,],
            //   begin: Alignment.bottomCenter,
            //   end: Alignment.topCenter,
            // ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CustomPaint(
              foregroundPainter: MyCardPainter(),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 15.0,),
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        // image: AssetImage("${_listCovidInfo[_currentIndex]['info'][index]['flag']}"),
                        image: NetworkImage(childInfoDataModel.country.countryflag),
                        fit: BoxFit.cover
                      ),
                      shape: BoxShape.circle
                    ),
                    
                  ),
                  SizedBox(height: 15.0,),
                  Text(
                    "${childInfoDataModel.country.countryname}",
                    style: TextStyle(
                      color: ctColor2,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Text(
                    childInfoDataModel.stats.where((element) => element.categoryid.toString() == categoryId.toString()).toList().length >0
                      ? NumberFormat().format(childInfoDataModel.stats.where((element) => element.categoryid.toString() == categoryId.toString()).toList()[0].value).toString()
                      :"---",
                    // "",
                    style: TextStyle(
                      color: ctColor8,
                      fontSize: 14.0,
                      // fontWeight: FontWeight.w800
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LineAwesomeIcons.arrow_up,
                        color: Colors.redAccent,
                      ),
                      SizedBox(height: 3.0,),
                      Icon(
                        LineAwesomeIcons.arrow_down,
                        color: ctColor8,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}