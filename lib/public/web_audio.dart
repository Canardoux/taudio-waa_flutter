//  web_audio.dart
//
//  Created by larpoux on 19/02/2022.
//
/*
 * Copyright 2022 Canardoux.
 *
 * This file is part of the τDio project.
 *
 * τDio is free software: you can redistribute it and/or modify
 * it under the terms of the Mozilla Public License version 2 (MPL2.0),
 * as published by the Mozilla organization.
 *
 * τDio is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * MPL General Public License for more details.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

// This source is originated from the Flutter Web Audio Library.
// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// ---------------------------------------------------------------------------------------------------
/// A Web Audio API port on Flutter Mobiles and Flutter Desktop.
/// This library is a copy and paste from the Flutter Web Audio Library interface,
/// but runs under Flutter Mobiles and Flutter Desktop instead of Flutter Web.
/// The goal is to be able to execute a Web App under iOS/Android with just an update
/// of the `import` statement.
/// Note : if we have to deviate from the original interface, those divergence will
/// be explicitly list here :
/// - AudioParamMap is a class specific on Flutter and does not have any correspondence in the W3C Recommandation
/// - AudioTrack is a class specific on Flutter and does not have any correspondence in the W3C Recommandation
/// - AudioTrackList is a class specific on Flutter and does not have any correspondence in the W3C Recommandation
/// - ScriptProcessorNode is a class specific on Flutter and does not have any correspondence in the W3C Recommandation
/// - The W3C [AudioContextOptions](https://www.w3.org/TR/webaudio/#AudioContextOptions) class is not implemented
/// - The W3C [AudioNodeOptions](https://www.w3.org/TR/webaudio/#AudioNodeOptions) class is not implemented
/// - The W3C [AudioWorklet](https://www.w3.org/TR/webaudio/#AudioWorklet) class is not implemented
/// - The W3C [MediaStreamTrackAudioSourceNode](https://www.w3.org/TR/webaudio/#MediaStreamTrackAudioSourceNode) class is not implemented
/// ----------------------------------------------------------------------------------------------------
/// {@category WAA}
library taudio.web_audio;

import 'dart:async';
import 'dart:collection' hide LinkedList, LinkedListEntry;
import 'dart:_internal' show FixedLengthListMixin;
import 'dart:_native_typed_data';
import 'dart:typed_data';
//import 'dart:_foreign_helper' show JS;
import 'dart:_interceptors' show JavaScriptObject;


/// ----------------------------------------------------------------------------------------------------
/// # AnalyserNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#AnalyserNode)
/// - [see Mozilla documentation](https://www.w3.org/TR/webaudio/#AnalyserNode)
/// ----------------------------------------------------------------------------------------------------
/// The AnalyserNode interface represents a node able to provide real-time frequency and time-domain analysis information.
/// It is an AudioNode that passes the audio stream unchanged from the input to the output,
/// but allows you to take the generated data, process it, and create audio visualizations.
class AnalyserNode extends AudioNode {
  // To suppress missing implicit constructor warnings.
  factory AnalyserNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory AnalyserNode(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return AnalyserNode._create_1(context, options_1);
    }
    return AnalyserNode._create_2(context);
  }
  static AnalyserNode _create_1(context, options) =>
      super(ctx, LabSound().createAnalyserNodeOptions(ctx.pointer, options));
  static AnalyserNode _create_2(context) =>
      super(ctx, LabSound().createAnalyserNode(ctx.pointer));

  setFftSize(int fftSize) => LabSound().AnalyserNode_setFftSize(this.nodeId, this.ctx.pointer, fftSize);
  int get fftSize => LabSound().AnalyserNode_fftSize(this.nodeId);

  int get frequencyBinCount => LabSound().AnalyserNode_frequencyBinCount(this.nodeId);

  setMinDecibels(double k) => LabSound().AnalyserNode_setMinDecibels(this.nodeId, k);
  int get minDecibels => LabSound().AnalyserNode_minDecibels(this.nodeId);

  setMaxDecibels(double k) => LabSound().AnalyserNode_setMaxDecibels(this.nodeId, k);
  int get maxDecibels => LabSound().AnalyserNode_maxDecibels(this.nodeId);

  setSmoothingTimeConstant(double k) => LabSound().AnalyserNode_setSmoothingTimeConstant(this.nodeId, k);
  int get smoothingTimeConstant => LabSound().AnalyserNode_smoothingTimeConstant(this.nodeId);

  AnalyserBuffer<double>? floatFrequencyData;
  AnalyserBuffer<double> getFloatFrequencyData() {
    floatFrequencyData ??= AnalyserBuffer<double>(frequencyBinCount);
    if(floatFrequencyData!.ptr == null) throw "floatFrequencyData ptr is null";
    LabSound().AnalyserNode_getFloatFrequencyData(this.nodeId, floatFrequencyData!.ptr! as Pointer<Float>);
    return floatFrequencyData!;
  }

  AnalyserBuffer<int>? byteFrequencyData;
  AnalyserBuffer<int> getByteFrequencyData({resample = false}) {
    byteFrequencyData ??= AnalyserBuffer<int>(frequencyBinCount);
    if(byteFrequencyData!.ptr == null) throw "byteFrequencyData ptr is null";
    LabSound().AnalyserNode_getByteFrequencyData(this.nodeId, byteFrequencyData!.ptr! as Pointer<Uint8>, resample ? 1 : 0);
    return byteFrequencyData!;
  }


  AnalyserBuffer<double>? floatTimeDomainData;
  AnalyserBuffer<double> getFloatTimeDomainData() {
    floatTimeDomainData ??= AnalyserBuffer<double>(frequencyBinCount);
    if(floatTimeDomainData!.ptr == null) throw "floatTimeDomainData ptr is null";
    LabSound().AnalyserNode_getFloatTimeDomainData(this.nodeId, floatTimeDomainData!.ptr! as Pointer<Float>);
    return floatTimeDomainData!;
  }

  AnalyserBuffer<int>? byteTimeDomainData;
  AnalyserBuffer<int> getByteTimeDomainData() {
    byteTimeDomainData ??= AnalyserBuffer<int>(frequencyBinCount);
    if(byteTimeDomainData!.ptr == null) throw "byteTimeDomainData ptr is null";
    LabSound().AnalyserNode_getByteTimeDomainData(this.nodeId, byteTimeDomainData!.ptr! as Pointer<Uint8>);
    return byteTimeDomainData!;
  }

  @override
  dispose() {
    floatFrequencyData?.free();
    byteFrequencyData?.free();
    floatTimeDomainData?.free();
    byteTimeDomainData?.free();
    super.dispose();
  }

}

/// ----------------------------------------------------------------------------------------------------
/// # AudioBuffer
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#AudioBuffer)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/AudioBuffer)
/// ----------------------------------------------------------------------------------------------------
/// The AudioBuffer interface represents a short audio asset residing in memory,
/// created from an audio file using the AudioContext.decodeAudioData() method, or from raw data using AudioContext.createBuffer().
/// Once put into an AudioBuffer, the audio can then be played by being passed into an AudioBufferSourceNode.
///
/// Objects of these types are designed to hold small audio snippets, typically less than 45 s.
/// For longer sounds, objects implementing the MediaElementAudioSourceNode are more suitable.
/// The buffer contains data in the following format: non-interleaved IEEE754 32-bit linear PCM with a nominal range between -1 and +1,
/// that is, a 32-bit floating point buffer, with each sample between -1.0 and 1.0. If the AudioBuffer has multiple channels,
/// they are stored in separate buffers.class AudioBuffer extends JavaScriptObject {
class AudioBuffer extends JavaScriptObject {
  /*
  // To suppress missing implicit constructor warnings.
  factory AudioBuffer._() {
    throw new UnsupportedError("Not supported");
  }

  factory AudioBuffer(Map options) {
    var options_1 = convertDartToNative_Dictionary(options);
    return AudioBuffer._create_1(options_1);
  }
  static AudioBuffer _create_1(options) =>
      JS('AudioBuffer', 'new AudioBuffer(#)', options);

  num? get duration native;

  int? get length native;

  int? get numberOfChannels native;

  num? get sampleRate native;

  void copyFromChannel(Float32List destination, int channelNumber,
      [int? startInChannel]) native;

  void copyToChannel(Float32List source, int channelNumber,
      [int? startInChannel]) native;

  Float32List getChannelData(int channelIndex) native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # AudioBufferSourceNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#AudioBufferSourceNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/AudioBufferSourceNode)
/// ----------------------------------------------------------------------------------------------------
/// This interface represents an audio source from an in-memory audio asset in an AudioBuffer.
/// It is useful for playing audio assets which require a high degree of scheduling flexibility and accuracy.
/// If sample-accurate playback of network- or disk-backed assets is required, an implementer should use AudioWorkletNode to implement playback.
///
/// The start() method is used to schedule when sound playback will happen.
/// The start() method may not be issued multiple times.
/// The playback will stop automatically when the buffer’s audio data has been completely played (if the loop attribute is false),
/// or when the stop() method has been called and the specified time has been reached. Please see more details in the start() and stop() descriptions.
///
/// - numberOfInputs	0
/// - numberOfOutputs	1
/// - channelCount	2
/// - channelCountMode	"max"
/// - channelInterpretation	"speakers"
/// - tail-time	No
///
/// The number of channels of the output equals the number of channels of the AudioBuffer assigned to the buffer attribute,
/// or is one channel of silence if buffer is null.
///
/// In addition, if the buffer has more than one channel, then the AudioBufferSourceNode output must change
/// to a single channel of silence at the beginning of a render quantum after the time at which any one of the following conditions holds:
/// - the end of the buffer has been reached;
/// - the duration has been reached;
/// - the stop time has been reached.
///
/// A playhead position for an AudioBufferSourceNode is defined as any quantity representing a time offset in seconds,
/// relative to the time coordinate of the first sample frame in the buffer.
/// Such values are to be considered independently from the node’s playbackRate and detune parameters.
/// In general, playhead positions may be subsample-accurate and need not refer to exact sample frame positions.
/// They may assume valid values between 0 and the duration of the buffer.
///
/// The playbackRate and detune attributes form a compound parameter. They are used together to determine a computedPlaybackRate value:
///
/// computedPlaybackRate(t) = playbackRate(t) * pow(2, detune(t) / 1200)
/// The nominal range for this compound parameter is (−∞,∞).
///
/// AudioBufferSourceNodes are created with an internal boolean slot `buffer set`, initially set to false.
class AudioBufferSourceNode extends AudioScheduledSourceNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory AudioBufferSourceNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory AudioBufferSourceNode(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return AudioBufferSourceNode._create_1(context, options_1);
    }
    return AudioBufferSourceNode._create_2(context);
  }
  static AudioBufferSourceNode _create_1(context, options) => JS(
      'AudioBufferSourceNode',
      'new AudioBufferSourceNode(#,#)',
      context,
      options);
  static AudioBufferSourceNode _create_2(context) =>
      JS('AudioBufferSourceNode', 'new AudioBufferSourceNode(#)', context);

  AudioBuffer? get buffer native;

  set buffer(AudioBuffer? value) native;

  AudioParam? get detune native;

  bool? get loop native;

  set loop(bool? value) native;

  num? get loopEnd native;

  set loopEnd(num? value) native;

  num? get loopStart native;

  set loopStart(num? value) native;

  AudioParam? get playbackRate native;

  void start([num? when, num? grainOffset, num? grainDuration]) native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # AudioContext
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#AudioContext)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/AudioContext)
/// ----------------------------------------------------------------------------------------------------
/// The AudioContext interface represents an audio-processing graph built from audio modules linked together,
/// each represented by an AudioNode.
///
/// An audio context controls both the creation of the nodes it contains and the execution of the audio processing,
/// or decoding.
/// You need to create an AudioContext before you do anything else, as everything happens inside a context.
/// It's recommended to create one AudioContext and reuse it instead of initializing a new one each time,
/// and it's OK to use a single AudioContext for several different audio sources and pipeline concurrently.
class AudioContext extends BaseAudioContext {
  /*
  // To suppress missing implicit constructor warnings.
  factory AudioContext._() {
    throw new UnsupportedError("Not supported");
  }

  /// Checks if this type is supported on the current platform.
  static bool get supported =>
      JS('bool', '!!(window.AudioContext || window.webkitAudioContext)');

  num? get baseLatency native;

  Future close() => promiseToFuture(JS("", "#.close()", this));

  Map getOutputTimestamp() {
    return convertNativeToDart_Dictionary(_getOutputTimestamp_1())!;
  }

  @JSName('getOutputTimestamp')
  _getOutputTimestamp_1() native;

  Future suspend() => promiseToFuture(JS("", "#.suspend()", this));

  factory AudioContext() => JS('AudioContext',
      'new (window.AudioContext || window.webkitAudioContext)()');

  GainNode createGain() {
    if (JS('bool', '#.createGain !== undefined', this)) {
      return JS('GainNode', '#.createGain()', this);
    } else {
      return JS('GainNode', '#.createGainNode()', this);
    }
  }

  ScriptProcessorNode createScriptProcessor(
      [int? bufferSize,
      int? numberOfInputChannels,
      int? numberOfOutputChannels]) {
    var function = JS(
        '=Object',
        '#.createScriptProcessor || '
            '#.createJavaScriptNode',
        this,
        this);
    if (numberOfOutputChannels != null) {
      return JS('ScriptProcessorNode', '#.call(#, #, #, #)', function, this,
          bufferSize, numberOfInputChannels, numberOfOutputChannels);
    } else if (numberOfInputChannels != null) {
      return JS('ScriptProcessorNode', '#.call(#, #, #)', function, this,
          bufferSize, numberOfInputChannels);
    } else if (bufferSize != null) {
      return JS(
          'ScriptProcessorNode', '#.call(#, #)', function, this, bufferSize);
    } else {
      return JS('ScriptProcessorNode', '#.call(#)', function, this);
    }
  }

  Future<AudioBuffer> decodeAudioData(ByteBuffer audioData,
      [DecodeSuccessCallback? successCallback,
      DecodeErrorCallback? errorCallback]) {
    // Both callbacks need to be provided if they're being used.
    assert((successCallback == null) == (errorCallback == null));
    // `decodeAudioData` can exist either in the older callback syntax or the
    // newer `Promise`-based syntax that also accepts callbacks. In the former,
    // we synthesize a `Future` to be consistent.
    // For more details:
    // https://developer.mozilla.org/en-US/docs/Web/API/BaseAudioContext/decodeAudioData
    // https://www.w3.org/TR/webaudio/#dom-baseaudiocontext-decodeaudiodata
    final completer = Completer<Object>();
    var errorInCallbackIsNull = false;

    void success(AudioBuffer decodedData) {
      completer.complete(decodedData);
      successCallback!.call(decodedData);
    }

    final nullErrorString =
        '[AudioContext.decodeAudioData] completed with a null error.';

    void error(DomException? error) {
      // Safari has a bug where it may return null for the error callback. In
      // the case where the Safari version still returns a `Promise` and the
      // error is not null after the `Promise` is finished, the error callback
      // is called instead in the `Promise`'s `catch` block. Otherwise, and in
      // the case where a `Promise` is not returned by the API at all, the
      // callback never gets called (for backwards compatibility, it can not
      // accept null). Instead, the `Future` completes with a custom string,
      // indicating that null was given.
      // https://github.com/mdn/webaudio-examples/issues/5
      if (error != null) {
        // Note that we `complete` and not `completeError`. This is to make sure
        // that errors in the `Completer` are not thrown if the call gets back
        // a `Promise`.
        completer.complete(error);
        errorCallback!.call(error);
      } else {
        completer.complete(nullErrorString);
        errorInCallbackIsNull = true;
      }
    }

    var decodeResult;
    if (successCallback == null) {
      decodeResult =
          JS("creates:AudioBuffer;", "#.decodeAudioData(#)", this, audioData);
    } else {
      decodeResult = JS(
          "creates:AudioBuffer;",
          "#.decodeAudioData(#, #, #)",
          this,
          audioData,
          convertDartClosureToJS(success, 1),
          convertDartClosureToJS(error, 1));
    }

    if (decodeResult != null) {
      // Promise-based syntax.
      return promiseToFuture<AudioBuffer>(decodeResult).catchError((error) {
        // If the error was null in the callback, but no longer is now that the
        // `Promise` is finished, call the error callback. If it's still null,
        // throw the error string. This is to handle the aforementioned bug in
        // Safari.
        if (errorInCallbackIsNull) {
          if (error != null) {
            errorCallback?.call(error);
          } else {
            throw nullErrorString;
          }
        }
        throw error;
      });
    }

    // Callback-based syntax. We use the above completer to synthesize a
    // `Future` from the callback values. Since we don't use `completeError`
    // above, `then` is used to simulate an error.
    return completer.future.then((value) {
      if (value is AudioBuffer) return value;
      throw value;
    });
  }

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # AudioDestinationNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#AudioDestinationNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/AudioDestinationNode)
/// ----------------------------------------------------------------------------------------------------
/// The AudioDestinationNode interface represents the end destination of an audio graph in a given context — usually the speakers of your device.
/// It can also be the node that will "record" the audio data when used with an OfflineAudioContext.
///
/// AudioDestinationNode has no output (as it is the output, no more AudioNode can be linked after it in the audio graph) and one input.
/// The number of channels in the input must be between 0 and the maxChannelCount value or an exception is raised.
///
/// The AudioDestinationNode of a given AudioContext can be retrieved using the AudioContext.destination property.
///
/// - Number of inputs	1
/// - Number of outputs	0
/// - Channel count mode	"explicit"
/// - Channel count	2
/// - Channel interpretation	"speakers"
class AudioDestinationNode extends AudioNode {
  // To suppress missing implicit constructor warnings.
  factory AudioDestinationNode._() {
    throw new UnsupportedError("Not supported");
  }

  int? get maxChannelCount native;
}

/// ----------------------------------------------------------------------------------------------------
/// # AudioListener
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#AudioListener)
/// - see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/AudioListener)
/// ----------------------------------------------------------------------------------------------------
/// This interface represents the position and orientation of the person listening to the audio scene.
/// All PannerNode objects spatialize in relation to the BaseAudioContext's listener.
/// See § 6 Spatialization/Panning for more details about spatialization.
///
/// The positionX, positionY, and positionZ parameters represent the location of the listener in 3D Cartesian coordinate space.
/// PannerNode objects use this position relative to individual audio sources for spatialization.
///
/// The forwardX, forwardY, and forwardZ parameters represent a direction vector in 3D space.
/// Both a forward vector and an up vector are used to determine the orientation of the listener.
/// In simple human terms, the forward vector represents which direction the person’s nose is pointing.
/// The up vector represents the direction the top of a person’s head is pointing. These two vectors are expected to be linearly independent.
/// For normative requirements of how these values are to be interpreted, see the § 6 Spatialization/Panning section.
class AudioListener extends JavaScriptObject {
  // To suppress missing implicit constructor warnings.
  factory AudioListener._() {
    throw new UnsupportedError("Not supported");
  }

  AudioParam? get forwardX native;

  AudioParam? get forwardY native;

  AudioParam? get forwardZ native;

  AudioParam? get positionX native;

  AudioParam? get positionY native;

  AudioParam? get positionZ native;

  AudioParam? get upX native;

  AudioParam? get upY native;

  AudioParam? get upZ native;

  void setOrientation(num x, num y, num z, num xUp, num yUp, num zUp) native;

  void setPosition(num x, num y, num z) native;
}

/// ----------------------------------------------------------------------------------------------------
/// # AudioNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#AudioNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/AudioNode)
/// ----------------------------------------------------------------------------------------------------
/// The AudioNode interface is a generic interface for representing an audio processing module.
///
/// Examples include:
/// - an audio source (e.g. an HTML <audio> or <video> element, an OscillatorNode, etc.),
/// - the audio destination,
/// - intermediate processing module (e.g. a filter like BiquadFilterNode or ConvolverNode), or
/// - volume control (like GainNode)
///
/// Note: An AudioNode can be target of events, therefore it implements the EventTarget interface.
class AudioNode extends EventTarget {
  /*
  // To suppress missing implicit constructor warnings.
  factory AudioNode._() {
    throw new UnsupportedError("Not supported");
  }

  int? get channelCount native;

  set channelCount(int? value) native;

  String? get channelCountMode native;

  set channelCountMode(String? value) native;

  String? get channelInterpretation native;

  set channelInterpretation(String? value) native;

  BaseAudioContext? get context native;

  int? get numberOfInputs native;

  int? get numberOfOutputs native;

  @JSName('connect')
  AudioNode _connect(destination, [int? output, int? input]) native;

  void disconnect([destination_OR_output, int? output, int? input]) native;

  void connectNode(AudioNode destination, [int output = 0, int input = 0]) {
    _connect(destination, output, input);
  }

  void connectParam(AudioParam destination, [int output = 0]) {
    _connect(destination, output);
  }

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # AudioParam
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#AudioParam)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/AudioParam)
/// ----------------------------------------------------------------------------------------------------
/// The Web Audio API's AudioParam interface represents an audio-related parameter,
/// usually a parameter of an AudioNode (such as GainNode.gain).
///
/// An AudioParam can be set to a specific value or a change in value,
/// and can be scheduled to happen at a specific time and following a specific pattern.
///
/// Each AudioParam has a list of events, initially empty, that define when and how values change.
/// When this list is not empty, changes using the AudioParam.value attributes are ignored.
/// This list of events allows us to schedule changes that have to happen at very precise times,
/// using arbitrary timeline-based automation curves.
/// The time used is the one defined in AudioContext.currentTime.
class AudioParam extends JavaScriptObject {
  // To suppress missing implicit constructor warnings.
  factory AudioParam._() {
    throw new UnsupportedError("Not supported");
  }

  num? get defaultValue native;

  num? get maxValue native;

  num? get minValue native;

  num? get value native;

  set value(num? value) native;

  AudioParam cancelAndHoldAtTime(num startTime) native;

  AudioParam cancelScheduledValues(num startTime) native;

  AudioParam exponentialRampToValueAtTime(num value, num time) native;

  AudioParam linearRampToValueAtTime(num value, num time) native;

  AudioParam setTargetAtTime(num target, num time, num timeConstant) native;

  AudioParam setValueAtTime(num value, num time) native;

  AudioParam setValueCurveAtTime(List<num> values, num time, num duration)
      native;
}

/// ----------------------------------------------------------------------------------------------------
/// # AudioParamMap
/// ----------------------------------------------------------------------------------------------------
/// This class is specific on Flutter and does not have any correspondence in the W3C Recommandation
class AudioParamMap extends JavaScriptObject with MapMixin<String, dynamic> {
  /*
  // To suppress missing implicit constructor warnings.
  factory AudioParamMap._() {
    throw new UnsupportedError("Not supported");
  }

  Map? _getItem(String key) =>
      convertNativeToDart_Dictionary(JS('', '#.get(#)', this, key));

  void addAll(Map<String, dynamic> other) {
    throw new UnsupportedError("Not supported");
  }

  bool containsValue(dynamic value) => values.any((e) => e == value);

  bool containsKey(dynamic key) => _getItem(key) != null;

  Map? operator [](dynamic key) => _getItem(key);

  void forEach(void f(String key, dynamic value)) {
    var entries = JS('', '#.entries()', this);
    while (true) {
      var entry = JS('', '#.next()', entries);
      if (JS('bool', '#.done', entry)) return;
      f(JS('String', '#.value[0]', entry),
          convertNativeToDart_Dictionary(JS('', '#.value[1]', entry)));
    }
  }

  Iterable<String> get keys {
    final keys = <String>[];
    forEach((k, v) => keys.add(k));
    return keys;
  }

  Iterable<Map> get values {
    final values = <Map>[];
    forEach((k, v) => values.add(v));
    return values;
  }

  int get length => JS('int', '#.size', this);

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;

  void operator []=(String key, dynamic value) {
    throw new UnsupportedError("Not supported");
  }

  dynamic putIfAbsent(String key, dynamic ifAbsent()) {
    throw new UnsupportedError("Not supported");
  }

  String remove(dynamic key) {
    throw new UnsupportedError("Not supported");
  }

  void clear() {
    throw new UnsupportedError("Not supported");
  }

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # AudioProcessingEvent
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#AudioProcessingEvent)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/AudioProcessingEvent)
/// ----------------------------------------------------------------------------------------------------
@deprecated
class AudioProcessingEvent extends Event {
  /*
  // To suppress missing implicit constructor warnings.
  factory AudioProcessingEvent._() {
    throw new UnsupportedError("Not supported");
  }

  factory AudioProcessingEvent(String type, Map eventInitDict) {
    var eventInitDict_1 = convertDartToNative_Dictionary(eventInitDict);
    return AudioProcessingEvent._create_1(type, eventInitDict_1);
  }
  static AudioProcessingEvent _create_1(type, eventInitDict) => JS(
      'AudioProcessingEvent',
      'new AudioProcessingEvent(#,#)',
      type,
      eventInitDict);

  AudioBuffer? get inputBuffer native;

  AudioBuffer? get outputBuffer native;

  num? get playbackTime native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # AudioScheduledSourceNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#AudioScheduledSourceNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/AudioScheduledSourceNode)
/// ----------------------------------------------------------------------------------------------------
/// The AudioScheduledSourceNode interface—part of the Web Audio API—is a parent interface
/// for several types of audio source node interfaces which share the ability to be started and stopped,
/// optionally at specified times. Specifically, this interface defines the start() and stop() methods, as well as the ended event.
///
/// Note: You can't create an AudioScheduledSourceNode object directly.
/// Instead, use the interface which extends it, such as AudioBufferSourceNode, OscillatorNode, and ConstantSourceNode.
///
/// Unless stated otherwise, nodes based upon AudioScheduledSourceNode output silence when not playing
/// (that is, before start() is called and after stop() is called).
/// Silence is represented, as always, by a stream of samples with the value zero (0).
class AudioScheduledSourceNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory AudioScheduledSourceNode._() {
    throw new UnsupportedError("Not supported");
  }

  static const EventStreamProvider<Event> endedEvent =
      const EventStreamProvider<Event>('ended');

  @JSName('start')
  void start2([num? when]) native;

  void stop([num? when]) native;

  Stream<Event> get onEnded => endedEvent.forTarget(this);

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # AudioTrack
/// ----------------------------------------------------------------------------------------------------
/// This class is specific on Flutter and does not have any correspondence in the W3C Recommandation
class AudioTrack extends JavaScriptObject {
  // To suppress missing implicit constructor warnings.
  factory AudioTrack._() {
    throw new UnsupportedError("Not supported");
  }

  bool? get enabled native;

  set enabled(bool? value) native;

  String? get id native;

  String? get kind native;

  String? get label native;

  String? get language native;

  SourceBuffer? get sourceBuffer native;
}

/// ----------------------------------------------------------------------------------------------------
/// # AudioTrackList
/// ----------------------------------------------------------------------------------------------------
/// This class is specific on Flutter and does not have any correspondence in the W3C Recommandation
class AudioTrackList extends EventTarget {
  // To suppress missing implicit constructor warnings.
  factory AudioTrackList._() {
    throw new UnsupportedError("Not supported");
  }

  static const EventStreamProvider<Event> changeEvent =
      const EventStreamProvider<Event>('change');

  int? get length native;

  AudioTrack __getter__(int index) native;

  AudioTrack? getTrackById(String id) native;

  Stream<Event> get onChange => changeEvent.forTarget(this);
}

/// ----------------------------------------------------------------------------------------------------
/// # AudioWorkletGlobalScope
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#AudioWorkletGlobalScope)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/AudioWorkletGlobalScope)
/// ----------------------------------------------------------------------------------------------------
/// The AudioWorkletGlobalScope interface of the Web Audio API represents a global execution context
/// for user-supplied code, which defines custom AudioWorkletProcessor-derived classes.
///
/// Each BaseAudioContext has a single AudioWorklet available under the audioWorklet property,
/// which runs its code in a single AudioWorkletGlobalScope.
///
/// As the global execution context is shared across the current BaseAudioContext,
/// it's possible to define any other variables and perform any actions
/// allowed in worklets — apart from defining AudioWorkletProcessor-derived classes.
class AudioWorkletGlobalScope extends WorkletGlobalScope {
  // To suppress missing implicit constructor warnings.
  factory AudioWorkletGlobalScope._() {
    throw new UnsupportedError("Not supported");
  }

  num? get currentTime native;

  num? get sampleRate native;

  void registerProcessor(String name, Object processorConstructor) native;
}

/// ----------------------------------------------------------------------------------------------------
/// # AudioWorkletNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#AudioWorkletNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/AudioWorkletNode)
/// ----------------------------------------------------------------------------------------------------
/// Note: Although the interface is available outside secure contexts,
/// the BaseAudioContext.audioWorklet property is not, thus custom AudioWorkletProcessors cannot be defined outside them.
///
/// The AudioWorkletNode interface of the Web Audio API represents a base class for a user-defined AudioNode,
/// which can be connected to an audio routing graph along with other nodes. It has an associated AudioWorkletProcessor,
/// which does the actual audio processing in a Web Audio rendering thread.
class AudioWorkletNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory AudioWorkletNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory AudioWorkletNode(BaseAudioContext context, String name,
      [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return AudioWorkletNode._create_1(context, name, options_1);
    }
    return AudioWorkletNode._create_2(context, name);
  }
  static AudioWorkletNode _create_1(context, name, options) => JS(
      'AudioWorkletNode',
      'new AudioWorkletNode(#,#,#)',
      context,
      name,
      options);
  static AudioWorkletNode _create_2(context, name) =>
      JS('AudioWorkletNode', 'new AudioWorkletNode(#,#)', context, name);

  AudioParamMap? get parameters native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # AudioWorkletProcessor
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#AudioWorkletProcessor)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/AudioWorkletProcessor)
/// ----------------------------------------------------------------------------------------------------
/// The AudioWorkletProcessor interface of the Web Audio API represents
/// an audio processing code behind a custom AudioWorkletNode.
/// It lives in the AudioWorkletGlobalScope and runs on the Web Audio rendering thread.
/// In turn, an AudioWorkletNode based on it runs on the main thread.
class AudioWorkletProcessor extends JavaScriptObject {
  // To suppress missing implicit constructor warnings.
  factory AudioWorkletProcessor._() {
    throw new UnsupportedError("Not supported");
  }
}

/// ----------------------------------------------------------------------------------------------------
/// # BaseAudioContext
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#BaseAudioContext)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/BaseAudioContext)
/// ----------------------------------------------------------------------------------------------------
/// The BaseAudioContext interface of the Web Audio API acts
/// as a base definition for online and offline audio-processing graphs,
/// as represented by AudioContext and OfflineAudioContext respectively.
/// You wouldn't use BaseAudioContext directly — you'd use its features via one of these two inheriting interfaces.
///
/// A BaseAudioContext can be a target of events, therefore it implements the EventTarget interface.
class BaseAudioContext extends EventTarget {
  /*
  // To suppress missing implicit constructor warnings.
  factory BaseAudioContext._() {
    throw new UnsupportedError("Not supported");
  }

  num? get currentTime native;

  AudioDestinationNode? get destination native;

  AudioListener? get listener native;

  num? get sampleRate native;

  String? get state native;

  AnalyserNode createAnalyser() native;

  BiquadFilterNode createBiquadFilter() native;

  AudioBuffer createBuffer(
      int numberOfChannels, int numberOfFrames, num sampleRate) native;

  AudioBufferSourceNode createBufferSource() native;

  ChannelMergerNode createChannelMerger([int? numberOfInputs]) native;

  ChannelSplitterNode createChannelSplitter([int? numberOfOutputs]) native;

  ConstantSourceNode createConstantSource() native;

  ConvolverNode createConvolver() native;

  DelayNode createDelay([num? maxDelayTime]) native;

  DynamicsCompressorNode createDynamicsCompressor() native;

  GainNode createGain() native;

  @JSName('createIIRFilter')
  IirFilterNode createIirFilter(List<num> feedForward, List<num> feedBack)
      native;

  MediaElementAudioSourceNode createMediaElementSource(
      MediaElement mediaElement) native;

  MediaStreamAudioDestinationNode createMediaStreamDestination() native;

  MediaStreamAudioSourceNode createMediaStreamSource(MediaStream mediaStream)
      native;

  OscillatorNode createOscillator() native;

  PannerNode createPanner() native;

  PeriodicWave createPeriodicWave(List<num> real, List<num> imag,
      [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return _createPeriodicWave_1(real, imag, options_1);
    }
    return _createPeriodicWave_2(real, imag);
  }

  @JSName('createPeriodicWave')
  PeriodicWave _createPeriodicWave_1(List<num> real, List<num> imag, options)
      native;
  @JSName('createPeriodicWave')
  PeriodicWave _createPeriodicWave_2(List<num> real, List<num> imag) native;

  ScriptProcessorNode createScriptProcessor(
      [int? bufferSize,
      int? numberOfInputChannels,
      int? numberOfOutputChannels]) native;

  StereoPannerNode createStereoPanner() native;

  WaveShaperNode createWaveShaper() native;

  Future<AudioBuffer> decodeAudioData(ByteBuffer audioData,
          [DecodeSuccessCallback? successCallback,
          DecodeErrorCallback? errorCallback]) =>
      promiseToFuture<AudioBuffer>(JS(
          "creates:AudioBuffer;",
          "#.decodeAudioData(#, #, #)",
          this,
          audioData,
          successCallback,
          errorCallback));

  Future resume() => promiseToFuture(JS("", "#.resume()", this));

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # BiquadFilterNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#BiquadFilterNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/BiquadFilterNode)
/// ----------------------------------------------------------------------------------------------------
/// The BiquadFilterNode interface represents a simple low-order filter,
/// and is created using the BaseAudioContext/createBiquadFilter method.
/// It is an AudioNode that can represent different kinds of filters, tone control devices,
/// and graphic equalizers. A BiquadFilterNode always has exactly one input and one output.
class BiquadFilterNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory BiquadFilterNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory BiquadFilterNode(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return BiquadFilterNode._create_1(context, options_1);
    }
    return BiquadFilterNode._create_2(context);
  }
  static BiquadFilterNode _create_1(context, options) =>
      JS('BiquadFilterNode', 'new BiquadFilterNode(#,#)', context, options);
  static BiquadFilterNode _create_2(context) =>
      JS('BiquadFilterNode', 'new BiquadFilterNode(#)', context);

  AudioParam? get Q native;

  AudioParam? get detune native;

  AudioParam? get frequency native;

  AudioParam? get gain native;

  String? get type native;

  set type(String? value) native;

  void getFrequencyResponse(Float32List frequencyHz, Float32List magResponse,
      Float32List phaseResponse) native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # ChannelMergerNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#ChannelMergerNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/ChannelMergerNode)
/// ----------------------------------------------------------------------------------------------------
/// The ChannelMergerNode interface, often used in conjunction with its opposite,
/// ChannelSplitterNode, reunites different mono inputs into a single output.
/// Each input is used to fill a channel of the output.
/// This is useful for accessing each channels separately, e.g. for performing channel mixing
/// where gain must be separately controlled on each channel.
///
/// If ChannelMergerNode has one single output, but as many inputs as there are channels to merge;
/// the number of inputs is defined as a parameter of its constructor
/// and the call to AudioContext.createChannelMerger().
/// In the case that no value is given, it will default to 6.
///
/// Using a ChannelMergerNode, it is possible to create outputs
/// with more channels than the rendering hardware is able to process.
/// In that case, when the signal is sent to the AudioContext.
/// listener object, supernumerary channels will be ignored.
class ChannelMergerNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory ChannelMergerNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory ChannelMergerNode(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return ChannelMergerNode._create_1(context, options_1);
    }
    return ChannelMergerNode._create_2(context);
  }
  static ChannelMergerNode _create_1(context, options) =>
      JS('ChannelMergerNode', 'new ChannelMergerNode(#,#)', context, options);
  static ChannelMergerNode _create_2(context) =>
      JS('ChannelMergerNode', 'new ChannelMergerNode(#)', context);

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # ChannelSplitterNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#ChannelSplitterNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/ChannelSplitterNode)
/// ----------------------------------------------------------------------------------------------------
/// The ChannelSplitterNode interface, often used in conjunction with its opposite,
/// ChannelMergerNode, separates the different channels of an audio source into a set of mono outputs.
/// This is useful for accessing each channel separately, e.g. for performing channel mixing
/// where gain must be separately controlled on each channel.
///
/// If your ChannelSplitterNode always has one single input,
/// the amount of outputs is defined by a parameter on its constructor and the call to AudioContext.createChannelSplitter().
/// In the case that no value is given, it will default to 6.
/// If there are fewer channels in the input than there are outputs, supernumerary outputs are silent.
class ChannelSplitterNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory ChannelSplitterNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory ChannelSplitterNode(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return ChannelSplitterNode._create_1(context, options_1);
    }
    return ChannelSplitterNode._create_2(context);
  }
  static ChannelSplitterNode _create_1(context, options) => JS(
      'ChannelSplitterNode', 'new ChannelSplitterNode(#,#)', context, options);
  static ChannelSplitterNode _create_2(context) =>
      JS('ChannelSplitterNode', 'new ChannelSplitterNode(#)', context);

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # ConstantSourceNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#ConstantSourceNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/ConstantSourceNode)
/// ----------------------------------------------------------------------------------------------------
/// The ConstantSourceNode interface—part of the Web Audio API—represents an audio source
/// (based upon AudioScheduledSourceNode) whose output is single unchanging value.
/// This makes it useful for cases in which you need a constant value coming in from an audio source.
/// In addition, it can be used like a constructible AudioParam by automating the value of its offset
/// or by connecting another node to it; see Controlling multiple parameters with ConstantSourceNode.
///
/// A ConstantSourceNode has no inputs and exactly one monaural (one-channel) output.
/// The output's value is always the same as the value of the offset parameter.
///
/// - Number of inputs	0
/// - Number of outputs	1
class ConstantSourceNode extends AudioScheduledSourceNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory ConstantSourceNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory ConstantSourceNode(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return ConstantSourceNode._create_1(context, options_1);
    }
    return ConstantSourceNode._create_2(context);
  }
  static ConstantSourceNode _create_1(context, options) =>
      JS('ConstantSourceNode', 'new ConstantSourceNode(#,#)', context, options);
  static ConstantSourceNode _create_2(context) =>
      JS('ConstantSourceNode', 'new ConstantSourceNode(#)', context);

  AudioParam? get offset native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # ConvolverNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#ConvolverNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/ConvolverNode)
/// ----------------------------------------------------------------------------------------------------
/// The ConvolverNode interface is an AudioNode that performs a Linear Convolution on a given AudioBuffer,
/// often used to achieve a reverb effect. A ConvolverNode always has exactly one input and one output.
///
/// Note: For more information on the theory behind Linear Convolution, see the Convolution article on Wikipedia.
///
/// - Number of inputs	1
/// - Number of outputs	1
/// - Channel count mode	"clamped-max"
/// - Channel count	1, 2, or 4
/// - Channel interpretation	"speakers"
class ConvolverNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory ConvolverNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory ConvolverNode(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return ConvolverNode._create_1(context, options_1);
    }
    return ConvolverNode._create_2(context);
  }
  static ConvolverNode _create_1(context, options) =>
      JS('ConvolverNode', 'new ConvolverNode(#,#)', context, options);
  static ConvolverNode _create_2(context) =>
      JS('ConvolverNode', 'new ConvolverNode(#)', context);

  AudioBuffer? get buffer native;

  set buffer(AudioBuffer? value) native;

  bool? get normalize native;

  set normalize(bool? value) native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # DelayNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#DelayNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/DelayNode)
/// ----------------------------------------------------------------------------------------------------
/// The DelayNode interface represents a delay-line an AudioNode audio-processing module
/// that causes a delay between the arrival of an input data and its propagation to the output.
///
/// A DelayNode always has exactly one input and one output, both with the same amount of channels.
///
/// The DelayNode acts as a delay-line, here with a value of 1s.
///
/// When creating a graph that has a cycle, it is mandatory to have at least
/// one DelayNode in the cycle, or the nodes taking part in the cycle will be muted.
///
/// - Number of inputs	1
/// - Number of outputs	1
/// - Channel count mode	"max"
/// - Channel count	2 (not used in the default count mode)
/// - Channel interpretation	"speakers"
class DelayNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory DelayNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory DelayNode(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return DelayNode._create_1(context, options_1);
    }
    return DelayNode._create_2(context);
  }
  static DelayNode _create_1(context, options) =>
      JS('DelayNode', 'new DelayNode(#,#)', context, options);
  static DelayNode _create_2(context) =>
      JS('DelayNode', 'new DelayNode(#)', context);

  AudioParam? get delayTime native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # DynamicsCompressorNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#DynamicsCompressorNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/DynamicsCompressorNode)
/// ----------------------------------------------------------------------------------------------------
/// The DynamicsCompressorNode interface provides a compression effect,
/// which lowers the volume of the loudest parts of the signal in order to help prevent clipping and distortion
/// that can occur when multiple sounds are played and multiplexed together at once.
/// This is often used in musical production and game audio.
/// DynamicsCompressorNode is an AudioNode that has exactly one input and one output.
///
/// - Number of inputs	1
/// - Number of outputs	1
/// - Channel count mode	"clamped-max"
/// - Channel count	2
/// - Channel interpretation	"speakers"
class DynamicsCompressorNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory DynamicsCompressorNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory DynamicsCompressorNode(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return DynamicsCompressorNode._create_1(context, options_1);
    }
    return DynamicsCompressorNode._create_2(context);
  }
  static DynamicsCompressorNode _create_1(context, options) => JS(
      'DynamicsCompressorNode',
      'new DynamicsCompressorNode(#,#)',
      context,
      options);
  static DynamicsCompressorNode _create_2(context) =>
      JS('DynamicsCompressorNode', 'new DynamicsCompressorNode(#)', context);

  AudioParam? get attack native;

  AudioParam? get knee native;

  AudioParam? get ratio native;

  num? get reduction native;

  AudioParam? get release native;

  AudioParam? get threshold native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # GainNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#GainNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/GainNode)
/// ----------------------------------------------------------------------------------------------------
/// The GainNode interface represents a change in volume.
/// It is an AudioNode audio-processing module that causes a given gain to be applied
/// to the input data before its propagation to the output.
/// A GainNode always has exactly one input and one output, both with the same number of channels.
///
/// The gain is a unitless value, changing with time, that is multiplied to each corresponding sample of all input channels.
/// If modified, the new gain is instantly applied, causing unaesthetic 'clicks' in the resulting audio.
/// To prevent this from happening, never change the value directly but use the exponential interpolation methods on the AudioParam interface.
///
/// - Number of inputs	1
/// - Number of outputs	1
/// - Channel count mode	"max"
/// - Channel count	2 (not used in the default count mode)
/// - Channel interpretation	"speakers"
class GainNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory GainNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory GainNode(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return GainNode._create_1(context, options_1);
    }
    return GainNode._create_2(context);
  }
  static GainNode _create_1(context, options) =>
      JS('GainNode', 'new GainNode(#,#)', context, options);
  static GainNode _create_2(context) =>
      JS('GainNode', 'new GainNode(#)', context);

  AudioParam? get gain native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # IirFilterNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#IIRFilterNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/IIRFilterNode)
/// ----------------------------------------------------------------------------------------------------
/// The IIRFilterNode interface of the Web Audio API is a AudioNode processor which implements
/// a general infinite impulse response (IIR)  filter; this type of filter can be used to implement
/// tone control devices and graphic equalizers as well. It lets the parameters of the filter response be specified,
/// so that it can be tuned as needed.
///
/// - Number of inputs	1
/// - Number of outputs	1
/// - Channel count mode	"max"
/// - Channel count	Same as on the input
/// - Channel interpretation	"speakers"
///
/// Typically, it's best to use the BiquadFilterNode interface to implement higher-order filters. There are several reasons why:
/// - Biquad filters are typically less sensitive to numeric quirks.
/// - The filter parameters of biquad filters can be automated.
/// - All even-ordered IIR filters can be created using BiquadFilterNode.
///
/// However, if you need to create an odd-ordered IIR filter, you'll need to use IIRFilterNode.
/// You may also find this interface useful if you don't need automation, or for other reasons.
///
/// Note: Once the node has been created, you can't change its coefficients.
///
/// IIRFilterNodes have a tail-time reference; they continue to output non-silent audio with zero input.
/// As an IIR filter, the non-zero input continues forever,
/// but this can be limited after some finite time in practice, when the output has approached zero closely enough.
/// The actual time that takes depends on the filter coefficients provided.
class IirFilterNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory IirFilterNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory IirFilterNode(BaseAudioContext context, Map options) {
    var options_1 = convertDartToNative_Dictionary(options);
    return IirFilterNode._create_1(context, options_1);
  }
  static IirFilterNode _create_1(context, options) =>
      JS('IirFilterNode', 'new IIRFilterNode(#,#)', context, options);

  void getFrequencyResponse(Float32List frequencyHz, Float32List magResponse,
      Float32List phaseResponse) native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # MediaElementAudioSourceNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#MediaElementAudioSourceNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/MediaElementAudioSourceNode)
/// ----------------------------------------------------------------------------------------------------
/// The MediaElementAudioSourceNode interface represents an audio source consisting of an HTML5 <audio> or <video> element.
/// It is an AudioNode that acts as an audio source.
///
/// A MediaElementSourceNode has no inputs and exactly one output, and is created using the AudioContext.createMediaElementSource() method.
/// The amount of channels in the output equals the number of channels of the audio referenced by the HTMLMediaElement
/// used in the creation of the node, or is 1 if the HTMLMediaElement has no audio.
///
/// - Number of inputs	0
/// - Number of outputs	1
/// - Channel count
class MediaElementAudioSourceNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory MediaElementAudioSourceNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory MediaElementAudioSourceNode(BaseAudioContext context, Map options) {
    var options_1 = convertDartToNative_Dictionary(options);
    return MediaElementAudioSourceNode._create_1(context, options_1);
  }
  static MediaElementAudioSourceNode _create_1(context, options) => JS(
      'MediaElementAudioSourceNode',
      'new MediaElementAudioSourceNode(#,#)',
      context,
      options);

  MediaElement? get mediaElement native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # MediaStreamAudioDestinationNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#MediaStreamAudioDestinationNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamAudioDestinationNode)
/// ----------------------------------------------------------------------------------------------------
/// The MediaStreamAudioDestinationNode interface represents an audio destination
/// consisting of a WebRTC MediaStream with a single AudioMediaStreamTrack,
/// which can be used in a similar way to a MediaStream obtained from Navigator.getUserMedia().
///
/// It is an AudioNode that acts as an audio destination, created using the AudioContext.createMediaStreamDestination() method.
///
/// - Number of inputs	1
/// - Number of outputs	0
/// - Channel count	2
/// - Channel count mode	"explicit"
/// - Channel count interpretation	"speakers"
class MediaStreamAudioDestinationNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory MediaStreamAudioDestinationNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory MediaStreamAudioDestinationNode(BaseAudioContext context,
      [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return MediaStreamAudioDestinationNode._create_1(context, options_1);
    }
    return MediaStreamAudioDestinationNode._create_2(context);
  }
  static MediaStreamAudioDestinationNode _create_1(context, options) => JS(
      'MediaStreamAudioDestinationNode',
      'new MediaStreamAudioDestinationNode(#,#)',
      context,
      options);
  static MediaStreamAudioDestinationNode _create_2(context) => JS(
      'MediaStreamAudioDestinationNode',
      'new MediaStreamAudioDestinationNode(#)',
      context);

  MediaStream? get stream native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # MediaStreamAudioSourceNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#MediaStreamAudioSourceNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamAudioSourceNode)
/// ----------------------------------------------------------------------------------------------------
/// The MediaStreamAudioSourceNode interface is a type of AudioNode which operates as an audio source
/// whose media is received from a MediaStream obtained using the WebRTC or Media Capture and Streams APIs.
///
/// This media could be from a microphone (through getUserMedia())
/// or from a remote peer on a WebRTC call (using the RTCPeerConnection's audio tracks).
///
/// A MediaStreamAudioSourceNode has no inputs and exactly one output, and is created using the AudioContext.createMediaStreamSource() method.
///
/// The MediaStreamAudioSourceNode takes the audio from the first MediaStreamTrack whose kind attribute's value is audio.
/// See Track ordering for more information about the order of tracks.
///
/// The number of channels output by the node matches the number of tracks found in the selected audio track.
///
/// - Number of inputs	0
/// - Number of outputs	1
/// - Channel count	defined by the first audio MediaStreamTrack passed to the AudioContext.createMediaStreamSource() method that created it.
class MediaStreamAudioSourceNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory MediaStreamAudioSourceNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory MediaStreamAudioSourceNode(BaseAudioContext context, Map options) {
    var options_1 = convertDartToNative_Dictionary(options);
    return MediaStreamAudioSourceNode._create_1(context, options_1);
  }
  static MediaStreamAudioSourceNode _create_1(context, options) => JS(
      'MediaStreamAudioSourceNode',
      'new MediaStreamAudioSourceNode(#,#)',
      context,
      options);

  MediaStream? get mediaStream native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # OfflineAudioCompletionEvent
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#OfflineAudioCompletionEvent)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/OfflineAudioCompletionEvent)
/// ----------------------------------------------------------------------------------------------------
@deprecated
class OfflineAudioCompletionEvent extends Event {
  /*
  // To suppress missing implicit constructor warnings.
  factory OfflineAudioCompletionEvent._() {
    throw new UnsupportedError("Not supported");
  }

  factory OfflineAudioCompletionEvent(String type, Map eventInitDict) {
    var eventInitDict_1 = convertDartToNative_Dictionary(eventInitDict);
    return OfflineAudioCompletionEvent._create_1(type, eventInitDict_1);
  }
  static OfflineAudioCompletionEvent _create_1(type, eventInitDict) => JS(
      'OfflineAudioCompletionEvent',
      'new OfflineAudioCompletionEvent(#,#)',
      type,
      eventInitDict);

  AudioBuffer? get renderedBuffer native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # OfflineAudioContext
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#OfflineAudioContext)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/OfflineAudioContext)
/// ----------------------------------------------------------------------------------------------------
/// The OfflineAudioContext interface is an AudioContext interface
/// representing an audio-processing graph built from linked together AudioNodes.
/// In contrast with a standard AudioContext, an OfflineAudioContext doesn't render
/// the audio to the device hardware; instead, it generates it, as fast as it can, and outputs the result to an AudioBuffer.
class OfflineAudioContext extends BaseAudioContext {
  /*
  // To suppress missing implicit constructor warnings.
  factory OfflineAudioContext._() {
    throw new UnsupportedError("Not supported");
  }

  factory OfflineAudioContext(numberOfChannels_OR_options,
      [int? numberOfFrames, num? sampleRate]) {
    if ((sampleRate is num) &&
        (numberOfFrames is int) &&
        (numberOfChannels_OR_options is int)) {
      return OfflineAudioContext._create_1(
          numberOfChannels_OR_options, numberOfFrames, sampleRate);
    }
    if ((numberOfChannels_OR_options is Map) &&
        numberOfFrames == null &&
        sampleRate == null) {
      var options_1 =
          convertDartToNative_Dictionary(numberOfChannels_OR_options);
      return OfflineAudioContext._create_2(options_1);
    }
    throw new ArgumentError("Incorrect number or type of arguments");
  }
  static OfflineAudioContext _create_1(
          numberOfChannels_OR_options, numberOfFrames, sampleRate) =>
      JS('OfflineAudioContext', 'new OfflineAudioContext(#,#,#)',
          numberOfChannels_OR_options, numberOfFrames, sampleRate);
  static OfflineAudioContext _create_2(numberOfChannels_OR_options) => JS(
      'OfflineAudioContext',
      'new OfflineAudioContext(#)',
      numberOfChannels_OR_options);

  int? get length native;

  Future<AudioBuffer> startRendering() => promiseToFuture<AudioBuffer>(
      JS("creates:AudioBuffer;", "#.startRendering()", this));

  @JSName('suspend')
  Future suspendFor(num suspendTime) =>
      promiseToFuture(JS("", "#.suspend(#)", this, suspendTime));

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # OscillatorNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#OscillatorNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/OscillatorNode)
/// ----------------------------------------------------------------------------------------------------
/// The OscillatorNode interface represents a periodic waveform, such as a sine wave.
/// It is an AudioScheduledSourceNode audio-processing module that causes
/// a specified frequency of a given wave to be created—in effect, a constant tone.
///
/// - Number of inputs	0
/// - Number of outputs	1
/// - Channel count mode	max
/// - Channel count	2 (not used in the default count mode)
/// - Channel interpretation	speakers
class OscillatorNode extends AudioScheduledSourceNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory OscillatorNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory OscillatorNode(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return OscillatorNode._create_1(context, options_1);
    }
    return OscillatorNode._create_2(context);
  }
  static OscillatorNode _create_1(context, options) =>
      JS('OscillatorNode', 'new OscillatorNode(#,#)', context, options);
  static OscillatorNode _create_2(context) =>
      JS('OscillatorNode', 'new OscillatorNode(#)', context);

  AudioParam? get detune native;

  AudioParam? get frequency native;

  String? get type native;

  set type(String? value) native;

  void setPeriodicWave(PeriodicWave periodicWave) native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # PannerNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#PannerNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/PannerNode)
/// ----------------------------------------------------------------------------------------------------
/// The PannerNode interface represents the position and behavior of an audio source signal in space.
/// It is an AudioNode audio-processing module describing its position with right-hand Cartesian coordinates,
/// its movement using a velocity vector and its directionality using a directionality cone.
///
/// A PannerNode always has exactly one input and one output:
/// the input can be mono or stereo but the output is always stereo (2 channels);
/// you can't have panning effects without at least two audio channels!
///
/// The PannerNode brings a spatial position and velocity and a directionality for a given signal.
///
/// - Number of inputs	1
/// - Number of outputs	1
/// - Channel count mode	"clamped-max"
/// - Channel count	2
/// - Channel interpretation	"speakers"
class PannerNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory PannerNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory PannerNode(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return PannerNode._create_1(context, options_1);
    }
    return PannerNode._create_2(context);
  }
  static PannerNode _create_1(context, options) =>
      JS('PannerNode', 'new PannerNode(#,#)', context, options);
  static PannerNode _create_2(context) =>
      JS('PannerNode', 'new PannerNode(#)', context);

  num? get coneInnerAngle native;

  set coneInnerAngle(num? value) native;

  num? get coneOuterAngle native;

  set coneOuterAngle(num? value) native;

  num? get coneOuterGain native;

  set coneOuterGain(num? value) native;

  String? get distanceModel native;

  set distanceModel(String? value) native;

  num? get maxDistance native;

  set maxDistance(num? value) native;

  AudioParam? get orientationX native;

  AudioParam? get orientationY native;

  AudioParam? get orientationZ native;

  String? get panningModel native;

  set panningModel(String? value) native;

  AudioParam? get positionX native;

  AudioParam? get positionY native;

  AudioParam? get positionZ native;

  num? get refDistance native;

  set refDistance(num? value) native;

  num? get rolloffFactor native;

  set rolloffFactor(num? value) native;

  void setOrientation(num x, num y, num z) native;

  void setPosition(num x, num y, num z) native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # PeriodicWave
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#PeriodicWave)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/PeriodicWave)
/// ----------------------------------------------------------------------------------------------------
/// The PeriodicWave interface defines a periodic waveform that can be used to shape the output of an OscillatorNode.
///
/// PeriodicWave has no inputs or outputs; it is used to define custom oscillators when calling OscillatorNode.setPeriodicWave().
/// The PeriodicWave itself is created/returned by BaseAudioContext.createPeriodicWave.
class PeriodicWave extends JavaScriptObject {
  /*
  // To suppress missing implicit constructor warnings.
  factory PeriodicWave._() {
    throw new UnsupportedError("Not supported");
  }

  factory PeriodicWave(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return PeriodicWave._create_1(context, options_1);
    }
    return PeriodicWave._create_2(context);
  }
  static PeriodicWave _create_1(context, options) =>
      JS('PeriodicWave', 'new PeriodicWave(#,#)', context, options);
  static PeriodicWave _create_2(context) =>
      JS('PeriodicWave', 'new PeriodicWave(#)', context);

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # ScriptProcessorNode
/// ----------------------------------------------------------------------------------------------------
/// This class is specific on Flutter and does not have any correspondence in the W3C Recommandation
class ScriptProcessorNode extends AudioNode {
  // To suppress missing implicit constructor warnings.
  factory ScriptProcessorNode._() {
    throw new UnsupportedError("Not supported");
  }

  /**
   * Static factory designed to expose `audioprocess` events to event
   * handlers that are not necessarily instances of [ScriptProcessorNode].
   *
   * See [EventStreamProvider] for usage information.
   */
  static const EventStreamProvider<AudioProcessingEvent> audioProcessEvent =
      const EventStreamProvider<AudioProcessingEvent>('audioprocess');

  int? get bufferSize native;

  void setEventListener(EventListener eventListener) native;

  /// Stream of `audioprocess` events handled by this [ScriptProcessorNode].
