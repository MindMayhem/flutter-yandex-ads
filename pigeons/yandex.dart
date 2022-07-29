import 'package:pigeon/pigeon.dart';

class EventRequest {
  final String name;
  final String id;
  final String type;

  EventRequest(this.name, this.id, this.type);
}

class EventResponse {
  final String? data;
  final int? code;
  final String? description;

  EventResponse(this.data, this.code, this.description);
}

@HostApi()
abstract class YandexAdsApi {
  void initialize();

  // dispatchers

  @async
  EventResponse onAdLoaded(EventRequest request);

  @async
  EventResponse onAdFailedToLoad(EventRequest request);

  @async
  EventResponse onImpression(EventRequest request);

  @async
  EventResponse onAdClicked(EventRequest request);

  @async
  EventResponse onRewarded(EventRequest request);

  @async
  EventResponse onLeftApplication(EventRequest request);

  @async
  EventResponse onReturnedToApplication(EventRequest request);

  @async
  EventResponse onAdShown(EventRequest request);

  @async
  EventResponse onAdDismissed(EventRequest request);
}
