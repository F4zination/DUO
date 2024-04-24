import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrJoinDialog extends StatelessWidget {
  final String id;
  const QrJoinDialog({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: const Text(
                  'Scan this QR code with the DUO app to join the group:',
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                  textAlign: TextAlign.center),
            ),
            const SizedBox(height: 10),
            QrImageView(
              data: 'id:$id',
              version: QrVersions.auto,
              foregroundColor: Colors.white54,
              size: 200,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
