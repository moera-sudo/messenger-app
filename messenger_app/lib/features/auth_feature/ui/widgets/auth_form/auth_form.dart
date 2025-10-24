// lib/features/auth_feature/presentation/widgets/auth_form.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';

class AuthForm extends StatefulWidget {
  final bool isLoginMode;
  final VoidCallback onToggleMode;

  const AuthForm({
    required this.isLoginMode,
    required this.onToggleMode,
    super.key,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController(); // Только для регистрации
  final _passwordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final authBloc = context.read<AuthBloc>();
      if (widget.isLoginMode) {
        authBloc.add(AuthLoginRequested(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        ));
      } else {
        authBloc.add(AuthRegisterRequested(
          username: _usernameController.text.trim(),
          name: _nameController.text.trim(),
          password: _passwordController.text.trim(),
        ));
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Заголовок
          Text(
            widget.isLoginMode ? 'Welcome Back' : 'Create Account',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Поле "Имя" (только для регистрации)
          if (!widget.isLoginMode)
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your name' : null,
            ),
          if (!widget.isLoginMode) const SizedBox(height: 16),

          // Поле "Имя пользователя"
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
            validator: (value) =>
                value!.isEmpty ? 'Please enter a username' : null,
          ),
          const SizedBox(height: 16),

          // Поле "Пароль"
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 4) {
                return 'Password must be at least 4 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Кнопка "Войти" / "Зарегистрироваться"
          // BlocBuilder слушает состояние, чтобы показывать индикатор загрузки
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.isLoginMode ? 'Login' : 'Register'),
              );
            },
          ),
          const SizedBox(height: 16),

          // Кнопка переключения режимов
          TextButton(
            onPressed: widget.onToggleMode,
            child: Text(
              widget.isLoginMode
                  ? 'Don\'t have an account? Register'
                  : 'Already have an account? Login',
            ),
          ),
        ],
      ),
    );
  }
}