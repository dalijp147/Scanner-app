import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:scanner_app/screens/scan_screen.dart';
import 'file_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'chart.dart';

class DachBoard extends StatelessWidget {
  final int counter;
  DachBoard(this.counter);

  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.blue])),
      // ignore: sort_child_properties_last
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Center(
            child: Text(
              'DashBoard',
              textAlign: TextAlign.justify,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: LineChartSample2(),
                ),
                SizedBox(
                  height: 20,
                ),
                /*
              Container(
                height: 310,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),*/

                Column(
                  children: [
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 0, 0, 0),
                              blurRadius: 2.0,
                              offset: Offset(2.0, 2.0)),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Number of card scanned'),
                          Text(
                            '$counter',
                            style: TextStyle(
                                color: Color.fromARGB(255, 69, 0, 180),
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/scanscreen');
                },
                icon: Icon(
                  Icons.wifi_find,
                  color: Colors.black,
                  size: 25,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/filescreen');
                },
                icon: Icon(
                  Icons.book_rounded,
                  color: Colors.black,
                  size: 25,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.dashboard,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
