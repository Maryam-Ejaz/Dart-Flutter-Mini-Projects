class Product {
  int id;
  String title;
  String description;

  Product({required this.id, required this.title, required this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'], description: json['description'], title: json['title']);
  }


}
