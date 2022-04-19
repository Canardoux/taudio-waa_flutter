import 'dart:io';

import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'dart:io';

final DynamicLibrary greeterNative = Platform.isAndroid
    ? DynamicLibrary.open("libgreeter.so")
    : DynamicLibrary.process();

typedef GreetingFunction    = Pointer<Utf8> Function(Pointer<Utf8>);
typedef GreetingFunctionFFI = Pointer<Utf8> Function(Pointer<Utf8>);

final GreetingFunction rustGreeting = greeterNative
    .lookup<NativeFunction<GreetingFunctionFFI>>("rust_greeting")
    .asFunction();

class TaudioWaa {
  int sum(int a, int b) => a + b + 500;

  //String getPlatformVersion() => TaudioWaaPlatform.instance.getPlatformVersion();
  //String greeting(String s)  =>  '$s papa';
  String greeting(String s)
  {

    final nameStr = "John Smith";
    final Pointer<Utf8> namePtr = nameStr.toNativeUtf8();  // Pointer<Utf8> namePtr = Utf8.toUtf8(nameStr);
    print("- Calling rust_greeting with argument:  $namePtr");

// Call rust_greeting
    final Pointer<Utf8> resultPtr = rustGreeting(namePtr);
    print("- Result pointer:  $resultPtr");

// Handle the result pointer
    final String greetingStr = resultPtr.toString();  //Utf8.to(resultPtr);
    print("- Response string:  $greetingStr");


    //rust_greeting('zozo');
    return '$s papa';
  }
}

