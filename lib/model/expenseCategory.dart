class FinancialMovementCategory {
  int? _id;
  String _category = "";

  FinancialMovementCategory(this._id);

  FinancialMovementCategory.fromData(int id, String category) {
    _id = id;
    _category = category;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'category': _category,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'category': _category,
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      'category': _category,
    };
  }

  static FinancialMovementCategory fromMap(Map<String, dynamic> map) {
    var id = map['id'] ?? 0;
    var category = map['category'] ?? "";
    var financialCategory = FinancialMovementCategory(category);
    financialCategory._id = id;
    return financialCategory;
  }

  get id => _id;

  get category => _category;
}
