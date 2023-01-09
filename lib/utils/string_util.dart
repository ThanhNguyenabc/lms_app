import 'package:flutter/material.dart';

const cookieKey = "cookie";
const isLoggedKey = "isLogged";
const userKey = "user";
const baseURL = "https://dev.ila.edu.vn/lms/lab";

const backgroundColor = Color(0xFFE8E4DE);

String getLessonCover(String lessonId) =>
    "$baseURL/content/lessons/$lessonId/cover.png";
