import 'package:flutter/material.dart';
import 'package:picovoice_speech_recognition/view/screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VoiceAssistantHome(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:picovoice_flutter/picovoice_manager.dart';
// import 'package:picovoice_flutter/picovoice_error.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:rhino_flutter/rhino.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: VoiceAssistantHome(),
//     );
//   }
// }

// class VoiceAssistantHome extends StatefulWidget {
//   const VoiceAssistantHome({super.key});

//   @override
//   State<VoiceAssistantHome> createState() => _VoiceAssistantHomeState();
// }

// class _VoiceAssistantHomeState extends State<VoiceAssistantHome> {
//   late PicovoiceManager _picovoiceManager;
//   final String accessKey =
//       "tzDcqNOe7ocfuOOvdBCparc4fLhyBdXpKF0IsDvycA5jkKDdlKsGuQ=="; // Replace with your actual access key
//   String _statusMessage = "Say the custom wake word to start!";
//   late stt.SpeechToText _speechToText;
//   late FlutterTts _flutterTts;
//   bool _isListening = false;

//   @override
//   void initState() {
//     super.initState();
//     _initPicovoice();
//     _initSpeechToText();
//     _initTextToSpeech();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Voice Assistant App"),
//       ),
//       body: Center(
//         child: Text(
//           _statusMessage,
//           style: const TextStyle(fontSize: 18),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }

//   void _initPicovoice() async {
//     try {
//       _picovoiceManager = await PicovoiceManager.create(
//         accessKey,
//         "assets/Hey-Flutter_en_android_v3_0_0.ppn", // Path to your custom wake word file
//         _wakeWordCallback,
//         "assets/Testing_en_android_v3_0_0.rhn", // Path to your context file
//         _inferenceCallback,
//       );
//       await _picovoiceManager.start();
//     } on PicovoiceException catch (ex) {
//       setState(() {
//         _statusMessage = "Error initializing Picovoice: $ex";
//       });
//       print(ex);
//     }
//   }

//   void _initSpeechToText() {
//     _speechToText = stt.SpeechToText();
//   }

//   void _initTextToSpeech() {
//     _flutterTts = FlutterTts();
//   }

//   void _wakeWordCallback() {
//     setState(() {
//       _statusMessage = "Wake word detected!";
//     });
//     _flutterTts.speak("Hi, how are you?");
//     _listenToResponse();
//   }

//   void _listenToResponse() async {
//     bool available = await _speechToText.initialize(
//       onStatus: (val) => print('onStatus: $val'),
//       onError: (val) => print('onError: $val'),
//     );

//     if (available) {
//       setState(() => _isListening = true);
//       _speechToText.listen(
//         onResult: (val) {
//           setState(() {
//             _statusMessage = "You said: ${val.recognizedWords}";
//           });
//           _processResponse(val.recognizedWords);
//         },
//       );
//     } else {
//       setState(() => _isListening = false);
//       _speechToText.stop();
//     }
//   }

//   void _processResponse(String response) {
//     // Basic response handling (expand this based on your needs)
//     if (response.toLowerCase().contains("good")) {
//       _flutterTts.speak("I'm glad to hear that!");
//     } else if (response.toLowerCase().contains("bad")) {
//       _flutterTts.speak("I'm sorry to hear that. How can I help?");
//     } else {
//       _flutterTts.speak("Thank you for sharing!");
//     }
//   }

//   void _inferenceCallback(RhinoInference inference) {
//     setState(() {
//       if (inference.isUnderstood!) {
//         _statusMessage =
//             "Intent: ${inference.intent}\nSlots: ${inference.slots}";
//       } else {
//         _statusMessage = "Didn't understand the command.";
//       }
//     });
//     print("Intent: ${inference.intent}");
//     print("Slots: ${inference.slots}");
//   }

//   @override
//   void dispose() {
//     _picovoiceManager.stop();
//     _picovoiceManager.delete();
//     _speechToText.stop();
//     super.dispose();
//   }
// }
