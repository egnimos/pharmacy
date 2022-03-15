class PaymentInfo {
  final String subTotal;
  final String amount;
  final String paymentMethod;
  final String taxId;
  final num handlingCharge;
  final num selectedId;
  final num sameAs;

  PaymentInfo({
    required this.subTotal,
    required this.amount,
    required this.paymentMethod,
    this.taxId = 'sgfjag7389174asafgsg',
    this.handlingCharge = 0,
    required this.selectedId,
    this.sameAs = 1,
  });

  Map<String, dynamic> toJson() => {
        'subtotal': subTotal.toString(),
        'amount': amount.toString(),
        'payment_method': paymentMethod,
        'txn_id': taxId,
        'handlingcharge': handlingCharge.toString(),
        'address_id': selectedId.toString(),
        'same_as': sameAs.toString()
      };
}