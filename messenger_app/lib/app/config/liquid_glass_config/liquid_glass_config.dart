import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';


class LiquidGlassBaseConfig extends LiquidGlassSettings {
  LiquidGlassBaseConfig() : super (
    thickness: 12.0,
    lightIntensity: 0,
    refractiveIndex: 1.1,
    ambientStrength: 1,
    blur: 2.5,
    blend: 50,
    saturation: 1,
  );
}