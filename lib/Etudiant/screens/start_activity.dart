
import 'package:arcore_flutter_plugin_example/Etudiant/screens/side_menu.dart';
import 'package:flutter/material.dart';
import '../../color.dart';
import 'cours_list.dart';

class StartActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StartActivity();
}

class _StartActivity extends State<StartActivity> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: new AppBar(
            title: new Text("test   "),
            actions: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text("nom etudiant",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                    )),
              ),
               IconButton(
                icon: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.asset('assets/images/prova_texture.png',
                        width: 110)),
                onPressed: () {},
              )
            ],
          ),
          drawer: SideMenu(),
          body:Container(
            color: StandardColor.color4,
            child:    Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(0),
                  alignment: Alignment.topRight,
                  // height: 400,

                  child: Row(
                    children: [
                      // SizedBox(width: 10),
                      Text(
                        'Bienvenu \n  dans votre \n    espace AR',
                        style: TextStyle(
                            fontFamily: 'Updock',
                            fontSize: 34,
                            letterSpacing: 3.2,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      SizedBox(width: 18.5),
                      Image.asset('assets/images/ar_asset.png',
                          height: 200, width: 200)
                    ],
                  )),
                      SizedBox(height: 50),
              Builder(
                  builder: (context) => 
                   Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CoursList()));
                      }, // Handle your callback
                      child:
                          Container(
                            decoration: BoxDecoration(
                                color: StandardColor.colorSecondary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 160,
                            width: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/profile.png'),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Profile',
                                  style: TextStyle(
                                      fontSize: 23, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          ),SizedBox(
                            width: 40,
                          ),
                          InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CoursList()));
                      }, // Handle your callback
                      child:Container(
                            decoration: BoxDecoration(
                                color: StandardColor.colorSecondary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 160,
                            width: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/book.png'),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Cours',
                                  style: TextStyle(
                                      fontSize: 23, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          )],
                      )),
            ],
          ),
          )
         ));
  }
}
