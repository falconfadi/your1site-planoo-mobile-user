import 'dart:io';

const String headerLanguageKey =HttpHeaders.acceptLanguageHeader;
const headerAuth = HttpHeaders.authorizationHeader;
const headerAccept = HttpHeaders.acceptHeader;
const headerContentType = HttpHeaders.contentTypeHeader;

const kAccessToken = 'access_token';
const kAccessTokenExpirationDate = 'token_expiration';
const userID = 'user_id';

const String serverUrl = "https://planoo.net/";
const String baseUrl = "https://planoo.net/api/customer/v1/";

/// auth
const String registerUrl = "auth/register";
const String verifyUrl = "auth/verify";
const String resendCodeUrl = "auth/resendCode";
const String loginUrl = "auth/login";
const String forgetPasswordUrl = "auth/forgetPassword";
const String resetPasswordUrl = "auth/resetPassword";
const String changePasswordUrl = "auth/changePassword";
const String logoutUrl = "auth/logout";
const String refreshTokenUrl = "auth/refreshToken";
/// user
const String getCustomerUrl = "customer/get";
const String uploadProfileImageUrl = "customer/uploadProfileImage";
const String deleteProfileImageUrl = "customer/deleteProfileImage";
const String editCustomerUrl = "customer/update";
const String deleteCustomerUrl = "customer/delete";
/// notification
const String getNotificationsUrl = "notification/all";
const String viewNotificationUrl = "notification/view";
const String deleteNotificationUrl = "notification/delete";
const String clearNotificationsUrl = "notification/clear";
/// appointment
const String allAppointmentsUrl = "appointment/all";
const String acceptedAppointmentsUrl = "appointment/accepted";
const String getAppointmentDetailsUrl = "appointment/find";
const String checkActivityAppointmentUrl = "appointment/check";
const String createActivityAppointmentUrl = "appointment/create";
const String cancelActivityAppointmentUrl = "appointment/cancel";
/// activity
const String allActivitiesUrl = "activity/all";
const String activityDetailsUrl = "activity/find";
/// category
const String categoriesUrl = "${serverUrl}api/label/categories";
/// course
const String allCoursesUrl = "course/all";
const String courseDetailsUrl = "course/find";
const String cancelCourseUrl = "course/cancel";
const String attendCourseUrl = "course/attend";
/// event
const String allEventsUrl = "event/all";
const String eventDetailsUrl = "event/find";
const String cancelEventUrl = "event/cancel";
const String attendEventUrl = "event/attend";

/// home
const String getFeedsUrl = "home/feeds";
const String getFeaturedUrl = "home/featured";
/// reviews
const String getReviewsUrl = "review/all/";
const String addReviewUrl = "review/create/";
/// favorite
const String getFavoritesUrl = "favorite/all";
const String addFavoriteUrl = "favorite/create/";
const String deleteFavoriteUrl = "favorite/delete";
