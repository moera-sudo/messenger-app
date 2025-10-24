import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'DI/service_locator.dart';
import 'navigation/app_router.dart';

import '../features/home_feature/home_view.dart';
import '../features/auth_feature/auth_view.dart';

import '../shared/widgets/AppBar/app_bar.dart'; 
import '../shared/widgets/BottomNavBar/nav_bar.dart'; 
import '../shared/widgets/Placeholder/placeholder_screen.dart';
import '../shared/theme_view.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter appRouter = sl<AppRouter>().router;



    return MultiBlocProvider(
      providers: [
        // 1. Глобальный AuthBloc, который будет жить всегда.
        // Он сразу же запускает проверку статуса аутентификации.
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>()..add(AuthCheckStatusRequested()),
        ),
        
        // 2. Глобальный HomeBloc. Мы можем предоставить его здесь,
        // а не в MainScreen, если он понадобится в других частях приложения.
        BlocProvider<HomeBloc>(
          create: (context) => sl<HomeBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'TeaChats',
        themeMode: ThemeMode.dark,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
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
    const HomeScreen(),
    const PlaceholderScreen(title: 'Wallet', icon: Icons.wallet),
    const PlaceholderScreen(title: 'Games', icon: Icons.gamepad),
    const PlaceholderScreen(title: 'Settings', icon: Icons.person),
  ];

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeLoadChats());
  }

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