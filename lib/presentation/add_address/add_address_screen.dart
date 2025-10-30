import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/string_constants.dart';
import 'package:bloc_project/core/themes/app_text_style.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/logic/add_address/add_address_bloc.dart';
import 'package:bloc_project/logic/add_address/add_address_event.dart';
import 'package:bloc_project/logic/add_address/add_address_state.dart';
import 'package:bloc_project/logic/delivery_address/delivery_address_bloc.dart';
import 'package:bloc_project/logic/delivery_address/delivery_address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/validators/input_validators.dart';
class AddAddressScreen extends StatefulWidget{
  const AddAddressScreen({super.key});
  @override
  State<AddAddressScreen> createState()=>_AddAddressState();
}

class _AddAddressState extends State<AddAddressScreen>{
  TextEditingController typeController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController houseNumberController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController pinCodeController=TextEditingController();
  TextEditingController stateController=TextEditingController();
   final _formKey= GlobalKey<FormState>();

   @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    typeController.clear();
    addressController.clear();
    houseNumberController.clear();
    cityController.clear();
    pinCodeController.clear();
    stateController.clear();
  }
   @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>AddAddressBloc(),
      child:BlocListener<AddAddressBloc,AddAddressState>(listener: (context,state){

      },
        child: BlocBuilder<AddAddressBloc,AddAddressState>(builder: (context,state){
          return Scaffold(
            appBar: CommonWidgets.appBar(title: StringConstants.addNewAddress),
            backgroundColor: AppColors.backGroundColor,
            floatingActionButton:    BlocBuilder<DeliveryAddressBloc,DeliveryAddressState>(builder: (context,deliveryState){
              return CommonWidgets.commonElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){

                      context.read<AddAddressBloc>().add(ClickOnAddNewAddressButton(deliveryState.addressList.length));
                    }else{

                    }
                  },
                  context: context,
                  showLoading: state.isSubmitting,
                  buttonMargin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Text(StringConstants.addNewAddress,style: AppTextStyle.titleStyle18bw,)
              );
            }),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            body: Form(
              key:  _formKey,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CommonWidgets.commonTextField(
                       controller: typeController,
                       validator: InputValidators.validateField,
                        hintText: StringConstants.enterHere,
                        labelText: StringConstants.selectAddressType,
                        onChanged: (type)=>context.read<AddAddressBloc>().add(AddressUpdated(type: type))
                      ),
                      CommonWidgets.commonTextField(
                          controller: addressController,
                          validator: InputValidators.validateField,
                          hintText: StringConstants.enterHere,
                          labelText: StringConstants.address,
                          onChanged: (address)=>context.read<AddAddressBloc>().add(AddressUpdated(address: address))
                      ),
                      CommonWidgets.commonTextField(
                          controller: houseNumberController,
                          validator: InputValidators.validateField,
                          hintText: StringConstants.enterHere,
                          labelText: StringConstants.houseNumber,
                          onChanged: (houseNumber)=>context.read<AddAddressBloc>().add(AddressUpdated(houseNumber: houseNumber))
                      ),
                      CommonWidgets.commonTextField(
                          controller: cityController,
                          validator: InputValidators.validateField,
                          hintText: StringConstants.enterHere,
                          labelText: StringConstants.city,
                          onChanged: (city)=>context.read<AddAddressBloc>().add(AddressUpdated(city: city))
                      ),
                      CommonWidgets.commonTextField(
                          controller: pinCodeController,
                          validator: InputValidators.validateField,
                          hintText: StringConstants.enterHere,
                          labelText: StringConstants.pinCode,
                          onChanged: (pinCode)=>context.read<AddAddressBloc>().add(AddressUpdated(pinCode: pinCode))
                      ),
                      CommonWidgets.commonTextField(
                          controller: stateController,
                          validator: InputValidators.validateField,
                          hintText: StringConstants.enterHere,
                          labelText: StringConstants.state,
                          onChanged: (state)=>context.read<AddAddressBloc>().add(AddressUpdated(state: state))
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ) ,
    );
  }
}