
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:picovoice_flutter/picovoice_manager.dart';
import 'package:picovoice_flutter/picovoice_error.dart';
import 'package:picovoice_speech_recognition/view/screens/home_screen/config.dart';
import 'package:rhino_flutter/rhino.dart';

class VoiceAssistantHome extends StatefulWidget {
  const VoiceAssistantHome({super.key});

  @override
  State<VoiceAssistantHome> createState() => _VoiceAssistantHomeState();
}

class _VoiceAssistantHomeState extends State<VoiceAssistantHome> {
  late PicovoiceManager _picovoiceManager;
  String _statusMessage =
      "Say the wake word to start! Wake keyword is 'Hey Qicpic'";
  bool _showImage = false;

  @override
  void initState() {
    super.initState();
    _initPicovoice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Voice Assistant App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                _statusMessage,
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 25),
            if (_showImage)
              Image.asset(
                'assets/QICPIC logo_Vertical-01.jpg',
                height: 200,
              ),
          ],
        ),
      ),
    );
  }

  void _initPicovoice() async {
    try {
      _picovoiceManager = await PicovoiceManager.create(
        accessKey,
        "assets/Hey-Quick-pick_en_android_v3_0_0.ppn", // Path to your wake word file
        _wakeWordCallback,
        "assets/QIcpic_en_android_v3_0_0.rhn", // Path to your context file
        _inferenceCallback,
      );
      await _picovoiceManager.start();
    } on PicovoiceException catch (ex) {
      setState(() {
        _statusMessage = "Error initializing Picovoice: $ex";
      });
      log(ex.toString());
    }
  }

  void _wakeWordCallback() {
    setState(() {
      _statusMessage = "Wake word detected!";
      _showImage = true;
    });
    log("Wake word detected!");
  }

  void _inferenceCallback(RhinoInference inference) {
    setState(() {
      if (inference.isUnderstood!) {
        // Check if the intent is "address"
        if (inference.intent == "Address") {
          _statusMessage =
              "QICPIC INNOVATIONS Pvt Ltd, G1, Dev plaza, Kadri Temple Rd, Mallikatte, Kadri, Mangaluru, Karnataka 575002";
        } else {
          _statusMessage =
              "Intent: ${inference.intent}\nSlots: ${inference.slots}";
        }
      } else {
        _statusMessage = "Didn't understand the command.";
        _showImage = false;
      }
    });
    log("Intent: ${inference.intent}");
    log("Slots: ${inference.slots}");
  }

  @override
  void dispose() {
    _picovoiceManager.stop();
    _picovoiceManager.delete();
    super.dispose();
  }
}
