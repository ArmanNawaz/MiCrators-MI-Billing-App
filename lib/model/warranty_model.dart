class WarrantyModel {
  String warranty_name;
  int warranty_id;
  String warranty_type;
  int days_valid;

  WarrantyModel(
      {required this.warranty_name,
      required this.warranty_id,
      required this.warranty_type,
      required this.days_valid});
}
