// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organizer_client/app/core/user/data/database/user_local_database.dart';
import 'package:organizer_client/app/features/home/presentation/bindings/home_binding.dart';
import 'package:organizer_client/app/features/register/presentation/bindings/register_binding.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/theme/theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final localDb = Get.put(UserLocalDatabaseImpl());
  final bool isAuthenticated = await localDb.authStatus();
  await GetStorage.init('theme');
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (_) => MyApp(
      isAuthenticated: isAuthenticated,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.isAuthenticated,
  }) : super(key: key);

  final bool isAuthenticated;

  @override
  Widget build(BuildContext context) {
    GetStorage themeStore = GetStorage('theme');
    final isDarkMode = themeStore.read('isDarkMode') ?? Get.isDarkMode;
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Organizer Client',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: isAuthenticated ? AppRoutes.HOME : AppRoutes.REGISTER,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      getPages: AppPages.pages,
      initialBinding: isAuthenticated ? HomeBinding() : RegisterBinding(),
      defaultTransition: Transition.cupertino,
    );
  }
}
