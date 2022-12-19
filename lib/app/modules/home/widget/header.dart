import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:mywistek/app/models/menu_item.dart';
import 'package:mywistek/app/models/menu_items.dart';
import 'package:mywistek/app/modules/login/views/login_view.dart';
import 'package:mywistek/utils/colors.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Header extends StatefulWidget {
  final VoidCallback signOut;
  const Header(this.signOut, {super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  SignOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove("value");
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoginView()),
        (route) => false);
  }

  String username = "";
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username")!;
      // nama = preferences.getString("nama")!;
      _lihatData(username);
    });
  }

  var appBarHeight = AppBar().preferredSize.height;

  @override
  void initState() {
    super.initState();
    getPref();
    _lihatData(username);
  }

  var nama, foto;
  bool loading = false;
  Future<void> _lihatData(String username) async {
    setState(() {
      loading = true;
    });
    final response = await http.get(Uri.parse(
        'https://mywistek.wistek.id/data/dataSiswa.php?nis=$username'));
    // print(response.statusCode);

    if (response.statusCode == 200) {
      var datasiswa = jsonDecode(response.body);
      if (datasiswa['nis'] != null) {
        setState(() {
          nama = datasiswa['nama'];
          foto = datasiswa['foto'];
          // dataSiswa = datasiswa['nama'][0];
          // print(nama);
        });
      }
    } else {
      print('failed');
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 25,
        right: 25,
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Image.asset(
                    'assets/images/logo-splash.png',
                    height: 75,
                    width: 75,
                  ),
                ],
              ),
              Text(
                "MY WISTEK",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              PopupMenuButton<MenuKu>(
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                  ...MenuItems.itemFirst.map(buildItem).toList(),
                  PopupMenuDivider(),
                  ...MenuItems.itemSecond.map(buildItem).toList(),
                ],
                icon: CircleAvatar(
                  child: Image.asset(
                    'assets/images/$foto',
                    fit: BoxFit.cover,
                  ),
                ),
                offset: Offset(0.0, appBarHeight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
              ),
              //
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 90),
              Container(
                width: 300,
                child: Text(
                  '${nama}',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                username,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  PopupMenuItem<MenuKu> buildItem(MenuKu item) => PopupMenuItem<MenuKu>(
        value: item,
        child: Row(
          children: [
            Icon(
              item.icon,
              color: Colors.black,
              size: 20,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(item.text),
          ],
        ),
      );

  void onSelected(BuildContext context, MenuKu item) {
    switch (item) {
      case MenuItems.itemLogout:
        SignOut();
        break;
    }
  }
}
