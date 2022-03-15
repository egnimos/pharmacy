class Search {
  final int id;
  final String productName;
  final String type;
  final String img;

  Search({
    required this.id,
    required this.productName,
    required this.type,
    required this.img,
  });

  factory Search.fromJson(Map<String, dynamic> data) => Search(
        id: data["id"],
        productName: data["value"],
        type: data["type"],
        img: data["img"],
      );
  // {
  //       "id": 13,
  //       "value": "Calpol 500mg Tablet in Medicines by Therapeutic Class",
  //       "type": "simple_products",
  //       "img": "https://dawadoctor.co.in/public/images/simple_products/Calpol_500_gsk-1.jpg",
  //       "url": "https://dawadoctor.co.in/public/shop?category=1&sid=1&start=16&end=108&keyword=calpol"
  //   }
}
