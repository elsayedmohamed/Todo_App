import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components/component.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class LayoutScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          AppCubit cubit = BlocProvider.of(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
                condition: true,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator())),
            bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.task),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.done),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archive',
                  ),
                ],
                currentIndex: cubit.currentIndex),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isOpendBottomSheet == true) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertIntoDataBase(
                        title: titleController.text,
                        date: dateController.text,
                        time: timeController.text);

                    titleController.text = '';
                    timeController.text = '';
                    dateController.text = '';

                    Navigator.pop(context);
                    cubit.isOpendBottomSheet = false;

                    // setState(() {
                    //   iconFab = Icons.edit;
                    // });
                  }
                } else {
                  // setState(() {
                  //   iconFab = Icons.add;
                  // });

                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        elevation: 30,
                        (context) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultTextFormField(
                                      border: const OutlineInputBorder(),
                                      inputType: TextInputType.text,
                                      controller: titleController,
                                      validator: (String value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Task Title ';
                                        } else {
                                          return null;
                                        }
                                      },
                                      obsecureText: false,
                                      label: 'Write Task Title',
                                      prefixIcon: Icons.task),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  defaultTextFormField(
                                      border: const OutlineInputBorder(),
                                      inputType: TextInputType.text,
                                      controller: timeController,
                                      validator: (String value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Select Task Time ';
                                        } else {
                                          return null;
                                        }
                                      },
                                      obsecureText: false,
                                      label: 'Select Task Time',
                                      prefixIcon: Icons.watch,
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          timeController.text =
                                              value!.format(context);
                                        });
                                      }),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  defaultTextFormField(
                                    border: const OutlineInputBorder(),
                                    inputType: TextInputType.text,
                                    controller: dateController,
                                    validator: (String value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Select Task Date ';
                                      } else {
                                        return null;
                                      }
                                    },
                                    obsecureText: false,
                                    label: 'Select Task Date',
                                    prefixIcon: Icons.date_range,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 30)),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMMd().format(value!);
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });
                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(cubit.iconFab),
            ),
          );
        },
      ),
    );
  }
}
