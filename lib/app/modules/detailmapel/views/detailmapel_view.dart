import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detailmapel_controller.dart';

class DetailmapelView extends GetView<DetailmapelController> {
  const DetailmapelView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailmapelView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailmapelView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
