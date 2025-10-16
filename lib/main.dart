//import 'package:cartify/views/screens/authentication_screen/login_screen.dart';
import 'package:cartify/controllers/auth_controller.dart';
import 'package:cartify/global_variables.dart';
import 'package:cartify/provider/user_provider.dart';
import 'package:cartify/views/screens/authentication_screen/login_screen.dart';
import 'package:cartify/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future <void> main() async {
  // ensure flutter binding is initialized before any other setup
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;

  await Stripe.instance.applySettings();
  
  // run the flutter app wrapped in a providerScope for managing state
  await dotenv.load();
  runApp(ProviderScope(child: const MyApp()));
}

// root widget to the app,  a consumerWidget to consume state changes
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // methode to check the token and set the user data if available
  Future <void> _checkTokenAndSetUser(context,WidgetRef ref)async{
    // // obtain a instance of shared preffences for local data storage
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // // retrive the user auth token and user data stored locally
    // String? token = preferences.getString('auth_token');
    // String? userJson = preferences.getString('user');
    // // if both token and user data available, update the user state
    // if(token != null && userJson != null){
    //   ref.read(userProvider.notifier).setUser(userJson);
    // }
    // else{
    //   ref.read(userProvider.notifier).signOut();
    // }
    await AuthController().getUserData(context, ref);
    ref.watch(userProvider);
    
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder(
        future: _checkTokenAndSetUser(context,ref),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          final user = ref.watch(userProvider);
          return user!.token.isNotEmpty ? MainScreen() : LoginScreen();
        },
      ),
    );
  }
}