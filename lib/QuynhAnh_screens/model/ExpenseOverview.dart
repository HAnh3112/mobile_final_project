class ExpenseOverview {
  String amount;
  String name;

  ExpenseOverview ({required this.amount, required this.name});

  factory ExpenseOverview.fromJson(Map<String, dynamic> json) {
    return ExpenseOverview(
      name: json['categoryName'],
      amount: json['totalSpent'].toString(),
    );
  }
}


