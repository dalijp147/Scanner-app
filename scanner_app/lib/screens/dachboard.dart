import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:scanner_app/screens/scan_screen.dart';
import 'file_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'chart.dart';
import 'package:provider/provider.dart';
import '../providers/click.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DachBoard extends StatefulWidget {
  @override
  State<DachBoard> createState() => _DachBoardState();
}

class _DachBoardState extends State<DachBoard> {
  Widget build(BuildContext context) {
    final count = Provider.of<Clicks>(context).getCounter();
    final v = Provider.of<Clicks>(context).getCounter();
    final vvv = Provider.of<Clicks>(context).ftechAndSetPlaces();
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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: BarChartSample3(),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 20),
                            blurRadius: 30,
                            spreadRadius: -5,
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          colors: [Colors.purple, Colors.blue],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' Total Number of card scanned',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          FutureBuilder(
                            future: Provider.of<Clicks>(context, listen: false)
                                .ftechAndSetPlaces(),
                            builder: (ctx, snapshot) => snapshot
                                        .connectionState ==
                                    ConnectionState.waiting
                                ? Center(
                                    child: Text(
                                      'there is no data ',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : Text(
                                    '$count',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 69, 0, 180),
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 20),
                            blurRadius: 30,
                            spreadRadius: -5,
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomCenter,
                          colors: [Colors.purple, Colors.blue],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' Number of card scanned daily',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$count',
                            style: TextStyle(
                                color: Color.fromARGB(255, 69, 0, 180),
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
