class Brand {
  final int id;
  final String name;
  final String imageName;
  // final int status;

  Brand({
    required this.id,
    required this.name,
    required this.imageName,
    // required this.status,
  });

  factory Brand.fromJson(Map<String, dynamic> data) => Brand(
        id: data["id"],
        name: data["name"],
        imageName: data["image"],
        // status: int.parse(data["status"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": imageName,
        // "status": status.toString(),
      };
}
