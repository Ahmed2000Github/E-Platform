import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/welcome_page.dart';
import 'package:arcore_flutter_plugin_example/Professor/screens/views/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Database/openDB/myDb.dart';
import '../widgets/bottom_nav_bar.dart';
import './onboarding_page.dart';

class HomePage extends StatelessWidget {

// const HomePage({ Key? key }) : super(key: key);
final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context){
    return Scaffold(
       bottomNavigationBar: BottomNavBar(),
      );  //scaffold

}
}
class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final VoidCallback press;
  const CategoryCard({
     Key key,
     this.svgSrc,
     this.title,
     this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return


      ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              // color: kShadowColor,
            ),
          ],
        ),
        child:
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: <Widget>[
                  // Spacer(),
                  SvgPicture.asset(svgSrc),
                  // Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                     style: GoogleFonts.lato(
                     textStyle: TextStyle(color: Colors.black, fontSize: 15, letterSpacing: .5),
                      ),
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