import 'package:flutter/material.dart';
import '../../models/onboard_data.dart';
import '../size_configs.dart';
import './pages.dart';
import './home_page.dart';


class OnboardingPage extends StatefulWidget {
  const OnboardingPage({ Key key }) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  AnimatedContainer dotIndicator(index){
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 400),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.blue : Colors.purple,
        shape: BoxShape.circle,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
     SizeConfig().init(context);
     double sizeV = SizeConfig.blockSizeV;
     double sizeH = SizeConfig.blockSizeH;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
            children: [
                Expanded(
                    flex: 9,
                    child: PageView.builder(
                        controller: _pageController,
                         onPageChanged: (value) {
                          setState(() {
                          currentPage = value;
                           });
                          }, 
                        itemCount: onboardingContents.length,
                        itemBuilder:(context,index)=>Column(
                          children: [
                            SizedBox(
                               height: sizeV * 5,
                            ),
                           Text(onboardingContents[index].title,
                           style: Theme.of(context).textTheme.headline6,
                           textAlign: TextAlign.center,
                           ),
                           SizedBox(
                           height: sizeV * 5,
                           ),
                           Container(
                           height: sizeV * 50,
                           child: Image.asset(
                           onboardingContents[index].image,
                           fit: BoxFit.contain,
                                            ),
                          ),
                          RichText(
                           textAlign: TextAlign.center,
                           text: TextSpan(
                           style: Theme.of(context).textTheme.subtitle1,
                           children: [
                             TextSpan(text: 'A whole System  '),
                             TextSpan(
                              text: 'to make sure of students presences with face recognition ',
                              style: TextStyle(
                              color: Colors.blue,
                              )),
                              TextSpan(text: 'and improve learning quality '),
                              TextSpan(text: 'with the latest technologies: '),
                              TextSpan(
                               text: 'the Augmented Reality ',
                               style: TextStyle(
                                color: Colors.blue,
                          ),
                        ),      
                      ],
                    ),
                  ),
                              SizedBox(
                                height: sizeV * 5,
                              ),
                        ],         
                    ),
                ),
              ),
              Expanded(
              flex: 1,
              child: Column(
              children: [
                currentPage == onboardingContents.length - 1
                ? MyTextButton(
                   buttonName: 'Get Started',
                   onPressed: (){
                     Navigator.push(context,
                     MaterialPageRoute(builder: (context)=>HomePage())
                     );
                   },
                   bgColor: Colors.blue[50],
                )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OnboardNavBtn(
                    name: 'Skip',
                    onPressed: (){
                       Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>HomePage())
                            );
                    },
                  ),
                  Row(
                  children:
                  List.generate(onboardingContents.length,(index) => dotIndicator(index),
                ),
              ),
              OnboardNavBtn(
                name: 'Next',
                onPressed: () {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    );  
                },
                )
            ],
            ),
             ],
            ),
            ),
            ],
        )),
    ); 
  }
}
class MyTextButton extends StatelessWidget{
  const MyTextButton({
        Key key,
         this.buttonName,
         this.onPressed,
         this.bgColor,
  }): super(key: key);
  final String buttonName;
  final VoidCallback onPressed;
  final Color bgColor;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,),
                  child: SizedBox(
                  width: SizeConfig.blockSizeH*100,
                  height: SizeConfig.blockSizeH*15.5,
                  child:TextButton(
                  onPressed: onPressed,
                  child:Text(
                  buttonName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style:TextButton.styleFrom(
                    backgroundColor: bgColor,
                  ),
                  ),
                  )
    );
  }
}


class OnboardNavBtn extends StatelessWidget {
      const OnboardNavBtn ({
           Key key,
           this.name,
           this.onPressed,
      }) : super(key: key);
      final String name;
      final VoidCallback onPressed;
      @override
      Widget build(BuildContext context){
        return InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(6),
          splashColor: Colors.black,
          child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            name,
            style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),  
        );
      }
}