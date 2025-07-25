/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/app_icon.png
  AssetGenImage get appIcon => const AssetGenImage('assets/icons/app_icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [appIcon];
}

class $AssetsLottiesGen {
  const $AssetsLottiesGen();

  /// File path: assets/lotties/auth_lottie.json
  String get authLottie => 'assets/lotties/auth_lottie.json';

  /// File path: assets/lotties/auth_lottie_2.json
  String get authLottie2 => 'assets/lotties/auth_lottie_2.json';

  /// File path: assets/lotties/chill_guy_laugh.json
  String get chillGuyLaugh => 'assets/lotties/chill_guy_laugh.json';

  /// File path: assets/lotties/girl_in_a_bike.json
  String get girlInABike => 'assets/lotties/girl_in_a_bike.json';

  /// File path: assets/lotties/not_found.json
  String get notFound => 'assets/lotties/not_found.json';

  /// List of all assets
  List<String> get values => [
    authLottie,
    authLottie2,
    chillGuyLaugh,
    girlInABike,
    notFound,
  ];
}

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/authbg.jpg
  AssetGenImage get authbg => const AssetGenImage('assets/png/authbg.jpg');

  /// File path: assets/png/background.jpeg
  AssetGenImage get background =>
      const AssetGenImage('assets/png/background.jpeg');

  /// File path: assets/png/bg.jpeg
  AssetGenImage get bg => const AssetGenImage('assets/png/bg.jpeg');

  /// File path: assets/png/supporttalogo.png
  AssetGenImage get supporttalogo =>
      const AssetGenImage('assets/png/supporttalogo.png');

  /// List of all assets
  List<AssetGenImage> get values => [authbg, background, bg, supporttalogo];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/facebook.svg
  String get facebook => 'assets/svg/facebook.svg';

  /// File path: assets/svg/gmail.svg
  String get gmail => 'assets/svg/gmail.svg';

  /// File path: assets/svg/google.svg
  String get google => 'assets/svg/google.svg';

  /// File path: assets/svg/rocket.svg
  String get rocket => 'assets/svg/rocket.svg';

  /// List of all assets
  List<String> get values => [facebook, gmail, google, rocket];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsLottiesGen lotties = $AssetsLottiesGen();
  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
