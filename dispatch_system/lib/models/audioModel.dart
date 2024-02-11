class audioresult {
  String? result;
  double? qty;
  num? price;
  num? totalAmt;

  audioresult({this.result, this.qty, this.price, this.totalAmt});

  audioresult.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    qty = json['qty'];
    price = json['price'];
    totalAmt = json['total_amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['total_amt'] = this.totalAmt;
    return data;
  }
}
