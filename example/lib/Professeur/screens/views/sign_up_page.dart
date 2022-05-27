
import 'package:arcore_flutter_plugin_example/Professeur/screens/views/home.dart';
import 'package:arcore_flutter_plugin_example/Professeur/screens/views/login_page.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';


class SignUpPageProf extends StatefulWidget {
  const SignUpPageProf({Key key}) : super(key: key);

  @override
  _SignUpPageProfState createState() => _SignUpPageProfState();
}

class _SignUpPageProfState extends State<SignUpPageProf> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),


        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Sign up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,

                  ),),
                  SizedBox(height: 20,),
                  Text("New Professor! Create an account",
                    style: TextStyle(
                        fontSize: 15,
                        color:Colors.grey[700]),)


                ],
              ),
              Column(
                children: <Widget>[
                  inputFile(label: "Username"),
                  inputFile(label: "Email"),
                  inputFile(label: "Password", obscureText: true),
                  inputFile(label: "Confirm Password ", obscureText: true),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration:
                BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),



                    )

                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                     Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>ProfHomePage())
                            );
                  },
                   color: Colors.blue,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Sign up", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  TextButton(
                   onPressed: () {
                   Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>LoginPageProf())
                            );
                   },
                child: Text(
                'LOGIN', //title
                textAlign: TextAlign.end, //aligment
                  ),
                 ),
                ],
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
