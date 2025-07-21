import 'package:flutter/material.dart';

import 'package:flutter_application_20/Services/ApiServices.dart';
import 'package:flutter_application_20/pages/showdata.dart';

class Countrylist extends StatefulWidget {
  const Countrylist({super.key});

  @override
  State<Countrylist> createState() => _CountrylistState();
}

class _CountrylistState extends State<Countrylist> {
  TextEditingController searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Countrylist",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          
        ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    
                  });
                },
                controller: searchcontroller,
                decoration: InputDecoration(
                  hintText: "Countrylist",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10,)
                  )
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: ApiServices.getworldlist(),
               builder: (context, snapshot) {
                 if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                 }else{
                  return ListView.builder(
                    itemCount:snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name=snapshot.data![index]["country"];
                      if(searchcontroller.text.isEmpty){
                       return ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Showdata(
                            name: snapshot.data![index]["country"],
                            image:  snapshot.data![index]["countryInfo"]["flag"],
                            cases:snapshot.data![index]["cases"],
                            deaths: snapshot.data![index]["deaths"],
                            critical:snapshot.data![index]["critical"], 
                            recovered: snapshot.data![index]["recovered"],
                          
                          ),));
                        },
                        leading: Image(
                          height: 50,
                          width: 50,
                          image: NetworkImage(
                          snapshot.data![index]["countryInfo"]["flag"]
                        ),
                        ),
                        title: Text(snapshot.data![index]["country"]),
                        subtitle: Text(snapshot.data![index]["cases"].toString()),
                      );
                      }else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase(
                       
                      ))){
                          return ListTile(
                            onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context) => Showdata(
                            name: snapshot.data![index]["country"],
                            image:  snapshot.data![index]["countryInfo"]["flag"],
                            cases:snapshot.data![index]["cases"],
                            deaths: snapshot.data![index]["deaths"],
                            critical:snapshot.data![index]["critical"], 
                            recovered: snapshot.data![index]["recovered"],
                           
                          ),));
                            },
                        leading: Image(
                          height: 50,
                          width: 50,
                          image: NetworkImage(
                          snapshot.data![index]["countryInfo"]["flag"]
                        ),
                        ),
                        title: Text(snapshot.data![index]["country"]),
                        subtitle: Text(snapshot.data![index]["cases"].toString()),
                      );
                      }else{
                        return Container();

                      }
                     
                    },);
                 }
               },
              ),
            )
          ],
        ),
      ),
    );
  }
}