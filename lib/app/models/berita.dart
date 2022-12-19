class Berita {
  String bgImg;
  String icon;
  String name;
  String type;
  // List<String> imgs;
  Berita(
    this.bgImg,
    this.icon,
    this.name,
    this.type,
    // this.imgs,
  );
  static List<Berita> generateBerita() {
    return [
      Berita(
        'assets/images/background.jpg',
        'assets/images/logo-splash.png',
        'Berita 1',
        'Pendidikan',
      ),
      Berita(
        'assets/images/background2.jpg',
        'assets/images/logo-splash.png',
        'Berita 2',
        'Perkuliahaan',
      ),
      Berita(
        'assets/images/background.jpg',
        'assets/images/logo-splash.png',
        'Berita 2',
        'Perkuliahaan',
      ),
    ];
  }
}
