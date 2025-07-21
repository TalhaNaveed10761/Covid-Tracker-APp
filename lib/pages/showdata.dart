import 'package:flutter/material.dart';
import 'package:flutter_application_20/pages/Reuseablerow.dart';


class Showdata extends StatefulWidget {
  String name;
  String image;
  int cases, recovered,deaths,critical;

   Showdata({required this.name,
   required this.image,
   required this.cases,
   required this.recovered,
   required this.deaths,
   required this.critical,
  
   
   });

  @override
  State<Showdata> createState() => _ShowdataState();
}

class _ShowdataState extends State<Showdata> {
  var height,width;
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
   
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(

            
            alignment: Alignment.topCenter,
            children: [
             
              Padding(
              padding: const EdgeInsets.only(top:70),
                child: Card(
                  
                  child: Column(
                    
                    children: [
                      SizedBox(
               height: MediaQuery.of(context).size.height*.06,
              ),
                Resueablerow(title: "cases", value:widget.cases.toString()),
                
                Resueablerow(title: "recovered", value:widget.recovered.toString()),
                
                Resueablerow(title: "deaths", value:widget.deaths.toString()),
                
                Resueablerow(title: "critical", value:widget.critical.toString()),
                
                    ],
                  ),
                  
                ),
              ),
              CircleAvatar(
                
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],

          )
        ],
      ),
    );
  }
}