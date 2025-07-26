class Category {
  final int categoryId;
  final String categoryName;
  final String colorCode;
  final int iconCode;
  final String? type;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.colorCode,
    required this.iconCode,
    this.type
  }); 
}