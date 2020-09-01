import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:women_fitness_flutter/ad/ad_utils.dart';
import 'package:women_fitness_flutter/ad/reward_listener.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/db/hive/admob_fitness.dart';
import 'package:women_fitness_flutter/db/hive/iap_fitness.dart';
import 'package:women_fitness_flutter/network/women_fitness_client.dart';

abstract class AdTask {
  static final int oneHour = 3600000;
  static final int oneMinute = 60 * 1000;
  static final int oneDay = 0;
  static final int notFoundAppLength = 30;

  RewardedVideoAd rewardedVideoAd = RewardedVideoAd.instance;
  InterstitialAd _interstitialAdGoogle;
  bool _isInterstitialAdFacebookLoaded = false;

  BannerAd bannerGoogle;

  // singleton
  // factory AdTask() {
  //   return instance;
  // }
  //
  // static final AdTask instance = AdTask._internal();
  //
  // AdTask._internal();

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['women fitness', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[
      AdUtils.deviceTestAdmob,
      AdUtils.deviceTestFacebook,
    ], // Android emulators are considered test devices
  );

  Future<void> getAdsServerConfig() async {
    int previousTime =
        await SPref.instance.getInt(AdUtils.timeAdsConfigGlobalApp) ?? 0;
    if (DateTime.now().millisecondsSinceEpoch - previousTime >= oneHour) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String jsonResult = "";
      String query =
          "/app-ads/public/api/app/" + packageInfo.packageName + "/detail";
      Response response = await WomenFitnessClient.instance.dio.get(query);
      if (response.statusCode == 200) {
        jsonResult = json.encode(response.data);
        SPref.instance.setString(AdUtils.adsConfigGlobalApp, jsonResult);
        SPref.instance.setInt(AdUtils.timeAdsConfigGlobalApp,
            DateTime.now().millisecondsSinceEpoch);
      }
    }
  }

  Future<String> getRewardFacebook() async {
    String jsonData = await getAdsConfigLocal();
    if (jsonData != null) {
      String rewardID = "";
      Map<String, dynamic> mapData = json.decode(jsonData);
      rewardID = mapData["data"]["app"]["Faceboook"][0]["rewards"];
      return rewardID;
    }
    return "";
  }

  Future<String> getIDRewardGoogle() async {
    String jsonData = await getAdsConfigLocal();
    if (jsonData != null) {
      String rewardID = "";
      Map<String, dynamic> mapData = json.decode(jsonData);
      rewardID = mapData["data"]["app"]["Admob"][0]["rewards"];
      return rewardID;
    }
    return "";
  }

  Future<String> getInterstitialIDFacebook() async {
    String jsonData = await getAdsConfigLocal();
    if (jsonData != null) {
      String intersitialIDFace = "";
      Map<String, dynamic> mapData = json.decode(jsonData);
      intersitialIDFace = mapData["data"]["app"]["Faceboook"][0]["intersitial"];
      return intersitialIDFace;
    }
    return "";
  }

  Future<String> getBannerIDAdsFacebook() async {
    String jsonData = await getAdsConfigLocal();
    if (jsonData != null) {
      String bannerIDFace = "";
      Map<String, dynamic> mapData = json.decode(jsonData);
      bannerIDFace = mapData["data"]["app"]["Faceboook"][0]["banner"];
      return bannerIDFace;
    }
    return "";
  }

  Future<String> getBannerIDAdsAdsmob() async {
    String jsonData = await getAdsConfigLocal();
    if (jsonData != null) {
      String bannerID = "";
      Map<String, dynamic> mapData = json.decode(jsonData);
      bannerID = mapData["data"]["app"]["Admob"][0]["banner"];
      return bannerID;
    }
    return "";
  }

  Future<String> getInterstitialIDAdsmob() async {
    String jsonData = await getAdsConfigLocal();
    if (jsonData != null) {
      String intersitialID = "";
      Map<String, dynamic> mapData = json.decode(jsonData);
      intersitialID = mapData["data"]["app"]["Admob"][0]["intersitial"];
      return intersitialID;
    }

    return "";
  }

  Future<String> getAppIdAdsmod() async {
    String jsonData = await getAdsConfigLocal();
    if (jsonData != null) {
      String appID = "";
      Map<String, dynamic> mapData = json.decode(jsonData);
      appID = mapData["data"]["app"]["Admob"][0]["app_ids_ads"];
      return appID;
    }
    return "ca-app-pub-3940256099942544~3347511713";
  }

  Future<void> loadRewardGoogle(RewardListener rewardListener) async {
    bool checkEarn = false;
    rewardedVideoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print('Rewarded video ad event= $event');
      switch (event) {
        case RewardedVideoAdEvent.loaded:
          rewardedVideoAd.show();
          break;
        case RewardedVideoAdEvent.failedToLoad:
          rewardListener.onRewardError();
          break;
        case RewardedVideoAdEvent.opened:
          break;
        case RewardedVideoAdEvent.leftApplication:
          break;
        case RewardedVideoAdEvent.closed:
          if (checkEarn) {
            rewardListener.onRewardEarned();
          } else {
            rewardListener.onRewardCancel();
          }
          break;
        case RewardedVideoAdEvent.rewarded:
          checkEarn = true;
          break;
        case RewardedVideoAdEvent.started:
          break;
        case RewardedVideoAdEvent.completed:
          break;
      }
    };

    rewardedVideoAd.load(adUnitId: await getIDRewardGoogle());
  }

  Future<void> loadRewardFacebook(
      RewardListener rewardListener, bool showAfterLoaded) async {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
        placementId: await getRewardFacebook(),
        listener: (result, value) {
          bool checkEarn = false;

          switch (result) {
            case RewardedVideoAdResult.ERROR:
              loadRewardGoogle(rewardListener);
              break;
            case RewardedVideoAdResult.LOADED:
              if (showAfterLoaded) {
                if (!value["invalidated"]) {
                  FacebookRewardedVideoAd.showRewardedVideoAd();
                }
                loadRewardFacebook(rewardListener, false);
              }
              break;
            case RewardedVideoAdResult.CLICKED:
              break;
            case RewardedVideoAdResult.LOGGING_IMPRESSION:
              break;
            case RewardedVideoAdResult.VIDEO_COMPLETE:
              checkEarn = true;
              break;
            case RewardedVideoAdResult.VIDEO_CLOSED:
              if (checkEarn) {
                rewardListener.onRewardEarned();
              } else {
                rewardListener.onRewardCancel();
              }
              break;
          }
        });
  }

  Future<String> getAdsConfigLocal() async {
    String jsonData =
        await SPref.instance.getString(AdUtils.adsConfigGlobalApp) ?? "";
    if (jsonData.length < notFoundAppLength) {
      return null;
    } else {
      return jsonData;
    }
  }

  Future<bool> needShowRewardedAds() async {
    bool checkPremium;
    var iapBox = Hive.box('iap_fitness');
    IAPFitness iapFitness = iapBox.get('premium');
    if (iapFitness == null) {
      checkPremium = iapFitness.isBuy;
    } else {
      checkPremium = false;
    }
    return !checkPremium;
  }

  Future<bool> needShowInterstitialAds() async {
    bool checkPremium;
    var iapBox = Hive.box('iap_fitness');
    IAPFitness iapFitness = iapBox.get('premium');
    if (iapFitness == null) {
      checkPremium = iapFitness.isBuy;
    } else {
      checkPremium = false;
    }
    int previousTime =
        await SPref.instance.getInt(AdUtils.deltaTimeAdShowInterstitial) ?? 0;
    if (DateTime.now().millisecondsSinceEpoch - previousTime >= oneMinute &&
        !checkPremium) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> needShowBannerAds() async {
    bool checkPremium;
    var iapBox = Hive.box('iap_fitness');
    IAPFitness iapFitness = iapBox.get('premium');
    if (iapFitness == null) {
      checkPremium = iapFitness.isBuy;
    } else {
      checkPremium = false;
    }
    int previousTime =
        await SPref.instance.getInt(AdUtils.deltaTimeAdShowBanner) ?? 0;
    if (DateTime.now().millisecondsSinceEpoch - previousTime >= oneMinute &&
        !checkPremium) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> needShowNotification() async {
    int previousTime =
        await SPref.instance.getInt(AdUtils.deltaTimeAdShowNotification) ?? 0;
    if (previousTime == 0) {
      previousTime = DateTime.now().millisecondsSinceEpoch;
      SPref.instance.setInt(AdUtils.deltaTimeAdShowNotification, previousTime);
      return true;
    }
    if (DateTime.now().millisecondsSinceEpoch - previousTime >= oneDay) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> loadAdsInterstitialGoogle() async {
    _interstitialAdGoogle = InterstitialAd(
        adUnitId: await getInterstitialIDAdsmob(),
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.opened) {
            SPref.instance.setInt(AdUtils.deltaTimeAdShowInterstitial,
                DateTime.now().millisecondsSinceEpoch);
          }
        });
    await _interstitialAdGoogle.load();
  }

  Future<void> showInterstitialAds() async {
    if (await needShowInterstitialAds()) {
      if (_isInterstitialAdFacebookLoaded) {
        FacebookInterstitialAd.showInterstitialAd();
        print('facebook interstitialads');
      } else if (_interstitialAdGoogle != null) {
        print('showInterstitialAds');
        _interstitialAdGoogle.show();
      }
      await loadInterstitialAds();
    }
  }

  Future<void> loadInterstitialAds() async {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "284129658790784_474035296466885",
      listener: (result, value) {
        switch (result) {
          case InterstitialAdResult.DISPLAYED:
            SPref.instance.setInt(AdUtils.deltaTimeAdShowInterstitial,
                DateTime.now().millisecondsSinceEpoch);
            break;
          case InterstitialAdResult.DISMISSED:
            break;
          case InterstitialAdResult.ERROR:
            loadAdsInterstitialGoogle();
            break;
          case InterstitialAdResult.LOADED:
            break;
          case InterstitialAdResult.CLICKED:
            SPref.instance.setInt(AdUtils.deltaTimeAdShowBanner,
                DateTime.now().millisecondsSinceEpoch);
            FacebookInterstitialAd.destroyInterstitialAd();
            break;
          case InterstitialAdResult.LOGGING_IMPRESSION:
            break;
        }
      },
    );
  }

  Future<void> loadBannerAdsGoogle() async {
    if (await needShowBannerAds()) {
      bannerGoogle = BannerAd(
        adUnitId: await getBannerIDAdsAdsmob(),
        size: AdSize.smartBanner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          switch (event) {
            case MobileAdEvent.loaded:
              var admobBox = Hive.box('admob_fitness');
              AdmobFitness admobFitness =
                  AdmobFitness(title: AdUtils.bannerLoaded, isLoaded: true);
              admobBox.put(AdUtils.bannerLoaded, admobFitness);
              break;
            case MobileAdEvent.failedToLoad:
              var admobBox = Hive.box('admob_fitness');
              if (admobBox.length != 0) {
                AdmobFitness admobFitness = admobBox.get(AdUtils.bannerLoaded);
                admobFitness.isLoaded = false;
                admobFitness.save();
              }
              break;
            case MobileAdEvent.clicked:
              break;
            case MobileAdEvent.impression:
              break;
            case MobileAdEvent.opened:
              break;
            case MobileAdEvent.leftApplication:
              SPref.instance.setInt(AdUtils.deltaTimeAdShowBanner,
                  DateTime.now().millisecondsSinceEpoch);
              destroyBannerAds();
              break;
            case MobileAdEvent.closed:
              break;
          }
        },
      )
        ..load()
        ..show(
          anchorType: AnchorType.bottom,
        );
    }
  }

  Future<void> destroyBannerAds() async {
    if (bannerGoogle != null) {
      bannerGoogle.dispose();
    }
  }
}
