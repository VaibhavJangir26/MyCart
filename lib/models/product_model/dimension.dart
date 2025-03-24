class Dimension {
  final double? width;
  final double? height;
  final double? depth;

  Dimension({
    this.width,
    this.height,
    this.depth,
  });

  factory Dimension.fromJson(Map<String, dynamic> json) {
    return Dimension(
      width: json['width']?.toDouble(),
      height: json['height']?.toDouble(),
      depth: json['depth']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
    };
  }
}