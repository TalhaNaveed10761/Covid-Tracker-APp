import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_20/Services/ApiServices.dart';
import 'package:flutter_application_20/pages/Countrylist.dart';
import 'package:flutter_application_20/pages/Reuseablerow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class worldstates extends StatefulWidget {
  const worldstates({super.key});

  @override
  State<worldstates> createState() => _worldstatedState();
}

class _worldstatedState extends State<worldstates>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 5),
    vsync: this,
  )..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            FutureBuilder(
              future: ApiServices.getworldstat(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      controller: _controller,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total":
                              double.parse(snapshot.data!.cases!.toString()),
                          "Recovered": double.parse(
                              snapshot.data!.recovered!.toString()),
                          "Death":
                              double.parse(snapshot.data!.deaths!.toString())
                        },
                        chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        chartRadius: width * 0.3,
                        animationDuration: Duration(milliseconds: 1200),
                        legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left),
                        chartType: ChartType.ring,
                        colorList: [Colors.green, Colors.red, Colors.blue],
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Column(
                            children: [
                              Resueablerow(
                                  title: "Cases",
                                  value: snapshot.data!.cases.toString()),
                              Resueablerow(
                                  title: "Active",
                                  value: snapshot.data!.active.toString()),
                              Resueablerow(
                                  title: "Deaths",
                                  value: snapshot.data!.deaths.toString()),
                              Resueablerow(
                                  title: "Critical",
                                  value: snapshot.data!.critical.toString()),
                              Resueablerow(
                                  title: "Recovered",
                                  value: snapshot.data!.recovered.toString()),
                              // Resueablerow(
                              //     title: "Today Deaths",
                              //     value:
                              //         snapshot.data!.todayDeaths.toString()),
                              // Resueablerow(
                              //     title: "Today Recovered",
                              //     value: snapshot.data!.todayRecovered
                              //         .toString())
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
            SizedBox(
              height: height*0.15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Countrylist(),));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: height*0.09,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text("Contrieslist",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
