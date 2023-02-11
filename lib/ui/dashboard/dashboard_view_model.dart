import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/data/core/network/App.logger.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/domain/model/home.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/ui/base_view_model.dart';

class DashBoardViewModel extends BaseViewModel {
  final userRepository = getIt<UserRepository>();

  ViewState _state = ViewState.idle;
  @override
  ViewState get viewState => _state;
  String errorMessage = "";
  String message = "";
  String token = "";
  String set = "";

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  /// get user secret message
  Future<HomeResponse?> getHomeMessage() async {
    getLogger("getHomeMessage");
    try {
      setViewState(ViewState.loading);
      var response = await userRepository.getHomeMessage();
      setViewState(ViewState.success);
      message = response?.data?.secret ?? "";
      return response;
    } catch (error) {
      setViewState(ViewState.error);
      setError(error.toString());
    }
  }

}