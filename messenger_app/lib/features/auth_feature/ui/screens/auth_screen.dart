// lib/features/auth_feature/presentation/screens/auth_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/auth_form/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Переменная для переключения между режимами "Вход" и "Регистрация"
  bool _isLoginMode = true;

  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // Используем BlocListener для "побочных эффектов": показа SnackBar'ов
      // Навигацией занимается GoRouter, поэтому здесь ее нет
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: theme.colorScheme.error,
                ),
              );
          }
        },
        child: Container(
          // Фоновый градиент или изображение для лучшего эффекта стекла
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: size.width > 500 ? 500 : size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: LiquidGlass(
                    // Настройки, похожие на ваш BottomNavigation
                    shape: LiquidRoundedSuperellipse(
                        borderRadius: const Radius.circular(32)),
                        
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
                    // Основной контент формы
                    child: Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: AuthForm(
                        isLoginMode: _isLoginMode,
                        onToggleMode: _toggleMode,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}