import 'package:flutter_yandex_ads/pigeons/rewarded.dart';
import 'package:flutter_yandex_ads/yandex.dart';

class YandexAdsRewardedComponents {
  YandexAdsRewardedComponents({
    Function()? onAdLoaded,
    Function(AdLoadError)? onAdFailedToLoad,
    Function(String?)? onRewarded,
    Function()? onLeftApplication,
    Function()? onReturnedToApplication,
    Function()? onAdShown,
    Function()? onAdDismissed,
    required this.id,
    required this.ads,
  }) {
    rewarded = YandexAdsRewarded();
    if (onAdLoaded != null) {
      ads.setOnAdLoaded(id, EventTypes.REWARDED, onAdLoaded);
    }

    if (onAdFailedToLoad != null) {
      ads.setOnAdFailedToLoad(id, EventTypes.REWARDED, onAdFailedToLoad);
    }

    if (onRewarded != null) {
      ads.setOnRewarded(id, EventTypes.REWARDED, onRewarded);
    }
    if (onLeftApplication != null) {
      ads.setOnLeftApplication(id, EventTypes.REWARDED, onLeftApplication);
    }

    if (onReturnedToApplication != null) {
      ads.setOnReturnedToApplication(id, EventTypes.REWARDED, onReturnedToApplication);
    }

    if (onAdShown != null) {
      ads.setOnAdShown(id, EventTypes.REWARDED, onAdShown);
    }

    if (onAdDismissed != null) {
      ads.setOnAdDismissed(id, EventTypes.REWARDED, onAdDismissed);
    }
  }

  final String id;
  final FlutterYandexAds ads;
  late final YandexAdsRewarded rewarded;

  void load() {
    rewarded.load(id);
  }

  void show() {
    rewarded.show();
  }
}
