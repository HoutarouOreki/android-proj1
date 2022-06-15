import 'package:flutter/material.dart';

import 'grades_screen.dart';

class GradePicker extends StatefulWidget {
  const GradePicker({Key? key, required this.controller}) : super(key: key);

  final GradeEditingController controller;

  @override
  State<GradePicker> createState() => _GradePickerState();
}

class _GradePickerState extends State<GradePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Text(widget.controller.przedmiot)),
        Expanded(
            child: RadioListTile<int?>(
              title: const Text('2'),
              value: 2,
              groupValue: widget.controller.ocena,
              onChanged: (int? value) {
                setState(() {
                  widget.controller.ocena = value;
                });
              },
            )),
        Expanded(
          child: RadioListTile<int?>(
            title: const Text('3'),
            value: 3,
            groupValue: widget.controller.ocena,
            onChanged: (int? value) {
              setState(() {
                widget.controller.ocena = value;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<int?>(
            title: const Text('4'),
            value: 4,
            groupValue: widget.controller.ocena,
            onChanged: (int? value) {
              setState(() {
                widget.controller.ocena = value;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<int?>(
            title: const Text('5'),
            value: 5,
            groupValue: widget.controller.ocena,
            onChanged: (int? value) {
              setState(() {
                widget.controller.ocena = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
