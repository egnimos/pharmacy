class Prescription {
  final int id;
  final int userId;
  final String name;
  final String phone;
  final String imageName;
  final String createdAt;
  final String updatedAt;
  final String imageUriPath;

  Prescription({
    required this.id,
    required this.userId,
    required this.phone,
    required this.name,
    required this.imageName,
    required this.createdAt,
    required this.updatedAt,
    this.imageUriPath = "https://dawadoctor.co.in/images/perscrption/",
  });

  factory Prescription.fromJson(Map<String, dynamic> data) => Prescription(
        id: data["id"],
        userId: data["user_id"],
        name: data["name"],
        phone: data["phone"],
        imageName: data["image_uploads"],
        createdAt: data["created_at"],
        updatedAt: data["updated_at"],
      );

  Map<String, String> toJson() => {
        "image_uploads": imageName,
        "name": name,
        "phone": phone,
        "updated_at": createdAt,
        "created_at": updatedAt,
      };
}
