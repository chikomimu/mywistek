import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mywistek/app/models/api.dart';

import 'package:mywistek/app/modules/home/widget/data_mahasiswa.dart';
import 'package:mywistek/app/modules/home/widget/menu.dart';
import 'package:mywistek/app/modules/login/views/login_view.dart';
import 'package:mywistek/app/widget/app_icon.dart';
import 'package:mywistek/app/modules/home/widget/header.dart';
import 'package:mywistek/utils/colors.dart';
import 'package:mywistek/utils/dimensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  final VoidCallback signOut;
  HomeView(this.signOut, {super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  SignOut() {
    setState(() {
      widget.signOut();
    });
  }

  String username = "";
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username")!;
      // nama = preferences.getString("nama")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Transform(
              transform: Matrix4.identity()..rotateZ(25),
              origin: const Offset(-200, 420),
              child: Image.asset(
                'assets/images/liquid-top.png',
                width: 200,
              ),
            ),
            Positioned(
              right: 0,
              top: 220,
              child: Transform(
                transform: Matrix4.identity()..rotateZ(5),
                origin: const Offset(55, 40),
                child: Image.asset(
                  'assets/images/liquid-bottom.png',
                  width: 200,
                ),
              ),
            ),
            Column(
              children: [
                // Text('Berhasil')
                Header(SignOut),
                DataMahasiswa(SignOut),
              ],
            )
          ],
        ),
      ),
    );
  }
}


// class HomeView extends StatelessWidget {
//   final String username;
//   const HomeView(this.username, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Transform(
//               transform: Matrix4.identity()..rotateZ(25),
//               origin: const Offset(-200, 420),
//               child: Image.asset(
//                 'assets/images/liquid-top.png',
//                 width: 200,
//               ),
//             ),
//             Positioned(
//               right: 0,
//               top: 220,
//               child: Transform(
//                 transform: Matrix4.identity()..rotateZ(5),
//                 origin: const Offset(55, 40),
//                 child: Image.asset(
//                   'assets/images/liquid-bottom.png',
//                   width: 200,
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 const Header(),
//                 dataMahasiswa(),
//                 // Menu(),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
