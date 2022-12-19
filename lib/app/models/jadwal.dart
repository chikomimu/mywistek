import 'package:mywistek/app/models/absensi.dart';
import 'package:mywistek/app/models/modul.dart';
import 'package:mywistek/app/models/tugas.dart';

class Jadwal {
  // String? title;
  String? namaMatkul;
  String? jamMulai;
  String? jamSelesai;
  String? namaDosen;
  String? kodeMatkul;
  String? sks;
  String? noRuang;
  String? kelPraktek;
  // List<Absensi> absen;
  // List<Modul> modul;
  // List<Tugas> tugas;
  Jadwal({
    // this.title,
    this.namaMatkul,
    this.jamMulai,
    this.jamSelesai,
    this.namaDosen,
    this.kodeMatkul,
    this.sks,
    this.noRuang,
    this.kelPraktek,
    // required this.absen,
    // required this.modul,
    // required this.tugas,
  });
}
