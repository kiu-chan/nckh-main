import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class pageFour extends StatefulWidget {
  const pageFour({super.key});

  @override
  State<pageFour> createState() => _pageFour();
}

class _pageFour extends State<pageFour> {
  List<String> items = []; // Start with an empty list

  Future refresh() async {
    final url = Uri.parse('http://14.225.211.5:5002');
  print("hello");
    try {
      final response = await http.get(url);
      print('Response Body: ${response}');
      if (response.statusCode == 200) {
        final List<String> newItems = json.decode(response.body);
        print('Response Body: ${response.body}');
        print('Response Body: ${newItems}');
        setState(() {
          items.addAll(newItems
              .map<String>((item) => 'Tài xế đã ngủ gật vào lúc: $item')
              .toList());
        });
      } else {
        // Error handling for unsuccessful HTTP status codes
        debugPrint('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.05),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Container(
              child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Lịch sử ngủ gật',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: refresh,
                      child: ListView.builder(
                          padding: EdgeInsets.all(8),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return Card(
                              elevation: 0.0,
                              color: Colors.grey.withOpacity(0.05),
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(64, 75, 96, .9),
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    leading: Container(
                                      padding: EdgeInsets.only(right: 12.0),
                                      decoration: new BoxDecoration(
                                          border: new Border(
                                              right: new BorderSide(
                                                  width: 1.0,
                                                  color: Colors.white24))),
                                      child: Icon(Icons.ballot_rounded,
                                          color: Colors.white),
                                    ),
                                    title: Text(
                                      item,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ]),
          )),
        ),
      ),
    );
  }
}
