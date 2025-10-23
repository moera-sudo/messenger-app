// lib/app.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'DI/service_locator.dart';
import '../features/home_feature/home_view.dart';
import 'navigation/app_router.dart';
import '../shared/widgets/AppBar/app_bar.dart'; 
import '../shared/widgets/BottomNavBar/nav_bar.dart'; 

import '../shared/theme_view.dart';

/// Главный виджет приложения, который инициализирует роутер.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter appRouter = sl<AppRouter>().router;

    return MaterialApp.router(
      title: 'TeaChats',
      themeMode: ThemeMode.dark,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,  
      
      debugShowCheckedModeBanner: false,
      
      // Передаем конфигурацию роутера в приложение
      routerConfig: appRouter,
    );
  }
}


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BlocProvider(
      // Создаем экземпляр HomeBloc через GetIt и сразу же
      // отправляем событие для загрузки данных.
      create: (context) => sl<HomeBloc>()..add(HomeLoadChats()),
      child: const HomeScreen(),
    ),
    const _PlaceholderScreen(title: 'Calls', icon: Icons.call_outlined),
    const _PlaceholderScreen(title: 'Games', icon: Icons.gamepad_outlined),
    
    const _PlaceholderScreen(title: 'Settings', icon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      

      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: kToolbarHeight - 16),
            child: _pages[_currentIndex],),
          


          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    scaffoldBackgroundColor.withValues(alpha: 0.0),
                    scaffoldBackgroundColor,
                  ],
                  stops: const [0.0, 0.8]
                ),
              ),
            )),

          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigation(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBarWidget())
        ],
      ),
    );
  }
}


/// Вспомогательный виджет-заглушка для нереализованных экранов.
class _PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const _PlaceholderScreen({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.grey.withOpacity(0.8)
            ),
          ),
        ],
      ),
    );
  }
}