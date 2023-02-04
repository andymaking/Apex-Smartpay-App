import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/domain/model/country_model.dart';
import 'package:Smartpay/ui/base_view_model.dart';
import 'package:Smartpay/ui/components/toast.dart';
import 'package:flutter/cupertino.dart';

class GetUserInfoViewModel extends BaseViewModel {
  List<CountryModel> userGenders = [];
  Set<String> currentUserCountry = {};
  String selectedCountryName = "";
  String selectedCountryCode = "";
  String selectedCountryFlag = "";
  String errorMessage = "";
  String fullName = "";
  String userName = "";
  String country = "";
  String password = "";
  bool isValidUserInfo = false;
  String index = "";

  ViewState _state = ViewState.idle;

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

  void getValues() {
    fullNameController.text = fullName ?? "";
    userNameController.text = userName ?? "";
    countryController.text = selectedCountryCode ?? "";
    passwordController.text = password ?? "";
  }

  void validUserInfo() {
    isValidUserInfo = fullName.isNotEmpty && userName.isNotEmpty &&
        selectedCountryCode.isNotEmpty && password.isNotEmpty;
    notifyListeners();
  }

  void setSelectedCountry(name) {
    this.selectedCountryName = name;
    notifyListeners();
  }

  void setSelectedCountryCode(code) {
    this.selectedCountryCode = code;
    notifyListeners();
  }

  void setSelectedCountryFlag(flag) {
    this.selectedCountryFlag = flag;
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

  showError() {
    String errorMessage = "";
    if (fullName == null || fullName.isEmpty) {
      errorMessage = "${errorMessage}Please Enter your Full Name,  ";
    }
    if (userName == null || userName.isEmpty) {
      errorMessage = "${errorMessage}Please Enter your User Name,  ";
    }
    if (country == null || country.isEmpty) {
      errorMessage = "${errorMessage}Please select your Country,  ";
    }
    if (password == null || password.isEmpty) {
      errorMessage = "${errorMessage}Please Enter your Password,  ";
    }
    showCustomToast(errorMessage);
  }

  userInfo() async {
    viewState = ViewState.idle;
    try {
      //TODO
    } catch (e) {
      viewState = ViewState.idle;

      showCustomToast(e.toString());
    }
    notifyListeners();
  }
}
