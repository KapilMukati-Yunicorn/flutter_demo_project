import 'dart:convert';
import 'dart:io';

import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/api_urls.dart';
import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/core/themes/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../constants/api_keys.dart';
import '../constants/icons_constant.dart';
import '../constants/image_constants.dart';
import '../constants/string_constants.dart';

class CommonWidgets {
  static appBar({
    String? title,
    bool wantBackButton = true,
    bool centerTitle = true,
    bool showColorBackButton = false,
    List<Widget>? actions,
  }) {
    return AppBar(
      elevation: 0,
      shadowColor: AppColors.appBarColor,
      surfaceTintColor: AppColors.appBarColor,
      foregroundColor: AppColors.appBarColor,
      backgroundColor: AppColors.appBarColor,

      leading: wantBackButton
          ? GestureDetector(
              onTap: () {
                NavigationService.pop();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Center(
                  child: appIcons(
                    assetName: IconConstants.icBack,
                    height: 35.h,
                    width: 35.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
          : null,
      centerTitle: centerTitle ?? true,
      title: Text(title ?? '', style: AppTextStyle.titleStyle20bw),
      actions: actions,
    );
  }

  /// BackGround frame
  static Widget customBackgroundFrame({
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? splashColor,
    bool showLoading = false,
    required VoidCallback onPressed,
    Widget? child,
    required BuildContext context,
  }) {
    return Container(
      height: height ?? 50.h,
      width: width ?? 50.h,
      margin: buttonMargin,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        gradient: LinearGradient(
          colors: [Color(0xFF34C8E8), Color(0xFF4E4AF2)],
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 9.r),
          border: GradientBoxBorder(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFFFFF).withOpacity(0.5),
                Color(0xFF000000).withOpacity(0.5),
              ],
            ),
            width: 3.w,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: showLoading
            ? Center(
                child: const CircularProgressIndicator(color: AppColors.white),
              )
            : GestureDetector(
                onTap: onPressed,
                child: Container(
                  height: height ?? 50.h,
                  width: width ?? 50.h,
                  alignment: Alignment.center,
                  child: child,
                ),
              ),
      ),
    );
  }

  ///For Full Size Use In Column Not In ROW
  static Widget commonElevatedButton({
    Key? buttonKey,
    Key? loadingKey,
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? splashColor,
    bool showLoading = false,
    Color? buttonColor,
    TextStyle? textStyle,
    double? elevation,
    required VoidCallback onPressed,
    Widget? child,
    Decoration? decoration,
    BoxBorder? border,
    required BuildContext context,
  }) {
    return Container(
      height: height ?? 60.h,
      width: width ?? double.infinity,
      margin: buttonMargin,
      alignment: Alignment.center,
      decoration:
          decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            color: buttonColor ?? AppColors.primary,
          ),
      clipBehavior: Clip.hardEdge,
      child: showLoading
          ? Container(
              key: loadingKey,
              alignment: Alignment.center,
              decoration:
                  decoration ??
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: buttonColor ?? AppColors.primary,
                  ),
              child: const CircularProgressIndicator(color: AppColors.white),
            )
          : GestureDetector(
              key: buttonKey,
              onTap: onPressed,
              child: Container(
                height: height ?? 60.h,
                width: width ?? double.infinity,
                alignment: Alignment.center,
                decoration:
                    decoration ??
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: buttonColor ?? AppColors.primary,
                    ),
                child: child,
              ),
            ),
    );
  }

  ///For Full Size Use In Column Not In ROW
  static Widget commonGradientButton({
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    bool wantContentSizeButton = false,
    bool isLoading = false,
    Color? buttonColor,
    TextStyle? textStyle,
    double? elevation,
    required VoidCallback onPressed,
    Widget? child,
    BoxBorder? border,
  }) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: wantContentSizeButton ? height : 50.h,
        width: wantContentSizeButton ? width : double.infinity,
        margin: buttonMargin,
        alignment: Alignment.center,
        decoration: kGradientBoxDecoration(
          borderRadius: borderRadius,
          showGradientBorder: true,
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              )
            : child ?? const Text(''),
      ),
    );
  }

  static imageView({
    double? width,
    double? height,
    double? radius,
    required String image,
    String? defaultNetworkImage,
    BoxFit? fit,
    BorderRadiusGeometry? borderRadius,
  }) {
    return SizedBox(
      height: height ?? 64.h,
      width: width ?? double.infinity,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 8.r),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: fit ?? BoxFit.cover,
          errorWidget: (context, error, stackTrace) {
            return Container(
              height: height ?? 64.h,
              width: width ?? double.infinity,
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(.2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius ?? 8.r),
                child: defaultNetworkImage != null
                    ? imageView(image: defaultNetworkImage)
                    : Icon(Icons.error, color: AppColors.primary),
              ),
            );
          },
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return SizedBox(
              height: height ?? 64.h,
              width: width ?? double.infinity,
              child: Shimmer.fromColors(
                baseColor: Theme.of(
                  context,
                ).colorScheme.onSecondary.withOpacity(.4),
                highlightColor: Theme.of(context).colorScheme.onSecondary,
                child: Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSecondary.withOpacity(.4),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static Widget dataNotFound() {
    return Center(child: Image.asset(ImageConstants.imageNoDataFound));
  }

  static BoxDecoration kGradientBoxDecoration({
    double? borderRadius,
    bool showGradientBorder = false,
    Color? defaultColor,
  }) {
    return BoxDecoration(
      gradient: showGradientBorder
          ? LinearGradient(
              colors: [
                const Color(0xffFF4292),
                const Color(0xffFF4292).withOpacity(0.7),
                const Color(0xff5588FE).withOpacity(0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : LinearGradient(
              colors: [
                defaultColor ?? Colors.grey,
                defaultColor ?? Colors.grey,
              ],
            ),
      borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
    );
  }

  static Widget appIcons({
    required String assetName,
    double? width,
    double? height,
    double? borderRadius,
    Color? color,
    BoxFit? fit,
    VoidCallback? onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset(
          assetName == '' ? IconConstants.icMinus : assetName,
          height: height ?? 24.h,
          width: width ?? 24.w,
          color: color,
          fit: fit ?? BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return SizedBox(height: height ?? 24.h, width: width ?? 24.w);
          },
        ),
      ),
    );
  }

  static Widget verticalSpace({double? height}) {
    return SizedBox(height: height ?? 10.h);
  }

  static Widget horizontalSpace({double? width}) {
    return SizedBox(width: width ?? 10.w);
  }

  static Widget customProgressBar({
    required bool inAsyncCall,
    double? width,
    Widget? child,
    Color? backgroundColor,
    bool overlapped = false,
    double? height,
  }) {
    return Container(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: inAsyncCall
            ? backgroundColor ?? backgroundColor
            : backgroundColor,
      ),
      clipBehavior: Clip.hardEdge,
      child: inAsyncCall
          ? overlapped
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                          appIcons(
                            assetName: IconConstants.icLogo,
                            width: 30.w,
                            height: 30.h,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                      Opacity(opacity: 0.3, child: child ?? const SizedBox()),
                    ],
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircularProgressIndicator(color: AppColors.primary),
                      appIcons(
                        assetName: IconConstants.icLogo,
                        width: 30.w,
                        height: 30.h,
                        fit: BoxFit.fill,
                      ),
                    ],
                  )
          : child ?? const SizedBox(),
    );
  }

  static InputDecoration inputDecoration({
    String? hintText,
    String? labelText,
    String? errorText,
    EdgeInsetsGeometry? contentPadding,
    Color? fillColor,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? errorStyle,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool? filled,
  }) {
    return InputDecoration(
      errorText: errorText,
      counterText: '',
      errorStyle: AppTextStyle.titleStyle16gr,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      hintText: hintText,
      labelText: labelText,
      labelStyle: AppTextStyle.titleStyle14b,
      fillColor: AppColors.primary,
      // filled: filled ?? false,
      contentPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
      hintStyle: AppTextStyle.titleStyle14b,
      disabledBorder: border(color: AppColors.lightTextColor),
      border: border(color: AppColors.primary),
      errorBorder: border(color: AppColors.errorColor),
      enabledBorder: border(color: AppColors.primary),
      focusedErrorBorder: border(),
      focusedBorder: border(),
    );
  }

  static border({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? AppColors.primary, width: 2.w),
      borderRadius: BorderRadius.circular(14.r),
    );
  }

  static Widget gradientText(String? text, double? fontSize) {
    return GradientText(
      text ?? '',
      gradientDirection: GradientDirection.ltr,
      style: TextStyle(fontSize: fontSize ?? 16.0.sp),
      colors: [
        const Color(0xffFF4292),
        const Color(0xffFF4292).withOpacity(0.7),
        const Color(0xff5588FE).withOpacity(0.6),
      ],
    );
  }

  static Widget commonTextField({
    Key? key,
    double? elevation,
    String? hintText,
    String? labelText,
    String? errorText,
    EdgeInsetsGeometry? contentPadding,
    TextEditingController? controller,
    int? maxLines,
    double? cursorHeight,
    double? horizontalPadding,
    double? prefixIconHorizontal,
    bool wantBorder = false,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    Color? fillColor,
    Color? initialBorderColor,
    double? initialBorderWidth,
    TextInputType? keyboardType,
    double? borderRadius,
    double? maxHeight,
    TextStyle? hintStyle,
    TextStyle? style,
    TextStyle? labelStyle,
    TextStyle? errorStyle,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool autofocus = false,
    bool readOnly = false,
    bool hintTextColor = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    AutovalidateMode? autoValidateMode,
    int? maxLength,
    GestureTapCallback? onTap,
    bool obscureText = false,
    FocusNode? focusNode,
    Decoration? decoration,
    bool? filled,
    bool isCard = false,
  }) {
    return Padding(
      padding: contentPadding ?? EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText ?? '',
            style: labelStyle ?? AppTextStyle.titleStyle14w,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 5.h),
            //  padding: EdgeInsets.only(bottom: 5.px),
            decoration:
                decoration ??
                BoxDecoration(
                  color: fillColor ?? AppColors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                  border: Border.all(
                    color: isCard ? AppColors.primary : AppColors.white,
                    width: 1.w,
                  ),
                ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding ?? 16.h,
              ),
              child: Row(
                children: [
                  prefixIcon ?? const SizedBox(),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 3.w, top: 9.h, right: 3.w),
                      child: TextFormField(
                        key: key,
                        focusNode: focusNode,
                        obscureText: obscureText,
                        onTap: onTap,
                        maxLines: maxLines ?? 1,
                        maxLength: maxLength,
                        cursorHeight: cursorHeight,
                        cursorColor: AppColors.primary,
                        autovalidateMode:
                            autoValidateMode ??
                            AutovalidateMode.onUserInteraction,
                        controller: controller,
                        onChanged:
                            onChanged ??
                            (value) {
                              value = value.trim();
                              if (value.isEmpty ||
                                  value.replaceAll(" ", "").isEmpty) {
                                controller?.text = "";
                              }
                            },
                        validator: validator,
                        keyboardType:
                            defaultTargetPlatform == TargetPlatform.iOS
                            ? const TextInputType.numberWithOptions(
                                decimal: true,
                                signed: true,
                              )
                            : keyboardType ?? TextInputType.text,
                        readOnly: readOnly,
                        autofocus: autofocus,
                        inputFormatters: inputFormatters,
                        textCapitalization: textCapitalization,
                        style: style ?? AppTextStyle.titleStyle14bw,
                        decoration: InputDecoration(
                          errorText: errorText,
                          counterText: '',
                          errorStyle:
                              errorStyle ?? AppTextStyle.titleStyleError(),
                          hintText: hintText,
                          hintStyle: hintStyle ?? AppTextStyle.titleStyle12w,
                          fillColor: fillColor ?? AppColors.primary,
                          filled: filled ?? false,
                          contentPadding:
                              contentPadding ?? EdgeInsets.only(bottom: 14.h),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  suffixIcon ?? const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static countryCodePicker({
    ValueChanged<CountryCode>? onChanged,
    String? initialSelection,
  }) {
    return CountryCodePicker(
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.primary, width: 8.w),
      ),
      searchDecoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(width: 8.w, color: AppColors.primary),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(width: 8.w, color: AppColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(width: 8.w, color: AppColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(width: 8.w, color: AppColors.errorColor),
        ),
      ),
      padding: EdgeInsets.zero,
      showFlagMain: true,
      hideMainText: true,
      flagWidth: 24.w,
      onChanged: onChanged,
      initialSelection: initialSelection ?? 'IN',
      showCountryOnly: true,
      showDropDownButton: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
      textStyle: AppTextStyle.titleStyle14bb,
    );
  }

  static Widget commonOtpView({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    PinCodeFieldShape? shape,
    TextInputType keyboardType = TextInputType.number,
    List<TextInputFormatter>? inputFormatters,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onCompleted,
    int length = 4,
    double? height,
    double? width,
    double? borderRadius,
    double? borderWidth,
    bool readOnly = false,
    bool autoFocus = false,
    bool enableActiveFill = true,
    bool enablePinAutofill = true,
    bool autoDismissKeyboard = true,
    TextStyle? textStyle,
    Color? cursorColor,
    Color? inactiveColor,
    Color? inactiveFillColor,
    Color? activeColor,
    Color? activeFillColor,
    Color? selectedColor,
    Color? selectedFillColor,
  }) => PinCodeTextField(
    length: length,
    mainAxisAlignment: mainAxisAlignment,
    hintCharacter: '●',
    hintStyle: AppTextStyle.titleStyle20bb,
    //obscureText: true,
    appContext: NavigationService.navigatorKey.currentContext!,
    cursorColor: AppColors.primary,
    autoFocus: autoFocus,
    keyboardType: keyboardType,

    inputFormatters:
        inputFormatters ??
        <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
    readOnly: readOnly,
    textStyle: textStyle ?? AppTextStyle.titleStyle20bb,
    autoDisposeControllers: false,
    enabled: true,
    animationType: AnimationType.fade,
    pinTheme: PinTheme(
      inactiveColor: Colors.grey.withOpacity(0.8),
      inactiveFillColor: Colors.transparent,
      activeColor: Colors.grey.withOpacity(0.8),
      activeFillColor: Colors.transparent,
      selectedColor: AppColors.primary,
      selectedFillColor: Colors.transparent,
      shape: shape ?? PinCodeFieldShape.underline,
      fieldWidth: width ?? 45.w,
      fieldHeight: height ?? 45.h,
      borderWidth: borderWidth ?? 5.w,
      borderRadius: BorderRadius.circular(borderRadius ?? 3.r),
    ),
    enableActiveFill: enableActiveFill,
    controller: controller,
    onChanged: onChanged,
    enablePinAutofill: enablePinAutofill,
    onCompleted: onCompleted,
    autoDismissKeyboard: autoDismissKeyboard,
  );

  static Widget profileStackWidget({
    required List<String> profileImageUrls,
    double avatarSize = 50.0,
    double spacing = 10.0,
  }) {
    List<Widget> stackLayers = List<Widget>.generate(profileImageUrls.length, (
      index,
    ) {
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * spacing, 0, 0, 0),
        child: CommonWidgets.imageView(
          image: profileImageUrls[index],
          height: avatarSize,
          width: avatarSize,
          borderRadius: BorderRadius.circular(avatarSize / 2),
          defaultNetworkImage: ApiUrlConstants.imageError,
        ),
      );
    });

    return Stack(children: stackLayers);
  }

  static Future<bool> internetConnectionCheckerMethod() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com/'));
      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  snackBarView({String title = '', bool success = false}) {
    var snackBar = SnackBar(
      content: Text(title, style: AppTextStyle.titleStyle14bb),
      backgroundColor: success ? Colors.green : Colors.redAccent,
    );
    return ScaffoldMessenger.of(
      NavigationService.navigatorKey.currentContext!,
    ).showSnackBar(snackBar);
  }

  ///For Check Post Api Response
  static Future<bool> responseCheckForPostMethod({
    http.Response? response,
    bool wantSnackBar = true,
  }) async {
    Map<String, dynamic> responseMap = jsonDecode(response?.body ?? "");
    if (wantSnackBar) {
      if (responseMap[ApiKeyConstants.message] != null) {
        snackBarView(
          title: responseMap[ApiKeyConstants.message],
          success: true,
        );
      }
      if (responseMap[ApiKeyConstants.error] != null) {
        snackBarView(title: responseMap[ApiKeyConstants.error]);
      }
    }
    if (response != null && response.statusCode == 200) {
      return true;
    } else if (response != null && response.statusCode == 401) {
      return false;
    } else {
      return false;
    }
  }

  ///For Check Get Api Response
  static Future<bool> responseCheckForGetMethod({
    http.Response? response,
    bool wantSuccessToast = false,
    bool wantErrorToast = true,
  }) async {
    Map<String, dynamic> responseMap = jsonDecode(response?.body ?? "");
    if (response != null && response.statusCode == 200) {
      return true;
    } else if (response != null && response.statusCode == 401) {
      return false;
    } else {
      return false;
    }
  }

  static void showAlertDialog({
    String title = StringConstants.logout,
    String content = StringConstants.wouldYouLikeToLogout,
    VoidCallback? onPressedYes,
  }) {
    showCupertinoModalPopup<void>(
      context: NavigationService.navigatorKey.currentContext!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => NavigationService.pop(),
            child: Text(StringConstants.no),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: onPressedYes,
            child: Text(StringConstants.yes),
          ),
        ],
      ),
    );
  }

  static void networkConnectionShowSnackBar() {
    snackBarView(title: "Check Your Internet Connection", success: false);
  }

  static void serverDownShowSnackBar() {
    snackBarView(title: "Server Down", success: false);
  }

  static Widget progressBar({
    bool isLoading = false,
    Widget? child,
    double? height,
    double? width,
  }) {
    return Container(
      height: height ?? 50.h,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 4.w,
              ),
            )
          : child,
    );
  }
}

enum ErrorAnimationType { shake, clear }
