import 'dart:html' as html;

class PageService {
  Future refreshPage() async {
    html.window.location.reload();
  }
}
