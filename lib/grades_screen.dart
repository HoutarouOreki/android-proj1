import 'package:flutter/material.dart';
import 'package:proj1/full_width_button.dart';
import 'package:proj1/grade_picker.dart';

class GradeEditingController extends TextEditingController {
  final String przedmiot;
  int? ocena = 2;

  GradeEditingController(this.przedmiot);
}

class GradesScreen extends StatefulWidget {
  final int gradesAmount;

  const GradesScreen({Key? key, required this.gradesAmount})
      : super(key: key);

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  final arr = [
    GradeEditingController("polski"),
    GradeEditingController("matematyka"),
    GradeEditingController("angielski"),
    GradeEditingController("historia"),
    GradeEditingController("android"),
    GradeEditingController("ios"),
    GradeEditingController("dyskretna"),
    GradeEditingController("niemiecki"),
    GradeEditingController("chmurki"),
    GradeEditingController("swift"),
    GradeEditingController("narzędzia informatyczne"),
    GradeEditingController("fizyka"),
    GradeEditingController("python"),
    GradeEditingController("integracja systemów"),
    GradeEditingController("szkielety programistyczne"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Oceny')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              for (var i
              in List<int>.generate(widget.gradesAmount, (index) => index))
                GradePicker(controller: arr[i]),
              FullWidthButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  obliczSrednia();
                },
                child: const Text("Oblicz średnią"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void obliczSrednia() {
    int suma = 0;
    for (int i = 0; i < widget.gradesAmount; i++) {
      suma += arr[i].ocena!;
    }
    num avg = suma / widget.gradesAmount;
    Navigator.of(context).pop(avg);
  }
}
