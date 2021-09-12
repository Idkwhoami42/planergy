import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

import 'constraints.dart';
import 'controllers/main_controller.dart';
import 'login.dart';
import 'main.dart';
import 'widgets.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  MainController c = Get.put(MainController());
  final formkey = GlobalKey<FormState>();
  final client = SupabaseClient(sbemail, sbauth);
  bool emailexists = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/logo.svg',
                      color: Colors.white,
                    ),
                    BText(
                      t: 'SIGN UP.',
                      s: 32,
                      c: Colors.white,
                      w: FontWeight.bold,
                    ),
                    BText(
                      t: 'Hello there, signup to see stories from\naround the civilisation.',
                      s: 14,
                      c: Colors.white,
                      w: FontWeight.bold,
                    ),
                    const Spacer(),
                    BText(
                      t: 'Name:',
                      s: 18,
                      c: Color(0xff979797),
                      w: FontWeight.bold,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Enter Name'),
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.name,
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (String? value) {
                        c.username.value = value.toString();
                      },
                    ),
                    const Spacer(),
                    BText(
                      t: 'Email:',
                      s: 18,
                      c: Color(0xff979797),
                      w: FontWeight.bold,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Enter Email'),
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "Email is required";
                        }
                        if (!RegExp(
                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(val)) {
                          return 'Please enter a valid email address';
                        }
                        if (emailexists) {
                          emailexists = false;
                          return "That email is taken, try another";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (String? value) {
                        c.email.value = value.toString();
                      },
                    ),
                    const Spacer(),
                    BText(
                      t: 'Password:',
                      s: 18,
                      c: const Color(0xff979797),
                      w: FontWeight.bold,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Enter Password'),
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      obscureText: true,
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "Password is required";
                        }
                        if (val.length <= 7) {
                          return "Use 8 or more characters";
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        c.password.value = value.toString();
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      color: pcolor,
                      child: TextButton(
                        onPressed: () async {
                          formkey.currentState!.save();
                          if (!formkey.currentState!.validate()) {
                            return;
                          }
                          formkey.currentState!.save();

                          final res = await client.auth
                              .signUp(c.email.value, c.password.value);
                          // print(res.error!.message);
                          if (res.error == null) {
                            final res2 = await client.from('users').insert([
                              {
                                'userid': res.data?.user?.id,
                                'name': c.username.value,
                              }
                            ]).execute();
                            c.userid = res.data!.user!.id;
                            final res3 = await client
                                .from('users')
                                .select()
                                .match({'userid': c.userid}).execute();
                            c.userdata = res3.data;
                            c.cartitemslist = [];
                            c.totalmoney.value =
                                int.parse(c.userdata[0]['money'].toString());
                            Get.to(() => HomeScreen());
                          } else if (res.error!.message ==
                              'A user with this email address has already been registered') {
                            setState(() {
                              emailexists = true;
                            });
                          }
                        },
                        child:
                            BText(t: 'Create Account', s: 22, c: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BText(
                          t: "Already have an account?",
                          s: 14,
                          c: Color(0xff7A869A),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(Loginpage());
                          },
                          child: BText(
                            t: 'SignIn',
                            s: 14,
                            c: Color(0xff0041C4),
                          ),
                        )
                      ],
                    ),
                    const Spacer(flex: 3),
                    Center(
                      child: BText(
                        t: 'By creating an account, you accept\nCompany’s Terms of Service',
                        s: 12,
                        c: Color(0xff7A869A),
                        a: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
