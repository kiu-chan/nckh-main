// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, avoid_print

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'pageOne.dart';
import 'pagetest.dart';
import 'pageThree.dart';
import 'pageTwo.dart';
import 'pagefour.dart';
import 'edit_pageThree.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    LiveChartWidget(),
    pageTwo(),
    pageFour(),
    pageThree(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: pageList[pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        backgroundColor: Colors.grey.withOpacity(0.05),
        color: Color.fromARGB(255, 140, 187, 241),
        animationDuration: Duration(milliseconds: 200),
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.location_on, color: Colors.white),
          Icon(Icons.article_rounded, color: Colors.white),
          Icon(Icons.account_circle, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
          print(index);
        },
      ),
    );
  }
}
