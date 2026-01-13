import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/browser_controller.dart';

class BrowserView extends GetView<BrowserController> {
  const BrowserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TextField(
            controller: controller.urlText,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              hintText: 'https://',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_forward),
                tooltip: 'Go',
                onPressed: controller.goToInput,
              ),
            ),
            onSubmitted: (_) => controller.goToInput(),
          ),
        ),
        actions: [
          Obx(() => IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: controller.canBack.value ? controller.back : null,
              )),
          Obx(() => IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: controller.canForward.value ? controller.forward : null,
              )),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.reload,
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            final p = controller.progress.value;
            if (p <= 0 || p >= 1) return const SizedBox(height: 2);
            return LinearProgressIndicator(value: p, minHeight: 2);
          }),
          Expanded(
            child: WebViewWidget(controller: controller.web),
          ),
        ],
      ),
    );
  }
}
