import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/domain/model/country_model.dart';
import 'package:Smartpay/domain/model/register_user.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/ui/base_view_model.dart';
import 'package:Smartpay/ui/components/custom_dialog.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:Smartpay/utils/validations.dart';
import 'package:flutter/cupertino.dart';

class GetUserInfoViewModel extends BaseViewModel {
  final userRepository = getIt<UserRepository>();

  List<CountryModel> userCountry = [];
  Set<String> currentUserCountry = {};
  String selectedCountryName = "";
  String selectedCountryCode = "";
  String selectedCountryFlag = "";
  String errorMessage = "";
  String fullName = "";
  String userName = "";
  String country = "";
  String password = "";
  String email = "";
  String token = "";
  bool isValidUserInfo = false;
  String index = "";

  ViewState _state = ViewState.idle;
  @override
  ViewState get viewState => _state;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController seachController = TextEditingController();

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  setFullName(String name) {
    fullName = name;
    notifyListeners();
  }

  setUserName(String name) {
    userName = name;
    notifyListeners();
  }

  setCountry(String country) {
    selectedCountryCode = country;
    notifyListeners();
  }

  setPassword(String pwd) {
    password = pwd;
    notifyListeners();
  }

  void validUserInfo() {
    isValidUserInfo = fullName.isNotEmpty && userName.isNotEmpty &&
        selectedCountryCode.isNotEmpty && isValidPasswords(password);
    notifyListeners();
  }

  void setSelectedCountry(name) {
    selectedCountryName = name;
    notifyListeners();
  }

  void setSelectedCountryCode(code) {
    selectedCountryCode = code;
    notifyListeners();
  }

  void setSelectedCountryFlag(flag) {
    selectedCountryFlag = flag;
    notifyListeners();
  }

  Future<void> updateCountryUI(CountryModel country) async {
    Set<String> listToUpdate = {};
    listToUpdate.addAll(currentUserCountry);
    String countryId = country.id ?? "";
    bool shouldDelete = listToUpdate.contains(countryId);
    if (shouldDelete) {
      listToUpdate.remove(countryId);
      currentUserCountry = listToUpdate;
    } else {
      listToUpdate.add(countryId);
      currentUserCountry = listToUpdate;
    }
    setViewState(ViewState.success);
  }


  Future<RegisterUserResponse?> registerUser(BuildContext context) async {
    try {
      setViewState(ViewState.loading);
      var response = await userRepository.register(fullName, userName, email, selectedCountryCode, password);
      final firstName = fullName.toString().trim().split(" ");
      setViewState(ViewState.success);
      sharedPreference.saveToken("${response?.data?.token}");
      sharedPreference.saveEmail(email);
      sharedPreference.savePassword(password);
      sharedPreference.saveFirstName(firstName.first);

      navigationService.navigateTo(AppRoutes.setUserPin);
      return response;
    } catch (error) {
      setViewState(ViewState.error);
      setError(error.toString());
      await showTopModalSheet<String>(
          context: context,
          child: ShowDialog(
            title: errorMessage,
            isError: true,
            onPressed: () {},
          ));
    }
  }
}
