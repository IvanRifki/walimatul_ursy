import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:walimatul_ursy/pages/ourwedding.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(IvanMiniApp());
}

class IvanMiniApp extends StatefulWidget {
  @override
  State<IvanMiniApp> createState() => _IvanMiniAppState();
}

class _IvanMiniAppState extends State<IvanMiniApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // <-- warna status bar
      statusBarIconBrightness:
          Brightness.dark, // <-- warna ikon status bar (dark = ikon hitam)
    ));
  }

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter(
      routes: [
        // GoRoute(
        //   path: '/',
        //   builder: (context, state) => MiniAppScreen(),
        // ),
        //langsung diarahin ke halaman wedding
        // GoRoute(
        //   path: '/',
        //   builder: (context, state) => InvitationPage(guestName: 'nvBM78v6'),
        // ),

        // WEDDING SECTION START
        GoRoute(
          path: '/:guestName',
          builder: (context, state) => InvitationPage(
            guestName: state.pathParameters['guestName']!,
          ),
        ),
        // GoRoute(
        //   path: '/:guestName',
        //   builder: (context, state) => InvitationPage(
        //     guestName: state.pathParameters['guestName']!,
        //   ),
        // ),
      ],
    );

    return MaterialApp.router(
      title: "Walimatul 'Ursy",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}
