import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../shared/components/component.dart';

class ArchiveScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var tasks = AppCubit.get(context).archiveTasks;

        return Scaffold(
          backgroundColor: Colors.teal.shade100,
          body: ConditionalBuilder(
            condition: tasks.isNotEmpty,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) =>
                    buildTaskItem(tasks[index], context),
                separatorBuilder: (context, index) => Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                itemCount: tasks.length),
            fallback: (context) => (tasks.isNotEmpty)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Center(
                        child: Icon(
                          Icons.archive_rounded,
                          size: 150,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Text(
                        'No tasks archived',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
