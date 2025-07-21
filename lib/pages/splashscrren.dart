import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math'as math;

import 'package:flutter/widgets.dart';
import 'package:flutter_application_20/pages/worldstates.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> with TickerProviderStateMixin {
  late final AnimationController _controller=AnimationController(
    duration: Duration(seconds: 5),
    vsync: this,
  )..repeat();
  @override
  void dispose() {
    
    super.dispose();
    _controller.dispose();
  }
  @override
  void initState() {
   
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => worldstates(),));
     });
  }
  var height,width;
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           AnimatedBuilder(
            animation: _controller,
            child: Container(
              height: height*0.3,
              width: width*0.3,
              child: Center(child: Image(image: AssetImage("assets/images/corona.png"),))
            ),
             builder: (context, child) {
               return Transform.rotate(
                angle: _controller.value*2.0*math.pi,
                child: child,
                );
             },
             ),
           SizedBox(
            height: height*0.1,
           ),
           Align(
            alignment: Alignment.center,
             child: Text("Covid-19\n Tracker App",textAlign:TextAlign.center,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
             ),),
           )
        ],
      ),
    );
  }
}