import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

final List<BoxShadow> highModeShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.12),
    blurRadius: 20,
    offset: const Offset(0, 6),
  ),
];

void showToastification({
  required BuildContext context,
  required ToastificationType type,
  ToastificationStyle style = ToastificationStyle.flat,
  required String title,
  String? description,
  Alignment alignment = Alignment.topCenter,
  Duration autoCloseDuration = const Duration(seconds: 2),
  BorderRadius? borderRadius,
  List<BoxShadow>? boxShadow,
}) {
  toastification.show(
    context: context,
    type: type,
    style: style,
    title: Text(title),
    description: Text(description ?? title),
    alignment: alignment,
    autoCloseDuration: autoCloseDuration,
    borderRadius: borderRadius ?? BorderRadius.circular(12.0),
    boxShadow: boxShadow ?? highModeShadow,
  );
}

void showSuccessToast(
  BuildContext context, {
  required String title,
  String? description,
  Alignment alignment = Alignment.topCenter,
  Duration autoCloseDuration = const Duration(seconds: 2),
}) {
  showToastification(
    context: context,
    type: ToastificationType.success,
    title: title,
    description: description,
    alignment: alignment,
    autoCloseDuration: autoCloseDuration,
  );
}

void showErrorToast(
  BuildContext context, {
  required String title,
  String? description,
  Alignment alignment = Alignment.topCenter,
  Duration autoCloseDuration = const Duration(seconds: 2),
}) {
  showToastification(
    context: context,
    type: ToastificationType.error,
    title: title,
    description: description,
    alignment: alignment,
    autoCloseDuration: autoCloseDuration,
  );
}

void showInfoToast(
  BuildContext context, {
  required String title,
  String? description,
  Alignment alignment = Alignment.topCenter,
  Duration autoCloseDuration = const Duration(seconds: 2),
}) {
  showToastification(
    context: context,
    type: ToastificationType.info,
    title: title,
    description: description,
    alignment: alignment,
    autoCloseDuration: autoCloseDuration,
  );
}

void showWarningToast(
  BuildContext context, {
  required String title,
  String? description,
  Alignment alignment = Alignment.topCenter,
  Duration autoCloseDuration = const Duration(seconds: 2),
}) {
  showToastification(
    context: context,
    type: ToastificationType.warning,
    title: title,
    description: description,
    alignment: alignment,
    autoCloseDuration: autoCloseDuration,
  );
}
