import 'package:duo_client/utils/constants.dart';
import 'package:flutter/material.dart';

class FirstTimeDialog extends StatefulWidget {
  final Future<void> Function(String name) onNameSet;
  const FirstTimeDialog({
    required this.onNameSet,
    super.key,
  });

  @override
  State<FirstTimeDialog> createState() => _FirstTimeDialogState();
}

class _FirstTimeDialogState extends State<FirstTimeDialog> {
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Welcome to Duo!'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'This is your first time using Duo. Please complete your profile to get started.',
            ),
            const SizedBox(height: Constants.defaultPadding),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            setState(() {
              _isLoading = true;
            });
            await widget.onNameSet(_nameController.text);
            if (!context.mounted) return;
            Navigator.of(context).pop();
          },
          child: _isLoading
              ? const CircularProgressIndicator.adaptive()
              : const Text('OK'),
        ),
      ],
    );
  }
}
