
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import '../../theme_view.dart';

part 'nav_bar_item.dart';



class BottomNavigation extends StatelessWidget{
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(
        left: 45,
        right: 45,
        bottom: 80
      ),
      child: SizedBox(
        height: 65,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(64),
          child: LiquidGlass(
            shape: LiquidRoundedSuperellipse(borderRadius: Radius.circular(64)),
            settings: LiquidGlassSettings(
              thickness: 12.0,
              // glassColor: Color.fromARGB(51, 0, 0, 0),
              lightIntensity: 0,
              refractiveIndex: 1.1,
              ambientStrength: 1,
              blur: 2.5,
              blend: 50,
              saturation: 1,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width - 32,
              height: 72,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 20,
                    offset: Offset(0, 8)
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(icon: Icons.chat, isActive: currentIndex == 0, onTap: () => onTap(0)),
                  _NavItem(icon: Icons.wallet, isActive: currentIndex == 1, onTap: () => onTap(1)),
                  _NavItem(icon: Icons.gamepad, isActive: currentIndex == 2, onTap: () => onTap(2)),
                  _NavItem(icon: Icons.person, isActive: currentIndex == 3, onTap: () => onTap(3)),
                ],
              ),
            ),
             ),
        ),
      ) 
  );}
}

