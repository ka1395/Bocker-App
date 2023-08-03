abstract class AddPostStats {}

class Initstats extends AddPostStats {}

class PickeImageSuccessStats extends AddPostStats {}

class PickeImageErrorState extends AddPostStats {}

class RemoveAllImagesstats extends AddPostStats {}

class RemoveImagesstats extends AddPostStats {}

class RemoveImagesprogressstats extends AddPostStats {}

class CreatePostLoadingStats extends AddPostStats {}

class CreatePostSuccessStats extends AddPostStats {

}

class CreatePostErrorStats extends AddPostStats {
  final String error;
  CreatePostErrorStats(this.error);
}
