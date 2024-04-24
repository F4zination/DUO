import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class QrCodeScanner extends StatefulWidget {
  static const route = '/qr-code-scanner';
  final void Function(int id) onDetectedValid;
  const QrCodeScanner({required this.onDetectedValid, super.key});

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner>
    with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController(
      detectionTimeoutMs: 500, detectionSpeed: DetectionSpeed.noDuplicates);
  Color borderColor = Colors.white;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          //barcode overlay
          _isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : SizedBox(
                  child: QRScannerOverlay(
                    scanAreaSize:
                        Size.square(MediaQuery.of(context).size.width * 0.7),
                    borderColor: borderColor,
                  ),
                ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.close,
                  color: Colors.white), //TODO change to close icon
            ),
          ),
        ],
      ),
    );
  }

  Future<void> setInvalidColor() async {
    setState(() {
      borderColor = Colors.red.withOpacity(0.4);
    });
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      borderColor = Colors.white;
    });
  }

  Future<void> setValidColor() async {
    setState(() {
      borderColor = Colors.green.withOpacity(0.4);
    });
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      borderColor = Colors.white;
      _isLoading = true;
    });
  }

  Widget buildQrView(BuildContext context) {
    return MobileScanner(
      scanWindow: Rect.fromCenter(
          center: Offset(MediaQuery.of(context).size.width / 2,
              MediaQuery.of(context).size.height / 2),
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.width * 0.75),
      placeholderBuilder: (BuildContext context, Widget? widget) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      controller: _controller,
      onDetect: (data) => _foundQrCode(data.barcodes.first),
    );
  }

  (bool isValid, int id) _validateQrData(String data) {
    //has the form of id:$id;pin:$pin
    final int id = int.tryParse(data.split(':')[1]) ?? -1;

    if (id < 0) {
      return (false, -1);
    }
    return (true, id);
  }

  void _foundQrCode(Barcode barcode) async {
    debugPrint(barcode.rawValue ?? "");
    final data = barcode.rawValue ?? "";
    final (isQrValid, id) = _validateQrData(data);
    if (isQrValid) {
      await setValidColor();
      if (!mounted) return;
      widget.onDetectedValid(id);
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    } else {
      if (borderColor == Colors.white) await setInvalidColor();
    }
  }
}
