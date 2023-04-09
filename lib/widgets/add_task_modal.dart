import 'package:flutter/material.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({
    Key? key,
    required this.addTask,
  }) : super(key: key);

  final Function addTask;

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final controller = TextEditingController();
  bool showAddButton = false;

  @override
  void initState() {
    super.initState();

    controller.addListener(
      () {
        setState(
          () {
            showAddButton = controller.text.trim().isNotEmpty;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter the name of your task, then press "Add Task"',
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: "Task",
              focusColor: getPrimaryColor(context),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 15),
          controller.text.trim().isNotEmpty
              ? WideCard(
                  content: "Add Task",
                  textAlign: TextAlign.center,
                  onTap: () {
                    widget.addTask(controller.text.trim());
                    controller.text = "";
                    Navigator.pop(context);
                  },
                )
              : const SizedBox(),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
