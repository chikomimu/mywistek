import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tugas {
  IconData? icon;
  String? judul;
  String? mulai;
  String? akhir;
  String? descTugas;
  Tugas({
    this.icon,
    this.judul,
    this.mulai,
    this.akhir,
    this.descTugas,
  });

  static List<Tugas> generatetugasMtk() {
    return [
      Tugas(
        icon: Icons.task,
        judul: 'Tugas 1 MTK',
        mulai: 'Senin, 10/10/2020',
        akhir: 'Rabu, 12/10/2020',
        descTugas: 'Membuat Bilangan Bulat',
      ),
      Tugas(
        icon: Icons.task,
        judul: 'Tugas 2 MTK',
        mulai: 'Senin, 20/10/2020',
        akhir: 'Jumat, 25/10/2020',
        descTugas: 'Membuat Bilangan Binner',
      ),
    ];
  }

  static List<Tugas> generatetugasBindo() {
    return [
      Tugas(
        icon: Icons.task,
        judul: 'Tugas 1 Bahasa Indonesia',
        mulai: 'Senin, 10/10/2020',
        akhir: 'Rabu, 12/10/2020',
        descTugas: 'Membuat Cerpen',
      ),
      Tugas(
        icon: Icons.task,
        judul: 'Tugas 2 Bahasa Indonesia',
        mulai: 'Senin, 20/10/2020',
        akhir: 'Jumat, 25/10/2020',
        descTugas: 'Membuat Pidato',
      ),
      Tugas(
        icon: Icons.task,
        judul: 'Tugas 3 Bahasa Indonesia',
        mulai: 'Senin, 1/11/2020',
        akhir: 'Kamis, 10/11/2020',
        descTugas: 'Membuat Narasi',
      ),
    ];
  }
}
