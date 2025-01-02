import 'package:flutter/material.dart';
import 'package:news/category.dart';
import 'package:news/categorymodel.dart';
import 'package:news/categorynews.dart';
import 'package:news/news.dart';
import 'package:news/newsdetail.dart';
import 'package:news/sevice.dart';



class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({super.key});

  @override
  _NewsHomeScreenState createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  List<NewsModel> articles = [];
  List<CategoryModel> categories = [];
  bool isLoading = true;
  getNews() async {
    NewsApi newsApi = NewsApi();
    await newsApi.getNews();
    articles = newsApi.dataStore;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    categories = getCategories();
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 
            
            const Text(
              "News Today",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                
              ),
            ),
            centerTitle: true,
          automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  // for category selection
                  Container(
                    height: 55,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectedCategoryNews(
                                  category: category.categoryName!,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue),
                              child: Center(
                                child: Text(
                                  category.categoryName!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // for home screen news
                  ListView.builder(
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
                              builder: (context) =>
                                  NewsDetail(newsModel: article),
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
                ],
              ),
            ),
    );
  }
}