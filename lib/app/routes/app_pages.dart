import 'dart:ui';

import 'package:get/get.dart';

import '../modules/detailmapel/bindings/detailmapel_binding.dart';
import '../modules/detailmapel/views/detailmapel_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/jadwal/bindings/jadwal_binding.dart';
import '../modules/jadwal/views/jadwal_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(signOut!),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.JADWAL,
      page: () => JadwalView(signOut!),
      binding: JadwalBinding(),
    ),
    GetPage(
      name: _Paths.DETAILMAPEL,
      page: () => const DetailmapelView(),
      binding: DetailmapelBinding(),
    ),
  ];

  static VoidCallback? get signOut => null;
}
