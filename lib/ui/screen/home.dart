import 'package:flutter/material.dart';
import 'package:simcard_charging/data/api/dio_api_service.dart';
import 'package:simcard_charging/data/config_data.dart';
import 'package:simcard_charging/data/entity/charge.dart';
import 'package:simcard_charging/ui/color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simcard_charging/ui/component/operators.dart';
import 'package:simcard_charging/ui/component/price.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  String currentOperator = 'MCI';
  String currentPrice = '10000';
  int currentIndexPrice = 0;
  int currentIndexOperator = 0;

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _customAppbar(context),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 56 - 24,
                decoration: const BoxDecoration(
                  color: ColorPalette.surfaceColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 19,
                        color: ColorPalette.contentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _customText('اپراتور'),
                              const SizedBox(
                                height: 8,
                              ),
                              OperatorList(
                                selectOperatorIndex: currentIndexOperator,
                                onTap: (newIndex) {
                                  currentIndexOperator = newIndex;
                                },
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              _customText('شماره موبایل'),
                              const SizedBox(
                                height: 8,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: _shadowOnTextField(
                                  textFieldHint:
                                      'لطفا شماره موبایل خود را وارد کنید...',
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              _customText('مبلغ'),
                              const SizedBox(
                                height: 8,
                              ),
                              PriceItem(
                                  selectedIndex: currentIndexPrice,
                                  onTap: (newIndex) {
                                    currentIndexPrice = newIndex;
                                  }),
                              const Spacer(),
                              _customButton(
                                context,
                                phoneNumber: phoneController.text,
                              ),
                              const SizedBox(
                                height: 12,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  MaterialButton _customButton(BuildContext context,
      {required String phoneNumber}) {
    return MaterialButton(
      onPressed: () {
        if (!validationPhoneNumber(phoneNumber)) {
          showSnackBar(context, message: 'لطفن شماره تلفن را درست وارد کنید!!');
          return;
        }
        if (currentOperator == 'MCI' && currentPrice == '10000') {
          showSnackBar(context,
              message: 'شارژ 1000 تومانی برای همراه اول پشتیبانی نمیکند!!');
        }
        convertIndexListToStringValue();
        sendRequest();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: ColorPalette.buttonColor,
      minWidth: double.infinity,
      height: 45,
      child: const Text(
        'خرید شارژ',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontFamily: 'CustomFont',
          fontSize: 20,
        ),
      ),
    );
  }

  Container _shadowOnTextField({required String textFieldHint}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: _mobileTextField(
        controller: phoneController,
        hint: textFieldHint,
      ),
    );
  }

  Text _customText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontFamily: 'CustomFont',
          fontSize: 14,
          color: ColorPalette.onPrimary),
    );
  }

  TextFormField _mobileTextField(
      {required String hint, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      onChanged: (text) {
        if (text.length == 11) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      keyboardType: TextInputType.number,
      maxLength: 11,
      maxLines: 1,
      decoration: InputDecoration(
        counterText: '',
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'CustomFont',
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  SizedBox _customAppbar(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 56,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                'خرید شارژ',
                style: TextStyle(
                    fontFamily: 'CustomFont',
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: ColorPalette.onPrimary),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Image.asset(
              'img/charge.png',
              width: 28,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  bool validationPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('09') && phoneNumber.length == 11) {
      return true;
    }
    return false;
  }

  void showSnackBar(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'CustomFont',
              color: ColorPalette.onPrimary,
            ),
          ),
        ),
        backgroundColor: ColorPalette.primaryColor,
      ),
    );
  }

  convertIndexListToStringValue() {
    currentPrice = Data.prices[currentIndexPrice];
    switch (currentIndexOperator) {
      case 0:
        currentOperator = 'MCI';
        break;
      case 1:
        currentOperator = 'MTN';
        break;
      case 2:
        currentOperator = 'RTL';
        break;
    }
  }

  void sendRequest() async {
    Charge charge = Charge(
      type: currentOperator,
      amount: currentPrice.substring(0, currentPrice.length - 1),
      callPhone: phoneController.text,
    );
    String url = await apiService.chargeSimCard(charge);
    _launchUrl(Uri.parse(url));
  }

  void _launchUrl(Uri url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }
}
