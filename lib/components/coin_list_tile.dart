// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:binance_spot/binance_spot.dart';
import 'package:bot1777/models/balance_model.dart';
import 'package:flutter/material.dart';

import 'package:bot1777/models/coin_model.dart';
import 'package:get/get.dart';

class CoinListTile extends StatelessWidget {
  final CoinModel coinBalance;
  const CoinListTile({
    Key? key,
    required this.coinBalance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('CoinListTile');

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.grey.shade800,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '${coinBalance.symbol}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w500,
              ),
            ),
            AutoSizeText(
              '${coinBalance.qty}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            RealTimePrice(
              coinBalance: coinBalance,
            ),
          ],
        ),
      ),
    );
  }
}

class RealTimePrice extends StatelessWidget {
  final CoinModel coinBalance;

  const RealTimePrice({
    super.key,
    required this.coinBalance,
  });

  @override
  Widget build(BuildContext context) {
    double price = 0;
    double priceOld = 0;
    String simbolo = '';
    Color color = Colors.white;
    return Obx(() {
      if (streamModel.value.ticker != null &&
          streamModel.value.ticker!.symbol.startsWith(coinBalance.symbol)) {
        simbolo = streamModel.value.ticker!.symbol;
        priceOld = streamModel.value.ticker!.priceChange;
        price = streamModel.value.ticker!
            .prichePercentChange; //(streamModel.value.ticker!.bestBid * coinBalance.qty);
        // if (price > priceOld) {
        //   color = Colors.green;
        //   priceOld = price;
        // } else {
        //   color = Colors.red;
        //   priceOld = price;
        // }
      }
      return Column(
        children: [
          AutoSizeText(
            '${simbolo}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          AutoSizeText(
            '${priceOld.toStringAsFixed(3)} - ${price.toStringAsFixed(3)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      );
    });
  }
}
