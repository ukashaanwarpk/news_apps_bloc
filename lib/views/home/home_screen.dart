import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_apps_bloc/bloc/top_headlines/top_headline_bloc.dart';
import 'package:news_apps_bloc/bloc/top_headlines/top_headline_event.dart';
import 'package:news_apps_bloc/bloc/top_headlines/top_headline_state.dart';
import 'package:news_apps_bloc/config/colors/app_colors.dart';
import 'package:news_apps_bloc/res/components/cached_network_image.dart';
import 'package:news_apps_bloc/res/components/circular_icon.dart';
import 'package:news_apps_bloc/utils/enums.dart';
import 'package:news_apps_bloc/utils/service_locator.dart';
import '../../res/components/heading_text.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TopHeadlineBloc topHeadlineBloc;

  String channelName = 'bbc-news';

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
    topHeadlineBloc = TopHeadlineBloc(newsRepository: getIt());
    topHeadlineBloc.add(GetTopHeadlineEvent(channelName: channelName));
  }

  @override
  void dispose() {
    super.dispose();
    topHeadlineBloc.close();
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

                        topHeadlineBloc.add(
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

              THeadingText(title: 'Top Headline'),
              SizedBox(height: 20),

              BlocProvider(
                create: (_) => topHeadlineBloc,
                child: BlocBuilder<TopHeadlineBloc, TopHeadlineState>(
                  builder: (context, state) {
                    switch (state.apiResponse.status) {
                      case Status.loading:
                        return const Center(child: CircularProgressIndicator());
                      case Status.error:
                        return Center(
                          child: Text(state.apiResponse.message.toString()),
                        );
                      case Status.success:
                        if (state.apiResponse.data == null) {
                          return const Center(child: Text('No data available'));
                        }
                        final topNews = state.apiResponse.data!;
                        final articals =
                            topNews.articles!.map((e) => e).take(5).toList();
                        debugPrint('The articals length is ${articals.length}');

                        final List<String> imageUrls =
                            articals
                                .map((e) => e.urlToImage.toString())
                                .toList();

                        return SizedBox(
                          height: size.height * 0.45,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: articals.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final news = articals[state.sliderIndex];

                              final dateTime = timeago.format(
                                DateTime.parse(news.publishedAt!),
                              );
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.30,
                                        width: size.width * 0.90,
                                        child: carousel.CarouselSlider.builder(
                                          itemCount: imageUrls.length,
                                          itemBuilder:
                                              (
                                                context,
                                                index,
                                                realIndex,
                                              ) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                    ),
                                                child: TCachedNetwrokImage(
                                                  radius: 20,
                                                  height: double.infinity,
                                                  width: double.infinity,

                                                  imageUrl: imageUrls[index],
                                                ),
                                              ),
                                          options: carousel.CarouselOptions(
                                            initialPage: 0,
                                            onPageChanged: (index, reason) {
                                              context
                                                  .read<TopHeadlineBloc>()
                                                  .add(
                                                    SliderIndexEvent(
                                                      index: index,
                                                    ),
                                                  );
                                            },

                                            viewportFraction: 1,
                                            aspectRatio: 16 / 9,
                                            enableInfiniteScroll: true,
                                            reverse: false,
                                            autoPlay: true,
                                            autoPlayInterval: Duration(
                                              seconds: 3,
                                            ),
                                            autoPlayAnimationDuration: Duration(
                                              milliseconds: 800,
                                            ),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        bottom: 90,
                                        left: 30,
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
                                        bottom: 20,
                                        left: 30,
                                        child: SizedBox(
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
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                        imageUrls.asMap().entries.map((entry) {
                                          final isActive =
                                              entry.key == state.sliderIndex;
                                          return Container(
                                            width: isActive ? 30.0 : 8.0,
                                            height: isActive ? 8.0 : 8.0,
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 4.0,
                                            ),
                                            decoration: BoxDecoration(
                                              shape:
                                                  isActive
                                                      ? BoxShape.rectangle
                                                      : BoxShape.circle,
                                              borderRadius:
                                                  isActive
                                                      ? BorderRadius.circular(
                                                        20,
                                                      )
                                                      : null,
                                              color:
                                                  isActive
                                                      ? AppColors.primaryColor
                                                      : AppColors
                                                          .lightGreyColor,
                                            ),
                                          );
                                        }).toList(),
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
            ],
          ),
        ),
      ),
    );
  }
}
