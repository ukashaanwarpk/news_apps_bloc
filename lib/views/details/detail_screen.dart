import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_apps_bloc/config/colors/app_colors.dart';
import 'package:news_apps_bloc/model/category_news_model.dart';
import 'package:news_apps_bloc/res/components/cached_network_image.dart';
import 'package:news_apps_bloc/res/components/circular_icon.dart';

class DetailScreen extends StatelessWidget {
  final Articles article;
  final int index;
  const DetailScreen({super.key, required this.article, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dateTime = DateFormat(
      'dd MMM yyyy',
    ).format(DateTime.parse(article.publishedAt.toString()));

    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: 'image$index${article.urlToImage.toString()}',

            child: TCachedNetwrokImage(
              imageUrl: article.urlToImage.toString(),
              height: size.height * 0.60,
              width: double.infinity,
              radius: 0,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20),
              height: size.height * 0.50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.source!.name.toString(),
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    article.description.toString(),
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: TCircularIcon(
                    height: 45,
                    width: 45,
                    icon: Icons.arrow_back_ios_new_rounded,
                    bgColor: AppColors.blackColor.withValues(alpha: 0.30),
                    iconColor: Colors.white,
                  ),
                ),
                Spacer(),

                TCircularIcon(
                  height: 45,
                  width: 45,

                  icon: Icons.bookmark,
                  bgColor: AppColors.blackColor.withValues(alpha: 0.30),
                  iconColor: Colors.white,
                ),
                SizedBox(width: 10),
                TCircularIcon(
                  height: 45,
                  width: 45,
                  icon: Icons.more_horiz,
                  bgColor: AppColors.blackColor.withValues(alpha: 0.30),
                  iconColor: Colors.white,
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            top: size.height * 0.30,
            child: Container(
              padding: const EdgeInsets.all(5).copyWith(),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                article.source!.name.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: size.height * 0.36,
            child: Text(
              article.title.toString(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: size.height * 0.43,
            child: Text(
              dateTime,
              style: TextStyle(
                color: AppColors.whiteColor,

                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
