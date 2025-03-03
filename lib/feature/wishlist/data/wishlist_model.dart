class WishlistModel {
  int? id;
  String? title;
  String? description;
  String? image;
  double? price;

  WishlistModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.price,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
    id: json['id'] as int,
    title: json['title'],
    description: json['description'],
    image: json['image'],
    price: json['price'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'image': image,
    'price': price,
  };
}