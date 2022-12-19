import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Modul {
  // String? judul;
  IconData? icon;
  String? namaFile;
  String? besarFile;
  Modul({
    // this.judul,
    this.icon,
    this.namaFile,
    this.besarFile,
  });

  static List<Modul> generateModulMtk() {
    return [
      Modul(
        icon: Icons.file_copy,
        namaFile: 'Materi 1 MTK',
        besarFile: '550 KB',
      ),
      Modul(
        icon: Icons.file_copy,
        namaFile: 'Materi 2 MTK',
        besarFile: '550 KB',
      ),
      Modul(
        icon: Icons.file_copy,
        namaFile: 'Materi 3 MTK',
        besarFile: '550 KB',
      ),
      Modul(
        icon: Icons.file_copy,
        namaFile: 'Materi 4 MTK',
        besarFile: '550 KB',
      ),
      Modul(
        icon: Icons.file_copy,
        namaFile: 'Materi 5 MTK',
        besarFile: '550 KB',
      ),
      Modul(
        icon: Icons.file_copy,
        namaFile: 'Materi 6 MTK',
        besarFile: '550 KB',
      ),
      Modul(
        icon: Icons.file_copy,
        namaFile: 'Materi 7 MTK',
        besarFile: '550 KB',
      ),
    ];
  }

  static List<Modul> generateModulBindo() {
    return [
      Modul(
        icon: Icons.file_copy,
        namaFile: 'Materi 1 Bahasa Indonesia',
        besarFile: '550 KB',
      ),
      Modul(
        icon: Icons.file_copy,
        namaFile: 'Materi 2 Bahasa Indonesia',
        besarFile: '550 KB',
      ),
      Modul(
        icon: Icons.file_copy,
        namaFile: 'Materi 3 Bahasa Indonesia',
        besarFile: '550 KB',
      ),
      Modul(
        icon: Icons.file_copy,
        namaFile: 'Materi 4 Bahasa Indonesia',
        besarFile: '550 KB',
      ),
      Modul(
        icon: Icons.file_copy,
        namaFile: 'Materi 5 Bahasa Indonesia',
        besarFile: '550 KB',
      ),
      Modul(
        icon: Icons.file_copy,
        namaFile: 'Materi 6 Bahasa Indonesia',
        besarFile: '550 KB',
      ),
      Modul(
        icon: Icons.file_copy,
        namaFile: 'Materi 7 Bahasa Indonesia',
        besarFile: '550 KB',
      ),
    ];
  }
}
