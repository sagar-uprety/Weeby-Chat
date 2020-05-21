import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/Rounded_Button.dart';

class WelcomeScreen extends StatefulWidget {
  //static members are the property of class and const inside class always needs to be static
  static const id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

//with is for using mixin: these are the functions/properties that can be used by any class. eg is given at end
class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this, //this here means WelcomeScreenState obj
      // upperBound: 1.0,
      // upperBound: 100.0,
    );

    controller.forward();
    // controller.reverse(from: 1.0);

    animation =
        ColorTween(begin: Colors.grey, end: Colors.white).animate(controller);

    controller.addListener(() {
      setState(() {});
      // print(controller.value);
      // print(animation.value);
    });
  }

  //dispose animation when state is deactivated. (so that it does not run on background)
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.pink.withOpacity(controller.value),
      // backgroundColor: Colors.white,
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                    // height: animation.value * 100,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  totalRepeatCount: 3,
                  speed: Duration(milliseconds: 250),
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              color: Colors.blueAccent,
              onPress: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              text: 'Login',
            ),
            RoundedButton(
              color: Colors.blueAccent,
              onPress: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              text: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}

//? Mixin Example
/*
Fish().swim()

class Fish extends Move with CanSwim{};

 mixin CanSwim {
  void swim(){
    print('Swimming');
  }
}
*/
//? CURVE ANIMATION -For non linear progression
/*   animation = CurvedAnimation(
      parent: controller,
      curve: Curves
          .easeInOutCubic, //curves cannot have upper bound greter than 1. Must be (0-1)
    ); */

/*  animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          controller.reverse(from: 1.0);
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      },
    );
 */
