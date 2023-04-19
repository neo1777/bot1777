import 'package:bot1777/components/mini_menu.dart';
import 'package:bot1777/models/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:bot1777/models/balance_model.dart';
import 'package:get/get.dart';
import 'package:bot1777/components/coin_list_tile.dart';

class HomePage extends StatefulWidget {
  static const route = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<CoinModel> coins = [];

  @override
  initState() {
    balanceModel.value.getBalance();
    //balanceModel.value.getSymbolUser();
    //balanceModel.value.getUpdateUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return Obx(() {
      print('GridView obx');
      var coins = balanceModel.value.coins;

      return Column(
        children: [
          Expanded(
            flex: 30,
            child: GridView.builder(
              shrinkWrap: false,
              padding: const EdgeInsets.fromLTRB(32, 24, 32, 32),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: coins.length,
              itemBuilder: (context, index) {
                return CoinListTile(
                  coinBalance: coins[index],
                );
              },
            ),
          ),
          Spacer(),
          MiniMenu(context: context),
          SizedBox(
            height: 16,
          ),
        ],
      );
    });
  }

  @override
  void dispose() {
    //storeModel.value.stream.cancel();
    super.dispose();
  }
}
