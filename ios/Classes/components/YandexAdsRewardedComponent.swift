//
// Created by Artem Kovardin on 09.03.2022.
//

import Foundation
import YandexMobileAds

class YandexAdsRewardedComponent: NSObject, YandexAdsRewarded {
    private var rewarded: YMARewardedAd? = nil
    private var api: YandexApi
    private var id: String!

    init(api: YandexApi) {
        self.api = api
        super.init()
    }

    func loadId(_ id: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        self.id = id

        rewarded = YMARewardedAd(adUnitID: id)
        rewarded?.delegate = self;
        rewarded?.load()
    }

    func showWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        if let controller = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController, let rewarded = rewarded {
            rewarded.present(from: controller)
        }
    }
}


extension YandexAdsRewardedComponent: YMARewardedAdDelegate {
    func rewardedAdDidLoad(_ rewardedAd: YMARewardedAd) {
        let response = EventResponse()

        if let callback = api.callbacks[EventKey(id: id, name: "onAdLoaded", type: EventType.REWARDED.rawValue)] {
            callback(response, nil)
        }
    }

    func rewardedAdDidFail(toLoad rewardedAd: YMARewardedAd, error: Error) {
        let response = EventResponse()
        response.code = error._code as NSNumber
        response.description = error._domain

        if let callback = api.callbacks[EventKey(id: id, name: "onAdFailedToLoad", type: EventType.REWARDED.rawValue)] {
            callback(response, nil)
        }
    }

    func rewardedAdWillLeaveApplication(_ rewardedAd: YMARewardedAd) {
        let response = EventResponse()

        if let callback = api.callbacks[EventKey(id: id, name: "onLeftApplication", type: EventType.REWARDED.rawValue)] {
            callback(response, nil)
        }
    }

    func rewardedAdDidFail(toPresent rewardedAd: YMARewardedAd, error: Error) {
        print("Failed to present rewarded. Error: \(error)")
    }

    func rewardedAdWillAppear(_ rewardedAd: YMARewardedAd) {
        print("Interstitial ad will appear")
    }

    func rewardedAdDidAppear(_ rewardedAd: YMARewardedAd) {
        let response = EventResponse()

        if let callback = api.callbacks[EventKey(id: id, name: "onAdShown", type: EventType.REWARDED.rawValue)] {
            callback(response, nil)
        }
    }

    func rewardedAdWillDisappear(_ rewardedAd: YMARewardedAd) {
        print("Interstitial ad will disappear")
    }

    func rewardedAdDidDisappear(_ rewardedAd: YMARewardedAd) {
        let response = EventResponse()

        if let callback = api.callbacks[EventKey(id: id, name: "onAdDismissed", type: EventType.REWARDED.rawValue)] {
            callback(response, nil)
        }
    }

    func rewardedAd(_ rewardedAd: YMARewardedAd, willPresentScreen webBrowser: UIViewController?) {
        print("Interstitial ad will present screen")
    }

    func rewardedAd(_ rewardedAd: YMARewardedAd, didTrackImpressionWith impressionData: YMAImpressionData?) {
        print("Interstitial ad did track impression data")

        let response = EventResponse()
        response.data = impressionData?.rawData ?? ""

        if let callback = api.callbacks[EventKey(id: id, name: "onImpression", type: EventType.REWARDED.rawValue)] {
            callback(response, nil)
        }
    }
}