import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';

void logInfo(String value) => DatadogSdk.instance.logs?.info(value);

void logWarn(String value) => DatadogSdk.instance.logs?.warn(value);

void logError(String value) => DatadogSdk.instance.logs?.error(value);
