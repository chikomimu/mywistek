import 'package:get/get.dart';

import '../controllers/detailmapel_controller.dart';

class DetailmapelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailmapelController>(
      () => DetailmapelController(),
    );
  }
}
