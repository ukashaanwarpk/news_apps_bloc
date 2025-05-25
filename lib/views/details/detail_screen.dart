import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_apps_bloc/config/colors/app_colors.dart';
import 'package:news_apps_bloc/model/category_news_model.dart';
import 'package:news_apps_bloc/res/components/cached_network_image.dart';

class DetailScreen extends StatelessWidget {
  final Articles article;
  final int index;
  const DetailScreen({super.key, required this.article, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dateTime = DateFormat(
      'MMMM d, y h:mma',
    ).format(DateTime.parse(article.publishedAt.toString()));

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.blackColor.withValues(alpha: 0.70),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              color: AppColors.blackColor.withValues(alpha: 0.70),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: AppColors.blackColor.withValues(alpha: 0.70),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.blackColor.withValues(alpha: 0.70),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                article.title.toString(),

                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.primaryTextColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      article.author == null
                          ? 'Unknown'
                          : article.author.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    dateTime,
                    style: TextStyle(
                      color: AppColors.greyColor.withValues(alpha: 0.70),

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Hero(
              tag: 'image$index${article.urlToImage.toString()}',

              child: TCachedNetwrokImage(
                imageUrl: article.urlToImage.toString(),
                height: size.height * 0.30,
                width: double.infinity,
                radius: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                article.description.toString(),
                style: TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
