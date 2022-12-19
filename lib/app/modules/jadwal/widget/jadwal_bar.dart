import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mywistek/app/models/absensi.dart';
// import 'package:mywistek/app/models/jadwalBackup.dart';
import 'package:mywistek/app/models/jadwal.dart';
import 'package:mywistek/app/models/menu_item.dart';
import 'package:mywistek/app/models/menu_items.dart';
import 'package:mywistek/app/modules/home/views/home_view.dart';
import 'package:mywistek/app/modules/home/widget/header.dart';
import 'package:mywistek/app/modules/jadwal/widget/jadwal_list.dart';
import 'package:mywistek/app/modules/login/views/login_view.dart';
import 'package:mywistek/utils/tab_silver_delegate.dart';
import 'package:mywistek/app/routes/app_pages.dart';
import 'package:mywistek/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class JadwalBar extends StatefulWidget {
  final VoidCallback signOut;
  const JadwalBar(this.signOut, {super.key});

  @override
  State<JadwalBar> createState() => _JadwalBarState();
}

class _JadwalBarState extends State<JadwalBar> {
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
      _lihatDataSenin(jurusan, semester, kelas);
      _lihatDataSelasa(jurusan, semester, kelas);
      _lihatDataRabu(jurusan, semester, kelas);
      _lihatDataKamis(jurusan, semester, kelas);
      _lihatDataJumat(jurusan, semester, kelas);
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
    _lihatDataSenin(jurusan, semester, kelas);
    _lihatDataSelasa(jurusan, semester, kelas);
    _lihatDataRabu(jurusan, semester, kelas);
    _lihatDataKamis(jurusan, semester, kelas);
    _lihatDataJumat(jurusan, semester, kelas);
    _lihatDataMatkul();
    // _lihatDataAllMatkul(jurusan, semester, kelas);
    saveData(kodeMtk);
  }

  bool loadingAllMatkul = false;
  String kodeMtk = "";
  final dataMatkul = [];
  Future<void> _lihatDataMatkul() async {
    setState(() {
      loadingAllMatkul = true;
    });
    final response = await http.get(Uri.parse(
        'https://mywistek.wistek.id/dataMatakuliah/dataAllMatkul.php'));
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var datamatkul = jsonDecode(response.body);
      if (response.contentLength == 2) {
      } else {
        final data = jsonDecode(response.body);
        data.forEach((api) {
          final ab = (api['kode_mtk']);
          setState(() {
            saveData(api['kode_mtk']);
          });
          dataMatkul.add(ab);
        });
        setState(() {
          loadingAllMatkul = false;
        });
      }
    }
  }

  saveData(String kodeMtk) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString('kodeMtk', kodeMtk);
      // ignore: deprecated_member_use
      preferences.commit();
    });
  }

  var loadingSenin = false;
  final hariSenin = <Jadwal>[];
  _lihatDataSenin(String jurusan, String semester, String kelas) async {
    hariSenin.clear();
    setState(() {
      loadingSenin = true;
    });
    final response = await http.get(Uri.parse(
        'https://mywistek.wistek.id/dataMatakuliah/dataMatkulSenin.php?jurusan=$jurusan&kelas=$kelas&semester=$semester'));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new Jadwal(
          namaMatkul: api['nama_mtk'],
          jamMulai: api['jam_mulai'],
          jamSelesai: api['jam_akhir'],
          namaDosen: api['nama_dosen'],
          kodeMatkul: api['kode_mtk'],
          sks: api['sks'],
          noRuang: api['no_ruang'],
          kelPraktek: api['kel_praktek'],
          // absen: Absensi.generateMtk(),
        );
        hariSenin.add(ab);
      });
      setState(() {
        loadingSenin = false;
      });
    }
  }

  var loadingSelasa = false;
  final hariSelasa = <Jadwal>[];
  _lihatDataSelasa(String jurusan, String semester, String kelas) async {
    hariSelasa.clear();
    setState(() {
      loadingSelasa = true;
    });
    final response = await http.get(Uri.parse(
        'https://mywistek.wistek.id/dataMatakuliah/dataMatkulSelasa.php?jurusan=$jurusan&kelas=$kelas&semester=$semester'));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        // ignore: unnecessary_new
        final ab = new Jadwal(
          namaMatkul: api['nama_mtk'],
          jamMulai: api['jam_mulai'],
          jamSelesai: api['jam_akhir'],
          namaDosen: api['nama_dosen'],
          kodeMatkul: api['kode_mtk'],
          sks: api['sks'],
          noRuang: api['no_ruang'],
          kelPraktek: api['kel_praktek'],
          // absen: Absensi.generateMtk(),
        );
        hariSelasa.add(ab);
      });
      setState(() {
        loadingSelasa = false;
      });
    }
  }

  var loadingRabu = false;
  final hariRabu = <Jadwal>[];
  _lihatDataRabu(String jurusan, String semester, String kelas) async {
    hariRabu.clear();
    setState(() {
      loadingRabu = true;
    });
    final response = await http.get(Uri.parse(
        'https://mywistek.wistek.id/dataMatakuliah/dataMatkulRabu.php?jurusan=$jurusan&kelas=$kelas&semester=$semester'));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new Jadwal(
          namaMatkul: api['nama_mtk'],
          jamMulai: api['jam_mulai'],
          jamSelesai: api['jam_akhir'],
          namaDosen: api['nama_dosen'],
          kodeMatkul: api['kode_mtk'],
          sks: api['sks'],
          noRuang: api['no_ruang'],
          kelPraktek: api['kel_praktek'],
          // absen: Absensi.generateMtk(),
        );
        hariRabu.add(ab);
      });
      setState(() {
        loadingRabu = false;
      });
    }
  }

  var loadingKamis = false;
  final hariKamis = <Jadwal>[];
  _lihatDataKamis(String jurusan, String semester, String kelas) async {
    hariKamis.clear();
    setState(() {
      loadingKamis = true;
    });
    final response = await http.get(Uri.parse(
        'https://mywistek.wistek.id/dataMatakuliah/dataMatkulKamis.php?jurusan=$jurusan&kelas=$kelas&semester=$semester'));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new Jadwal(
          namaMatkul: api['nama_mtk'],
          jamMulai: api['jam_mulai'],
          jamSelesai: api['jam_akhir'],
          namaDosen: api['nama_dosen'],
          kodeMatkul: api['kode_mtk'],
          sks: api['sks'],
          noRuang: api['no_ruang'],
          kelPraktek: api['kel_praktek'],
          // absen: Absensi.generateMtk(),
        );
        hariKamis.add(ab);
      });
      setState(() {
        loadingKamis = false;
      });
    }
  }

  var loadingJumat = false;
  final hariJumat = <Jadwal>[];
  _lihatDataJumat(String jurusan, String semester, String kelas) async {
    hariJumat.clear();
    setState(() {
      loadingJumat = true;
    });
    final response = await http.get(Uri.parse(
        'https://mywistek.wistek.id/dataMatakuliah/dataMatkulJumat.php?jurusan=$jurusan&kelas=$kelas&semester=$semester'));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new Jadwal(
          namaMatkul: api['nama_mtk'],
          jamMulai: api['jam_mulai'],
          jamSelesai: api['jam_akhir'],
          namaDosen: api['nama_dosen'],
          kodeMatkul: api['kode_mtk'],
          sks: api['sks'],
          noRuang: api['no_ruang'],
          kelPraktek: api['kel_praktek'],
          // absen: Absensi.generateMtk(),
        );
        hariJumat.add(ab);
      });
      setState(() {
        loadingJumat = false;
      });
    }
  }

  final tabs = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                centerTitle: true,
                title: Text(
                  "Jadwal Mata Kuliah",
                ),
                pinned: true,
                elevation: 0,
                backgroundColor: AppColors.mainColor,
                leading: _buildIcon(
                  context,
                  Icons.arrow_back_ios_outlined,
                ),
                actions: [
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: PopupMenuButton<MenuKu>(
                      onSelected: (item) => onSelected(context, item),
                      itemBuilder: (context) => [
                        ...MenuItems.itemFirst.map(buildItem).toList(),
                        PopupMenuDivider(),
                        ...MenuItems.itemSecond.map(buildItem).toList(),
                      ],
                      icon: CircleAvatar(
                        backgroundColor: AppColors.white,
                        child: Image.asset(
                          'assets/images/default.png',
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ],
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
              JadwalList('Senin', hariSenin),
              JadwalList('Selasa', hariSelasa),
              JadwalList('Rabu', hariRabu),
              JadwalList('Kamis', hariKamis),
              JadwalList('Jumat', hariJumat),
            ],
          ),
        ),
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

  _buildIcon(BuildContext context, IconData icon) {
    return IconButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeView(SignOut))),
      splashRadius: 20,
      icon: Icon(
        icon,
        color: AppColors.white,
        size: 20,
      ),
    );
  }
}
