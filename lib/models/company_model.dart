class CompanyModel {
  String? name;
  String? logoPath;

  CompanyModel({this.name, this.logoPath});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        name: json["name"] ?? "unknown", logoPath: json["logo_path"] ?? "");
  }
}
