class CartProduct {
  final int cartId;
  final int productId;
  final int variantId;
  final int simpleProductId;
  final int offInPercent;
  final String productName;
  final String originaPrice;
  final String originalOfferPrice;
  final String mainPrice;
  final String offerPrice;
  int quantity;
  final String thumbnailPath;
  final String thumbnail;
  final double taxInfo;
  final String currency;
  final String soldBy;

  CartProduct({
    required this.cartId,
    required this.productId,
    required this.variantId,
    required this.simpleProductId,
    required this.offInPercent,
    required this.productName,
    required this.originaPrice,
    required this.originalOfferPrice,
    required this.mainPrice,
    required this.offerPrice,
    required this.quantity,
    required this.thumbnailPath,
    required this.thumbnail,
    required this.taxInfo,
    required this.currency,
    required this.soldBy,
  });

  factory CartProduct.fromJson(Map<String, dynamic> data) => CartProduct(
        cartId: data["cartid"] ?? 0,
        productId: data["productid"],
        variantId: data["variantid"],
        simpleProductId: data["simpleproductid"],
        offInPercent: data["off_in_percent"],
        productName: data["productname"],
        originaPrice: data["orignalprice"].toString(),
        originalOfferPrice: data["orignalofferprice"].toString(),
        mainPrice: data["mainprice"].toString(),
        offerPrice: data["offerprice"].toString(),
        quantity: data["qty"],
        thumbnailPath: data["thumbnail_path"],
        thumbnail: data["thumbnail"],
        taxInfo: data["tax_info"],
        currency: data["currency"],
        soldBy: data["soldby"],
      );
  Map<String, dynamic> toJson() => {
        "cartid": cartId.toString(),
        "productid": productId.toString(),
        "variantid": variantId.toString(),
        "simpleproductid": simpleProductId.toString(),
        "off_in_percent": offInPercent.toString(),
        "productname": productName,
        "orignalprice": originaPrice.toString(),
        "orignalofferprice": originalOfferPrice.toString(),
        "mainprice": mainPrice.toString(),
        "offerprice": offerPrice.toString(),
        "qty": quantity.toString(),
        "thumbnail_path": thumbnailPath,
        "thumbnail": thumbnail,
        "tax_info": taxInfo.toString(),
        "currency": currency,
        "soldby": soldBy,
      };
}

class CartInfo {
  // final List<CartProduct> cartProducts;
  String subTotal;
  final int shipping;
  final int couponDiscount;
  double grandTotal;
  final String currency;
  final String symbol;
  final String? appliedCoupon;
  final dynamic offers;

  CartInfo({
    // required this.cartProducts,
    this.subTotal = "0.0",
    required this.shipping,
    required this.couponDiscount,
    this.grandTotal = 0.0,
    required this.currency,
    required this.symbol,
    this.appliedCoupon = "",
    this.offers = "",
  });

  factory CartInfo.fromJson(Map<String, dynamic> data) => CartInfo(
        // cartProducts: cartProd,
        subTotal: data["subtotal"].toString(),
        shipping: data["shipping"] ?? 0,
        couponDiscount: data["coupan_discount"] ?? 0,
        grandTotal: data["grand_total"] ?? 0.0,
        currency: data["currency"] ?? "INR",
        symbol: data["symbol"] ?? "",
        appliedCoupon: data["appliedCoupan"] ?? "",
        offers: data["offers"] ?? "",
      );
}
