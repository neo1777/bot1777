import 'package:bot1777/models/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:bot1777/models/balance_model.dart';
import 'package:get/get.dart';
import 'package:bot1777/components/coin_list_tile.dart';
import 'package:bot1777/components/mini_menu.dart';
import 'package:settings_ui/settings_ui.dart';

class OptionPage extends StatefulWidget {
  static const route = '/option';

  const OptionPage({Key? key}) : super(key: key);

  @override
  OptionPageState createState() => OptionPageState();
}

class OptionPageState extends State<OptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return Column(
      children: [
        Expanded(
          flex: 30,
          child: SettingsList(
            platform: DevicePlatform.linux,
            sections: [
              SettingsSection(
                title: Text('Common'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    leading: Icon(Icons.language),
                    title: Text('Language'),
                    value: Text('English'),
                  ),
                  SettingsTile.switchTile(
                    onToggle: (value) {
                      setState(() {});
                    },
                    onPressed: (context) {
                      //print(value);
                    },
                    initialValue: true,
                    leading: Icon(Icons.format_paint),
                    title: Text('Enable custom theme'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Spacer(),
        MiniMenu(context: context),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  @override
  void dispose() {
    //storeModel.value.stream.cancel();
    super.dispose();
  }
}
