import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: ((context) => AuthScreen())),
        Provider(create: (context) => ChatScreen())
      ],
      child: MaterialApp(
          title: 'Chat App',
          theme: ThemeData(
              primarySwatch: Colors.grey,
              backgroundColor: Colors.pinkAccent[100],
              // colorScheme: const ColorScheme(
              //     brightness: Brightness.dark,
              //     primary: Colors.grey,
              //     onPrimary: Colors.pink,
              //     secondary: Colors.yellow,
              //     onSecondary: Colors.orange,
              //     error: Colors.red,
              //     onError: Colors.purple,
              //     background: Colors.blueGrey,
              //     onBackground: Colors.lightBlue,
              //     surface: Colors.grey,
              //     onSurface: Colors.indigoAccent),
              // copywith ....
              buttonTheme:
                  ButtonTheme.of(context).copyWith(buttonColor: Colors.pink)),
          home: StreamBuilder<User?>(
            // modifed to user? ..
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return const ChatScreen();
              } else {
                return const AuthScreen();
              }
            },
          )),
    );
  }
}
