import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/keys/widget_keys.dart';
import 'package:bloc_project/logic/signup/signup_bloc.dart';
import 'package:bloc_project/logic/signup/signup_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/image_constants.dart';
import '../../core/constants/string_constants.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/validators/input_validators.dart';
import '../../core/widgets/common_widgets.dart';
import '../../logic/signup/signup_event.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() =>_SignUpState();
}

class _SignUpState extends State<SignUpScreen>{
  final _formKey= GlobalKey<FormState>();
  TextEditingController userNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController cnfPasswordController=TextEditingController();

  @override
  void dispose() {
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    cnfPasswordController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
        create: (context)=>SignUpBloc(),
      child: BlocListener<SignUpBloc,SignUpState>(
          listener: (context,state){

      },
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          appBar: CommonWidgets.appBar(),
          body: BlocBuilder<SignUpBloc,SignUpState>(
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 10.h),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CommonWidgets.verticalSpace(height: 10),
                              Container(
                                height: 120.h,
                                width: 120.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.primary,width: 2.w)
                                ),
                                child: GestureDetector(
                                  onTap: (){
                                    context.read<SignUpBloc>().add(PickUserProfile());
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      state.userProfile!=null?
                                      Image.file(
                                        state.userProfile!,
                                        height: 120.h,
                                        width: 120.h,
                                        fit: BoxFit.cover,
                                      ):CommonWidgets.appIcons(
                                          assetName: ImageConstants.imgHelmet,
                                        height: 120.h,
                                        width: 120.h,
                                        fit: BoxFit.cover,
                                      ),
                                      Icon(Icons.photo_camera,size: 40.h,color: AppColors.white,)
                                    ],
                                  ),
                                ),
                              ),
                              CommonWidgets.verticalSpace(height: 20),
                              CommonWidgets.commonTextField(
                                key: WidgetKeys.signupNameField,
                                  controller: userNameController,
                                  validator: InputValidators.validateName,
                                  hintText: StringConstants.enterUserName,
                                  labelText: StringConstants.userName,
                                  keyboardType: TextInputType.name,
                                  onChanged: (email)=>context.read<SignUpBloc>().add(UserNameChange(email))
                              ),
                              CommonWidgets.commonTextField(
                                  key: WidgetKeys.signupEmailField,
                                  controller: emailController,
                                  validator: InputValidators.validateEmail,
                                  hintText: StringConstants.enterEmail,
                                  labelText: StringConstants.email,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (email)=>context.read<SignUpBloc>().add(EmailChange(email))
                              ),
                              CommonWidgets.commonTextField(
                                  key: WidgetKeys.signupPasswordField,
                                  controller: passwordController,
                                  validator: InputValidators.validatePassword,
                                  hintText: StringConstants.enterPassword,
                                  labelText: StringConstants.password,
                                  keyboardType: TextInputType.visiblePassword,
                                  onChanged: (password)=>context.read<SignUpBloc>().add(PasswordChange(password))
                              ),
                              CommonWidgets.commonTextField(
                                  key: WidgetKeys.signupCnfPasswordField,
                                  controller: cnfPasswordController,
                                  validator: InputValidators.validatePassword,
                                  hintText: StringConstants.enterCnfPassword,
                                  labelText: StringConstants.cnfPassword,
                                  keyboardType: TextInputType.visiblePassword,
                                  onChanged: (password)=>context.read<SignUpBloc>().add(CnfPasswordChange(password))
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

                                onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    context.read<SignUpBloc>().add(ClickOnSignUpButton());
                                  }else{

                                  }
                                },
                                buttonKey: WidgetKeys.signupButton,
                                loadingKey: WidgetKeys.signupLoadingButton,
                                context: context,
                                showLoading: state.isSubmitting,
                                child: Text(StringConstants.signUp,style: AppTextStyle.titleStyle16bw,)
                            ),
                            CommonWidgets.verticalSpace(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(StringConstants.iHaveAlreadyAccount,style: AppTextStyle.titleStyle14w,),
                                CommonWidgets.horizontalSpace(width: 5),
                                GestureDetector(
                                    onTap: (){
                                      context.read<SignUpBloc>().add(ClickOnLoginButton());
                                    },
                                    child: Text(StringConstants.login,style: AppTextStyle.titleStyle16gr,)),
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