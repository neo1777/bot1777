import 'package:bot1777/pages/home_page.dart';
import 'package:bot1777/pages/option_page.dart';
import 'package:flutter/material.dart';

class MiniMenu extends StatelessWidget {
  const MiniMenu({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Colors.grey.shade800,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              child: IconButton(
                alignment: Alignment.center,
                onPressed: () => Navigator.pushNamed(context, HomePage.route),
                icon: Icon(Icons.home),
                iconSize: 24,
                visualDensity: VisualDensity.compact,
              ),
            ),
            FittedBox(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.precision_manufacturing_outlined),
                iconSize: 24,
                visualDensity: VisualDensity.compact,
              ),
            ),
            FittedBox(
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, OptionPage.route),
                icon: Icon(Icons.settings),
                iconSize: 24,
                visualDensity: VisualDensity.compact,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            FittedBox(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.density_medium_outlined),
                iconSize: 24,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
