abstract class StringsRes {
  static const String appName = 'Safe Access';
  static const String version = 'v';
  static const String datadogSdkToken = 'pub1e3a65c5716bf31ee1d0cf072906f889';
  static const String datadogSdkEnv = 'Production';

  //Access Alert
  static const String accessAlerts = 'Access Alerts';
  static const String access = 'Access';
  static const String alerts = 'Alerts';
  static const String found = 'Found';
  static const String filterByClassification = 'Filter results';
  static const String clearAll = 'Clear All';
  static const String camera = 'Camera: ';
  static const String cameras = 'Cameras';
  static const String cameraAlertDetails = 'Camera Alert';
  static const String accessAlertDetails = 'Alert';
  static const String handleAlert = 'Handle Alert';
  static const String noAlerts = 'No alerts';
  static const String searchAlerts = 'Search Alerts';
  static const String status = 'Status';
  static const String notHandled = 'Not-Handled';
  static const String handled = 'Handled';
  static const String dateRange = 'Date Range';
  static const String dateRangeRequired = 'Date Range*';
  static const String dateRangeHint = 'dd-mm-yyyy - dd-mm-yyyy';
  static const String handle = 'Handle';
  static const String view = 'View';
  static const String activeCamera = 'Active Camera';
  static const String inactiveCamera = 'Inactive Camera';

  //Events
  static const String events = 'Events';
  static const String searchEvents = 'Search Events';

  //Workers
  static const String workers = 'Workers';
  static const String hardwareAlerts = 'Hardware Alerts';
  static const String hardware = 'Hardware';
  static const String project = 'Project *';
  static const String lengthIDPassportError =
      '*ID/Passport can be only 15 characters long';
  static const String lengthPassportError =
      '*Passport can be only 15 characters long';
  static const String lengthIDError =
      '*ID can be only 9 characters long';
  static const String projectTitle = 'Project';
  static const String activeProjects = 'Show only Active Projects';
  static const String showing = 'Showing ';
  static const String firstAppearance  = 'Show only first appearance';
  static const String outOf = ' out of ';
  static const String results = 'results';
  static const String selected = ' Selected';
  static const String viewMore = 'View more';
  static const String registrationDate = 'Registration date:';
  static const String registrationUser = 'Registration by:';
  static const String workerFoundByPhoto = 'The worker was found by photo';
  static const String approvedAccess = 'Approved for access:';
  static const String existsOnProject =
      'Worker already exists on this Project.';
  //Override ID/Passport
  static const String overrideIDPassport = 'Override ';
  static const String existsAnotherProject =
      'Worker already exists on another Project';
  static const String registerToProject = 'Register to Project';
  //With a different Id/passport number:
  static const String differentIDPassport =
      'With a different ';
  static const String differentIDPassportNumber =
      ' number:';
  static const String notFoundForThisWorker =
      'Not found for this worker, ';
  static const String workerFoundByPhotoCurrentProject = 'on the current project.';
  static const String workerFoundByPhotoAddToProject = 'on another project.';
  //Do you want to override Id / Passport?
  static const String wantOverrideID = 'Do you want to override ';
  //Do you want to override the ID/ Passport and assign the user to
  static const String wantOverrideIDOrProject = 'Do you want to override the ';
  static const String wantOverrideIDOrProjectAssign = ' and assign the user to ';

  static const String step1 = 'Step 1 / 2';
  static const String step2 = 'Step 2 / 2';

  static const String registeredSuccess = 'was registered successfully';
  static const String assignedTo = 'was assigned to';
  static const String nameIdUpdated = 'was updated successfully';
  static const String notSufficient =
      'Quality is not sufficient for face recognition';

  static const String warning = 'Warning!';
  static const String overrideWorkerIdentification =
      'You are about to override the main worker identification data, are you sure you want ot perform this operation?';
  static const String overrideData = 'Override Data';

  static const String selectProject = 'Select project';
  static const String enterIDPassport = 'Enter ID / Passport';
  static const String enterIDPassportRequired = 'Enter ID / Passport *';
  static const String passport = 'Passport';
  static const String iDAndPassport = 'ID / Passport';
  static const String idCard = 'ID Card';
  static const String id = 'ID';
  static const String passportIDCard = 'Passport / ID Card';
  static const String position = 'Position';
  static const String all = 'All';
  static const String classification = 'Classification';
  static const String employer = 'Employer';
  static const String lastEntrance = 'Last Entrance';
  static const String photoNotTaken = 'Photo is not taken!';
  static const String noResultsChangeParameters =
      'No results found.\nChange the parameters and try again';
  static const String next = 'Next';

