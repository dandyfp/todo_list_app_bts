import 'dart:convert';

import 'package:todo_list_app_bts/src/models/item_checklist_model.dart';

ChecklistModel checklistModelFromJson(String str) =>
    ChecklistModel.fromJson(json.decode(str));

String checklistModelToJson(ChecklistModel data) => json.encode(data.toJson());

class ChecklistModel {
  final int? id;
  final String? name;
  final List<ItemChecklistModel>? items;
  final bool? checklistCompletionStatus;

  ChecklistModel({
    this.id,
    this.name,
    this.items,
    this.checklistCompletionStatus,
  });

  factory ChecklistModel.fromJson(Map<String, dynamic> json) => ChecklistModel(
        id: json["id"],
        name: json["name"],
        items: json["items"] == null
            ? []
            : List<ItemChecklistModel>.from(
                json["items"]!.map((x) => ItemChecklistModel.fromJson(x))),
        checklistCompletionStatus: json["checklistCompletionStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "checklistCompletionStatus": checklistCompletionStatus,
      };
}
