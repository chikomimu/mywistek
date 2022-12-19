// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:mywistek/app/modules/home/widget/data_mahasiswa.dart';
// import 'package:mywistek/app/modules/home/widget/menu.dart';
// import 'package:mywistek/app/widget/app_icon.dart';
// import 'package:mywistek/app/modules/home/widget/header.dart';
// import 'package:mywistek/utils/colors.dart';
// import 'package:mywistek/utils/dimensions.dart';

// import '../controllers/home_controller.dart';

// class HomeViewAdmin extends StatelessWidget {
//   const HomeViewAdmin({Key? key}) : super(key: key);

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
//                 Header(),
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
