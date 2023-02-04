import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/data/services/navigation_service.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:flutter/foundation.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.idle;
  NavigationService navigationService = getIt<NavigationService>();

  ViewState get viewState => _viewState;

  set viewState(ViewState newState) {
    _viewState = newState;
    notifyListeners();
  }
}
