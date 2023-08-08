// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:password_generator/utils/constants.dart';
import 'package:provider/provider.dart';

import '../controller/provider/password_db.dart';

class PasswordListScreen extends StatelessWidget {
  const PasswordListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordProvider = Provider.of<PasswordController>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      passwordProvider.getAllPassword();
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Password List'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<PasswordController>(
                builder: (context, value, child) => value.passwordList.isEmpty
                    ? const Center(
                        child: Text('No password available'),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.passwordList.length,
                        itemBuilder: (context, index) {
                          final data = value.passwordList[index];
                          return ListTile(
                            title: Text(data.password),
                            trailing: IconButton(
                                onPressed: () async {
                                  await value.deletePassword(index);
                                  scaffoldAlert(
                                      context, 'Deleted Successfully');
                                },
                                icon: const Icon(Icons.delete)),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
