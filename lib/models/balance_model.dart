import 'package:binance_spot/binance_spot.dart';
import 'package:get/get.dart';

import 'package:bot1777/models/coin_model.dart';
import 'package:bot1777/repositories/binance_repository.dart';

final balanceModel = BalanceModel().obs;
final streamModel = StreamModel().obs;

class BalanceModel {
  List<CoinModel> coins = [];

  BinanceRepository binanceRepository = BinanceRepository();

  Future<void> initialize() async {
    await binanceRepository.initialize();
  }

  Future<void> getBalance() async {
    coins = await binanceRepository.getCoinList();
    for (var element in coins) {
      streamModel.value.getSymbolUser(element.symbol);
    }

    balanceModel.refresh();
  }

  Future<void> getUpdateUser() async {
    final stream = await binanceRepository.getUserDataStream();
    stream.listen((event) {
      balanceModel.refresh();
    });
  }
}

class StreamModel {
  WsTicker? ticker;

  Future<void> getSymbolUser(String symbol) async {
    await Future.delayed(const Duration(seconds: 1));
    var stream = await balanceModel.value.binanceRepository
        .getTickerStream('${symbol}usdt');
    stream.listen((WsTicker event) {
      ticker = event;
      streamModel.refresh();
    });
  }

  bool hasPurchased = false;
  double purchaseQuantity = 0;

}
