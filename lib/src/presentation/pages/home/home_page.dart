import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app_bts/src/data/checklist_datasource.dart';
import 'package:todo_list_app_bts/src/presentation/misc/constant.dart';
import 'package:todo_list_app_bts/src/presentation/misc/methods.dart';
import 'package:todo_list_app_bts/src/presentation/misc/navigator_helper.dart';
import 'package:todo_list_app_bts/src/presentation/misc/style.dart';
import 'package:todo_list_app_bts/src/presentation/pages/auth/login_page.dart';
import 'package:todo_list_app_bts/src/presentation/pages/home/detail_checklist.dart';
import 'package:todo_list_app_bts/src/presentation/widgets/button.dart';
import 'package:todo_list_app_bts/src/presentation/widgets/fab.dart';
import 'package:todo_list_app_bts/src/presentation/widgets/textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController nameController = TextEditingController();

GlobalKey<FormState> formKey = GlobalKey<FormState>();

ChecklistDatasource _checklistDatasource = ChecklistDatasource();

String? uid;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ghostWhite,
      floatingActionButton: FAB(
        onTap: () {
          bottomSheetAddTask(context);
        },
      ),
      body: ListView(
        children: [
          verticalSpace(20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: saffron.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: saffron.withOpacity(0.8),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'TO-DO List',
                  style: whiteSemiBoldTextStyle.copyWith(fontSize: 20),
                ),
                Text(
                  getGreeting(),
                  style: whiteMediumTextStyle.copyWith(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 2,
                      color: ghostWhite,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    setState(() {
                      NavigatorHelper.pushAndRemoveUntil(
                        context,
                        const LoginPage(),
                        (route) => false,
                      );
                    });
                  },
                  child: Text(
                    'Logout',
                    style: whiteMediumTextStyle.copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                FutureBuilder(
                  future: _checklistDatasource.getAllCheckList(),
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
                                onTap: () {
                                  NavigatorHelper.push(
                                    context,
                                    DetailCheckList(data: item),
                                  );
                                },
                                child: Card(
                                  color: whiteColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item.name ?? '',
                                          style: blackMediumTextStyle.copyWith(
                                            fontSize: 16,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            var result =
                                                await _checklistDatasource
                                                    .deleteChecklist(
                                                        checklistId:
                                                            item.id ?? 0);

                                            result.fold(
                                              (l) {
                                                setState(() {
                                                  setState(() {
                                                    AnimatedSnackBar.material(l,
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
                                                    AnimatedSnackBar.material(r,
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

  Future<dynamic> bottomSheetAddTask(BuildContext context) {
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
                      var result = await _checklistDatasource
                          .createChecklist(nameController.text);
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

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 11) {
      return "Good Morning";
    } else if (hour >= 11 && hour < 15) {
      return "Good Afternoon";
    } else if (hour >= 15 && hour < 18) {
      return "Good Afternoon";
    } else if (hour >= 18 && hour < 24) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }
}
