class Category {
  final int id;
  final String title;
  final String iconImageName;

  Category({
    required this.id,
    required this.iconImageName,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> data) => Category(
        id: data["id"],
        iconImageName: data["image"],
        title: data["title"]["en"],
      );
}

        // {
        //     "id": 12,
        //     "title": {
        //         "en": "OTC"
        //     },
        //     "icon": null,
        //     "icon_image": "Component 59 – 7.png",
        //     "image": "Component 59 – 7.png",
        //     "description": {
        //         "en": "<p>OTC</p>"
        //     },
        //     "position": 12,
        //     "status": "1",
        //     "featured": "0",
        //     "created_at": "2022-01-24T17:26:53.000000Z",
        //     "updated_at": "2022-03-09T09:50:10.000000Z"
        // }
