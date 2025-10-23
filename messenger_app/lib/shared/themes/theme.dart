import 'package:flutter/material.dart';

class MessengerColors extends ThemeExtension<MessengerColors> {
  final Color userBubble;
  final Color friendBubble;
  final Color chatBackground;
  final Color timestamp;

  const MessengerColors({
    required this.userBubble,
    required this.friendBubble,
    required this.chatBackground,
    required this.timestamp,
  });

  @override
  MessengerColors copyWith({
    Color? userBubble,
    Color? friendBubble,
    Color? chatBackground,
    Color? timestamp,
  }) {
    return MessengerColors(
      userBubble: userBubble ?? this.userBubble,
      friendBubble: friendBubble ?? this.friendBubble,
      chatBackground: chatBackground ?? this.chatBackground,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  MessengerColors lerp(ThemeExtension<MessengerColors>? other, double t) {
    if (other is! MessengerColors) return this;
    return MessengerColors(
      userBubble: Color.lerp(userBubble, other.userBubble, t)!,
      friendBubble: Color.lerp(friendBubble, other.friendBubble, t)!,
      chatBackground: Color.lerp(chatBackground, other.chatBackground, t)!,
      timestamp: Color.lerp(timestamp, other.timestamp, t)!,
    );
  }
}

class AppTheme {
  static const Color _primary = Color(0xFF809F73);
  static const Color _secondary = Color(0xFF9EBE8C);
  static const Color _errorLight = Color(0xFFD9534F);
  static const Color _errorDark = Color(0xFFFF6B6B);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.light,
      secondary: _secondary,
      error: _errorLight,
    ),
    // override component-specific themes if нужно
    appBarTheme: const AppBarTheme(
      surfaceTintColor: null,
      elevation: 0,
    ),
    scaffoldBackgroundColor: null, // позволяет использовать surface по умолчанию
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _primary),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(),
      bodyMedium: TextStyle(),
      labelLarge: TextStyle(),
    ),
    extensions: <ThemeExtension<dynamic>>[
      const MessengerColors(
        userBubble: _primary,
        friendBubble: Color(0xFFEFEFEF),
        chatBackground: Color(0xFFF7F8F5),
        timestamp: Colors.grey,
      ),
    ],
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.dark,
      secondary: _secondary,
      error: _errorDark,
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: null,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E201E),
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2F312F)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _primary),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(),
      bodyMedium: TextStyle(),
      labelLarge: TextStyle(),
    ),
    extensions: <ThemeExtension<dynamic>>[
      const MessengerColors(
        userBubble: _primary,
        friendBubble: Color(0xFF2E2E2E),
        chatBackground: Color(0xFF101210),
        timestamp: Colors.grey,
      ),
    ],
  );
}
