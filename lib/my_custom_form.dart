import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proj1/full_width_button.dart';
import 'package:proj1/grades_screen.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  num? _srednia;

  TextEditingController gradesAmountController = TextEditingController();

  Future<void> sprawdzFormularz() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Ok')),
        );
      final avg = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => GradesScreen(
            gradesAmount: int.parse(gradesAmountController.text),
          ),
        ),
      );

      setState(() {
        _srednia = avg;
      });
    }
  }

  String poinformujBlad(String t) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t)),
    );
    return t;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formularz, projekt 1"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: "Imię"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return poinformujBlad(
                        "Wypełnij imię.");
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Nazwisko"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return poinformujBlad(
                        "Wypełnij nazwisko.");
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: gradesAmountController,
                decoration: const InputDecoration(labelText: "Liczba ocen"),
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: false),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return poinformujBlad(
                        'Wpisz liczbę z przedziału [5;15].');
                  }
                  int? liczba = int.tryParse(value);
                  if (liczba == null) {
                    return poinformujBlad(
                        'Wpisz liczbę z przedziału [5;15]');
                  }
                  if (liczba < 5 || liczba > 15) {
                    return poinformujBlad(
                        'Wpisz liczbę z przedziału [5;15]');
                  }
                  return null;
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox.fromSize(size: const Size(0, 20)),
              if (_srednia != null)
                Text("Średnia: ${_srednia!.toStringAsFixed(2)}"),
              SizedBox.fromSize(size: const Size(0, 20)),
              FullWidthButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  sprawdzFormularz();
                },
                child: const Text("Oceny"),
              ),
              if (_srednia != null)
                FullWidthButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                      msg: _srednia! >= 3
                          ? "Gratulacje! Otrzymujesz zaliczenie!"
                          : "Wysyłam podanie o zaliczenie warunkowe",
                      toastLength: Toast.LENGTH_SHORT,
                      textColor: Colors.black,
                      fontSize: 16,
                      backgroundColor: Colors.grey[200],
                    );
                    SystemNavigator.pop(animated: true);
                  },
                  child: Text(
                      _srednia! >= 3 ? "Super!" : "Tym razem mi nie poszło"),
                ),
              SizedBox.fromSize(size: const Size(0, 50))
            ],
          ),
        ),
      ),
    );
  }
}
