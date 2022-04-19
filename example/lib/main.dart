import 'package:flutter/material.dart';

import 'package:taudio_waa/taudio_waa.dart' ;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  late int sumResult;

  @override
  void initState() {
    super.initState();
    sumResult = TaudioWaa().sum(1, 2);
  }



  void onPressed()
  {

    String s = TaudioWaa().greeting("John Smith");
    print(s);
    /*
// Prepare the parameters
    final nameStr = "John Smith";
    final Pointer<Utf8> namePtr = nameStr.toNativeUtf8(); //Utf8.toUtf8(nameStr);
    print("- Calling rust_greeting with argument:  $namePtr");

// Call rust_greeting
    final Pointer<Utf8> resultPtr = rustGreeting(namePtr);
    print("- Result pointer:  $resultPtr");

// Handle the result pointer
    final String greetingStr = resultPtr.toDartString();
    print("- Response string:  $greetingStr");
*/
/*

    // Create an empty two second stereo buffer at the
    // sample rate of the AudioContext
    var frameCount = (audioCtx.sampleRate! * 2). floor();
    var myArrayBuffer = audioCtx.createBuffer(channels, frameCount, audioCtx.sampleRate!);
    // Fill the buffer with white noise;
    //just random values between -1.0 and 1.0

    for (int channel = 0; channel < channels; channel++) {
      // This gives us the actual array that contains the data
      var  nowBuffering = myArrayBuffer.getChannelData(channel);
      for (int i = 0; i < frameCount; i++) {
        // rng.nextInt(2) is in [0; 2]
        // audio needs to be in [-1.0; 1.0]
        nowBuffering[i] = rng.nextInt(2)  - 1;
      }
    }

    // Get an AudioBufferSourceNode.
    // This is the AudioNode to use when we want to play an AudioBuffer
    var source = audioCtx.createBufferSource();
    // set the buffer in the AudioBufferSourceNode
    source.buffer = myArrayBuffer;
    // connect the AudioBufferSourceNode to the
    // destination so we can hear the sound
    source.connectNode(audioCtx.destination!);
    // start the source playing
    source.start();


 */
  }


  void boum()
  {
      String s = TaudioWaa().greeting("John Smith");
      print('boum() => $s');
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  'This calls a native function through FFI that is shipped as source in the package. '
                  'The native code is built as part of the Flutter Runner build.',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                Text(
                  'sum(1, 2) = $sumResult',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                TextButton(onPressed: boum, child: Text('TOTO')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
