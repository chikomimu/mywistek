import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mywistek/app/modules/home/widget/header.dart';
import 'package:mywistek/app/modules/jadwal/widget/jadwal_bar.dart';
import 'package:mywistek/app/modules/login/views/login_view.dart';
import 'package:mywistek/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  final VoidCallback signOut;
  const Menu(this.signOut, {super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  SignOut() {
    setState(() {
      widget.signOut();
    });
  }

  late List<Map<String, dynamic>> list;
  @override
  void initState() {
    super.initState();
    list = [
      {
        'icon': Icons.search,
        'color': const Color(0xFF605cf4),
        'title': 'Informasi\nAkademik',
        'url': JadwalBar(SignOut),
      },
      {
        'icon': Icons.calendar_today,
        'color': const Color(0xFFfc77a6),
        'title': 'Kalender\nAkademik',
        'url': JadwalBar(SignOut),
      },
      {
        'icon': Icons.library_books,
        'color': const Color(0xFF4391ff),
        'title': 'Jadwal\nKuliah',
        'url': JadwalBar(SignOut),
      },
      {
        'icon': Icons.analytics,
        'color': const Color(0xFF7182f2),
        'title': 'Hasil\nStudy',
        'url': JadwalBar(SignOut),
      },
      {
        'icon': Icons.notes,
        'color': const Color(0xFFB0C4DE),
        'title': 'Catatan\nKehadiran',
        'url': JadwalBar(SignOut),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      decoration: const BoxDecoration(
        color: Color(0xFFf6f8ff),
      ),
      child: Column(
        children: [
          Container(
            height: 140,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: list[index]['color'] as Color,
                    ),
                    child: IconButton(
                        icon: Icon(list[index]['icon'] as IconData),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => list[index]['url']))
                        // Get.offAllNamed(list[index]['url'] as String),
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    list[index]['title'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              separatorBuilder: (_, index) => const SizedBox(width: 26),
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }
}
