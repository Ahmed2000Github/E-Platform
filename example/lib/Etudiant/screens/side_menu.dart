import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
           DrawerHeader(
            child: Image.asset(
                          'assets/images/ar_image.png',
                          height: 200,
                        ),
            decoration: new BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
      onTap: () {},
      horizontalTitleGap: 0.0,
      leading: Image.asset('assets/images/profile.png'),
      title: Text('   Profile',
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize:22),
      ),
    ),
    SizedBox(height: 10,),
          ListTile(
      onTap: () {},
      horizontalTitleGap: 0.0,
      leading: Image.asset('assets/images/ar_image.png'),
      title: Text('   title',
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize:22),
      ),
    ),
    SizedBox(height: 10,),
          ListTile(
      onTap: () {},
      horizontalTitleGap: 0.0,
      leading: Image.asset('assets/images/ar_image.png'),
      title: Text('   Settings',
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize:22),
      ),
    ),
    SizedBox(height: 10,),
          ListTile(
      onTap: () {},
      horizontalTitleGap: 0.0,
      leading: Image.asset('assets/images/ar_image.png'),
      title: Text('   About',
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize:22),
      ),
    ),
        ],
      ),
    );
  }
}
