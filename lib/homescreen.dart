import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news/newhomescreen.dart';


class LandingPage extends StatefulWidget{
  @override
  State<LandingPage> createState()=>_LandingPageState();
}

class _LandingPageState extends State<LandingPage>{
  
  void initState(){

    Timer(const Duration(seconds: 3), () {
     Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsHomeScreen(),
          ));
    });
    super.initState();

  }
  
  
  
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 150,),
          Container(
            height: 500,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),image: DecorationImage(image: AssetImage("assets/images/newnews.jpg"),fit: BoxFit.cover)),
          ),
            
           //Text("News Today",style: TextStyle(fontSize: 45,fontWeight: FontWeight.w900),),
                      
                      /*Text("Every day start with a new begining.Lets start a fresh day with fresh news",
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      ),*/
        ],
      ),
    );
  }
}