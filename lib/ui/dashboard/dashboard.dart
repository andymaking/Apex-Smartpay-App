import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dashboard_view_model.dart';

final dashboardProvider =
ChangeNotifierProvider.autoDispose<DashBoardViewModel>((ref) {
  ref.onDispose(() {});
  final viewmodel = getIt.get<DashBoardViewModel>();
  viewmodel.getHomeMessage();
  return viewmodel;
});

final _dashBaordStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(dashboardProvider).viewState;
});
final dashBaordStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_dashBaordStateProvider);
});

class Dashboard extends StatefulHookWidget {

  const Dashboard( {Key? key,})
      : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final message = useProvider(dashboardProvider);

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
                      message.message,
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
