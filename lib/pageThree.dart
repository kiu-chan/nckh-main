// ignore_for_file: prefer_const_constructors, file_names, camel_case_types, prefer_const_literals_to_create_immutables, prefer_const_declarations, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:nckh/button_widget.dart';
import 'package:nckh/edit_pageThree.dart';
import 'package:nckh/profile_widget.dart';
import 'package:nckh/user.dart';
import 'package:nckh/user_preferences.dart';

class pageThree extends StatefulWidget {
  @override
  _pageThree createState() => _pageThree();
}

class _pageThree extends State<pageThree> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();

    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.05),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),
            ProfileWidget(
              imagePath: user.imagePath,
              onClicked: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const edit_pageThree()),
                );
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            buildName(user),
            const SizedBox(
              height: 20,
            ),
            Center(child: buildUpgradeButton()),
            const SizedBox(height: 40),
            buildAbout(user),
          ],
        ));
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            user.email,
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            user.phonenum,
            style: TextStyle(color: Colors.black),
          ),
        ],
      );
  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade to PRO',
        onClicked: () {},
      );
  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin cá nhân',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(user.about, style: TextStyle(fontSize: 16, height: 1.4)),
          ],
        ),
      );
}
