import 'package:centro/core/constants/end_point.dart';
import 'package:centro/core/data_source/remote_data_source.dart';
import 'package:centro/core/http/http_method.dart';
import 'package:centro/core/repository/core_repository.dart';
import 'package:centro/core/results/result.dart';
import 'package:centro/features/category/data/model/court/court_details_model.dart';
import 'package:centro/features/category/data/model/court/all_courts_model.dart';
import 'package:centro/features/category/data/model/category_model.dart';
import 'package:centro/features/category/data/model/course/all_courses_model.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';
import 'package:centro/features/category/data/model/event/all_events_model.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';
import 'package:centro/features/category/data/model/review_model.dart';
import 'package:centro/features/category/data/model/court/slots_model.dart';
import 'package:centro/features/category/data/usecase/court/court_details_usecase.dart';
import 'package:centro/features/category/data/usecase/court/all_courts_usecase.dart';
import 'package:centro/features/category/data/usecase/add_review_usecase.dart';
import 'package:centro/features/category/data/usecase/categories_usecase.dart';
import 'package:centro/features/category/data/usecase/court/check_court_usecase.dart';
import 'package:centro/features/category/data/usecase/course/all_courses_usecase.dart';
import 'package:centro/features/category/data/usecase/course/attend_course_usecase.dart';
import 'package:centro/features/category/data/usecase/course/course_details_usecase.dart';
import 'package:centro/features/category/data/usecase/court/book_court_usecase.dart';
import 'package:centro/features/category/data/usecase/event/all_events_usecase.dart';
import 'package:centro/features/category/data/usecase/event/attend_event_usecase.dart';
import 'package:centro/features/category/data/usecase/event/event_details_usecase.dart';
import 'package:centro/features/category/data/usecase/reviews_usecase.dart';
import 'package:centro/features/category/data/usecase/course/cancel_course_usecase.dart';
import 'package:centro/features/category/data/usecase/event/cancel_event_usecase.dart';

class CategoryRepository extends CoreRepository {

  Future<Result<CategoryModel>> getCategories({required CategoriesParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: false,
        url: categoriesUrl,
        method: HttpMethod.GET,
        responseStr: 'CategoryResponse',
        converter: (json) => CategoryResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<List<CourtDetailsModel>>> getAllCourts({required AllCourtsParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: "$allActivitiesUrl?page=${params.request.page}",
        method: HttpMethod.POST,
        data: params.toJson(),
        responseStr: 'AllCourtsResponse',
        converter: (json) => AllCourtsResponse.fromJson(json));
    return paginatedCall(result: result);
  }

  Future<Result<CourtDetailsModel>> getCourtDetails({required CourtDetailsParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: "$activityDetailsUrl?activity_id=${params.courtId}",
        method: HttpMethod.GET,
        responseStr: 'CourtDetailsResponse',
        converter: (json) => CourtDetailsResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<List<CourseDetailsModel>>> getAllCourses({required AllCoursesParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: "$allCoursesUrl?page=${params.request.page}",
        method: HttpMethod.POST,
        data: params.toJson(),
        responseStr: 'AllCoursesResponse',
        converter: (json) => AllCoursesResponse.fromJson(json));
    return paginatedCall(result: result);
  }

  Future<Result<CourseDetailsModel>> getCourseDetails({required CourseDetailsParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: "$courseDetailsUrl?course_id=${params.courseId}",
        method: HttpMethod.GET,
        responseStr: 'CourseDetailsResponse',
        converter: (json) => CourseDetailsResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<List<EventDetailsModel>>> getAllEvents({required AllEventsParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: "$allEventsUrl?page=${params.request.page}",
        method: HttpMethod.POST,
        data: params.toJson(),
        responseStr: 'AllEventsResponse',
        converter: (json) => AllEventsResponse.fromJson(json));
    return paginatedCall(result: result);
  }

  Future<Result<EventDetailsModel>> getEventDetails({required EventDetailsParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: "$eventDetailsUrl?event_id=${params.eventId}",
        method: HttpMethod.GET,
        responseStr: 'EventDetailsResponse',
        converter: (json) => EventDetailsResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<ReviewModel>> getReviews({required ReviewsParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: "$getReviewsUrl${params.ownerType}/${params.ownerId}",
        method: HttpMethod.GET,
        responseStr: 'ReviewResponse',
        converter: (json) => ReviewResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<bool>> addReview({required AddReviewParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: true,
      url: "$addReviewUrl${params.ownerType}/${params.ownerId}",
      data: params.toJson(),
      method: HttpMethod.POST,
    );
    return noModelCall(result: result);
  }

  Future<Result<SlotsModel>> checkCourt({required CheckCourtParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: checkActivityAppointmentUrl,
        data: params.toJson(),
        method: HttpMethod.POST,
        responseStr: 'SlotsResponse',
        converter: (json) => SlotsResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<bool>> bookCourt({required BookCourtParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: true,
      url: createActivityAppointmentUrl,
      data: params.toJson(),
      method: HttpMethod.POST,
    );
    return noModelCall(result: result);
  }

  Future<Result<bool>> attendCourse({required AttendCourseParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: true,
      url: "$attendCourseUrl?course_id=${params.courseId}",
      method: HttpMethod.POST,
    );
    return noModelCall(result: result);
  }

  Future<Result<bool>> cancelCourse({required CancelCourseParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: true,
      url: cancelCourseUrl,
      data: params.toJson(),
      method: HttpMethod.POST,
    );
    return noModelCall(result: result);
  }

  Future<Result<bool>> attendEvent({required AttendEventParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: true,
      url: "$attendEventUrl?event_id=${params.eventId}",
      method: HttpMethod.POST,
    );
    return noModelCall(result: result);
  }

  Future<Result<bool>> cancelEvent({required CancelEventParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: true,
      url: cancelEventUrl,
      data: params.toJson(),
      method: HttpMethod.POST,
    );
    return noModelCall(result: result);
  }
}
