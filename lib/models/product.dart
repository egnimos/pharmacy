class Product {
  final int productId;
  final int variantId;
  final int categoryId;
  final String brandName;
  final String storeName;
  final String productName;
  final String description;
  final String overview;
  final String usageDosage;
  final String interactions;
  final String sideEffects;
  final String expertAdvice;
  final String notToUse;
  final String warning;
  final String otherDetails;
  final String? keyFeatures;
  final String mainPrice;
  final String offerPrice;
  final int? reviewCount;
  final String? tags;
  final String priceIn;
  final String symbol;
  final String taxInfo;
  final String offPercent;
  final String rating;
  final String thumbnail;
  final String typeOfSell;
  final String thumbnailPath;
  final bool isInWishList;
  final String saltComposition;

  Product({
    required this.categoryId,
    required this.brandName,
    required this.storeName,
    required this.overview,
    required this.usageDosage,
    required this.interactions,
    required this.sideEffects,
    required this.expertAdvice,
    required this.notToUse,
    required this.warning,
    required this.otherDetails,
    required this.productId,
    required this.variantId,
    required this.productName,
    required this.description,
    this.keyFeatures = "",
    required this.mainPrice,
    required this.offerPrice,
    required this.taxInfo,
    this.reviewCount = 0,
    this.tags = "",
    required this.priceIn,
    required this.symbol,
    required this.isInWishList,
    required this.offPercent,
    required this.rating,
    required this.thumbnail,
    required this.thumbnailPath,
    required this.typeOfSell,
    required this.saltComposition,
  });

  factory Product.fromJson(Map<String, dynamic> data,
          {bool isDisabled = false}) =>
      Product(
          productId: data["productid"] ?? 0,
          productName: data["productname"] == null
              ? ""
              : data["productname"]["en"] ?? "",
          description: isDisabled
              ? ""
              : data["description"] == null
                  ? ""
                  : data["description"]["en"] ?? "",
          mainPrice: data["mainprice"].toString(),
          offerPrice: data["offerprice"].toString(),
          taxInfo: data["tax_info"] ?? "",
          variantId: data["variantid"] ?? 0,
          symbol: data["symbol"] ?? "",
          isInWishList: data["is_in_wishlist"] ?? false,
          offPercent: data["off_percent"].toString(),
          rating: data["rating"].toString(),
          keyFeatures: data["key_features"] == null
              ? ""
              : data["key_features"]["en"] ?? "",
          thumbnail: data["thumbnail"] ?? "",
          thumbnailPath: data["thumbnail_path"] ?? "",
          typeOfSell: data["type_of_sell"] ?? "",
          priceIn: data["pricein"] ?? "",
          brandName: data["brand_name"] ?? "",
          categoryId: data["category_id"] ?? 0,
          expertAdvice: data["expert_advice"] ?? "",
          interactions: data["interactions"] ?? "",
          notToUse: data["not_to_use"] ?? "",
          otherDetails: data["other_details"] ?? "",
          overview: data["overview"] ?? "",
          sideEffects: data["side_effects"] ?? "",
          storeName: data["store_name"] ?? "",
          usageDosage: data["usage_dosage"] ?? "",
          warning: data["warning"] ?? "",
          saltComposition: data["composition"] ?? "");
  Map<String, dynamic> toJson() => {
        "productid": productId,
        "variantid": variantId,
        "productname": productName,
        "description": description,
        "tax_info": taxInfo,
        "mainprice": mainPrice,
        "offerprice": offerPrice,
        "pricein": priceIn,
        "symbol": symbol,
        "off_percent": offPercent,
        "rating": rating,
        "thumbnail": thumbnail,
        "type_of_sell": typeOfSell,
        "thumbnail_path": thumbnailPath,
        "is_in_wishlist": isInWishList,
      };
}
