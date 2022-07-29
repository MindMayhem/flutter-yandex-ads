package ru.kovardin.flutter_yandex_ads.components

import android.util.Log
import ru.kovardin.flutter_yandex_ads.pigeons.Rewarded
import android.content.Context
import com.yandex.mobile.ads.common.AdRequest
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.rewarded.Reward
import com.yandex.mobile.ads.rewarded.RewardedAd
import com.yandex.mobile.ads.rewarded.RewardedAdEventListener
import ru.kovardin.flutter_yandex_ads.EventKey
import ru.kovardin.flutter_yandex_ads.EventType
import ru.kovardin.flutter_yandex_ads.YandexApi
import ru.kovardin.flutter_yandex_ads.pigeons.Interstitial
import ru.kovardin.flutter_yandex_ads.pigeons.Yandex

class YandexAdsRewarded(private val api: YandexApi, private val context: Context): Rewarded.YandexAdsRewarded {
    private var rewarded: RewardedAd? = null

    override fun load(id: String) {
        if (rewarded == null) {
            rewarded = RewardedAd(context)
            rewarded?.setAdUnitId(id)
            rewarded?.setRewardedAdEventListener(
                    object : RewardedAdEventListener {
                        override fun onAdLoaded() {
                            val builder = Yandex.EventResponse.Builder()

                            val response = builder.build()
                            api.callbacks
                                    .remove(
                                            EventKey(
                                                    id = id,
                                                    name = "onAdLoaded",
                                                    type = EventType.REWARDED.type
                                            )
                                    )
                                    ?.success(response)
                        }

                        override fun onAdFailedToLoad(error: AdRequestError) {
                            val builder = Yandex.EventResponse.Builder()
                            builder.setCode(error.code.toLong())
                            builder.setDescription(error.description)

                            val response = builder.build()
                            api.callbacks
                                    .remove(
                                            EventKey(
                                                    id = id,
                                                    name = "onAdFailedToLoad",
                                                    type = EventType.REWARDED.type
                                            )
                                    )
                                    ?.success(response)
                        }

                        override fun onAdShown() {
                            val builder = Yandex.EventResponse.Builder()

                            val response = builder.build()
                            val key =
                                    EventKey(
                                            id = id,
                                            name = "onAdShown",
                                            type = EventType.REWARDED.type
                                    )
                            api.callbacks.remove(key)?.success(response)
                        }

                        override fun onAdDismissed() {
                            val builder = Yandex.EventResponse.Builder()

                            val response = builder.build()
                            api.callbacks
                                    .remove(
                                            EventKey(
                                                    id = id,
                                                    name = "onAdDismissed",
                                                    type = EventType.REWARDED.type
                                            )
                                    )
                                    ?.success(response)
                        }

                        override fun onLeftApplication() {
                            val builder = Yandex.EventResponse.Builder()

                            val response = builder.build()
                            api.callbacks
                                    .remove(
                                            EventKey(
                                                    id = id,
                                                    name = "onLeftApplication",
                                                    type = EventType.REWARDED.type
                                            )
                                    )
                                    ?.success(response)
                        }

                        override fun onReturnedToApplication() {
                            val builder = Yandex.EventResponse.Builder()

                            val response = builder.build()
                            api.callbacks
                                    .remove(
                                            EventKey(
                                                    id = id,
                                                    name = "onReturnedToApplication",
                                                    type = EventType.REWARDED.type
                                            )
                                    )
                                    ?.success(response)
                        }
                        
                        override fun onAdClicked() {
                            val builder = Yandex.EventResponse.Builder()

                            val response = builder.build()
                            api.callbacks
                                    .remove(
                                            EventKey(
                                                    id = id,
                                                    name = "onAdClicked",
                                                    type = EventType.REWARDED.type
                                            )
                                    )
                                    ?.success(response)
                        }
                        override fun onImpression(data: ImpressionData?) {
                            val builder = Yandex.EventResponse.Builder()
                            builder.setData(data?.rawData ?: "")

                            val response = builder.build()
                            api.callbacks
                                    .remove(
                                            EventKey(
                                                    id = id,
                                                    name = "onImpression",
                                                    type = EventType.REWARDED.type
                                            )
                                    )
                                    ?.success(response)
                        }

                        override fun onRewarded(reward: Reward) {
                            val builder = Yandex.EventResponse.Builder()
                            builder.setData(reward?.amount.toString() ?: "")

                            val response = builder.build()
                            api.callbacks
                                    .remove(
                                            EventKey(
                                                    id = id,
                                                    name = "onRewarded",
                                                    type = EventType.REWARDED.type
                                            )
                                    )
                                    ?.success(response)
                        }
                    }
            )
        }

        val request = AdRequest.Builder().build()
        rewarded?.loadAd(request)
    }

    override fun show() {
        rewarded?.show()
    }
}