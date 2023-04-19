import 'package:binance_spot/binance_spot.dart';
import 'package:bot1777/models/coin_model.dart';

class BinanceRepository {
  late final BinanceSpot binanceSpot;

  Future<void> initialize() async {
    const apiKey =
        "apiKey";
    const apiSecret =
        "apiSecret";

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
    }
    final response = binanceSpot.userDataStream(listenKey: listenKey);

    return response;
  }

  Future<Stream<WsTicker>> getTickerStream(String symbol) async {
    final Stream<WsTicker> response = binanceSpot.tickerStream(symbol: symbol);
    return response;
  }
}
