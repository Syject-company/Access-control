import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/widgets/action_bar_no_buttons.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';

class LoginWebPage extends StatefulWidget {
  const LoginWebPage({Key? key, required this.onLoggedIn}) : super(key: key);

  final VoidCallback onLoggedIn;

  @override
  LoginWebPageState createState() => LoginWebPageState();
}

class LoginWebPageState extends State<LoginWebPage> {
  final FlutterWebviewPlugin _listener = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    _listener.onUrlChanged.listen((String url) async {
      debugPrint('WebView: $url');
      if (url.startsWith(StringsRes.redirectURLPrefix)) {
        _backAndClose;
        widget.onLoggedIn();
      } else if (url.contains(StringsRes.errorURLPrefix)) {
        _backAndClose;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: WebviewScaffold(
        url: StringsRes.loginAzureURL,
        appBar: ActionBarNoButtons(
          title: StringsRes.logIn,
        ),
        initialChild: ProgIndicator(),
        invalidUrlRegex: StringsRes.redirectURLPrefix,
      ),
    );
  }

  void get _backAndClose => getIt<Navigation>().pop();

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }
}