/**
   * Get a Stream that fires events when AudioProcessingEvents occur.
   * This particular stream is special in that it only allows one listener to a
   * given stream. Converting the returned [Stream.asBroadcastStream] will
   * likely ruin the soft-real-time properties which which these events are
   * fired and can be processed.
   */
  Stream<AudioProcessingEvent> get onAudioProcess =>
      audioProcessEvent.forTarget(this);
}

/// ----------------------------------------------------------------------------------------------------
/// # StereoPannerNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#StereoPannerNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/StereoPannerNode)
/// ----------------------------------------------------------------------------------------------------
/// The StereoPannerNode interface of the Web Audio API represents a simple stereo panner node
/// that can be used to pan an audio stream left or right.
/// It is an AudioNode audio-processing module that positions an incoming audio stream
/// in a stereo image using a low-cost equal-power panning algorithm.
///
/// The pan property takes a unitless value between -1 (full left pan) and 1 (full right pan).
/// This interface was introduced as a much simpler way to apply a simple panning effect than having to use a full PannerNode.
///
/// - Number of inputs	1
/// - Number of outputs	1
/// - Channel count mode	"clamped-max"
/// - Channel count	2
/// - Channel interpretation	"speakers"
class StereoPannerNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory StereoPannerNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory StereoPannerNode(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return StereoPannerNode._create_1(context, options_1);
    }
    return StereoPannerNode._create_2(context);
  }
  static StereoPannerNode _create_1(context, options) =>
      JS('StereoPannerNode', 'new StereoPannerNode(#,#)', context, options);
  static StereoPannerNode _create_2(context) =>
      JS('StereoPannerNode', 'new StereoPannerNode(#)', context);

  AudioParam? get pan native;

   */
}

