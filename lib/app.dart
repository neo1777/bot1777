import 'package:bot1777/models/balance_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bot1777/pages/home_page.dart';
import 'package:bot1777/pages/option_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: () async {
        await balanceModel.value.initialize();
      },
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: HomePage.route,
      onGenerateRoute: ((settings) {
        final pageBuilder = {
          HomePage.route: ((_) => const HomePage()),
          OptionPage.route: ((_) => const OptionPage()),
        }[settings.name];
        return MaterialPageRoute(builder: pageBuilder!);
      }),
    );
  }
}
