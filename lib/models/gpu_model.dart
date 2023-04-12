class GPU {
  String name;
  String brand;
  String urlImage;
  List<String> tags = [];
  int vram;
  double price;
  double clock;
  int memoryInterface;
  double energy;

  GPU({
    required this.name,
    required this.brand,
    required this.vram,
    required this.price,
    required this.urlImage,
    required this.clock,
    required this.energy,
    required this.memoryInterface,
    required this.tags,
  });
}
