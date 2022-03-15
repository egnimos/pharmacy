class Offer {
  final String image;
  final String linkedTo;
  final String linkedId;

  Offer({
    required this.image,
    required this.linkedId,
    required this.linkedTo,
  });

  factory Offer.fromJson(Map<String, dynamic> data) => Offer(
        image: data["image"],
        linkedTo: data["linkedTo"],
        linkedId: data["linked_id"],
      );
}
