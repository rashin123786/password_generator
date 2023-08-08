// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/controller/provider/password_db.dart';
import 'package:password_generator/model/password_model.dart';
import 'package:password_generator/utils/constants.dart';
import 'package:password_generator/utils/helper_services.dart';
import 'package:password_generator/view/password_list_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _lengthkey = GlobalKey<FormState>();

  bool checkbox = false;
  final passwordController = TextEditingController();
  final lengthController = TextEditingController(text: '8');
  List<bool> checkboxValues = List.generate(3, (index) => true);
  @override
  Widget build(BuildContext context) {
    final passwordProvider = Provider.of<PasswordController>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Password Generator'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: passwordController,
                    validator: (password) => password!.isEmpty ||
                            password.length < 8 ||
                            password.length > 25
                        ? 'Please enter password correctly'
                        : null,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () {
                          final data =
                              ClipboardData(text: passwordController.text);
                          Clipboard.setData(data);

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  duration: Duration(milliseconds: 350),
                                  content: Text('password copied')));
                        },
                      ),
                      hintText: "Enter password",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.purpleAccent,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.purple,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50,
                    height: 10,
                    child: Form(
                      key: _lengthkey,
                      child: TextFormField(
                        validator: (length) =>
                            length!.isEmpty ? 'Please enter length' : null,
                        keyboardType: TextInputType.number,
                        controller: lengthController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_lengthkey.currentState!.validate()) {
                        if ((checkboxValues[0] ||
                                checkboxValues[1] ||
                                checkboxValues[2]) ==
                            false) {
                          errorcatch(context, 1);
                        } else if (int.parse(lengthController.text) < 8 ||
                            int.parse(lengthController.text) > 25 ||
                            int.parse(lengthController.text) == 0) {
                          errorcatch(context, 2);
                        } else {
                          inputPassword = generatePassword(
                            int.parse(lengthController.text),
                            checkboxValues[0],
                            checkboxValues[1],
                            checkboxValues[2],
                          );
                          passwordController.text = inputPassword!;
                        }
                      } else {
                        errorcatch(context, 5);
                      }
                    },
                    child: const Text(
                      'Generate password',
                    ),
                  ),
                ],
              ),
              ...List.generate(checkboxValues.length, (index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: checkboxValues[index],
                        onChanged: (value) {
                          setState(() {
                            checkboxValues[index] = value!;
                          });
                        }),
                    Text(userSpecificPassword[index]),
                  ],
                );
              }),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    PasswordModel passwordModel =
                        PasswordModel(password: passwordController.text);
                    final passwords = passwordProvider.passwordList
                        .map((e) => e.password.trim())
                        .toList();
                    if (passwords.contains(passwordModel.password)) {
                      errorcatch(context, 3);
                    } else {
                      await passwordProvider.addPassword(passwordModel);
                      errorcatch(context, 4);
                    }
                  }
                },
                child: const Text(
                  'Store password',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CircleAvatar(
          child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PasswordListScreen(),
                    ));
              },
              icon: const Icon(Icons.arrow_forward))),
    );
  }
}
