import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class YandexAdsRewarded {
  void load(String id);
  void show();
}
