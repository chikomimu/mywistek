import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mywistek/app/models/absensi.dart';
import 'package:mywistek/utils/colors.dart';
import 'package:mywistek/utils/tab_silver_delegate.dart';
import 'package:mywistek/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailAbsen extends StatefulWidget {
  final Absensi absen;
  const DetailAbsen(this.absen, {super.key});

  @override
  State<DetailAbsen> createState() => _DetailAbsenState(absen);
}

class _DetailAbsenState extends State<DetailAbsen> {
  _DetailAbsenState(this.absen);
  final Absensi absen;

  String jurusan = "", semester = "", kelas = "";
  // ignore: prefer_typing_uninitialized_variables
  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      jurusan = preferences.getString("jurusan")!;
      semester = preferences.getString("semester")!;
      kelas = preferences.getString("kelas")!;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  var loading = false;
  final kehadiran = <Absensi>[];
  _lihatData(String jurusan, String semester, String kelas) async {
    kehadiran.clear();
    setState(() {
      loading = true;
    });
    String kodeMtk = absen.noRuang!;
    // print(kodeMtk);
    final response = await http.get(Uri.parse(
        'https://mywistek.wistek.id/dataMatakuliah/dataMatkul.php?jurusan=$jurusan&kelas=$kelas&semester=$semester&kode_mtk=$kodeMtk'));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new Absensi();
        kehadiran.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      padding: EdgeInsets.only(top: 10, left: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            absen.tanggal as String,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          Text(
            absen.pertemuan as String,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          Text(
            '(${absen.jam}) - ${absen.noRuang} | Kampus ${absen.namaKampus} ',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 5),
          if (absen.keterangan == 'hadir')
            Column(
              children: [
                Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(2),
                  width: 50,
                  child: Text(
                    'Hadir',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          if (absen.keterangan != 'hadir')
            Column(
              children: [
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(2),
                  width: 80,
                  child: Text(
                    'Tidak Hadir',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// class DetailAbsen extends StatelessWidget {
//   final Absensi absen;
//   const DetailAbsen(this.absen, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 95,
//       padding: EdgeInsets.only(top: 10, left: 25),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             absen.tanggal as String,
//             style: const TextStyle(
//               fontWeight: FontWeight.w300,
//               fontSize: 12,
//               color: Colors.grey,
//             ),
//           ),
//           Text(
//             absen.pertemuan as String,
//             style: const TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 15,
//             ),
//           ),
//           Text(
//             '(${absen.jam}) - ${absen.noRuang} | Kampus ${absen.namaKampus} ',
//             style: const TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 12,
//               color: Colors.grey,
//             ),
//           ),
//           SizedBox(height: 5),
//           if (absen.keterangan)
//             Column(
//               children: [
//                 Container(
//                   color: Colors.green,
//                   padding: EdgeInsets.all(2),
//                   width: 50,
//                   child: Text(
//                     'Hadir',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 11,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           if (absen.keterangan != true)
//             Column(
//               children: [
//                 Container(
//                   color: Colors.red,
//                   padding: EdgeInsets.all(2),
//                   width: 80,
//                   child: Text(
//                     'Tidak Hadir',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 11,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }
