




/*class PhoneAuthScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixText: '+',
              ),
            ),
            SizedBox(height: 20),
            Obx(() => authController.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      authController.sendOTP(phoneController.text.trim());
                    },
                    child: Text('Send OTP'),
                  )),
            Obx(() => Text(authController.authStatus.value)),
          ],
        ),
      ),
    );
  }
}*/