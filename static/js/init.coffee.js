(function() {
  window.Ellumia = {
    init: {}
  };

  Ellumia.init['responsiveYouTube'] = function(root) {
    var iframe, wrapper, _i, _len, _ref, _results;

    if (root == null) {
      root = document.body;
    }
    _ref = $('iframe[src*="www.youtube.com"]:not([data-ellumia-responsive])', root);
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      iframe = _ref[_i];
      iframe = $(iframe);
      wrapper = $('<div class="video-wrap"/>').css({
        'padding-top': "" + ((iframe.height() / iframe.width()) * 100) + "%"
      }).insertBefore(iframe);
      _results.push(iframe.attr('data-ellumia-responsive', '1').appendTo(wrapper));
    }
    return _results;
  };

  Ellumia.init['animations'] = function(root) {
    if (root == null) {
      root = document.body;
    }
    return $(root).addClass('ready');
  };

  yepnope({
    load: ['http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js'],
    callback: function() {
      return $(window).load(function() {
        var cb, key, keys, _i, _len;

        keys = ((function() {
          var _ref, _results;

          _ref = Ellumia.init;
          _results = [];
          for (key in _ref) {
            cb = _ref[key];
            _results.push(key);
          }
          return _results;
        })()).sort();
        for (_i = 0, _len = keys.length; _i < _len; _i++) {
          key = keys[_i];
          Ellumia.init[key]();
        }
      });
    }
  });

  window.onYouTubeIframeAPIReady = function() {
    return Ellumia.VideoPlayer = new YT.Player('yt', {
      events: {
        onReady: function() {
          var shade;

          shade = $('#video #thumb');
          return shade.children('a').attr('href', '#').end().click(function() {
            shade.hide();
            Ellumia.VideoPlayer.playVideo();
            return false;
          });
        }
      }
    });
  };

  yepnope({
    load: ['https://www.youtube.com/iframe_api']
  });

}).call(this);
