import 'package:driverprofile_mobikad/pages/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DriverProfile());
}

class DriverProfile extends StatefulWidget {
  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UI Practice Design",
      debugShowCheckedModeBanner: false,

      home: RegisterPage(),

    );
  }
}


