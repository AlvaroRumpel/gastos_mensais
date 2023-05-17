import 'package:flutter/material.dart';

import '../ui/widgets/loader.dart';
import '../ui/widgets/messages.dart';
import 'change_notifier_controller.dart';

class ChangeNotifierListener {
  final ChangeNotifierController changeNotifierController;

  ChangeNotifierListener({required this.changeNotifierController});

  void listener({
    required BuildContext context,
    SuccessVoidCallback? successVoidCallback,
    ErrorVoidCallback? errorVoidCallback,
    EverVoidCallback? everVoidCallback,
  }) {
    changeNotifierController.addListener(
      () {
        if (changeNotifierController.loading) {
          Loader.show(context);
        } else {
          Loader.hide();
        }

        if (changeNotifierController.hasError) {
          if (errorVoidCallback != null) {
            errorVoidCallback(changeNotifierController, this);
          }
          Messages.of(context).showError(changeNotifierController.errorMessage);
        } else if (changeNotifierController.isSuccess) {
          if (successVoidCallback != null) {
            successVoidCallback(changeNotifierController, this);
          }
        }

        if (everVoidCallback != null) {
          everVoidCallback(changeNotifierController, this);
        }
      },
    );
  }
}

typedef SuccessVoidCallback = void Function(
  ChangeNotifierController notifier,
  ChangeNotifierListener listenerInstance,
);

typedef ErrorVoidCallback = void Function(
  ChangeNotifierController notifier,
  ChangeNotifierListener listenerInstance,
);

typedef EverVoidCallback = void Function(
  ChangeNotifierController notifier,
  ChangeNotifierListener listenerInstance,
);
