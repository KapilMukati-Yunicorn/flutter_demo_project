import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/icons_constant.dart';
import 'package:bloc_project/core/constants/image_constants.dart';
import 'package:bloc_project/core/constants/length.dart';
import 'package:bloc_project/core/constants/string_constants.dart';
import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/core/themes/app_text_style.dart';
import 'package:bloc_project/core/validators/input_validators.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/data/models/get_user_model.dart';
import 'package:bloc_project/logic/edit_profile/edit_profile_bloc.dart';
import 'package:bloc_project/logic/edit_profile/edit_profile_event.dart';
import 'package:bloc_project/logic/edit_profile/edit_profile_state.dart';
import 'package:bloc_project/logic/login/login_bloc.dart';
import 'package:bloc_project/logic/login/login_event.dart';
import 'package:bloc_project/logic/login/login_state.dart';
import 'package:bloc_project/logic/person/person_bloc.dart';
import 'package:bloc_project/logic/person/person_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class EditProfileScreen extends StatefulWidget{
  final UserModel userModel;
  const EditProfileScreen({super.key,required this.userModel});
  @override
  State<EditProfileScreen> createState() =>_EditProfileState();
}
class _EditProfileState extends State<EditProfileScreen>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController addressController=TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.userModel.email ?? '';
    nameController.text = widget.userModel.name ?? '';
    phoneController.text = widget.userModel.phone ?? '';
    addressController.text = widget.userModel.address ?? '';
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc()..add(FetchProfileData(widget.userModel)),
      child: BlocListener<EditProfileBloc,EditProfileState>(
        listener: (context,state){
          if(state.isSuccess){
            context.read<PersonBloc>().add(PersonDataUpdate(state.userModel!));
          }

        },
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          resizeToAvoidBottomInset: false,
          appBar: CommonWidgets.appBar(title: StringConstants.editProfile),
          body: BlocBuilder<EditProfileBloc,EditProfileState>(
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
                              CommonWidgets.verticalSpace(height: 20),
                              Container(
                                height:100.h,
                                width: 100.h,
                                decoration:BoxDecoration(
                                    color: AppColors.primary2,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.white,
                                        width: 2.w)
                                ),
                                child: CommonWidgets.appIcons(
                                    assetName: state.userModel?.image??'',
                                    height: 100

                                ),
                              ),
                              CommonWidgets.verticalSpace(height: 20),
                              CommonWidgets.commonTextField(
                                  controller: nameController,
                                  validator: InputValidators.validateName,
                                  hintText: StringConstants.enterUserName,
                                  labelText: StringConstants.userName,
                                  keyboardType: TextInputType.name,
                                  onChanged: (password)=>context.read<EditProfileBloc>().add(ChangeName(password))
                              ),
                              CommonWidgets.commonTextField(
                                  controller: emailController,
                                  validator: InputValidators.validateEmail,
                                  hintText: StringConstants.enterEmail,
                                  labelText: StringConstants.email,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (email)=>context.read<EditProfileBloc>().add(ChangeEmail(email))
                              ),
                              CommonWidgets.commonTextField(
                                  controller: phoneController,
                                  validator: InputValidators.validatePhone,
                                  hintText: StringConstants.enterPhone,
                                  labelText: StringConstants.phone,
                                  keyboardType: TextInputType.phone,
                                  onChanged: (email)=>context.read<EditProfileBloc>().add(ChangePhone(email))
                              ),
                              CommonWidgets.commonTextField(
                                  controller: addressController,
                                  validator: InputValidators.validateField,
                                  hintText: StringConstants.enterAddress,
                                  labelText: StringConstants.address,
                                  keyboardType: TextInputType.name,
                                  onChanged: (password)=>context.read<EditProfileBloc>().add(ChangeAddress(password))
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
                            CommonWidgets.customBackgroundFrame(
                                onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                     context.read<EditProfileBloc>().add(UpdateProfileData());
                                  }else{

                                  }
                                },
                                context: context,
                                showLoading: state.isSubmitting,
                                width: AppLength.screenFullWidth(),
                                child: Text(StringConstants.update,style: AppTextStyle.titleStyle16bw,)
                            ),

                            CommonWidgets.verticalSpace(height: 20),
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