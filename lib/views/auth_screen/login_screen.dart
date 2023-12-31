import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/auth_screen/signup_screen.dart';
import 'package:emart_app/views/cart_screen/cart_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import '../../consts/lists.dart';
import '../../widgets_common/applogo_notext_widget.dart';
import '../../widgets_common/custom_textfield.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AuthController());


    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogonotextWidget(),
            "Log in to $appname".text.fontFamily(bold).color(golden).size(15).make(),
            20.heightBox,

            Obx(()=>Column(
                children: [
                  customTextField (hint: emailHint, title: email,isPass:false, controller: controller.emailController),
                  customTextField (hint: passwordHint,title: password,isPass: true,controller: controller.passwordController),
                  Align(
                    alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child: forgetPass.text.make())),
                    5.heightBox,

                 controller.isloading.value ? const CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation(primaryColor),

                 ) : ourButton(color: primaryColor,title: login,textColor: whiteColor,onPress: () async{
                   controller.isloading(true);

                    await controller.loginMethod(context: context).then((value) {
                      if (value != null){
                        VxToast.show(context, msg: loggedin);
                        Get.offAll(() => const Home());
                      }else{
                        controller.isloading(false);
                      }
                    });

                  },)
                      .box
                      .width(context.screenWidth -50)
                      .make(),

                  5.heightBox,
                  createNewAccunt.text.color(fontGrey).make(),
                  10.heightBox,

                  ourButton(color: primaryColorLight3,title: signup,textColor: whiteColor,
                      onPress: (){
                        Get.to(()=> const SignupScreen());
                      })
                      .box
                      .width(context.screenWidth -50)
                      .make(),

                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                    socialIconList[index],
                                    width: 30,
                                ),
                              ),
                            )),
                  ),


                ],
              ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
            )


          ],
        ),
      ),
    ));
  }
}
