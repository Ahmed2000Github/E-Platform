import 'package:arcore_flutter_plugin_example/color.dart';
import 'package:flutter/material.dart';

import 'cours_list.dart';

class ScanneList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanneList();
}

class _ScanneList extends State<ScanneList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      debugShowCheckedModeBanner : false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Les scannes disponibles'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          color: StandardColor.color4,
          child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         Container(
           height: 200,
                  // color: Color.fromARGB(255, 83, 154, 230),
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        'Choisir une \n    Option',
                        style: TextStyle(
                            fontFamily: 'Updock',
                            fontSize: 34,
                            letterSpacing: 3.2,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                       SizedBox(width: 120),
                      // SizedBox(width: 48),
                      Image.asset('assets/images/select.png',
                          height: 100, width: 100)
                    ],
                  )),
                  
               
       Builder(
            builder: (context) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CoursList()));
                  }, // Handle your callback
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.5), //shadow color
                            spreadRadius: 5, // spread radius
                            blurRadius: 7, // shadow blur radius
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 140,
                      width: 400,
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Image augmenté    ',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                          Image.asset(
                            'assets/images/ar_image.png',
                            height: 200,
                          ),
                        ],
                      )),
                )),
        SizedBox(height: 10),
        Builder(
            builder: (context) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CoursList()));
                  }, // Handle your callback
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.5), //shadow color
                            spreadRadius: 5, // spread radius
                            blurRadius: 7, // shadow blur radius
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 140,
                      width: 400,
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Texte augmenté    ',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                          Image.asset(
                            'assets/images/ar_image.png',
                            height: 200,
                          ),
                        ],
                      )),
                )),
        SizedBox(height: 10),
        Builder(
            builder: (context) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CoursList()));
                  }, // Handle your callback
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.5), //shadow color
                            spreadRadius: 5, // spread radius
                            blurRadius: 7, // shadow blur radius
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 140,
                      width: 400,
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'QR Code augmenté',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                          Image.asset(
                            'assets/images/ar_image.png',
                            height: 200,
                          ),
                        ],
                      )),
                )),
      ],
    )
   ,
        )
    
      ),
    );
  }
}
