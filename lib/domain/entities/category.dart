import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  bool isSelected;

  Category({
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  Category setSelected(bool isSelected) {
    return Category(
      id: id,
      name: name,
      isSelected: isSelected,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        isSelected,
      ];
}
