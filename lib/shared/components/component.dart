import 'package:flutter/material.dart';

import '../cubit/cubit.dart';

Widget defaultTextFormField({
  required TextInputType inputType,
  required TextEditingController controller,
  required Function validator,
  required bool obsecureText,
  required String label,
  InputBorder? border,
  String? hintText,
  IconData? prefixIcon,
  IconData? sufixIcon,
  Function()? suffixPressed,
  Function()? onTap,
}) =>
    TextFormField(
      onTap: onTap,
      keyboardType: inputType,
      controller: controller,
      validator: (value) {
        return validator(value);
      },
      obscureText: obsecureText,
      decoration: InputDecoration(
        label: Text(label),
        border: border,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(icon: Icon(sufixIcon), onPressed: suffixPressed),
      ),
    );

//==================================
Widget defaultMaterialButton({
  required Widget text,
  required Function() onPressed,
  Color backgroundcolor = Colors.blue,
  Color textColor = Colors.white,
}) =>
    MaterialButton(
      color: backgroundcolor,
      textColor: textColor,
      onPressed: onPressed,
      child: text,
    );
//======================================

Widget buildTaskItem(model, context) => Card(
      color: Colors.teal.shade50,
      shape: const RoundedRectangleBorder(),
      child: Dismissible(
        key: Key(model['id'].toString()),
        onDismissed: (direction) {
          AppCubit.get(context).deleteData(id: model['id']);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.teal,
                radius: 40.0,
                child: Text(
                  '${model['time']}',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${model['title']}',
                        style: Theme.of(context).textTheme.headline5),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${model['date']}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        AppCubit.get(context)
                            .updateData(id: model['id'], status: 'done');
                      },
                      icon: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      label: const Text(
                        'Done',
                        style: TextStyle(fontSize: 14.0),
                      )),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton.icon(
                      onPressed: () {
                        AppCubit.get(context)
                            .updateData(id: model['id'], status: 'Archive');
                      },
                      icon: const Icon(
                        Icons.archive_rounded,
                      ),
                      label: const Text(
                        'Archive',
                        style: TextStyle(fontSize: 14.0),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
