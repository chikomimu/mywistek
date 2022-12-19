import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mywistek/app/models/absensi.dart';
// import 'package:mywistek/app/models/api.dart';
import 'package:mywistek/app/models/jadwal.dart';
import 'package:mywistek/app/modules/detailmapel/widget/list_absen.dart';
import 'package:mywistek/app/modules/detailmapel/widget/list_bahanAjar.dart';
import 'package:mywistek/app/modules/detailmapel/widget/list_tugas.dart';
import 'package:mywistek/app/modules/home/views/home_view.dart';
import 'package:mywistek/app/modules/jadwal/widget/jadwal_bar.dart';
import 'package:mywistek/app/modules/login/views/login_view.dart';
import 'package:mywistek/utils/colors.dart';
import 'package:mywistek/utils/tab_silver_delegate.dart';
import 'package:mywistek/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailMapel extends StatefulWidget {
  final Jadwal detailJadwal;
  const DetailMapel(this.detailJadwal, {super.key});

  @override
  State<DetailMapel> createState() => _DetailMapelState(detailJadwal);
}

class _DetailMapelState extends State<DetailMapel> {
  _DetailMapelState(this.detailJadwal);

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

  String jurusan = "", semester = "", kelas = "", kodeMtk = "", nis = "";
  // ignore: prefer_typing_uninitialized_variables
  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      jurusan = preferences.getString("jurusan")!;
      semester = preferences.getString("semester")!;
      kelas = preferences.getString("kelas")!;
      nis = preferences.getString('username')!;
      _lihatAbsen(jurusan, semester, kelas, nis);
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
    _lihatAbsen(
      jurusan,
      semester,
      kelas,
      nis,
    );
  }

  var loading = false;
  final absensi = <Absensi>[];
  _lihatAbsen(String jurusan, String semester, String kelas, String nis) async {
    absensi.clear();
    setState(() {
      loading = true;
    });
    String kode_mtk = detailJadwal.kodeMatkul!;
    print(kode_mtk);
    final response = await http.get(Uri.parse(
      'https://mywistek.wistek.id/dataAbsen/dataAbsen.php?semester=$semester&kelas=$kelas&jurusan=$jurusan&kode_mtk=$kode_mtk&nis=$nis',
    ));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new Absensi(
          tanggal: api['hari'] + ' , ' + api['waktu_absen'],
          pertemuan: api['pertemuan'],
          jam: api['waktuKuliah'],
          noRuang: api['keterangan'],
          namaKampus: 'Margonda',
          keterangan: api['keterangan'],
        );
        absensi.add(ab);
        print(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  // String formattedDate = DateFormat('kk:mm').format(DateTime.now());

  absen(String nis, String kodeMtk, String jurusan, String semester,
      String kelas, String keterangan) async {
    final response = await http.post(
        Uri.parse('https://mywistek.wistek.id/dataAbsen/inputAbsen.php'),
        body: {
          'nis': nis,
          'kode_mtk': kodeMtk,
          'jurusan': jurusan,
          'semester': semester,
          'kelas': kelas,
          'keterangan': keterangan,
        });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      Fluttertoast.showToast(
        msg: 'Absen Berhasil',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
      print(pesan);
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Absen Gagal',
        toastLength: Toast.LENGTH_SHORT,
      );
      print(pesan);
    }
  }

  final Jadwal detailJadwal;
  final tabs = ['Absensi', 'Bahan Ajar', 'Tugas'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text(
                  detailJadwal.namaMatkul as String,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                pinned: true,
                elevation: 0,
                backgroundColor: AppColors.mainColor,
                leading: _buildIcon(
                  context,
                  Icons.arrow_back_ios_outlined,
                ),
              ),
              SliverPersistentHeader(
                delegate: TabSliverDelegate(
                  TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey[500],
                    indicatorColor: Colors.black,
                    isScrollable: false,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 14),
                    tabs: tabs
                        .map((e) => Tab(
                              child: Text(
                                e,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                pinned: true,
              )
            ];
          },
          body: TabBarView(
            children: [
              DetailList('Absensi', absensi),
              ListBahanAjar('Bahan Ajar', absensi),
              ListTugas('Tugas', absensi),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            openDialog(detailJadwal.kodeMatkul as String, nis, jurusan,
                semester, kelas);
          },
          label: Text('Absen'),
          icon: const Icon(Icons.signpost_sharp),
          backgroundColor: Colors.lightBlue,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Future openDialog(kodeMtk, nis, jurusan, semester, kelas) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Absensi"),
          content: Text('Silakan Tekan Tombol Hadir!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                String keterangan;
                absen(nis, kodeMtk, jurusan, semester, kelas,
                    keterangan = 'hadir');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailMapel(detailJadwal)));
              },
              child: Text('Hadir'),
            ),
            ElevatedButton(
              onPressed: () {
                String keterangan;
                absen(nis, kodeMtk, jurusan, semester, kelas,
                    keterangan = 'tidak hadir');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailMapel(detailJadwal)));
              },
              child: Text('Tidak Hadir'),
            ),
          ],
        ),
      );

  _buildIcon(BuildContext context, IconData icon) {
    return IconButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => JadwalBar(SignOut))),
      splashRadius: 20,
      icon: Icon(
        icon,
        color: AppColors.white,
        size: 20,
      ),
    );
  }
}
