import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gojo_renthub/Myproperty/bloc/property_bloc.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/Profile/user_provider/user_provider.dart';
import 'package:gojo_renthub/controllers/theme_provider/theme_provider.dart';
import 'package:gojo_renthub/routes/routes.dart';
import 'package:gojo_renthub/views/screens/auth/authpage.dart';
import 'package:gojo_renthub/views/screens/tabs/bloc/favorite_bloc.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Chapa.configure(privateKey: "CHASECK_TEST-S6Y7XQhsRMWfHvykP7vbSRdX9067HMPQ");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        BlocProvider(
          create: (context) => PropertyBloc(repo: MyPropertyRepo()),
        ),
        BlocProvider(
          create: ((context) => FavoriteBloc()),
        ),
        // BlocProvider(
        //   create: ((context) => WelcomeBloc()..add(WelcomeEvent())),
        //   child: const Welcome(),
        // ),
        Provider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: const MyApp(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

// 703797823
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const AuthPage(),
      initialRoute: RouteClass.getSplash(),
      getPages: RouteClass.routes,
    );
  }
}
