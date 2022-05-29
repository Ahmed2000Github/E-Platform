import 'package:arcore_flutter_plugin_example/Etudiant/screens/cours_list.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/welcome_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/screen_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key key }) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}



class _MainPageState extends State<MainPage>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("Check my lessons",
            style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                  child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CoursList()));
                   },
                  child: Text('Liste des cours',
                  style: TextStyle(fontSize: 23),),
                  ),
                  ),
                ],)),
                   ),
                    ],
                    ),
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: Image(
                              fit: BoxFit.contain,
                              alignment: Alignment.topRight,
                              image: NetworkImage(
                                  "https://patrice-hardouin.canoprof.fr/eleve/PSE%20BacPro/Exemple_sequence_inversee/Approche%20par%20le%20risque/res/Books-3-300px.png"),
                            ),
                          ),),
                      ],)
                ),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("Take A screenshot",
            style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Row(children: <Widget>[
            // Container(child: Text("3.5", style: TextStyle(
            //   color: Colors.black54, fontSize: 18.0,),)),
            // Container(child: Icon(
            //   FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
            // Container(child: Icon(
            //   FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
            // Container(child: Icon(
            //   FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
            // Container(child: Icon(
            //   FontAwesomeIcons.solidStarHalf, color: Colors.amber,
            //   size: 15.0,),),
            Center(
                  child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ScreenPage()));
                   },
                  child: Text('take a screenshot now',
                  style: TextStyle(fontSize: 23),),
                  ),
                  ),
          ],)),
        ),
        // Container(child: Text("Pastries \u00B7 Phoenix,AZ",
        //   style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
      ],
    ),
                          ),
                        ),

                        Container(
                          width: 250,
                          height: 180,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: Image(
                              fit: BoxFit.contain,
                              alignment: Alignment.topRight,
                              image: NetworkImage(
                                  "https://img.modradar.net/source/blog/human-hand-holding-mobile-phone.jpg"),
                            ),
                          ),),
                      ],)
                ),
              ),
            ),
          ),
          ],
          ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.settings, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
          print(index);
          switch (index) {
            case 0:
             Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
              break;
            case 1:
             Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
              break;
            case 2:
             Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
              break;
            default:
          }
        },
      ),
    );
  }
}

  
