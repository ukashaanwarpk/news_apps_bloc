import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_apps_bloc/bloc/top_headlines/news_bloc.dart';
import 'package:news_apps_bloc/bloc/top_headlines/news_event.dart';
import 'package:news_apps_bloc/bloc/top_headlines/news_state.dart';
import 'package:news_apps_bloc/config/colors/app_colors.dart';
import 'package:news_apps_bloc/res/components/cached_network_image.dart';
import 'package:news_apps_bloc/res/components/circular_icon.dart';
import 'package:news_apps_bloc/utils/enums.dart';
import 'package:news_apps_bloc/utils/service_locator.dart';
import '../../res/components/heading_text.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NewsBloc newsBloc;

  String channelName = 'bbc-news';
  String categoryName = 'general';

  List<String> channelList = [
    'bbc-news',
    'ary-news',
    'cnn',
    'nbc-news',
    'independent',
    'al-jazeera-english',
  ];

  @override
  void initState() {
    super.initState();
    newsBloc = NewsBloc(newsRepository: getIt());
    newsBloc.add(GetTopHeadlineEvent(channelName: channelName));
  }

  @override
  void dispose() {
    super.dispose();
    newsBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    debugPrint('The build');
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TCircularIcon(icon: Icons.menu),
        ),
        actions: [
          TCircularIcon(icon: Icons.search),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TCircularIcon(icon: Icons.notifications),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: ListView.builder(
                  itemCount: channelList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final channel = channelList[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          channelName = channel;
                          debugPrint('The channel name is $channelName');
                        });

                        // when channel changed we need to get new news

                        newsBloc.add(
                          GetTopHeadlineEvent(channelName: channelName),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color:
                              channelName == channel
                                  ? AppColors.primaryColor
                                  : AppColors.lightGreyColor,
                          gradient:
                              channelName == channel
                                  ? AppColors.gradientColor
                                  : null,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            channel,
                            style: TextStyle(
                              color:
                                  channelName == channel
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

              THeadingText(title: 'Top Headline', show: false),
              SizedBox(height: 20),

              BlocProvider(
                create: (_) => newsBloc,
                child: BlocBuilder<NewsBloc, NewsState>(
                  builder: (context, state) {
                    switch (state.apiResponseChannel.status) {
                      case Status.loading:
                        return const Center(child: CircularProgressIndicator());
                      case Status.error:
                        return Center(
                          child: Text(
                            state.apiResponseChannel.message.toString(),
                          ),
                        );
                      case Status.success:
                        if (state.apiResponseChannel.data == null) {
                          return const Center(child: Text('No data available'));
                        }
                        final topNews = state.apiResponseChannel.data!;
                        final articals = topNews.articles ?? [];

                        return SizedBox(
                          height: size.height * 0.45,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: articals.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final news = articals[index];
                              final dateTime = timeago.format(
                                DateTime.parse(news.publishedAt!),
                              );
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: TCachedNetwrokImage(
                                      radius: 20,
                                      height: size.height * 0.30,
                                      width: size.width * 0.90,

                                      imageUrl: news.urlToImage.toString(),
                                    ),
                                  ),

                                  Positioned(
                                    top: 10,
                                    right: 30,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: AppColors.greyColor.withValues(
                                          alpha: 0.55,
                                        ),

                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '${articals.length}/${index + 1}',
                                        style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    left: 30,
                                    top: 120,
                                    child: Row(
                                      children: [
                                        Text(
                                          news.source!.name.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          height: 6,
                                          width: 6,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          dateTime,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 90,
                                    left: 30,
                                    child: SizedBox(
                                      height: 100,
                                      width: size.width * 0.70,
                                      child: Text(
                                        news.title.toString(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      default:
                        return SizedBox();
                    }
                  },
                ),
              ),
              SizedBox(height: 20),

              THeadingText(title: 'Latest News'),

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
                      if (state.apiResponseChannel.data == null) {
                        return const Center(child: Text('No data available'));
                      }
                      final topNews = state.apiResponseCategory.data!;
                      final articals = topNews.articles ?? [];

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: articals.length,

                        itemBuilder: (context, index) {
                          final category = articals[index];
                          final dateTime = timeago.format(
                            DateTime.parse(category.publishedAt!),
                          );
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.lightGreyColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                TCachedNetwrokImage(
                                  imageUrl: category.urlToImage.toString(),
                                  height: 100,
                                  width: 100,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        category.source!.name.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),

                                      Text(
                                        category.title.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        dateTime,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
