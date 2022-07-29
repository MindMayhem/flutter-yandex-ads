import 'package:flutter/material.dart';
import 'package:flutter_yandex_ads/compoenets/interstitial.dart';
import 'package:flutter_yandex_ads/compoenets/rewaded.dart';

import 'package:flutter_yandex_ads/widgets/banner.dart';
import 'package:flutter_yandex_ads/yandex.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  FlutterYandexAds ads = FlutterYandexAds();

  @override
  void initState() {
    super.initState();

    ads.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Yandex ADS'),
            ),
            bottomNavigationBar: const TabBar(
              tabs: [
                Tab(child: Text('Banner', style: TextStyle(color: Colors.black54, fontSize: 12))),
                Tab(
                    child: Text('Interstitial',
                        style: TextStyle(color: Colors.black54, fontSize: 12))),
                Tab(child: Text('Rewarded', style: TextStyle(color: Colors.black54, fontSize: 12))),
                Tab(child: Text('Native', style: TextStyle(color: Colors.black54, fontSize: 12))),
              ],
            ),
            body: TabBarView(
              children: [
                BannerScreen(ads: ads),
                InterstitialScreen(
                  ads: ads,
                ),
                RewardedScreen(ads: ads),
                const Icon(Icons.directions_bike),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BannerScreen extends StatefulWidget {
  BannerScreen({Key? key, required this.ads}) : super(key: key);

  FlutterYandexAds ads;

  @override
  _BannerScreenState createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Banner'),
        Container(
          height: 60,
          decoration: const BoxDecoration(
              border: Border.fromBorderSide(BorderSide(width: 2)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Colors.redAccent),
          padding: const EdgeInsets.all(5),
          child: YandexAdsBannerWidget(
            ads: widget.ads,
            id: 'R-M-DEMO-320x50',
            onAdLoaded: () {
              print('banner onAdLoaded');
            },
            onAdFailedToLoad: (AdLoadError err) {
              print('banner onAdFailedToLoad code: ${err.code}, description: ${err.description}');
            },
            onImpression: (String? data) {
              print("banner onImpression ${data ?? ''}");
            },
            onAdClicked: () {
              print('banner onAdClicked');
            },
          ),
        ),
      ],
    );
  }
}

class InterstitialScreen extends StatefulWidget {
  InterstitialScreen({Key? key, required this.ads}) : super(key: key);

  FlutterYandexAds ads;

  @override
  _InterstitialScreenState createState() => _InterstitialScreenState();
}

class _InterstitialScreenState extends State<InterstitialScreen> {
  late YandexAdsIntersttialComponents interstitial;

  @override
  void initState() {
    super.initState();

    interstitial = YandexAdsIntersttialComponents(
      id: 'R-M-DEMO-interstitial',
      ads: widget.ads,
      onAdLoaded: () {
        print('interstitial onAdLoaded');
      },
      onAdFailedToLoad: (AdLoadError err) {
        print('interstitial onAdFailedToLoad code: ${err.code}, description: ${err.description}');
      },
      onAdDismissed: () {
        print("interstitial onAdDismissed");
      },
      onAdShown: () {
        print("interstitial onAdShown");
      },
      onImpression: (String? data) {
        print('interstitial onImpression $data');
      },
    );

    interstitial.load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Interstitial'),
        ElevatedButton(
          onPressed: () {
            interstitial.show();
          },
          child: const Text('show'),
        ),
      ],
    );
  }
}

class RewardedScreen extends StatefulWidget {
  RewardedScreen({Key? key, required this.ads}) : super(key: key);

  FlutterYandexAds ads;

  @override
  _RewardedScreenState createState() => _RewardedScreenState();
}

class _RewardedScreenState extends State<RewardedScreen> {
  late YandexAdsRewardedComponents rewarded;

  @override
  void initState() {
    super.initState();

    rewarded = YandexAdsRewardedComponents(
      id: 'R-M-DEMO-rewarded-client-side-rtb',
      ads: widget.ads,
      onAdLoaded: () {
        print('Rewarded onAdLoaded');
      },
      onAdFailedToLoad: (AdLoadError err) {
        print('Rewarded onAdFailedToLoad code: ${err.code}, description: ${err.description}');
      },
      onAdDismissed: () {
        print("Rewarded onAdDismissed");
      },
      onAdShown: () {
        print("Rewarded onAdShown");
      },
      onRewarded: (String? data) {
        print('Rewarded onRewarded $data');
      },
    );

    rewarded.load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Rewarded video'),
        ElevatedButton(
          onPressed: () {
            rewarded.show();
          },
          child: const Text('show'),
        ),
      ],
    );
  }
}
