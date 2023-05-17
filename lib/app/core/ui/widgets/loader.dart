import 'dart:developer';

import 'package:flutter/material.dart';

const defaultValue = 56.0;

class Loader extends StatelessWidget {
  static OverlayEntry? _currentLoader;

  const Loader._(this._progressIndicator, this._themeData);

  final Widget? _progressIndicator;
  final ThemeData? _themeData;
  static WidgetsBinding? widgetBind = WidgetsBinding.instance;

  static OverlayState? _overlayState;

  static bool get isShown => _currentLoader != null;

  static void show(
    BuildContext context, {
    Widget? progressIndicator,
    ThemeData? themeData,
  }) {
    _overlayState = Overlay.of(context);
    if (_currentLoader == null) {
      ///Create current Loader Entry
      _currentLoader = OverlayEntry(
        builder: (context) {
          return Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                  color: const Color(0x55000000),
                ),
              ),
              Center(
                child: Loader._(
                  progressIndicator,
                  themeData,
                ),
              ),
            ],
          );
        },
      );

      try {
        widgetBind?.addPostFrameCallback((_) {
          if (_currentLoader != null) {
            _overlayState?.insert(_currentLoader!);
          }
        });
      } catch (e, s) {
        log(e.toString(), error: e, stackTrace: s);
      }
    }
  }

  static void hide() {
    if (_currentLoader != null) {
      try {
        _currentLoader?.remove();
      } catch (e) {
        log(e.toString());
      } finally {
        _currentLoader = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        log("called will pop");

        return false;
      },
      child: Center(
        child: Theme(
          data: _themeData ?? Theme.of(context),
          child: _progressIndicator ?? const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
