import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CovidInfo {
  final image;
  final title;
  final content;
  CovidInfo({this.content,this.image,this.title});
}

class ConseilScreen extends StatefulWidget {
  @override
  _ConseilScreenState createState() => _ConseilScreenState();
}

class _ConseilScreenState extends State<ConseilScreen> {

  List<CovidInfo> _listCovidInfo = [
    CovidInfo(
      title: "Conseils et sympômes du covid-19",
      image: "assets/images/01.png",
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
    ),
    CovidInfo(
      title: "Conseils et sympômes du covid-19",
      image: "assets/images/02.png",
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
    ),
    CovidInfo(
      title: "Conseils et sympômes du covid-19",
      image: "assets/images/03.png",
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
    ),
    CovidInfo(
      title: "Conseils et sympômes du covid-19",
      image: "assets/images/04.png",
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
    ),
    CovidInfo(
      title: "Conseils et sympômes du covid-19",
      image: "assets/images/05.png",
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
    ),
    CovidInfo(
      title: "Conseils et sympômes du covid-19",
      image: "assets/images/06.png",
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
    )
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: ctColor1,
      body: Container(
        child: NestedScrollView(
          headerSliverBuilder: (_,v){
            return <Widget>[
              SliverAppBar(
                floating: false,
                expandedHeight: 300,
                elevation: 0.0,
                backgroundColor: ctColor1,
                leading: CupertinoButton(
                  onPressed:()=> Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  child: Icon(LineAwesomeIcons.arrow_left,color: ctColor2,),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Hero(
                    tag: "movn",
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/movn.png"),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ];
          }, 
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Text(
                      "COVID-19",
                      style: TextStyle(
                        color: ctColor6,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                  ),
                  Text(
                    "\t\tLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: ctColor2
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _listCovidInfo.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (_,i){
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ctColor2,
                            width: 0.5
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              // unselectedWidgetColor: ctColor6,
                              accentColor: ctColor6
                            ),
                          child: ExpansionTile(
                            title: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                              padding: EdgeInsets.symmetric(vertical: 3.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 60.0,
                                    width: 60.0,
                                    margin: EdgeInsets.only(left: 8.0),
                                    decoration: BoxDecoration( 
                                      image: DecorationImage(
                                        image: AssetImage(_listCovidInfo[i].image),
                                        fit: BoxFit.cover
                                      )
                                    ),
                                  ),
                                  SizedBox(width: 10.0,),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          _listCovidInfo[i].title,
                                          style: TextStyle(
                                            color: ctColor3,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w800
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 5.0,),
                                ],
                              ),
                            ),
                            subtitle: Text(
                              _listCovidInfo[i].content,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                // color: ctColor8,
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(_listCovidInfo[i].content,style: TextStyle(
                                    // color: ctColor8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}