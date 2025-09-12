import 'dart:ui';

import 'package:flutter/material.dart';

AppBar appbar() {
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: 100,
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(32),
        bottomRight: Radius.circular(32),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 18),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  top: 19,
                  right: 0,
                  bottom: 11,
                ),
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white.withOpacity(0.88),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 84,
                    height: 84,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, left: 0, right: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Safety Planner",
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: 6,
                              offset: Offset(1.2, 2),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Plan your safest route in one tap",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.87),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 18),
            ],
          ),
        ),
      ),
    ),
  );
}
