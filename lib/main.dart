import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:para/src/loginScreen/loginScreen.dart';
import 'package:para/src/main_app/app_view.dart';
import 'package:para/src/temp/damy_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => debugPrint("firebase done"));

  saveDataToFierbase();

  runApp(const AppView());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Center(
            child: Text('Could not load app'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Phone Verification',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Colors.blue,
                primarySwatch: Colors.blue,
                inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.grey)),
                backgroundColor: Colors.white),
            home: const LoginScreen(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  )
                ],
              )
            ]);
      },
    );
  }
}
