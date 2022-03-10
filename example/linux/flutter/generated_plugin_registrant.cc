//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <taudio_waa/taudio_waa_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) taudio_waa_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "TaudioWaaPlugin");
  taudio_waa_plugin_register_with_registrar(taudio_waa_registrar);
}
