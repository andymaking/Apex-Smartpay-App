import 'package:Smartpay/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:Smartpay/ui/set_pin/set_pin.dart' as sharedProvider;


class Dashboard extends StatefulHookWidget {

  const Dashboard( {Key? key,})
      : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void dispose() {
    //_node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = useProvider(sharedProvider.setUserPinProvider);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child:
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  AppTextView.getAppTextViewBold(
                      "Dashboard",
                  size: 16),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
