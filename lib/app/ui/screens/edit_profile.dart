import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steels/app/controller/auth.dart';
import 'package:steels/app/controller/fileupload.dart';
import 'package:steels/app/ui/screens/profile/profile_screen.dart';
import '../../controller/profile.dart';
import '../themes/colors.dart';
import '../themes/font_size.dart';
import '../widgets/common/button.dart';
import '../widgets/common/common_textform.dart';
import '../widgets/common/intl_phone_field.dart';
import '../widgets/common/loading.dart';
import '../widgets/common/text.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileController(),
        initState: (_) {
          ProfileController.to.addressFieldsEmpty();
          ProfileController.to.billingAsSameShipping = false;
          ProfileController.to.setData();
        },
        builder: (_) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.primary,
                automaticallyImplyLeading: true,
                title: CommonText(
                  text: "Edit Profile",
                  style: mediumText(fontSize: 18, color: AppColors.white),
                ),
              ),
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: ProfileController.to.addressKey,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          const SizedBox(height: 10),

                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                // FileUploadController.to
                                //     .showSelectionDialog(profileMode: false);
                                // print(
                                //     "RETURN TYPE OF IMAGE IS: ${FileUploadController.to.imageFile}");
                              },
                              child: Container(
                                height: 180,
                                width: 180,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 1.3,
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(150),
                                  child: Obx(
                                    () =>
                                        FileUploadController.to.isFilePicked ==
                                                false
                                            ? Image.network(
                                                "${ProfileController.to.profileDetails.avatarUrl}",
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File(FileUploadController
                                                    .to.imageFile),
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          //Profile
                          Row(
                            children: [
                              CommonText(
                                  text: "Personal Details",
                                  style: mediumText(fontSize: 18)),
                            ],
                          ),

                          CommonTextFormField(
                            hintText: "First Name",
                            controller: ProfileController.to.firstName,
                            validator: (data) {
                              if (data == null || data.isEmpty || data == "") {
                                return 'Please enter first name';
                              }
                              return null;
                            },
                          ),
                          CommonTextFormField(
                            hintText: "User Name",
                            controller: ProfileController.to.userName,
                            validator: (data) {
                              if (data == null || data.isEmpty || data == "") {
                                return 'Please enter username';
                              }
                              return null;
                            },
                          ),

                          //Billing Address
                          Row(
                            children: [
                              CommonText(
                                  text: "Billing Address",
                                  style: mediumText(fontSize: 18)),
                            ],
                          ),

                          Row(
                            children: [
                              Flexible(
                                child: CommonTextFormField(
                                  hintText: "First Name",
                                  controller: ProfileController.to.bFName,
                                  validator: (data) {
                                    if (data == null ||
                                        data.isEmpty ||
                                        data == "") {
                                      return 'Please enter first name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Flexible(
                                child: CommonTextFormField(
                                  hintText: "Last Name",
                                  controller: ProfileController.to.bLName,
                                  validator: (data) {
                                    if (data == null ||
                                        data.isEmpty ||
                                        data == "") {
                                      return 'Please enter last name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          CommonTextFormField(
                            hintText: "Address Line 1",
                            controller: ProfileController.to.bAddress1,
                            validator: (data) {
                              if (data == null || data.isEmpty || data == "") {
                                return 'Please enter address';
                              }
                              return null;
                            },
                          ),
                          CommonTextFormField(
                            hintText: "Address Line 2",
                            controller: ProfileController.to.bAddress2,
                            validator: (data) {
                              // if (data == null || data.isEmpty || data == "") {
                              //   return 'Please enter first name';
                              // }
                              return null;
                            },
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: CommonTextFormField(
                                  hintText: "Country",
                                  controller: ProfileController.to.bCountry,
                                  validator: (data) {
                                    if (data == null ||
                                        data.isEmpty ||
                                        data == "") {
                                      return 'Please enter country';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Flexible(
                                child: CommonTextFormField(
                                  hintText: "State",
                                  controller: ProfileController.to.bState,
                                  validator: (data) {
                                    if (data == null ||
                                        data.isEmpty ||
                                        data == "") {
                                      return 'Please enter state';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: CommonTextFormField(
                                  hintText: "City",
                                  controller: ProfileController.to.bCity,
                                  validator: (data) {
                                    if (data == null ||
                                        data.isEmpty ||
                                        data == "") {
                                      return 'Please enter city';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Flexible(
                                child: CommonTextFormField(
                                  hintText: "PostCode",
                                  controller: ProfileController.to.bPostCode,
                                  validator: (data) {
                                    if (data == null ||
                                        data.isEmpty ||
                                        data == "") {
                                      return 'Please enter postcode';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          CommonTextFormField(
                            hintText: "Email",
                            controller: ProfileController.to.bEmail,
                            validator: (data) {
                              if (data == null || data.isEmpty || data == "") {
                                return 'Please enter email';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IntlPhoneField(
                              maxLength: 10,
                              hintText: "Phone",
                              controller: ProfileController.to.bPhone,
                              initialCountryCode: "IN",
                              fontFamily: "medium",
                              onChanged: (data) {
                                // if (data.toString().length == 10) {
                                //   ProfileController.to.phoneNumberLength = 10;
                                // } else {
                                //   ProfileController.to.phoneNumberLength = 0;
                                // }
                              },
                              validator: (data) {
                                if (data!.isEmpty || data == "") {
                                  return "Phone field required";
                                } else if (data.length < 10) {
                                  return "Phone number must be 10 character";
                                }
                                return null;
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Obx(() => Checkbox(
                                  value: ProfileController
                                      .to.billingAsSameShipping,
                                  onChanged: (data) {
                                    ProfileController.to.billingAsSameShipping =
                                        data;
                                  })),
                              CommonText(
                                text: "Same as billing",
                                style: mediumText(
                                    fontSize: 14,
                                    color: AppColors.black.withOpacity(.6)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CommonText(
                                  text: "Shipping Address",
                                  style: mediumText(fontSize: 18)),
                            ],
                          ),

                          // Shipping Address
                          Obx(() => Row(
                                children: [
                                  Flexible(
                                    child: CommonTextFormField(
                                      hintText: "First Name",
                                      controller: ProfileController
                                                  .to.billingAsSameShipping ==
                                              true
                                          ? ProfileController.to.bFName
                                          : ProfileController.to.sFName,
                                      validator: (data) {
                                        if (data == null ||
                                            data.isEmpty ||
                                            data == "") {
                                          return 'Please enter first name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: CommonTextFormField(
                                      hintText: "Last Name",
                                      controller: ProfileController
                                                  .to.billingAsSameShipping ==
                                              true
                                          ? ProfileController.to.bLName
                                          : ProfileController.to.sLName,
                                      validator: (data) {
                                        if (data == null ||
                                            data.isEmpty ||
                                            data == "") {
                                          return 'Please enter last name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          Obx(
                            () => CommonTextFormField(
                              hintText: "Address Line 1",
                              controller:
                                  ProfileController.to.billingAsSameShipping ==
                                          true
                                      ? ProfileController.to.bAddress1
                                      : ProfileController.to.sAddress1,
                              validator: (data) {
                                if (data == null ||
                                    data.isEmpty ||
                                    data == "") {
                                  return 'Please enter address';
                                }
                                return null;
                              },
                            ),
                          ),
                          Obx(
                            () => CommonTextFormField(
                              hintText: "Address Line 2",
                              controller:
                                  ProfileController.to.billingAsSameShipping ==
                                          true
                                      ? ProfileController.to.bAddress2
                                      : ProfileController.to.sAddress2,
                              validator: (data) {
                                // if (data == null || data.isEmpty || data == "") {
                                //   return 'Please enter first name';
                                // }
                                return null;
                              },
                            ),
                          ),
                          Obx(() => Row(
                                children: [
                                  Flexible(
                                    child: CommonTextFormField(
                                      hintText: "Country",
                                      controller: ProfileController
                                                  .to.billingAsSameShipping ==
                                              true
                                          ? ProfileController.to.bCountry
                                          : ProfileController.to.sCountry,
                                      validator: (data) {
                                        if (data == null ||
                                            data.isEmpty ||
                                            data == "") {
                                          return 'Please enter country';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: CommonTextFormField(
                                      hintText: "State",
                                      controller: ProfileController
                                                  .to.billingAsSameShipping ==
                                              true
                                          ? ProfileController.to.bState
                                          : ProfileController.to.sState,
                                      validator: (data) {
                                        if (data == null ||
                                            data.isEmpty ||
                                            data == "") {
                                          return 'Please enter state';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          Obx(
                            () => Row(
                              children: [
                                Flexible(
                                  child: CommonTextFormField(
                                    hintText: "City",
                                    controller: ProfileController
                                                .to.billingAsSameShipping ==
                                            true
                                        ? ProfileController.to.bCity
                                        : ProfileController.to.sCity,
                                    validator: (data) {
                                      if (data == null ||
                                          data.isEmpty ||
                                          data == "") {
                                        return 'Please enter city';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: CommonTextFormField(
                                    hintText: "PostCode",
                                    inputType: TextInputType.number,
                                    controller: ProfileController
                                                .to.billingAsSameShipping ==
                                            true
                                        ? ProfileController.to.bPostCode
                                        : ProfileController.to.sPostCode,
                                    validator: (data) {
                                      if (data == null ||
                                          data.isEmpty ||
                                          data == "") {
                                        return 'Please enter postcode';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IntlPhoneField(
                                maxLength: 10,
                                hintText: "Phone",
                                controller: ProfileController
                                            .to.billingAsSameShipping ==
                                        true
                                    ? ProfileController.to.bPhone
                                    : ProfileController.to.sPhone,
                                initialCountryCode: "IN",
                                fontFamily: "medium",
                                onChanged: (data) {
                                  // if (data.toString().length == 10) {
                                  //   ProfileController.to.phoneNumberLength = 10;
                                  // } else {
                                  //   ProfileController.to.phoneNumberLength = 0;
                                  // }
                                },
                                validator: (data) {
                                  if (data!.isEmpty || data == "") {
                                    return "Phone field required";
                                  } else if (data.length < 10) {
                                    return "Phone number must be 10 character";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommonButton(
                                text: "Save",
                                onTap: () {
                                  if (ProfileController
                                      .to.addressKey.currentState!
                                      .validate()) {
                                    ProfileController.to.updateProfile();
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                  Obx(() => ProfileController.to.updateProfileLoading == true
                      ? Container(
                          color: AppColors.black.withOpacity(.3),
                          child: const SimpleLoading(),
                        )
                      : const SizedBox())
                ],
              ));
        });
  }
}
