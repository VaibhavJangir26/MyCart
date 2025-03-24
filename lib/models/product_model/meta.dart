
class Meta {

  final String? createdAt;
  final String? updatedAt;
  final String? barcode;
  final String? qrCode;


  Meta({this.createdAt,
    this.updatedAt,
    this.barcode,
    this.qrCode
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      barcode: json['barcode'],
      qrCode: json['qrCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'barcode': barcode,
      'qrCode': qrCode,
    };
  }
}
