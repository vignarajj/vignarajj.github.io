// GetX controller for managing Medium feed data
import 'package:get/get.dart';
import 'package:portfolio/repo/medium_repo.dart';
import 'package:portfolio/shared/models/medium_post.dart';

class MediumController extends GetxController {
  final MediumRepository _repository = MediumRepository();
  final RxList<MediumPost> posts = <MediumPost>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isMarquee = true.obs; // Toggle between marquee and list
  final RxInt currentIndex = 0.obs;
  final RxDouble cardWidth = 250.0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // Fetch posts from Medium
  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      final fetchedPosts = await _repository.fetchMediumPosts(
        'vignarajj',
      ); // Replace with your username
      posts.assignAll(fetchedPosts);
    } catch (e) {
      // print("error fetch medium stories $e $trace");
      // Get.snackbar('Error', 'Failed to load Medium posts: $e');
      posts.addAll([
        MediumPost(
          title:
              "Retrieval-Augmented Generation (RAG): Why Just “Think” When You Can “Look Up” Too?",
          link:
              "https://medium.com/@vignarajj/retrieval-augmented-generation-rag-why-just-think-when-you-can-look-up-too-c433f421e04a",
        ),
        MediumPost(
          title:
              "Build a Smart AI Assistant That Understands Your Uploaded Files (FastAPI + OpenAI)",
          link:
              "https://medium.com/@vignarajj/build-a-smart-ai-assistant-that-understands-your-uploaded-files-fastapi-openai-1a383b971782",
        ),
        MediumPost(
          title:
              "Automate Like a Boss: Why n8n Is the Workflow Wingman You Didn’t Know You Needed",
          link:
              "https://medium.com/@vignarajj/automate-like-a-boss-why-n8n-is-the-workflow-wingman-you-didnt-know-you-needed-f7eb4e062ab4",
        ),
      ]);
    } finally {
      isLoading.value = false;
    }
  }

  // Toggle between marquee and list view
  void toggleView() => isMarquee.value = !isMarquee.value;
  void updateCurrentIndex(int index) => currentIndex.value = index;
  void updateCardWidth(double width) => cardWidth.value = width;
}
