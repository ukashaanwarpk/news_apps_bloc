import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_apps_bloc/bloc/top_headlines/news_bloc.dart';
import 'package:news_apps_bloc/bloc/top_headlines/news_event.dart';
import 'package:news_apps_bloc/bloc/top_headlines/news_state.dart';
import 'package:news_apps_bloc/config/colors/app_colors.dart';
import 'package:news_apps_bloc/config/routes/route_name.dart';
import 'package:news_apps_bloc/res/components/cached_network_image.dart';
import 'package:news_apps_bloc/utils/enums.dart';
import 'package:news_apps_bloc/utils/service_locator.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late NewsBloc newsBloc;

  final ScrollController _scrollController = ScrollController();

  String categoryName = 'general';
  List<String> categoriesList = [
    'general',
    'entertainment',
    'health',
    'sports',
    'business',
    'technology',
  ];

  @override
  void initState() {
    super.initState();

    newsBloc = NewsBloc(newsRepository: getIt());
    newsBloc.add(GetCategoryEvent(category: categoryName));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          newsBloc.state.hasMore) {
        newsBloc.add(GetMoreCategoryEvent(category: categoryName));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    newsBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Categories'), centerTitle: true),
      body: BlocProvider(
        create: (_) => newsBloc,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: ListView.builder(
                  itemCount: categoriesList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = categoriesList[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          categoryName = category;
                          debugPrint('The channel name is $category');
                        });

                        newsBloc.add(GetCategoryEvent(category: category));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color:
                              categoryName == category
                                  ? AppColors.primaryColor
                                  : AppColors.lightGreyColor,

                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            category[0].toUpperCase() + category.substring(1),
                            style: TextStyle(
                              color:
                                  categoryName == category
                                      ? AppColors.whiteColor
                                      : AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),

              BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  switch (state.apiResponseCategory.status) {
                    case Status.loading:
                      return const Center(child: CircularProgressIndicator());
                    case Status.error:
                      return Center(
                        child: Text(
                          state.apiResponseCategory.message.toString(),
                        ),
                      );
                    case Status.success:
                      if (state.apiResponseCategory.data == null) {
                        return const Center(child: Text('No data available'));
                      }
                      final topNews = state.apiResponseCategory.data!;
                      final articles = topNews.articles ?? [];

                      return Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: articles.length + 1,

                          itemBuilder: (context, index) {
                            if (index < articles.length) {
                              final article = articles[index];
                              final dateTime = DateFormat(
                                'MMMM d, y h:mma',
                              ).format(
                                DateTime.parse(article.publishedAt.toString()),
                              );
                              return GestureDetector(
                                onTap:
                                    () => Navigator.pushNamed(
                                      context,
                                      RouteName.detail,
                                      arguments: {
                                        'article': article,
                                        'index': index,
                                      },
                                    ),
                                child: Container(
                                  height: 165,
                                  margin: EdgeInsets.symmetric(vertical: 10),

                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.08,
                                        ),
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Hero(
                                        tag:
                                            'image$index${article.urlToImage.toString()}',
                                        child: TCachedNetwrokImage(
                                          imageUrl:
                                              article.urlToImage.toString(),
                                          height: 165,

                                          width: size.width * 0.30,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(7),
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: Text(
                                                article.author == null
                                                    ? 'Unknown'
                                                    : article.author.toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 80,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 10.0,
                                                  top: 10,
                                                ),
                                                child: Text(
                                                  article.title.toString(),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        AppColors
                                                            .primaryTextColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 8.0,
                                              ),
                                              child: Text(
                                                dateTime,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: AppColors.greyColor
                                                      .withValues(alpha: 0.70),

                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return state.hasMore
                                  ? Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                  : SizedBox();
                            }
                          },
                        ),
                      );
                    default:
                      return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
