// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, camel_case_types, depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class pageOne extends StatefulWidget {
  const pageOne({Key? key}) : super(key: key);

  @override
  State<pageOne> createState() => pageOneState();
}

class pageOneState extends State<pageOne> {
  //pagecontroller
  final _controller = PageController();
  final time = DateFormat('yMMMd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.05),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This text is hidden here in case of neccessary legal activity! This project belongs to 3 students in ICTU (Huy, Ninh, Hải). This flutter project was written by Vũ Quang Huy ',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        time,
                        style: TextStyle(
                            color: Color.fromARGB(255, 140, 124, 255)),
                      )
                    ],
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(100, 140, 124, 255),
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.notifications,
                          color: Color.fromARGB(255, 140, 124, 255)))
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 250,
              padding: EdgeInsets.all(20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                children: [],
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                  activeDotColor: Color(0xffFFDE7D),
                  dotColor: Color(0xffF8F3D4)),
            )
          ],
        ),
      ),
    );
  }
}
