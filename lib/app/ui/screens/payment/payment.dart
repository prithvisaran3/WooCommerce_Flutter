import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/payment.dart';
import '../../../controller/profile.dart';
import '../../../payment/razorpay.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/common_textform.dart';
import '../../widgets/common/intl_phone_field.dart';
import '../../widgets/common/text.dart';
import '../../widgets/common/toast.dart';
import '../../widgets/payment/payment_details.dart';
import '../../widgets/payment/payment_method.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: PaymentController(),
        initState: (_) {
          PaymentController.to.onPressedPaymentMethod = 0;
          PaymentController.to.selectIndex = 0;
          ProfileController.to.getProfile();
          Future.delayed(const Duration(seconds: 5), () {
            PaymentController.to.checkBillingAddressEmpty();
            if (PaymentController.to.billingAddressEmpty == true) {
              commonToast(
                  msg:
                      "Your profile don't have saved billing address\nPlease fill the address");
            } else {
              commonToast(msg: "Have an Address");
              PaymentController.to.setData();
            }
          });
        },
        builder: (_) {
          return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  // toolbarHeight: 55,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  centerTitle: true,
                  title: CommonText(
                    text: "Checkout",
                    style: boldText(
                      color: AppColors.primary,
                      fontSize: 18,
                    ),
                  ),
                ),
                body: ListView(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 40,
                        child: ListView.builder(
                            itemCount: 3,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    PaymentController.to.selectIndex = index;
                                  },
                                  child: Obx(
                                    () => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 25,
                                              width: 25,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: PaymentController
                                                              .to.selectIndex >=
                                                          index
                                                      ? AppColors.green
                                                      : AppColors.grey),
                                              child: const Icon(
                                                Icons.check,
                                                color: AppColors.white,
                                                size: 18,
                                              ),
                                            ),
                                            index == 2
                                                ? const SizedBox()
                                                : SizedBox(
                                                    width: Get.width / 4,
                                                    child: Divider(
                                                      color: PaymentController
                                                                  .to
                                                                  .selectIndex >=
                                                              index
                                                          ? AppColors.green
                                                          : AppColors.grey,
                                                      thickness: 2,
                                                    ),
                                                  )
                                          ],
                                        ),
                                        CommonText(
                                            text: index == 0
                                                ? "Shipping"
                                                : index == 1
                                                    ? "Payment"
                                                    : "Order",
                                            style: mediumText(fontSize: 12))
                                      ],
                                    ),
                                  ));
                            }),
                      ),
                    ),
                    Obx(
                      () => PaymentController.to.selectIndex == 0
                          ? SizedBox(
                              height: Get.height * 0.85, child: buildAddress())
                          : PaymentController.to.selectIndex == 1
                              ? SizedBox(
                                  height: Get.height * 0.85,
                                  child: buildPayment(),
                                )
                              : SizedBox(
                                  height: Get.height * 0.85,
                                  child: buildOrderSuccess()),
                    )
                  ],
                )),
          );
        });
  }

  ListView buildOrderSuccess() {
    return ListView(
      children: [
        Container(
          height: 80,
          width: 80,
          margin: const EdgeInsets.symmetric(vertical: 30),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.green),
          child: const Icon(
            Icons.check,
            color: AppColors.white,
            size: 40,
          ),
        ),
        CommonText(
            text: "Your order has been successfully submitted!",
            style: mediumText(fontSize: 24)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20),
          child: CommonButton(
              text: "Done",
              onTap: () {
                Get.back();
              }),
        )
      ],
    );
  }

  Padding buildPayment() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          ListView.builder(
            itemCount: PaymentController.to.paymentGatewayDetails.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, int index) {
              return Obx(() => PaymentController.to.paymentGatewayDetails[index]
                              ['enabled'] ==
                          true &&
                      PaymentController.to.paymentGatewayDetails[index]['id'] !=
                          ""
                  ? PaymentMethodTile(
                      text:
                          "${PaymentController.to.paymentGatewayDetails[index]['id'].toString().capitalizeFirst}",
                      onTap: () {
                        if (PaymentController.to.paymentGatewayDetails[index]
                                ['id'] ==
                            "razorpay") {
                          PaymentController.to.onPressedPaymentMethod = index;
                          RazorPaymentService payment = RazorPaymentService();
                          payment.initPaymentGateway();
                          payment.getPayment(context);
                        } else {
                          print("kjhlkhkjhlkjhk");
                        }
                      },
                      index: index,
                    )
                  : SizedBox());
            },
          ),
          const SizedBox(
            height: 50,
          ),
          PaymentDetailsBox(),
        ],
      ),
    );
  }

  Padding buildAddress() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: PaymentController.to.addressKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            //Billing Address
            Row(
              children: [
                CommonText(
                    text: "Billing Address", style: mediumText(fontSize: 18)),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: CommonTextFormField(
                    hintText: "First Name",
                    controller: PaymentController.to.bFName,
                    validator: (data) {
                      if (data == null || data.isEmpty || data == "") {
                        return 'Please enter first name';
                      }
                      return null;
                    },
                  ),
                ),
                Flexible(
                  child: CommonTextFormField(
                    hintText: "Last Name",
                    controller: PaymentController.to.bLName,
                    validator: (data) {
                      if (data == null || data.isEmpty || data == "") {
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
              controller: PaymentController.to.bAddress1,
              validator: (data) {
                if (data == null || data.isEmpty || data == "") {
                  return 'Please enter address';
                }
                return null;
              },
            ),
            CommonTextFormField(
              hintText: "Address Line 2",
              controller: PaymentController.to.bAddress2,
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
                    controller: PaymentController.to.bCountry,
                    validator: (data) {
                      if (data == null || data.isEmpty || data == "") {
                        return 'Please enter country';
                      }
                      return null;
                    },
                  ),
                ),
                Flexible(
                  child: CommonTextFormField(
                    hintText: "State",
                    controller: PaymentController.to.bState,
                    validator: (data) {
                      if (data == null || data.isEmpty || data == "") {
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
                    controller: PaymentController.to.bCity,
                    validator: (data) {
                      if (data == null || data.isEmpty || data == "") {
                        return 'Please enter city';
                      }
                      return null;
                    },
                  ),
                ),
                Flexible(
                  child: CommonTextFormField(
                    hintText: "PostCode",
                    controller: PaymentController.to.bPostCode,
                    validator: (data) {
                      if (data == null || data.isEmpty || data == "") {
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
              controller: PaymentController.to.bEmail,
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
                controller: PaymentController.to.bPhone,
                initialCountryCode: "IN",
                fontFamily: "medium",
                onChanged: (data) {
                  // if (data.toString().length == 10) {
                  //   PaymentController.to.phoneNumberLength = 10;
                  // } else {
                  //   PaymentController.to.phoneNumberLength = 0;
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
                    value: PaymentController.to.billingAsSameShipping,
                    onChanged: (data) {
                      PaymentController.to.billingAsSameShipping = data;
                    })),
                CommonText(
                  text: "Same as billing",
                  style: mediumText(
                      fontSize: 14, color: AppColors.black.withOpacity(.6)),
                ),
              ],
            ),
            Row(
              children: [
                CommonText(
                    text: "Shipping Address", style: mediumText(fontSize: 18)),
              ],
            ),

            // Shipping Address
            Obx(() => Row(
                  children: [
                    Flexible(
                      child: CommonTextFormField(
                        hintText: "First Name",
                        controller:
                            PaymentController.to.billingAsSameShipping == true
                                ? PaymentController.to.bFName
                                : PaymentController.to.sFName,
                        validator: (data) {
                          if (data == null || data.isEmpty || data == "") {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Flexible(
                      child: CommonTextFormField(
                        hintText: "Last Name",
                        controller:
                            PaymentController.to.billingAsSameShipping == true
                                ? PaymentController.to.bLName
                                : PaymentController.to.sLName,
                        validator: (data) {
                          if (data == null || data.isEmpty || data == "") {
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
                controller: PaymentController.to.billingAsSameShipping == true
                    ? PaymentController.to.bAddress1
                    : PaymentController.to.sAddress1,
                validator: (data) {
                  if (data == null || data.isEmpty || data == "") {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
            ),
            Obx(
              () => CommonTextFormField(
                hintText: "Address Line 2",
                controller: PaymentController.to.billingAsSameShipping == true
                    ? PaymentController.to.bAddress2
                    : PaymentController.to.sAddress2,
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
                        controller:
                            PaymentController.to.billingAsSameShipping == true
                                ? PaymentController.to.bCountry
                                : PaymentController.to.sCountry,
                        validator: (data) {
                          if (data == null || data.isEmpty || data == "") {
                            return 'Please enter country';
                          }
                          return null;
                        },
                      ),
                    ),
                    Flexible(
                      child: CommonTextFormField(
                        hintText: "State",
                        controller:
                            PaymentController.to.billingAsSameShipping == true
                                ? PaymentController.to.bState
                                : PaymentController.to.sState,
                        validator: (data) {
                          if (data == null || data.isEmpty || data == "") {
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
                      controller:
                          PaymentController.to.billingAsSameShipping == true
                              ? PaymentController.to.bCity
                              : PaymentController.to.sCity,
                      validator: (data) {
                        if (data == null || data.isEmpty || data == "") {
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
                      controller:
                          PaymentController.to.billingAsSameShipping == true
                              ? PaymentController.to.bPostCode
                              : PaymentController.to.sPostCode,
                      validator: (data) {
                        if (data == null || data.isEmpty || data == "") {
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
                  controller: PaymentController.to.billingAsSameShipping == true
                      ? PaymentController.to.bPhone
                      : PaymentController.to.sPhone,
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
                  text: "Next",
                  onTap: () {
                    if (PaymentController.to.addressKey.currentState!
                        .validate()) {
                      PaymentController.to.selectIndex = 1;
                      PaymentController.to.getPaymentGateways();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
