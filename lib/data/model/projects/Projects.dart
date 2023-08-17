import 'Images.dart';

class Project {
  int id;
  int? companyId;
  String title;
  String address;
  String description;
  int type;
  int floors;
  int area;
  int minInvest;
  String latitude;
  String longitude;
  String expectedProfit;
  String uuid;
  String finishAt;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  List<Image> images;
  List<dynamic> attachments;
  num progress_bar;

  Project(
      {required this.id,
      this.companyId,
      required this.title,
      required this.address,
      required this.description,
      required this.type,
      required this.floors,
      required this.area,
      required this.minInvest,
      required this.latitude,
      required this.longitude,
      required this.expectedProfit,
      required this.uuid,
      required this.finishAt,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.images,
      required this.attachments,
      required this.progress_bar});

  factory Project.fromJson(Map<String, dynamic> json) {
    List<Image> images = [];
    if (json['images'] != null && json['images'] is List<dynamic>) {
      images = (json['images'] as List<dynamic>)
          .map((image) => Image.fromJson(image))
          .toList();
    }

    return Project(
      id: json["id"],
      companyId: json["company_id"],
      title: json["title"],
      address: json["address"],
      description: json["description"],
      type: json["type"],
      floors: json["floors"],
      area: json["area"],
      minInvest: json["min_invest"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      expectedProfit: json["expected_profit"],
      uuid: json["uuid"],
      finishAt: json["finish_at"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      deletedAt: json["deleted_at"],
      images: images,
      attachments: json["attachments"] ?? [],
      progress_bar: json["progress_bar"],
    );
  }
}
