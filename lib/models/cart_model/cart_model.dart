class CartModel {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final String? brand;
  final int? weight;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final List<String>? images;
  final String? thumbnail;
  int quantity;

  CartModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.weight,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.images,
    this.thumbnail,
    this.quantity = 1,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as int?,
      title: map['title'] as String?,
      description: map['description'] as String?,
      category: map['category'] as String?,
      price: (map['price'] as num?)?.toDouble(),
      discountPercentage: (map['discountPercentage'] as num?)?.toDouble(),
      rating: (map['rating'] as num?)?.toDouble(),
      stock: map['stock'] as int?,
      brand: map['brand'] as String?,
      weight: map['weight'] as int?,
      warrantyInformation: map['warrantyInformation'] as String?,
      shippingInformation: map['shippingInformation'] as String?,
      availabilityStatus: map['availabilityStatus'] as String?,
      returnPolicy: map['returnPolicy'] as String?,
      minimumOrderQuantity: map['minimumOrderQuantity'] as int?,
      images: map['images'] != null
          ? List<String>.from(map['images'] as List<dynamic>)
          : null,
      thumbnail: map['thumbnail'] as String?,
      quantity: map['quantity'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'weight': weight,
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'images': images,
      'thumbnail': thumbnail,
      'quantity': quantity,
    };
  }

  CartModel copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    String? brand,
    int? weight,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    String? returnPolicy,
    int? minimumOrderQuantity,
    List<String>? images,
    String? thumbnail,
    int? quantity,
  }) {
    return CartModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      brand: brand ?? this.brand,
      weight: weight ?? this.weight,
      warrantyInformation: warrantyInformation ?? this.warrantyInformation,
      shippingInformation: shippingInformation ?? this.shippingInformation,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      returnPolicy: returnPolicy ?? this.returnPolicy,
      minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
      images: images ?? this.images,
      thumbnail: thumbnail ?? this.thumbnail,
      quantity: quantity ?? this.quantity,
    );
  }
}