  //Settings
  static const String settings = 'Settings';
  static const String language = 'Language';
  static const String english = 'English';
  static const String hebrew = 'Hebrew';
  static const String changeLanguage = 'Change Language to ';
  static const String youCanSwitchLanguage =
      'You can switch language again in settings';
  static const String changeLanguageButton = 'Change Language';
  static const String logOut = 'Log Out';
  static const String procLogOut = 'Proceed Log out?';
  static const String ifYouLogOut =
      'If you log out,  you will need to login via Azure SSO';

  static const String subTitleLogIn = 'Subtitle, small moto, etc.';

  static const String logIn = 'Login';

  static const String editProfile = 'Edit Profile';
  static const String newSearch = 'New Search';
  static const String download = 'Download';
  static const String editPhoto = 'Edit photo';
  static const String editWorker = 'Edit worker';
  static const String clickCapture = 'Click to capture photo';
  static const String captureSuccessful = 'Photo capture successful';
  static const String addPhoto = 'Add photo';

  static const String search = 'Search';
  static const String searchResults = 'Search results';
  static const String searchWorkers = 'Search workers';
  static const String registerWorker = 'Register Worker';
  static const String register = 'Register';
  static const String addWorkerPhoto = 'Add Worker Photo';
  static const String filter = 'Filter';
  static const String close = 'Close';
  static const String cancel = 'Cancel';
  static const String saveProfile = 'Save Profile';
  static const String update = 'Update';

  static const String fontFamily = 'Open Sans';

  static const String noResults = 'No results';
  static const String support = 'Support';

  //Errors
  static const String connectionError = 'No internet or bad connection!';

  //Azure data
  static const String redirectURLPrefix = 'msauth';
  static const String errorURLPrefix = 'callbackMobile';
  static const String loginAzureURL =
      'https://api.pangeasac.xyz/login?isMobile=true';

  //Hardware camera status
  static const String caIdle = 'Idle';

  static const String caActive = 'Active';
  static const String caActiveDesc = 'The camera is capturing & analyzing.';

  static const String caAborted = 'Aborted';
  static const String caAbortedDesc = 'The Camera was stopped by user request, This status code will be sent as a final Status Event, and the Camera will return to idle state.';

  static const String caAnalyzeTimeout = 'Analyze timeout';
  static const String caAnalyzeTimeoutDesc = 'The analysis pipeline reached timeout waiting for detected frames. If this happened during capture and the Camera is persistent, it will become attempting reconnect.';

  static const String caInputError = 'Input error';
  static const String caInputErrorDesc = 'Failed to read frames from the source. If this happened during capture and the Camera is persistent, it will become attempting reconnect.';

  static const String caAttemptingReconnect = 'Attempting reconnect';
  static const String caAttemptingReconnectDesc = 'The Camera previously failed during capture, and now the backend attempts to restart it. It will continue these attempts until stopped by user.';

  static const String caErrorStarting = 'Error starting';
  static const String caErrorStartingDesc = 'The Camera failed to start. It will not attempt to reconnect.';

  static const String caErrorStopping = 'Error stopping';
  static const String caErrorStoppingDesc = 'The Camera failed to stop.';

  static const String caNonResponsive = 'Non responsive';
  static const String caNonResponsiveDesc = 'The analysis pipeline failed due to non-responsiveness of other services, or could not be reached. If this happened during capture and the Camera is persistent, it will become attempting reconnect.';

  static const String caDisplay = 'Display';

  //Classification data
  static const String permittedActive = 'Permitted, Active';
  static const String unPermitted = 'Unpermitted';
  static const String inactive = 'Inactive';
  static const String unPermittedInactive = 'Unpermitted, Inactive';
  static const String blocked = 'Blocked';
  static const String unPermittedBlocked = 'Unpermitted, Blocked';
  static const String inactiveBlocked = 'Inactive, Blocked';
  static const String unPermittedInactiveBlocked = 'Unpermitted, Inactive, Blocked';
  static const String existsNotAssign = 'Exists, not assign to the project';
  static const String pendingPermission = 'Pending for permission';
  static const String exceptionPending = 'Exception pending for permission';
  static const String blockedRecently = 'Blocked, recently entered';
  static const String unidentified = 'Unidentified';

  static const String pathLanguages = 'assets/languages';

  //Info
  static const String newBadge = 'new';
  static const String noPermission = 'User is unpermitted to perform this action.';
  static const String timeOutError =
      'Poor connectivity or unstable network at the moment, please try again!';
  static const String apiError = 'Something went wrong on a request, try again later!';

  static const String isLoggedIn = 'Logged_In';
  static const String isLoggedOut = 'Logged_out';

  static const String allowed = 'Allowed';
  static const String notAllowed = 'NotAllowed';

  static const String platformName = 'Safe Access mobile ';

  static const String notValidNumber = 'The ID or passport is not a valid number!';
}