/// ----------------------------------------------------------------------------------------------------
/// # WaveShaperNode
/// - [see W3C Recommandation](https://www.w3.org/TR/webaudio/#WaveShaperNode)
/// - [see Mozilla documentation](https://developer.mozilla.org/en-US/docs/Web/API/WaveShaperNode)
/// ----------------------------------------------------------------------------------------------------
/// The WaveShaperNode interface represents a non-linear distorter.
///
/// It is an AudioNode that uses a curve to apply a wave shaping distortion to the signal.
/// Beside obvious distortion effects, it is often used to add a warm feeling to the signal.
///
/// A WaveShaperNode always has exactly one input and one output.
///
/// - Number of inputs	1
/// - Number of outputs	1
/// - Channel count mode	"max"
/// - Channel count	2 (not used in the default count mode)
/// - Channel interpretation	"speakers"
class WaveShaperNode extends AudioNode {
  /*
  // To suppress missing implicit constructor warnings.
  factory WaveShaperNode._() {
    throw new UnsupportedError("Not supported");
  }

  factory WaveShaperNode(BaseAudioContext context, [Map? options]) {
    if (options != null) {
      var options_1 = convertDartToNative_Dictionary(options);
      return WaveShaperNode._create_1(context, options_1);
    }
    return WaveShaperNode._create_2(context);
  }
  static WaveShaperNode _create_1(context, options) =>
      JS('WaveShaperNode', 'new WaveShaperNode(#,#)', context, options);
  static WaveShaperNode _create_2(context) =>
      JS('WaveShaperNode', 'new WaveShaperNode(#)', context);

  Float32List? get curve native;

  set curve(Float32List? value) native;

  String? get oversample native;

  set oversample(String? value) native;
  
   */
}
