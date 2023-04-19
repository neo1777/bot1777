import 'package:binance_spot/binance_spot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bot1777/repositories/binance_repository.dart';
import 'package:bot1777/models/coin_model.dart';

final balanceModel = BalanceModel().obs;
final streamModel = StreamModel().obs;

class BalanceModel {
  List<CoinModel> coins = [];

  BinanceRepository binanceRepository = BinanceRepository();

  Future<void> initialize() async {
    await binanceRepository.initialize();
  }

  Future<void> getBalance() async {
    print('getBalance');
    coins = await binanceRepository.getCoinList();
    for (var element in coins) {
      streamModel.value.getSymbolUser(element.symbol);
    }

    balanceModel.refresh();
  }

  Future<void> getUpdateUser() async {
    print('getUpdateUser');
    final stream = await binanceRepository.getUserDataStream();
    stream.listen((event) {
      print(event.runtimeType);
      balanceModel.refresh();
    });
  }
}

class StreamModel {
  WsTicker? ticker;

  Future<void> getSymbolUser(String symbol) async {
    print('getSymbolUser');
    // for (var element in coins) {
    //   await Future.delayed(const Duration(seconds: 1));
    //   print(element.symbol);
    //   stream = await binanceRepository.getTickerStream('${element.symbol}usdt');
    // }
    await Future.delayed(const Duration(seconds: 1));
    var stream = await balanceModel.value.binanceRepository
        .getTickerStream('${symbol}usdt');
    stream.listen((WsTicker event) {
      ticker = event;
      //print(ticker!.symbol);
      streamModel.refresh();
    });
  }

  bool hasPurchased = false;
  double purchaseQuantity = 0;

  void _simulateTrade(WsTicker ticker) {
    if (!hasPurchased && ticker.prichePercentChange <= -1) {
      double purchasePrice = ticker.bestAsk;
      double purchaseAmount = 10;
      purchaseQuantity = purchaseAmount / purchasePrice;
      hasPurchased = true;
    }

    if (hasPurchased) {
      double salePrice = ticker.bestBid;
      double saleAmount = purchaseQuantity * salePrice;
      double profit = saleAmount - 10;

      if (profit >= 1) {
        print(
            "Trade effettuato con successo! Profitto: \$${profit.toStringAsFixed(2)}");
        hasPurchased =
            false; // Resetta il flag di acquisto per future simulazioni
        purchaseQuantity = 0; // Resetta il valore di purchaseQuantity
      }
    }
  }
}
