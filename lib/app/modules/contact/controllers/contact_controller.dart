// GetX controller for managing the contact form with validation
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/network/api_services.dart';
import 'package:portfolio/shared/models/contact_model.dart';

class ContactController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final RxBool isSubmitting = false.obs;

  ApiServices apiServices = GetInstance().find<ApiServices>();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }

  // Validate and submit the form
  void submitForm() async {
    if (formKey.currentState!.validate()) {
      isSubmitting.value = true;
      // Simulate a network call (replace with actual API call if needed)
      await apiServices
          .sendContact(
            ContactModel(
              name: nameController.text,
              email: emailController.text,
              phone: phoneController.text,
              message: messageController.text,
            ),
          )
          .then(
            (res) {
              if (res.contains("success")) {
                Get.snackbar(
                  'Success',
                  'Your message has been sent!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              } else {
                Get.snackbar(
                  'Error',
                  res,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                );
              }
            },
            onError: (error) {
              Get.snackbar(
                'Error',
                'Something went wrong, Please try again',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            },
          );
      // Clear the form
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      messageController.clear();
      isSubmitting.value = false;
    }
  }

  // Validation functions
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number (at least 10 digits)';
    }
    return null;
  }

  String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Message is required';
    }
    if (value.length < 10) {
      return 'Message must be at least 10 characters';
    }
    return null;
  }
}
