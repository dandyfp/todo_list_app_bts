import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app_bts/src/models/checklist_model.dart';
import 'package:todo_list_app_bts/src/models/item_checklist_model.dart';

class ChecklistDatasource {
  final Dio _dio = Dio();

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  final String baseUrl = "http://94.74.86.174:8080/api/";

  Future<Either<String, String>> createChecklist(String name) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      var result = await _dio.post(
        "${baseUrl}checklist",
        data: {
          "name": name,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );
      return right(result.data["message"]);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> updateStatusItemChecklist({
    required int checklistId,
    required int itemCheckListId,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      var result = await _dio.put(
        "${baseUrl}checklist/$checklistId/item/$itemCheckListId",
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );
      return right(result.data["message"]);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> deleteItemChecklist({
    required int checklistId,
    required int itemCheckListId,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      var result = await _dio.delete(
        "${baseUrl}checklist/$checklistId/item/$itemCheckListId",
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );
      return right(result.data["message"]);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> createItemChecklist({
    required String name,
    required int checklistId,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      var result = await _dio.post(
        "${baseUrl}checklist/$checklistId/item",
        data: {
          "itemName": name,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );
      return right(result.data["message"]);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<List<ChecklistModel>> getAllCheckList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      var result = await _dio.get(
        "${baseUrl}checklist",
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );

      List<ChecklistModel> checklists = result.data["data"] == null
          ? []
          : List<ChecklistModel>.from(
              result.data["data"]!.map((x) => ChecklistModel.fromJson(x)));
      return checklists;
    } catch (e) {
      return [];
    }
  }

  Future<List<ItemChecklistModel>> getAllItemCheckList(int checkListId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      var result = await _dio.get(
        "${baseUrl}checklist/$checkListId/item",
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );

      List<ItemChecklistModel> checklists = result.data["data"] == null
          ? []
          : List<ItemChecklistModel>.from(
              result.data["data"]!.map((x) => ItemChecklistModel.fromJson(x)));
      return checklists;
    } catch (e) {
      return [];
    }
  }
}
