// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nckh/button_widget.dart';
import 'package:nckh/profile_widget.dart';
import 'package:nckh/textfield_widget.dart';
import 'package:nckh/user.dart';
import 'package:nckh/user_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class edit_pageThree extends StatefulWidget {
  const edit_pageThree({Key? key}) : super(key: key);

  @override
  State<edit_pageThree> createState() => _edit_pageThreeState();
}

class _edit_pageThreeState extends State<edit_pageThree> {
  User user = UserPreferences.getUser();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),
            SafeArea(
              child: ProfileWidget(
                imagePath: user.imagePath,
                isEdit: true,
                onClicked: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image == null) return;
                  final directory = await getApplicationDocumentsDirectory();
                  final name = basename(image.path);
                  final imageFile = File('${directory.path}/$name');
                  final newImage = await File(image.path).copy(imageFile.path);
                  setState(
                    () => user = user.copy(imagePath: newImage.path),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              label: 'Họ và tên:',
              text: user.name,
              onChanged: (name) => user = user.copy(name: name),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              label: 'Email:',
              text: user.email,
              onChanged: (email) => user = user.copy(email: email),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              label: 'Số Điện Thoại:',
              text: user.phonenum,
              onChanged: (phonenum) => user = user.copy(phonenum: phonenum),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              label: 'Thông tin:',
              text: user.about,
              maxLines: 5,
              onChanged: (about) => user = user.copy(about: about),
            ),
            const SizedBox(
              height: 24,
            ),
            ButtonWidget(
                text: 'Save',
                onClicked: () {
                  UserPreferences.setUser(user);
                  Navigator.of(context).pop();
                })
          ],
        ),
      );
}
