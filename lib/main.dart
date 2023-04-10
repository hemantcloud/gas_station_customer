import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gas_station_customer/firebase_options.dart';
import 'package:gas_station_customer/views/home/notification.dart';
import 'package:gas_station_customer/views/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// Firebase ........................
FirebaseMessaging messaging = FirebaseMessaging.instance;
String? fcmToken;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  playSound: true,
  importance: Importance.high,
);
String? payload;


final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");


/// Background Handler Services................
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  routeToGo = '/notification';
  navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (_) => NotificationScreen(status: "notification",)));
}



/// Select Notification to open app......................
Future<void> selectNotification(String? payload) async {

  print("selectNotification");
  //  routeToGo = '/';
  routeToGo = '/notification';
  navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
      builder: (_) => NotificationScreen(status: "notification",)));

}
late String routeToGo = '/';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = await FirebaseMessaging.instance.getToken();
  prefs.setString("fcmToken", token.toString());
  fcmToken = token.toString();
  print("FCM token is -------------------$token");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);


  /// Forground services...................
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // initialize notification for android
  var initialzationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings =
  InitializationSettings(android: initialzationSettingsAndroid,iOS: IOSInitializationSettings());
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: selectNotification);
  ///
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  /// OnMessage Notification..............
  OnMessageNotification(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("------------------------------------------data");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            payload: "Test",
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.orange,
                playSound: true,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: "@mipmap/ic_launcher",
              ),
            ));
      }
    });
  }

  OnMessageOpenApp(BuildContext context){
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print("Title>>>${notification.title.toString()}");
        routeToGo = '/notification';
        setState(() {});
        navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (_) => NotificationScreen(status: "notification",)));
        //
        // Future.delayed(Duration(seconds: 0),(){
        //   showDialog(
        //       context: context,
        //       builder: (_) {
        //         return AlertDialog(
        //           title: Text(notification.title.toString()),
        //           content: SingleChildScrollView(
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [Text(notification.body.toString())],
        //             ),
        //           ),
        //         );
        //       });
        // });
      }
    });
  }
  notificationInitialization() async {
    print("notificationInitialization run ----------------------------");
    var initializationSettingsAndroid = new AndroidInitializationSettings('ic_launcher');
    var initialzationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: initialzationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: selectNotification);
  }

  @override
  initState()  {
    // TODO: implement initState
    super.initState();

    notificationInitialization();

    /// On message method call............
    OnMessageNotification();

    /// On message Open app method call............
    OnMessageOpenApp(context);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Gas Station Customer',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      initialRoute: (routeToGo != null) ? routeToGo : '/',
    // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    onGenerateRoute: (RouteSettings settings) {
      switch (settings.name) {
        case '/':
          return MaterialPageRoute(
            builder: (_) => const SplashScreen(),
          );
          break;
        case '/notification':
          return MaterialPageRoute(
            builder: (_) => NotificationScreen(status: "notification",),
          );
          break;
        default:
          return _errorRoute();
      }
    }
      // home: Success(merchanId: "3", profileImage: "", name: "name"),
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Align(
                    child: Container(
                      width: 150,
                      height: 150,
                      child: const Icon(
                        Icons.delete_forever,
                        size: 48,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                          strokeWidth: 4, value: 1.0
                        // valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Page Not Found'),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Press back button on your phone',
                style: TextStyle(color: Color(0xff39399d), fontSize: 28),
              ),
              const SizedBox(
                height: 20,
              ),
              /*ElevatedButton(
                    onPressed: () {
                      Navigator.pop();
                      return;
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.orange),
                    ),
                    child: const Text('Back to home'),
                  ),*/
            ],
          ),
        ),
      );
    });
  }
}