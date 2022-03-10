#include "include/taudio_waa/taudio_waa_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "taudio_waa_plugin.h"

void TaudioWaaPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  taudio_waa::TaudioWaaPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
