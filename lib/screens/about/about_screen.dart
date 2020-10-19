import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ctColor10,
        leading: CupertinoButton(
          onPressed:()=> Navigator.of(context).pop(),
          padding: EdgeInsets.zero,
          child: Icon(LineAwesomeIcons.arrow_left,color: ctColor2,),
        ),
      ),
      backgroundColor: ctColor10,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: [
            Positioned(
              bottom: -10.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: 200.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [ctColor2,ctColor5],
                  //   begin: Alignment.bottomCenter,
                  //   end: Alignment.topCenter,
                  // ),
                  // image: DecorationImage(
                  //   image: AssetImage("assets/images/world.png"),
                  //   fit: BoxFit.contain,
                  //   colorFilter: ColorFilter.srgbToLinearGamma()
                  // )
                ),
                child:  Image.asset(
                  "assets/images/world.png",
                  fit: BoxFit.cover,
                  color: ctColor8.withOpacity(0.3),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150.0,
                      width: 150.0,
                      child: Image.asset(
                        "assets/icon/icon.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Column(
                  children: [
                    Text(
                      "COVID-19 TRACKER",
                      style: TextStyle(
                        color: ctColor2,
                        fontSize: 21
                      ),
                    ),
                    // SizedBox(height: 5.0,),
                    // Text(
                    //   "Oxanfoxs Academy 1ère édition",
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     color: Colors.grey,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    // SizedBox(height: 15.0,),
                    Text(
                      "Toutes les informations en temps réel dont vous avez besoin",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ctColor8,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Text(
                      "Version 1.0.0",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ctColor8,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Développeurs",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ctColor8,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Flexible(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (_,i){
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              backgroundImage: AssetImage("assets/images/user_pic.png",),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Développeur ${i+1}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ctColor8,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    "développeur description",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}