import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:equipohealth/health/model/dashboardinputmodel.dart';

class Initializer {
  static bool? openEye = true;
  static RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static String? userId = "";
  static DateTime? logTime;
  static TextEditingController? updateTodoController = TextEditingController();
  static bool? genderMale = true;
  static QuerySnapshot? userData;
  static DashboardInputModel dashboardInputModel = DashboardInputModel();

  static List<Map<String, String>> news = [
    {
      "title": "How self-care empowers women to thrive",
      "content":
          "Self-care is an essential part of everyone's mental health and overall well-being. But In today's fast-paced world, women often juggle multiple roles and responsibilities, which can lead to stress and burnout. Professionally women might be either equal to men or trying to keep up but personally, they still have a long way to go. So by prioritizing self-care, women can nurture their mental and emotional health, allowing them to thrive in all areas of their lives.",
      "image":
          "https://static.toiimg.com/thumb/msid-108340626,imgsize-658126,width-400,resizemode-4/108340626.jpg"
    },
    {
      "title": "Diet tips and foods to harden bones and make them stronger",
      "content":
          "Several essential nutrients work together to maintain strong and healthy and harder bones. While nutrients such as calcium and vitamin D are termed essential to build and maintain strong bones, other nutrients are equally important to maintaining bone health including protein, vitamin B12, magnesium, vitamin C, among others. Osteoporosis, a disease that weakens and thins bones is a major public health problem in Indian women that makes the bones fragile and prone to breaking.",
      "image":
          "https://static.toiimg.com/thumb/msid-108331377,imgsize-1373515,width-400,resizemode-4/108331377.jpg"
    },
    {
      "title": "Do you wear blue light filter glasses? You need to read this",
      "content":
          "You must know that your vision will improve with glasses, but only while you wear them. Addressing the underlying source of your eye problems is the only hope to see better without the need for glasses. Your current prescription will be the only basis on which your glasses adjust your vision. However,on our quest for finding the right eyewear, the salesperson at the optical shop often stresses more on buying the one with a blue light filter.",
      "image":
          "https://static.toiimg.com/thumb/msid-108329961,imgsize-1171228,width-400,resizemode-4/108329961.jpg"
    },
  ];

  static updateHour(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays >= 14) {
      final weeks = (difference.inDays / 7).ceil();
      return '$weeks weeks ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }
}
