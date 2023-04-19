/*import 'package:binance_spot/binance_spot.dart';
import 'package:bot1777/models/coin_model.dart';
import 'package:either_dart/either.dart';

class BinanceRepository {
  late BinanceSpot binanceSpot;

  Future all() async {
    String key =
        "ge0S2hecH7MGo2GNuRcyIeuFXKoaG0ISZBFhnfHkKoetNkLYQVfRVXePMIHR32hR";
    String secret =
        "4h0nLzS95XLl8Ab3ly5auHeVEaNlGi8PpfpdcmgDA1aLgTaurp8JbMNSS8LWnuSe";

    binanceSpot = BinanceSpot(key: key, secret: secret);
  }

  Future<List<CoinModel>> getBalance() async {
    Either<String, AccountInfo> response =
        await binanceSpot.accountInformation();
    List<CoinModel> cassa = [];
    if (response.isRight) {
      for (var element in response.right.balances) {
        if (element.free > 0.0) {
          var value = null;
          cassa.add(CoinModel(
            symbol: element.asset,
            qty: element.free,

            // priceAsk: value == null ? 0 : value.bestAsk,
            // priceBid: value == null ? 0 : value.bestBid,
          ));
        }
      }
      //return response.right;
    } else {
      print('ERROR: ${response.left}');
    }
    return cassa;
  }

  Future<List<Symbol>> _getTradablePairs() async {
    List<Symbol> tradablePairs = [];

    var response = await binanceSpot.exchangeInfo();
    if (response.isRight) {
      tradablePairs = response.right.symbols;
    }
    return tradablePairs;
  }
}
*/

import 'package:binance_spot/binance_spot.dart';
import 'package:bot1777/models/coin_model.dart';
import 'package:either_dart/either.dart';

class BinanceRepository {
  late final BinanceSpot binanceSpot;

  Future<void> initialize() async {
    const apiKey =
        "ge0S2hecH7MGo2GNuRcyIeuFXKoaG0ISZBFhnfHkKoetNkLYQVfRVXePMIHR32hR";
    const apiSecret =
        "4h0nLzS95XLl8Ab3ly5auHeVEaNlGi8PpfpdcmgDA1aLgTaurp8JbMNSS8LWnuSe";

    binanceSpot = BinanceSpot(key: apiKey, secret: apiSecret);
  }

  Future<List<CoinModel>> getCoinList() async {
    final response = await binanceSpot.accountInformation();
    final coinList = <CoinModel>[];

    if (response.isRight) {
      for (final element in response.right.balances) {
        if (element.free > 0.0) {
          coinList.add(CoinModel(
            symbol: element.asset,
            qty: element.free,
          ));
        }
      }
    } else {
      throw Exception('Error getting account information: ${response.left}');
    }

    return coinList;
  }

  Future<Stream> getUserDataStream() async {
    String listenKey = '';
    final keyresult = await binanceSpot.createListenKey();
    if (keyresult.isRight) {
      listenKey = keyresult.right;
    } else {
      print('key KO: ${keyresult.left}');
    }
    final response = binanceSpot.userDataStream(listenKey: listenKey);

    return response;
  }

  Future<Stream<WsTicker>> getTickerStream(String symbol) async {
    final Stream<WsTicker> response = binanceSpot.tickerStream(symbol: symbol);
    return response;
  }
}
