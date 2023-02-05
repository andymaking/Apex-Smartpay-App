import 'dart:async';
import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/data/core/table_constants.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/ui/components/app_toolbar.dart';
import 'package:Smartpay/ui/components/button.dart';
import 'package:Smartpay/ui/components/country_view.dart';
import 'package:Smartpay/ui/components/custom_dialog.dart';
import 'package:Smartpay/ui/components/custom_textfield.dart';
import 'package:Smartpay/ui/components/textfield_search.dart';
import 'package:Smartpay/ui/create_user_info/get_user_info_view_model.dart';
import 'package:Smartpay/utils/app_text.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userInfoProvider = ChangeNotifierProvider.autoDispose(
    (ref) => getIt.get<GetUserInfoViewModel>());

final _validUserInfoProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(userInfoProvider).isValidUserInfo;
});

final validUserInfoProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(_validUserInfoProvider);
});

final _userInfoStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(userInfoProvider).viewState;
});

final userInfoStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_userInfoStateProvider);
});

class GetUserInfoScreen extends StatefulHookWidget {
  const GetUserInfoScreen({super.key});

  @override
  _GetUserInfoScreen createState() => _GetUserInfoScreen();
}

class _GetUserInfoScreen extends State<GetUserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusScopeNode _node = FocusScopeNode();
  final dummySearchList = ['USA', 'United Kingdom', 'Others'];
  final label = "Search";

  //List<bool> isSelected = [false];
  String? _selectedOption;
  int selectedCountryIndex = -1;

  //List<Country> _countryList = [];
  String query = '';

  //Timer? debouncer;
  final countryList = DemoCountryValues.countries;
  int? index;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
    final isValidUserInfo = useProvider(validUserInfoProvider);
    final userInfoViewState = useProvider(userInfoStateProvider);
    final countryN = useProvider(userInfoProvider).currentUserCountry;
    final countryNn = useProvider(userInfoProvider).selectedCountryName;
    final currentSelectedCountry =
        useProvider(userInfoProvider).currentUserCountry;
    final model = context.read(userInfoProvider);
    model.email = email;

    context.read(userInfoProvider).email = email.toString();
    print("showing email $email");
    print("showing just selected $countryN $countryNn");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: FocusScope(
          node: _node,
          child: Form(
            key: _formKey,
            child: ListView(children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppToolbar(),
                  Sized24Container(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(
                            text: AppStrings.heyThereTellUs,
                            semanticsLabel: AppStrings.heyThereTellUs,
                            style: TextStyle(
                              fontFamily: AppStrings.fontFamily,
                              color: ThemeConfig.darkColor,
                              fontSize: AppFontSizes.headingFontSize24,
                              fontWeight: FontWeight.w600,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: AppStrings.yourself,
                                semanticsLabel: AppStrings.yourself,
                                style: TextStyle(
                                  fontFamily: AppStrings.fontFamily,
                                  color: ThemeConfig.darkAccent,
                                  fontSize: AppFontSizes.headingFontSize24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ])),
                        const SizedBox(
                          height: 30,
                        ),
                        AppTextField(
                          hint: AppStrings.fullName,
                          onChanged: (v) {
                            final input = v.toString().trim().split(" ");
                            storageService.storeItem(key: DbTable.FIRST_NAME_TABLE, value: input.first);
                            model.setFullName(v);
                            model.validUserInfo();
                          },
                          controller: model.fullNameController,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        AppTextField(
                          hint: AppStrings.userName,
                          onChanged: (v) {
                            model.setUserName(v);
                            model.validUserInfo();
                          },
                          controller: model.userNameController,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CountryList(
                          countryName: model.selectedCountryName,
                          countryFlag: model.selectedCountryFlag,
                          countryCode: model.selectedCountryCode,
                          onTap: () {
                            showCountryListBottomSheet(context);
                            print("show ${model.selectedCountryName}");
                            print("show ${model.selectedCountryFlag}");
                            print("show ${model.selectedCountryCode}");
                            print("show cont${model.countryController.text}");
                          },
                          selected: _selectedOption.toString().isNotEmpty,
                          controller: model.countryController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        AppPasswordField(
                          hint: AppStrings.password,
                          onChanged: (val) {
                            model.setPassword(val);
                            model.validUserInfo();
                          },
                          controller: model.passwordController,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        userInfoViewState == ViewState.loading
                            ? Center(
                                child: CircularProgressIndicator(
                                color: ThemeConfig.darkAccent,
                              ))
                            : AppButton(
                                onPressed: () {
                                  observeRegistrationState(context);
                                },
                                title: "Continue",
                                enabled: isValidUserInfo ? true : false),
                        const SizedBox(
                          height: 32,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void observeRegistrationState(BuildContext context) async {
    final viewModel = context.read(userInfoProvider);
    print('fullName ${viewModel.fullName}');
    print('userName ${viewModel.userName}');
    print('email ${viewModel.email}');
    print('country ${viewModel.selectedCountryCode}');
    print('password ${viewModel.password}');
    print('password ${viewModel.token}');
    var mail = await viewModel.registerUser(
      viewModel.fullName,
      viewModel.userName,
      viewModel.email,
      viewModel.selectedCountryCode,
      viewModel.password,
      context
    );
    if (viewModel.viewState == ViewState.success) {
      print('register user details $mail');
      print('register user token ${viewModel.token}');
      setToken(viewModel.token);
      Navigator.of(context).pushNamed(AppRoutes.setUserPin, arguments: viewModel.token);
    }
  }

  setToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List> fetchData() async {
    String _inputText = context.read(userInfoProvider).seachController.text;
    final searchResult = countryList;
    return searchResult;
  }

  showCountryListBottomSheet(BuildContext context) {
    showModalBottomSheet(
        elevation: 10,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        builder: (context) => StatefulBuilder(
              builder: (BuildContext context, setState) => Container(
                height: 617,
                alignment: Alignment.center,
                //padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 56.h,
                              width: MediaQuery.of(context).size.width - 10,
                              decoration: BoxDecoration(
                                color: ThemeConfig.editTextGB.withOpacity(0.2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Center(
                                  child: TextFieldSearch(
                                      initialList: dummySearchList,
                                      controller: context
                                          .read(userInfoProvider)
                                          .seachController,
                                      label: label,
                                      future: () {
                                        //return fetchData();
                                      },
                                      getSelectedValue: (value) {
                                        FocusScope.of(context).unfocus();
                                        context
                                            .read(userInfoProvider)
                                            .seachController
                                            .clear();
                                        //Navigator.pop(context, arguments: value.value);
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: IconButton(
                                          icon: SvgPicture.asset(
                                            AppImages.searchIcon,
                                          ),
                                          onPressed: () {},
                                        ),
                                        hintText: "Search",
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: ThemeConfig.greyColor,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: AppStrings.fontFamily,
                                        ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ) //
                                      ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: AppTextView.getAppTextViewBold('Cancel',
                                size: AppFontSizes.titleFontSize16,
                                color: ThemeConfig.darkColor,
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:
                                List.generate(countryList.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  print("country object:: $_selectedOption");
                                  selectedCountryIndex = index;
                                  context
                                          .read(userInfoProvider)
                                          .selectedCountryName =
                                      countryList[index].countryName;
                                  context
                                          .read(userInfoProvider)
                                          .selectedCountryCode =
                                      countryList[index].countryCode;
                                  context.read(userInfoProvider).index =
                                      countryList[index].id;
                                  context
                                          .read(userInfoProvider)
                                          .selectedCountryFlag =
                                      countryList[index].countryFlag;
                                  _selectedOption =
                                      countryList[index].countryCode;

                                  final selected = context
                                      .read(userInfoProvider)
                                      .updateCountryUI(countryList[index]);
                                  print("selected country object:: $selected");
                                  context.read(userInfoProvider).setCountry(
                                      countryList[index].countryCode);
                                  context
                                      .read(userInfoProvider)
                                      .validUserInfo();
                                  Navigator.of(context)
                                      .pop((countryList[index]));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: CountryView(
                                    countryName: countryList[index].countryName,
                                    countryFlag: countryList[index].countryFlag,
                                    countryCode: countryList[index].countryCode,
                                    index: selectedCountryIndex == index,
                                    onChanged: (String value) {
                                      _selectedOption =
                                          countryList[index].countryCode;
                                      print(
                                          "country object:: $_selectedOption");
                                      print("clicked country object:: "
                                          "${countryList[index].countryCode}");
                                      context.read(userInfoProvider).country =
                                          value.trim();
                                    },
                                    selected:
                                        _selectedOption.toString().isNotEmpty,
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

class CountryList extends StatelessWidget {
  final String countryName;
  final String countryFlag;
  final String countryCode;
  final VoidCallback onTap;
  final bool selected;
  final dummyList = [];
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;

  CountryList({
    Key? key,
    required this.countryName,
    required this.countryFlag,
    required this.countryCode,
    required this.onTap,
    required this.selected,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
              height: 56.h,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                color: ThemeConfig.editTextGB.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              ),
              child: CountryClickView(
                countryName: countryName,
                countryFlag: countryFlag,
                countryCode: countryCode,
                //onTap: onTap,
                selected: selected,
                onChanged: (value) => onChanged!(value),
              )),
        ),
      ],
    );
  }
}
