// import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/sign_up_page.dart';
import 'dart:convert';

import 'package:arcore_flutter_plugin_example/Etudiant/models/utils.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/welcome_page.dart';
import 'package:flutter/material.dart';

import '../../../Database/models/User.dart';
import '../../../Database/models/UserDto.dart';
import 'package:http/http.dart' as http;

import '../../../Database/openDB/myDb.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
var studentEmailController = TextEditingController();
var studentPasswordController = TextEditingController();
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text("Login to your account",
                    style: TextStyle(
                      fontSize: 15,
                    color:Colors.grey[700]),)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: studentEmailController,
                            obscureText: false,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400))),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: studentPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400))),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                  Padding(padding:
                  EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
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
                        onPressed: () async {
                           // Navigator.push(context,
                           //  MaterialPageRoute(builder: (context)=>WelcomePage())
                           //  );
                          // Auth Mobile est commenté car le backend n'est pas encore prêt
                          await doAuthStudent(context);
                        },
                        color: Color(0xff0095FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),

                        ),
                        child: Text(
                          "Login", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,

                        ),
                        ),

                      ),
                    ),
                  ),


                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Text("Don't have an account?"),
                //      TextButton(
                //    onPressed: () {
                //    Navigator.push(context,
                //             MaterialPageRoute(builder: (context)=>SignUpPage())
                //             );
                //    },
                // child: Text(
                // 'SIGN UP', //title
                // textAlign: TextAlign.end, //aligment
                //   ),
                //  ),
                //   ],
                // ),

                Container(
                  padding: EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.fitHeight
                    ),

                  ),
                )

              ],
            ))
          ],
        ),
      ),
    );
  }

}
// [UnivIt : Errouk Ismail]
Future<User> fetchData(UserDto userDto) async {
  final response = await http.post(
    Uri.parse('https://c6cb-102-52-176-16.eu.ngrok.io/api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': userDto.email,
      'password': userDto.password
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return null;
  }
}

// [UnivIt : Errouk Ismail]
void doAuthStudent(BuildContext context) async {
  // ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("email : "+profEmailController.text+ "  password : "+profPasswordController.text)));
  User user = null;
  dynamic connexion = "";
  UserDto userDto = new UserDto(
      email: studentEmailController.text, password: studentPasswordController.text);
  await fetchData(userDto).then((value) => user = value);
  if(user==null){
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar
      (content: Text("Email or Password is incorrect!!!")));

  }
  dynamic txt = "";
  dynamic permission = 0;
  dynamic auth = 0;
  if (user != null) {
    await DatabaseHelper.instance.removeall().then((value) => permission = 1);
    if (permission == 1) {
      await DatabaseHelper.instance
          .add(user)
          .then((value) => txt = "added")
          .catchError((err) => txt = "error");
      dynamic myTxt = 0;
      await DatabaseHelper.instance
          .getUsers()
          .then((value) => myTxt = value.first.username);
      auth = 1;
      ScaffoldMessenger.of(context)
          .showSnackBar(new SnackBar(content: Text(myTxt)));
    }

    if (auth == 1) {
      if(user.type_user=="3"){
        Utils.token=user.token;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WelcomePage()));
      }
      else{
        ScaffoldMessenger.of(context)
            .showSnackBar(new SnackBar(content: Text(user.username +" is not a Student!!!!")));
      }
    }
  }
}

// we will be creating a widget for text field
Widget inputFile({label, obscureText = false})
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color:Colors.black87
        ),

      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0,
          horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400
            ),

          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400)
          )
        ),
      ),
      SizedBox(height: 10,)
    ],
  );
}