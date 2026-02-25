enum NetworkTitles {
  error,
  exception,
  httpError,
  httpRequest,
  httpRequestCurl,
  httpResponse,
  blocEvent,
  blocTransition,
  blocCreate,
  blocClose,
  route,
}

extension WellKnownTitlesExt on NetworkTitles {
  String get title {
    switch (this) {
      case NetworkTitles.error:
        return 'ERROR';
      case NetworkTitles.exception:
        return 'EXCEPTION';
      case NetworkTitles.httpRequestCurl:
        return 'cURL';
      case NetworkTitles.httpError:
        return 'http-error';
      case NetworkTitles.httpRequest:
        return 'http-request';
      case NetworkTitles.httpResponse:
        return 'http-response';
      case NetworkTitles.blocEvent:
        return 'bloc-event';
      case NetworkTitles.blocTransition:
        return 'bloc-transition';
      case NetworkTitles.blocCreate:
        return 'bloc-create';
      case NetworkTitles.blocClose:
        return 'bloc-close';
      case NetworkTitles.route:
        return 'ROUTE';
    }
  }
}
