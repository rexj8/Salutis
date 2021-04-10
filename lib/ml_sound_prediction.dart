import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tflite_audio/tflite_audio.dart';

class MachineLearning {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final isRecording = ValueNotifier<bool>(false);
  Stream<Map<dynamic, dynamic>> result;

  // !example values for google's teachable machine model
  final String model = 'assets/soundclassifier.tflite';
  final String label = 'assets/labels.txt';
  final String inputType = 'rawAudio';
  final int sampleRate = 44100;
  final int recordingLength = 44032;
  final int bufferSize = 22050; //22050
  final int numOfInferences = 1;

  // you first have to call this method after making object of class
  void initializemodel() {
    TfliteAudio.loadModel(
      numThreads: 1,
      isAsset: true,
      model: this.model,
      label: this.label,
    );
  }

  // call this method for checking output of recorded file
  getResult() {
    var Result;
    result = TfliteAudio.startAudioRecognition(
      numOfInferences: this.numOfInferences,
      inputType: this.inputType,
      sampleRate: this.sampleRate,
      recordingLength: this.recordingLength,
      bufferSize: this.bufferSize,
    );

    ///Logs the results and assigns false when stream is finished.
    result.listen((event) {
      print(
          event["recognitionResult"]); // this line outputs the predicted class
      Result = event["recognitionResult"];
      Fluttertoast.showToast(msg: event["recognitionResult"]);
    }).onDone(() => isRecording.value = false);
    return result;
  }
}
