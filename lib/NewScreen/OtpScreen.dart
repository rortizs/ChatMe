// ignore_for_file: prefer_const_constructors_in_immutables, file_names

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key, required this.number, required this.countryCode})
      : super(key: key);
  final String number;
  final String countryCode;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Verify ${widget.countryCode} ${widget.number}",
          style: const TextStyle(color: Colors.blueAccent, fontSize: 17),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),
      // ignore: sized_box_for_whitespace
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "We have send an sms with a code to ",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    TextSpan(
                      text: " " + widget.countryCode + " " + widget.number,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: " Wrong number?",
                      style: TextStyle(color: Colors.cyan, fontSize: 15),
                    ),
                  ],
                )),
            const SizedBox(
              height: 5,
            ),
            OTPTextField(
              length: 5,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 30,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                // ignore: avoid_print
                print("Completed: " + pin);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Enter 6-digit code",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                )),
            const SizedBox(
              height: 30,
            ),
            bottomButton("Resend SMS", Icons.message),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              thickness: 1.5,
            ),
            const SizedBox(
              height: 15,
            ),
            bottomButton("Call Me", Icons.call),
          ],
        ),
      ),
    );
  }

  Widget bottomButton(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.green,
          size: 24,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.blueAccent,
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}
