#ifndef FLUTTER_PLUGIN_TAUDIO_WAA_PLUGIN_H_
#define FLUTTER_PLUGIN_TAUDIO_WAA_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace taudio_waa {

class TaudioWaaPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  TaudioWaaPlugin();

  virtual ~TaudioWaaPlugin();

  // Disallow copy and assign.
  TaudioWaaPlugin(const TaudioWaaPlugin&) = delete;
  TaudioWaaPlugin& operator=(const TaudioWaaPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace taudio_waa

#endif  // FLUTTER_PLUGIN_TAUDIO_WAA_PLUGIN_H_
