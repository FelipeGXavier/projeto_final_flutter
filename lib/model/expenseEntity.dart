import 'package:projeto_final/model/expenseCategory.dart';

class FinancialMovement {
  int? _id;
  String _title = "";
  bool _type = false;
  FinancialMovementCategory _category;
  double _value = 0;

  FinancialMovement(this._title, this._type, this._value, this._category);

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'title': _title,
      'type': _type,
      'value': _value,
      'category': _category,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'title': _title,
      'type': _type,
      'value': _value,
      'category': _category,
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      'title': _title,
      'type': _type,
      'value': _value,
      'category': _category,
    };
  }

  static FinancialMovement fromMap(Map<String, dynamic> map) {
    var id = map['id'] ?? 0;
    var title = map['title'] ?? "";
    var category =
        FinancialMovementCategory.fromData(map['category_id'], map['category']);
    var value = double.parse(map['value'].toString());
    var type = map['type'] ?? false;
    var financialMovement = FinancialMovement(title, type, value, category);
    financialMovement._id = id;
    return financialMovement;
  }

  get id => _id;

  get title => _title;

  get value => _value;

  get category => _category;

  get type => _type;

  get categoryName => _category.category;
}
