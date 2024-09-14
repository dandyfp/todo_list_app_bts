import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app_bts/src/data/checklist_datasource.dart';
import 'package:todo_list_app_bts/src/models/checklist_model.dart';
import 'package:todo_list_app_bts/src/presentation/misc/constant.dart';
import 'package:todo_list_app_bts/src/presentation/misc/methods.dart';
import 'package:todo_list_app_bts/src/presentation/misc/style.dart';
import 'package:todo_list_app_bts/src/presentation/widgets/button.dart';
import 'package:todo_list_app_bts/src/presentation/widgets/fab.dart';
import 'package:todo_list_app_bts/src/presentation/widgets/textfield.dart';

class DetailCheckList extends StatefulWidget {
  final ChecklistModel data;
  const DetailCheckList({super.key, required this.data});

  @override
  State<DetailCheckList> createState() => _DetailCheckListState();
}

ChecklistDatasource _checklistDatasource = ChecklistDatasource();

TextEditingController nameController = TextEditingController();

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _DetailCheckListState extends State<DetailCheckList> {
  @override
  void initState() {
    _checklistDatasource.getAllItemCheckList(widget.data.id ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FAB(
        onTap: () {
          bottomSheetAddTask(
            context: context,
            id: widget.data.id ?? 0,
          );
        },
      ),
      backgroundColor: ghostWhite,
      appBar: AppBar(
        backgroundColor: saffron,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          widget.data.name ?? '',
          style: whiteSemiBoldTextStyle.copyWith(fontSize: 16),
        ),
      ),
      body: ListView(
        children: [
          verticalSpace(50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                FutureBuilder(
                  future: _checklistDatasource
                      .getAllItemCheckList(widget.data.id ?? 0),
                  builder: (context, snapshot) {
                    return snapshot.data == null
                        ? Center(
                            child: Column(
                              children: [
                                verticalSpace(100),
                                Text(
                                  'Data Not Found',
                                  style: blackRegularTextStyle.copyWith(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              var item = snapshot.data![index];
                              return InkWell(
                                onTap: () {},
                                child: Card(
                                  color: whiteColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 15),
                                    child: Row(
                                      children: [
                                        Checkbox.adaptive(
                                          value: item.itemCompletionStatus,
                                          onChanged: (value) async {
                                            setState(() {});
                                            var result =
                                                await _checklistDatasource
                                                    .updateStatusItemChecklist(
                                              checklistId: widget.data.id ?? 0,
                                              itemCheckListId: item.id ?? 0,
                                            );
                                            result.fold(
                                              (l) {},
                                              (r) {
                                                _checklistDatasource
                                                    .getAllItemCheckList(
                                                        widget.data.id ?? 0);
                                              },
                                            );
                                            setState(() {});
                                          },
                                        ),
                                        horizontalSpace(10),
                                        Expanded(
                                          child: Text(
                                            item.name ?? '',
                                            style:
                                                blackMediumTextStyle.copyWith(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                              ),
                                            ),
                                            horizontalSpace(5),
                                            InkWell(
                                              onTap: () async {
                                                var result =
                                                    await _checklistDatasource
                                                        .deleteItemChecklist(
                                                            checklistId: widget
                                                                    .data.id ??
                                                                0,
                                                            itemCheckListId:
                                                                item.id ?? 0);

                                                result.fold(
                                                  (l) {
                                                    setState(() {
                                                      setState(() {
                                                        AnimatedSnackBar.material(
                                                                'Success delete',
                                                                type:
                                                                    AnimatedSnackBarType
                                                                        .warning)
                                                            .show(context);
                                                      });
                                                    });
                                                  },
                                                  (r) {
                                                    setState(() {
                                                      setState(() {
                                                        AnimatedSnackBar.material(
                                                                r,
                                                                type:
                                                                    AnimatedSnackBarType
                                                                        .warning)
                                                            .show(context);
                                                      });
                                                    });
                                                  },
                                                );
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> bottomSheetAddTask({
    required BuildContext context,
    required int id,
  }) {
    return showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: whiteColor,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                verticalSpace(20),
                Center(
                  child: Container(
                    height: 3,
                    width: 77,
                    color: primaryColor,
                  ),
                ),
                verticalSpace(20),
                KTextField(
                  maxLines: 1,
                  minLines: 1,
                  isActiveFocusBorder: true,
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  borderColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  label: 'Name',
                  placeholder: 'Input Name',
                ),
                verticalSpace(40),
                Button(
                  onPressed: () async {
                    if (nameController.text.isNotEmpty) {
                      var result =
                          await _checklistDatasource.createItemChecklist(
                        name: nameController.text,
                        checklistId: id,
                      );
                      result.fold(
                        (l) {},
                        (r) async {
                          Navigator.pop(context);
                          // await _taskDatasource.getTasks(uid ?? '');
                          setState(() {
                            nameController.clear();
                          });
                        },
                      );
                    } else {
                      setState(() {
                        AnimatedSnackBar.material('Name column cannot be empty',
                                type: AnimatedSnackBarType.warning)
                            .show(context);
                      });
                    }
                  },
                  child: Center(
                    child: Text(
                      'Add Task',
                      style: whiteMediumTextStyle.copyWith(fontSize: 12),
                    ),
                  ),
                ),
                verticalSpace(40),
              ],
            ),
          ),
        );
      },
    );
  }
}
