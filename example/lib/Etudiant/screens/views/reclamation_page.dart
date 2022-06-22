
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:mailer/mailer.dart';
//import 'package:mailer/smtp_server.dart';
import 'package:url_launcher/url_launcher.dart';




class ReclamationPage extends StatefulWidget {
  const ReclamationPage({ Key key }) : super(key: key);

  @override
  _ReclamationPageState createState() => _ReclamationPageState();
}



class _ReclamationPageState extends  State<ReclamationPage> {
/*
    List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/absence.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }*/
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
                    Text( "Réclamation d'abscence",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text(" Un email sera envoyé au prof du module",
                    style: TextStyle(
                      fontSize: 15,
                    color:Colors.grey[700]),)
                  ],
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
                        onPressed: sendMail,
                        color: Color(0xff0095FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),

                        ),
                        child: Text(
                          "Réclamer", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,

                        ),
                        ),
                        

                      ),
                    ),
                  ),


  

               

              ],
            ))
          ],
        ),
      ),
    );
  }

Future sendMail() async {
/*
final email ='jimouhsami@gmail.com';
final SmtpServer = gmailSaslXoauth2(email, 'accessToken');
final message = Message()
  ..from = Address(email,'SAMI')
  ..recipients = ['jimouhsami@gmail.com']
  ..subject ='Hello SAMI'
  ..text ='Réclamation '; 
try {

  await send(message,SmtpServer);
} on MailerException catch(e) {
  print(e);
}*/


  var url = Uri.parse("mailto:jimouhsami@gmail.com?subject=Réclamation de présence&body=Bonjour, Un étudiant réclame qu'il a été présent durant ....");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

}