import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_apps_bloc/bloc/top_headlines/top_headline_bloc.dart';
import 'package:news_apps_bloc/bloc/top_headlines/top_headline_event.dart';
import 'package:news_apps_bloc/bloc/top_headlines/top_headline_state.dart';
import 'package:news_apps_bloc/res/components/cached_network_image.dart';
import 'package:news_apps_bloc/res/components/circular_icon.dart';
import 'package:news_apps_bloc/utils/enums.dart';
import 'package:news_apps_bloc/utils/service_locator.dart';
import '../../res/components/heading_text.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TopHeadlineBloc topHeadlineBloc;
  String channelName = 'bbc-news';

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
                        final articals = topNews.articles ?? [];
                        return SizedBox(
                          height: size.height * 0.45,
                          child: ListView.builder(
                            shrinkWrap: true,

                            itemCount: articals.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final news = articals[index];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: TCachedNetwrokImage(
                                      height: size.height * 0.45,
                                      width: size.width * 0.90,
                                      radius: 20,
                                      imageUrl: news.urlToImage.toString(),
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
            ],
          ),
        ),
      ),
    );
  }
}
