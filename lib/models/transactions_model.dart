class TransactionsModel {
  bool? status;
  String? message;
  Data? data;

  TransactionsModel({this.status, this.message, this.data});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Transactions>? transactions;
  int? total;

  Data({this.transactions, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Transactions {
  int? id;
  String? customerId;
  String? customerUniqueid;
  String? title;
  String? amount;
  String? type;
  String? createdAt;
  String? updatedAt;

  Transactions(
      {this.id,
        this.customerId,
        this.customerUniqueid,
        this.title,
        this.amount,
        this.type,
        this.createdAt,
        this.updatedAt});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    customerUniqueid = json['customer_uniqueid'];
    title = json['title'];
    amount = json['amount'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['customer_uniqueid'] = this.customerUniqueid;
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
