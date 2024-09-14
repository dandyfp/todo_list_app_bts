import 'dart:convert';

ItemChecklistModel itemChecklistModelFromJson(String str) =>
    ItemChecklistModel.fromJson(json.decode(str));

String itemChecklistModelToJson(ItemChecklistModel data) =>
    json.encode(data.toJson());

class ItemChecklistModel {
  final int? id;
  final String? name;
  final bool? itemCompletionStatus;

  ItemChecklistModel({
    this.id,
    this.name,
    this.itemCompletionStatus,
  });

  factory ItemChecklistModel.fromJson(Map<String, dynamic> json) =>
      ItemChecklistModel(
        id: json["id"],
        name: json["name"],
        itemCompletionStatus: json["itemCompletionStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "itemCompletionStatus": itemCompletionStatus,
      };
}
