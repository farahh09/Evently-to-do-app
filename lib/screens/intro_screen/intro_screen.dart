import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatelessWidget {
  static const String routeName = 'IntroScreen';
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2FEFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2FEFF),
        centerTitle: true,
        title: Image.asset('assets/images/evently_logo.png'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 28,
          children: [
            Image.asset('assets/images/creative.png'),
            Text("Personalize Your Experience", style: GoogleFonts.inter(
              fontSize: 20, color: Color(0xFF5669FF), fontWeight: FontWeight.bold
            ),),
            Text("Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.", style: GoogleFonts.inter(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Language", style: GoogleFonts.inter(fontSize: 20, color: Color(0xFF5669FF), fontWeight: FontWeight.w500)),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: BoxBorder.all(
                      color: Color(0xFF5669FF),
                      width: 2
                    )
                  ),
                  child: Row(
                    spacing: 20,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: BoxBorder.all(
                                  color: Color(0xFF5669FF),
                                  width: 5
                              )
                          ),
                          child: Image.asset('assets/images/usa.png', width: 30, height: 30,)),
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Image.asset('assets/images/eg.png', width: 30, height: 30),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Theme", style: GoogleFonts.inter(fontSize: 20, color: Color(0xFF5669FF), fontWeight: FontWeight.w500)),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: BoxBorder.all(
                          color: Color(0xFF5669FF),
                          width: 2
                      )
                  ),
                  child: Row(
                    spacing: 20,
                    children: [
                      Container(
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFF5669FF),
                            border: BoxBorder.all(
                                color: Color(0xFF5669FF),
                                width: 2
                            )
                        ),
                        child: Image.asset('assets/images/sun.png', width: 30, height: 30,)),
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Image.asset('assets/images/moon.png', width: 30, height: 30),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5669FF),
                  padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  )
                ),
                child:  Text("Let’s Start", style: GoogleFonts.inter(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500) ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
