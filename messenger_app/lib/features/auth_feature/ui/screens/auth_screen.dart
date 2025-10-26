// lib/features/auth_feature/presentation/screens/auth_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/auth_form/auth_form.dart';

import '../../../../app/config/liquid_glass_config/liquid_glass_config.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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

          if (state is AuthRegisterSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Registration successful! Please log in.'),
                  backgroundColor: Colors.green,
                ),
              );
            // Автоматически переключаем форму обратно в режим входа
            _toggleMode(); 
          }

        },
        child: Container(
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
                    shape: LiquidRoundedSuperellipse(
                        borderRadius: const Radius.circular(32)),
                        settings: LiquidGlassBaseConfig(),
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