class Order {
  final int id;
  final String orderId;
  final int qtyTotal;
  final String orderTotal;
  final String paymentMethod;
  final String invoices;
  final String createdAt;

  Order({
    required this.id,
    required this.orderId,
    required this.qtyTotal,
    required this.orderTotal,
    required this.paymentMethod,
    required this.invoices,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> data) => Order(
        id: data["id"],
        orderId: data["order_id"].toString(),
        qtyTotal: data["qty_total"],
        orderTotal: data["order_total"].toString(),
        paymentMethod: data["payment_method"].toString(),
        invoices: data["invoices"].toString(),
        createdAt: data["created_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "qty_total": qtyTotal,
        "order_total": orderTotal,
        "payment_method": paymentMethod,
        "invoices": invoices,
        "created_at": createdAt,
      };
}
