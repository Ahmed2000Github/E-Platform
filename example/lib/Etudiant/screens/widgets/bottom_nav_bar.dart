import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_configs.dart';
import '../views/login_page.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: SizeConfig.screenHeight * .45,
            decoration: BoxDecoration(
              // color: Color.fromRGBO(137,198,240,0.4),
              color: Colors.blueAccent[700],
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent[700],
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/images/menu.svg"),
                    ), //container
                  ), //Align
                  Text(
                    "Authentification Area",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Colors.white, fontSize: 18, letterSpacing: .5),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29.5),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "   A Student Or A teacher ?",
                        icon: SvgPicture.asset("assets/images/search.svg"),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .6,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      // fit: BoxFit.cover,

                      children: <Widget>[
                        CategoryCard(
                          title: "Teacher Area",
                          svgSrc: "assets/images/prof.svg",
                          press: () {},
                        ), // categorycard
                        CategoryCard(
                          title: "Student Area",
                          svgSrc: "assets/images/student.svg",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                        ), // categorycard
                      ], // widget
                    ), // Gridview
                  ), // Expanded
                  //  Center(
                  //  child: Container(
                  //  margin: const EdgeInsets.all(10.0),
                  //  child: Lottie.asset("assets/images/lottiea.json"),
                  //  width: 48.0,
                  //  height: 48.0,

                  //  ),
                  //  ),
                ], //widget
              ), //Padding
            ), //column
          ), //safeArea
        ], //widget
      ), //stack
    );
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
    return ClipRRect(
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
        child: Material(
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
                      textStyle: TextStyle(
                          color: Colors.black, fontSize: 15, letterSpacing: .5),
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
// class BottomNavItem extends StatelessWidget {
//   final String svgScr;
//   final String title;
//   final VoidCallback press;
//   final bool isActive;
//   const BottomNavItem({
//     Key? key,
//     required this.svgScr,
//     required this.title,
//     required this.press,
//     this.isActive = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           SvgPicture.asset(
//             svgScr,
//             color: isActive ? kActiveIconColor : kTextColor,
//           ),
//           Text(
//             title,
//             style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
//           ),
//         ],
//       ),
//     );
//   }
//
