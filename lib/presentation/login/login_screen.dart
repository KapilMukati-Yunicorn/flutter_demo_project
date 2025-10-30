import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/icons_constant.dart';
import 'package:bloc_project/core/constants/image_constants.dart';
import 'package:bloc_project/core/constants/string_constants.dart';
import 'package:bloc_project/core/keys/widget_keys.dart';
import 'package:bloc_project/core/themes/app_text_style.dart';
import 'package:bloc_project/core/validators/input_validators.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/logic/login/login_bloc.dart';
import 'package:bloc_project/logic/login/login_event.dart';
import 'package:bloc_project/logic/login/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() =>_LoginState();
}
class _LoginState extends State<LoginScreen>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context)=>LoginBloc(),
      child: BlocListener<LoginBloc,LoginState>(
          listener: (context,state){

      },
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          resizeToAvoidBottomInset: false,
          body: BlocBuilder<LoginBloc,LoginState>(
              builder: (context,state){
                return Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              ImageConstants.imgBg,
                            ),
                          fit: BoxFit.cover
                        ),

                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 10.h),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CommonWidgets.appIcons(assetName: ImageConstants.imgCycle2,
                                  width: 250.w,height: 200.h),
                              CommonWidgets.verticalSpace(height: 50),
                              CommonWidgets.commonTextField(
                                key: WidgetKeys.loginEmailField,
                                controller: emailController,
                                validator: InputValidators.validateEmail,
                                  hintText: StringConstants.enterEmail,
                                  labelText: StringConstants.email,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (email)=>context.read<LoginBloc>().add(EmailChange(email))
                              ),
                              CommonWidgets.commonTextField(
                                  key: WidgetKeys.loginPasswordField,
                                controller: passwordController,
                                  validator: InputValidators.validatePassword,
                                  hintText: StringConstants.enterPassword,
                                  labelText: StringConstants.password,
                                  keyboardType: TextInputType.visiblePassword,
                                  onChanged: (password)=>context.read<LoginBloc>().add(PasswordChange(password))
                              ),
                      
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30.h,left: 40.w,right: 40.w,
                        child: Column(
                          children: [
                            CommonWidgets.commonElevatedButton(
                                buttonKey:WidgetKeys.loginButton,
                                loadingKey:WidgetKeys.loginLoading,
                                onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    context.read<LoginBloc>().add(ClickOnLoginButton());
                                  }else{

                                  }
                                },
                                context: context,
                                showLoading: state.isSubmitting,
                              child: Text(StringConstants.login,style: AppTextStyle.titleStyle16bw,)
                            ),
                            CommonWidgets.verticalSpace(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(StringConstants.doNotHaveAnAccount,style: AppTextStyle.titleStyle14w,),
                                CommonWidgets.horizontalSpace(width: 5),
                                GestureDetector(
                                  key: WidgetKeys.loginSignupButton,
                                  onTap: (){
                                    context.read<LoginBloc>().add(ClickOnSignUpButton());
                                  },
                                    child: Text(StringConstants.signUp,style: AppTextStyle.titleStyle16gr,)),
                              ],
                            )
                          ],
                        )
                    )

                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}