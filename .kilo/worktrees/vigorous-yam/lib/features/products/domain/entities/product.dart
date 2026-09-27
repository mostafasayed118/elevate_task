class Product {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.count,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rate;
  final int count;

  /// Fake "old price" to match the design (crossed-out price).
  double get oldPrice => price * 1.25;
}
