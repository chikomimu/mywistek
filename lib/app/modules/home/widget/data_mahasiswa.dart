import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mywistek/app/models/api.dart';

import 'berita_terbaru.dart';
import 'menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DataMahasiswa extends StatefulWidget {
  final VoidCallback signOut;
  const DataMahasiswa(this.signOut, {super.key});

  @override
  State<DataMahasiswa> createState() => _DataMahasiswaState();
}

class _DataMahasiswaState extends State<DataMahasiswa> {
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

  var jurusanAPI, namaAPI, kelasAPI, semesterAPI, namaJurusan;
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
          namaAPI = datasiswa['nama'];
          jurusanAPI = datasiswa['kode_jurusan'];
          semesterAPI = datasiswa['semester'];
          kelasAPI = datasiswa['kelas'];
          namaJurusan = datasiswa['jurusan'];
          saveData(jurusanAPI, semesterAPI, kelasAPI);
        });
      }
    } else {
      print('failed');
    }
    setState(() {
      loading = false;
    });
  }

  saveData(String jurusan, String semester, String kelas) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString('jurusan', jurusan);
      preferences.setString('semester', semester);
      preferences.setString('kelas', kelas);
      // ignore: deprecated_member_use
      preferences.commit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      height: MediaQuery.of(context).size.width * 1.624,
      decoration: const BoxDecoration(
        color: Color(0xFFf6f8ff),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            height: 300,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: AssetImage('assets/images/background2.jpg')
                    as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                _buildTitleData('Program Studi'),
                _buildData('${namaJurusan}'),
                _buildTitleData('Semester / Kelas'),
                _buildData('${semesterAPI} / ${kelasAPI}'),
                _buildTitleData('Indeks Prestasi Kumulatif'),
                _buildData('3.46'),
                _buildTitleData('Total Satuan Kredit Semester'),
                _buildData('83'),
              ],
            ),
          ),
          Menu(SignOut),
          _buildTitle('Berita Terbaru'),
          BeritaTerbaru(),
        ],
      ),
    );
  }
}

Widget _buildTitleData(String text) {
  return Container(
    // padding: const EdgeInsets.symmetric(horizontal: 25),
    width: double.maxFinite,
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildData(String text) {
  return Container(
    padding: const EdgeInsets.only(bottom: 25),
    width: double.maxFinite,
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildTitle(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    width: double.maxFinite,
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.black87,
      ),
    ),
  );
}
