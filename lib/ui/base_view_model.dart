import 'package:Smartpay/core/enum/view_state.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:flutter/foundation.dart';
import '../core/services/navigation_service.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.idle;
  NavigationService navigationService = getIt<NavigationService>();

  ViewState get viewState => _viewState;

  set viewState(ViewState newState) {
    _viewState = newState;
    notifyListeners();
  }
}
