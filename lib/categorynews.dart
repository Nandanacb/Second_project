import 'package:flutter/material.dart';
import 'package:news/news.dart';
import 'package:news/newsdetail.dart';
import 'package:news/sevice.dart';



// ignore: must_be_immutable
class SelectedCategoryNews extends StatefulWidget {
  String category;
  SelectedCategoryNews({super.key, required this.category});

  @override
  State<SelectedCategoryNews> createState() => _SelectedCategoryNewsState();
}

class _SelectedCategoryNewsState extends State<SelectedCategoryNews> {
  List<NewsModel> articles = [];
  bool isLoadin = true;
  getNews() async {
    CategoryNews news = CategoryNews();
    await news.getNews(widget.category);
    articles = news.dataStore;
    setState(() {
      isLoadin = false;
    });
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          widget.category,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoadin
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: ListView.builder(
                itemCount: articles.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetail(newsModel: article),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              article.urlToImage ?? 'https://www.washingtonpost.com/wp-apps/imrs.php?src=https://arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/7PBYH6DBMRALZB57QIE6LAODWI.jpg&w=1440',
                              height: 250,
                              width: 400,
                              fit: BoxFit.cover,

                                                 loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // Image has finished loading
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Text('Failed to load image'));
                },


                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            article.title!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Divider(thickness: 2),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}