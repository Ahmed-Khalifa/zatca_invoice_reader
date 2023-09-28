import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
import 'package:string_validator/string_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tlv_decoder/tlv_decoder.dart';
import 'package:zatca_invoice_reader/results_page.dart';

class ScannerPage extends StatefulWidget {
  static const id = 'scanner_page';
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final double iconsSize = 32.0;
  MobileScannerController cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal, detectionTimeoutMs: 1000);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          child: MobileScanner(
            fit: BoxFit.fill,
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;
              List<TLV> tlvList = [];
              for (final barcode in barcodes) {
                String base64String = barcode.rawValue!;
                debugPrint('Base64 String: ${base64Decode(base64String)}');
                Uint8List bytes = base64Decode(base64String);
                debugPrint(bytes.toString());
                tlvList = TlvUtils.decode(bytes);
                debugPrint(tlvList.length.toString());
              }
              cameraController.dispose();
              Navigator.popAndPushNamed(context, ResultsPage.id, arguments: {
                'tlv_list': tlvList,
              });
            },
          ),
        ),
        Positioned(
          bottom: 150.0,
          left: 150.0,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: Row(
                children: [
                  IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.close),
                    iconSize: iconsSize,
                    onPressed: () {
                      cameraController.dispose();
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: ValueListenableBuilder(
                      valueListenable: cameraController.torchState,
                      builder: (context, state, child) {
                        switch (state as TorchState) {
                          case TorchState.off:
                            return const Icon(Icons.flash_off,
                                color: Colors.grey);
                          case TorchState.on:
                            return const Icon(Icons.flash_on,
                                color: Colors.yellow);
                        }
                      },
                    ),
                    iconSize: iconsSize,
                    onPressed: () => cameraController.toggleTorch(),
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: ValueListenableBuilder(
                      valueListenable: cameraController.cameraFacingState,
                      builder: (context, state, child) {
                        switch (state as CameraFacing) {
                          case CameraFacing.front:
                            return const Icon(Icons.camera_front);
                          case CameraFacing.back:
                            return const Icon(Icons.camera_rear);
                        }
                      },
                    ),
                    iconSize: iconsSize,
                    onPressed: () => cameraController.switchCamera(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
