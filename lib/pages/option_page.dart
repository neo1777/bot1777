import 'package:flutter/material.dart';
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
                title: const Text('Common'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    leading: const Icon(Icons.language),
                    title: const Text('Language'),
                    value: const Text('English'),
                  ),
                  SettingsTile.switchTile(
                    onToggle: (value) {
                      setState(() {});
                    },
                    onPressed: (context) {
                      //print(value);
                    },
                    initialValue: true,
                    leading: const Icon(Icons.format_paint),
                    title: const Text('Enable custom theme'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        MiniMenu(context: context),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
