import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mywistek/app/modules/jadwal/widget/jadwal_bar.dart';
import 'package:mywistek/app/modules/login/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/jadwal_controller.dart';

class JadwalView extends StatefulWidget {
  final VoidCallback signOut;
  JadwalView(this.signOut);

  @override
  State<JadwalView> createState() => _JadwalViewState();
}

class _JadwalViewState extends State<JadwalView> {
  SignOut() {
    setState(() {
      widget.signOut();
    });
  }

  @override
  Widget build(BuildContext context) {
    return JadwalBar(SignOut);
  }
}
